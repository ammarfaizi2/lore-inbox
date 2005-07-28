Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVG1HB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVG1HB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 03:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVG1HBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 03:01:25 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:24294 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261323AbVG1G7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 02:59:33 -0400
Date: Thu, 28 Jul 2005 00:04:55 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Greg KH <greg@kroah.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050728070455.GF9985@gaz.sfgoth.com>
References: <20050726003018.GA24089@kroah.com> <9e47339105072517561f53b2f9@mail.gmail.com> <20050726015401.GA25015@kroah.com> <9e473391050725201553f3e8be@mail.gmail.com> <9e47339105072719057c833e62@mail.gmail.com> <20050728034610.GA12123@kroah.com> <9e473391050727205971b0aee@mail.gmail.com> <20050728040544.GA12476@kroah.com> <9e47339105072721495d3788a8@mail.gmail.com> <20050728054914.GA13904@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728054914.GA13904@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 28 Jul 2005 00:04:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> > +	/* locate trailng white space */
> > +	z = y = x;
> > +	while (y - buffer->page < count) {
> > +		y++;
> > +		z = y;
> > +		while (isspace(*y) && (y - buffer->page < count)) {
> > +			y++;
> > +		}
> > +	}
> > +	count = z - x;
> 
> Hm, I _think_ this works, but I need someone else to verify this...
> Anyone else?

It looks sane-ish to me, but also more complicated than need be.  Why can't
you just do something like:

	while (count > 0 && isspace(x[count - 1]))
		count--;

-Mitch
