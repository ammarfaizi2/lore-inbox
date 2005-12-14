Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVLNSay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVLNSay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVLNSay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:30:54 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:48809 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932093AbVLNSax
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:30:53 -0500
Subject: Re: [RFC][PATCH 3/3] TCP/IP Critical socket communication mechanism
From: Sridhar Samudrala <sri@us.ibm.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20051214121253.GB23393@gaz.sfgoth.com>
References: <Pine.LNX.4.58.0512140052470.31720@w-sridhar.beaverton.ibm.com>
	 <1134559039.25663.12.camel@localhost.localdomain>
	 <20051214121253.GB23393@gaz.sfgoth.com>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 10:29:27 -0800
Message-Id: <1134584967.8698.41.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 04:12 -0800, Mitchell Blank Jr wrote:
> Alan Cox wrote:
> > But your user space that would add the routes is not so protected so I'm
> > not sure this is actually a solution, more of an extended fudge.
> 
> Yes, there's no 100% solution -- no matter how much memory you reserve and
> how many paths you protect if you try hard enough you can come up
> with cases where it'll fail.  ("I'm swapping to NFS across a tun/tap
> interface to a custom userland SSL tunnel to a server across a BGP route...")
> 
> However, if the 'extended fundge' pushes a problem from "can happen, even
> in a very normal setup" territory to "only happens if you're doing something
> pretty weird" then is it really such a bad thing?  I think the cost in code
> complexity looks pretty reasonable.

Yes. This should work fine for cases where you need a limited number of
critical allocation requests to succeed for a short period of time.

> > > +#define SK_CRIT_ALLOC(sk, flags) ((sk->sk_allocation & __GFP_CRITICAL) | flags)
> > 
> > Lots of hidden conditional logic on critical paths.
> 
> How expensive is it compared to the allocation itself?

Also, as i said in my other response we could make it a compile-time
configurable option with zero overhead when turned off.

Thanks
Sridhar

> 
> > > +#define CRIT_ALLOC(flags) (__GFP_CRITICAL | flags)
> > 
> > Pointless obfuscation
> 
> Fully agree.
> 
> -Mitch

