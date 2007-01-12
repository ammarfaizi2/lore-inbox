Return-Path: <linux-kernel-owner+w=401wt.eu-S1750713AbXALOAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbXALOAe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 09:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbXALOAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 09:00:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:27334 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbXALOAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 09:00:33 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VmaRhThkb1q36ddmOAgydZh67BFf+D31U8QOhIW5MBqP44t4qpHK1vqqi3er88IQOlgHpzcip+rrDFdXWdTL7vPWZ44WasW3lvZZDMzrDmKVYUKdOozbuFtWsBEokWr6gBymhPrS1r1z0FlT306lIO919psX3moOpG+QIi4Yye8=
Message-ID: <58cb370e0701120600pc65b237w4865c9637fc1b6e6@mail.gmail.com>
Date: Fri, 12 Jan 2007 15:00:30 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 18/19] ide: add ide_use_fast_pio() helper
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20070112100836.58738dbc@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	 <20070112042800.28794.95095.sendpatchset@localhost.localdomain>
	 <20070112100836.58738dbc@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> On Fri, 12 Jan 2007 05:28:00 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> > [PATCH] ide: add ide_use_fast_pio() helper
> >
> > * add ide_use_fast_pio() helper for use by host drivers
> > * add DMA capability and autodma checks to ide_use_dma()
> >   - au1xxx-ide/it8213/it821x drivers didn't check for (id->capability & 1)
>
> For the IT8211/2 in SMART this check shouldn't be made.

It is OK since in it821x_fixups() we set it explicitly:

		if(strstr(id->model, "Integrated Technology Express")) {
			/* In raid mode the ident block is slightly buggy
			   We need to set the bits so that the IDE layer knows
			   LBA28. LBA48 and DMA ar valid */
			id->capability |= 3;		/* LBA28, DMA */

and we are better off using generic helper if we can
(which may later allow us to use generic tuning code).

> >   - ide-cris driver didn't set ->autodma
>
> You've changed the behaviour there. Should the default be autodma=0 ?

Before my patch hwif->autodma was only checked in the chipset specific
hwif->ide_dma_check implementations.  For ide-cris it is
cris_dma_check()
function so there no behavior change here.

Sorry for not explaining changes in detail in the patch description
(I will update it).

Bart
