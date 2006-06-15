Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030742AbWFOP6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030742AbWFOP6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 11:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030748AbWFOP6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 11:58:35 -0400
Received: from mail.tbdnetworks.com ([204.13.84.99]:32225 "EHLO
	mail.tbdnetworks.com") by vger.kernel.org with ESMTP
	id S1030742AbWFOP6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 11:58:35 -0400
Date: Thu, 15 Jun 2006 08:58:28 -0700
To: bfennema@falcon.csc.calpoly.edu
Cc: linux-kernel@vger.kernel.org
Subject: OOPS in UDF
Message-ID: <20060615155828.GA14257@defiant.tbdnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From: nkiesel@tbdnetworks.com (Norbert Kiesel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just got an OOPS while copying between two loopback-mounted UDF filesystems.
One or both of the UDF file systems are corrupted (some files not readable by
root), but kernel should not OOPS anyway.

I get the corrupted file systems reliably by rsync'ing big directories onto the
UDF filesystem (while trying to prepare a backup DVD).  I saw the OOPS only once
so far.  The system continued to work after the OOPS.

This happens on an old AMD K7 system running Debian unstable, but with self-
compiled vanilla kernel 2.6.16.19 (compiled with gcc version 4.0.4 20060507
(prerelease) (Debian 4.0.3-3)).

Best,
  Norbert

Jun 15 07:33:14 defiant kernel: [18278818.772000] UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 2006/06/15 06:31 (1e5c)
Jun 15 07:34:54 defiant kernel: [18278915.636000] udf: udf_read_inode(ino 1553042) failed !bh
Jun 15 07:34:54 defiant kernel: [18278915.636000] udf: udf_get_filelongad() invalidparms
Jun 15 07:38:57 defiant kernel: [18279161.240000] udf: udf_read_inode(ino 1183786) failed !bh
Jun 15 07:40:26 defiant kernel: [18279250.016000] udf: udf_read_inode(ino 1183786) failed !bh
Jun 15 07:40:30 defiant kernel: [18279253.996000] udf: udf_read_inode(ino 1183786) failed !bh
Jun 15 07:40:30 defiant kernel: [18279253.996000] udf: udf_get_filelongad() invalidparms
Jun 15 07:41:13 defiant kernel: [18279297.464000] udf: udf_read_inode(ino 1553048) failed !bh
Jun 15 07:41:13 defiant kernel: [18279297.476000] udf: udf_read_inode(ino 1553044) failed !bh
Jun 15 07:41:13 defiant kernel: [18279297.476000] Unable to handle kernel paging request at virtual address 010000fb
Jun 15 07:41:13 defiant kernel: [18279297.476000]  printing eip:
Jun 15 07:41:13 defiant kernel: [18279297.476000] f0af2b01
Jun 15 07:41:13 defiant kernel: [18279297.476000] *pde = 00000000
Jun 15 07:41:13 defiant kernel: [18279297.476000] Oops: 0000 [#1]
Jun 15 07:41:13 defiant kernel: [18279297.476000] Modules linked in: udf loop iptable_nat ip_nat ip_conntrack iptable_mangle iptable_filter ip_tables x_tables i2c_dev binfmt_misc pktcdvd capability commoncap thermal fan processor autofs4 ipv6 nfs twofish serpent aes blowfish sha256 crypto_null nfsd exportfs lockd sunrpc snd_pcm_oss snd_mixer_oss evdev uhci_hcd usbcore i2c_viapro via686a i2c_isa i2c_core parport_pc parport
Jun 15 07:41:13 defiant kernel: [18279297.476000] CPU:    0
Jun 15 07:41:13 defiant kernel: [18279297.476000] EIP:    0060:[<f0af2b01>]    Not tainted VLI
Jun 15 07:41:13 defiant kernel: [18279297.476000] EFLAGS: 00010293   (2.6.16.19 #82) 
Jun 15 07:41:13 defiant kernel: [18279297.476000] EIP is at udf_get_filelongad+0x30/0x47 [udf]
Jun 15 07:41:13 defiant kernel: [18279297.476000] eax: 010001d3   ebx: 010000fb   ecx: dcd0dd78   edx: 010001e3
Jun 15 07:41:13 defiant kernel: [18279297.476000] esi: 01408dd8   edi: 010000fb   ebp: 010000fb   esp: dcd0dce8
Jun 15 07:41:13 defiant kernel: [18279297.476000] ds: 007b   es: 007b   ss: 0068
Jun 15 07:41:13 defiant kernel: [18279297.476000] Process cp (pid: 9670, threadinfo=dcd0c000 task=e434aa50)
Jun 15 07:41:13 defiant kernel: [18279297.476000] Stack: <0>d7e00e2c dcd0dd78 f0ae95f1 00000001 dcd0dd68 d7e00e2c dcd0dd70 dcd0dd60 
Jun 15 07:41:13 defiant kernel: [18279297.476000]        f0ae96a1 dcd0dd60 dcd0dd74 dcd0dd70 00000001 dcd0dd78 ffffffff d7e00e2c 
Jun 15 07:41:13 defiant kernel: [18279297.476000]        e7f3ceb4 b84d1aac f0af222c dcd0dd60 dcd0dd74 dcd0dd70 00000001 01cd26a0 
Jun 15 07:41:13 defiant kernel: [18279297.476000] Call Trace:
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<f0ae95f1>] udf_current_aext+0xf7/0x132 [udf]
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<f0ae96a1>] udf_next_aext+0x75/0x85 [udf]
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<f0af222c>] udf_discard_prealloc+0x16a/0x286 [udf]
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<f0ae94e9>] udf_clear_inode+0x16/0x27 [udf]
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b0150f67>] clear_inode+0x80/0xad
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b0151489>] generic_drop_inode+0x101/0x114
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b01509b3>] iput+0x64/0x66
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<f0aeb01a>] udf_iget+0x84/0x8b [udf]
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<f0aef4ac>] udf_lookup+0x62/0x86 [udf]
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b0148bbd>] do_lookup+0xa3/0x137
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b0149304>] __link_path_walk+0x6b3/0xa8e
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b0149726>] link_path_walk+0x47/0xb9
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b014f8e1>] dput+0x22/0x116
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b01525b3>] mntput_no_expire+0x11/0x52
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b0149b4b>] do_path_lookup+0x181/0x19c
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b014a011>] __user_walk_fd+0x29/0x3f
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b0144cf3>] vfs_lstat_fd+0x12/0x39
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b014f8e1>] dput+0x22/0x116
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b01525b3>] mntput_no_expire+0x11/0x52
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b0145378>] sys_lstat64+0xf/0x23
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b013caa9>] sys_chmod+0x11/0x15
Jun 15 07:41:13 defiant kernel: [18279297.476000]  [<b0102387>] sysenter_past_esp+0x54/0x75
Jun 15 07:41:13 defiant kernel: [18279297.476000] Code: 0f 94 c2 85 c9 53 89 c3 0f 94 c0 08 c2 74 0f 68 19 46 af f0 e8 ba 0a 62 bf 5a 31 c0 eb 21 8b 01 85 c0 78 19 8d 50 10 39 f2 77 12 <83> 3b 00 89 d8 74 0b 83 7c 24 0c 00 74 06 89 11 eb 02 31 c0 5b 
