Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVI2V33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVI2V33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVI2V33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:29:29 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:44556 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751334AbVI2V32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:29:28 -0400
Date: Fri, 30 Sep 2005 07:28:36 +1000
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: paulmck@us.ibm.com, Robert.Olsson@data.slu.se, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20050929212836.GA14323@gondor.apana.org.au>
References: <200509291602.j8TG2TuI015920@rastaban.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509291602.j8TG2TuI015920@rastaban.cs.pdx.edu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 09:02:29AM -0700, Suzanne Wood wrote:
> 
> The exchange below suggests that it is equally important 
> to have the rcu_dereference() in __in_dev_get(), so the 
> idea of the only difference between in_dev_get and 
> __in_dev_get being the refcnt may be accepted.

With __in_dev_get() it's the caller's responsibility to ensure
that RCU works correctly.  Therefore if any rcu_dereference is
needed it should be done by the caller.

Some callers of __in_dev_get() don't need rcu_dereference at all
because they're protected by the rtnl.

BTW, could you please move the rcu_dereference in in_dev_get()
into the if clause? The barrier is not needed when ip_ptr is
NULL.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
