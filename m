Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274484AbRITNc1>; Thu, 20 Sep 2001 09:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274482AbRITNcH>; Thu, 20 Sep 2001 09:32:07 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:60304 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S274481AbRITNbz>;
	Thu, 20 Sep 2001 09:31:55 -0400
Date: Thu, 20 Sep 2001 15:31:05 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Jan Harkes <jaharkes@cs.cmu.edu>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix page aging (2.4.9-ac12)
In-Reply-To: <20010920132504Z16271-2758+295@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0109201529280.16139-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Daniel Phillips wrote:

[snip]
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
                               ^^^
>      }

static inline void age_page_down(struct page *page)
{
	page->age = max((int) (page->age - PAGE_AGE_DECL), 0);
}


/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

