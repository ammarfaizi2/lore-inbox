Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVGNTbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVGNTbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbVGNTbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:31:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:48600 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263086AbVGNTbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:31:13 -0400
Date: Thu, 14 Jul 2005 12:30:49 -0700
From: Greg KH <greg@kroah.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Adam Belay <abelay@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] split PCI probing code [1/9]
Message-ID: <20050714193049.GA31595@kroah.com>
References: <1121331304.3398.89.camel@localhost.localdomain> <20050714171014.GA16069@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714171014.GA16069@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 07:10:14PM +0200, Francois Romieu wrote:
> Adam Belay <abelay@novell.com> :
> [...]
> 
> Some nits + a suspect error branch. It seems nice otherwise.

If I'm correct, this patch only moves the code into different files, it
doesn't change any of it, so your comments apply to the current code
today, not Adam's changes :)

> > --- a/drivers/pci/bus/bus.c	1969-12-31 19:00:00.000000000 -0500
> > +++ b/drivers/pci/bus/bus.c	2005-07-10 22:32:53.000000000 -0400
> [...]
> > +struct pci_bus * pci_alloc_bus(void)
> > +{
> > +	struct pci_bus *b;
> > +
> > +	b = kmalloc(sizeof(*b), GFP_KERNEL);
> > +	if (b) {
> > +		memset(b, 0, sizeof(*b));
> 
> mm/slab.c provides kcalloc.

Ick, I hate that function call, this is nicer :)

thanks,

greg k-h
