Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWGaW41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWGaW41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 18:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWGaW41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 18:56:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57825 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030369AbWGaW41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 18:56:27 -0400
Date: Tue, 1 Aug 2006 00:53:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, xfs@oss.sgi.com
Subject: Re: XFS vs. swsusp
Message-ID: <20060731225308.GA4000@elf.ucw.cz>
References: <20060731215933.GB3612@elf.ucw.cz> <20060801084143.D2286470@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801084143.D2286470@wobbly.melbourne.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Rafael has patches to add bdev freezing to swsusp. I'd like to know if
> > they are neccessary (and why).
> > 
> > 1) Is sync() enough to guarantee that all the data written before sync
> > actually reach the platters?
> > 
> > (Or is it that data only reach the journal? OTOH that would be okay, too).
> 
> It ensures file data reaches its final resting place, and that
> metadata changes have been logged.  It does not necessarily
....

Okay, good, being safely in the journal is okay.

> > 2) If we stop all the user proceses and all the kernel threads, is
> > that enough to prevent XFS from writing to disk?
> 
> Yes, I believe so (if all user processes and kernel threads are
> stopped, who else would be left to initiate I/O?).  There is a

Well, we were afraid that you'd do it from timer interrupt or
something like that.

> timer driven wakeup done on the per-fs xfssyncd kernel threads,
> which do background metadata writeout and will write to the log
> periodically... but if those processes are all stopped too, you
> should be OK.

Timer only wakes up xfssyncd thread, right? That's okay, as that
thread will be stopped.

Rafael, I do not think we need bdev freezing changes for XFS.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
