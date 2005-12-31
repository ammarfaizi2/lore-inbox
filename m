Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVLaHku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVLaHku (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 02:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVLaHku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 02:40:50 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:10764 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751320AbVLaHku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 02:40:50 -0500
Date: Sat, 31 Dec 2005 08:38:18 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, barryn@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Message-ID: <20051231073817.GZ15993@alpha.home.local>
References: <200512302306.28667.a1426z@gawab.com> <1135990502.28365.43.camel@localhost.localdomain> <200512310759.02962.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512310759.02962.a1426z@gawab.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 07:59:02AM +0300, Al Boldi wrote:
> Alan Cox wrote:
> > On Gwe, 2005-12-30 at 23:06 +0300, Al Boldi wrote:
> > > > +3 - (NEW) paranoid overcommit The total address space commit
> > > > +      for the system is not permitted to exceed swap. The machine
> > > > +      will never kill a process accessing pages it has mapped
> > > > +      except due to a bug (ie report it!)
> > >
> > > This one isn't in 2.6, which is critical for a stable system.
> >
> > Actually it is
> >
> > In the 2.4 case we took  "50% RAM + swap" as the safe sane world 'never
> > OOM kill' and to all intents and purposes it works. We also had a 100%
> > paranoia mode.
> >
> > When it was ported to 2.6 (not by me) whoever did it very sensibly made
> > the percentage tunable and removed "mode 3" since its mode 2 0% ram and
> > can be set that way.
> 
> Only, doesn't this imply that you cannot control overcommit unless backed by 
> swap?  i.e Without swap the kernel cannot use all of ram, because it would 
> overcommit no-matter what, thus invoking OOM-killer.
> 
> Which raises an important question:  What's overcommit to do with limiting 
> access to physical RAM?

As shown in my previous mail, it allows malloc() to return NULL. I've
also successfully verified that it allows mmap() to fail if there is
not enough memory. I disabled swap, and set the overcommit_ratio to 95
and could not kill the system. Above this, it becomes tricky. At 97, I
see the last malloc() calls take a very long time, and at 98, the
system still hangs. But 95% without swap seems stable here.

> Thanks!
> 
> --
> Al

Cheers,
Willy

