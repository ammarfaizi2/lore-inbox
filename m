Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVCNJhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVCNJhb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVCNJfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:35:06 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:17355 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262079AbVCNJd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:33:57 -0500
Date: Mon, 14 Mar 2005 04:33:49 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <Pine.LNX.4.58.0503140214360.697@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503140427560.697@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu>  <1108789704.8411.9.camel@krustophenia.net>
  <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain> 
 <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> 
 <20050311095747.GA21820@elte.hu>  <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain>
  <20050311101740.GA23120@elte.hu>  <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
  <20050311024322.690eb3a9.akpm@osdl.org>  <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain>
  <20050311153817.GA32020@elte.hu>  <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
  <1110574019.19093.23.camel@mindpipe> <1110578809.19661.2.camel@mindpipe>
 <Pine.LNX.4.58.0503140214360.697@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Mar 2005, Steven Rostedt wrote:

>
> > > I'll test this with PREEMPT_DESKTOP and data=ordered also and see how it
> > > goes.
> >
> > Does not seem to work at all with the above settings.  It seemed OK
> > until I started X.  Then every time I launched an xterm it would
> > disappear as soon as I typed anything.  I could not switch consoles to
> > see the Oops.
> >
>
> Hi Lee,
>
> I just compiled PREEMPT_DESKTOP and mounted root (only disk filesystem on
> my test machine) as data=ordered.  I had no problem getting to X, starting
> an xterm and running a make. Actually it was a gnome-term since I didn't
> have xterm. But then I su to root, apt-get xterm, ran xterm, and did a
> make there with no problems.
>
> Did you patch this against 39-02 or -40-X?
>
> I haven't had time to upgrade to 40 yet.  Maybe, I'll work on that today.
>

I just downloaded -40 and applied my patch, compiled it with
PREEMPT_DESKTOP and data=ordered, ran it and everything seems OK, except
I'm getting the following...

BUG: Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c0213438
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: ipv6 af_packet tsdev mousedev evdev floppy psmouse
pcspkr snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd soundcore snd_page_alloc shpchp pci_hotplug ehci_hcd
intel_agp agpgart uhci_hcd usbcore e100 mii ide_cd cdrom unix
CPU:    0
EIP:    0060:[<c0213438>]    Not tainted VLI
EFLAGS: 00010286   (2.6.11-RT-V0.7.40-00)
EIP is at vt_ioctl+0x18/0x1ab0
eax: 00000000   ebx: 00005603   ecx: 00005603   edx: cb6c8780
esi: c0213420   edi: cc956000   ebp: cb613f18   esp: cb613e48
ds: 007b   es: 007b   ss: 0068   preempt: 00000000
Process XFree86 (pid: 4713, threadinfo=cb612000 task=cb5e0a40)
Stack: cb5e0b90 cb612000 cb5e0a40 c034494c cb5e0a40 00000246 cb613e7c
c0117217
       c0344954 00000006 00000001 00000000 00000000 cb613ebc ce0cce24
c13e1800
       cf1279b8 00000000 00000000 cb613ed4 c01707f1 cf1279b8 00000007
00000000
Call Trace:
 [<c0103cdf>] show_stack+0x7f/0xa0 (28)
 [<c0103e95>] show_registers+0x165/0x1d0 (56)
 [<c0104088>] die+0xc8/0x150 (64)
 [<c0115376>] do_page_fault+0x356/0x6c4 (216)
 [<c0103973>] error_code+0x2b/0x30 (268)
 [<c020e91b>] tty_ioctl+0x34b/0x490 (52)
 [<c016837f>] do_ioctl+0x4f/0x70 (32)
 [<c0168582>] vfs_ioctl+0x62/0x1d0 (40)
 [<c0168751>] sys_ioctl+0x61/0x90 (40)
 [<c0102ec3>] syscall_call+0x7/0xb (-8124)
Code: ff ff 8d 05 88 4d 34 c0 e8 f6 60 0a 00 e9 3a ff ff ff 90 55 89 e5 57
56 53 81 ec c4 00 00 00 8b 7d 08 8b 5d 10 8b 87 7c 09 00 00 <8b> 30 89 34
24 8b 04 b5 e0 b7 3c c0 89 45 8c e8 a4 6a 00 00 85


I'll see if this happens without the patch, and if so, then I'll look into
this further.

Thanks,

-- Steve

