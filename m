Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbVHaMDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbVHaMDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbVHaMDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:03:20 -0400
Received: from mail.joq.us ([67.65.12.105]:3228 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964774AbVHaMDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:03:20 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       jackit-devel@lists.sourceforge.net, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, cc@ccrma.Stanford.EDU,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [Jackit-devel] Re: jack, PREEMPT_DESKTOP, delayed interrupts?
References: <1125453795.25823.121.camel@cmn37.stanford.edu>
	<20050831073518.GA7582@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 31 Aug 2005 07:08:08 -0500
In-Reply-To: <20050831073518.GA7582@elte.hu> (Ingo Molnar's message of "Wed,
 31 Aug 2005 09:35:18 +0200")
Message-ID: <7q64tmnwbb.fsf@io.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> - if everything fails and automatic latency tracing does not show 
>   anything out of ordinary, then you could try to do "user-triggered 
>   tracing" of jackd's critical path. This is more laborous to do, but
>   should pinpoint the latency reason in a pretty sure way.
>
>   user-triggered tracing is done via adding those special gettimeofday 
>   calls to jackd and recompiling jackd. I've attached an older hack
>   against jackd below, you might need to merge it to recent jackd. NOTE: 
>   this patch will only work if you are getting xrun messages from ALSA.  
>   It has to be reworked if your latencies are not actual xruns.

JACK sources already include a CHECK_PREEMPTION() macro which expands
to Ingo's special gettimeofday() calls.  The trace is turned on and
then off automatically before and after the realtime critical section
in the process thread (see libjack/client.c).  

Ingo's suggested ALSA backend patch is not presently included.

There are probably some other places where these macros could usefully
be added.  We will integrate patches adding them in appropriate spots.
They do no harm in vanilla kernels without tracing enabled.

-- 
  joq
