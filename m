Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVGZKuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVGZKuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 06:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVGZKuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:50:10 -0400
Received: from totor.bouissou.net ([82.67.27.165]:24809 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261675AbVGZKsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:48:51 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [SOLVED ?] VIA KT400 + Kernel 2.6.12 + IO-APIC + ehci_hcd = IRQ trouble
User-Agent: KMail/1.7.2
Cc: "Alan Stern" <stern@rowland.harvard.edu>, dbrownell@users.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C75@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C75@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Disposition: inline
Date: Tue, 26 Jul 2005 12:48:46 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200507261248.47286@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mardi 26 Juillet 2005 04:13, Protasevich, Natalie a écrit :
> > > Le Lundi 25 Juillet 2005 22:44, Alan Stern a écrit :
> >
> > Natalie, that's all I can think of.  Now it's up to you to
> > invent a patch Michel can try out, to show just where the
> > IO-APIC code is going wrong.
>
> I will sure try... I'm keeping an eye on your exchange don't worry :)
> just have to get done with urgent work piled up here while on my trip :<
> ...

I'm afraid that I may have accidentally solved my problem ;-)

I've upgraded my Gigabyte GA7-VAXP motherboard's BIOS from release 7VAXP.F11 
to 7VAXP.F15, and it seems the problem is gone !

The strange thing is that now, cat /proc/interrupts shows that both uhci_hcd 
and ehci_hcd use the same IRQ (21) :

[root@totor etc]# cat /proc/interrupts
           CPU0
  0:     569004    IO-APIC-edge  timer
  1:       2107    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:       1589    IO-APIC-edge  serial
  7:          2    IO-APIC-edge  parport0
 14:       4615    IO-APIC-edge  ide4
 15:       4624    IO-APIC-edge  ide5
 16:      29033   IO-APIC-level  nvidia
 18:       7684   IO-APIC-level  eth0, eth1
 19:      28049   IO-APIC-level  ide0, ide1, ide2, ide3
 21:       7128   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, 
uhci_hcd:usb4
 22:       5969   IO-APIC-level  VIA8233
NMI:          0
LOC:     568946
ERR:          0
MIS:          0

...and then, the system feels happy. I've played around with USB devices of 
all speeds in all sockets, and there are no "irq 21: nobody cared!" messages 
anymore...

Still, high-speed USB devices seem to work only in the motherboard integrated 
USB sockets, otherwise I get some "usb 1-4: device not accepting address 26, 
error -71" messages, but this isn't an issue for me, and might be a cable 
problem as you said...

So it seems that the BIOS upgrade fixed the IRQ issue (or masked it ?).

What is weird is that, from the Gigabyte's BIOS list, I wouldn't have expected 
this upgrade to fix this, as their changelog from F11 to F15 only says:

F11: AMD Barton CPU support (2500+/2800+/3000+) 

F13: Fixed BIOS flash utility(flash8xx) can't be used issue

F14: Support new AMD Duron model8 CPU (64K L2 Cache FSB 266)

F15: Added AMD Sempron CPU support

So this BIOS upgrade was just a desperate move on my part ;-)

Well, anyway, things look much better here now...

Natalie, if you would like me to try some of your VIA patches to check them 
out on my system, I would be glad to help in my turn...

Cheers, and thanks to all of you again for all your precious help.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
