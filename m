Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbULMWTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbULMWTT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbULMWSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:18:50 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:1165 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261210AbULMWQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:16:25 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: Steven Rostedt <rostedt@goodmis.org>
To: Bill Huey <bhuey@lnxw.com>
Cc: Esben Nielsen <simlo@phys.au.dk>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>, Ingo Molnar <mingo@elte.hu>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <20041213215549.GB29432@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10412112027540.6963-100000@da410.ifa.au.dk>
	 <1102804480.3691.32.camel@localhost.localdomain>
	 <20041213215549.GB29432@nietzsche.lynx.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Mon, 13 Dec 2004 17:15:00 -0500
Message-Id: <1102976100.3582.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-13 at 13:55 -0800, Bill Huey wrote:

> 
> One thing that I noticed in this thread is that even though you were talking
> about the mechanisms to support these features, it really needs some
> consideration as to how it's going to effect the stock kernel since you're
> really introduction a first-class threading object/concept into the system.
> That means changes to the scheduler, how QoS fits into this, etc...
> IMO, it's ultimately about QoS and that alone is a hot button since it's
> so invasive throughout the kernel.
> 

Is there any talk about Ingo's patch getting into the mainstream kernel?

> Creating a special threaded server object (thinking out loud) might be a
> good idea in that it could be attached to any arbitrary subsystem at will,
> assuming if that particular subsystem's logic permits this easily.
> 
> It's not a light topic and can certain require more folks pushing it. I'm
> very interested in getting something like this into Linux, but stability,
> latency regularity, contention are things that still need a lot of work.
>  
> > The packet queue was a heap queue sorted by priority. The parts of the
> > TCP/IP stack was broken up into sections. The receive thread would only
> > process the packet on top of the queue. At the end of the section, it
> > would check to see if the queue changed and then start processing the
> > packet on top, if a higher packet came in at that time.  So the packets
> > on the queue had a state attached to them.  When the packet eventually
> > made it to the process waiting, it was then handled by that process. So
> > if a process was waiting, the process would have been woken up and it
> > would handle the rest of the processing. Otherwise the receive thread
> > would do it up to where it can drop it off to the processes. I set the
> > packet to be once less priority of the process it was sent from and the
> > one it was going to.
> > 
> > The sending was done mostly by the process, but if it had to wait for
> > some reason, the sending thread would take over.
> > 
> > This was mostly academic in nature, but was a lot of fun and interesting
> > to see how results changed with different methods.
> 
> This is a good track to research casually since not that many people have
> done so, and so that the problem space is mapped in this particular kernel.
> With things like VoIP and relatives becoming popular, this is becoming
> more and more essential over time.
> 
> It's up to you, but I think this is a great track to pursue.. That's because
> if you don't do it, somebody else will... :)
> 

I'd love to keep up on it, but now I'm working on a contract that's
taking all of my time. I did this some time back using the TimeSys GPL
kernel.  Of course I didn't have the priority inheritance (it's a
proprietary module), but it was good for my needs.

The work I'm now doing may swing back into this field, and we'll see
what happens.  As I said earlier, this was very much academic and needs
lots of work. I did notice that the processors today make the TCP/IP
stack very fast, but the big improvement was the separate queue for
packets coming in and seeing right a way that they need to be processed
ahead of other packets, as well as other processes.

> bill
> 
