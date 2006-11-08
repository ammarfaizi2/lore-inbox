Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753726AbWKHABo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbWKHABo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 19:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbWKHABn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 19:01:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37857 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753725AbWKHABn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 19:01:43 -0500
Date: Wed, 8 Nov 2006 00:01:09 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Srinivasa DS <srinivasa@in.ibm.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061108000109.GE30653@agk.surrey.redhat.com>
Mail-Followup-To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com, Ingo Molnar <mingo@elte.hu>,
	Srinivasa DS <srinivasa@in.ibm.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611080005.50070.rjw@sisk.pl> <45511430.8030703@redhat.com> <200611080042.03563.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611080042.03563.rjw@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 12:42:02AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, 8 November 2006 00:18, Eric Sandeen wrote:
> > But, how is a stampede of fs-freezers -supposed- to work?  I could
> > imagine something like a freezer count, and the filesystem is only
> > unfrozen after everyone has thawed?  Or should only one freezer be
> > active at a time... which is what we have now I guess.
> I think it shouldn't be possible to freeze an fs more than once.

In device-mapper today, the only way to get more than one freeze on the
same device is to use xfs and issue xfs_freeze before creating an lvm snapshot
(or issuing the dmsetup equivalent), and at the moment we tell people not to do
that any more.  The device-mapper API does not permit multiple freezes of the
same device.  (The interesting question is actually whether the request should
be cascaded in any way when devices depend on other devices.)

Now if someone's introducing a new use for freeze_bdev, perhaps now's the time
to revisit the semantics and allow for concurrent freeze requests.

Alasdair
-- 
agk@redhat.com
