Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264642AbUEYEjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264642AbUEYEjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 00:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUEYEjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 00:39:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:464 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264628AbUEYEjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 00:39:10 -0400
Date: Mon, 24 May 2004 21:39:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <20040525042054.GU29378@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0405242137210.32189@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
 <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
 <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
 <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
 <20040525042054.GU29378@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, Andrea Arcangeli wrote:

> On Mon, May 24, 2004 at 09:00:02PM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Tue, 25 May 2004, Andrea Arcangeli wrote:
> > > 
> > > The below patch should fix it, the only problem is that it can screwup
> > > some arch that might use page-faults to keep track of the accessed bit,
> > 
> > Indeed. At least alpha does this - that's where this code came from. SO 
> > this will cause infinite page faults on alpha and any other "accessed bit 
> > in software" architectures.
> 
> as you say the alpha has no accessed bit at all in hardware, so
> it cannot generate page faults. 

It _does_ generate page faults.

We do the accessed bit by clearing the "user readable" thing (or
something. I forget the exact details, and I'm too lazy to check it out).  
And a page won't be _really_ readable until it has been marked young.

If you don't mark it young, you'll get infinite page faults.

That's how we do the accessed bit.

> "accessed bit in software" is fine with my fix.

NO IT IS NOT.

		Linus
