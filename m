Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWIKBE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWIKBE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 21:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWIKBE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 21:04:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:16546 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750731AbWIKBEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 21:04:25 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200609101734.06839.jbarnes@virtuousgeek.org>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <0F623199-9152-46B3-8CC3-6FFCDD8AF705@kernel.crashing.org>
	 <1157933531.31071.274.camel@localhost.localdomain>
	 <200609101734.06839.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 11:04:04 +1000
Message-Id: <1157936644.31071.286.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If we go this route though, can I request that we don't introduce any 
> performance regressions in drivers currently using mmiowb()?  I.e. 
> they'll be converted over to the new accessor routines when they become 
> available along with the new barrier macros?

There are few enough of them, I've grep'ed, so that should be doable.
The segher mentioned in favor of his approach (option B -> ioremap
flags) that doing a test in writeX/readX is very cheap compared to the
cost of IOs in general and would make driver conversion easier: you
don't have to change a single occurence of writel/readl : just add the
necessary barriers and change the ioremap call. Thus I tend to agree
that his approach makes it easier from a driver writer point of view.

Now, I don't have a strong preference myself, which is why I asked for a
vote here. So far, I could your vote for A :)

Ben.


