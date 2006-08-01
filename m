Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWHAArg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWHAArg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 20:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWHAArg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 20:47:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39323 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751499AbWHAArf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 20:47:35 -0400
Date: Tue, 1 Aug 2006 02:47:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nathan Scott <nathans@sgi.com>, kernel list <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: XFS vs. swsusp
Message-ID: <20060801004721.GA1869@elf.ucw.cz>
References: <20060731215933.GB3612@elf.ucw.cz> <20060801084143.D2286470@wobbly.melbourne.sgi.com> <20060731225308.GA4000@elf.ucw.cz> <200608010123.37466.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608010123.37466.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > timer driven wakeup done on the per-fs xfssyncd kernel threads,
> > > which do background metadata writeout and will write to the log
> > > periodically... but if those processes are all stopped too, you
> > > should be OK.
> > 
> > Timer only wakes up xfssyncd thread, right? That's okay, as that
> > thread will be stopped.
> 
> But we call sync() before kernel threads are frozen.  What happens if xfssyncd
> gets woken up by the timer after the sync() and before we freeze it?

xfssyncd writes some data to disk, but that is okay (no important data
could be generated in the meantime) and then it is frozen. As we take
system snapshot after the freeze, it is okay, because image is
consistent.

I do not see a problem.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
