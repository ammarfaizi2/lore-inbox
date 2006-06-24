Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWFXQT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWFXQT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 12:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWFXQT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 12:19:27 -0400
Received: from mail.gmx.net ([213.165.64.21]:3714 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750871AbWFXQT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 12:19:27 -0400
X-Authenticated: #14349625
Subject: Re: Measuring tools - top and interrupts
From: Mike Galbraith <efault@gmx.de>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: danial_thom@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060624154037.GA2946@atjola.homenet>
References: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
	 <1151128763.7795.9.camel@Homer.TheSimpsons.net>
	 <1151130383.7545.1.camel@Homer.TheSimpsons.net>
	 <20060624092156.GA13142@atjola.homenet>
	 <1151142716.7797.10.camel@Homer.TheSimpsons.net>
	 <1151149317.7646.14.camel@Homer.TheSimpsons.net>
	 <20060624154037.GA2946@atjola.homenet>
Content-Type: text/plain; charset=utf-8
Date: Sat, 24 Jun 2006 18:23:12 +0200
Message-Id: <1151166193.8516.8.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 17:40 +0200, Björn Steinbrink wrote:
> On 2006.06.24 13:41:57 +0200, Mike Galbraith wrote:
> > On Sat, 2006-06-24 at 11:52 +0200, Mike Galbraith wrote:
> > > On Sat, 2006-06-24 at 11:21 +0200, Björn Steinbrink wrote:
> > > > 
> > > > The non-SMP call to update_process_times() is in do_timer_interrupt_hook(),
> > > > so I guess the above is not the Right Thing to do.
> > > 
> > > Ah, there it is.  That's what I was looking for.  I figured that doing
> > > what I did had to be wrong, but tried it for grins anyway... was pretty
> > > surprised when it worked (kinda).
> > 
> > Calling update_process_times() in do_timer_interrupt_hook() flat does
> > not work here.  Calling it in smp_local_timer_interrupt() works fine.  
> > 
> > Oh joy.
> 
> I can reproduce it now, seems to require CONFIG_4KSTACKS to fail. Can
> you confirm that?

What a coincidence.  After trying a different compiler, and slogging
through a bunch of assembler trying to figure out how the heck this can
happen, I was just booting an 8k stack kernel (as a wild-ass guess;).

let's see.  Yeah, confirmed.

	-Mike

