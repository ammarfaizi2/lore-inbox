Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289901AbSA3QbG>; Wed, 30 Jan 2002 11:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289987AbSA3QaE>; Wed, 30 Jan 2002 11:30:04 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:29843 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290017AbSA3Q3b>;
	Wed, 30 Jan 2002 11:29:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Wed, 30 Jan 2002 17:34:18 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201301354000.11594-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201301354000.11594-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Vxgg-0000Fr-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 04:54 pm, Rik van Riel wrote:
> On Wed, 30 Jan 2002, Daniel Phillips wrote:
> > On January 30, 2002 03:46 pm, Rik van Riel wrote:
> > > On Wed, 30 Jan 2002, Daniel Phillips wrote:
> 
> > > >      |-bash---bash---xinit-+-XFree86
> > > >      |                     `-xfwm-+-xfce---gnome-terminal-+-bash---pstree
> > >
> > > It doesn't matter how deep the tree is, on exec() all
> > > previously shared page tables will be blown away.
> > >
> > > In this part of the tree, I see exactly 2 processes
> > > which could be sharing page tables (the two bash
> > > processes).
> >
> > Sure, your point is that there is no problem and the speed of rmap on
> > fork is not something to worry about?
> 
> No.  The point is that we should optimise for fork()+exec(),
> not for a long series of consecutive fork()s all sharing the
> same page tables.

Fork+exec is adequately optimized for.  Fork+100 execs is supremely well
optimized for.  I'm entirely satisfied with the way the performance looks
at this point, it will outdo anything we've seen to date.  With Linus's
write-protect-in-page-directory optimization there's not a lot more fat
to be squeezed out, if any, and even without it, it will be a screamer.
I think we've done this one, it's time to move on from here.

-- 
Daniel
