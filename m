Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268073AbUGWVWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268073AbUGWVWj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268075AbUGWVWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:22:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:22671 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268073AbUGWVW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:22:28 -0400
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hlist_for_each_safe cleanup
References: <20040723140527.7e3c119a@dell_ss3.pdx.osdl.net>
From: Andreas Schwab <schwab@suse.de>
X-Yow: You mean now I can SHOOT YOU in the back and further BLUR
 th' distinction between FANTASY and REALITY?
Date: Fri, 23 Jul 2004 23:22:23 +0200
In-Reply-To: <20040723140527.7e3c119a@dell_ss3.pdx.osdl.net> (Stephen
 Hemminger's message of "Fri, 23 Jul 2004 14:05:27 -0700")
Message-ID: <jeoem65shc.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> writes:

> --- linux-2.6/include/linux/list.h	2004-07-23 09:36:18.000000000 -0700
> +++ tcp-2.6/include/linux/list.h	2004-07-23 11:43:25.000000000 -0700
> @@ -620,13 +620,12 @@
>  
>  #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
>  
> -/* Cannot easily do prefetch unfortunately */
>  #define hlist_for_each(pos, head) \
>  	for (pos = (head)->first; pos && ({ prefetch(pos->next); 1; }); \
>  	     pos = pos->next)
>  
>  #define hlist_for_each_safe(pos, n, head) \
> -	for (pos = (head)->first; n = pos ? pos->next : NULL, pos; \
> +	for (pos = (head)->first; pos && ({ n = pos->next; 1; }); \

What's wrong with using the comma operator instead of non-standard
statement expressions?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
