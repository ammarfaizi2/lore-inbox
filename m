Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTKCVrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 16:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTKCVrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 16:47:06 -0500
Received: from ale.atd.ucar.edu ([128.117.80.15]:32199 "EHLO ale.atd.ucar.edu")
	by vger.kernel.org with ESMTP id S263310AbTKCVrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 16:47:03 -0500
From: "Charles Martin" <martinc@ucar.edu>
To: <linux-kernel@vger.kernel.org>
Cc: <martinc@atd.ucar.edu>
Subject: RE: interrupts across  PCI bridge(s) not handled
Date: Mon, 3 Nov 2003 14:46:57 -0700
Message-ID: <000001c3a254$043d88c0$c3507580@atdsputnik>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0311031218250.20373-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hmm..
> 
> The MP tables mention IRQ's up to 51, but no further.
> 
> But the PIRQ routing tables talk about irqs 92-95 for bus 6.
> 
> It really looks like the IRQ routing entries are just broken. One 
> potential fix is to enable ACPI, and hope that the ACPI irq 
> routing isn't 
> as broken as the PIRQ stuff.
> 
> Other than that I don't see anything we can do. Anybody else?
> 
> 		Linus
> 

I enabled ACPI, and the interrupts are now assigned correctly,
and in the range of 48-51:

           CPU0       CPU1       
 
 48:        878        389   IO-APIC-level  piraq
 49:        923        336   IO-APIC-level  piraq
 50:      17239        838   IO-APIC-level  ioc2, piraq
 51:        879        404   IO-APIC-level  piraq

They are now getting handled properly, i.e. I am receiveing 
interrupts from the boards located in the backplane extender. 
This is with 2.4.22.

I didn't realize that ACPI is related to interrupt management 
as well as power control. Is there any downside to using ACPI?

Thanks,
Charlie

