Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262587AbREOAEH>; Mon, 14 May 2001 20:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbREOAD5>; Mon, 14 May 2001 20:03:57 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24075 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262588AbREOADs>; Mon, 14 May 2001 20:03:48 -0400
Date: Mon, 14 May 2001 19:25:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmscan.c fixes
In-Reply-To: <Pine.LNX.4.21.0105140335580.4671-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0105141922490.32493-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 May 2001, Rik van Riel wrote:

> Hi Linus,
> 
> the following patch does:


<snip>

>  	pg_data_t *pgdat = pgdat_list;
>  	int sum = 0;
>  	int freeable = nr_free_pages() + nr_inactive_clean_pages();
> +	/* XXX: dynamic free target is complicated and may be wrong... */
>  	int freetarget = freepages.high + inactive_target / 3;

I think its better if we just remove " + inactive_target / 3" here ---
callers already account for the inactive_target when trying to
calculate the free target anyway.

Example: 

static int refill_inactive(unsigned int gfp_mask, int user)
{
        int count, start_count, maxtry;

        count = inactive_shortage() + free_shortage();

...


