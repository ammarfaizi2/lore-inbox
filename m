Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVCWJvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVCWJvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVCWJvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:51:04 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:45833 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261233AbVCWJu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:50:57 -0500
Date: Wed, 23 Mar 2005 20:49:54 +1100
To: Ingo Molnar <mingo@elte.hu>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org, simlo@phys.au.dk
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050323094954.GA14052@gondor.apana.org.au>
References: <20050323063317.GB31626@elte.hu> <E1DE2JX-0003cP-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DE2JX-0003cP-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 08:38:11PM +1100, Herbert Xu wrote:
>
> > ok. It's enough to put a barrier into the else branch here, because the
> > atomic op in the main brain is a barrier by itself.
> 
> Since the else branch is only taken when rcu_read_lock_nesting > 0, do
> we need the barrier at all?

Actually, since atomic_inc isn't a barrier, we do need that mb.
However, it should only be necessary in the main branch and we
can use smp_mb__after_atomic_inc which is optimised away on a
number of architectures (i386 in particular).

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
