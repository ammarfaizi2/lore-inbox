Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289859AbSAKTYI>; Fri, 11 Jan 2002 14:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289868AbSAKTX6>; Fri, 11 Jan 2002 14:23:58 -0500
Received: from web20908.mail.yahoo.com ([216.136.226.230]:3955 "HELO
	web20908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289859AbSAKTXr>; Fri, 11 Jan 2002 14:23:47 -0500
Message-ID: <20020111192345.9003.qmail@web20908.mail.yahoo.com>
Date: Fri, 11 Jan 2002 11:23:45 -0800 (PST)
From: Paul Lorenz <p1orenz@yahoo.com>
Subject: Re: Driver via ac97 sound problem (VT82C686B)
To: linux-kernel@vger.kernel.org
Cc: j.lumbroso@noos.fr
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have the same laptop( Presario 700 with ac97 audio 
(VT82C686B chip) and the same problem. Here is the
info I have gathered so far. I'm not a kernel hacker
so the info may not be as useful as it could be but
maybe it will be enough for someone in the know to go
on.

selected dmesg output
------------------------------------------------------
PCI: PCI BIOS revision 2.10 entry at 0xfd7ae, last
bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
.
.8139too Fast Ethernet driver 0.9.22
PCI: Assigned IRQ 11 for device 00:0b.0
IRQ routing conflict for 00:07.5, have irq 5, want irq
11
PCI: Sharing IRQ 11 with 00:0a.0
eth0: RealTek RTL8139 Fast Ethernet at 0xcf81e000,
00:08:02:03:2a:ef, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
----------------------------------------------------
output from modprobe via82cxxx_audio

Jan 11 08:56:34 debian kernel: via82cxxx: board #1 at
0x1000, IRQ 5
Jan 11 08:56:48 debian kernel: Via 686a audio driver
1.9.1
Jan 11 08:56:48 debian kernel: PCI: Found IRQ 11 for
device 00:07.5
Jan 11 08:56:48 debian kernel: IRQ routing conflict
for 00:07.5, have irq 5, want irq 11
Jan 11 08:56:48 debian kernel: PCI: Sharing IRQ 11
with 00:0a.0
Jan 11 08:56:48 debian kernel: PCI: Sharing IRQ 11
with 00:0b.0
Jan 11 08:56:48 debian kernel: ac97_codec: AC97 Audio
codec, id: 0x4144:0x5361 (Unknown)
Jan 11 08:56:48 debian kernel: via82cxxx: board #1 at
0x1000, IRQ 5

-----------------------------------------

What I found from poking around in 
arch/i386/kernel/pci-irq.c
mostly in pnpbios_lookup_irq( ... )

The dev->irq is 5, which is correct, I think that is 
the same as what windows assigns to it. However the 
problem is that it shares a pirq with the ethernet 
adapter. I checked and the sound card and the ethernet
adapter have diferrent pins, I think one was 0 and
one was 2, but they return the same pirq from

info=pirq_get_dev(dev)
pirq=info->irq[pin].link;

So, as I understand, the sound card has irq 5, 
the ethernet card has irq 11 and since they
, possibly erroneously, share a routing table 
entry, this is causing some confusion. I put 
some debug statements in the driver itself and
it is receiving interrupts.

I have the same symptoms, if you crank the volume
all the way up, you can very faintly here something.
I have also tried the ALSA drivers, but they 
weren't any better. I also tried all with and 
without ACPI/APM and various via quirks. Nothing 
helped.

I'm willing to supply further information, test
patches or try to debug further but with my limited
knowledge of how the pci subsystem works I'm stuck for
now. 

I've made sure that I have the latest BIOS from
compaq. The BIOS is completely useless. There are
about 5 options you can set, none of them usefull.

I appreciate any and all assistance.
Paul Lorenz

-------------------------------
>hi 
>
>i have a laptop presario 700 with ac97 audio an board
( >VT82C686B 
>chip).
>When i load the via686xxx sound module ,everything is
>fine 
>but i have very very low sound with all volume at
100%.

>could someone have a solution or an idea on what
going >on ?

>thx 



__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
