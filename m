Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268912AbUHMA1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268912AbUHMA1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268913AbUHMA1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:27:32 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:23265 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268912AbUHMA1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:27:25 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Paul Davis <paul@linuxaudiosystems.com>
In-Reply-To: <1092355488.1304.52.camel@mindpipe>
References: <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe>
	 <20040811073149.GA4312@elte.hu> <20040811074256.GA5298@elte.hu>
	 <1092210765.1650.3.camel@mindpipe> <20040811090639.GA8354@elte.hu>
	 <20040811141649.447f112f@mango.fruits.de> <20040811124342.GA17017@elte.hu>
	 <1092268536.1090.7.camel@mindpipe>  <20040812072127.GA20386@elte.hu>
	 <1092347654.11134.10.camel@mindpipe>  <1092355488.1304.52.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1092356877.1304.58.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 20:27:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 20:04, Lee Revell wrote:

> So, it seems that if a SCHED_FIFO process opens a PCM device using mmap, 
> then mlockall's the memory, then another process mlockall's memory, the 
> result is an xrun 100% of the time.
> 

I have found that around 1400 KB is a magic number on my system, this
triggers the preempt violation/xrun about 50% of the time.  1300 never
triggers it, 1500 always triggers it.

Also the amount of memory being mlockall'ed does not affect the length
of the preemption violation - if we hit it at all, there's a 10ms
latency, whether we lock 1400KB or 100MB.

Hopefully O6 will give enough info to track this down.

Lee

