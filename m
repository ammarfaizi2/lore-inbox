Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbUKVJbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUKVJbd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 04:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUKVJbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 04:31:33 -0500
Received: from mail.onestepahead.de ([62.96.100.59]:25317 "EHLO
	mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S261998AbUKVJb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 04:31:29 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
From: Christian Meder <chris@onestepahead.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
In-Reply-To: <20041119095451.GC27642@elte.hu>
References: <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu>
	 <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu>
	 <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
	 <20041118123521.GA29091@elte.hu>
	 <49222.195.245.190.94.1100789179.squirrel@195.245.190.94>
	 <20041118210517.GA8703@elte.hu> <1100818448.3476.17.camel@localhost>
	 <20041119095451.GC27642@elte.hu>
Content-Type: text/plain
Date: Mon, 22 Nov 2004 10:31:00 +0100
Message-Id: <1101115860.4182.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 10:54 +0100, Ingo Molnar wrote: 
> * Christian Meder <chris@onestepahead.de> wrote:
> 
> > This just leaves me with the mysterious traceless jvm related crash.
> > I'll do my best to get a trace ;-)
> 
> it would be equally useful to somehow reproduce the lockup with public
> software only, and post the precise steps how to reproduce it.

Hi Ingo,

after two evenings of experimenting this is the current status
(everything based on 0.7.29-0, will try 0.7.30-x during the day):

* the lockup can't be triggered from the console or using a remote
session and I really tried to torture the box ;-)
* the real trigger is mouse activity in X
* the other important factor is running the jvm in profiling mode,
running without jvm or with the jvm in non-profiling mode leaves the box
stable
* I couldn't yet figure out the pattern of java program which is
triggering. Not every java program is triggering but at least I found
several public available ones. I wrote some small test programs doing
simple multithreading but they didn't trigger.

So the simplest setup I found til now is the following: 

chris@blue:~$ java -version
java version "1.4.1"
Java(TM) 2 Runtime Environment, Standard Edition (build Blackdown-1.4.1-01)
Java HotSpot(TM) Client VM (build Blackdown-1.4.1-01, mixed mode)
chris@blue:~$ JAVA_OPTIONS=-Xrunhprof:cpu=samples,file=crap.log,depth=3 jython 
Jython 2.1 on java1.4.1 (JIT: null)
Type "copyright", "credits" or "license" for more information.
>>>

Now moving the mouse around in X will make the box lockup in less than
10 seconds.

I'm not sure if JAVA_OPTIONS is a standard jython feature but at least
it's part of the jython-wrapper script of Debian.



				Christian

-- 
Christian Meder, email: chris@onestepahead.de

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

