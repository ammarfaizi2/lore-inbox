Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVCXIdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVCXIdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 03:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVCXIcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 03:32:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:15004 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262765AbVCXIcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 03:32:21 -0500
Date: Thu, 24 Mar 2005 00:00:48 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Frank Sorenson <frank@tuxrocks.com>, LKML <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 0/5] I8K driver facelift
Message-ID: <20050324080048.GA13414@kroah.com>
References: <200502240110.16521.dtor_core@ameritech.net> <200503170140.49328.dtor_core@ameritech.net> <20050324072550.GL10604@kroah.com> <200503240239.32639.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503240239.32639.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 02:39:32AM -0500, Dmitry Torokhov wrote:
> On Thursday 24 March 2005 02:25, Greg KH wrote:
> > On Thu, Mar 17, 2005 at 01:40:48AM -0500, Dmitry Torokhov wrote:
> > > On Wednesday 16 March 2005 16:38, Frank Sorenson wrote:
> > > > Okay, I replaced the sysfs_ops with ops of my own, and now all the show
> > > > and store functions also accept the name of the attribute as a parameter.
> > > > This lets the functions know what attribute is being accessed, and allows
> > > > us to create attributes that share show and store functions, so things
> > > > don't need to be defined at compile time (I feel slightly evil!).
> > > 
> > > Hrm, can we be a little more explicit and not poke in the sysfs guts right
> > > in the driver? What do you think about the patch below athat implements
> > > "attribute arrays"? And I am attaching cumulative i8k patch using these
> > > arrays so they can be tested.
> > > 
> > > I am CC-ing Greg to see what he thinks about it.
> > 
> > Hm, I think it's proably of limited use, right?  What other code would
> > want this (the i2c sensor code doesn't, as it's naming scheme is
> > different.)
> >
> 
> Looking at their attributes they would benefit from arrays of goups of
> attributes... They have:
> 
> temp[1-4]_max
> temp[1-3]_min
> temp[1-3]_max_hyst
> 
> It could be:
> 
> temp/<n>/max
>          min
>          max_hyst
> 

Yeah, but then you break the userspace api that tools are already
expecting to see :(

thanks,

greg k-h
