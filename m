Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWGYIIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWGYIIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 04:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWGYIIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 04:08:36 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:23600 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932067AbWGYIIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 04:08:35 -0400
Subject: [BUG] CPIA Kernel Bug in 2.6.17
From: Alex Bennee <kernel-hacker@bennee.com>
Reply-To: kernel-hacker@bennee.com
To: cpia@risc.uni-linz.ac.at
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 09:08:53 +0100
Message-Id: <1153814933.10587.5.camel@malory>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently running 2.6.17 and I get kernel faults when my camera is
plugged in. From the quietness of the (cpia) mailing list I'm wondering
if the driver atrophied while in the kernel?

For reference the kernel backtrace looks like this:

BUG: warning at lib/kref.c:32/kref_get()

Call Trace: <ffffffff80311f61>{kref_get+46}
<ffffffff803115a2>{kobject_get+18}
       <ffffffff8028f6ba>{sysfs_create_link+194}
<ffffffff803a098a>{class_device_add+494}
       <ffffffff8808d531>{:videodev:video_register_device+403}
       <ffffffff880a2bf9>{:cpia:cpia_register_camera+959}
<ffffffff880a981d>{:cpia_usb:cpia_probe+345}
       <ffffffff80400d91>{usb_probe_interface+118}
<ffffffff8039fabe>{driver_probe_device+84}
       <ffffffff8039fbed>{__driver_attach+104}
<ffffffff8039fb85>{__driver_attach+0}
       <ffffffff8039f016>{bus_for_each_dev+67}
<ffffffff8039f515>{bus_add_driver+116}
       <ffffffff803a0077>{driver_register+140}
<ffffffff80400eeb>{usb_register_driver+95}
       <ffffffff8800903c>{:cpia_usb:usb_cpia_init+60}
<ffffffff8023b34a>{sys_init_module+5215}
       <ffffffff8020962a>{system_call+126}
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/sysfs/symlink.c:88
invalid opcode: 0000 [1]
CPU 0
Modules linked in: cpia_usb cpia compat_ioctl32 v4l2_common videodev
fuse snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss radeon drm 8139cp
amd64_agp i2c_nforce2 agpgart 8139too
Pid: 32112, comm: modprobe Not tainted 2.6.17-ajb-dirty #19
RIP: 0010:[<ffffffff8028f629>] <ffffffff8028f629>{sysfs_create_link+49}
RSP: 0018:ffff810014a61be8  EFLAGS: 00010202
RAX: 000000003bf57401 RBX: 00000000ffffffef RCX: ffff8100143bf4c8
RDX: ffff81003bf57401 RSI: ffff81000f670050 RDI: ffff810005f754d0
RBP: ffff81003bf574c0 R08: 0000000000000000 R09: ffff8100143bf3c0
R10: ffffffff8045137c R11: ffffffff80494818 R12: 0000000000000000
R13: ffffffff8808f460 R14: ffffffff8808f460 R15: ffff81000f670050
FS:  00002ab9b64e1d50(0000) GS:ffffffff80720000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002ad1261f30e8 CR3: 00000000293b1000 CR4: 00000000000006e0
Process modprobe (pid: 32112, threadinfo ffff810014a60000, task
ffff81002b5cf140)
Stack: ffff8100143bf4c8 ffff81000f670050 ffff81000f670040
ffff81000f670050
       ffffffff8808f460 ffffffff8808f460 0000000000000000
ffffffff803a09a4
       ffff81003bf574c0 ffff81000f670040
Call Trace: <ffffffff803a09a4>{class_device_add+520}
       <ffffffff8808d531>{:videodev:video_register_device+403}
       <ffffffff880a2bf9>{:cpia:cpia_register_camera+959}
<ffffffff880a981d>{:cpia_usb:cpia_probe+345}
       <ffffffff80400d91>{usb_probe_interface+118}
<ffffffff8039fabe>{driver_probe_device+84}
       <ffffffff8039fbed>{__driver_attach+104}
<ffffffff8039fb85>{__driver_attach+0}
       <ffffffff8039f016>{bus_for_each_dev+67}
<ffffffff8039f515>{bus_add_driver+116}
       <ffffffff803a0077>{driver_register+140}
<ffffffff80400eeb>{usb_register_driver+95}
       <ffffffff8800903c>{:cpia_usb:usb_cpia_init+60}
<ffffffff8023b34a>{sys_init_module+5215}
       <ffffffff8020962a>{system_call+126}

Code: 0f 0b 68 76 43 4e 80 c2 58 00 49 8b 7c 24 08 48 81 c7 c0 00
RIP <ffffffff8028f629>{sysfs_create_link+49} RSP <ffff810014a61be8>


--
Alex, homepage: http://www.bennee.com/~alex/
Is a person who blows up banks an econoclast?

