Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVLaSSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVLaSSR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 13:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVLaSSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 13:18:17 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:1085 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932310AbVLaSSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 13:18:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=CbL2JExFvbFVYzyJUZQ2sBun0vkTBpqrUcnX07aD3/kCL/BAWAHPiQ5WShmVu8lcCttxPLRcbpNXu/LZXz1z+y6Yn4nHmI0MoeIMLCfQGKemMZdq6x5nVk52vAF+jl4fmo5RQBOVM0gtCf69QTujhVO1+UArB0VBKU4y7z2TTUA=
Date: Sat, 31 Dec 2005 20:18:08 +0200
From: Bradley Reed <bradreed1@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: MPlayer broken under 2.6.15-rc7-rt1?
Message-ID: <20051231201808.43d6c4d6@galactus.example.org>
X-Mailer: Sylpheed-Claws 1.9.100cvs108 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried MPlayer versions 1.0pre6, 1.0pre7, and cvs from today and
they all work fine under 2.6.14 and 2.6.14-rt21/22.

I booted into 2.6.15-rc7-rt1 and the same MPlayer binaries segfault on
every video I try and play. Yes, I have nvidia modules loaded, so won't
get much help, but thought someone might like to know. 

xine plays the videos fine.

BTW, other than MPLayer problems, everything else works great.

Brad

dmesg shows:
------------[ cut here ]------------
kernel BUG at include/linux/timer.h:83!
invalid operand: 0000 [#5]
PREEMPT 
Modules linked in: snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_o    
ss intel_agp snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd snd_page_alloc nvidia agpgart b44     
orinoco_cs orinoco hermes
CPU:    0
EIP:    0060:[<c031491c>]    Tainted: P      VLI
EFLAGS: 00010286   (2.6.15-rc7-rt1) 
EIP is at rtc_do_ioctl+0xa13/0xa44
eax: 00000021   ebx: cf16e000   ecx: de8e8000   edx: cf16e000
esi: 00000246   edi: 00000001   ebp: 00007005   esp: cf16fe7c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process mplayer (pid: 4067, threadinfo=cf16e000 task=df315380 stack_left=7752 worst_left=-1)
Stack: c047704e c047dff9 00000053 00000000 00000000 00000246 dffb4e00 c0500380 
       00000087 00000000 c030809a de91e330 cb5f1b80 00000000 00000246 dffb4e00 
       dffb4e00 00000000 c0307fc3 c016ed76 de91e330 cb5f1b80 cf16ff38 00000003 
Call Trace:
 [<c030809a>] misc_open+0xd7/0x2ee (44)
 [<c0307fc3>] misc_open+0x0/0x2ee (32)
 [<c016ed76>] chrdev_open+0xf6/0x1c8 (4)
 [<c016ec80>] chrdev_open+0x0/0x1c8 (32)
 [<c0164380>] __dentry_open+0xc3/0x259 (4)
 [<c0164656>] nameidata_to_filp+0x37/0x4f (28)
 [<c016456a>] filp_open+0x54/0x60 (28)
 [<c0178983>] do_ioctl+0x6f/0xa9 (40)
 [<c0178b54>] vfs_ioctl+0x65/0x1e1 (36)
 [<c01732ac>] putname+0x2b/0x37 (20)
 [<c0178d15>] sys_ioctl+0x45/0x6c (16)
 [<c0103171>] syscall_call+0x7/0xb (36)
Code: 73 14 00 e9 bb fd ff ff e8 d0 73 14 00 eb ae c7 44 24 08 53 00 00 00 c7 44 24 04 f9 df 47 c0 c7 04 24 4e    
 70 47 c0 e8 25 7d e0 ff <0f> 0b 53 00 f9 df 47 c0 e9 a1 fd ff ff fb 83 6b 14 01 8b 43 08 

====
strace mplayer ends with:

munmap(0xb6cd8000, 790528)              = 0
open("/dev/rtc", O_RDONLY|O_LARGEFILE)  = 3
ioctl(3, RTC_IRQP_SET, 0x400)           = 0
ioctl(3, RTC_PIE_ON <unfinished ...>
+++ killed by SIGSEGV +++


