Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbTE3CBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 22:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbTE3CBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 22:01:23 -0400
Received: from fmr01.intel.com ([192.55.52.18]:15867 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262185AbTE3CBV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 22:01:21 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
Date: Thu, 29 May 2003 19:14:36 -0700
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB5640204336B@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC Proposal to enable MSI support in Linux kernel
Thread-Index: AcMmLm4bV/28JTC8TRy4zGfWy13z2QAHwN6w
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 May 2003 02:14:37.0172 (UTC) FILETIME=[3816A340:01C32651]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca]
> Sent: Thursday, May 29, 2003 2:55 PM
> To: Nguyen, Tom L
> Cc: Jeff Garzik; Nakajima, Jun;
> Subject: RE: RFC Proposal to enable MSI support in Linux kernel
> 
> On Thu, 29 May 2003, Nguyen, Tom L wrote:
> 
> > I am working on an updated patch to 2.5.70 to incorporate the comments
> > from you and Jeff Garzik. Regarding the variable renaming of irq, I am
> > open to any suggestions. Please make a recommendation and I will
> > incorporate it into the next update.
> 
> Well essentially, if the function is being passed a vector, lets call the
> parameter 'vector', right now you have to look at the code paths careful
> to determine wether it's an irq number or a vector masquerading as an irq
> number.
Agree.

> 
> > Regarding platform_legacy_irq, I have not seen an edge-triggered
> > interrupt failure caused by platform_legacy_irq.
> 
> So we can go with Jeff's suggestion there and remove the unecessary check
> for wether to assign level or edge?

Not so fast. This part is #ifdef CONFIG_ACPI_PCI and legacy IRQs can be overridden by Interrupt Source Overrides. Since they can change polarity (as far as the spec is concerned), I think we should fix the code. Hint: Look at the mp_override_legacy_irq().

Jun

> 
> 	Zwane
> --
> function.linuxpower.ca
