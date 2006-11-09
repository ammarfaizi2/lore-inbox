Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424150AbWKIVVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424150AbWKIVVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424152AbWKIVVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:21:41 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:3499 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1424150AbWKIVVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:21:40 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Date: Thu, 9 Nov 2006 22:18:57 +0100
User-Agent: KMail/1.9.1
Cc: Alasdair G Kergon <agk@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611092059.48722.rjw@sisk.pl> <20061109211722.GA2616@elf.ucw.cz>
In-Reply-To: <20061109211722.GA2616@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611092218.58970.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 9 November 2006 22:17, Pavel Machek wrote:
> Hi!
> 
> > > > OTOH I have no idea _how_ we can tell xfs that the processes have been
> > > > frozen.  Should we introduce a global flag for that or something?
> > > 
> > > I guess XFS should just do all the writes from process context, and
> > > refuse any writing when its threads are frozen... I actually still
> > > believe it is doing the right thing, because you can't really write to
> > > disk from timer.
> > 
> > This is from a work queue, so in fact from a process context, but from
> > a process that is running with PF_NOFREEZE.
> 
> Why not simply &~ PF_NOFREEZE on that particular process? Filesystems
> are free to use threads/work queues/whatever, but refrigerator should
> mean "no writes to filesystem" for them...

But how we differentiate worker_threads used by filesystems from the
other ones?

BTW, I think that worker_threads run with PF_NOFREEZE for a reason,
but what exactly is it?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
