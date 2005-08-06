Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVHFHWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVHFHWt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVHFHUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:20:35 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:39311 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262088AbVHFHSR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:18:17 -0400
Subject: NULL pointer dereference at vt_ioctl()
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 06 Aug 2005 09:18:44 +0200
Message-Id: <1123312725.10911.3.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with the latest 2.6.13-rc5-git kernel I see three weird oopses when I
boot up my machine. All of refer to vt_ioctl().

Regards

Marcel


Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c022d1f5
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: rfcomm hidp l2cap af_packet tun irda crc_ccitt binfmt_misc ipv6 xfrm_user ipcomp esp4 ah4 pcmcia firmware_class ide_cd cdrom yenta_socket rsrc_nonstatic pcmcia_core ohci_hcd 8250_pci 8250 serial_core st sd_mod aic7xxx scsi_transport_spi scsi_mod skge snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc tpm_atmel tpm_nsc tpm ehci_hcd evdev usbhid hci_usb bluetooth uhci_hcd usbcore intel_agp deflate zlib_deflate zlib_inflate twofish serpent aes_i586 blowfish des sha256 sha1 md5 crypto_null af_key nls_iso8859_1 nls_cp437 vfat fat nls_base mga drm agpgart w83627hf i2c_sensor i2c_isa i2c_i801 i2c_core sk98lin unix
CPU:    0
EIP:    0060:[<c022d1f5>]    Not tainted VLI
EFLAGS: 00010286   (2.6.13-rc5) 
EIP is at vt_ioctl+0x15/0x1948
eax: c022d1e0   ebx: f7468680   ecx: f7468680   edx: bf98f420
esi: 00000000   edi: f5437000   ebp: 00005401   esp: f55fdeb4
ds: 007b   es: 007b   ss: 0068
Process getty (pid: 7578, threadinfo=f55fc000 task=c223e020)
Stack: c02363e1 f7468680 ffffffed f7468680 f55fc000 c0227a46 f5437000 f7468680 
       f55fdee4 8802e020 f55fc000 00000002 f5437000 00000000 f7c41c04 c02277ba 
       f7e8a444 c0169493 f7e8a444 f7468680 c0160a51 f7468680 f7468680 fffffff8 
Call Trace:
 [<c02363e1>] con_open+0x22/0x8e
 [<c0227a46>] tty_open+0x28c/0x313
 [<c02277ba>] tty_open+0x0/0x313
 [<c0169493>] chrdev_open+0xb2/0x184
 [<c0160a51>] get_empty_filp+0x6a/0x107
 [<c02285c4>] tty_ioctl+0x95/0x4ad
 [<c01732b8>] do_ioctl+0x78/0x81
 [<c0173446>] vfs_ioctl+0x5a/0x1ef
 [<c017364a>] sys_ioctl+0x6f/0x7d
 [<c0102d23>] sysenter_past_esp+0x54/0x75
