Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbVJZI2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbVJZI2J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 04:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVJZI2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 04:28:09 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:24261 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932589AbVJZI2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 04:28:08 -0400
Date: Wed, 26 Oct 2005 10:28:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: john stultz <johnstul@us.ibm.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU, William Weston <weston@lysdexia.org>
Subject: Re: 2.6.14-rc4-rt7
Message-ID: <20051026082800.GB28660@elte.hu>
References: <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu> <20051022035851.GC12751@elte.hu> <1130182121.4983.7.camel@cmn3.stanford.edu> <1130182717.4637.2.camel@cmn3.stanford.edu> <1130183199.27168.296.camel@cog.beaverton.ibm.com> <20051025154440.GA12149@elte.hu> <1130264218.27168.320.camel@cog.beaverton.ibm.com> <435E91AA.7080900@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435E91AA.7080900@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> The TSC is such a fast and, usually, accurate answer, I think it 
> deserves a little effort to save it.  With your new clock code I think 
> we could use per cpu TSC counters, read the full 64 bits and, in real 
> corner cases, even per cpu conversion "constants" and solve this 
> problem.

the problem is, this is the same issue as 'boot-time TSC syncing', but 
in disguise: to get any 'per CPU TSC offset' you need to do exactly the 
same type of careful all-CPUs-dance to ensure that the TSCs were sampled 
at around the same moment in time!

The box where i have these small TSC inconsistencies shows that it's the 
bootup synchronization of TSCs that failed to be 100% accurate. Even a 2 
usecs error in synchronization can show up as a time-warp - regardless 
of whether we keep per-CPU TSC offsets or whether we clear these offsets 
back to 0. So it is not a solution to do another type of synchronization 
dance. The only solution is to fix the boot-time synchronization (where 
the hardware keeps TSCs synchronized all the time), or to switch TSCs 
off where this is not possible.

	Ingo
