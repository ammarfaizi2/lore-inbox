Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274959AbTHPVAx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 17:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274960AbTHPVAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 17:00:53 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:448 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S274959AbTHPVAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 17:00:52 -0400
Date: Sat, 16 Aug 2003 22:54:27 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Jamie Lokier <jamie@shareable.org>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030816225427.Z639@nightmaster.csn.tu-chemnitz.de>
References: <20030815235431.GT1027@matchmail.com> <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com> <20030816005408.GA21356@mail.jlokier.co.uk> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net>; from efault@gmx.de on Sat, Aug 16, 2003 at 08:14:36AM +0200
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19o8AM-0002ou-00*iSht5eqVzSY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 08:14:36AM +0200, Mike Galbraith wrote:
> At 01:54 AM 8/16/2003 +0100, Jamie Lokier wrote:
> [...]
> 
> >None of these will work well if "wakee" tasks are able to run
> >immediately after being woken, before "waker" tasks get a chance to
> >either block or put the wakees back to sleep.
> Sounds like another scheduler class (SCHED_NOPREEMPT) would be required.

Sounds more like a new futex feature: Wakeup after time expired.

It would be very easy to do, since we have a timeout handy
anyway (look at kernel/futex.c:do_futex()).

But it would require to use a kernel timer and we might add a
cancel of this wakeup returning some sane error, if the wakeup
happenend already.

Then this "blocking" could be modeled as "blocking too long",
which is how this kind of thing is handled more sanely anyway.

The only thing that is disturbing about blocking, is blocking
"too long". Blocking itself is ok, since it frees CPU time for
other processes the programmer is completely unaware of.

Regards

Ingo Oeser
