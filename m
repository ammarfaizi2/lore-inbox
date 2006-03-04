Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWCDF16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWCDF16 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 00:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWCDF16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 00:27:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:36255 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751081AbWCDF15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 00:27:57 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-rc5-mm2]  sched_cleanup-V17 - task throttling
	patch 1 of 2
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       lkml <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200603041624.06656.kernel@kolivas.org>
References: <1140183903.14128.77.camel@homer>
	 <4408FC8B.4050802@bigpond.net.au> <1141449654.7703.36.camel@homer>
	 <200603041624.06656.kernel@kolivas.org>
Content-Type: text/plain
Date: Sat, 04 Mar 2006 06:29:47 +0100
Message-Id: <1141450187.7703.40.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-04 at 16:24 +1100, Con Kolivas wrote:
> On Saturday 04 March 2006 16:20, Mike Galbraith wrote:
> > On Sat, 2006-03-04 at 13:33 +1100, Peter Williams wrote:
> > > >  include/linux/sched.h |    3 -
> > > >  kernel/sched.c        |  136
> > > > +++++++++++++++++++++++++++++--------------------- 2 files changed, 82
> > > > insertions(+), 57 deletions(-)
> > > >
> > > > --- linux-2.6.16-rc5-mm2/include/linux/sched.h.org	2006-03-01
> > > > 15:06:22.000000000 +0100 +++
> > > > linux-2.6.16-rc5-mm2/include/linux/sched.h	2006-03-02
> > > > 08:33:12.000000000 +0100 @@ -720,7 +720,8 @@
> > > >
> > > >  	unsigned long policy;
> > > >  	cpumask_t cpus_allowed;
> > > > -	unsigned int time_slice, first_time_slice;
> > > > +	int time_slice;
> > >
> > > Can you guarantee that int is big enough to hold a time slice in
> > > nanoseconds on all systems?  I think that you'll need more than 16 bits.
> >
> > Nope, that's a big fat bug.
> 
> Most ints are 32bit anyway, but even a 32 bit unsigned int overflows with 
> nanoseconds at 4.2 seconds. A signed one at about half that. Our timeslices 
> are never that large, but then int isn't always 32bit either.

Yup.  I just didn't realize that there were 16 bit integers out there.

	-Mike

