Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965220AbWILAvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbWILAvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 20:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWILAvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 20:51:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:37814 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965220AbWILAvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 20:51:23 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: segher@kernel.crashing.org, jbarnes@virtuousgeek.org, jeff@garzik.org,
       paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20060911.173208.74750403.davem@davemloft.net>
References: <D680AFCF-11EC-48AD-BBC2-B92521DF442A@kernel.crashing.org>
	 <20060911.062144.74719116.davem@davemloft.net>
	 <8DA3BCBF-0F19-4CF0-B22E-91E57E7CB033@kernel.crashing.org>
	 <20060911.173208.74750403.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 10:49:07 +1000
Message-Id: <1158022147.15465.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's silly because if you just use different interface
> names for the different semantics, the caller can
> ask for what he wants at the call site and no conditionals
> are needed in the implementation.

As Paulus also pointed out, having writel() behave differently based on
some magic done earlier at map time makes it harder to understand what
happens when reading the code, and thus harder to audit drivers for
missing barriers etc... since it's not obvious at first sight wether a
driver is using ordered or relaxed semantics. Thus I prefer keeping two
speparate interfaces.

We've come up with the __writel() name, but I'm open to proposals for
something nicer :)

Ben.

