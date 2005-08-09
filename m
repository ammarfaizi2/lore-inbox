Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVHIXYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVHIXYf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 19:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVHIXYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 19:24:35 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:2986 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932286AbVHIXYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 19:24:34 -0400
Subject: Re: [PATCH] Custom IORESOURCE Class
From: Matthew Gilbert <mgilbert@mvista.com>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Adam Belay <ambx1@neo.rr.com>, Greg KH <greg@kroah.com>,
       rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <7A8D4849-AE31-4F22-BA00-6C2B66CC833D@freescale.com>
References: <20050808231714.GB7276@neo.rr.com>
	 <7A8D4849-AE31-4F22-BA00-6C2B66CC833D@freescale.com>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 16:24:39 -0700
Message-Id: <1123629879.7951.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 23:23 -0500, Kumar Gala wrote:
> On Aug 8, 2005, at 6:17 PM, Adam Belay wrote:
> 
> > On Mon, Aug 08, 2005 at 09:00:21AM -0700, Greg KH wrote:
> >
> >> On Mon, Aug 08, 2005 at 11:11:45AM -0700, Matthew Gilbert wrote:
> >>
> >>> Below is a patch that adds an additional resource class to the
> >>>
> > platform
> >
> >>> resource types. This is to support additional resources that need to
> >>>
> > be passed
> >
> >>> to drivers without overloading the existing specific types. In my
> >>>
> > case, I need
> >
> >>> to send clock information to the driver to enable power management.
> >>>
> >>> Signed-off-by: Matthew Gilbert <mgilbert@mvista.com>
> >>>
> >>
> >> Hm, you do realize that Pat's no longer the driver core maintainer?
> >>
> > :)
> >
> >>
> >> Anyway, Russell and Adam, any objections to this patch?
> >>
> >
> > I'm not sure if I agree with this patch.  "struct resource" is used
> > primarily for
> > I/O resource assignment.  Although I agree we may need to add new
> > IORESOURCE types,
> > I'm not sure if clock data belongs here.  I don't think "start" and
> > "end" would be
> > useful for most platform data.  Could you provide more information  
> > about
> > this
> > specific issue and resource type?  Maybe we could create a new sysfs
> > attribute?
> 
> I would also like to understand more about what the need is here.  We  
> have clock data and such but use platform_data for it.

I am using IORESOURCE_MEM to pass in the base addresses of the necessary
clock registers. I also need to pass a fractional divider clk id. The
resource table seemed appropriate because the base addresses and the
divider id are closely related. Its also a great framework for enabling
varying resource lists. Currently I don't use this, but in the future I
may. Its possible in a future board revision there may not be a
fractional divider available. The resource framework makes querying for
the clk id very straight forward as opposed to magic values in a struct
I pass through platform_data. 

It can easily be moved to platform_data (or split between the two) if
that is more appropriate. Thanks for the feedback. _matt

