Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVAMI3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVAMI3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVAMI3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:29:19 -0500
Received: from ozlabs.org ([203.10.76.45]:30178 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261262AbVAMI3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:29:15 -0500
Subject: Re: [PATCH] kill symbol_get & friends
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Airlie <airlied@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, adaplas@pol.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dwmw2@redhat.com
In-Reply-To: <21d7e997050112165935b89a27@mail.gmail.com>
References: <20050112203136.GA3150@lst.de>
	 <1105575573.12794.27.camel@localhost.localdomain>
	 <21d7e997050112165935b89a27@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 13:25:47 +1100
Message-Id: <1105583147.25553.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 11:59 +1100, Dave Airlie wrote:
> > For optional module dependencies, weak symbols can be used, but there
> > seems to be a desire for genuine dynamic dependencies.  If you can get
> > rid of those, I'll apply your patch in a second!
> 
> what weak symbol support? can I actually use gcc weak symbols and have
> it all work?
> what happens if the module goes away? 

1) See kernel/module.c:1156 ("/* OK if weak. */").

2) Weak undefined symbols should "just work".  Overriding of weak
defined symbols is not implemented: noone has asked.

3) Like any statically-resolved symbol, this module will hold a
reference to the module exporting the symbol.  The only special thing
about weak symbols is that we don't fail to load if they are unresolved
(and the address will be NULL in this case).

Hope that clarifies,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

