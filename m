Return-Path: <linux-kernel-owner+w=401wt.eu-S1754951AbWL2P2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbWL2P2z (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 10:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754927AbWL2P2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 10:28:55 -0500
Received: from THUNK.ORG ([69.25.196.29]:54272 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754869AbWL2P2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 10:28:54 -0500
Date: Fri, 29 Dec 2006 10:27:42 -0500
From: Theodore Tso <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       linux-kernel@vger.kernel.org, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, akpm@osdl.org, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
Message-ID: <20061229152742.GA28710@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
	kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
	linux-kernel@vger.kernel.org, ranma@tdiedrich.de,
	gordonfarquharson@gmail.com, akpm@osdl.org, a.p.zijlstra@chello.nl,
	tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org> <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org> <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 12:58:12AM -0800, Linus Torvalds wrote:
> Because what "__set_page_dirty_buffers()" does is that AT THE TIME THE 
> "set_page_dirty()" IS CALLED, it will mark all the buffers on that page as 
> dirty. That may _sound_ like what we want, but it really isn't. Because by 
> the time "writepage()" is actually called (which can be MUCH MUCH later), 
> some internal filesystem activity may actually have cleaned one or more of 
> those buffers in the meantime, and now we call "writepage()" (which really 
> wants to write them _all_), and it will write only part of them, or none 
> at all.

I'm confused.  Does this mean that if "fs blocksize"=="VM pagesize"
this bug can't trigger?  But I thought at least one of people
reporting corruption was using a filesystem with a 4k block size on an
i386?

						- Ted
