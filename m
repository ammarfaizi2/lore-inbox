Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274134AbRISSkc>; Wed, 19 Sep 2001 14:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274135AbRISSkM>; Wed, 19 Sep 2001 14:40:12 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:12679 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S274134AbRISSkG>; Wed, 19 Sep 2001 14:40:06 -0400
Date: Wed, 19 Sep 2001 14:40:00 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix page aging (2.4.9-ac12)
Message-ID: <20010919143958.A1466@cs.cmu.edu>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0109191454570.8191-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109191454570.8191-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 03:25:29PM -0300, Rik van Riel wrote:
> No more mr. overcareful, obviously that doesn't work ;)

Finally ;)

>  static inline void age_page_down(struct page *page)
>  {
...
> +	unsigned long age = page->age;
> +	if (age > 0)
> +		age -= PAGE_AGE_DECL;
> +	page->age = age;
>  }

Perhaps the following would be better, just in case anyone sets
PAGE_AGE_DECL to something other than 1.

    static inline void age_page_down(struct page *page)
    {
	unsigned long age = page->age;
	if (age > PAGE_AGE_DECL)
		age -= PAGE_AGE_DECL;
	else
		age = 0;
	page->age = age;
    }

Jan

