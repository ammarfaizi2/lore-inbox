Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUJIU70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUJIU70 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUJIU70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:59:26 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:9374 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267400AbUJIU7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:59:11 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: karim@opersys.com
Cc: stefan.eletzhofer@eletztrick.de,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <41684FC6.1070803@opersys.com>
References: <41677E4D.1030403@mvista.com> <416822B7.5050206@opersys.com>
	 <1097346628.1428.11.camel@krustophenia.net>
	 <20041009212614.GA25441@tier.local>
	 <1097350227.1428.41.camel@krustophenia.net>
	 <20041009213817.GB25441@tier.local>
	 <1097351221.1428.46.camel@krustophenia.net>  <416845E4.206@opersys.com>
	 <1097352885.1428.60.camel@krustophenia.net>  <41684FC6.1070803@opersys.com>
Content-Type: text/plain
Message-Id: <1097355547.1428.79.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 16:59:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 16:53, Karim Yaghmour wrote:
> Lee Revell wrote:
> > In theory, I think yes, if all IRQs on the system run in threads except
> > the saw interrupt, and the RT task that controls the saw runs at a
> > higher priority than all the IRQ threads.  You can guarantee that other
> > interrupts won't delay the saw, because the saw irq is the only thing on
> > the system that runs in interrupt context.  With the current VP
> > implementation you are still bounded by the longest non-preemptible code
> > path in the kernel AKA the longest time that a spinlock is held. 
> > Replacing most spinlocks with mutexes reduces this to less than 20 code
> > paths according to Mvista, which then can be individually audited for
> > RT-safeness. 
> > 
> > That being said, no way would I put my hand under the saw with the
> > current implementation.  But, unless I am missing something, it seems
> > like this kind of determinism is possible with the Mvista design.
> 
> It may be a question of taste, but even if that did work, which I am
> not convinced of, it seems to me that it's awfully convoluted.
> With the current interrupt pipeline mechanism part of Adeos, on
> which RTAI and RTAI fusion are built, I can give you absolute hard-rt
> deterministic guarantees while keeping the spinlocks intact, and not
> having to check for the rt-safeness of any part of the kernel. You
> just write the time-sensitive saw driver int handler in front of
> Linux in the ipipe and you're done: 100% deterministic hard-rt,
> regardless of the application load and the driver set.

True, there are probably too many "ifs" in my above statement for a saw
or an airplane or a power plant.  There does seem to be a gray area
between soft and hard realtime, where either approach could be
reasonable.  For example the Mt. St. Helens example, where you could
miss a sample and it would be really bad, but not kill anyone.

Lee

