Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbUKVNdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbUKVNdT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 08:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUKVNdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 08:33:18 -0500
Received: from mail.onestepahead.de ([62.96.100.59]:8337 "EHLO
	mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S262098AbUKVNc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 08:32:56 -0500
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
In-Reply-To: <20041122130519.GB13574@elte.hu>
References: <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu>
	 <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
	 <20041118123521.GA29091@elte.hu>
	 <49222.195.245.190.94.1100789179.squirrel@195.245.190.94>
	 <20041118210517.GA8703@elte.hu> <1100818448.3476.17.camel@localhost>
	 <20041119095451.GC27642@elte.hu> <1101115860.4182.7.camel@localhost>
	 <20041122130519.GB13574@elte.hu>
Content-Type: text/plain
Date: Mon, 22 Nov 2004 14:32:45 +0100
Message-Id: <1101130365.3356.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 14:05 +0100, Ingo Molnar wrote:
> * Christian Meder <chris@onestepahead.de> wrote:
> 
> > * the other important factor is running the jvm in profiling mode,
> > running without jvm or with the jvm in non-profiling mode leaves the
> > box stable
> 
> ah ... CPU profiling i suspect needs SIGPROF, and that is one of the
> things that i had to disable in -RT. But it seems this disabling wasnt
> fully correct - could you try the patch i attached, does it change the
> symptoms?

I tried it on top of 0.7.29-0 and it seemed to survive a little bit
longer but it doesn't change fundamentally i.e. I've got to wiggle the
mouse for maybe 20 seconds instead of 10 before the kernel locks up.

> 
> > So the simplest setup I found til now is the following: 
> > 
> > chris@blue:~$ java -version
> > java version "1.4.1"
> > Java(TM) 2 Runtime Environment, Standard Edition (build Blackdown-1.4.1-01)
> > Java HotSpot(TM) Client VM (build Blackdown-1.4.1-01, mixed mode)
> > chris@blue:~$ JAVA_OPTIONS=-Xrunhprof:cpu=samples,file=crap.log,depth=3 jython 
> > Jython 2.1 on java1.4.1 (JIT: null)
> > Type "copyright", "credits" or "license" for more information.
> > >>>
> > 
> > Now moving the mouse around in X will make the box lockup in less than
> > 10 seconds.
> > 
> > I'm not sure if JAVA_OPTIONS is a standard jython feature but at least
> > it's part of the jython-wrapper script of Debian.
> 
> on a FC3 box this gives me:
> 
>  saturn:~> JAVA_OPTIONS=-Xrunhprof:cpu=samples,file=crap.log,depth=3 jython
>  Exception in thread "main" java.lang.NoClassDefFoundError: error:
> 
> (i'm getting the same message when purely running 'jython')
> 
> i've got:
> 
>  saturn:~> java -version
>  java version "1.4.2_03"
>  Java(TM) 2 Runtime Environment, Standard Edition (build 1.4.2_03-b02)
>  Java HotSpot(TM) Client VM (build 1.4.2_03-b02, mixed mode)
> 
> is my java setup botched perhaps?

I'd rather guess your jython setup is botched. I'm sending you offlist
another simple test case which just involves a simple start of the Jetty
servlet container.


				Christian

-- 
Christian Meder, email: chris@onestepahead.de

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

