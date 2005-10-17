Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVJQJbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVJQJbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVJQJbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:31:48 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:27251
	"EHLO x30.random") by vger.kernel.org with ESMTP id S932227AbVJQJbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:31:47 -0400
Date: Mon, 17 Oct 2005 13:28:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: "David S. Miller" <davem@davemloft.net>, herbert@gondor.apana.org.au,
       nickpiggin@yahoo.com.au, benh@kernel.crashing.org, hugh@veritas.com,
       paulus@samba.org, anton@samba.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible memory ordering bug in page reclaim?
Message-ID: <20051017112858.GA14775@x30.random>
References: <20051015180018.GN18159@opteron.random> <20051015194855.GA1164@gondor.apana.org.au> <20051015200701.GP18159@opteron.random> <20051015.160702.128767261.davem@davemloft.net> <20051016233600.A13487@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051016233600.A13487@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2005 at 11:36:00PM +0400, Ivan Kokshaysky wrote:
> Note that superfluous mb's around atomic stuff still can hurt -
> Alpha mb instruction also flushes IO write buffers, so it can
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

That's what needed to implement the wmb on alpha, this is why mb is
needed there and we need to add it at the top as well to comply with
docs (and especially for atomic_dec_and_test kind of usage like Dave
said).

Ivan I assume you'll take care of fixing it, thanks!
