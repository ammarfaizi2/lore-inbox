Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932749AbWFWBYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbWFWBYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWFWBYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:24:40 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59858 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932749AbWFWBYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:24:40 -0400
Subject: Re: More weird latency trace output (was Re: 2.6.17-rt1)
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1150944663.2754.416.camel@mindpipe>
References: <20060618070641.GA6759@elte.hu>
	 <1150937848.2754.379.camel@mindpipe>  <1150944663.2754.416.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 21:24:52 -0400
Message-Id: <1151025892.17952.32.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 22:51 -0400, Lee Revell wrote:
> How can the latency tracer be reporting 1898us max latency while the
> trace is of a 12us latency?  This must be a bug, correct?

I've found the bug.  The latency tracer uses get_cycles() for
timestamping, which uses rdtsc, which is unusable for timing on dual
core AMD64 machines due to the well known "unsynced TSCs" hardware bug.

Would a patch to convert the latency tracer to use gettimeofday() be
acceptable?

Lee

