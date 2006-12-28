Return-Path: <linux-kernel-owner+w=401wt.eu-S964889AbWL1C2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWL1C2V (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 21:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWL1C2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 21:28:21 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:32837 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964889AbWL1C2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 21:28:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C5T9gZFg+eP/wW3fblV2fDSSb/uMJJOBvZ7rYNLQpPip+F5ixCdvNWb92eavTbJQSQacns9am+8Tb9fTl8+4ME/pwPhKTAQhgurj8Dz1i7TaaUokplMDBuPkJhUHmeUywX4RNM/WHcBCS2V9x5nLHj9pbFX3pYhGlDt1PYLsG8I=
Message-ID: <9e4733910612271828k6e017d1bg7dc62aa3b6cf0795@mail.gmail.com>
Date: Wed, 27 Dec 2006 21:28:19 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: kobject_add failed for card0, ALSA and USB
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something has stopped working between usb_audio and ALSA. When I boot
my USB audio won't work, but if I remove it and plug it in again it
works. I posted this on usb-dev and alsa-dev but everyone is gone.

The error occurs when the device is plugged in a again.

usb 2-1: new full speed USB device using uhci_hcd and address 3
usb 2-1: configuration #1 chosen from 1 choice
ALSA sound/usb/usbaudio.c:2739: 3:1:1: add audio endpoint 0x1
ALSA sound/usb/usbaudio.c:2739: 3:2:1: add audio endpoint 0x82
ALSA sound/usb/usbmixer.c:989: [2] FU [PCM Playback Switch] ch = 1, val = 0/1/1
ALSA sound/usb/usbmixer.c:989: [2] FU [PCM Playback Volume] ch = 6,
val = 0/32512/127
ALSA sound/usb/usbmixer.c:989: [5] FU [PCM Capture Switch] ch = 1, val = 0/1/1
ALSA sound/usb/usbmixer.c:989: [5] FU [PCM Capture Volume] ch = 2, val
= 0/6144/768
kobject_add failed for card0 with -EEXIST, don't try to register
things with the same name in the same directory.
 [<c01be26f>] kobject_add+0x10f/0x190
 [<c020b0c7>] device_add+0xb7/0x530
 [<c01bdf3f>] kobject_get+0xf/0x20
 [<c01be34b>] kobject_init+0x2b/0x40
 [<c020b5d8>] device_create+0x88/0xc0
 [<f8a6cc47>] snd_card_register+0x2e7/0x3c0 [snd]
 [<f8865c74>] usb_driver_claim_interface+0x84/0xb0 [usbcore]
 [<f8a875bc>] usb_audio_probe+0x5dc/0xa30 [snd_usb_audio]
 [<c01257e7>] try_to_del_timer_sync+0x47/0x50
 [<f8865b06>] usb_probe_interface+0x96/0xe0 [usbcore]
 [<c020d204>] really_probe+0x54/0x140
 [<c020d339>] driver_probe_device+0x49/0xc0
 [<c02af7e3>] klist_next+0x53/0xa0
 [<c020c614>] bus_for_each_drv+0x44/0x70
 [<c020d44a>] device_attach+0x7a/0x80
 [<c020d3b0>] __device_attach+0x0/0x10
 [<c020c556>] bus_attach_device+0x26/0x60
 [<c020b465>] device_add+0x455/0x530
 [<f8863e71>] usb_set_configuration+0x3f1/0x4d0 [usbcore]
 [<f886b867>] generic_probe+0x157/0x210 [usbcore]
 [<f8865753>] usb_probe_device+0x33/0x40 [usbcore]
 [<c020d204>] really_probe+0x54/0x140
 [<c020d339>] driver_probe_device+0x49/0xc0
 [<c02af7e3>] klist_next+0x53/0xa0
 [<c020c614>] bus_for_each_drv+0x44/0x70
 [<c020d44a>] device_attach+0x7a/0x80
 [<c020d3b0>] __device_attach+0x0/0x10
 [<c020c556>] bus_attach_device+0x26/0x60
 [<c020b465>] device_add+0x455/0x530
 [<f885f422>] __usb_new_device+0x92/0x120 [usbcore]
 [<f88607db>] hub_thread+0x74b/0xc10 [usbcore]
 [<c012f530>] autoremove_wake_function+0x0/0x50
 [<f8860090>] hub_thread+0x0/0xc10 [usbcore]
 [<c012f37a>] kthread+0xba/0xf0
 [<c012f2c0>] kthread+0x0/0xf0
 [<c0103cab>] kernel_thread_helper+0x7/0x1c
 =======================
input: Philips Electronics Philips PSC805 as /class/input/input6
input,hiddev96: USB HID v1.00 Device [Philips Electronics Philips
PSC805] on usb-0000:00:1d.1-1
ALSA sound/usb/usbaudio.c:1317: setting usb interface 1:1
ALSA sound/usb/usbaudio.c:1317: setting usb interface 1:1


-- 
Jon Smirl
jonsmirl@gmail.com
