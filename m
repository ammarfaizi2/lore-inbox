Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVBXWdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVBXWdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVBXWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:33:24 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:61394 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262519AbVBXWdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:33:07 -0500
Date: Thu, 24 Feb 2005 22:32:18 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
In-Reply-To: <421E4E27.20004@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0502242224070.14886@goblin.wat.veritas.com>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au> 
    <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston> 
    <20050217230342.GA3115@wotan.suse.de> 
    <20050217153031.011f873f.davem@davemloft.net> 
    <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au> 
    <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com> 
    <421B0163.3050802@yahoo.com.au> 
    <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com> 
    <421D1737.1050501@yahoo.com.au> 
    <Pine.LNX.4.61.0502240457350.5427@goblin.wat.veritas.com> 
    <1109224777.5177.33.camel@npiggin-nld.site> 
    <Pine.LNX.4.61.0502241143001.6630@goblin.wat.veritas.com> 
    <421E4E27.20004@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2005, Nick Piggin wrote:
> Hugh Dickins wrote:
> > 
> > Has anyone _ever_ seen a p??_ERROR message?  I'm inclined to just
> > put three functions into mm/memory.c to do the p??_ERROR and p??_clear,
> > but that way the __FILE__ and __LINE__ will always come out the same.
> > I think if it ever proves a problem, we'd just add in a dump_stack.
> 
> I think a function is the most sensible. And a good idea, it should
> reduce the icache pressure in the loops (although gcc does seem to
> do a pretty good job of moving unlikely()s away from the fastpath).

At one stage I was adding unlikelies to all the p??_bads, then it
seemed more sensible to hide that in a new macro (which of course
must do the none and bad tests inline, before going off to the function).

David's response confirms that __FILE__,__LINE__ shouldn't be an issue.

> I think at the point these things get detected, there is little use
> for having a dump_stack. But we may as well add one anyway if it is
> an out of line function?

We could at little cost.  But I think if these messages come up at all,
they're likely to come up in clumps, where the backtrace won't actually
be giving any interesting info, and the quantity of them be a nuisance
itself.  I'd rather leave it to the next person who gets the error and
wants the backtrace to add it.

Hugh
