Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbVKYChe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbVKYChe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 21:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbVKYChe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 21:37:34 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:28688 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1161093AbVKYChd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 21:37:33 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: bcollins@debian.org (Ben Collins)
Subject: Re: [PATCH 2.6.15-rc2] Fxi hardcoded cpu=0 in workqueue for per_cpu_ptr() calls
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, rusty@rustcorp.com.au
Organization: Core
In-Reply-To: <20051124185419.GC20937@swissdisk.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EfTSr-0004DU-00@gondolin.me.apana.org.au>
Date: Fri, 25 Nov 2005 13:37:29 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> wrote:
> Tracked this down on an Ultra Enterprise 3000. It's a 6-way machine. Odd
> thing about this machine (and it's good for finding bugs like this) is
> that the CPU id's are not 0 based. For instance, on my machine the CPU's
> are 6/7/10/11/14/15.

Good catch.
 
> I changed the 0's to any_online_cpu(cpu_online_mask), which cpumask.h
> claims is "First cpu in mask". So this fits the same usage.

any_online_cpu(cpu_online_mask) is a bit of a tautology.  How about
first_cpu(cpu_online_mask)? In fact, I'd prefer a new macro altogether
which you can then define to zero on UP.

This patch raises an interesting question actually.  What happens
when the CPU that's designated to run single-threaded wq's gets
removed?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
