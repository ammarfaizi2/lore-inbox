Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUEQW7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUEQW7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUEQW7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:59:14 -0400
Received: from mail.kroah.org ([65.200.24.183]:32710 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263045AbUEQW7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:59:06 -0400
Date: Mon, 17 May 2004 15:58:16 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       james.bottomley@steeleye.com
Subject: Re: [PATCH] init. mca_bus_type even if !MCA_bus
Message-ID: <20040517225816.GA21333@kroah.com>
References: <20040517144603.1c63895f.rddunlap@osdl.org> <20040517151412.1f7fb7d4.akpm@osdl.org> <20040517150828.2d5afc1a.rddunlap@osdl.org> <20040517155222.11f4b253.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517155222.11f4b253.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 03:52:22PM -0700, Andrew Morton wrote:
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> >
> > On Mon, 17 May 2004 15:14:12 -0700 Andrew Morton wrote:
> > 
> > | "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> > | >
> > | > -	if(mca_system_init()) {
> > | > +	if (mca_system_init()) {
> > | >  		printk(KERN_ERR "MCA bus system initialisation failed\n");
> > | >  		return -ENODEV;
> > | >  	}
> > | >  
> > | > +	if (!MCA_bus)
> > | > +		return -ENODEV;
> > | 
> > | Why is it appropriate to register the MCA bus type when there is no
> > | MCA bus present?
> > 
> > Mostly because it was selected with CONFIG_MCA=y.
> > 
> > Another option (I think, need to test) is to check !MCA_bus
> > in drivers/mca/mca-legacy.c::find_mca_adapter(), so that
> > mca_bus_type isn't used when it shouldn't be.
> > 
> > Do you prefer that approach?
> 
> well my question really was a question, rather than a reimplementation
> suggestion.  If it _is_ appropriate that mca_bus_type be registered on a
> platform which is discovered to have no MCA hardware then fine.
> 
> Greg? James?  Any insights?

Ick, James is the one to answer here, as I remember this being pretty
messy at times due to the way the MCA code currently is...

thanks,

greg k-h
