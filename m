Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVI3AWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVI3AWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVI3AWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:22:19 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:41485 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932401AbVI3AWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:22:18 -0400
Date: Fri, 30 Sep 2005 10:21:44 +1000
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: Robert.Olsson@data.slu.se, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20050930002144.GA21062@gondor.apana.org.au>
References: <200509292330.j8TNUSmH019572@rastaban.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509292330.j8TNUSmH019572@rastaban.cs.pdx.edu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 04:30:28PM -0700, Suzanne Wood wrote:
> 
> > BTW, could you please move the rcu_dereference in in_dev_get()
> > into the if clause? The barrier is not needed when ip_ptr is
> > NULL.
> 
> The trouble with that may be that there are three events, the
> dereference, the assignment, and the conditional test.  The
> rcu_dereference() is meant to assure deferred destruction
> throughout.

The deferred destruction is guaranteed here by the reference count.
The only purpose served by rcu_dereference() in in_dev_get() is to
prevent the user from seeing pre-initialisation data.

When the pointer is NULL, you can't see any data at all, let alone
pre-initialisation data.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
