Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbTI2UZw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 16:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264706AbTI2UZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 16:25:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22544 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264705AbTI2UZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 16:25:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] ULL fixes for qlogicfc
Date: 29 Sep 2003 13:25:20 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bla4fg$pbp$1@cesium.transmeta.com>
References: <E1A41Rq-0000NJ-00@hardwired> <20030929172329.GD6526@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030929172329.GD6526@gtf.org>
By author:    Jeff Garzik <jgarzik@pobox.com>
In newsgroup: linux.dev.kernel
>
> On Mon, Sep 29, 2003 at 06:04:34PM +0100, davej@redhat.com wrote:
> > diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/qlogicfc.c linux-2.5/drivers/scsi/qlogicfc.c
> > --- bk-linus/drivers/scsi/qlogicfc.c	2003-09-08 00:47:00.000000000 +0100
> > +++ linux-2.5/drivers/scsi/qlogicfc.c	2003-09-08 01:30:56.000000000 +0100
> > @@ -718,8 +718,8 @@ int isp2x00_detect(Scsi_Host_Template * 
> >  				continue;
> >  
> >  			/* Try to configure DMA attributes. */
> > -			if (pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff) &&
> > -			    pci_set_dma_mask(pdev, (u64) 0xffffffff))
> > +			if (pci_set_dma_mask(pdev, 0xffffffffffffffffULL) &&
> > +			    pci_set_dma_mask(pdev, 0xffffffffULL))
> >  					continue;
> 
> Looks great.
> 
> I wonder if you are motivated to create similar pci_set_dma_mask()
> cleanups for other drivers?  ;-)  Several other drivers need this same
> cleanup, too.
> 

Dumb question: why marking these explicitly as ULL instead of letting
the compiler do its usual promotion?

(By all means, remove the explicit cast -- the function call should do
this by itself.)

0xffffffff is unsigned int and will be promoted to
0x00000000ffffffffULL by the function call.  0xffffffffffffffff is UL
on 64-bit platforms and ULL on 32-bit platforms and will be promoted
to 0xffffffffffffffffULL by the function call.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
