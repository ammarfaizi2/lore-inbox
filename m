Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbUJWTjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbUJWTjY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbUJWTjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 15:39:24 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:58532
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261286AbUJWTjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 15:39:19 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Lee Revell <rlrevell@joe-job.com>
Cc: paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
In-Reply-To: <1098558876.13176.54.camel@krustophenia.net>
References: <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
	 <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
	 <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>
	 <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu>
	 <20041022175633.GA1864@elte.hu>  <20041023185132.GA1268@us.ibm.com>
	 <1098558876.13176.54.camel@krustophenia.net>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 23 Oct 2004 21:31:13 +0200
Message-Id: <1098559873.3306.159.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 15:14 -0400, Lee Revell wrote:
> On Sat, 2004-10-23 at 11:51 -0700, Paul E. McKenney wrote:
> > On Fri, Oct 22, 2004 at 07:56:33PM +0200, Ingo Molnar wrote:
> > > 
> > > i have released the -U10.2 Real-Time Preemption patch, which can be
> > > downloaded from:
> > > 
> > >   http://redhat.com/~mingo/realtime-preempt/
> > 
> > On realtime-preempt-2.6.9-mm1-U10.3:
> > 
> > o	In rcupdate.h, I believe that the:
> > 
> > 	+# define rcu_read_unlock_nort()                rcu_read_lock_nort()
> > 
> > 	should instead be:
> > 
> > 	+# define rcu_read_unlock_nort()                rcu_read_unlock()
> > 
> 
> Oh no!  That would explain a lot... the typical report is it works fine
> until people go to use the network :-P

Yes and No !

The wrong define is in the #else path of CONFIG_PREEMPT_REALTIME, so it
affects the kernel only when it is built with PREEMPT_REALTIME
disabled. 

The network problem with PREEMPT_REALTIME enabled is a subtle race,
which I have nearly tracked down. I know the scenario, but I have not
yet identified the culprit. (:

tglx




