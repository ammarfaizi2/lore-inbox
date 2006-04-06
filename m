Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWDFVXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWDFVXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 17:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWDFVXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 17:23:40 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64202 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751324AbWDFVXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 17:23:39 -0400
Subject: Re: [PATCH 2/4] coredump: speedup SIGKILL sending
From: Lee Revell <rlrevell@joe-job.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060406235519.GA331@oleg>
References: <20060406220628.GA237@oleg> <1144352758.2866.105.camel@mindpipe>
	 <20060406235519.GA331@oleg>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 16:07:45 -0400
Message-Id: <1144354065.2866.116.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 03:55 +0400, Oleg Nesterov wrote:
> On 04/06, Lee Revell wrote:
> > On Fri, 2006-04-07 at 02:06 +0400, Oleg Nesterov wrote:
> > > With this patch a thread group is killed atomically under ->siglock.
> > > This is faster because we can use sigaddset() instead of force_sig_info()
> > > and this is used in further patches.
> > > 
> > > Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> > 
> > Won't this cause huge latencies when a process with lots of threads is
> > killed?
> 
> Yes, irqs are disabled. But this is not worse than 'kill -9 pid', note
> that __group_complete_signal() or zap_other_threads() do the same.

Those have been problematic in the past.  I am just wondering if this
will be a latency regression, or if changes elsewhere in your patch
negate the effect.

I'm just concerned because it was a lot of work over ~2 years to get 2.6
to perform decently in this area, and we have regressed since 2.6.14 (VM
issue).

Lee

