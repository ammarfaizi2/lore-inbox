Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422940AbWAMUkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422940AbWAMUkk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422937AbWAMUkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:40:40 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:29568 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422938AbWAMUkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:40:39 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       Roger Heflin <rheflin@atipa.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <1137183980.6731.1.camel@localhost.localdomain>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	 <1137168254.7241.32.camel@localhost.localdomain>
	 <1137174463.15108.4.camel@mindpipe>
	 <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
	 <1137174848.15108.11.camel@mindpipe>
	 <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
	 <1137178506.15108.38.camel@mindpipe>
	 <1137182991.8283.7.camel@localhost.localdomain>
	 <1137183980.6731.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 15:40:37 -0500
Message-Id: <1137184837.15108.67.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 15:26 -0500, Steven Rostedt wrote:
> On Fri, 2006-01-13 at 15:09 -0500, Steven Rostedt wrote:
> 
> > Nope it doesn't work :-(
> > 
> > I ran this test:
> >  http://www.kihontech.com/tests/rt/monotonic.c
> > 
> [...]
> > 
> > I'll reboot to vanilla 2.6.15 and see if that is broken too (just to
> > make sure)
> > 
> 
> Failed on 2.6.15 too:

That's what I suspected based on reports from several JACK users (JACK
used to use rdtsc directly, it now uses clock_gettime).

Hmm, it looks like the kernel uses the TSC left and right, even if
clock=pmtmr is used.  There's even an rdtscll in pmtimer_mark_offset().

Wow, what a mess.  Thanks, AMD...

Lee

