Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965266AbVIOT1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbVIOT1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965269AbVIOT1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:27:48 -0400
Received: from blackstar.xs4all.nl ([80.126.234.51]:47201 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id S965266AbVIOT1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:27:47 -0400
Subject: Re: 2.6.14-rc1 - kernel BUG at fs/ntfs/aops.c:403
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0509150954290.29921@hermes-1.csi.cam.ac.uk>
References: <1126769362.5358.3.camel@laptop.blackstar.nl>
	 <Pine.LNX.4.60.0509150954290.29921@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 21:24:56 +0200
Message-Id: <1126812296.4776.2.camel@laptop.blackstar.nl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14.WB1) 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the postmaster@blackstar.nl for more information
X-MailScanner: No virus found
X-MailScanner-From: bvermeul@blackstar.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-15 at 09:58 +0100, Anton Altaparmakov wrote:
> Ouch.  )-:  Could you do two things for me so I can figure out what is 
> going on?
> 
> 1) Apply this patch to fs/ntfs/aops.c:

done.

> 2) Enable ntfs debugging in the kernel configuration.

done.

> Recompile the ntfs module (or the kernel if ntfs is built in).
> 
> Then load the new module (if not built in).
> 
> Then enable debug output (as root do):
> 
> 	echo 1 > /proc/sys/fs/ntfs-debug

done.

> Now do the mount and send me the resulting dmesg output.  That should 
> hopefully enable me to fix it.

The logs are below. The mount resulted in a segmentation fault.

