Return-Path: <linux-kernel-owner+w=401wt.eu-S1750841AbWLLBeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWLLBeA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWLLBd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:33:59 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33345
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750838AbWLLBd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:33:58 -0500
Date: Mon, 11 Dec 2006 17:33:57 -0800 (PST)
Message-Id: <20061211.173357.92558541.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: kaber@trash.net, khc@pm.waw.pl, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: Broken commit: [NETFILTER]: ipt_REJECT: remove largely
 duplicate route_reverse function
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061201043755.GA13624@gondor.apana.org.au>
References: <20061129065146.GA20681@gondor.apana.org.au>
	<20061130.202206.25410613.davem@davemloft.net>
	<20061201043755.GA13624@gondor.apana.org.au>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 1 Dec 2006 15:37:55 +1100

> So in general when allocating packets we have two scenarios:
> 
> 1) The dst is known and fixed, i.e., all datagram protocols.  This is
> the easy case where the headroom is known exactly beforehand.
> 
> 2) The dst is unknown or may vary, this includes TCP, SCTP and DCCP.
> This is where we currently use MAX_HEADER plus some protocol-specific
> headroom.
> 
> Right now the normal (non-IPsec) dst output path always checks for
> sufficient headroom and reallocates if necessary (ip_finish_output2).
> I propose that we make IPsec do the same thing.

Agreed.

> For standard MTU-sized packets this discussion is moot since we have
> 2K of memory in each chunk.  However, for ACKs it could save a bit of
> memory.

For linear MTU-sized SKBs yes, but TCP data packets are going out %99
of the time with paged data these days and thus suffers from the same
set of issues and potential savings.
