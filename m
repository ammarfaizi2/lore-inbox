Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbUACV3A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 16:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUACV3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 16:29:00 -0500
Received: from mail.shareable.org ([81.29.64.88]:14989 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264289AbUACV26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 16:28:58 -0500
Date: Sat, 3 Jan 2004 21:28:37 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Bill Davidsen <davidsen@tmr.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
Message-ID: <20040103212837.GA10139@mail.shareable.org>
References: <3FE492EF.2090202@colorfullife.com> <20031221113640.GF3438@mail.shareable.org> <3FE594D0.8000807@colorfullife.com> <20031221141456.GI3438@mail.shareable.org> <3FF5DF59.3090905@tmr.com> <20040102224150.GA5864@mail.shareable.org> <20040103010909.GI1882@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040103010909.GI1882@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Fri, Jan 02, 2004 at 10:41:50PM +0000, Jamie Lokier wrote:
> > The best way is to maintain poll state in each "struct file".  The
> > order of complexity for the bitmap scan is still significant, but
> > ->poll calls are limited to the number of transitions which actually
> > happen.
> 
> What's the drawback to this approach?
> 
> Where is the poll state kept now?

The poll state is not maintained at all _between_ calls to poll/select
at the moment, so at least one fresh call to ->poll is required per
file descriptor.  That is something that can be changed.

> > I think somebody, maybe Richard Gooch, has a patch to do this that's
> > several years old by now.
> 
> Why wasn't it merged?  
> Implementation issues?

The impression I had was that the code is quite complicated and
invasive, and select/poll aren't considered worth optimising because
epoll is an overall better solution (which is true; optimising
select/poll would change the complexity of the slow part but not
reduce the complexity of the API part, while epoll does both).

See ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.1/fastpoll-readme

-- Jamie
