Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbWILAb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbWILAb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 20:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbWILAb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 20:31:27 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17834
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965208AbWILAb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 20:31:26 -0400
Date: Mon, 11 Sep 2006 17:32:08 -0700 (PDT)
Message-Id: <20060911.173208.74750403.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: jbarnes@virtuousgeek.org, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, akpm@osdl.org
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: David Miller <davem@davemloft.net>
In-Reply-To: <8DA3BCBF-0F19-4CF0-B22E-91E57E7CB033@kernel.crashing.org>
References: <D680AFCF-11EC-48AD-BBC2-B92521DF442A@kernel.crashing.org>
	<20060911.062144.74719116.davem@davemloft.net>
	<8DA3BCBF-0F19-4CF0-B22E-91E57E7CB033@kernel.crashing.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 11 Sep 2006 16:17:18 +0200

> >> Why not just keep writel() etc. for *both* purposes; the address  
> >> cookie
> >> it gets as input can distinguish between the required behaviours for
> >> different kinds of I/Os; it will have to be setup by the arch- 
> >> specific
> >> __ioremap() or similar.
> >
> > This doesn't work when the I/O semantics are encoded into the
> > instruction, not some virual mapping PTE bits.  We'll have to use
> > a conditional or whatever in that case, which is silly.
> 
> Why is this "silly"?

It's silly because if you just use different interface
names for the different semantics, the caller can
ask for what he wants at the call site and no conditionals
are needed in the implementation.

