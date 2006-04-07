Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWDGTmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWDGTmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWDGTmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:42:53 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:43483 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964916AbWDGTmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:42:52 -0400
Subject: Re: [PATCH 2/4] coredump: speedup SIGKILL sending
From: Lee Revell <rlrevell@joe-job.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060407232838.GA11460@oleg>
References: <20060406220628.GA237@oleg> <1144352758.2866.105.camel@mindpipe>
	 <20060406235519.GA331@oleg> <1144354065.2866.116.camel@mindpipe>
	 <20060407232838.GA11460@oleg>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 15:42:47 -0400
Message-Id: <1144438967.22490.90.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-08 at 03:28 +0400, Oleg Nesterov wrote:
> zap_process() disables irqs while traversing ->thread_group list.
> So yes, if a process has a lot of threads it will be a latency regression.
> (but again, __group_complete_signal() does the same while delivering this
> signal, so I don't think this change can make things worse).
> 
> However this allows us to avoid tasklist_lock in zap_threads() so I think
> it is worth it. Please note that tasklist_lock was held while iterating
> over _all_ threads in system, not only current's thread group.
> 

OK sounds good.

Lee

