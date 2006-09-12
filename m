Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWILHR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWILHR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWILHR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:17:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:10170 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751397AbWILHR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:17:56 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: jbarnes@virtuousgeek.org, alan@lxorguk.ukuu.org.uk, davem@davemloft.net,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org
In-Reply-To: <787b0d920609120009q7b7bf47dw9d320e838cf191a@mail.gmail.com>
References: <787b0d920609112130v2d855023ief2457942736ccfd@mail.gmail.com>
	 <1158039004.15465.62.camel@localhost.localdomain>
	 <787b0d920609112304x3342e3bek88a8e12da62adac4@mail.gmail.com>
	 <1158041558.15465.77.camel@localhost.localdomain>
	 <787b0d920609120009q7b7bf47dw9d320e838cf191a@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 17:17:00 +1000
Message-Id: <1158045420.15465.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If I see an io_to_io_barrier(), how am I to tell if it is
> read to read, write to write, read to write, write to read,
> read/write to read, read/write to write, read to read/write,
> write to read/write, or read/write to read/write?
> 
> Considering just reads and writes to MMIO, there are
> 9 possible types of fence. SPARC seems to cover a
> decent number of these distinctly; the instruction takes
> an immediate value as flags.

We need to decide wether a single one doing a full MMIO fence (and not
memory) is enough or if the performance different justifies maybe having
io_to_io_{wmb,rmb,mb}. I don't see any real use for more combinations.

David ? It's your call here. What do you think ?

Ben.


