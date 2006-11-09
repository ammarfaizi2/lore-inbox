Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161209AbWKIUCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbWKIUCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161803AbWKIUCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:02:13 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:14506 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161209AbWKIUCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:02:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Date: Thu, 9 Nov 2006 20:59:47 +0100
User-Agent: KMail/1.9.1
Cc: Alasdair G Kergon <agk@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611091652.34649.rjw@sisk.pl> <20061109160003.GA24156@elf.ucw.cz>
In-Reply-To: <20061109160003.GA24156@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611092059.48722.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 9 November 2006 17:00, Pavel Machek wrote:
> Hi!
> 
> > > > Well, it looks like the interactions with dm add quite a bit of
> > > > complexity here.
> > > 
> > > What about just fixing xfs (thou shall not write to disk when kernel
> > > threads are frozen), and getting rid of blockdev freezing?
> > 
> > Well, first I must admit you were absolutely right being suspicious with
> > respect to this stuff.
> 
> (OTOH your patch found real bugs in suspend.c, so...)
> 
> > OTOH I have no idea _how_ we can tell xfs that the processes have been
> > frozen.  Should we introduce a global flag for that or something?
> 
> I guess XFS should just do all the writes from process context, and
> refuse any writing when its threads are frozen... I actually still
> believe it is doing the right thing, because you can't really write to
> disk from timer.

This is from a work queue, so in fact from a process context, but from
a process that is running with PF_NOFREEZE.

And I don't think we can forbid filesystems to use work queues.  IMO it's
a legitimate thing to do for an fs.

_But_.

Alasdair, do I think correctly that if there's a suspended device-mapper
device below an non-frozen filesystem, then sys_sync() would block just
as well as freeze_bdev() on this filesystem?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
