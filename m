Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWAIJwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWAIJwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 04:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWAIJwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 04:52:04 -0500
Received: from mail.charite.de ([160.45.207.131]:44417 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1751210AbWAIJwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 04:52:02 -0500
Date: Mon, 9 Jan 2006 10:51:59 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at drivers/ide/ide.c:1384!
Message-ID: <20060109095159.GE4535@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I invoked "hdparm -w /dev/hda"

# uname -a
Linux hummus.charite.de 2.6.15 #1 Tue Jan 3 09:30:04 CET 2006 i686 GNU/Linux

Before you flame away at me for using the nvidia kernel module: I will
reproduce this WITHOUT the nvidia kernel module. At least I'll try.

Thanks.

Jan  9 09:32:01 hummus kernel: end_request: I/O error, dev hda, sector 22604679
Jan  9 09:32:01 hummus kernel: ------------[ cut here ]------------
Jan  9 09:32:01 hummus kernel: kernel BUG at drivers/ide/ide.c:1384!
Jan  9 09:32:01 hummus kernel: invalid operand: 0000 [#1]
Jan  9 09:32:01 hummus kernel: Modules linked in: nvidia agpgart binfmt_misc lp thermal fan button processor ac battery pcmcia af_packet 8250_pnp rtc eth1394 ipw2200 ieee80211 ieee80211_crypt firmware_class ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core tg3 snd_intel8x0m 8250_pci 8250 serial_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc usbhid ehci_hcd hci_usb bluetooth uhci_hcd usbcore deflate zlib_deflate zlib_inflate twofish serpent aes blowfish des sha256 sha1 md5 crypto_null af_key dm_mod
Jan  9 09:32:01 hummus kernel: CPU:    0
Jan  9 09:32:01 hummus kernel: EIP:    0060:[<c02064a1>]    Tainted: P      VLI
Jan  9 09:32:01 hummus kernel: EFLAGS: 00210086   (2.6.15)
Jan  9 09:32:01 hummus kernel: EIP is at generic_ide_ioctl+0x4e6/0x5b1
Jan  9 09:32:01 hummus kernel: eax: c1b8e0c0   ebx: 00200206   ecx: 00000002   edx: 00000001
Jan  9 09:32:01 hummus kernel: esi: c0379614   edi: c020e1ee   ebp: f61f0080   esp: c8f99ec0
Jan  9 09:32:01 hummus kernel: ds: 007b   es: 007b   ss: 0068
Jan  9 09:32:01 hummus kernel: Process hdparm (pid: 16818, threadinfo=c8f99000 task=ce026070)
Jan  9 09:32:01 hummus kernel: Stack: c02c9ee0 00000abc 000000c8 ebb1164c c1709ec0 c0132f0d 00000001 c01bacee
Jan  9 09:32:01 hummus kernel: c8f99f3c dd5d4c24 f693d440 f693d484 ebb115ac 00000000 00000002 c02c9ee0
Jan  9 09:32:01 hummus kernel: 00000abc c1709ec0 00000abc 00000000 0000031c c18e3b24 f61f0080 c0211e11
Jan  9 09:32:01 hummus kernel: Call Trace:
Jan  9 09:32:01 hummus kernel: [<c0132f0d>] filemap_nopage+0x2b3/0x363
Jan  9 09:32:01 hummus kernel: [<c01bacee>] bit_cursor+0x0/0x5b4
Jan  9 09:32:01 hummus kernel: [<c0211e11>] idedisk_ioctl+0x26/0x2c
Jan  9 09:32:01 hummus kernel: [<c0211deb>] idedisk_ioctl+0x0/0x2c
Jan  9 09:32:01 hummus kernel: [<c019e051>] blkdev_driver_ioctl+0x42/0x44
Jan  9 09:32:01 hummus kernel: [<c019e15f>] blkdev_ioctl+0x10c/0x143
Jan  9 09:32:01 hummus kernel: [<c0152ef5>] block_ioctl+0x18/0x1d
Jan  9 09:32:01 hummus kernel: [<c0152edd>] block_ioctl+0x0/0x1d
Jan  9 09:32:01 hummus kernel: [<c015aef9>] do_ioctl+0x19/0x55
Jan  9 09:32:01 hummus kernel: [<c01137e8>] do_page_fault+0x24f/0x5b3
Jan  9 09:32:01 hummus kernel: [<c015b02f>] vfs_ioctl+0x50/0x19e
Jan  9 09:32:01 hummus kernel: [<c015b1b1>] sys_ioctl+0x34/0x53
Jan  9 09:32:01 hummus kernel: [<c0102bcb>] sysenter_past_esp+0x54/0x75
Jan  9 09:32:01 hummus kernel: Code: 00 00 20 0f 84 fd fc ff ff 81 48 0c 00 01 00 00 9c 5b fa ba 70 35 2a c0 89 f0 e8 21 0c 00 00 8b 46 6c 8b 40 08 8b 38 85 ff 74 08 <0f> 0b 68 05 f7 34 2a c0 c7 40 08 01 00 00 00 53 9d 89 f0 e8 f5

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
