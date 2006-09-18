Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965314AbWIRCZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965314AbWIRCZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 22:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbWIRCZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 22:25:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965314AbWIRCZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 22:25:26 -0400
Date: Sun, 17 Sep 2006 19:24:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC] MMIO accessors & barriers documentation #2
In-Reply-To: <1158534913.14473.276.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609171919030.4388@g5.osdl.org>
References: <1158534913.14473.276.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Sep 2006, Benjamin Herrenschmidt wrote:
> 
> Class 1: Ordered accessors
> --------------------------
> 
>  1- {read,write}{b,w,l,q} : MMIO accessors. Those accessors provide
> all MMIO ordering requirements. They are thus called "fully ordered".
> That is #1, #2 and #4 for writes and #1 and #3 for reads. 

Well, it's already not defined to be #4 right now on SGI boxes, and we 
have that (badly named) mmiowb() thing to enforce #4, so I think we should 
just accept that write[bwl]() it's _that_ ordered.

And on x86, we _already_ depend on "wmb()" to be a "normal write to MMIO 
write" barrier, which is technically wrong and bad. Again, thanks to 
mmiowb(), normal memory accesses and MMIO accesses have already been 
defined to not be in the same "ordering domain", so "wmb()" is technically 
wrong and may not order a regular write wrt a MMIO (because it doesn't do 
so for the other order: MMIO->spin_unlock).

So I think we should just admit that at least MMIO _stores_ are already 
not entirely ordered, and not try to strengthen the rules for the current 
setup (and just try to clarify the currently accepted semantics).

		Linus
