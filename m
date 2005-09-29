Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVI2XbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVI2XbG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVI2XbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:31:06 -0400
Received: from lead.cat.pdx.edu ([131.252.208.91]:47599 "EHLO lead.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1751344AbVI2XbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:31:05 -0400
Date: Thu, 29 Sep 2005 16:30:28 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200509292330.j8TNUSmH019572@rastaban.cs.pdx.edu>
To: herbert@gondor.apana.org.au
Cc: Robert.Olsson@data.slu.se, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 30 Sep 2005 07:28:36 +1000
> From: Herbert Xu <herbert@gondor.apana.org.au>

> On Thu, Sep 29, 2005 at 09:02:29AM -0700, Suzanne Wood wrote:
> > 
> > The exchange below suggests that it is equally important 
> > to have the rcu_dereference() in __in_dev_get(), so the 
> > idea of the only difference between in_dev_get and 
> > __in_dev_get being the refcnt may be accepted.

> With __in_dev_get() it's the caller's responsibility to ensure
> that RCU works correctly.  Therefore if any rcu_dereference is
> needed it should be done by the caller.

This sounds reasonable to me.  Does everyone agree? 

> Some callers of __in_dev_get() don't need rcu_dereference at all
> because they're protected by the rtnl.

> BTW, could you please move the rcu_dereference in in_dev_get()
> into the if clause? The barrier is not needed when ip_ptr is
> NULL.

The trouble with that may be that there are three events, the
dereference, the assignment, and the conditional test.  The
rcu_dereference() is meant to assure deferred destruction
throughout.

Thank you very much for your suggestions.
