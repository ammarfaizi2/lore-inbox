Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316693AbSFQEvW>; Mon, 17 Jun 2002 00:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSFQEvV>; Mon, 17 Jun 2002 00:51:21 -0400
Received: from fluent2.pyramid.net ([206.100.220.213]:50962 "HELO
	fluent2.pyramid.net") by vger.kernel.org with SMTP
	id <S316693AbSFQEvU>; Mon, 17 Jun 2002 00:51:20 -0400
Message-Id: <5.1.0.14.0.20020616212259.00a8b110@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 16 Jun 2002 21:51:19 -0700
To: linux-kernel@vger.kernel.org
From: Stephen Satchell <spamfilter@fluent2.pyramid.net>
Subject: Toshiba PCToPIC97 PC Card freeze in 2.4.18
In-Reply-To: <1024271844.1476.26.camel@sinai>
References: <Pine.LNX.4.44.0206161809480.9633-200000@e2>
 <Pine.LNX.4.44.0206161809480.9633-200000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All:

I'm at my wit's end.  I have a Toshiba Satellite 2545XCDT which has a PC 
Card adapter.  I have been happily running this laptop with a 2.2.16 kernel 
without problem.  Today, when trying to upgrade to a 20GB hard disk and a 
2.4.18 kernel, the box would freeze when trying to start the PCMCIA 
service.  Here is the message that I get on the screen:

PCI:  No IRQ known for interrupt pin A of device 00:13:0.  Please try using 
pci=biosirq
PCI:  No IRQ known for interrupt pin B of device 00:13.0.  Please try using 
pci=biosirq
Yenta IRQ list 06b8 PCI irq 0
Socket status: 30000007

and the system is completely frozen at that point -- even CTRL-ALT-DEL 
doesn't work.  (The soft power switch does, which tells me that NMI 
interrupts get through, but nothing else.)  As you might guess, SysRq 
didn't work, either.  Only powering off would allow me to restart the system.

When I recompile the kernel to not make PCMCIA a module, there is NO 
message, just the system freeze.

Nothing interesting shows up in syslog.

Probing the /proc filesystem, I find that under 2.2.16 there is a character 
device 254 labeled PCMCIA; in the 2.4.18 kernel I see no device 254 or any 
device with the label PCMCIA.  Granted, in the case of 2.2.16 the various 
modules successfully loaded, so they may have advertised device 254, 
whereas on the 2.4.18 kernel the failure kept the device from being advertised.

Dumping /proc/pci, I see device 19 (0x13) listed but completely different 
capabilities advertised.  Under 2.2.16, I see "Slow devsel.  Fast 
back-to-back capable.  Master Capable.  No bursts.  Min Gnt=128.Max 
lat=4."  The same device under 2.4.18 reports "Non-prefetchable 32 bit 
memory at 0x100000000 [0x100000fff]."  Other PCI devices have reports that 
differ in format but not significantly in the amount of and values in content.

I even went so far as to download the latest version 
(pcmcia-cs-3.1.34.tar.gz) of the PCMCIA stuff from SourceForge, compiled it 
all, and ended up with exactly the same results.  So I'm beginning to 
believe that it's not the PCMCIA/PCCard software.

I checked the kernel archives for any mention of this problem, and the 
closest I could find was a complaint regarding an IBM ThinkPad.  Ditto 
checking the bug list for the project on SourceForge.  Nothing on Toshiba

I put the old hard drive back into the laptop so I can get some work done, 
but I still have all the stuff on the new drive.

The distributions involved are Red Hat 7.0 and Red Hat 7.3.

Where to "try using pci=biosirq"?  I tried adding it to the boot sequence, 
with no result.

I'm stumped.  Any suggestions where to start looking?


Stephen Satchell

