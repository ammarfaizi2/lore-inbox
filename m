Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751733AbWCUOoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWCUOoa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWCUOoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:44:30 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:60427 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751734AbWCUOo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:44:29 -0500
Date: Tue, 21 Mar 2006 15:44:10 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Con Kolivas <kernel@kolivas.org>, Mike Galbraith <efault@gmx.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
Subject: Re: interactive task starvation
Message-ID: <20060321144410.GE26171@w.ods.org>
References: <1142592375.7895.43.camel@homer> <200603220119.50331.kernel@kolivas.org> <1142951339.7807.99.camel@homer> <200603220130.34424.kernel@kolivas.org> <20060321143240.GA310@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321143240.GA310@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 03:32:40PM +0100, Ingo Molnar wrote:
> 
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> > On Wednesday 22 March 2006 01:28, Mike Galbraith wrote:
> > > On Wed, 2006-03-22 at 01:19 +1100, Con Kolivas wrote:
> > > > What you're fixing with unfairness is worth pursuing. The 'ls' issue just
> > > > blows my mind though for reasons I've just said. Where are the magic
> > > > cycles going when nothing else is running that make it take ten times
> > > > longer?
> > >
> > > What I was talking about when I mentioned scrolling was rendering.
> > 
> > I'm talking about the long standing report that 'ls' takes 10 times 
> > longer on 2.6 90% of the time you run it, and doing 'ls | cat' makes 
> > it run as fast as 2.4. This is what Willy has been fighting with.
> 
> ah. That's i think a gnome-terminal artifact - it does some really 
> stupid dynamic things while rendering, it 'skips' certain portions of 
> rendering, depending on the speed of scrolling. Gnome 2.14 ought to have 
> that fixed i think.

Ah no, I never use those montruous environments ! xterm is already heavy.
don't you remember, we found that doing "ls" in an xterm was waking the
xterm process for every single line, which in turn woke the X server for
a one-line scroll, while adding the "|cat" acted like a buffer with batched
scrolls. Newer xterms have been improved to trigger jump scroll earlier and
don't exhibit this behaviour even on non-patched kernels. However, sshd
still shows the same problem IMHO.

> 	Ingo

Cheers,
Willy

