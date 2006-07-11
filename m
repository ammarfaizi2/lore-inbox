Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWGKXXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWGKXXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWGKXX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:23:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:10920 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932239AbWGKXXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:23:02 -0400
Date: Tue, 11 Jul 2006 16:15:37 -0700
From: Greg KH <greg@kroah.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: resource_size_t and printk()
Message-ID: <20060711231537.GC18973@kroah.com>
References: <44AAD59E.7010206@drzeus.cx> <20060704214508.GA23607@kroah.com> <44AB3DF7.8080107@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AB3DF7.8080107@drzeus.cx>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 06:20:07AM +0200, Pierre Ossman wrote:
> Greg KH wrote:
> > On Tue, Jul 04, 2006 at 10:54:54PM +0200, Pierre Ossman wrote:
> >   
> >> Hi there!
> >>
> >> Your commit b60ba8343b78b182c03cf239d4342785376c1ad1 has been causing me
> >> a bit of confusion and I thought I'd point out the problem so that you
> >> can resolve it. :)
> >>
> >> resource_size_t is not guaranteed to be a long long, but might be a u64
> >> or u32 depending on your .config. So you need an explicit cast in the
> >> printk:s or you get a lot of junk on the output.
> >>     
> >
> > That is exactly correct.  Is there somewhere in that patch that I forgot
> > to fix this up properly?
> >
> >   
> 
> In drivers/pnp/interface.c, theres a couple of these:
> 
> @@ -264,7 +264,7 @@ static ssize_t pnp_show_current_resource
>  			if (pnp_port_flags(dev, i) & IORESOURCE_DISABLED)
>  				pnp_printf(buffer," disabled\n");
>  			else
> -				pnp_printf(buffer," 0x%lx-0x%lx\n",
> +				pnp_printf(buffer," 0x%llx-0x%llx\n",
>  						pnp_port_start(dev, i),
>  						pnp_port_end(dev, i));
>  		}
> 

Good catch, care to create a patch to fix these?

thanks,

greg k-h
