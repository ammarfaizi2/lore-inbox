Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267498AbUBST16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267499AbUBST16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:27:58 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:37317 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S267498AbUBST1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:27:44 -0500
X-qfilter-stat: ok
X-Analyze: Velop Mail Shield v0.0.4
Date: Thu, 19 Feb 2004 16:27:39 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC works on Windows and FreeBSD but not Linux ?
Message-ID: <Pine.LNX.4.58.0402191616260.816@pervalidus.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote on 2004-01-24 0:57:44:

> I never got IO-APIC to work with my ECS K7VTA3 5.0 (KT333) on
> Linux 2.4 and 2.6. The first problem was at boot time with my
> network. It wouldn't give an IRQ or something to the lan, be
> it the onboard Realtek or a 3Com 3C905CX-TXNM.

Just tested with 2.6.3, and it still happens.

> ACPI with or without it was even worse, but I never needed
> it.

Everything seems to work fine with it now.

> It worked fine on Windows XP Professional SP1. Some days ago
> I installed FreeBSD 5.2 and now noticed it gave me IRQ18 for
> the onboard lan, IRQ22 for the onboard sound, and so on, and
> there's the following in /var/log/messages:

> Jan 23 15:27:07 pervalidus kernel: ioapic0: Assuming intbase
> of 0
> Jan 23 15:27:07 pervalidus kernel: ioapic0 <Version 0.3> irqs
> 0-23 on motherboard

> I'm just surprised IO-APIC works with it but not Linux.

Still surprised, because on it everything works if I use
IO-APIC with or without ACPI.

Here are the differences in /proc/pci (- is ACPI with IO-APIC,
+ IO-APIC):

       I/O at 0xb800 [0xb81f].
   Bus  0, device  16, function  3:
     USB Controller: VIA Technologies, Inc. USB 2.0 (rev 130).
-      IRQ 21.
+      IRQ 19.
       Master Capable.  Latency=32.
       Non-prefetchable 32 bit memory at 0xdd035000 [0xdd0350ff].
   Bus  0, device  17, function  0:
     ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge (rev 0).
   Bus  0, device  17, function  1:
     IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 6).
-      IRQ 20.
+      IRQ 27.
       Master Capable.  Latency=32.
       I/O at 0xbc00 [0xbc0f].
   Bus  0, device  17, function  5:

And /proc/interrupts:

-  9:          0   IO-APIC-level  acpi
- 14:       1138    IO-APIC-edge  ide0
+ 14:        777    IO-APIC-edge  ide0
- 18:         24   IO-APIC-level  eth0
- 21:        290   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd
+ 21:         99   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd

> I reported it months ago -
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0306.2/1646.html

> BTW, the freezes I mentioned are gone. The motherboard may be
> a bit buggy, as they appear if I disable the onboard RAID,
> but...

-- 
http://www.pervalidus.net/contact.html
