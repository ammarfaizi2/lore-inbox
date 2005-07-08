Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVGHV35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVGHV35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbVGHV2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:28:32 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:14509 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261663AbVGHV1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:27:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=lGD5RArgLO5+RfOiCb4EOSgpZqOpA5BhF1Luonkq6PN31BXRf56UpuIppcnqkohcOL3ILi8rP/iQo5F2Cp+WUa207p1uRwaGg2DBftZhlJdaphVB1vN3kn8xEL7bLKYFhnczH++Cy5Bl8LFgx11RynOL2b+o3gfBjJjU23suOZQ=
Subject: Re: [ck] Re: 2.6.12-ck3
From: Kerin Millar <kerframil@gmail.com>
To: Rudo Thomas <rudo@matfyz.cz>
Cc: Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050708202753.GA32317@ss1000.ms.mff.cuni.cz>
References: <200506301241.00593.kernel@kolivas.org>
	 <20050704091648.GA14759@ss1000.ms.mff.cuni.cz>
	 <20050707213034.GA9306@ss1000.ms.mff.cuni.cz>
	 <200507081352.55660.kernel@kolivas.org>
	 <20050708202753.GA32317@ss1000.ms.mff.cuni.cz>
Content-Type: text/plain
Date: Fri, 08 Jul 2005 22:31:20 +0100
Message-Id: <1120858280.22079.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-08 at 22:27 +0200, Rudo Thomas wrote:
> > > > Time seems to pass very fast with this kernel.
> > >
> > > Am I the only one who gets this strange behaviour? Kernel's notion of
> > > time seems to be about 30 times faster than real time.
> > 
> > Sorry I really have no idea. If you can retest with latest stable mainline 
> > that this kernel is based on (2.6.12.2) and reproduce the problem
> 
> The following one-liner (from 2.6.12.2) seems to be the problem:
> 
> diff -urN linux-2.6.12-ck2-rudo/drivers/acpi/pci_irq.c linux-2.6.12-ck-rudo/drivers/acpi/pci_irq.c
> --- linux-2.6.12-ck2-rudo/drivers/acpi/pci_irq.c        2005-07-08 10:16:53.000000000 +0200
> +++ linux-2.6.12-ck-rudo/drivers/acpi/pci_irq.c 2005-07-03 21:06:10.000000000 +0200
> @@ -435,6 +435,7 @@
>                 /* Interrupt Line values above 0xF are forbidden */
>                 if (dev->irq >= 0 && (dev->irq <= 0xF)) {
>                         printk(" - using IRQ %d\n", dev->irq);
> +                       acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
>                         return_VALUE(0);
>                 }
>                 else {
> 

Hi, could you try the following patch please?

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=44f8e1a20cf3afe10a3744bd9317808a39a242bb

Cheers,

--Kerin Millar

