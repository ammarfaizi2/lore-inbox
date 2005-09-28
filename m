Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbVI1C4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVI1C4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 22:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbVI1C4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 22:56:09 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:22288 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S965257AbVI1C4I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 22:56:08 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@davemloft.net (David S. Miller)
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Cc: suzannew@cs.pdx.edu, linux-kernel@vger.kernel.org,
       Robert.Olsson@data.slu.se, paulmck@us.ibm.com, walpole@cs.pdx.edu,
       netdev@oss.sgi.com
Organization: Core
In-Reply-To: <20050927.135626.88296134.davem@davemloft.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EKS6j-0006s4-00@gondolin.me.apana.org.au>
Date: Wed, 28 Sep 2005 12:55:45 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@davemloft.net> wrote:
> 
> I agree with the changes to add rcu_dereference() use.
> Those were definitely lacking and needed.

Actually I'm not so sure that they are all needed.  I only looked
at the very first one in the patch which is in in_dev_get().  That
one certainly isn't necessary because the old value of ip_ptr
is valid as long as the reference count does not hit zero.

The later is guaranteed by the increment in in_dev_get().

Because the pervasiveness of reference counting in the network stack,
I believe that we should scrutinise the other bits in the patch too
to make sure that they are all needed.

In general, using rcu_dereference/rcu_assign_pointer does not
guarantee correct code.  We really need to look at each case
individually.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
