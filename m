Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTLAXjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 18:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTLAXjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 18:39:47 -0500
Received: from users.linvision.com ([62.58.92.114]:56551 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264246AbTLAXjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 18:39:43 -0500
Date: Tue, 2 Dec 2003 00:39:41 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BUG 2.6.0-test11] debug messages, ALSA or USB related
Message-ID: <20031201233941.GA4017@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While playing sound on a USB audio device I got the following debug
messages:

Debug: sleeping function called from invalid context at kernel/sched.c:1751
in_atomic():1, irqs_disabled():1
Call Trace:
 [<c011dedb>] __might_sleep+0xab/0xd0
 [<c011cd6f>] wait_for_completion+0x1f/0xe0
 [<c01ec5fa>] get_device+0x1a/0x30
 [<e0b4b1a9>] hcd_unlink_urb+0x169/0x260 [usbcore]
 [<e0c04730>] snd_complete_urb+0x0/0xc0 [snd_usb_audio]
 [<e0b4af27>] hcd_submit_urb+0x107/0x180 [usbcore]
 [<e0b4ba42>] usb_unlink_urb+0x32/0x70 [usbcore]
 [<e0c04960>] deactivate_urbs+0xb0/0xc0 [snd_usb_audio]
 [<e0c04bd4>] snd_usb_pcm_trigger+0x54/0x60 [snd_usb_audio]
 [<e0bce0a7>] snd_pcm_do_stop+0x27/0x30 [snd_pcm]
 [<e0bcdde4>] snd_pcm_action_single+0x34/0x60 [snd_pcm]
 [<e0bcde77>] snd_pcm_action+0x67/0x70 [snd_pcm]
 [<e0bce150>] snd_pcm_stop+0x20/0x30 [snd_pcm]
 [<e0bd2cb4>] snd_pcm_update_hw_ptr+0x134/0x1d0 [snd_pcm]
 [<e0bd67c5>] snd_pcm_lib_write1+0x4c5/0x4e0 [snd_pcm]
 [<c015fa14>] pipe_wait+0x94/0xb0
 [<c011e2c0>] autoremove_wake_function+0x0/0x50
 [<c016d1a1>] update_atime+0xc1/0xd0
 [<e0bd686e>] snd_pcm_lib_write+0x8e/0xb0 [snd_pcm]
 [<e0bd6220>] snd_pcm_lib_write_transfer+0x0/0xe0 [snd_pcm]
 [<e0bd15bc>] snd_pcm_playback_ioctl1+0x40c/0x4a0 [snd_pcm]
 [<c01538c9>] vfs_read+0xb9/0x120
 [<c0165604>] sys_ioctl+0xf4/0x2b0
 [<c010a36f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011ca8c>] schedule+0x55c/0x570
 [<c010acdc>] common_interrupt+0x18/0x20
 [<c011cdd8>] wait_for_completion+0x88/0xe0
 [<c011caf0>] default_wake_function+0x0/0x20
 [<c011caf0>] default_wake_function+0x0/0x20
 [<e0b4b1a9>] hcd_unlink_urb+0x169/0x260 [usbcore]
 [<e0c04730>] snd_complete_urb+0x0/0xc0 [snd_usb_audio]
 [<e0b4af27>] hcd_submit_urb+0x107/0x180 [usbcore]
 [<e0b4ba42>] usb_unlink_urb+0x32/0x70 [usbcore]
 [<e0c04960>] deactivate_urbs+0xb0/0xc0 [snd_usb_audio]
 [<e0c04bd4>] snd_usb_pcm_trigger+0x54/0x60 [snd_usb_audio]
 [<e0bce0a7>] snd_pcm_do_stop+0x27/0x30 [snd_pcm]
 [<e0bcdde4>] snd_pcm_action_single+0x34/0x60 [snd_pcm]
 [<e0bcde77>] snd_pcm_action+0x67/0x70 [snd_pcm]
 [<e0bce150>] snd_pcm_stop+0x20/0x30 [snd_pcm]
 [<e0bd2cb4>] snd_pcm_update_hw_ptr+0x134/0x1d0 [snd_pcm]
 [<e0bd67c5>] snd_pcm_lib_write1+0x4c5/0x4e0 [snd_pcm]
 [<c015fa14>] pipe_wait+0x94/0xb0
 [<c011e2c0>] autoremove_wake_function+0x0/0x50
 [<c016d1a1>] update_atime+0xc1/0xd0
 [<e0bd686e>] snd_pcm_lib_write+0x8e/0xb0 [snd_pcm]
 [<e0bd6220>] snd_pcm_lib_write_transfer+0x0/0xe0 [snd_pcm]
 [<e0bd15bc>] snd_pcm_playback_ioctl1+0x40c/0x4a0 [snd_pcm]
 [<c01538c9>] vfs_read+0xb9/0x120
 [<c0165604>] sys_ioctl+0xf4/0x2b0
 [<c010a36f>] syscall_call+0x7/0xb

The USB device is:

T:  Bus=07 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0471 ProdID=0104 Rev= 1.00
S:  Manufacturer=Philips Electronics
S:  Product=Philips USB Digital Speaker System
C:* #Ifs= 3 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
I:  If#= 1 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=04(O) Atr=09(Isoc) MxPS=  56 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=04(O) Atr=09(Isoc) MxPS= 112 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=04(O) Atr=09(Isoc) MxPS= 112 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=04(O) Atr=09(Isoc) MxPS= 224 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=04(O) Atr=09(Isoc) MxPS= 168 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=04(O) Atr=09(Isoc) MxPS= 336 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=hid
E:  Ad=83(I) Atr=03(Int.) MxPS=   1 Ivl=10ms

At first glance it looks USB related, but it might as well be that the
ALSA code is the real culprit.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
