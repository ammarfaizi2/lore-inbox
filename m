Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbRERNxp>; Fri, 18 May 2001 09:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262318AbRERNxf>; Fri, 18 May 2001 09:53:35 -0400
Received: from wombat.educ.indiana.edu ([129.79.219.48]:59284 "EHLO
	wombat.educ.indiana.edu") by vger.kernel.org with ESMTP
	id <S262317AbRERNxW>; Fri, 18 May 2001 09:53:22 -0400
From: Brian Wheeler <bdwheele@wombat.educ.indiana.edu>
Message-Id: <200105181406.f4IE68E24125@wombat.educ.indiana.edu>
Subject: Re: LANANA: To Pending Device Number Registrants
To: tim@tjansen.de (Tim Jansen)
Date: Fri, 18 May 2001 09:06:08 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01051810241601.00782@cookie> from "Tim Jansen" at May 18, 2001 10:24:16 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thursday 17 May 2001 22:00, Brian Wheeler wrote:
> > Consider an ID consisting of:
> > 	* vendor
> > 	* model
> 
> Vendor and model ids are available for PCI and USB devices, but I think you 
> can not assume that all busses have them and you dont gain anything if you 
> keep them separate (unless you want to interpret the fields of the device id).
> In other words I would merge them into a single field.
> 

I could see that.  In some cases (ISA devices in particular), they'd probably
be blank all of the time, and would be taken out of the equation.


> > 	* serial number
> > 	* content-cookie
> > 	* topology-cookie
> 
> You need another field that contains a identifier for the bus or the scheme 
> of the device id, because different busses use different formats and you 
> cannot compare them.

Since topology-cookie would be opaque, it doesn't matter what bus its sitting
on....its either the same or its different.  As long as "pci bus 0, slot 1"
turns into the same cookie each time, and is always different than the 
"isa io=330" cookie then no problem.

> 
> You could also merge content-cookie and serial number because you will always 
> to interpret them together. 

Not necessarily, from other posts, serial number may or may not be unique.

All of the fields would probably be interpreted at the same time, but keeping
them separate would handle 'odd' cases that we've not thought of at this point.


> 
> >   I suppose these ID fields could also be used by a userspace tool to
> >   load/unload drivers as necessary.
> 
> There is a problem with that idea: you often cannot generate the device id 
> before the driver is available. Things like the content cookie and the serial 
> number must be created by the driver, at least in some cases. For example a 
> PCI ethernet card has a great serial number, its hardware address, but you 
> can only get it after the driver has been loaded.

Hmm.  True.  However, most of the other fields (Vendor/model, topology) would
be available before the driver is loaded.  Shouldn't that be enough to figure
which driver to use?  Of course, ISA devices cause problems here...come to
think of it, ISA devices cause problems no matter what we do :)

Brian
