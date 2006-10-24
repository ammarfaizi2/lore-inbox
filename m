Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWJXQsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWJXQsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbWJXQsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:48:12 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:693 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1030424AbWJXQsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:48:10 -0400
Subject: Re: -rt7 announcement? (was Re: 2.6.18-rt6) and more info about a
	compile error
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: sergio@sergiomb.no-ip.org, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <1161664706.22373.48.camel@localhost.localdomain>
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe>  <1161621286.2835.3.camel@mindpipe>
	 <1161628539.22373.36.camel@localhost.localdomain>
	 <1161635161.2948.12.camel@localhost.portugal>
	 <1161636049.3982.18.camel@mindpipe>
	 <1161653206.2996.17.camel@localhost.portugal>
	 <1161664706.22373.48.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 09:48:07 -0700
Message-Id: <1161708487.2414.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is this new functionality? I thought -rt7 was just moving to the -mm'ish
hrtimers. What's changing the rtmutex?

Daniel

On Tue, 2006-10-24 at 06:38 +0200, Thomas Gleixner wrote:
> Index: linux-2.6.18/kernel/rtmutex.c
> ===================================================================
> --- linux-2.6.18.orig/kernel/rtmutex.c	2006-10-24 06:33:02.000000000 +0200
> +++ linux-2.6.18/kernel/rtmutex.c	2006-10-24 06:31:55.000000000 +0200
> @@ -902,7 +902,10 @@ static inline void rt_reacquire_bkl(int 
>  }
>  
>  #else
> -# define rt_release_bkl(x)	(-1)
> +static inline int rt_release_bkl(struct rt_mutex *lock, unsigned long flags)
> +{
> +	return -1;
> +}
>  # define rt_reacquire_bkl(x)	do { } while (0)
>  #endif
>  
> 
> 