Sep 15 21:13:43 laptop kernel: [4295071.339000] NTFS volume version 3.1.
Sep 15 21:13:43 laptop kernel: [4295071.339000] NTFS-fs error (device
sda2): load_system_files(): Volume is dirty.  Mounting read-only.  Run
chkdsk and mount in Windows.
Sep 15 21:13:43 laptop kernel: [4295071.439000] NTFS-fs error (device
sda2): ntfs_readpage(): Eeek!  i_ino = 0x5, type = 0xa0, name_len = 0x4.
Sep 15 21:13:43 laptop kernel: [4295071.439000] ------------[ cut
here ]------------
Sep 15 21:13:43 laptop kernel: [4295071.439000] kernel BUG at
fs/ntfs/aops.c:407!
Sep 15 21:13:43 laptop kernel: [4295071.439000] invalid operand: 0000
[#1]
Sep 15 21:13:43 laptop kernel: [4295071.439000] PREEMPT 
Sep 15 21:13:43 laptop kernel: [4295071.439000] Modules linked in:
parport_pc lp parport nls_iso8859_1 yenta_socket rsrc_nonstatic uhci_hcd
floppy
Sep 15 21:13:43 laptop kernel: [4295071.439000] CPU:    0
Sep 15 21:13:43 laptop kernel: [4295071.439000] EIP:    0060:
[<c026a1ff>]    Not tainted VLI
Sep 15 21:13:43 laptop kernel: [4295071.439000] EFLAGS: 00010202
(2.6.14-rc1-g03055f0b) 
Sep 15 21:13:43 laptop kernel: [4295071.439000] EIP is at ntfs_readpage
+0x30f/0x320
Sep 15 21:13:43 laptop kernel: [4295071.439000] eax: 00000000   ebx:
c12c2220   ecx: 00000000   edx: 00000000
Sep 15 21:13:43 laptop kernel: [4295071.439000] esi: c076cfa0   edi:
c12c2220   ebp: d4b00220   esp: d8bc9bf4
Sep 15 21:13:43 laptop kernel: [4295071.439000] ds: 007b   es: 007b
ss: 0068
Sep 15 21:13:43 laptop kernel: [4295071.439000] Process mount (pid:
4398, threadinfo=d8bc8000 task=c649ea70)
Sep 15 21:13:43 laptop kernel: [4295071.439000] Stack: c070690b cdc28600
c076cfa0 00000005 000000a0 00000004 00000000 00000000 
Sep 15 21:13:43 laptop kernel: [4295071.439000]        c12c2220 c12c2220
c12c2220 c12c2220 00000000 c12c2220 d4b0035c c01476bc 
Sep 15 21:13:43 laptop kernel: [4295071.439000]        000000d0 c0269ef0
00000000 00000000 d4b0035c 00000000 00000000 c0273135 
Sep 15 21:13:43 laptop kernel: [4295071.439000] Call Trace:
Sep 15 21:13:43 laptop kernel: [4295071.439000]  [<c01476bc>]
read_cache_page+0xac/0x270
Sep 15 21:13:43 laptop kernel: [4295071.439000]  [<c0269ef0>]
ntfs_readpage+0x0/0x320
Sep 15 21:13:43 laptop kernel: [4295071.439000]  [<c0273135>]
ntfs_lookup_inode_by_name+0x5d5/0xeb0
Sep 15 21:13:43 laptop kernel: [4295071.439000]  [<c0276e0e>]
ntfs_read_locked_inode+0x51e/0xf70
Sep 15 21:13:43 laptop kernel: [4295071.439000]  [<c02729ed>]
__ntfs_debug+0x8d/0xc0
Sep 15 21:13:43 laptop kernel: [4295071.439000]  [<c028897b>]
check_windows_hibernation_status+0x7b/0x450
Sep 15 21:13:43 laptop kernel: [4295071.439000]  [<c0276330>] ntfs_iget
+0x60/0x80
Sep 15 21:13:43 laptop kernel: [4295071.439000]  [<c02761d0>]
ntfs_init_locked_inode+0x0/0x100
Sep 15 21:13:43 laptop kernel: [4295071.439000]  [<c028a614>]
load_system_files+0x814/0xd70
Sep 15 21:13:43 laptop kernel: [4295071.439000]  [<c028bfd1>]
ntfs_fill_super+0x2a1/0x860
Sep 15 21:13:43 laptop kernel: [4295071.439000]  [<c016d021>]
get_sb_bdev+0xb1/0x110
Sep 15 21:13:44 laptop kernel: [4295071.439000]  [<c0183409>]
alloc_vfsmnt+0x89/0xc0
Sep 15 21:13:44 laptop kernel: [4295071.439000]  [<c028c5c9>]
ntfs_get_sb+0x19/0x1e
Sep 15 21:13:44 laptop kernel: [4295071.439000]  [<c028bd30>]
ntfs_fill_super+0x0/0x860
Sep 15 21:13:44 laptop kernel: [4295071.439000]  [<c016d2ba>]
do_kern_mount+0x9a/0x170
Sep 15 21:13:44 laptop kernel: [4295071.439000]  [<c01845eb>]
do_new_mount+0x6b/0xc0
Sep 15 21:13:44 laptop kernel: [4295071.439000]  [<c0184d1f>] do_mount
+0x1cf/0x1e0
Sep 15 21:13:44 laptop kernel: [4295071.439000]  [<c0184a62>]
exact_copy_from_user+0x32/0x70
Sep 15 21:13:44 laptop kernel: [4295071.439000]  [<c0184af9>]
copy_mount_options+0x59/0xb0
Sep 15 21:13:44 laptop kernel: [4295071.439000]  [<c01850b9>] sys_mount
+0x79/0xb0
Sep 15 21:13:44 laptop kernel: [4295071.439000]  [<c010302b>]
sysenter_past_esp+0x54/0x75
Sep 15 21:13:44 laptop kernel: [4295071.439000] Code: ff 83 c1 80 75 0e
bf f3 ff ff ff 89 7c 24 1c e9 ce fe ff ff 0f 0b 8d 01 8b 67 75 c0 eb e8
0f 0b 98 01 8b 67 75 c0 e9 2a ff ff ff <0f> 0b 97 01 8b 67 75 c0 e9 12
ff ff ff 8d 74 26 00 55 bd d4 cf 

-- 
Bas Vermeulen <bvermeul@blackstar.nl>

