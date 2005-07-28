Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVG1My6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVG1My6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVG1My6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:54:58 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:18617 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261432AbVG1My5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:54:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GkdN8XesZpZBtFPZdP7E08hdHjVwus7XjRBIZNqdTlyh7j+22SNYArB21ZbASYw8uaQbAUdQH77bCyagWjwgxwWp7osy9qZ4IjMVpDp0yvzrKNvQW5gWE6Y6pYxPZJkVoglYWDPvrtIsh9oC0MVMueCrKzit88L3hLWqpVFwzoY=
Message-ID: <9e47339105072805545766f97d@mail.gmail.com>
Date: Thu, 28 Jul 2005 08:54:53 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: Greg KH <greg@kroah.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050728070455.GF9985@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050726003018.GA24089@kroah.com>
	 <20050726015401.GA25015@kroah.com>
	 <9e473391050725201553f3e8be@mail.gmail.com>
	 <9e47339105072719057c833e62@mail.gmail.com>
	 <20050728034610.GA12123@kroah.com>
	 <9e473391050727205971b0aee@mail.gmail.com>
	 <20050728040544.GA12476@kroah.com>
	 <9e47339105072721495d3788a8@mail.gmail.com>
	 <20050728054914.GA13904@kroah.com>
	 <20050728070455.GF9985@gaz.sfgoth.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, Mitchell Blank Jr <mitch@sfgoth.com> wrote:
> Greg KH wrote:
> > > +   /* locate trailng white space */
> > > +   z = y = x;
> > > +   while (y - buffer->page < count) {
> > > +           y++;
> > > +           z = y;
> > > +           while (isspace(*y) && (y - buffer->page < count)) {
> > > +                   y++;
> > > +           }
> > > +   }
> > > +   count = z - x;
> >
> > Hm, I _think_ this works, but I need someone else to verify this...
> > Anyone else?
> 
> It looks sane-ish to me, but also more complicated than need be.  Why can't
> you just do something like:
> 
>         while (count > 0 && isspace(x[count - 1]))
>                 count--;
> 
> -Mitch
> 

Do we need to deal with UTF8 here? I did the forward loop because you
can't parse UTF8 backwards. If UTF8 is possible I need to change the
pointer inc function.

-- 
Jon Smirl
jonsmirl@gmail.com
