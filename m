Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbULARKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbULARKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 12:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbULARKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 12:10:08 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:26430 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261367AbULARJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 12:09:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=DKtjj3YKe7skvQTIUjla7FCZgjs1sIue5EHjZiDalyNo3WoF8yec2tjnK95xu7FL6TH9LV/UCqQVPi2+VCloiaf96CSM9obJrlDBK0+IQPV7nKYyNYPb7xSg/NJnhRsj3kfa0t8f99GIMz5xIzCqyUBkPkpRX/yPoxfAm4uDu5g=
Message-ID: <abc339820412010909325c08b6@mail.gmail.com>
Date: Wed, 1 Dec 2004 11:09:13 -0600
From: John Newman <cachehit@gmail.com>
Reply-To: John Newman <cachehit@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel crashes with 2.5/2.8
Cc: mhenderson@pointserve.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I've been experiencing (seemingly) random kernel Oops with various
versions of 2.5 and 2.8 on a Dell Poweredge 2650.  The machine is
configured with 2GB of ram, a 5GB swap file and two 2.8GHZ Xeons.   It
is a NIS/NFS server with an internal hardware raid 5 array  on the
Dell Perc card, using the aacraid driver.  The RAID5 array comes out
to about 500GB and is where all our user data is stored for NIS users.
  That data and the NIS information is accessed by a variety of older
and newer Linux and Sun boxes.

Here is the latest oops from my klog, which happened about a week ago:

Nov 24 21:34:10 ptscorp-nis01 kernel: Unable to handle kernel paging
request at virtual address 01000004
Nov 24 21:34:10 ptscorp-nis01 kernel:  printing eip:
Nov 24 21:34:10 ptscorp-nis01 kernel: 02144496
Nov 24 21:34:10 ptscorp-nis01 kernel: *pde = 00005001
Nov 24 21:34:10 ptscorp-nis01 kernel: Oops: 0002 [#1]
Nov 24 21:34:10 ptscorp-nis01 kernel: SMP
Nov 24 21:34:10 ptscorp-nis01 kernel: Modules linked in:
iptable_filter ip_tables nfsd exportfs lockd md5 ipv6 autofs4 sunrpc
tg3 microcode dm_mod ohci_hcd button battery asus_acpi ac ext3 jbd
aacraid sd_mod scsi_mod
Nov 24 21:34:10 ptscorp-nis01 kernel: CPU:    3
Nov 24 21:34:10 ptscorp-nis01 kernel: EIP:    0060:[<02144496>]    Not tainted
Nov 24 21:34:10 ptscorp-nis01 kernel: EFLAGS: 00010006   (2.6.8-1.521smp)
Nov 24 21:34:10 ptscorp-nis01 kernel: EIP is at free_block+0x3d/0xd9
Nov 24 21:34:10 ptscorp-nis01 kernel: eax: 01000000   ebx: 784cb000  
ecx: 784cbe38   edx: 413bd000
Nov 24 21:34:10 ptscorp-nis01 kernel: esi: 81fa0c80   edi: 0000001b  
ebp: 00000006   esp: 39e32de4
Nov 24 21:34:10 ptscorp-nis01 kernel: ds: 007b   es: 007b   ss: 0068
Nov 24 21:34:10 ptscorp-nis01 kernel: Process pdflush (pid: 57,
threadinfo=39e32000 task=39e1e230)
Nov 24 21:34:10 ptscorp-nis01 kernel: Stack: 0426b090 81f96800
0426b090 2d1c2148 0000001b 021445c9 0426b080 81fa0c80
Nov 24 21:34:10 ptscorp-nis01 kernel:        0000616d 0232cd88
0426b080 0426b090 2d1c2148 00000006 021449cc 39e32e44
Nov 24 21:34:10 ptscorp-nis01 kernel:        00000002 00000010
00000002 021c4776 03b80220 39e32e50 175c8d58 00000202
Nov 24 21:34:10 ptscorp-nis01 kernel: Call Trace:
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<021445c9>] cache_flusharray+0x97/0xf4
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<021449cc>] kmem_cache_free+0x2b/0x39
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<021c4776>]
radix_tree_delete+0x120/0x14a
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<0215f806>]
try_to_free_buffers+0xb9/0xcc
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<021c44d8>]
radix_tree_gang_lookup+0x39/0x52
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<8285e1bb>]
journal_try_to_free_buffers+0xc4/0xd1 [jbd]
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<0213bfa2>]
__remove_from_page_cache+0x12/0x51
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<0214651e>]
invalidate_complete_page+0x90/0xd0
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<021467e1>]
invalidate_mapping_pages+0x65/0xc9
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<0215d594>]
remove_inode_buffers+0x12/0xa9
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<021745aa>] prune_icache+0x141/0x28b
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<02142000>] pdflush+0x0/0x1e
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<02173d3c>] try_to_clip_inodes+0x90/0x94
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<02141f1a>] __pdflush+0x1be/0x2a4
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<0214201a>] pdflush+0x1a/0x1e
Nov 24 21:34:10 ptscorp-nis01 kernel:  [<0214132f>] wb_kupdate+0x0/0xee

I've gotten crashes like this with both 2.5 and 2.8.  I'm sorry I
don't have a copy of an oops from the 2.5 crashes.   The kermel I'm
using is the stock Fedora Core 2  2.6.8-1.521smp.   I've also compiled
my own kernels, various versions from 2.5 - 2.9, but NFS never works
quite right with my kernels.   That's even when I'm using the exact
config file that comes with the feodra kernel rpm's.  The NFs problems
when I compile my own kernel are inter-operability issues with our
Sun's and other, older, Linux boxes.  With the RPM kernels NFS works
great but the crashes are  really messings us up, and scaring me about
potential data loss!

Here is a list of loaded modules:

Module                  Size  Used by
nfsd                  169441  9
exportfs                9281  1 nfsd
lockd                  53513  2 nfsd
md5                     7745  1
ipv6                  233701  24
autofs4                20165  0
sunrpc                128805  19 nfsd,lockd
tg3                    79045  0
microcode              10209  0
dm_mod                 49477  0
ohci_hcd               22097  0
button                  8793  0
battery                11085  0
asus_acpi              13017  0
ac                      7373  0
ext3                   99497  2
jbd                    58457  1 ext3
aacraid                41073  3
sd_mod                 20801  4
scsi_mod              102025  2 aacraid,sd_mod

uname -a output:

Linux ptscorp-nis01 2.6.8-1.521smp #1 SMP Mon Aug 16 09:25:06 EDT 2004
i686 i686 i386 GNU/Linux

Does anyone have any idea what is causing the panics?    I appreciate
any feedback.  Is it possible this is a bug within some of the patches
that Fedora is using?   I was hopeful going from 2.5 to 2.8 would fix
the issue.  Since it didn't I haven't yet jumped to 2.9 but am
planning on doing it tonight.

-- 
John
