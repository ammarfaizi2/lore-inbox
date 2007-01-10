Return-Path: <linux-kernel-owner+w=401wt.eu-S965250AbXAJXxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbXAJXxQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbXAJXxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:53:16 -0500
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:52882 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965250AbXAJXxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:53:15 -0500
Subject: Re: [PATCH 0/4] Improve swap page error handling
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <45A56989.3060209@yahoo.com.au>
References: <1168452294.5801.58.camel@localhost.localdomain>
	 <45A56989.3060209@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 23:52:55 +0000
Message-Id: <1168473175.14261.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-11 at 09:32 +1100, Nick Piggin wrote:
> Richard Purdie wrote: 
> > I think you were cc'd on some of it but you never commented. Anyhow,
> > I've reworked this patch series based on your comments. The hints were
> > appreciated, thanks. This was the way I'd originally hoped to be able to
> > work things, I just couldn't find the right way to do it.
> 
> IMO it seems a bit complex for so small a benefit. Last time I was
> working on this, I thought it would be almost as good to do something
> simple like stop trying to write out the page if PG_error is set (and
> clear that bit in delete_from_swap_cache or try_to_unusesomewhere).
> This way the admin could swapoff and scan the swap device at some
> point.

FWIW, the patches have got a lot less invasive and I was pleased with
the way the last set I posted worked out. 

1/4 is a lot of noise adding the page parameter to swap_free but doesn't
actually change much. 
2/4 is the guts of the solution in the form of two new functions. 
3/4 just hooks it in. 
4/4 is an optional cleanup.

I guess the key point for me is that the lack of proper handling of this
was bringing one of my systems to its knees due to IO loops before these
patches. Yes, there are ways to minimise the impact but why not fix it
properly? This proposal is certainly nowhere near as invasive as the
previous ones and since its got this far...

> > You can't proceed to do that until you're able to identify the bad pages
> > so this would be a necessary first step towards that, yes.
> 
> Agreed here, FWIW. I think that might be just as well done in
> userspace?

Maybe, I haven't made my mind up about that yet. I'd have to see how the
code looked I guess.

Cheers,

Richard

