Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTLOObM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 09:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTLOObM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 09:31:12 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:44559 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S263620AbTLOObI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 09:31:08 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Fwd: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Tue, 16 Dec 2003 00:30:30 +1000
User-Agent: KMail/1.5.1
Cc: recbo@nishanet.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312160030.30511.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> APIC error on CPU0: 02(02) 
> > what?? no crash though. 
> [...] 
> > bob@where cat /proc/interrupts 
> > CPU0 
> > 0: 3350153 IO-APIC-edge timer 
> > 1: 5775 IO-APIC-edge i8042 
> > 2: 0 XT-PIC cascade 
> > 8: 1 IO-APIC-edge rtc 
> > 9: 0 IO-APIC-level acpi 
> > 12: 5385 IO-APIC-edge i8042 
> > 14: 10 IO-APIC-edge ide0 
> > 15: 10 IO-APIC-edge ide1 
> > 16: 1717957 IO-APIC-level ide2, ide3, eth0 
> > 19: 472929 IO-APIC-level ide4, ide5 
> > 21: 0 IO-APIC-level NVidia nForce2 
> > NMI: 822 
> > LOC: 3350073 
> > ERR: 35 
> > MIS: 15818 

>It looks like the infamous APIC delivery bug -- the "MIS" counter shows 
>how many level-triggered interrupts has been erronously delivered as 
>edge-triggered ones. No wonder the system shows instability -- you have 
>noise problems at the APIC bus. 
 
Thanks Maciej
I was wondering about those, I had seen the work around code and would not
have thought it need apply to recent athlon chipsets?


For comparison here is my proc/interrupts 
CPU0
  0:   50462204    IO-APIC-edge  timer
  1:      49153    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  9:          0   IO-APIC-level  acpi
 12:     395912    IO-APIC-edge  PS/2 Mouse
 14:     995872    IO-APIC-edge  ide0
 15:        283    IO-APIC-edge  ide1
 16:    3921102   IO-APIC-level  nvidia
 18:          2   IO-APIC-level  bttv
 20:     136325   IO-APIC-level  eth0, usb-ohci
 21:     146903   IO-APIC-level  ehci_hcd, NVIDIA nForce Audio
 22:          0   IO-APIC-level  usb-ohci
NMI:          0
LOC:   50457798
ERR:          0
MIS:          0

Albatron KM18G-Pro, nforce2, pheonix bios, 2200XP, 255fsb, ddr400,
ide0 is hard drive, ide1 is cdrom, nmi watchdog off

Report seems OK but this machine locks up hard without the apic delay patch.

I am currently trying the simpler v1 (always add a delay) patch but on all apic
acks as per this posting

http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/3291.html

which is a reply to an earlier posting of the same name but I accidently 
omitted the Re in the subject.

Regards,
Ross.

