Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270641AbTG0AoR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 20:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270639AbTG0AoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 20:44:17 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:65410 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S270641AbTG0AoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 20:44:15 -0400
Date: Sat, 26 Jul 2003 20:29:23 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Daniele Bellucci <bellucda@tiscali.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: [PATCH] Get rid of __check_region in drivers/pnp/resource.c [2.6.0-test1][2.5.75-kj1]
Message-ID: <20030726202923.GA6160@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Daniele Bellucci <bellucda@tiscali.it>,
	linux-kernel@vger.kernel.org
References: <200307261806.41091.bellucda@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307261806.41091.bellucda@tiscali.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 06:06:41PM +0200, Daniele Bellucci wrote:
> 
> Hi Adam,
> could you double check this patch?
> 
> tnx.
> 
> 
> diff -urN 1.0/drivers/pnp/resource.c 1.1/drivers/pnp/resource.c
> --- 1.0/drivers/pnp/resource.c	2003-07-26 13:56:18.000000000 +0200
> +++ 1.1/drivers/pnp/resource.c	2003-07-26 14:05:30.000000000 +0200
> @@ -258,7 +258,9 @@
>  	/* check if the resource is already in use, skip if the
>  	 * device is active because it itself may be in use */
>  	if(!dev->active) {
> -		if (__check_region(&ioport_resource, *port, length(port,end)))
> +
> +		if (__request_region(&ioport_resource, *port, length(port,end),
> +				     dev->dev.name))
>  			return 0;
>  	}
>  
> 
> 
> 
> ----------  Forwarded Message  ----------
> 
> Subject: Re: [PATCH] Get rid of __check_region in drivers/pnp/resource.c 
[2.6.0-test1][2.5.75-kj1]> Date: Sat, 26 Jul 2003 11:50:40 -0400
> From: Greg KH <greg@kroah.com>
> To: Daniele Bellucci <bellucda@tiscali.it>
> Cc: kernel-janitor-discuss@lists.sourceforge.net
> 
> On Sat, Jul 26, 2003 at 02:10:15PM +0200, Daniele Bellucci wrote:
> > Hi all,
> > the following patch  compile and boot fine but i'm not sure if this is the
> > right fix.
> >
> > Please tellme if correct.
> 
> It doesn't look correct.  You should also cc: the pnp maintainer about
> this.
> 
> thanks,
> 
> greg k-h
> 
> -------------------------------------------------------
>

We only want to check if the resource is in use, not reserve it.  Therefore I 
see __check_region as being appropriate.  As long as it isn't printing a compile
warning, I'd prefer to leave it.  In this particular case it is not creating a 
race condition but for most cases it should be removed.

Also simply requesting the resource without releasing it will cause many of the
drivers that actually call request_region to fail.

Thanks,
Adam
