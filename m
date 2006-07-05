Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWGENCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWGENCh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWGENCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:02:37 -0400
Received: from god.demon.nl ([83.160.164.11]:778 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S964838AbWGENCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:02:36 -0400
Date: Wed, 5 Jul 2006 15:02:31 +0200
From: Henk Vergonet <Henk.Vergonet@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Off by one in drivers/usb/input/yealink.c
Message-ID: <20060705130231.GA1259@god.dyndns.org>
References: <1151448080.16217.3.camel@alice> <20060627155143.b0e3e1dd.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627155143.b0e3e1dd.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the late response guys, but I was on holliday.

No no no, please dont use this.


On Tue, Jun 27, 2006 at 03:51:43PM -0700, Randy.Dunlap wrote:
> On Wed, 28 Jun 2006 00:41:19 +0200 Eric Sesterhenn wrote:
> > another off by one spotted by coverity (id #485),
> > we loop exactly one time too often
> > 
> > Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> > 
> > --- linux-2.6.17-git11/drivers/usb/input/yealink.c.orig	2006-06-28 00:29:46.000000000 +0200
> > +++ linux-2.6.17-git11/drivers/usb/input/yealink.c	2006-06-28 00:30:04.000000000 +0200
> > @@ -350,7 +350,7 @@ static int yealink_do_idle_tasks(struct 
> >  		val = yld->master.b[ix];
> >  		if (val != yld->copy.b[ix])
> >  			goto send_update;
> > -	} while (++ix < sizeof(yld->master));
> > +	} while (++ix < sizeof(yld->master)-1);

Apart from introducing a new bug in the code, the construct is ugly.

I would rather see then the more readable:

	ix++;
    } while (ix < sizeof(yld->master));
 
- Henk
