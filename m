Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266696AbUFYKjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266696AbUFYKjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266699AbUFYKjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:39:15 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:7820 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266696AbUFYKjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:39:10 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm2
Date: Fri, 25 Jun 2004 12:48:01 +0200
User-Agent: KMail/1.5
Cc: ak@muc.de, linux-kernel@vger.kernel.org
References: <20040624014655.5d2a4bfb.akpm@osdl.org> <200406242257.03397.rjwysocki@sisk.pl> <20040624222140.07e01dae.akpm@osdl.org>
In-Reply-To: <20040624222140.07e01dae.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406251248.02155.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 of June 2004 07:21, Andrew Morton wrote:
> "R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
> > On Thursday 24 of June 2004 10:46, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6
> > >.7-m m2/
> >
> > Well, I have alarmingly many problems with this patch (my system is a
> > dual Opteron - full config log attached):
> >
> > 1) There is an Oops at early boot time, caused probably by earlyprintk,
> > which makes the serial console stop working (the call trace goes too fast
> > to read and of course it does not go to the serial console ...).
>
> This is fixed, yes?

I think so.  I haven't tried your patch yet (I managed to miss it ;-)), but 
reversing the "+reduce-tlb-flushing-during-process-migration-2.patch"
helps here, so I assume the answer is "yes".

> > 2) There is an Oops when trying to unload the sound driver
> > (snd-intel8x0).  At present I'm unable to grab it. because of 1).
>
> I'm not able to reproduce this.  Can you grab a trace now?

This is related to the previous one, certainly.  I'm unable to reproduce it 
after reversing the "+reduce-tlb-flushing-during-process-migration-2.patch", 
too.

The trace would probably look very much like that one:

Jun 24 22:16:40 chimera kernel: Unable to handle kernel NULL pointer 
dereference at 0000000000000238 RIP: 
Jun 24 22:16:40 chimera kernel: <ffffffff80119be4>{flush_tlb_mm+4}
Jun 24 22:16:40 chimera kernel: PML4 3f6a3067 PGD 3f6d7067 PMD 0 
Jun 24 22:16:40 chimera kernel: Oops: 0000 [2] SMP 
Jun 24 22:16:40 chimera kernel: CPU 0 
Jun 24 22:16:40 chimera kernel: Modules linked in: parport_pc lp parport 
usbserial snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss 
snd_ioctl32 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc 
gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ohci1394 
ieee1394 ehci_hcd tg3 ohci_hcd usblp usbcore dm_mod
Jun 24 22:16:40 chimera kernel: Pid: 8489, comm: kstopmachine Not tainted 
2.6.7-mm2
Jun 24 22:16:40 chimera kernel: RIP: 0010:[flush_tlb_mm+4/176] 
<ffffffff80119be4>{flush_tlb_mm+4}
Jun 24 22:16:40 chimera kernel: RIP: 0010:[<ffffffff80119be4>] 
<ffffffff80119be4>{flush_tlb_mm+4}
Jun 24 22:16:40 chimera kernel: RSP: 0018:000001003efe5e88  EFLAGS: 00010216
Jun 24 22:16:40 chimera kernel: RAX: 0000000000000000 RBX: 000001003efe5e98 
RCX: 000001003efe5ee8
Jun 24 22:16:40 chimera kernel: RDX: 000001003efe5e60 RSI: 000001003e4e2a70 
RDI: 0000000000000000
Jun 24 22:16:40 chimera kernel: RBP: 000001003efe5f28 R08: 000001003efe4000 
R09: 0000000000000001
Jun 24 22:16:40 chimera kernel: R10: 00000000ffffffff R11: 0000000000000000 
R12: 000001002070f620
Jun 24 22:16:40 chimera kernel: R13: 000001003efe5ea8 R14: 0000000000000000 
R15: 000001003e4e2a70
Jun 24 22:16:40 chimera kernel: FS:  0000002a95d330a0(0000) 
GS:ffffffff80497280(0000) knlGS:0000000000000000
Jun 24 22:16:41 chimera kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 
000000008005003b
Jun 24 22:16:41 chimera kernel: CR2: 0000000000000238 CR3: 0000000000101000 
CR4: 00000000000006e0
Jun 24 22:16:41 chimera kernel: Process kstopmachine (pid: 8489, threadinfo 
000001003efe4000, task 000001003e4e2a70)
Jun 24 22:16:41 chimera kernel: Stack: 000001003efe5f28 ffffffff801319c4 
0000000000000001 0000000000000246 
Jun 24 22:16:41 chimera kernel:        000001003efe5ea8 000001003efe5ea8 
0000010000000000 000001003e4e2a70 
Jun 24 22:16:41 chimera kernel:        0000000000000000 0000000000000206 
Jun 24 22:16:41 chimera kernel: Call 
Trace:<ffffffff801319c4>{set_cpus_allowed+436} 
<ffffffff80150e83>{stopmachine+35} 
Jun 24 22:16:41 chimera kernel:        <ffffffff8010f24f>{child_rip+8} 
<ffffffff80150e60>{stopmachine+0} 
Jun 24 22:16:41 chimera kernel:        <ffffffff8010f247>{child_rip+0} 
Jun 24 22:16:41 chimera kernel: 
Jun 24 22:16:41 chimera kernel: Code: 48 8b 87 38 02 00 00 48 89 f9 48 89 04 
24 65 8b 04 25 34 00 
Jun 24 22:16:41 chimera kernel: RIP <ffffffff80119be4>{flush_tlb_mm+4} RSP 
<000001003efe5e88>
Jun 24 22:16:41 chimera kernel: CR2: 0000000000000238

but I had only been able to get this:

Jun 24 23:20:20 chimera kernel: Unable to handle kernel NULL pointer 
dereference at 0000000000000238 RIP:
Jun 24 23:20:20 chimera kernel: <ffffffff80119be4>{flush_tlb_mm+4}
Jun 24 23:20:20 chimera kernel: PML4 1e86a067 PGD 0
Jun 24 23:20:20 chimera kernel: Oops: 0000 [2] SMP

before the machine hanged solid after rmmod (the serial console doesn't work, 
as I've already reported).

Yours,
rjw

----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
