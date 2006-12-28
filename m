Return-Path: <linux-kernel-owner+w=401wt.eu-S1753666AbWL1RML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbWL1RML (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 12:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753668AbWL1RML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 12:12:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44819 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640AbWL1RMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 12:12:10 -0500
Date: Thu, 28 Dec 2006 09:10:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <000101c72a46$ee2296b0$bc84030a@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0612280909070.4473@woody.osdl.org>
References: <000101c72a46$ee2296b0$bc84030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Dec 2006, Chen, Kenneth W wrote:
> > 
> > Running the test code, git bisect points its finger at this commit. Reverting
> > this commit on top of 2.6.20-rc2 doesn't trigger the bug from the test code.
> > 
> >     [PATCH] mm: balance dirty pages
> > 
> >     Now that we can detect writers of shared mappings, throttle them.  Avoids OOM
> >     by surprise.
> 
> Oh, never mind :-(  I just didn't create enough write out pressure when
> test this. I just saw bug got triggered on a kernel I previously thought
> was OK.

Btw, this is an important point - people have long felt that the new page 
balancing in 2.6.19 was to blame, but you've just confirmed the long-held 
suspicion (at least by me) that it's not actually a new bug at all, it's 
just that the dirty page balancing causes writeback to happen _earlier_, 
and thus is better able to _show_ a bug that we've likely had for a long 
long time.

			Linus
