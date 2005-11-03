Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbVKCBvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVKCBvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbVKCBvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:51:07 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:42766 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030260AbVKCBvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:51:06 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Kris Katterjohn" <kjak@users.sourceforge.net>
Subject: Re: [PATCH] Merge __load_pointer() and load_pointer() in net/core/filter.c; kernel 2.6.14
Cc: jschlst@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net, acme@ghostprotocols.net, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <e626300280b94e0abc26defcc6043b91.kjak@ispwest.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EXUFJ-0006nP-00@gondolin.me.apana.org.au>
Date: Thu, 03 Nov 2005 12:50:29 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kris Katterjohn <kjak@ispwest.com> wrote:
> Another patch for net/core/filter.c by me. I merged __load_pointer() into
> load_pointer(). I don't see a point in having two seperate functions when
> both functions are really small and load_pointer() calls __load_pointer().
> Renamed the variable "k" to "offset" since that's what it is, and in
> skb_header_pointer() it's "offset".
> 
> This patch is a diff from kernel 2.6.14

This code path is performance-critical so you should benchmark your
changes.

In this particular case, __load_pointer is the unlikely case and
therefore it wasn't inlined.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
