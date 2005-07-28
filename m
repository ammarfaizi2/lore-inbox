Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVG1TGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVG1TGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVG1TGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:06:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:61834 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261876AbVG1TEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:04:24 -0400
Date: Thu, 28 Jul 2005 12:03:53 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050728190352.GA29092@kroah.com>
References: <20050726015401.GA25015@kroah.com> <9e473391050725201553f3e8be@mail.gmail.com> <9e47339105072719057c833e62@mail.gmail.com> <20050728034610.GA12123@kroah.com> <9e473391050727205971b0aee@mail.gmail.com> <20050728040544.GA12476@kroah.com> <9e47339105072721495d3788a8@mail.gmail.com> <20050728054914.GA13904@kroah.com> <20050728070455.GF9985@gaz.sfgoth.com> <9e47339105072805545766f97d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105072805545766f97d@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 08:54:53AM -0400, Jon Smirl wrote:
> On 7/28/05, Mitchell Blank Jr <mitch@sfgoth.com> wrote:
> > Greg KH wrote:
> > > > +   /* locate trailng white space */
> > > > +   z = y = x;
> > > > +   while (y - buffer->page < count) {
> > > > +           y++;
> > > > +           z = y;
> > > > +           while (isspace(*y) && (y - buffer->page < count)) {
> > > > +                   y++;
> > > > +           }
> > > > +   }
> > > > +   count = z - x;
> > >
> > > Hm, I _think_ this works, but I need someone else to verify this...
> > > Anyone else?
> > 
> > It looks sane-ish to me, but also more complicated than need be.  Why can't
> > you just do something like:
> > 
> >         while (count > 0 && isspace(x[count - 1]))
> >                 count--;
> > 
> > -Mitch
> > 
> 
> Do we need to deal with UTF8 here? I did the forward loop because you
> can't parse UTF8 backwards. If UTF8 is possible I need to change the
> pointer inc function.

No, we don't need to handle UTF8.  Or if we do, then we better not make
a general filter function, as it will be a mess.

thanks,

greg k-h
