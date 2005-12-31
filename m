Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVLaODW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVLaODW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 09:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVLaODV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 09:03:21 -0500
Received: from [212.76.87.66] ([212.76.87.66]:45062 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932267AbVLaODV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 09:03:21 -0500
From: Al Boldi <a1426z@gawab.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Date: Sat, 31 Dec 2005 17:02:20 +0300
User-Agent: KMail/1.5
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, barryn@pobox.com,
       linux-kernel@vger.kernel.org
References: <200512302306.28667.a1426z@gawab.com> <200512310759.02962.a1426z@gawab.com> <20051231073817.GZ15993@alpha.home.local>
In-Reply-To: <20051231073817.GZ15993@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512311702.20525.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sat, Dec 31, 2005 at 07:59:02AM +0300, Al Boldi wrote:
> > Alan Cox wrote:
> > > On Gwe, 2005-12-30 at 23:06 +0300, Al Boldi wrote:
> > > > > +3 - (NEW) paranoid overcommit The total address space commit
> > > > > +      for the system is not permitted to exceed swap. The machine
> > > > > +      will never kill a process accessing pages it has mapped
> > > > > +      except due to a bug (ie report it!)
> > > >
> > > > This one isn't in 2.6, which is critical for a stable system.
> > >
> > > Actually it is
> > >
> > > In the 2.4 case we took  "50% RAM + swap" as the safe sane world
> > > 'never OOM kill' and to all intents and purposes it works. We also had
> > > a 100% paranoia mode.
> > >
> > > When it was ported to 2.6 (not by me) whoever did it very sensibly
> > > made the percentage tunable and removed "mode 3" since its mode 2 0%
> > > ram and can be set that way.
> >
> > Only, doesn't this imply that you cannot control overcommit unless
> > backed by swap?  i.e Without swap the kernel cannot use all of ram,
> > because it would overcommit no-matter what, thus invoking OOM-killer.
> >
> > Which raises an important question:  What's overcommit to do with
> > limiting access to physical RAM?
>
> As shown in my previous mail, it allows malloc() to return NULL. I've
> also successfully verified that it allows mmap() to fail if there is
> not enough memory. I disabled swap, and set the overcommit_ratio to 95
> and could not kill the system. Above this, it becomes tricky. At 97, I
> see the last malloc() calls take a very long time, and at 98, the
> system still hangs. But 95% without swap seems stable here.

Thanks, for confirming this!  And I agree that this patch and 2.6 offer an 
important and necessary workaround to inhibit OOM-killer, but it's no more 
than a workaround.

And so the question remains:  Why should overcommit come into play at all 
when dealing with physical RAM only?

Shouldn't it be possible to disable overcommit completely, thus giving kswapd 
a break from running wild trying to find something to swap/page, which is 
the reason why the system gets unstable going over 95% in your example.

Thanks!

--
Al

