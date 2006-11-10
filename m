Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932838AbWKJKkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932838AbWKJKkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932846AbWKJKkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:40:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14720 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932838AbWKJKkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:40:03 -0500
Date: Fri, 10 Nov 2006 11:39:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061110103942.GG3196@elf.ucw.cz>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611092218.58970.rjw@sisk.pl> <20061109214159.GB2616@elf.ucw.cz> <200611092321.47728.rjw@sisk.pl> <20061110005749.GO8394166@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110005749.GO8394166@melbourne.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-11-10 11:57:49, David Chinner wrote:
> On Thu, Nov 09, 2006 at 11:21:46PM +0100, Rafael J. Wysocki wrote:
> > I think we can add a flag to __create_workqueue() that will indicate if
> > this one is to be running with PF_NOFREEZE and a corresponding macro like
> > create_freezable_workqueue() to be used wherever we want the worker thread
> > to freeze (in which case it should be calling try_to_freeze() somewhere).
> > Then, we can teach filesystems to use this macro instead of
> > create_workqueue().
> 
> At what point does the workqueue get frozen? i.e. how does this
> guarantee an unfrozen filesystem will end up in a consistent
> state?

Snapshot is atomic; workqueue will be unfrozen with everyone else, but
as there were no writes in the meantime, there should be no problems.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
