Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWBDNKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWBDNKk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 08:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWBDNKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 08:10:40 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:60064 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751241AbWBDNKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 08:10:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Sat, 4 Feb 2006 14:09:42 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041238.06395.rjw@sisk.pl> <200602042141.23685.nigel@suspend2.net>
In-Reply-To: <200602042141.23685.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602041409.43298.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 04 February 2006 12:41, Nigel Cunningham wrote:
> On Saturday 04 February 2006 21:38, Rafael J. Wysocki wrote:
> > > > My personal view is that:
> > > > 1) turning the freezing of kernel threads upside-down is not
> > > > necessary and would cause problems in the long run,
> > >
> > > Upside down?
> >
> > I mean now they should freeze voluntarily and your patches change that
> > so they would have to be created as non-freezeable if need be, AFAICT.
> 
> Ah. Now I'm on the same page. Lost the context.
> 
> > > > 2) the todo lists are not necessary and add a lot of complexity,
> > >
> > > Sorry. Forgot about this. I liked it for solving the SMP problem, but
> > > IIRC, we're downing other cpus before this now, so that issue has gone
> > > away. I should check whether I'm right there.
> > >
> > > > 3) trying to treat uninterruptible tasks as non-freezeable should
> > > > better be avoided (I tried to implement this in swsusp last year but
> > > > it caused vigorous opposition to appear, and it was not Pavel ;-))
> > >
> > > I'm not suggesting treating them as unfreezeable in the fullest sense.
> > > I still signal them, but don't mind if they don't respond. This way,
> > > if they do leave that state for some reason (timeout?) at some point,
> > > they still get frozen.
> >
> > Yes, that's exactly what I wanted to do in swsusp. ;-)
> 
> Oh. What's Pavel's solution? Fail freezing if uninterruptible threads don't 
> freeze?
> 
> > > > > A couple of possible  exceptions might be (1) freezing bdevs,
> > > > > because you don't care so much about making xfs really sync and
> > > > > really stop it's activity
> > > >
> > > > As I have already stated, in my view this one is at least worth
> > > > considering in the long run.
> > > >
> > > > > and (2) the  ability to thaw kernel space without thawing
> > > > > userspace. I want this for eating memory, to avoid deadlocking
> > > > > against kjournald etc. I haven't checked carefully as to why you
> > > > > don't need it in vanilla.
> > > >
> > > > Because it does not deadlock?  I will say we need this if I see a
> > > > testcase showing such a deadlock clearly.
> > >
> > > I've been surprised that you haven't already seen them while eating
> > > memory such that filesystems come into play. Perhaps you guys only use
> > > swap partitions, and something like a swapfile with some memory
> > > pressure might trigger this? Or it could be a side effect of one of
> > > the other changes.
> >
> > In fact, we only use swap partitions, so this will be needed if we are
> > going to use files, I guess.  Nice to know in advance, thanks. ;-)
> 
> k. Just so you don't confuse me, can I ask you not to refer to swapfiles as 
> 'files'? I support swap partitions, swapfiles and ordinary files, so the 
> latter will come to mind first for me.

Sure.  In fact I was referring to both swapfiles and regular files as just
"files".

Greetings,
Rafael
