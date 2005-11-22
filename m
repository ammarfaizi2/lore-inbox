Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVKVB2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVKVB2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVKVB2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:28:35 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62640 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964821AbVKVB2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:28:34 -0500
Subject: Re: 2.6.14-rt13 does not build
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1132600755.29178.80.camel@mindpipe>
References: <1132599511.29178.69.camel@mindpipe>
	 <1132600755.29178.80.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 20:28:29 -0500
Message-Id: <1132622910.4772.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 14:19 -0500, Lee Revell wrote:
> On Mon, 2005-11-21 at 13:58 -0500, Lee Revell wrote:
> >   CC      kernel/ktimers.o
> > kernel/ktimers.c: In function 'enqueue_ktimer':
> > kernel/ktimers.c:756: error: incompatible type for argument 1 of
> > 'trace_special_u64'
> > make[1]: *** [kernel/ktimers.o] Error 1
> > make: *** [kernel] Error 2
> 
> The problem is specific to !CONFIG_HIGH_RES_TIMERS.  This seems to fix
> it (untested):
> 
> -#define ktimer_trace(a,b)		trace_special_u64(a,b)
> +#define ktimer_trace(a,b)		trace_special(ktime_get_high(a),ktime_get_low(a),b)

No good, this double faults on boot.  I'm trying to work around it by
compiling with high res timers even though I don't have the hardware to
support them.

Lee

