Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267624AbUIFNQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267624AbUIFNQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUIFNQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 09:16:28 -0400
Received: from colin2.muc.de ([193.149.48.15]:34309 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268010AbUIFNQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 09:16:19 -0400
Date: 6 Sep 2004 15:16:18 +0200
Date: Mon, 6 Sep 2004 15:16:18 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-ID: <20040906131618.GB46770@muc.de>
References: <m3zn4bidlx.fsf@averell.firstfloor.org> <20040831183655.58d784a3.pj@sgi.com> <20040904133701.GE33964@muc.de> <20040904171417.67649169.pj@sgi.com> <Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 05:18:30PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 4 Sep 2004, Paul Jackson wrote:
> > 
> > How is what Linus left more broken?
> 
> It's not. If anything, we should probably remove even more.
> 
> I don't see what the problem was with just requiring the right damn size.  
> User mode can trivially get the size by asking for it. But if it can't be

I don't think writing a syscall loop is a good idea for this. 
The main reason is that when you get an EINVAL for some other
reason you will still blow up your memory until you
hit some arbitary upper size.

Currently this EINVAL is the only instance in this syscall,
but this may change in some future version.

A sysctl may have worked, but it results in a lot of code
bloat in the application to handle it.

> bothered, then Andi's code certainly just made things worse.

I disagree on that. It was not perfect, but with minor fixes
could have been a proper solution. Your current code is even worse than
what was there before my patch.

Alternative would be the sysctl and strict check again. I don't
like it too much because it makes the application more complicated
(i prefer simple interfaces, because complex interfaces tend to 
have more bugs) 

-Andi
