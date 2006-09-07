Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWIGVIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWIGVIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 17:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWIGVIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 17:08:35 -0400
Received: from buick.jordet.net ([193.91.240.190]:25812 "EHLO buick.jordet.net")
	by vger.kernel.org with ESMTP id S1751424AbWIGVIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 17:08:34 -0400
Subject: Re: [NEW PATCH] VIA IRQ quirk behaviour change
From: Stian Jordet <liste@jordet.net>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Daniel Drake <dsd@gentoo.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org, jeff@garzik.org, greg@kroah.com, cw@f00f.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru
In-Reply-To: <1157629436.2369.7.camel@localhost.localdomain>
References: <20060906020429.6ECE67B40A0@zog.reactivated.net>
	 <44FE8EBA.4060104@jordet.net>  <44FCE36D.4000708@gentoo.org>
	 <1157557765.5091.1.camel@localhost.localdomain>
	 <44FF5E90.9030808@gentoo.org> <1157594442.4700.9.camel@localhost.portugal>
	 <44FF9656.1020309@gentoo.org>
	 <1157629436.2369.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 23:07:45 +0200
Message-Id: <1157663265.4075.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 07,.09.2006 kl. 12.43 +0100, skrev Sergio Monteiro Basto:
> the statment was write by Linus on http://lkml.org/lkml/2005/9/27/113
> my patch don't quirk any device if we are working on IO-APIC,
> Linus simply know if a interrupt is > 15 we are working on IO-APIC and
> just don't quirk irq > 15 
> 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c 
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -546,7 +546,10 @@ static void quirk_via_irq(struct pci_dev
> > >  {
> > >       u8 irq, new_irq;
> > >  
> > > -     new_irq = dev->irq & 0xf;
> > > +     new_irq = dev->irq;
> > > +     if (!new_irq || new_irq >= 15)
> > > +             return;
> > > +
> > >       pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
> > >       if (new_irq != irq) {

After a quick test tonight, this patch seems to work nicely for me. (I
know I told Linux that it didn't, don't know what's changed). Does this
fix the problems other people is having as well? If so, that would be
nice :)

Thanks.

-Stian

