Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbULKDDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbULKDDR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 22:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbULKDDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 22:03:16 -0500
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.74]:3397 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261919AbULKDCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 22:02:55 -0500
Date: Fri, 10 Dec 2004 22:02:48 -0500
From: Jeff Sipek <jeffpc@optonline.net>
Subject: BUG at drivers/block/as-iosched.c:1853
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: James.Bottomley@HansenPartnership.com, mdharm-usb@one-eyed-alien.net,
       axboe@suse.de, piggin@cyberone.com.au
Message-id: <20041211030248.GA32420@optonline.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary="jI8keyz6grp/JLjh";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

First off....

jeffpc@jeff:~$ uname -a
Linux jeff 2.6.9-rc3 #2 Sun Oct 10 09:48:38 EDT 2004 i686 GNU/Linux

It is so old because I'm just lazy and 61 day uptime is a lot for the
box since I normally recompile the kernel every few days. :-) I'll do it
soon, and hopefully retry the same procedure.

Here's the story....

Today, I plugged in the USB flash drive I got my hands on..It's a 1GB PNY
Attache. I tried copying some files onto it, but soon afterwards, the
transfer froze and I got this in the log...

SCSI error : <9 0 0 0> return code = 0x70000
end_request: I/O error, dev sdb, sector 17896
Buffer I/O error on device sdb1, logical block 17864
lost page write due to I/O error on sdb1
SCSI error : <9 0 0 0> return code = 0x70000
end_request: I/O error, dev sdb, sector 17897
Buffer I/O error on device sdb1, logical block 17865
lost page write due to I/O error on sdb1
(more of the same, with different sector numbers)

So, since I couldn't umount it, I decided to just rip it out. (I'm
surprised that linux handles hot-unplug so badly...is it fixed in newer
versions?) The dmesg goes on...

usb 2-2.3: USB disconnect, address 15
SCSI error : <9 0 0 0> return code = 0x70000
end_request: I/O error, dev sdb, sector 17907
Buffer I/O error on device sdb1, logical block 17875
lost page write due to I/O error on sdb1
scsi: Device offlined - not ready after error recovery: host 9 channel 0
id 0 lun 0
sd 9:0:0:0: Illegal state transition cancel->offline
Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1688
 [<c0106fb5>] dump_stack+0x1e/0x22
 [<c0341454>] scsi_device_set_state+0xc2/0x110
 [<c033eefb>] scsi_eh_offline_sdevs+0x61/0x80
 [<c033f432>] scsi_unjam_host+0xd3/0x20a
 [<c033f647>] scsi_error_handler+0xde/0x17a
 [<c0104275>] kernel_thread_helper+0x5/0xb
SCSI error : <9 0 0 0> return code = 0x70000
end_request: I/O error, dev sdb, sector 17908
Buffer I/O error on device sdb1, logical block 17876
lost page write due to I/O error on sdb1
------------[ cut here ]------------
kernel BUG at drivers/block/as-iosched.c:1853!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: usb_storage visor usbserial nvidia eth1394 ohci1394
ieee1394 evdev tvaud
io msp3400 bttv video_buf i2c_algo_bit v4l2_common btcx_risc videodev
snd_bt87x uhci_hcd us
bcore dm_mod snd_emu10k1_synth snd_emu10k1 snd_ac97_codec snd_emux_synth
snd_seq_virmidi sn
d_rawmidi snd_seq_midi_emul snd_hwdep snd_util_mem tuner i2c_core
eepro100 mii
CPU:    0
EIP:    0060:[<c03185c6>]    Tainted: P   VLI
EFLAGS: 00010206   (2.6.9-rc3)
EIP is at as_exit+0x61/0x75
eax: c17b1cd8   ebx: c17b1ccc   ecx: efc66280   edx: 00000001
esi: efc6630c   edi: 00000286   ebp: e9d5de60   esp: e9d5de58
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_9 (pid: 32094, threadinfo=e9d5c000 task=d7992810)
Stack: c17b1d48 efc66280 e9d5de70 c030f6bf efc66280 efc6628c e9d5de88
c03115ce
       efc66280 d79932d0 eec6968c eec69668 e9d5dea4 c03432eb efc66280
d392bb9c
       eec69810 c052f990 c052f9c0 e9d5debc c030afca eec697ec 00000001
e9731e00
Call Trace:
 [<c0106f81>] show_stack+0x80/0x96
 [<c0107113>] show_registers+0x15a/0x1c2
 [<c0107307>] die+0xf3/0x187
 [<c0107890>] do_invalid_op+0x104/0x106
 [<c0106b89>] error_code+0x2d/0x38
 [<c030f6bf>] elevator_exit+0x20/0x22
 [<c03115ce>] blk_cleanup_queue+0x34/0x7f
 [<c03432eb>] scsi_device_dev_release+0xfd/0x116
 [<c030afca>] device_release+0x1b/0x5e
 [<c029db25>] kobject_cleanup+0x8d/0x8f
 [<c029de8e>] kref_put+0x36/0x90
 [<c029db54>] kobject_put+0x20/0x24
 [<c033bb64>] __scsi_iterate_devices+0x74/0x85
 [<c033e827>] scsi_eh_stu+0xbf/0x17a
 [<c033f210>] scsi_eh_ready_devs+0x28/0x88
 [<c033f432>] scsi_unjam_host+0xd3/0x20a
 [<c033f647>] scsi_error_handler+0xde/0x17a
 [<c0104275>] kernel_thread_helper+0x5/0xb
Code: 56 20 e2 ff 8b 83 cc 00 00 00 89 04 24 e8 2f ae ff ff 8b 43 30 89
04 24 e8 ab 8e e2 ff 89 5d 08 8b 5d fc 89 ec 5d e9 9d 8e e2 ff <0f> 0b
3d 07 2a 41 49 c0 eb c4 0f 0b 3c 07 2a 41 49 c0 eb b2 55

Jeff Sipek.

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBumNYwFP0+seVj/4RAlq8AJ94yyGMAP0hF2BRn6syQlAY2mC6pQCfZetf
BdWlx1Qh7yajzXBC7IPC+QE=
=7+UJ
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
