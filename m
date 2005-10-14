Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVJNNh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVJNNh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 09:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVJNNh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 09:37:27 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:4878 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750749AbVJNNh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 09:37:27 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: suzannew@cs.pdx.edu (Suzanne Wood)
Subject: Re: [RFC][PATCH] rcu in drivers/net/hamradio
Cc: linux-kernel@vger.kernel.org, g4klx@g4klx.demon.co.uk, hch@infradead.org,
       jreuter@yaina.de, paulmck@us.ibm.com, suzannew@cs.pdx.edu,
       walpole@cs.pdx.edu
Organization: Core
In-Reply-To: <200510140804.j9E84nwG026920@rastaban.cs.pdx.edu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EQPk5-0006dA-00@gondolin.me.apana.org.au>
Date: Fri, 14 Oct 2005 23:37:01 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suzanne Wood <suzannew@cs.pdx.edu> wrote:
>
> (1) bpq_new_device() calls list_add_rcu() labeled as 
> "list protected by RTNL."  The comment may need to go 
> since the only apparent rtnl_lock()/unlock() pair encloses 
> the call to bpq_free_device() in bpq_cleanup_driver()
> called upon module_exit().

The RTNL comment is correct actually.

bpq_new_device can only be called from bpq_device_event which
is called from a netdev event handler.  All netdev event handlers
must be called uner the RTNL.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
