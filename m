Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753385AbWKLWbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbWKLWbg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 17:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753404AbWKLWbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 17:31:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54217 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753385AbWKLWbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 17:31:35 -0500
Date: Mon, 13 Nov 2006 09:30:13 +1100
From: David Chinner <dgc@sgi.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Chinner <dgc@sgi.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Alasdair G Kergon <agk@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061112223012.GH11034@melbourne.sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611092218.58970.rjw@sisk.pl> <20061109214159.GB2616@elf.ucw.cz> <200611092321.47728.rjw@sisk.pl> <20061110005749.GO8394166@melbourne.sgi.com> <20061110103942.GG3196@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110103942.GG3196@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 11:39:42AM +0100, Pavel Machek wrote:
> On Fri 2006-11-10 11:57:49, David Chinner wrote:
> > On Thu, Nov 09, 2006 at 11:21:46PM +0100, Rafael J. Wysocki wrote:
> > > I think we can add a flag to __create_workqueue() that will indicate if
> > > this one is to be running with PF_NOFREEZE and a corresponding macro like
> > > create_freezable_workqueue() to be used wherever we want the worker thread
> > > to freeze (in which case it should be calling try_to_freeze() somewhere).
> > > Then, we can teach filesystems to use this macro instead of
> > > create_workqueue().
> > 
> > At what point does the workqueue get frozen? i.e. how does this
> > guarantee an unfrozen filesystem will end up in a consistent
> > state?
> 
> Snapshot is atomic; workqueue will be unfrozen with everyone else, but
> as there were no writes in the meantime, there should be no problems.

That doesn't answer my question - when in the sequence of freezing
do you propose diasbling the workqueues? before the kernel threads,
after the kernel threads, before you sync the filesystem? And how does
freezing them at that point in time guarantee consistent filesystem state?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