Code: 12 32 c0 e8 0e 12 0a 00 e9 1e ff ff ff 90 90 90 90 90 90 90 90 90 55 57 56 53 83 ec 58 8b 7c 24 6c 8b 6c 24 74 8b b7 9c 09 00 00 <0f> b7 1e 89 1c 24 e8 f8 62 00 00 85 c0 75 0f bb fd fd ff ff 89 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c022d1f5
*pde = 00000000
Oops: 0000 [#2]
SMP 
Modules linked in: rfcomm hidp l2cap af_packet tun irda crc_ccitt binfmt_misc ipv6 xfrm_user ipcomp esp4 ah4 pcmcia firmware_class ide_cd cdrom yenta_socket rsrc_nonstatic pcmcia_core ohci_hcd 8250_pci 8250 serial_core st sd_mod aic7xxx scsi_transport_spi scsi_mod skge snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc tpm_atmel tpm_nsc tpm ehci_hcd evdev usbhid hci_usb bluetooth uhci_hcd usbcore intel_agp deflate zlib_deflate zlib_inflate twofish serpent aes_i586 blowfish des sha256 sha1 md5 crypto_null af_key nls_iso8859_1 nls_cp437 vfat fat nls_base mga drm agpgart w83627hf i2c_sensor i2c_isa i2c_i801 i2c_core sk98lin unix
CPU:    0
EIP:    0060:[<c022d1f5>]    Not tainted VLI
EFLAGS: 00010286   (2.6.13-rc5) 
EIP is at vt_ioctl+0x15/0x1948
eax: c022d1e0   ebx: f7468680   ecx: f7468680   edx: bf9b0860
esi: 00000000   edi: f5437000   ebp: 00005401   esp: f55fdeb4
ds: 007b   es: 007b   ss: 0068
Process getty (pid: 7615, threadinfo=f55fc000 task=c223e020)
Stack: 00000001 00000001 f55fdee4 c0118c11 f7ec1a60 00000003 00000000 00000000 
       c031a57c c031a56c c031a574 00000282 f55fdf00 c0118ca8 c031a574 00000003 
       00000001 00000000 00000000 00000282 c02ce263 00000001 f7468680 fffffff8 
Call Trace:
 [<c0118c11>] __wake_up_common+0x43/0x65
 [<c0118ca8>] __wake_up_locked+0x2a/0x2c
 [<c02ce263>] __down+0xaf/0xf5
 [<c02285c4>] tty_ioctl+0x95/0x4ad
 [<c01732b8>] do_ioctl+0x78/0x81
 [<c0173446>] vfs_ioctl+0x5a/0x1ef
 [<c017364a>] sys_ioctl+0x6f/0x7d
 [<c0102d23>] sysenter_past_esp+0x54/0x75
Code: 12 32 c0 e8 0e 12 0a 00 e9 1e ff ff ff 90 90 90 90 90 90 90 90 90 55 57 56 53 83 ec 58 8b 7c 24 6c 8b 6c 24 74 8b b7 9c 09 00 00 <0f> b7 1e 89 1c 24 e8 f8 62 00 00 85 c0 75 0f bb fd fd ff ff 89 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c022d1f5
*pde = 00000000
Oops: 0000 [#3]
SMP 
Modules linked in: rfcomm hidp l2cap af_packet tun irda crc_ccitt binfmt_misc ipv6 xfrm_user ipcomp esp4 ah4 pcmcia firmware_class ide_cd cdrom yenta_socket rsrc_nonstatic pcmcia_core ohci_hcd 8250_pci 8250 serial_core st sd_mod aic7xxx scsi_transport_spi scsi_mod skge snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc tpm_atmel tpm_nsc tpm ehci_hcd evdev usbhid hci_usb bluetooth uhci_hcd usbcore intel_agp deflate zlib_deflate zlib_inflate twofish serpent aes_i586 blowfish des sha256 sha1 md5 crypto_null af_key nls_iso8859_1 nls_cp437 vfat fat nls_base mga drm agpgart w83627hf i2c_sensor i2c_isa i2c_i801 i2c_core sk98lin unix
CPU:    1
EIP:    0060:[<c022d1f5>]    Not tainted VLI
EFLAGS: 00010286   (2.6.13-rc5) 
EIP is at vt_ioctl+0x15/0x1948
eax: c022d1e0   ebx: f7468680   ecx: f7468680   edx: bfeed250
esi: 00000000   edi: f5437000   ebp: 00005401   esp: f55fdeb4
ds: 007b   es: 007b   ss: 0068
Process getty (pid: 7618, threadinfo=f55fc000 task=c223e020)
Stack: 00000001 00000001 f55fdee4 c0118c11 f7ec1a60 00000003 00000000 00000000 
       c031a57c c031a56c c031a574 00000282 f55fdf00 c0118ca8 c031a574 00000003 
       00000001 00000000 00000000 00000282 c02ce263 00000001 f7468680 fffffff8 
Call Trace:
 [<c0118c11>] __wake_up_common+0x43/0x65
 [<c0118ca8>] __wake_up_locked+0x2a/0x2c
 [<c02ce263>] __down+0xaf/0xf5
 [<c02285c4>] tty_ioctl+0x95/0x4ad
 [<c01732b8>] do_ioctl+0x78/0x81
 [<c0173446>] vfs_ioctl+0x5a/0x1ef
 [<c017364a>] sys_ioctl+0x6f/0x7d
 [<c0102d23>] sysenter_past_esp+0x54/0x75
Code: 12 32 c0 e8 0e 12 0a 00 e9 1e ff ff ff 90 90 90 90 90 90 90 90 90 55 57 56 53 83 ec 58 8b 7c 24 6c 8b 6c 24 74 8b b7 9c 09 00 00 <0f> b7 1e 89 1c 24 e8 f8 62 00 00 85 c0 75 0f bb fd fd ff ff 89 
 


