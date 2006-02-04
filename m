Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWBDRUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWBDRUF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 12:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWBDRUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 12:20:05 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:43425 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932523AbWBDRUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 12:20:03 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Sat, 4 Feb 2006 18:18:56 +0100
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
Message-Id: <200602041818.57278.rjw@sisk.pl>
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

Yes.

AFAICT it's to avoid situations in which we would freeze having a
process in the D state that holds a semaphore or a mutex neded for
suspending or resuming devices (or later on for saving the image etc.).

[I didn't answer this question previously, sorry.]

Greetings,
Rafael
