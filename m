Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUBWJVW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 04:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbUBWJVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 04:21:22 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:60583 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261889AbUBWJVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 04:21:19 -0500
Message-ID: <4039C609.7040307@cyberone.com.au>
Date: Mon, 23 Feb 2004 20:21:13 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<40395ACE.4030203@cyberone.com.au>	<20040222175507.558a5b3d.akpm@osdl.org>	<40396ACD.7090109@cyberone.com.au>	<40396DA7.70200@cyberone.com.au>	<4039B4E6.3050801@cyberone.com.au>	<4039BE41.1000804@cyberone.com.au> <20040223005948.10a3b325.akpm@osdl.org>
In-Reply-To: <20040223005948.10a3b325.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>
>>
>>Nick Piggin wrote:
>>
>>
>>>Humph. OK you're right.
>>>
>>
>>Aha but you've broken something!
>>
>
>I'm a microsoft spy.
>
>

Well their code is public domain now, so you needn't put in all
the good bits by yourself.

>>Tell me I'm still useful.
>>
>
>You're still useful.
>
>
>>diff -puN mm/vmscan.c~vm-fix-all_zones_ok mm/vmscan.c
>>--- linux-2.6/mm/vmscan.c~vm-fix-all_zones_ok	2004-02-23 19:44:06.000000000 +1100
>>+++ linux-2.6-npiggin/mm/vmscan.c	2004-02-23 19:45:10.000000000 +1100
>>@@ -1008,10 +1008,12 @@ static int balance_pgdat(pg_data_t *pgda
>> 
>> 			if (nr_pages)		/* Software suspend */
>> 				to_reclaim = min(to_free, SWAP_CLUSTER_MAX*8);
>>-			else			/* Zone balancing */
>>+			else {			/* Zone balancing */
>> 				to_reclaim = zone->reclaim_batch;
>>+				if (zone->pages_high < zone->free_pages)
>>+					all_zones_ok = 0;
>>+			}
>>
>
>I wouldna spotted that in a million years.  That all_zones_ok code was a
>bitch to test and really needs retesting.
>
>

all_zones_ok is actually now the only way you can really stop
scanning (yes, you eventually run out of priority).

I suspect you mean zone->all_unreclaimable?

