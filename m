Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWFLUGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWFLUGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWFLUGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:06:24 -0400
Received: from rtr.ca ([64.26.128.89]:14254 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932202AbWFLUGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:06:24 -0400
Message-ID: <448DC93E.9050200@rtr.ca>
Date: Mon, 12 Jun 2006 16:06:22 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>
Subject: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb, error
 -28
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

With 2.6.17-rc6-git2, I'm seeing this kernel message during start-up:

  pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb, error -28

The pl2303 serial port is part of a USB1.1 Hub/dock device,
plugged into a USB2 port on my notebook.

I get the same failure again when trying to use the port with Kermit.
This device was working fine here not long ago -- on the -rc5 kernels I think.

Unplugging the hub/dock does this:

kernel BUG at kernel/workqueue.c:110!
invalid opcode: 0000 [#1]
PREEMPT
Modules linked in: nfsd exportfs lockd nfs_acl sunrpc speedstep_centrino cpufreq_conservative cpufreq_stats cpufreq_userspace cpufreq_powersave freq_table cpufreq_ondemand thermal fan battery ac processor container video button rfcomm l2cap bluetooth cfq_iosched deflate zlib_deflate twofish serpent aes blowfish des sha256 sha1 crypto_null af_key sbp2 af_packet pl2303 usbserial ipw2200 pcmcia usblp usbhid snd_intel8x0 snd_ac97_codec snd_ac97_bus ieee80211 ieee80211_crypt yenta_socket sdhci mmc_core snd_pcm_oss snd_mixer_oss mousedev firmware_class rsrc_nonstatic pcmcia_core ohci1394 ieee1394 b44 mii snd_pcm snd_timer snd serio_raw pcspkr ehci_hcd uhci_hcd psmouse soundcore snd_page_alloc intel_agp agpgart usbcore sg sr_mod cdrom unix
CPU:    0
EIP:    0060:[queue_work+81/96]    Not tainted VLI
EFLAGS: 00210296   (2.6.17-rc6-git2 #1)
EIP is at queue_work+0x51/0x60
eax: f701113c   ebx: 00000000   ecx: b21b9f80   edx: f7011138
esi: f79bcc80   edi: f79bcc80   ebp: f78a7614   esp: f79e3e4c
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 1733, threadinfo=f79e2000 task=f7e86a90)
Stack: 00000000 f8b09d63 b01ca38f b02e136b f8972ad3 f78a7600 f8b17080 f8b170a4
       f78a7614 f89747f2 f78a767c f78a7614 b022240f f78a7614 f78a7614 f8989ae0
       b02226a6 f78a7614 b0221c87 f78a7614 f7be9058 00000001 b0220e35 f78a7600
Call Trace:
 <f8b09d63> usb_serial_disconnect+0x53/0xd0 [usbserial]  <b01ca38f> kref_put+0x2f/0x80
 <f8972ad3> usb_disable_interface+0x53/0x70 [usbcore]  <f89747f2> usb_unbind_interface+0x32/0x70 [usbcore]
 <b022240f> __device_release_driver+0x5f/0xc0  <b02226a6> device_release_driver+0x16/0x30
 <b0221c87> bus_remove_device+0x77/0x90  <b0220e35> device_del+0x35/0x70
 <f8973733> usb_disable_device+0xb3/0x100 [usbcore]  <f896d404> usb_disconnect+0x94/0x100 [usbcore]
 <f896d3f2> usb_disconnect+0x82/0x100 [usbcore]  <f896d3f2> usb_disconnect+0x82/0x100 [usbcore]
 <f896fc1e> hub_thread+0x3be/0xc75 [usbcore]  <b012efc0> autoremove_wake_function+0x0/0x50
 <b02b6d9f> preempt_schedule+0x4f/0x70  <b012eed6> kthread+0xd6/0xe0
 <f896f860> hub_thread+0x0/0xc75 [usbcore]  <b012ee00> kthread+0x0/0xe0
 <b0101005> kernel_thread_helper+0x5/0x10
Code: a8 08 75 1c 89 d8 5b c3 89 f6 8d 42 04 3b 42 04 75 19 8b 01 bb 01 00 00 00 e8 dc fa ff ff eb d3 e8 85 ae 18 00 89 d8 5b 89 f6 c3 <0f> 0b 6e 00 d1 de 2c b0 eb dd 90 8d 74 26 00 89 c2 a1 d4 d1 38
EIP: [queue_work+81/96] queue_work+0x51/0x60 SS:ESP 0068:f79e3e4c
 <6>note: khubd[1733] exited with preempt_count 1

???
