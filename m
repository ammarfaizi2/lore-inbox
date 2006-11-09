Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161802AbWKIXd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161802AbWKIXd1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161835AbWKIXd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:33:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17811 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161802AbWKIXd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:33:26 -0500
Date: Fri, 10 Nov 2006 00:32:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061109233258.GH2616@elf.ucw.cz>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611092218.58970.rjw@sisk.pl> <20061109214159.GB2616@elf.ucw.cz> <200611092321.47728.rjw@sisk.pl> <20061109231146.GD2616@elf.ucw.cz> <20061109232438.GS30653@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109232438.GS30653@agk.surrey.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Fri, Nov 10, 2006 at 12:11:46AM +0100, Pavel Machek wrote:
> > ? Not sure if I quite understand, but if dm breaks sync... something
> > is teribly wrong with dm. And we do simple sys_sync()... so I do not
> > think we have a problem.
>  
> If you want to handle arbitrary kernel state, you might have a device-mapper
> device somewhere lower down the stack of devices that is queueing any I/O
> that reaches it.  So anything waiting for I/O completion will wait until 
> the dm process that suspended that device has finished whatever it is doing
> - and that might be a quick thing carried out by a userspace lvm tool, or
> a long thing carried out by an administrator using dmsetup.
> 
> I'm guessing you need a way of detecting such state lower down the stack
> then optionally either aborting the operation telling the user it can't be
> done at present; waiting for however long it takes (perhaps for ever if
> the admin disappeared); or more probably skipping those devices on a 
> 'best endeavours' basis.

Okay, so you claim that sys_sync can stall, waiting for administator?

In such case we can simply do one sys_sync() before we start freezing
userspace... or just more the only sys_sync() there. That way, admin
has chance to unlock his system.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
