Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUBDXSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUBDXSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:18:21 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:4853 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263927AbUBDXSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:18:06 -0500
Date: Wed, 04 Feb 2004 15:17:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: linux-mm mailing list <linux-mm@kvack.org>, kmannth@us.ibm.com
Subject: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving X  (fwd)
Message-ID: <51080000.1075936626@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2019

           Summary: Bug from the mm subsystem involving X
    Kernel Version: kernel.org 2.6.2
            Status: NEW
          Severity: normal
             Owner: mm_numa-discontigmem@kernel-bugs.osdl.org
         Submitter: kmannth@us.ibm.com


Distribution:  Red Hat Enterprise Linux AS release 3 (Taroon Update 1)
Hardware Environment:  IBM x445 16-way 64gig of ram
Software Environment:  AS3.0 update 1 with stock 2.6.2
Problem Description:   The X server and the kenel do not play well.

Steps to reproduce:   Load AS3.0 (any flavor) and install a v2.6 kernel
start X on boot. 

So there have been alot of X issue with Red Hat and 2.6 kernels.  I managed to
get the system to panic and I decide it was time to open this bug.  I got this
on boot up. 

NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 296k freed
???????
Red Hat Enterprise Linux AS release 3 (Taroon Update 1)
Kernel 2.6.2 on an i686

elm3a80 login: Unable to handle kernel paging request at virtual address 0264d000
 printing eip:
c0147af4
*pde = 00000000
Oops: 0000 [#1]
CPU:    7
EIP:    0060:[<c0147af4>]    Not tainted
EFLAGS: 00013206
EIP is at remap_page_range+0x193/0x26c
eax: 0264d000   ebx: 000f5200   ecx: 00000001   edx: dad0fa80
esi: 001fe000   edi: d87c9ff0   ebp: f5200000   esp: d8835ee4
ds: 007b   es: 007b   ss: 0068
Process X (pid: 1285, threadinfo=d8834000 task=d9474ce0)
Stack: d961d580 001ff000 001ff000 40000000 f5002000 001fe000 d9578000 d961d580
       401ff000 d9576508 00000000 f5200000 d961d580 00000001 c0247055 d87d62c0
       401fe000 b5002000 00001000 00000027 d9388e80 00001000 c014a7fd d9388e80
Call Trace:
 [<c0247055>] mmap_mem+0x71/0xd4
 [<c014a7fd>] do_mmap_pgoff+0x362/0x70d
 [<c0156f65>] filp_open+0x67/0x69
 [<c0111c4d>] sys_mmap2+0x7a/0xaa
 [<c010aced>] sysenter_past_esp+0x52/0x71

Code: 8b 00 a9 00 08 00 00 74 10 89 d8 8b 54 24 4c c1 e8 14 09 ea
 <6>note: X[1285] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011da0a>] schedule+0x6d0/0x6d5
 [<c0122357>] __call_console_drivers+0x5b/0x5d
 [<c0122449>] call_console_drivers+0x69/0x11f
 [<c0223ffb>] rwsem_down_read_failed+0xa7/0x15a
 [<c012513f>] .text.lock.exit+0xeb/0x18c
 [<c010be11>] do_divide_error+0x0/0xfb
 [<c011a06f>] do_page_fault+0x1f8/0x561
 [<c0138b93>] find_get_page+0x3d/0x7a
 [<c0139db6>] filemap_nopage+0x287/0x378
 [<c013b166>] generic_file_aio_write+0x78/0xa2
 [<c0119e77>] do_page_fault+0x0/0x561
 [<c010b7a9>] error_code+0x2d/0x38
 [<c0147af4>] remap_page_range+0x193/0x26c
 [<c0247055>] mmap_mem+0x71/0xd4
 [<c014a7fd>] do_mmap_pgoff+0x362/0x70d
 [<c0156f65>] filp_open+0x67/0x69
 [<c0111c4d>] sys_mmap2+0x7a/0xaa
 [<c010aced>] sysenter_past_esp+0x52/0x71


Red Hat Enterprise Linux AS release 3 (Taroon Update 1)
Kernel 2.6.2 on an i686


My X version is XFree86-4.3.0-44.EL

Also if I do proc related thing on the pid (ps top ...) I hang the login session
(strace shows I don't return from a read on what I suppose is the X pid)

Any thoughts, comments or suggestions are wanted.


