Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbUCJVPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbUCJVO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:14:59 -0500
Received: from mail.kroah.org ([65.200.24.183]:49315 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262836AbUCJVOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:14:39 -0500
Date: Wed, 10 Mar 2004 13:12:38 -0800
From: Greg KH <greg@kroah.com>
To: Corey Minyard <minyard@acm.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Davis, Todd C" <todd.c.davis@intel.com>,
       sensors@stimpy.netroedge.com, "Simon G. Vogl" <simon@tk.uni-linz.ac.at>
Subject: Re: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
Message-ID: <20040310211238.GB21966@kroah.com>
References: <20040307223221.0f2db02e.akpm@osdl.org> <20040309013917.GH14833@fs.tum.de> <404F3BC3.2090906@acm.org> <20040310185105.GS14833@fs.tum.de> <20040310190648.GB18892@kroah.com> <404F7EF8.5020402@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404F7EF8.5020402@acm.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 02:47:52PM -0600, Corey Minyard wrote:
> Greg KH wrote:
> 
> >On Wed, Mar 10, 2004 at 07:51:05PM +0100, Adrian Bunk wrote:
> > 
> >
> >>On Wed, Mar 10, 2004 at 10:01:07AM -0600, Corey Minyard wrote:
> >>   
> >>
> >>>...
> >>>I have included a patch from Todd Davis at Intel that adds this function 
> >>>to the I2C driver.  I believe Todd has been working on getting this in 
> >>>through the I2C driver writers, although the patch is fairly 
> >>>non-intrusive.
> >>>
> >>>However, I have no real way to test this patch.
> >>>...
> >>>     
> >>>
> >>I can only confirm that it fixes the compilation...
> >>
> >>
> >>The patch to i2c-core.c is strange:
> >>   
> >>
> >
> >And dumb, and incorrect :(
> >
> > 
> >
> Wrong as in: "This code will not work" or wrong as in: "don't export the 
> variable and the function", or both?

Wrong as in "don't export the variable, the function, and on top of
that, not document what you are trying to do."

> I certainly agree that exporting both is wrong, there should really be
> two inline functions with only the variable exported, or only
> functions exported and the variable hidden.  That's an easy change.
> 
> However, if the code does not work, that is a bigger deal.  I'm fairly 
> sure it works in some cases, but not sure about all.
> 
> The patch I posted is for 2.6, BTW.

But you never sent it to the i2c maintainers, right?

I understand what you are trying to accomplish with this type of patch,
but if you _really_ need to make this kind of change, please change the
name to something that really stands out as being not the thing you ever
would want to do.

Something like:
	i2c_we_just_paniced_and_can_not_sleep_anymore()

thanks,

greg k-h
