Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270827AbUJUUhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270827AbUJUUhv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270831AbUJUUhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:37:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60640 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270827AbUJUUeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:34:44 -0400
Date: Thu, 21 Oct 2004 22:33:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Huey <bhuey@lnxw.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021203350.GK32465@suse.de>
References: <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <20041021195842.GA23864@nietzsche.lynx.com> <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021202422.GA24555@nietzsche.lynx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21 2004, Bill Huey wrote:
> On Thu, Oct 21, 2004 at 10:14:43PM +0200, Jens Axboe wrote:
> > On Thu, Oct 21 2004, Bill Huey wrote:
> > > A lot of things are perfectly "valid" in the Linux kernel regarding
> > > stuff like that are a bit irregular. But the preemption work about
> > > to stress these things in ways that was never designed to which is
> > > why these patches are needed. Having a clear use of various locking
> > > conventions is key to getting this system to behave in a predictable
> > > manner. Quite simply, Linux was never targetted to do this and the
> > > sloppiness is showing so it's got to be removed.
> > 
> > I have to disagree, I don't think the above use is either convoluted or
> > sloppy in any way. Now that we have the completion structure, certain
> > things are surely better implemented as such. But the old use is
> > perfectly valid and logical, imho.
> 
> You use a semaphore to protect data, a completion isn't protecting data
> but preserving a certain kind of wait ordering in the code. The
> possibility of overloading the current mutex_t for PI makes for a conceptual
> mismatch when used in this case since having a kind of priority for
> completions is a bit odd. It's better to flat out use a completion
> instead, IMO.

Linux semaphores (being counted) have always been a fine fit for things
like the loop use, where you get to down it 10 times because you have 10
items pending. I know this isn't the traditional mutex and that it
doesn't protect data as such, but is was never abuse. It isn't overload.
Doing it with a traditional mutex (I'm assuming this is what mutex_t is
in Ingos tree) would be overload and a bad idea, indeed.

-- 
Jens Axboe

