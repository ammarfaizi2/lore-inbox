Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933639AbWKQPOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933639AbWKQPOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933655AbWKQPOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:14:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59342 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S933639AbWKQPOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:14:07 -0500
Date: Fri, 17 Nov 2006 16:13:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061117151348.GA8859@elf.ucw.cz>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061110103942.GG3196@elf.ucw.cz> <20061112223012.GH11034@melbourne.sgi.com> <200611122343.06625.rjw@sisk.pl> <20061116232349.GI11034@melbourne.sgi.com> <20061116234053.GC6757@elf.ucw.cz> <20061117014051.GM11034@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117014051.GM11034@melbourne.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-11-17 12:40:51, David Chinner wrote:
> On Fri, Nov 17, 2006 at 12:40:53AM +0100, Pavel Machek wrote:
> > On Fri 2006-11-17 10:23:49, David Chinner wrote:
> > > On Sun, Nov 12, 2006 at 11:43:05PM +0100, Rafael J. Wysocki wrote:
> > > > On Sunday, 12 November 2006 23:30, David Chinner wrote:
> > > > > And how does freezing them at that point in time guarantee consistent
> > > > > filesystem state?
> > > > 
> > > > If the work queues are frozen, there won't be any fs-related activity _after_
> > > > we create the suspend image. 
> > > 
> > > fs-related activity before or after the suspend image is captured is
> > > not a problem - it's fs-related activity _during_ the suspend that
> > > is an issue here. If we have async I/O completing during the suspend
> > > image capture, we've got problems....
> > 
> > fs-related activity _after_ image is captured definitely is a problem
> > -- it breaks swsusp invariants.
> > 
> > During image capture, any fs-related activity is not possible, as we
> > are running interrupts disabled, DMA disabled.
> 
> Ok, so the I/o that finishes during the image capture won't be reported
> until after the capture completes. that means we lose the capability

There's no I/O in flight during image capture. Interrupts are
disabled, DMAs are stopped, and drivers were told to shut down (that
includes finishing any outstanding work, and drivers do that
currently; but perhaps docs should be more explicit about it).
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
