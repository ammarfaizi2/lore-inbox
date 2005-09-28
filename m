Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVI1WLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVI1WLy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVI1WLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:11:54 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:10502 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751120AbVI1WLx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:11:53 -0400
Date: Thu, 29 Sep 2005 08:11:10 +1000
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, suzannew@cs.pdx.edu,
       linux-kernel@vger.kernel.org, Robert.Olsson@data.slu.se,
       walpole@cs.pdx.edu, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20050928221110.GA22018@gondor.apana.org.au>
References: <20050927.135626.88296134.davem@davemloft.net> <E1EKS6j-0006s4-00@gondolin.me.apana.org.au> <20050928145110.GA4925@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928145110.GA4925@us.ibm.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 07:51:10AM -0700, Paul E. McKenney wrote:
> 
> The reference-count approach is only guaranteed to work if the kernel
> thread that did the reference-count increment is later referencing that
> same data element.  Otherwise, one has the following possible situation
> on DEC Alpha:

You're quite right.  Without the rcu_dereference users of in_dev_get()
may see pre-initialisation contents of in_dev.

So these barriers are definitely needed.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
