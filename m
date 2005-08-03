Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVHCKET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVHCKET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVHCKET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:04:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25495 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262184AbVHCKDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:03:47 -0400
Date: Wed, 3 Aug 2005 18:08:49 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050803100849.GE9812@redhat.com>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org> <20050803035618.GB9812@redhat.com> <1123060630.3363.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123060630.3363.10.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 11:17:09AM +0200, Arjan van de Ven wrote:
> On Wed, 2005-08-03 at 11:56 +0800, David Teigland wrote:
> > The point is you can define GFS2_ENDIAN_BIG to compile gfs to be BE
> > on-disk instead of LE which is another useful way to verify endian
> > correctness.
> 
> that sounds wrong to be a compile option. If you really want to deal
> with dual disk endianness it really ought to be a runtime one (see jffs2
> for example).

We don't want BE to be an "option" per se; as developers we'd just like to
be able to compile it that way to verify gfs's endianness handling.  If
you think that's unmaintainable or a bad idea we'll rip it out.

> > > * +	while (!kthread_should_stop()) {
> > > +		gfs2_scand_internal(sdp);
> > > +
> > > +		set_current_state(TASK_INTERRUPTIBLE);
> > > +		schedule_timeout(gfs2_tune_get(sdp, gt_scand_secs) * HZ);
> > > 
> > > you probably really want to check for signals if you do
> > > interruptible sleeps
> > 
> > I don't know why we'd be interested in signals here.
> 
> well.. because if you don't your schedule_timeout becomes a nop when you
> get one, which makes your loop a busy waiting one.

OK, it looks like we need to block/flush signals a la daemonize(); I guess
I mistakenly figured the kthread routines did everything daemonize did.
Thanks,
Dave

