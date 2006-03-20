Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWCTLlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWCTLlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWCTLlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:41:52 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:27737 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750782AbWCTLlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:41:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1+O4nMzN5Pu98hei5oPZOHZyeQL2mH3qtEsL+a6MUMichpNJiCSZ3nvwUZqxAy4jvSV5bxlCiSuA2kYFm3nTwRf/vzSmxr0ENuQ2BZuwskr/jDPPMCNoxcC/nMlBpSPg4AC2AmCsiSB8/nrOpyLOcYWaG2NeXiyTd84TTJZuzLA=  ;
Message-ID: <441E94FA.8070408@yahoo.com.au>
Date: Mon, 20 Mar 2006 22:41:46 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Rafael Wysocki <rjw@sisk.pl>,
       Pavel Machek <pavel@ucw.cz>, linux-mm@kvack.org
Subject: Re: [PATCH][1/3] mm: swsusp shrink_all_memory tweaks
References: <200603200231.50666.kernel@kolivas.org>
In-Reply-To: <200603200231.50666.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> - 
> +
> +#define for_each_priority_reverse(priority)	\
> +	for (priority = DEF_PRIORITY;		\
> +		priority >= 0;			\
> +		priority--)
> +
>  /*
>   * This is the main entry point to direct page reclaim.
>   *
> @@ -979,7 +1010,7 @@ unsigned long try_to_free_pages(struct z
>  		lru_pages += zone->nr_active + zone->nr_inactive;
>  	}
>  
> -	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
> +	for_each_priority_reverse(priority) {
>  		sc.nr_mapped = read_page_state(nr_mapped);
>  		sc.nr_scanned = 0;
>  		if (!priority)

I still don't like this change. Apart from being harder to read in
my opinion, I don't believe there is a precedent for "consolidating"
simple for loops in the kernel, is there?

More complex loops get helpers, but they're made part of the wider
well-known kernel API.

Why does for_each_priority_reverse blow up when you pass it an unsigned
argument? What range has priority? What direction does the loop go in?
(_reverse postfix doesn't tell me, because it is going from low->high
priority so I would have thought that is going forward, or up)

You had to look in two places each time you wanted to know the answers.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
