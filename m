Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVIZV2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVIZV2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVIZV2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:28:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:12487 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932331AbVIZV2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:28:55 -0400
Subject: Re: update_mmu_cache(): fault or not fault ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050926.125203.132216841.davem@davemloft.net>
References: <1127715725.15882.43.camel@gaston>
	 <20050926.004123.47346085.davem@davemloft.net>
	 <1127721788.15882.64.camel@gaston>
	 <20050926.125203.132216841.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 07:28:10 +1000
Message-Id: <1127770090.15882.86.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 12:52 -0700, David S. Miller wrote:

> So this is a ton of complication, which is straightforwardly done in
> the TLB miss handler.  And if you think about it, since we've been
> writing the PTE entries and walking the page tables for fault
> processing, all of this will be hot in the L2 cache when we take
> the nearly immediate TLB miss.
> 
> Anyways, I'm very likely going to remove the prefilling of TLB entries
> on sparc64.  I hope it's more beneficial and less complicated for ppc64
> :-)

Ok, makes sense. On most ppc, things aren't pretty much equivalent on
real faults and pre-fill (except for masking interrupts which we have to
add to the pre-fill case). Anyway, best is to get real numbers with some
benchmarks, I'll see if I can get something from the 4xx folks.

Ben.


