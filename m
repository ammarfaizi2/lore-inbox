Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274460AbRITNY5>; Thu, 20 Sep 2001 09:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274477AbRITNYr>; Thu, 20 Sep 2001 09:24:47 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:53255 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S274460AbRITNYn>; Thu, 20 Sep 2001 09:24:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jan Harkes <jaharkes@cs.cmu.edu>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] fix page aging (2.4.9-ac12)
Date: Thu, 20 Sep 2001 15:32:26 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0109191454570.8191-100000@imladris.rielhome.conectiva> <20010919143958.A1466@cs.cmu.edu>
In-Reply-To: <20010919143958.A1466@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010920132504Z16271-2758+295@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 19, 2001 08:40 pm, Jan Harkes wrote:
> On Wed, Sep 19, 2001 at 03:25:29PM -0300, Rik van Riel wrote:
> > No more mr. overcareful, obviously that doesn't work ;)
> 
> Finally ;)
> 
> >  static inline void age_page_down(struct page *page)
> >  {
> ...
> > +	unsigned long age = page->age;
> > +	if (age > 0)
> > +		age -= PAGE_AGE_DECL;
> > +	page->age = age;
> >  }
> 
> Perhaps the following would be better, just in case anyone sets
> PAGE_AGE_DECL to something other than 1.
> 
>     static inline void age_page_down(struct page *page)
>     {
> 	unsigned long age = page->age;
> 	if (age > PAGE_AGE_DECL)
> 		age -= PAGE_AGE_DECL;
> 	else
> 		age = 0;
> 	page->age = age;
>     }


     static inline void age_page_down(struct page *page)
     {
 	page->age = max((int) (age - PAGE_AGE_DECL), 0);
     }

;-)

--
Daniel
