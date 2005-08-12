Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVHLUm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVHLUm5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 16:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVHLUm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 16:42:57 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:41358 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751274AbVHLUm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 16:42:56 -0400
Date: Sat, 13 Aug 2005 00:42:51 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <greg@kroah.com>, ohnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org
Subject: Re: w1: more debug level decrease.
Message-ID: <20050812204251.GA15164@2ka.mipt.ru>
References: <20050812184622.GA19999@kroah.com.suse.lists.linux.kernel> <p737jeq3o8j.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <p737jeq3o8j.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 13 Aug 2005 00:42:51 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 10:16:12PM +0200, Andi Kleen (ak@suse.de) wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > Here's a patch for 2.6.13-rc6 to keep people's syslogs a bit nicer.
> 
> But why is this thing running every 10 seconds at all in the first place?
> Looks to me like you're just hiding the symptoms, not fixing the bug
> that makes this code run on unsuspecting systems.
> 
> e.g. one way would be to only probe once and then never again. 

Hmmm, why do you think it is a bug? :)

This bus does not have any kind of notiication, so w1 core 
searches for devices on this buses and prints when something is found
or not. Exactly because of this message people are unhappy.

> -Andi
> 
> > 
> > From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> > 
> > Do not spam syslog each 10 seconds when there is nothing on the wire.
> > 
> > Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > ---
> >  drivers/w1/w1.c |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- gregkh-2.6.orig/drivers/w1/w1.c	2005-08-02 13:41:30.000000000 -0700
> > +++ gregkh-2.6/drivers/w1/w1.c	2005-08-12 11:42:04.000000000 -0700
> > @@ -593,7 +593,7 @@
> >  		 * Return 0 - device(s) present, 1 - no devices present.
> >  		 */
> >  		if (w1_reset_bus(dev)) {
> > -			dev_info(&dev->dev, "No devices present on the wire.\n");
> > +			dev_dbg(&dev->dev, "No devices present on the wire.\n");
> >  			break;
> >  		}
> >  
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 
	Evgeniy Polyakov
