Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWBDLjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWBDLjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 06:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWBDLjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 06:39:11 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:31392 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1945925AbWBDLjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 06:39:10 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Sat, 4 Feb 2006 12:38:05 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041159.00326.rjw@sisk.pl> <200602042108.52112.nigel@suspend2.net>
In-Reply-To: <200602042108.52112.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602041238.06395.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 04 February 2006 12:08, Nigel Cunningham wrote:
> On Saturday 04 February 2006 20:58, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Saturday 04 February 2006 10:54, Nigel Cunningham wrote:
> > > On Saturday 04 February 2006 19:01, Pavel Machek wrote:
> > > > On So 04-02-06 11:20:54, Nigel Cunningham wrote:
> > > > > Hi Pavel.
> > > > >
> > > > > On Friday 03 February 2006 21:44, Pavel Machek wrote:
> > > > > > [Pavel is willing to take patches, as his cooperation with
> > > > > > Rafael shows, but is scared by both big patches and series of 10
> > > > > > small patches he does not understand. He likes patches removing
> > > > > > code.]
> > > > >
> > > > > Assuming you're refering to the patches that started this thread,
> > > > > what don't you understand? I'm more than happy to explain.
> > > >
> > > > For "suspend2: modules support", it is pretty clear that I do not
> > > > need or want that complexity. But for "refrigerator improvements", I
> > > > did
> > >
> > > ... and yet you're perfectly happy to add the complexity of sticking
> > > half the code in userspace. I don't think I'll ever dare to try to
> > > understand you, Pavel :)
> > >
> > > > not understand which parts are neccessary because of suspend2
> > > > vs. swsusp differences, and if there is simpler way towards the same
> > > > goal. (And thanks for a stress hint...)
> > >
> > > I think virtually everything is relevant to you.
> >
> > My personal view is that:
> > 1) turning the freezing of kernel threads upside-down is not necessary
> > and would cause problems in the long run,
> 
> Upside down?

I mean now they should freeze voluntarily and your patches change that
so they would have to be created as non-freezeable if need be, AFAICT.

> > 2) the todo lists are not necessary and add a lot of complexity,
> 
> Sorry. Forgot about this. I liked it for solving the SMP problem, but IIRC, 
> we're downing other cpus before this now, so that issue has gone away. I 
> should check whether I'm right there.
> 
> > 3) trying to treat uninterruptible tasks as non-freezeable should better
> > be avoided (I tried to implement this in swsusp last year but it caused
> > vigorous opposition to appear, and it was not Pavel ;-))
> 
> I'm not suggesting treating them as unfreezeable in the fullest sense. I 
> still signal them, but don't mind if they don't respond. This way, if they 
> do leave that state for some reason (timeout?) at some point, they still 
> get frozen.

Yes, that's exactly what I wanted to do in swsusp. ;-)

> > > A couple of possible  exceptions might be (1) freezing bdevs,
> > > because you don't care so much about making xfs really sync and really
> > > stop it's activity
> >
> > As I have already stated, in my view this one is at least worth
> > considering in the long run.
> >
> > > and (2) the  ability to thaw kernel space without thawing userspace. I
> > > want this for eating memory, to avoid deadlocking against kjournald
> > > etc. I haven't checked carefully as to why you don't need it in
> > > vanilla.
> >
> > Because it does not deadlock?  I will say we need this if I see a
> > testcase showing such a deadlock clearly.
> 
> I've been surprised that you haven't already seen them while eating memory 
> such that filesystems come into play. Perhaps you guys only use swap 
> partitions, and something like a swapfile with some memory pressure might 
> trigger this? Or it could be a side effect of one of the other changes.

In fact, we only use swap partitions, so this will be needed if we are going
to use files, I guess.  Nice to know in advance, thanks. ;-)

Greetings,
Rafael
