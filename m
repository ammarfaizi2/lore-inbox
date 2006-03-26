Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWCZSEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWCZSEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 13:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWCZSEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 13:04:45 -0500
Received: from mail.charite.de ([160.45.207.131]:898 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1750967AbWCZSEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 13:04:44 -0500
Date: Sun, 26 Mar 2006 20:04:40 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at fs/direct-io.c:916!
Message-ID: <20060326180440.GA4776@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I wanted to run xfs_fsr on my laptop. I got:

------------[ cut here ]------------
kernel BUG at fs/direct-io.c:916!
invalid opcode: 0000 [#1]
PREEMPT 
last sysfs file: /devices/pci0000:00/0000:00:13.0/usb1/idProduct
Modules linked in: tda9887 tuner rtc rtc_dev rtc_ds1672 rtc_m48t86 rtc_pcf8563 rtc_rs5c372 rtc_sysfs rtc_x1205 rtc_core rtc_lib thermal fan button processor ac battery af_packet ide_scsi scsi_mod saa7134_dvb mt352 saa7134 compat_ioctl32 v4l2_common v4l1_compat ir_kbd_i2c ir_common videodev video_buf_dvb dvb_core video_buf nxt200x dvb_pll tda1004x i2c_core usbhid usbmouse tsdev pcmcia firmware_class yenta_socket psmouse evdev rt2500 rsrc_nonstatic pcmcia_core 8139too ehci_hcd ohci_hcd usbcore snd_atiixp_modem snd_atiixp snd_ac97_codec ide_cd ati_agp agpgart snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc cdrom unix
CPU:    0
EIP:    0060:[<c0182645>]    Not tainted VLI
EFLAGS: 00210246   (2.6.16-mm1 #1) 
EIP is at __blockdev_direct_IO+0xe75/0xed5
eax: 00000007   ebx: dd029254   ecx: 00000009   edx: 00000000
esi: 00000000   edi: 00000000   ebp: dd029200   esp: d52e1c98
ds: 007b   es: 007b   ss: 0068
Process xfs_fsr (pid: 22319, threadinfo=d52e1000 task=c9278580)
Stack: <0>00000001 006e78ea 174a9067 c014a4bd 00002c00 dd029254 00011200 ddf394c0 
       c7bc425c d52e1ef8 00000001 01bd4040 00000009 00000009 c14f601c 00003000 
       00000000 00000000 00000000 c14f2fa0 00000009 00200286 00000008 00000001 
Call Trace:
 <c014a4bd> __handle_mm_fault+0x77d/0x850   <c01f760a> xfs_vm_direct_IO+0xda/0x100
 <c01f7a40> xfs_get_blocks_direct+0x0/0x50   <c01f7170> xfs_end_io_direct+0x0/0x90
 <c0175729> touch_atime+0x59/0xc0   <c013cd27> generic_file_direct_IO+0x87/0x130
 <c013ce40> generic_file_direct_write+0x70/0x1b0   <c0175659> file_update_time+0x39/0xb0
 <c01ff906> xfs_write+0x4a6/0xd40   <c013c520> file_read_actor+0x0/0xe0
 <c01fb887> xfs_file_aio_write+0x87/0xb0   <c015b594> do_sync_write+0xc4/0x120
 <c012e5b0> autoremove_wake_function+0x0/0x50   <c0205826> sys_shmdt+0x6/0x1a0
 <c01fba15> xfs_file_ioctl+0x35/0x70   <c015baa3> vfs_write+0xa3/0x160
 <c015b4d0> do_sync_write+0x0/0x120   <c015c451> sys_write+0x41/0x70
 <c0102e93> sysenter_past_esp+0x54/0x75  
Code: ff ff 8b 84 24 80 00 00 00 bb f1 ff ff ff e8 73 21 fc ff 8b 75 2c 8b 55 34 e9 65 f8 ff ff e8 63 44 17 00 8d 76 00 e9 e4 f9 ff ff <0f> 0b 94 03 55 01 31 c0 8d 76 00 e9 dd fb ff ff e8 46 44 17 00 


# uname -a
Linux knarzkiste 2.6.16-mm1 #1 PREEMPT Fri Mar 24 19:01:24 CET 2006  i686 GNU/Linux

-- 
_________________________________________________

  Charité - Universitätsmedizin Berlin
_________________________________________________

  Ralf Hildebrandt
   i.A. Geschäftsbereich Informationsmanagement
   Campus Benjamin Franklin
   Hindenburgdamm 30 | Berlin
   Tel. +49 30 450 570155 | Fax +49 30 450 570962
   Ralf.Hildebrandt@charite.de
   http://www.charite.de
