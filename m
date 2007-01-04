Return-Path: <linux-kernel-owner+w=401wt.eu-S1030180AbXADTJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbXADTJn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbXADTJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:09:43 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44722 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964821AbXADTJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:09:42 -0500
Date: Thu, 4 Jan 2007 11:09:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
In-Reply-To: <20070104105430.1de994a7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org>
References: <459C4038.6020902@redhat.com> <20070103162643.5c479836.akpm@osdl.org>
 <459D3E8E.7000405@redhat.com> <20070104102659.8c61d510.akpm@osdl.org>
 <459D4897.4020408@redhat.com> <20070104105430.1de994a7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2007, Andrew Morton wrote:

> On Thu, 04 Jan 2007 12:33:59 -0600
> Eric Sandeen <sandeen@redhat.com> wrote:
> 
> > Andrew Morton wrote:
> > > On Thu, 04 Jan 2007 11:51:10 -0600
> > > Eric Sandeen <sandeen@redhat.com> wrote:
> > 
> > >> Also - is it ok to alias a function with one signature to a function with
> > >> another signature?
> > > 
> > > Ordinarily I'd say no wucking fay, but that's effectively what we've been
> > > doing in there for ages, and it seems to work.
> > 
> > Hmm that gives me a lot of confidence ;-)  I'd hate to carry along bad
> > assumptions while we try to make this all kosher... but I'm willing to
> > defer to popular opinion on this one....
> 
> yeah, I'm a bit wobbly about it.  Linus, what do you think?

I don't much care. If we ever find an architecture where it matters, we'll 
unalias them. In the meantime, we've for the longest time just known that 
calling conventions don't care about argument types on all the 
architectures we've been on, so we've aliased things to the same function.

But it's not very common, so we can stop doing it. 

But I'd argue we should only do it if there is an actual 
honest-to-goodness reason to do so. Usually it only matters for

 - return types are fundamentally different (FP vs integer vs pointer)

 - calling convention has callee popping the arguments (normal in Pascal, 
   very unusual in C, because it also breaks lots of historical code, 
   and is simply not workable with K&R C, where perfectly normal things 
   like "open()" take either two or three arguments without being 
   varargs).

In general, this just isn't an issue for the kernel. Other systems have 
had basically NO typing what-so-ever for functions, and use aliasing much 
more extensively. We only do it for a few ratehr rare things.

			Linus
