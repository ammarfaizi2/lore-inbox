Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbUF3XcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUF3XcC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 19:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUF3XcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 19:32:02 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:9664 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263301AbUF3Xbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 19:31:38 -0400
Subject: Re: [Lhms-devel] new memory hotremoval patch
From: Dave Hansen <haveblue@us.ibm.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20040630111719.EBACF70A92@sv1.valinux.co.jp>
References: <20040630111719.EBACF70A92@sv1.valinux.co.jp>
Content-Type: text/plain
Message-Id: <1088638272.5265.931.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 30 Jun 2004 16:31:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-30 at 04:17, IWAMOTO Toshihiro wrote:
> Hi,
> 
> this is an updated version of my memory hotremoval patch.
> I'll only include the main patch which contains page remapping code.
> The other two files, which haven't changed much from April, can be
> found at http://people.valinux.co.jp/~iwamoto/mh.html .

I tried your code and it oopsed pretty fast:

NUMA - single node, flat memory mode, but broken in several blocks
Rounding down maxpfn 950265 -> 949248
node 0 start 0
node 1 start 65536
node 2 start 131072
node 3 start 196608
node 4 start 262144
node 5 start 327680
node 6 start 393216
node 7 start 458752
physnode_map 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
Warning only 1920MB will be used.
Use a HIGHMEM enabled kernel.
1892MB LOWMEM available.
min_low_pfn = 1080, max_low_pfn = 484352, highstart_pfn = 0
Low memory ends at vaddr f6400000
node 0 will remap to vaddr f6400000 -
High memory starts at vaddr 80000000
found SMP MP-table at 0009e1d0
On node 0 totalpages: 65536
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61440 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:1
...
Node 2 not plugged
Node 5 not plugged
Zone 5 not plugged
Node 8 not plugged
Zone 8 not plugged
Node 2 not plugged
Node 5 not plugged
Node 8 not plugged
disable 11
Unable to handle kernel NULL pointer dereference at virtual address 000003a7
 printing eip:
801349b5
*pde = 00000000
Oops: 0002 [#1]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<801349b5>]    Not tainted
EFLAGS: 00010206   (2.6.7)
EIP is at mhtest_disable+0x49/0xa0
eax: 0000039f   ebx: 0000001f   ecx: 00000380   edx: 000000b0
esi: 00000000   edi: 80425ea0   ebp: 0000002c   esp: 8c60beec
ds: 007b   es: 007b   ss: 0068
Process sh (pid: 1842, threadinfo=8c60a000 task=8e549a70)
Stack: 0000000b 0000002c 802cad39 802cad38 00000001 80134dd4 0000000b 00000000
       8f9b2f64 8f9b2f88 0000000b 8c60bf28 802cacb0 0000002c 0000000b 61736964
       00656c62 000a3131 0000000a 8e4fee58 00000001 8c496f64 0000000a 00000000
Call Trace:
 [<80134dd4>] mhtest_write+0x150/0x17d
 [<8015daa4>] dupfd+0x2c/0x64
 [<8015dac6>] dupfd+0x4e/0x64
 [<801788a3>] proc_file_write+0x27/0x34
 [<8014ef0c>] vfs_write+0xa0/0xd0
 [<8014efb9>] sys_write+0x31/0x4c
 [<80103c87>] syscall_call+0x7/0xb

Code: c7 40 08 00 00 00 00 c7 40 04 00 00 00 00 89 c8 03 04 3a 83


$ addr2line -e vmlinux 801349b5
/home/dave/work/linux/2.6/2.6.7/linux-2.6.7-iwamoto/mm/page_alloc.c:2205


The script spit out some errors too:

# sh rotate.sh
2:
 rotate.sh: line 11: [: too many arguments

5: rotate.sh: line 11: [: too many arguments

8: rotate.sh: line 11: [: too many arguments




-- Dave

