Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWFXWPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWFXWPT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 18:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWFXWPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 18:15:19 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:32749 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751121AbWFXWPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 18:15:17 -0400
Subject: Re: More weird latency trace output (was Re: 2.6.17-rt1)
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <1151025892.17952.32.camel@mindpipe>
References: <20060618070641.GA6759@elte.hu>
	 <1150937848.2754.379.camel@mindpipe>  <1150944663.2754.416.camel@mindpipe>
	 <1151025892.17952.32.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 18:15:19 -0400
Message-Id: <1151187320.2931.191.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 21:24 -0400, Lee Revell wrote:
> On Wed, 2006-06-21 at 22:51 -0400, Lee Revell wrote:
> > How can the latency tracer be reporting 1898us max latency while the
> > trace is of a 12us latency?  This must be a bug, correct?
> 
> I've found the bug.  The latency tracer uses get_cycles() for
> timestamping, which uses rdtsc, which is unusable for timing on dual
> core AMD64 machines due to the well known "unsynced TSCs" hardware bug.
> 
> Would a patch to convert the latency tracer to use gettimeofday() be
> acceptable?

OK, I tried that and it oopses on boot - presumably the latency tracer
runs before clocksource infrastructure is initialized.

Does anyone have any suggestions at all as to what a proper solution
would look like?  Is no one interested in this problem?

Lee

