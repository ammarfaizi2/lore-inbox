Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274495AbRITNsH>; Thu, 20 Sep 2001 09:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274496AbRITNr6>; Thu, 20 Sep 2001 09:47:58 -0400
Received: from ns.ithnet.com ([217.64.64.10]:61967 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S274495AbRITNru>;
	Thu, 20 Sep 2001 09:47:50 -0400
Date: Thu, 20 Sep 2001 15:48:06 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Fw: Re: [PATCH] fix page aging (2.4.9-ac12)
Message-Id: <20010920154806.75d7da23.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001 15:32:26 +0200 Daniel Phillips <phillips@bonn-fries.net>
wrote:

> > Perhaps the following would be better, just in case anyone sets
> > PAGE_AGE_DECL to something other than 1.
> > 
> >     static inline void age_page_down(struct page *page)
> >     {
> > 	unsigned long age = page->age;
> > 	if (age > PAGE_AGE_DECL)
> > 		age -= PAGE_AGE_DECL;
> > 	else
> > 		age = 0;
> > 	page->age = age;
> >     }
> 
> 
>      static inline void age_page_down(struct page *page)
>      {
>  	page->age = max((int) (age - PAGE_AGE_DECL), 0);
>      }
> 
> ;-)

Aehm, Daniel. Just for a hint of what I know about C:

IF age is unsigned long (like declared above) and PAGE_AGE_DECL is a define,
then age-PAGE_AGE_DECL is of type unsigned long, which means it will not go
below 0 but instead be huge positive, so your cast (int) before will not do any
good, and you will not end up with 0 but somewhere above the clouds.
So you just made Linus' max/min/cast point of view _very_ clear, I guess it was
something like "people don't really think about using max/min and related
problems".

;-))

I guess you meant:

page->age = max(((int)age - (int)PAGE_AGE_DECL),0);

Written without actually caring about the real definition of PAGE_AGE_DECL.

Regards,
Stephan

PS: please anyone don't tell me what gnu c actually thinks about this, I don't
care, I read K&R.
And, of course, the whole thing is not worth discussing, it just hit me ...

