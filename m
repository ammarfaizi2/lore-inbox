Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284538AbRLIWDP>; Sun, 9 Dec 2001 17:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284500AbRLIWDG>; Sun, 9 Dec 2001 17:03:06 -0500
Received: from inje.iskon.hr ([213.191.128.16]:4820 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S284497AbRLIWCx>;
	Sun, 9 Dec 2001 17:02:53 -0500
To: Rui Sousa <rui.p.m.sousa@clix.pt>
Cc: <linux-kernel@vger.kernel.org>
Subject: emu10k1 - interrupt storm?
In-Reply-To: <Pine.LNX.4.33.0111041743030.3150-100000@sophia-sousar2.nice.mindspeed.com>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 09 Dec 2001 22:54:03 +0100
In-Reply-To: <Pine.LNX.4.33.0111041743030.3150-100000@sophia-sousar2.nice.mindspeed.com> (Rui Sousa's message of "Sun, 4 Nov 2001 17:48:59 +0100 (CET)")
Message-ID: <87g06kawlg.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Sousa <rui.p.m.sousa@clix.pt> writes:
> 
> The current emu10k1 driver uses a hardware clock to generate periodic 
> interrupts. These apparently ran at the wrong rate in some Alpha machines.
> It's possible that the same problem occur now with more recent i386 
> machines.
> 

Hi!

Sorry to quote a really old email. :)

I'm currently investigating why is my emu10k1 doing so much
interrupts. They are so frequent that they usually show on a kernel
profile report on the top, no matter what I've been doing with the
poor machine (interrupts are there even if I'm not using my
Soundblaster live).

Kernel is the most recent 2.5.x. dmesg says:

Creative EMU10K1 PCI Audio Driver, version 0.16, 16:17:32 Dec  9 2001
emu10k1: EMU10K1 rev 6 model 0x8027 found, IO at 0xc400-0xc41f, IRQ 10
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)

This is my /proc/interrupts:

           CPU0       CPU1       
  0:     423348     425806    IO-APIC-edge  timer
  1:      13674      13371    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          2          1    IO-APIC-edge  rtc
 10:    5956299    5956064   IO-APIC-level  EMU10K1       <===========
 11:      19803      20033   IO-APIC-level  ide2
 12:     104203     101822    IO-APIC-edge  PS/2 Mouse
 14:       4356       4285    IO-APIC-edge  ide0
 15:          7          9    IO-APIC-edge  ide1
NMI:          0          0 
LOC:     849167     849165 
ERR:          2
MIS:          0

Yes, this is a SMP machine, but I don't know why would that make any
difference. As you can see, number of emu10k1 interrupts is enormous
(I also tried noapic, no changes).

procinfo -d quickly shows that emu10k1 is generating ~1412 interrupts
per second (7060/2).

irq  0:       500 timer                 irq 10:      7060 EMU10K1
irq  1:         1 keyboard              irq 11:        10 ide2
irq  2:         0 cascade [4]           irq 12:       164 PS/2 Mouse
irq  3:         0                       irq 14:         2 ide0
irq  4:         0                       irq 15:         0 ide1
irq  8:         0 rtc                  

Is that the periodic hardware interrupt you're talking about, and why
are there so many interrupts? Is there a way to stop that storm?

Regards,
-- 
Zlatko
