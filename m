Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269639AbUJLLcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbUJLLcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269627AbUJLLci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:32:38 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:948 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269639AbUJLLcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:32:23 -0400
Message-ID: <416BBF48.4070102@yahoo.com.au>
Date: Tue, 12 Oct 2004 21:26:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: "Ronny V. Vindenes" <s864@ii.uib.no>
CC: Jens Axboe <axboe@suse.de>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: CFQ v2 high cpu load fix(?)
References: <1097579760.4086.27.camel@tentacle125.gozu.lan>
In-Reply-To: <1097579760.4086.27.camel@tentacle125.gozu.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronny V. Vindenes wrote:
> CFQ v2 is much better in a lot of cases, but certain situations trigger
> a cpu load so high it starves the rest of the system thus completely
> ruining the interactive experience. While casually looking at the
> problem, I stumbled upon a patch by Arjan van de Ven sent to lkml on
> sept. 1 (Subject: block fixes). Part of it is already included in the
> CFQ v2 patches and after applying the rest[1] I'm no longer able to
> trigger the problem.
> 
> [1] Patch attached against 2.6.9-rc4-ck1 but applies to rc4-mm1 with
> some minor fuzz.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> --- patches/linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c	2004-10-12 12:25:09.798003278 +0200
> +++ linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c	2004-10-12 12:25:42.959479479 +0200
> @@ -100,7 +100,7 @@
>  		nr = q->nr_requests;
>  	q->nr_congestion_on = nr;
>  
> -	nr = q->nr_requests - (q->nr_requests / 8) - 1;
> +	nr = q->nr_requests - (q->nr_requests / 8) - (q->nr_requests/16)- 1;
>  	if (nr < 1)
>  		nr = 1;
>  	q->nr_congestion_off = nr;


I thought this first hunk looked like a good idea when Arjan sent the
patch. Can you check if it alone helps your problem?

The second hunk should be basically a noop.
