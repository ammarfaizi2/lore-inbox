Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVANHCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVANHCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 02:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVANHCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 02:02:15 -0500
Received: from ozlabs.org ([203.10.76.45]:41395 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261233AbVANHCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 02:02:11 -0500
Subject: Re: [PATCH] kill symbol_get & friends
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       adaplas@pol.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dwmw2@infradead.org
In-Reply-To: <20050113170528.GA24590@lst.de>
References: <20050112203136.GA3150@lst.de>
	 <1105575573.12794.27.camel@localhost.localdomain>
	 <20050113170528.GA24590@lst.de>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 17:56:50 +1100
Message-Id: <1105685810.7311.96.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 18:05 +0100, Christoph Hellwig wrote:
> On Thu, Jan 13, 2005 at 11:19:33AM +1100, Rusty Russell wrote:
> > If you don't hold a reference, then yes, the module can go away.  This
> > hasn't been a huge problem for users in the past.
> 
> There's a single users, and it has these problems.

It is an excellent candidate for weak symbols though.  If you want the
symbols to stay around, of course you have to keep a reference to them.
This code seems silly to me.

> > The lack of users is because, firstly, dynamic dependencies are less
> > common than static ones, and secondly because the remaining inter-module
> > users (AGP and mtd) have not been converted.
> 
> AGP doesn't use dynamic symbols anymore, only mtd is gone.  And I'd
> rather see it not switching to symbol_get.

If it really wants dynamic symbol lookup, that's damn well what's going
to happen.  intermodule must die.  If David doesn't want that feature
any more, then sure, remove it.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

