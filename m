Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754447AbWKHI3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447AbWKHI3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 03:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754449AbWKHI3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 03:29:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41885 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1754436AbWKHI3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 03:29:20 -0500
Date: Wed, 8 Nov 2006 19:27:22 +1100
From: David Chinner <dgc@sgi.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Alasdair G Kergon <agk@redhat.com>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Ingo Molnar <mingo@elte.hu>, Srinivasa DS <srinivasa@in.ibm.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061108082722.GH8394166@melbourne.sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611080005.50070.rjw@sisk.pl> <45511430.8030703@redhat.com> <200611080042.03563.rjw@sisk.pl> <20061108000109.GE30653@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108000109.GE30653@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 12:01:09AM +0000, Alasdair G Kergon wrote:
> On Wed, Nov 08, 2006 at 12:42:02AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, 8 November 2006 00:18, Eric Sandeen wrote:
> > > But, how is a stampede of fs-freezers -supposed- to work?  I could
> > > imagine something like a freezer count, and the filesystem is only
> > > unfrozen after everyone has thawed?  Or should only one freezer be
> > > active at a time... which is what we have now I guess.
> > I think it shouldn't be possible to freeze an fs more than once.
> 
> In device-mapper today, the only way to get more than one freeze on the
> same device is to use xfs and issue xfs_freeze before creating an lvm snapshot
> (or issuing the dmsetup equivalent), and at the moment we tell people not to do
> that any more.

But it's trivial to detect this condition - if (sb->s_frozen != SB_UNFROZEN)
then the filesystem is already frozen and you shouldn't try to freeze
it again. It's simple to do, and the whole problem then just goes away....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
