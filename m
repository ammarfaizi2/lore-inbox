Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWKGXuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWKGXuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 18:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbWKGXuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 18:50:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52440 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751803AbWKGXuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 18:50:15 -0500
Date: Tue, 7 Nov 2006 23:49:51 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Srinivasa DS <srinivasa@in.ibm.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061107234951.GD30653@agk.surrey.redhat.com>
Mail-Followup-To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com, Ingo Molnar <mingo@elte.hu>,
	Srinivasa DS <srinivasa@in.ibm.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061107122837.54828e24.akpm@osdl.org> <45510C73.7060408@redhat.com> <200611080005.50070.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611080005.50070.rjw@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 12:05:49AM +0100, Rafael J. Wysocki wrote:
> But freeze_bdev() is supposed to return the result of get_super(bdev)
> _unconditionally_.  Moreover, in its current form freeze_bdev() _cannot_
> _fail_, so I don't see how this change doesn't break any existing code.
> For example freeze_filesystems() (recently added to -mm) will be broken
> if the down_trylock() is unsuccessful.
 
I hadn't noticed that -mm patch.  I'll take a look.  Up to now, device-mapper
(via dmsetup) and xfs (via xfs_freeze, which dates from before device-mapper
handled this automatically) were the only users.  Only one freeze should be
issued at once.  A freeze is a temporary thing, normally used while creating a
snapshot.  (One problem we still have is lots of old documentation on the web
advising people to run xfs_freeze before creating device-mapper snapshots.)

You're right that the down_trylock idea is more trouble than it's worth and
should be scrapped.

Alasdair
-- 
agk@redhat.com
