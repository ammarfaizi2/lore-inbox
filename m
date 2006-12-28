Return-Path: <linux-kernel-owner+w=401wt.eu-S964836AbWL1Awr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWL1Awr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 19:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWL1Awr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 19:52:47 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59171
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964845AbWL1Awq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 19:52:46 -0500
Date: Wed, 27 Dec 2006 16:52:46 -0800 (PST)
Message-Id: <20061227.165246.112622837.davem@davemloft.net>
To: torvalds@osdl.org
Cc: ranma@tdiedrich.de, gordonfarquharson@gmail.com, tbm@cyrius.com,
       a.p.zijlstra@chello.nl, andrei.popa@i-neo.ro, akpm@osdl.org,
       hugh@veritas.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix page_mkclean_one
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org>
References: <20061226.205518.63739038.davem@davemloft.net>
	<Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612271636540.4473@woody.osdl.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Wed, 27 Dec 2006 16:39:43 -0800 (PST)

> 
> 
> On Wed, 27 Dec 2006, Linus Torvalds wrote:
> > 
> > I think the test-case could probably be improved by having a munmap() and 
> > page-cache flush in between the writing and the checking, to see whether 
> > that shows the corruption easier (and possibly without having to start 
> > paging in order to throw the pages out, which would simplify testing a 
> > lot).
> 
> I think the page-writeout is implicated, because I do seem to need it, but 
> the page-cache flush does seem to make corruption _easier_ to see. I now 
> seem about to trigger it with a 100MB file on a 256MB machine in a minute 
> or so, with this slight modification.
> 
> I still don't see _why_, though. But maybe smarter people than me can see 
> it..

FWIW this program definitely triggers the bug for me.
