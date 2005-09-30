Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVI3AYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVI3AYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVI3AYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:24:09 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:43533 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932407AbVI3AYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:24:07 -0400
Date: Fri, 30 Sep 2005 10:23:39 +1000
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: Robert.Olsson@data.slu.se, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20050930002339.GB21062@gondor.apana.org.au>
References: <200509292359.j8TNxuxD019838@rastaban.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509292359.j8TNxuxD019838@rastaban.cs.pdx.edu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 04:59:56PM -0700, Suzanne Wood wrote:
> Sorry to be thinking on-line, but if you mean this:
> 
>   if (in_dev = rcu_dereference(dev->ip_ptr))
> 
> I think that's fine.

Close.  What I had in mind is

	rcu_read_lock();
	in_dev = dev->ip_ptr;
	if (in_dev) {
		in_dev = rcu_dereference(in_dev);
		atomic_inc(&in_dev->refcnt);
	}
	rcu_read_unlock();
	return in_dev;

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
