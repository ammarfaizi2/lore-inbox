Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754430AbWKIJMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbWKIJMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 04:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754438AbWKIJMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 04:12:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:516 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1754430AbWKIJMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 04:12:19 -0500
Date: Wed, 8 Nov 2006 18:09:22 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alasdair G Kergon <agk@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061108180921.GA7708@ucw.cz>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061107234951.GD30653@agk.surrey.redhat.com> <20061108023039.GF30653@agk.surrey.redhat.com> <200611081310.19100.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611081310.19100.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > swsusp-freeze-filesystems-during-suspend-rev-2.patch
> > 
> > I think you need to give more thought to device-mapper
> > interactions here.  If an underlying device is suspended
> > by device-mapper without freezing the filesystem (the
> > normal state) and you issue a freeze_bdev on a device
> > above it, the freeze_bdev may never return if it attempts
> > any synchronous I/O (as it should).
> 
> Well, it looks like the interactions with dm add quite a bit of
> complexity here.

What about just fixing xfs (thou shall not write to disk when kernel
threads are frozen), and getting rid of blockdev freezing?

						Pavel
-- 
Thanks for all the (sleeping) penguins.
