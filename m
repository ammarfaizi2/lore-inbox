Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUHVIPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUHVIPH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 04:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUHVIPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 04:15:06 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:64272 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266538AbUHVIO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 04:14:59 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: nuno.silva@vgertech.com (Nuno Silva)
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0 to become free. Usage count = 1
Cc: linux-kernel@vger.kernel.org, master@sectorb.msk.ru, netdev@oss.sgi.com,
       kaber@trash.net
Organization: Core
In-Reply-To: <41280163.1050508@vgertech.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1BynUy-0007t1-00@gondolin.me.apana.org.au>
Date: Sun, 22 Aug 2004 18:14:44 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Silva <nuno.silva@vgertech.com> wrote:
> 
> The problem is in the QoS code. If I start ppp whithout the 

OK, this appears to be due to the changeset titled

[PKT_SCHED]: Refcount qdisc->dev for __qdisc_destroy rcu-callback

It adds a reference to dev.

I don't see any code that cleans up that reference when the dev goes
down.  So someone needs to add that similar to the code in net/core/dst.c.

Patrick, could you please have a look at this?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
