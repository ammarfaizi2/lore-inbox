Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUGYJhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUGYJhI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 05:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUGYJhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 05:37:08 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:4879 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263769AbUGYJhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 05:37:05 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: shemminger@osdl.org (Stephen Hemminger)
Subject: Re: [PATCH] hlist_for_each_safe cleanup
Cc: schwab@suse.de, akpm@digeo.com, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20040723155614.2a63dc71@dell_ss3.pdx.osdl.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1BofMp-0005z4-00@gondolin.me.apana.org.au>
Date: Sun, 25 Jul 2004 19:32:27 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> wrote:
> On Fri, 23 Jul 2004 23:22:23 +0200
>
>> What's wrong with using the comma operator instead of non-standard
>> statement expressions?
> 
> It was more a case of consistency and avoiding the n = NULL assignment when pos
> is NULL.  
> 
> Look at hlist_for_each_entry_safe
> 
> #define hlist_for_each_entry_safe(tpos, pos, n, head, member)            \
>        for (pos = (head)->first;                                        \
>             pos && ({ n = pos->next; 1; }) &&                           \
>                ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
>             pos = n)
> 
> What's your problem with the gcc extensions, the kernel uses them all over the place,
> planning on starting a conversion?

Yes but a comma operator will achieve exactly the same thing and is
more concise:

pos && (n = pos->next, 1) &&

You could also write

pos && ((n = pos->next) || 1) &&

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
