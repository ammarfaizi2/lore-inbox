Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSBKWsj>; Mon, 11 Feb 2002 17:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290597AbSBKWsa>; Mon, 11 Feb 2002 17:48:30 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:17673 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S290593AbSBKWsZ>; Mon, 11 Feb 2002 17:48:25 -0500
Message-ID: <3C684A88.5070307@sh.cvut.cz>
Date: Mon, 11 Feb 2002 23:49:44 +0100
From: Jakub Travnik <J.Travnik@sh.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020207
X-Accept-Language: cs, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: zlatko.calusic@iskon.hr
Subject: Re: emu10k1 - interrupt storm?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello and sorry for replying late,

I did experienced same problems with emu10k1 on 2.4.8 (as is in Mandrake 8.1).

After modprobing emu10k1, interrupts per second (as reported by vmstat)
start to increase and in few minutes they were as high as 70000 per second.
rmmod-ing emu10k1 caused number of interrupts per second to slowly decrease.

Following setting affected this:

In BIOS setup, PCI options:
Interrupts triggered by
1, edge
2, level

value 'edge' causes problems,
value 'level' makes thing work without problems.

If you are experiencing problems with this, set to 'level'.


Jakub Travnik
jabber://jtra@jabber.com



----Replied message follows----
From: Zlatko Calusic (zlatko.calusic@iskon.hr)
Date: Sun Dec 09 2001 - 16:54:03 EST
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

Creative EMU10K1 PCI Audio Driver, version 0.16, 16:17:32 Dec 9 2001
emu10k1: EMU10K1 rev 6 model 0x8027 found, IO at 0xc400-0xc41f, IRQ 10
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)

This is my /proc/interrupts:

            CPU0 CPU1
   0: 423348 425806 IO-APIC-edge timer
   1: 13674 13371 IO-APIC-edge keyboard
   2: 0 0 XT-PIC cascade
   8: 2 1 IO-APIC-edge rtc
  10: 5956299 5956064 IO-APIC-level EMU10K1 <===========
  11: 19803 20033 IO-APIC-level ide2
  12: 104203 101822 IO-APIC-edge PS/2 Mouse
  14: 4356 4285 IO-APIC-edge ide0
  15: 7 9 IO-APIC-edge ide1
NMI: 0 0
LOC: 849167 849165
ERR: 2
MIS: 0

Yes, this is a SMP machine, but I don't know why would that make any
difference. As you can see, number of emu10k1 interrupts is enormous
(I also tried noapic, no changes).

procinfo -d quickly shows that emu10k1 is generating ~1412 interrupts
per second (7060/2).

irq 0: 500 timer irq 10: 7060 EMU10K1
irq 1: 1 keyboard irq 11: 10 ide2
irq 2: 0 cascade [4] irq 12: 164 PS/2 Mouse
irq 3: 0 irq 14: 2 ide0
irq 4: 0 irq 15: 0 ide1
irq 8: 0 rtc

Is that the periodic hardware interrupt you're talking about, and why
are there so many interrupts? Is there a way to stop that storm?

Regards,

-- 
Zlatko
-


