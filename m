Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVG0AmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVG0AmC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 20:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVG0AmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 20:42:02 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:35292 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S262420AbVG0AkN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 20:40:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6.13-rc3-git4] VIA686A polymorphs into VIA586!
Date: Tue, 26 Jul 2005 17:40:11 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C33D2C2B@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.13-rc3-git4] VIA686A polymorphs into VIA586!
thread-index: AcWSLaw4YYhQrDgUSuuqBD9RqGF7CAAFRqow
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Giancarlo Formicuccia" <giancarlo.formicuccia@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       "Greg KH" <greg@kroah.com>
X-OriginalArrivalTime: 27 Jul 2005 00:40:13.0020 (UTC) FILETIME=[BFEA61C0:01C59243]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Giancarlo Formicuccia
>Sent: Tuesday, July 26, 2005 2:09 PM
>To: Aleksey Gorelov
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: [2.6.13-rc3-git4] VIA686A polymorphs into VIA586!
>
>Does this patch look good for you?
>Who's the right developer to ask for inclusion? I'd like to 
>see this problem addressed before 2.6.13...
Yep, this is better. Please add appropriate patch description &
Signed-off-by and resend it to Greg and Andrew.

Aleks.
>
>Thanks,
>Giancarlo
>
>
>--- linux-2.6.13-git4/arch/i386/pci/irq.c.org	2005-07-23 
>11:15:12.000000000 +0200
>+++ linux-2.6.13-git4/arch/i386/pci/irq.c	2005-07-26 
>20:53:11.000000000 +0200
>@@ -550,6 +550,13 @@
> static __init int via_router_probe(struct irq_router *r, 
>struct pci_dev *router, u16 device)
> {
> 	/* FIXME: We should move some of the quirk fixup stuff here */
>+
>+	if (router->device == PCI_DEVICE_ID_VIA_82C686 &&
>+			device == PCI_DEVICE_ID_VIA_82C586_0) {
>+		/* Asus k7m bios wrongly reports 82C686A as 
>586-compatible */
>+		device = PCI_DEVICE_ID_VIA_82C686;
>+	}
>+
> 	switch(device)
> 	{
> 		case PCI_DEVICE_ID_VIA_82C586_0:
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
