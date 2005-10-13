Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVJMSYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVJMSYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 14:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVJMSYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 14:24:45 -0400
Received: from host-84-9-201-133.bulldogdsl.com ([84.9.201.133]:60546 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932149AbVJMSYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 14:24:45 -0400
Date: Thu, 13 Oct 2005 19:24:31 +0100
From: Ben Dooks <ben@fluff.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/base - fix sparse warnings
Message-ID: <20051013182431.GA2155@home.fluff.org>
References: <20051013165441.GA18360@home.fluff.org> <Pine.LNX.4.64.0510131059510.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510131059510.15297@g5.osdl.org>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 11:10:15AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 13 Oct 2005, Ben Dooks wrote:
> > 
> > The patch does not solve all the sparse errors generated,
> > but reduces the count significantly.
> 
> Well, you should also then remove the _bad_ declarations.

Sorry, I do not follow you, can you clarify this for me.
My patch did not generate any more errors, just removed the ones
that where easy to see a solution too.
 
> For example, attribute_container_init() right now is defined in 
> attribute_container.c, but then it's _declared_ (with no checking) where 
> it's used in init.c. 
> 
> The sparse warnign is appropriate: it was not declared where that 
> declaration is actually visible to the definition, so the code basically 
> isn't type-safe at all (since there's nothing that enforces the 
> declaration actually matching the definition).
> 
> You made the declaration properly visible, but you should also remove the 
> bogus declaration. A declaration that isn't visible to the definition is 
> always bad - since in the absense of a compiler with global visibility it 
> may or may not actually match what it supposedly declares.
> 
> I wonder if I should make sparse warn about multiple declarations..

I pulled the old declerations out of drivers/base/init.c ? I'm sure
the patch shows that?

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
