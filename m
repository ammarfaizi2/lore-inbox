Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288845AbSAXST5>; Thu, 24 Jan 2002 13:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288830AbSAXSTv>; Thu, 24 Jan 2002 13:19:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:26313 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S288845AbSAXSTL>; Thu, 24 Jan 2002 13:19:11 -0500
Date: Thu, 24 Jan 2002 18:21:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: James Washer <e2big@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question on current->local_pages and its usage
In-Reply-To: <200201230608.g0N685P09476@crg8.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.21.0201241808180.1698-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, James Washer wrote:
> 
> In __free_pages_ok(), if current->flags & PF_FREE_PAGES, the code adds the
> pages being freed to current->local_pages using the following block of code:
> ......
> Unless I am misreading this, that first if statement in going to limit
> us to at most one block of pages no matter how many times we call
> __free_pages_ok()
> 
> However, in balance_classzone(), the code seems to expect that multiple 
> blocks of pages may be 'cached' in local_pages.
> ...... 
> So, am I misreading this.. or is one of these wrong? If I were to hazard a 
> guess, __free_pages_ok() should be 'fixed'.

I think you read it right.  I believe it comes from Linus
integrating Andrea's VM, but making changes to it on the fly.
So one end has a capability that the other end now prohibits.
In Andrea's -aa tree it isn't quite the same; and I don't think
it's worth tidying up the mainline here, while there's the
possibility that more of Andrea's version is to be merged in.

Hugh

