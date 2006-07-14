Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWGNJyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWGNJyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWGNJyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:54:46 -0400
Received: from server.mrvanes.com ([81.17.40.76]:42391 "EHLO mail.mrvanes.com")
	by vger.kernel.org with ESMTP id S1161014AbWGNJyp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:54:45 -0400
From: Martin van Es <martin@mrvanes.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.17.1 bug/oops in snd_usb_audio subsystem
Date: Fri, 14 Jul 2006 11:54:36 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607141154.36939.martin@mrvanes.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I already sent this mail to perex@suse.cz a couple of days ago since I thought 
that was the closest match in the MAINTAINERS list for this oops.
Since I didn't receive any reply I am not sure if the information in this mail 
is known to the developing community so I'll send a one time copy to the 
list. Please forgive me for not being a member of the list, I just happen to 
follow (stable) kernel development and stumbled upon this oops...

If there's anything I forgot, or should test/send to this list or person, 
please CC me on the reply.

Regards,
Martin van Es

-- original message --

Device:
The mentioned usb SOUND device is part of a philips webcam, dmesg output:
pwc: Philips PCVC675K (Vesta) USB webcam detected.

and registers as /dev/dsp1

I was able to reproduce the bug every time I start up ffmpeg (using /dev/dsp1) 
in 2.6.17.1, but for 1 time. I tried the same with 2.6.16 (only) once which 
worked fine.

Maybe helpful:
I deselected support for old ALSA API in 2.6.17.1

I didn't find a reference to the snd_usb_audio subsystem in recent 2.6.17 
releases (> .1) changelog so didn't try to compile a new version of the 
2.6.17.x kernel.

Grtz.
Martin van Es

dmesg output:

BUG: unable to handle kernel NULL pointer dereference at virtual address 
000001b8
 printing eip:
deae2514
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: snd_usb_audio pwc snd_usb_lib videodev v4l2_common 
snd_rawmidi snd_hwdep capability commoncap kqemu ipw2200
CPU:    0
EIP:    0060:[<deae2514>]    Tainted: P      VLI
EFLAGS: 00210202   (2.6.17.1 #5)
EIP is at snd_usb_pcm_open+0x34/0x4d0 [snd_usb_audio]
eax: db67e780   ebx: 00000000   ecx: 0000000e   edx: 000001a8
esi: deaf0d20   edi: c5be1e50   ebp: c56379c0   esp: c5be1d9c
ds: 007b   es: 007b   ss: 0068
Process ffmpeg (pid: 19504, threadinfo=c5be0000 task=c678aa70)
Stack: 00000020 c5be1dd8 00000000 d1d49000 00000010 c56379c0 c030f7f4 d1d49000
       00000000 00000010 d1d49000 000001a8 00000011 0000000b ffffffff cfcdf600
       00000000 0000000d c5be1e50 c56379c0 c030fb17 db67e780 00000001 c61a4c80
Call Trace:
 <c030f7f4> snd_pcm_hw_constraints_init+0x704/0x790  <c030fb17> 
snd_pcm_open_substream+0x57/0xb0
 <c031df41> snd_pcm_oss_open+0x221/0x4a0  <c0163800> 
generic_permission+0x110/0x120
 <c02126c7> kobject_get+0x17/0x20  <c01185c0> default_wake_function+0x0/0x20
 <c030482d> soundcore_open+0x8d/0x1c0  <c015e826> chrdev_open+0x76/0x160
 <c015e7b0> chrdev_open+0x0/0x160  <c0153aeb> __dentry_open+0xbb/0x200
 <c0153d4c> do_filp_open+0x5c/0x70  <c01539cb> get_unused_fd+0x5b/0xc0
 <c0153db3> do_sys_open+0x53/0x100  <c0153eb7> sys_open+0x27/0x30
 <c0102f47> syscall_call+0x7/0xb
Code: 8b 48 5c 8d 14 52 fc 89 4c 24 28 89 d1 c1 e1 04 01 ca b9 0e 00 00 00 8d 
14 d5 10 00 00 00 89 54 24 2c 8b 58 08 01 da 89 54 24 2c <c7> 42 10 ff ff ff 
ff c7 42 24 00 00 00 00 8b 7c 24 28 81 c7 d0
EIP: [<deae2514>] snd_usb_pcm_open+0x34/0x4d0 [snd_usb_audio] SS:ESP 
0068:c5be1d9c

