Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVK2EW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVK2EW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 23:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVK2EW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 23:22:56 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:53225 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750739AbVK2EWz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 23:22:55 -0500
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
       acpi-devel@lists.sourceforge.net, len.brown@intel.com,
       nando@ccrma.Stanford.EDU, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com
In-Reply-To: <1133235740.6328.27.camel@localhost.localdomain>
References: <20051115090827.GA20411@elte.hu>
	 <1132336954.20672.11.camel@cmn3.stanford.edu>
	 <1132350882.6874.23.camel@mindpipe>
	 <1132351533.4735.37.camel@cmn3.stanford.edu>
	 <20051118220755.GA3029@elte.hu>
	 <1132353689.4735.43.camel@cmn3.stanford.edu>
	 <1132367947.5706.11.camel@localhost.localdomain>
	 <20051124150731.GD2717@elte.hu>
	 <1132952191.24417.14.camel@localhost.localdomain>
	 <20051126130548.GA6503@elte.hu>
	 <1133232503.6328.18.camel@localhost.localdomain>
	 <20051128190253.1b7068d6.akpm@osdl.org>
	 <1133235740.6328.27.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 20:22:50 -0800
Message-Id: <1133238170.1421.15.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 22:42 -0500, Steven Rostedt wrote:
> On Mon, 2005-11-28 at 19:02 -0800, Andrew Morton wrote:
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > This patch creates a directory in /sys/kernel called idle.
> > >
> > 
> > At no point do you appear to explain _why_ the kernel needs this feature?
> 
> Sorry about that.  This originally came up when we had problems with the
> AMD64 x2 in the -rt patch.  It was noted that the TSCs would get very
> far out of sync and cause problems.  The way to solve this was to set
> idle=poll.  The original patch I sent was to allow the user to change to
> idle=poll dynamically.  This way they could switch to the poll_idle and
> run there tests (requiring tsc not to drift) and then switch back to the
> default idle to save on electricity.

The problem with this is that this must be a one way transition. That
is, once the TSCs have become unsynchronized, there is no use going back
to using the polling idle unless you add some code to re-sync the TSCs
which would be ugly to do after the system has booted.

Using idle=poll (for anything other then debugging) is really a worst
case workaround for systems that do not have alternative clocksources
like ACPI PM or HPET.

Its an interesting bit of code, but I'm not really sure I understand its
usefulness.

thanks
-john



