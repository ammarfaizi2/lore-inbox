Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263407AbRFNRPR>; Thu, 14 Jun 2001 13:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263415AbRFNRPH>; Thu, 14 Jun 2001 13:15:07 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:21258 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263407AbRFNRPC>; Thu, 14 Jun 2001 13:15:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Avoid !__GFP_IO allocations to eat from memory reservations
Date: Thu, 14 Jun 2001 19:17:48 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20010614143441Z263016-17720+3764@vger.kernel.org>
In-Reply-To: <20010614143441Z263016-17720+3764@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01061419174808.00879@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 June 2001 14:59, Marcelo Tosatti wrote:
> --- linux/mm/page_alloc.c.orig	Thu Jun 14 11:00:14 2001
> +++ linux/mm/page_alloc.c	Thu Jun 14 11:32:56 2001
> @@ -453,6 +453,12 @@
>  				int progress = try_to_free_pages(gfp_mask);
>  				if (progress || gfp_mask & __GFP_IO)
>  					goto try_again;
> +				/*
> +				 * Fail in case no progress was made and the
> +				 * allocation may not be able to block on IO.
> +				 */
> +				else
> +					return NULL;
>  			}
>  		}
>  	}

Nitpick dept: the 'else' is redundant.

--
Daniel
