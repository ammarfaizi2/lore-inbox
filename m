Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWG3MTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWG3MTb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 08:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWG3MTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 08:19:31 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:22428 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S932300AbWG3MTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 08:19:30 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc3
Date: Sun, 30 Jul 2006 16:05:12 GMT
Message-ID: <06AU4OP11@briare1.heliogroup.fr>
X-Mailer: Pliant 96
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
>
> Hubert Tonneau wrote:
> > Greg KH wrote:
> >> On Sun, Jul 30, 2006 at 12:21:13PM  0000, Hubert Tonneau wrote:
> >>> Off topic information:
> >>> With 2.6.17, none of my USB sound cards works; all of them work with 2.6.16
> >> That's not good at all.  Care to run 'git bisect' on the tree to find
> >> out what patch caused it?
> > 
> > Hard to do since I'm not a git user.
> 
> Then, could you "bisect" it just by -17-rcX patches applying and testing?

2.6.17-rc1 does not work.

I tried to get more details about what does not work, and found something
really strange:
basically, I'm using my own player, and with 2.6.17 it fails to open /dev/dsp
(error code returned by the kernel is -19 which is ENODEV)
Now, where the strangeness is that it seems to append rather unpredictibly.
I made a short program opening /dev/dsp and it worked.
Then in my player, I tried to open /dev/dsp not once, but twice, and the
second one works.

So, I tried to unplug and replug the USB audio card, and got more kernel
error messages:

<6>usb 1-1: USB disconnect, address 2
<3>hub 1-0:1.0: over-current change on port 1
<6>usb 1-1: new full speed USB device using uhci_hcd and address 3
<6>usb 1-1: configuration #1 chosen from 1 choice
<1>BUG: unable to handle kernel NULL pointer dereference at virtual address 0000022c
<1> printing eip:
<4>f886b914
<1>*pde = 00000000
<0>Oops: 0000 [#1]
<4>Modules linked in: snd_usb_audio snd_hwdep snd_usb_lib snd_rawmidi snd_seq_device usbmouse usbkbd uhci_hcd usbcore snd_pcm_oss snd_mixer_oss snd_ac97_codec snd_ac97_bus snd_pcm snd_page_alloc snd_timer snd soundcore
<0>CPU:    0
<4>EIP:    0060:[<f886b914>]    Not tainted VLI
<4>EFLAGS: 00010286   (2.6.17-rc1 #1) 
<0>EIP is at snd_pcm_oss_set_channels+0x24/0x50 [snd_pcm_oss]
<0>eax: 00000000   ebx: f7cb44e0   ecx: 00000000   edx: 00000002
<0>esi: b7231c20   edi: f7cb44e0   ebp: f08ca000   esp: f08cbf5c
<0>ds: 007b   es: 007b   ss: 0068
<0>Process pliant (pid: 1172, threadinfo=f08ca000 task=c19e2570)
<0>Stack: <0>fffffff2 f886cd5f f886f740 f6a8c200 f886c8f0 c015d216 f7634478 f6a8c200 
<0>       00000000 00000005 c015d36e d1baab00 003d09cc f6a8c200 00000005 fffffff7 
<0>       f08ca000 c015d50d b7231c20 00000001 00000005 b7231ba8 bfbff270 c0102df7 
<0>Call Trace:
<0> <f886cd5f> snd_pcm_oss_ioctl+0x46f/0x520 [snd_pcm_oss]   <f886c8f0> snd_pcm_oss_ioctl+0x0/0x520 [snd_pcm_oss]
<0> <c015d216> do_ioctl+0x56/0x70   <c015d36e> vfs_ioctl+0x5e/0x1c0
<0> <c015d50d> sys_ioctl+0x3d/0x70   <c0102df7> syscall_call+0x7/0xb
<0> <c0151030> bio_fs_destructor+0x0/0x10  
<0>Code: 00 5a c3 8d 74 26 00 53 85 d2 89 c3 b8 01 00 00 00 0f 44 d0 81 fa 80 00 00 00 77 2c b9 01 00 00 00 8b 04 8b 85 c0 74 18 8b 40 5c <39> 90 2c 02 00 00 74 0d 80 88 20 02 00 00 01 89 90 2c 02 00 00 
<4> <1>BUG: unable to handle kernel NULL pointer dereference at virtual address 0000022c
<1> printing eip:
<4>f886b914
<1>*pde = 00000000
<0>Oops: 0000 [#2]
<4>Modules linked in: snd_usb_audio snd_hwdep snd_usb_lib snd_rawmidi snd_seq_device usbmouse usbkbd uhci_hcd usbcore snd_pcm_oss snd_mixer_oss snd_ac97_codec snd_ac97_bus snd_pcm snd_page_alloc snd_timer snd soundcore
<0>CPU:    0
<4>EIP:    0060:[<f886b914>]    Not tainted VLI
<4>EFLAGS: 00010286   (2.6.17-rc1 #1) 
<0>EIP is at snd_pcm_oss_set_channels+0x24/0x50 [snd_pcm_oss]
<0>eax: 00000000   ebx: f7418e80   ecx: 00000000   edx: 00000002
<0>esi: b7231c20   edi: f7418e80   ebp: f08ca000   esp: f08cbf5c
<0>ds: 007b   es: 007b   ss: 0068
<0>Process pliant (pid: 1175, threadinfo=f08ca000 task=c19e2570)
<0>Stack: <0>fffffff2 f886cd5f f886f740 f6a8a9c0 f886c8f0 c015d216 f7634478 f6a8a9c0 
<0>       00000000 00000005 c015d36e 338ad700 003d09ce f6a8a9c0 00000005 fffffff7 
<0>       f08ca000 c015d50d b7231c20 00000001 00000005 b7231ba8 bf7ff270 c0102df7 
<0>Call Trace:
<0> <f886cd5f> snd_pcm_oss_ioctl+0x46f/0x520 [snd_pcm_oss]   <f886c8f0> snd_pcm_oss_ioctl+0x0/0x520 [snd_pcm_oss]
<0> <c015d216> do_ioctl+0x56/0x70   <c015d36e> vfs_ioctl+0x5e/0x1c0
<0> <c015d50d> sys_ioctl+0x3d/0x70   <c0102df7> syscall_call+0x7/0xb
<0> <c0151030> bio_fs_destructor+0x0/0x10  
<0>Code: 00 5a c3 8d 74 26 00 53 85 d2 89 c3 b8 01 00 00 00 0f 44 d0 81 fa 80 00 00 00 77 2c b9 01 00 00 00 8b 04 8b 85 c0 74 18 8b 40 5c <39> 90 2c 02 00 00 74 0d 80 88 20 02 00 00 01 89 90 2c 02 00 00 
<4> <6>usb 1-1: USB disconnect, address 3
