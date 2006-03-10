Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752127AbWCJAfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbWCJAfd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbWCJAfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:35:33 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:29851
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1752127AbWCJAfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:32 -0500
Date: Thu, 9 Mar 2006 16:35:13 -0800
From: Greg KH <gregkh@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20] ipath - sysfs support for core driver)
Message-ID: <20060310003513.GA17050@suse.de>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain> <adapskvfbqe.fsf@cisco.com> <1141947143.10693.40.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141947143.10693.40.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 03:32:23PM -0800, Bryan O'Sullivan wrote:
> On Thu, 2006-03-09 at 15:18 -0800, Roland Dreier wrote:
> >  > +static ssize_t show_atomic_stats(struct device_driver *dev, char *buf)
> >  > +{
> >  > +	memcpy(buf, &ipath_stats, sizeof(ipath_stats));
> >  > +
> >  > +	return sizeof(ipath_stats);
> >  > +}
> > 
> > I think putting a whole binary struct in a sysfs attribute is
> > considered a no-no.
> 
> Grumble.

Grumble?  Oh come on, don't export binary structures through sysfs, it's
in the DOCUMENTATION THAT SYSFS IS FOR TEXT FILES ONLY!!!!

If you don't want to export a text file, then use something else other
than sysfs, it's that simple.

> it's a fairly small struct, much less than a page in length,
> and userspace needs an atomic view of it, instead of reading each of the
> umpteen broken-out files that we also provide for humean-readable access
> to each counter.
> 
> I didn't see any point to implementing the sysfs binary file interface
> in order to do exactly what this 6-line function does.  Still don't, in
> fact :-)

sysfs binary files are for PASS-THROUGH things ONLY!  stuff like this is
NOT for sysfs binary files, so even if you switched to using it, it
would not be allowed.

And if I sound grumpy about this whole thing, I am.  I'm tired of people
trying to abuse sysfs and putting crappy userspace APIs in it.  They
don't realize how messy it causes things to be over the long run.  If
you want to make your own filesystem to export stuff in whatever way you
want, feel free to do so (only takes about 200 lines including comments
to do so.)  But DO NOT ABUSE SYSFS just because you don't happen to
agree with the way it was designed, or feel inconvienced by it.

Ok, here's a new rule to help this from happening again in the future:

  If you want to add a new sysfs file to the kernel, it MUST be
  accompanied with full documentation that explains exactly what that
  file contains and what it is for.  No exceptions will be allowed.

Structure for this documentation will be in the format that I layed out
last week, I'll update it again and post it to lkml for review later
tonight.

thanks,

greg k-h
