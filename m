Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270834AbUJUUwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270834AbUJUUwv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270939AbUJUUws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:52:48 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:63395
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270834AbUJUUvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:51:44 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Bill Huey <bhuey@lnxw.com>
Cc: Jens Axboe <axboe@suse.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
In-Reply-To: <20041021203821.GA24628@nietzsche.lynx.com>
References: <20041020094508.GA29080@elte.hu>
	 <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
	 <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de>
	 <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de>
	 <20041021195842.GA23864@nietzsche.lynx.com>
	 <20041021201443.GF32465@suse.de>
	 <20041021202422.GA24555@nietzsche.lynx.com>
	 <20041021203350.GK32465@suse.de>
	 <20041021203821.GA24628@nietzsche.lynx.com>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098391421.27089.83.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 22:43:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 22:38, Bill Huey wrote:
> On Thu, Oct 21, 2004 at 10:33:50PM +0200, Jens Axboe wrote:
> > On Thu, Oct 21 2004, Bill Huey wrote:
> > > You use a semaphore to protect data, a completion isn't protecting data
> > > but preserving a certain kind of wait ordering in the code. The
> > > possibility of overloading the current mutex_t for PI makes for a conceptual
> > > mismatch when used in this case since having a kind of priority for
> > > completions is a bit odd. It's better to flat out use a completion
> > > instead, IMO.
> > 
> > Linux semaphores (being counted) have always been a fine fit for things
> > like the loop use, where you get to down it 10 times because you have 10
> > items pending. I know this isn't the traditional mutex and that it
> > doesn't protect data as such, but is was never abuse. It isn't overload.
> > Doing it with a traditional mutex (I'm assuming this is what mutex_t is
> > in Ingos tree) would be overload and a bad idea, indeed.
> 
> Well, this is something that's got to be considered by the larger Linux
> community and whether these conventions are to be kept or removed. It's
> a larger issue than what can be address in Ingo's preemption patch, but
> with inevitable need for something like this in the kernel (hard RT)
> it's really unavoidable collision. IMO, it's got to go, which is a nasty
> change.
> 

Hey, let's stop this here.

You are both (in)correct :)

1. It makes no sense to discuss, why X has been considered correct for
time T.

2. Counted semaphores are a valid use and should be marked explicit as
counted semaphores.

3. Using mutexes and semaphores for event and completion signalling
should be converted to the appropriate interfaces. 

A bunch of work, but not really hard.

tglx


