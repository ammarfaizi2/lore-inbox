Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVAQCr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVAQCr4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 21:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVAQCri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 21:47:38 -0500
Received: from ozlabs.org ([203.10.76.45]:35993 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262672AbVAQCrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 21:47:36 -0500
Subject: Re: [PATCH] kill symbol_get & friends
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, adaplas@pol.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dwmw2@infradead.org
In-Reply-To: <037701c4fc0c$87abd910$0f01a8c0@max>
References: <20050112203136.GA3150@lst.de>
	 <1105575573.12794.27.camel@localhost.localdomain>
	 <20050113170528.GA24590@lst.de>
	 <1105685810.7311.96.camel@localhost.localdomain>
	 <037701c4fc0c$87abd910$0f01a8c0@max>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 13:47:21 +1100
Message-Id: <1105930041.3954.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 20:46 +0000, Richard Purdie wrote:
> Without symbol_get, you can only have hard dependencies between the modules 
> and hence you would be forced into loading both modules even if you only 
> want one of them.
> 
> I came across this function when trying to solve this exact problem. If the 
> function is going to be removed, what is the alternative? Apologies if I've 
> missed something obvious...

The workaround is to put some registration wedge in the core code (see
net/core/netfilter.c:808 for an example).

But this is exactly what symbol_get is for.  However, if noone needs it,
we can remove it, as keeping infrastructure around because "someone
might need it" is not usually a good idea.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

