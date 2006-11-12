Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753265AbWKLV4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbWKLV4g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 16:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbWKLV4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 16:56:36 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:35529 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1753265AbWKLV4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 16:56:36 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Date: Sun, 12 Nov 2006 22:53:56 +0100
User-Agent: KMail/1.9.1
Cc: Alasdair G Kergon <agk@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611101303.33685.rjw@sisk.pl> <20061112184310.GC5081@ucw.cz>
In-Reply-To: <20061112184310.GC5081@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611122253.57201.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 12 November 2006 19:43, Pavel Machek wrote:
> Hi!
> 
> > > Okay, so you claim that sys_sync can stall, waiting for administator?
> > > 
> > > In such case we can simply do one sys_sync() before we start freezing
> > > userspace... or just more the only sys_sync() there. That way, admin
> > > has chance to unlock his system.
> > 
> > Well, this is a different story.
> > 
> > My point is that if we call sys_sync() _anyway_ before calling
> > freeze_filesystems(), then freeze_filesystems() is _safe_ (either the
> > sys_sync() blocks, or it doesn't in which case freeze_filesystems() won't
> > block either).
> > 
> > This means, however, that we can leave the patch as is (well, with the minor
> > fix I have already posted), for now, because it doesn't make things worse a
> > bit, but:
> > (a) it prevents xfs from being corrupted and
> 
> I'd really prefer it to be fixed by 'freezeable workqueues'. Can you
> point me into sources -- which xfs workqueues are problematic?

I think these:

http://www.linux-m32r.org/lxr/http/source/fs/xfs/linux-2.6/xfs_buf.c?a=x86_64#L1829

But then, there's also this one

http://www.linux-m32r.org/lxr/http/source/fs/reiserfs/journal.c?a=x86_64#L2837

and some others that I had no time to trace.

> (It would be nice to fix that for 2.6.19, and full bdev freezing looks
> intrusive to me).

IMHO changing __create_workqueue() will be even more intrusive.

> > (b) it prevents journaling filesystems in general from replaying journals
> > after a failing resume.
> 
> I do not see b) as an useful goal.

Okay, let's forget it.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
