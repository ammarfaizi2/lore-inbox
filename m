Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVGYTu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVGYTu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVGYTup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:50:45 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:23869 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261505AbVGYTsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:48:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=EAWf8ko5VIoDm+uxarJprB04WrE2KQN9OPxt2ojOd41ejD0e0NZPazNiNeeYXdMesFe3FaQKx42eXIJKOyiQobwCfsMYt4Dsm0fiMkhPMw4nNnuxVEDCVgwEAqnHT15HtQO2RnrOiuPoSdxFdXyztpec3Jk1EF8fcLlhQwQVfAA=
From: "Giancarlo Formicuccia" <giancarlo.formicuccia@gmail.com>
To: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
Subject: Re: [2.6.13-rc3-git4] VIA686A polymorphs into VIA586!
Date: Mon, 25 Jul 2005 21:54:59 +0200
User-Agent: KMail/1.6.1
Cc: <linux-kernel@vger.kernel.org>
References: <0EF82802ABAA22479BC1CE8E2F60E8C33D28A2@scl-exch2k3.phoenix.com>
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C33D28A2@scl-exch2k3.phoenix.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507252155.00262.giancarlo.formicuccia@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksey Gorelov wrote:
> Be irq routing table definition, rtr_vendor:rtr_device should contain
> COMPATIBLE pci Interrupt Router, and rtr_bus & rtr_devfn - location of
> the actual device (pirq_router_dev). So,
> 1. Apparently, there is a bug in the BIOS - 586 & 686 are not compatible
> (different mapping)

Most likely. Unfortunately, this is the last released BIOS for this old board  AFAIK.

> 2. Does anybody know why compatible device is probed first, and actual
> one afterwards ? In other words, is swapping probes in the code above
> would give more correct behavior ?
>

This of course would fix my issue too...

> >This patch brings my board back to the correct behaviour
> >[Aleksey Gorelov CC'd for review/comments/suggestions]:
> >
> >--- linux-2.6.13-git4/arch/i386/pci/irq.c.org	2005-07-23
> >11:15:12.000000000 +0200
> >+++ linux-2.6.13-git4/arch/i386/pci/irq.c	2005-07-23
> >11:55:50.000000000 +0200
> >@@ -553,10 +553,12 @@
> > 	switch(device)
> > 	{
> > 		case PCI_DEVICE_ID_VIA_82C586_0:
> >-			r->name = "VIA";
> >-			r->get = pirq_via586_get;
> >-			r->set = pirq_via586_set;
> >-			return 1;
> >+			if (router->device==PCI_DEVICE_ID_VIA_82C586_0) {
> >+				r->name = "VIA";
> >+				r->get = pirq_via586_get;
> >+				r->set = pirq_via586_set;
> >+				return 1;
> >+			}
> > 		case PCI_DEVICE_ID_VIA_82C596:
> > 		case PCI_DEVICE_ID_VIA_82C686:
> > 		case PCI_DEVICE_ID_VIA_8231:
>
> Probably, comments on buggy BIOS would be nice here..
>
> Aleks.
>

Thanks,

Giancarlo
