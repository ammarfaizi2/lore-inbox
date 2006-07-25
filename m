Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWGYVbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWGYVbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWGYVbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:31:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44486 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964867AbWGYVbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:31:47 -0400
Date: Tue, 25 Jul 2006 14:27:37 -0700
From: Greg KH <gregkh@suse.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060725212737.GB9513@suse.de>
References: <20060725203028.GA1270@kroah.com> <20060725210953.GA11405@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725210953.GA11405@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 01:09:53AM +0400, Alexey Dobriyan wrote:
> On Tue, Jul 25, 2006 at 01:30:28PM -0700, Greg KH wrote:
> > This adds the infrastructure for drivers to do a threaded probe.
> 
> > -			goto ProbeFailed;
> > +			goto probe_failed;
> >  		}
> >  	} else if (drv->probe) {
> >  		ret = drv->probe(dev);
> >  		if (ret) {
> >  			dev->driver = NULL;
> > -			goto ProbeFailed;
> > +			goto probe_failed;
> >  		}
> >  	}
> >  	device_bind_driver(dev);
> >  	ret = 1;
> >  	pr_debug("%s: Bound Device %s to Driver %s\n",
> >  		 drv->bus->name, dev->bus_id, drv->name);
> > -	goto Done;
> > +	goto done;
> >  
> > - ProbeFailed:
> > +probe_failed:
> >  	if (ret == -ENODEV || ret == -ENXIO) {
> >  		/* Driver matched, but didn't support device
> >  		 * or device not found.
> > @@ -110,7 +99,53 @@ int driver_probe_device(struct device_dr
> >  		       "%s: probe of %s failed with error %d\n",
> >  		       drv->name, dev->bus_id, ret);
> >  	}
> > - Done:
> > +done:
> 
> Removing these changes will make this patch smaller and do one thing. ;-)

Heh, yeah, it would, but cleaning up coding style violations at the same
time that I move code around is usually safe :)

thanks,

greg k-h
