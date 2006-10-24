Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWJXOqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWJXOqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWJXOqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:46:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36839 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932288AbWJXOqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:46:33 -0400
Date: Wed, 25 Oct 2006 00:44:46 +1000
From: David Chinner <dgc@sgi.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, xfs@oss.sgi.com
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061024144446.GD11034@melbourne.sgi.com>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610231236.54317.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 12:36:53PM +0200, Rafael J. Wysocki wrote:
> On Monday, 23 October 2006 06:12, Nigel Cunningham wrote:
> > XFS can continue to submit I/O from a timer routine, even after
> > freezeable kernel and userspace threads are frozen. This doesn't seem to
> > be an issue for current swsusp code,
> 
> So it doesn't look like we need the patch _now_.
> 
> > but is definitely an issue for Suspend2, where the pages being written could
> > be overwritten by Suspend2's atomic copy.
> 
> And IMO that's a good reason why we shouldn't use RCU pages for storing the
> image.  XFS is one known example that breaks things if we do so and
> there may be more such things that we don't know of.  The fact that they
> haven't appeared in testing so far doesn't mean they don't exist and
> moreover some things like that may appear in the future.

Could you please tell us which XFS bits are broken so we can get
them fixed?  The XFS daemons should all be checking if they are
supposed to freeze (i.e. they call try_to_freeze() after they wake
up due to timer expiry) so I thought they were doing the right
thing.

However, I have to say that I agree with freezing the filesystems
before suspend - at least XFS will be in a consistent state that can
be recovered from without corruption if your machine fails to
resume....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
