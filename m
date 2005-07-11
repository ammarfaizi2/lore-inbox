Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVGKT73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVGKT73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVGKT6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:58:09 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:35079 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S262544AbVGKTwn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:52:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [SOLVED ??] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Mon, 11 Jul 2005 14:52:40 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C49@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [SOLVED ??] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Thread-Index: AcWGT2A4Ja8iWU0ISKWLlWiVZrpW3QAAMWCQ
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Michel Bouissou" <michel@bouissou.net>,
       "Alan Stern" <stern@rowland.harvard.edu>, <fieroch@web.de>
Cc: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
X-OriginalArrivalTime: 11 Jul 2005 19:52:35.0036 (UTC) FILETIME=[1528C1C0:01C58652]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Le Lundi 11 Juillet 2005 20:36, Alan Stern a écrit :
> > It's also possible that the UHCI controllers are generating the 
> > unwanted interrupt requests.  You should make sure that Legacy USB 
> > Support is turned off in your BIOS settings.
> 
> My motherboard both holds USB 1.1 and USB 2.0 controllers. I 
> don't have a "Legacy USB Support" option in my BIOS, all my 
> USB options are the following:
> 
> Enable USB 1.1 controller: YES	(Surely relates to my 
> true USB 1.1 controller)
> 
> Enable USB 2.0 controller: YES	(Same for the high 
> speed controller ?)
> 
> Enable USB keyboard: NO
> 
> Enable USB mouse support: YES	(Well, I have one ;-)
> 
> I didn't change anything regarding these so far.
> 
> > You can also try adding the "usb-handoff" kernel parameter to your 
> > boot command line.
> 
> Hey !! This one looks like the MIRACLE-OPTION !!

Alexander, should you try this option? (Just in case if you haven't noticed this thread)...

> I just booted using my 2.6.12 kernel patched with Nathalie's 
> patches (don't know if they help in there...) and the problem 
> seems to be gone !

Michel, it would be interesting to see if you have problems with the kernel that doesn't have the fix posted in that bugzilla yet, but only has my first patch.
 
> Nothing complains anymore about the interrupt. I have:
> 
> [root@totor etc]# cat /proc/interrupts
>            CPU0
>   0:     934501    IO-APIC-edge  timer
>   1:       4611    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   4:       2779    IO-APIC-edge  serial
>   7:          3    IO-APIC-edge  parport0
>  14:       7909    IO-APIC-edge  ide4
>  15:       7918    IO-APIC-edge  ide5
>  16:      38447   IO-APIC-level  nvidia
>  18:       2982   IO-APIC-level  eth0, eth1
>  19:      37041   IO-APIC-level  ide0, ide1, ide2, ide3, ehci_hcd:usb4
>  21:      52036   IO-APIC-level  uhci_hcd:usb1, 
> uhci_hcd:usb2, uhci_hcd:usb3
>  22:       2850   IO-APIC-level  VIA8233
> NMI:          0
> LOC:     934453
> ERR:          0
> MIS:          0
> 
> 
> ...now let's see with time if this is stable...
> 
> A thousand thanks for your suggestion Alan !
>
 
Thank you Alan! You helped me too, since my patch has broken a couple VIA chips lately. Now I know that at least the fix works...

 
