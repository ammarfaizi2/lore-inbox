Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965308AbWJ2Rfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965308AbWJ2Rfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 12:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965309AbWJ2Rfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 12:35:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5020 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965308AbWJ2Rfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 12:35:42 -0500
Date: Sun, 29 Oct 2006 18:35:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061029173537.GA3022@elf.ucw.cz>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <1161850709.17293.23.camel@nigel.suspend2.net> <20061026085700.GI8394166@melbourne.sgi.com> <200610261111.30486.rjw@sisk.pl> <20061027013802.GQ8394166@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027013802.GQ8394166@melbourne.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > As you have them at the moment, the threads seem to be freezing fine.
> > > > The issue I've seen in the past related not to threads but to timer
> > > > based activity. Admittedly it was 2.6.14 when I last looked at it, but
> > > > there used to be a possibility for XFS to submit I/O from a timer when
> > > > the threads are frozen but the bdev isn't frozen. Has that changed?
> > > 
> > > I didn't think we've ever done that - periodic or delayed operations
> > > are passed off to the kernel threads to execute. A stack trace
> > > (if you still have it) would be really help here.
> > > 
> > > Hmmm - we have a couple of per-cpu work queues as well that are
> > > used on I/O completion and that can, in some circumstances,
> > > trigger new transactions. If we are only flush metadata, then
> > > I don't think that any more I/o will be issued, but I could be
> > > wrong (maze of twisty passages).
> > 
> > Well, I think this exactly is the problem, because worker_threads run with
> > PF_NOFREEZE set (as I've just said in another message).
> 
> Ok, so freezing the filesystem is the only way you can prevent
> this as the workqueues are flushed as part of quiescing the filesystem.

Well, alternative is to teach XFS to sense that we are being frozen
and stop disk writes in such case.

OTOH freeze_bdevs is perhaps not that bad solution... 
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
