Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVA1WVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVA1WVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 17:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVA1WVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 17:21:35 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:48140 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262796AbVA1WVX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 17:21:23 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: wweissmann@gmx.at (Wilfried Weissmann)
Subject: Re: multiple neighbour cache tables for AF_INET
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       davem@davemloft.net, 282492@bugs.debian.org
Organization: Core
In-Reply-To: <24939.1106917237@www31.gmx.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CueSz-0000lz-00@gondolin.me.apana.org.au>
Date: Sat, 29 Jan 2005 09:19:49 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilfried Weissmann <wweissmann@gmx.at> wrote:
> 
> The kernels 2.4.28+ and 2.6.9+ with IPv4 and ATM-CLIP enabled have bugs in
> the neighbour cache code. neigh_delete() and neigh_add() only work properly
> if one cache table per address family exist. After ATM-CLIP installed a
> second cache table for AF_INET, neigh_delete() and neigh_add() only examine
> the first table (the ATM-CLIP table if IPv4 and ATM-CLIP are compiled into
> the kernel). neigh_dump_info() is also affected if the neigh_dump_table()
> call fails.

Indeed, this has been the case for a very long time.

IMHO you need to give the user a way to specify which table they want
to operate on.  If they don't specify one, then the current behaviour
of choosing the first table found is reasonble.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
