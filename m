Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUFJXh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUFJXh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 19:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUFJXhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 19:37:25 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:7442 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263413AbUFJXhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 19:37:23 -0400
Date: Fri, 11 Jun 2004 09:37:07 +1000
To: Pavel Machek <pavel@suse.cz>
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: Fix memory leak in swsusp
Message-ID: <20040610233707.GA4741@gondor.apana.org.au>
References: <20040609130451.GA23107@elf.ucw.cz> <E1BYN8O-0008Vg-00@gondolin.me.apana.org.au> <20040610105629.GA367@gondor.apana.org.au> <20040610212448.GD6634@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610212448.GD6634@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 11:24:48PM +0200, Pavel Machek wrote:
> > > @@ -803,32 +804,31 @@
> > >  		return 0;
> > >  	}
> > >  
> > > +	err = -ENOMEM;
> > >  	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
> > >  		memset(m, 0, PAGE_SIZE);
> > 
> > BTW, what does this memset do?
> 
> Here's incremental fix, it compiles but not tested.

Thanks, but my question remains: why do we need the memset?  The
area allocated is either thrown away because it collides or is
overwritten with the pagedir stuff straight away.

> BTW I have problems getting mail to you:

Sorry, that should be fixed now.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
