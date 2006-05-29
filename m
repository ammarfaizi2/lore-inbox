Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWE2BPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWE2BPF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 21:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWE2BPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 21:15:05 -0400
Received: from main.gmane.org ([80.91.229.2]:32233 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751087AbWE2BPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 21:15:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Salah Coronya <salahx@yahoo.com>
Subject: Re: [UDF] (bogus?) overlap of directories and files + UDF oops
Date: Sun, 28 May 2006 20:13:17 -0500
Message-ID: <e5dhrl$q77$1@sea.gmane.org>
References: <20060528161858.GA4705@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 71-14-84-46.dhcp.stls.mo.charter.com
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20060528161858.GA4705@clipper.ens.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas George wrote:
> Hi.
> 
> <I-tell-my-life>
> 
> I have a hard drive with an UDF filesystem, and something strange happened a
> few weeks ago: I had a directory foo, then I created a file bar at a
> completely different place; after that, foo was no longer a directory, it
> was a plain file, a hard-link to the newly created bar, except that the link
> count was wrong. Obviously there is a bug somewhere.
> 
> Since then, I spent part of my free-time to dissect my filesystem, and I
> found the following strange detail.
> 
> </I-tell-my-life>
> 
> 
> Some directories have eight allocated unrecorded (extent.length >> 30 == 1,
> according to ECMA 167, 4/14.14.1.1, page 4/46) sectors at the end. The
> strange thing is that some of these sectors also belong to others files or
> directories, as recorded sectors.
> 
> Is this situation normal?
> 
> (For the record, I am currently using a 2.6.14.1 kernel, but I did not see
> anything related in the ChangeLog of later releases.)
> 
> 
> 
> PS: I managed to build and run fsck.udf from OpenSolaris under GNU/Linux,
> but it seems to be limited to version 2 records, while Linux produces both
> version 2 and version 3 records, so it did not help. I intend to release the
> tools I have written to dissect my filesystem, but they still need a lot of
> work.
> 
> 
> Regards,
> 

While were on the subject of UDF bugs, I can also reliably produce an 
oops updating a UDF filesystem (at least on a DVD-RW/DVD+RW/DVD-RAM, 
using the packet writer)

cdrom: This disc doesn't have any tracks I recognize!
pktcdvd: writer pktcdvd0 mapped to hdc
pktcdvd: write speed 4155kB/s
pktcdvd: 4473408kB available on disc
UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp
2006/04/26 21:27 (1ed4)
udf: udf_read_inode(ino 6454) failed !bh
udf: udf_read_inode(ino 6454) failed !bh
udf: udf_read_inode(ino 854577) failed !bh
udf: udf_get_fileshortad() invalidparms
udf: udf_read_inode(ino 854578) failed !bh
udf: udf_read_inode(ino 854579) failed !bh
udf: udf_read_inode(ino 854581) failed !bh
udf: udf_read_inode(ino 854583) failed !bh
udf: udf_read_inode(ino 854584) failed !bh
udf: udf_read_inode(ino 854585) failed !bh
udf: udf_read_inode(ino 854586) failed !bh
udf: udf_read_inode(ino 854587) failed !bh
udf: udf_read_inode(ino 854589) failed !bh
udf: udf_get_fileshortad() invalidparms
udf: udf_read_inode(ino 854590) failed !bh
udf: udf_read_inode(ino 854591) failed !bh
udf: udf_read_inode(ino 854576) failed !bh
udf: udf_read_inode(ino 854576) failed !bh
udf: udf_read_inode(ino 854580) failed !bh
BUG: unable to handle kernel paging request at virtual address 0000194b
  printing eip:
c01e6e56
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: it87 hwmon_vid eeprom lm90 i2c_isa pcspkr rtc 
snd_opl3_lib
snd_cs4231_lib snd_hwdep snd_mpu401 analog ns558 parport_pc parport floppy
i2c_prosavage 8139too mii snd_via82xx gameport snd_ac97_codec snd_ac97_bus
snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi 
snd_seq_device snd
i2c_viapro via_agp agpgart pktcdvd dm_mirror dm_mod sata_mv ata_piix ahci
sata_qstor sata_vsc sata_uli sata_sis sata_sx4 sata_nv sata_via sata_svw
sata_sil sata_promise libata sbp2 ohci1394 ieee1394 sl811_hcd ohci_hcd 
uhci_hcd
usb_storage usbhid ehci_hcd usbcore
CPU:    0
EIP:    0060:[<c01e6e56>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc3-g30d55280 #1)
EIP is at udf_get_filelongad+0x3d/0x4f
eax: 00000000   ebx: d8e39ce8   ecx: 0000194b   edx: 00000038
esi: c7cc1300   edi: d8e39ce8   ebp: c7cc1338   esp: d8e39c48
ds: 007b   es: 007b   ss: 0068
Process rsync (pid: 10903, threadinfo=d8e39000 task=dde29050)
Stack: <0>0000194b c01e007e 0000194b 00001974 d8e39ce8 00000001 00000000 
00000000
        ffffffd2 c048b80e 00000202 c0119b4e d8e39ce0 d8e39cf8 c7cc1338 
d8e39cec
        c01dff40 c7cc1338 d8e39ce0 d8e39ce8 d8e39cec d8e39cf4 d8e39cf8 
00000001
Call Trace:
  <c01e007e> udf_current_aext+0x12f/0x189   <c0119b4e> 
release_console_sem+0x9e/0xa2
  <c01dff40> udf_next_aext+0x78/0x87   <c01e6123> 
udf_discard_prealloc+0x135/0x240
  <c01de26a> __udf_read_inode+0x55/0x1c0   <c01dc893> 
udf_clear_inode+0x1c/0x37
  <c0167fb8> clear_inode+0xa4/0xd2   <c0168cbb> 
generic_forget_inode+0x111/0x124
  <c01df972> udf_iget+0x83/0x8b   <c01e0f1e> udf_lookup+0x80/0xb4
  <c0150000> __cache_shrink+0x42/0x44   <c012c4e8> 
debug_mutex_add_waiter+0x7f/0x91
  <c0166d78> d_alloc+0x14/0x17f   <c015e3b6> real_lookup+0x4d/0xa9
  <c015e5fb> do_lookup+0x4a/0x7b   <c015ed74> __link_path_walk+0x748/0xb6d
  <c015f1d8> link_path_walk+0x3f/0xa7   <c015f5ba> 
do_path_lookup+0x1c9/0x22b
  <c015dfd2> getname+0x4a/0x51   <c015f853> __user_walk_fd+0x2a/0x3b
  <c015ab3b> vfs_lstat_fd+0x17/0x42   <c015ab75> vfs_lstat+0xf/0x13
  <c015b0ec> sys_lstat64+0x10/0x27   <c01025f3> sysenter_past_esp+0x54/0x75
Code: c0 09 d0 a8 01 74 0f 68 7c c1 38 c0 e8 d3 29 f3 ff 5a 31 c0 eb 25 
8b 03 85
c0 78 09 8d 50 10 3b 54 24 0c 76 04 31 c0 eb 12 31 c0 <83> 39 00 74 0b 
83 7c 24
14 00 74 02 89 13 89 c8 5b c3 8b 4c 24
EIP: [<c01e6e56>] udf_get_filelongad+0x3d/0x4f SS:ESP 0068:d8e39c48
  BUG: rsync/10903, lock held at task exit time!
  [c7610b3c] {inode_init_once}
.. held by:             rsync:10903 [dde29050, 117]
... acquired at:               real_lookup+0x15/0xa9

A more serious problems is udftools 
(http://sourceforge.net/projects/linux-udf/) seems unmaintained (for 2+ 
years, at least) and the developer is MIA. Somebody - I think a Ubuntu 
developer tried to contact him with no response. There is a udffsck in 
udftools, but it won't help you :)

