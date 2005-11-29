Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVK2ECK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVK2ECK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 23:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVK2ECK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 23:02:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750707AbVK2ECI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 23:02:08 -0500
Date: Mon, 28 Nov 2005 20:01:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, acpi-devel@lists.sourceforge.net, len.brown@intel.com,
       nando@ccrma.Stanford.EDU, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Message-Id: <20051128200108.068b2dcd.akpm@osdl.org>
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
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 2005-11-28 at 19:02 -0800, Andrew Morton wrote:
>  > Steven Rostedt <rostedt@goodmis.org> wrote:
>  > >
>  > > This patch creates a directory in /sys/kernel called idle.
>  > >
>  > 
>  > At no point do you appear to explain _why_ the kernel needs this feature?
> 
>  Sorry about that.  This originally came up when we had problems with the
>  AMD64 x2 in the -rt patch.  It was noted that the TSCs would get very
>  far out of sync and cause problems.

Unsynced TSCs are rare, but they happen.  I guess even if we were to resync
them, these measurements would screw up.


> The way to solve this was to set
>  idle=poll.  The original patch I sent was to allow the user to change to
>  idle=poll dynamically.  This way they could switch to the poll_idle and
>  run there tests (requiring tsc not to drift) and then switch back to the
>  default idle to save on electricity.

Use gettimeofday()?

If it's just for some sort of instrumentation, run NR_CPUS instances of a
niced-down busyloop, pin each one to a different CPU?  That way the idle
function doesn't get called at all..

