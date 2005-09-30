Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVI3BTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVI3BTv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVI3BTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:19:51 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:3086 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751397AbVI3BTu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:19:50 -0400
Date: Fri, 30 Sep 2005 11:19:07 +1000
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Suzanne Wood <suzannew@cs.pdx.edu>, Robert.Olsson@data.slu.se,
       davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20050930011907.GA21579@gondor.apana.org.au>
References: <200509292330.j8TNUSmH019572@rastaban.cs.pdx.edu> <20050930002346.GP8177@us.ibm.com> <20050930002719.GC21062@gondor.apana.org.au> <20050930003642.GQ8177@us.ibm.com> <20050930010404.GA21429@gondor.apana.org.au> <20050930011603.GT8177@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930011603.GT8177@us.ibm.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 06:16:03PM -0700, Paul E. McKenney wrote:
> 
> OK, how about this instead?
> 
> 	rcu_read_lock();
> 	in_dev = dev->ip_ptr;
> 	if (in_dev) {
> 		atomic_inc(&rcu_dereference(in_dev)->refcnt);
> 	}
> 	rcu_read_unlock();
> 	return in_dev;

Looks great.  Thanks Paul.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
