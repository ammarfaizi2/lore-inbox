Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265016AbTFVNwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 09:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbTFVNwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 09:52:21 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:14232 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S265016AbTFVNwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 09:52:20 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Isapnp warning
Date: Sun, 22 Jun 2003 16:07:14 +0200
User-Agent: KMail/1.5.2
Cc: Linus Torvalds <torvalds@transmeta.com>, perex@suse.cz,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200306151836.h5FIaqv2008285@callisto.of.borg> <1056198688.25975.25.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1056198688.25975.25.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306221607.15232.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Saturday 21 June 2003 14:31, Alan Cox wrote:
> On Sul, 2003-06-15 at 19:36, Geert Uytterhoeven wrote:
> > Isapnp: Kill warning if CONFIG_PCI is not set
> >
> > --- linux-2.5.x/drivers/pnp/resource.c	Tue May 27 19:03:04 2003
> > +++ linux-m68k-2.5.x/drivers/pnp/resource.c	Sun Jun  8 13:31:20 2003
> > @@ -97,7 +97,9 @@
> >
> >  int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data)
> >  {
> > +#ifdef CONFIG_PCI
> >  	int i;
> > +#endif
>
> This is far uglier than te warning

How about:

   #define if_pci(tokens...) tokens

   int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data)
   {
	if_pci(int i);
	...
   }

Admittedly uglier than just having the warning disabled by default.

Regards,

Daniel

