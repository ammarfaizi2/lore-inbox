Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbULNTeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbULNTeb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 14:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbULNTeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 14:34:31 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:11167 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261625AbULNTeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 14:34:21 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <20041214132834.GA32390@elte.hu>
References: <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
	 <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu>  <20041214132834.GA32390@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Tue, 14 Dec 2004 14:34:13 -0500
Message-Id: <1103052853.3582.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC]

Ingo,

Any thought about adding a one shot timer for the system? 

I know there's been talk about this in the mainline (actually going on
right now in the dynamic Hz thread), but I figured that this would
especially be good for a RT system and not be worried about the HZ
settings.  

An example would be to have the timer interrupt be implemented as a one
shot timer, and be able to register actions to times with it.  The jiffy
calculations could just be an event that is registered to go off once
every HZ.  The timer interrupt would then just have to look at all the
events that have expired (using something like the TSC to determine what
expires), execute their registered actions, and if need be, the action
could add itself back on the event queue (the jiffy timer would do
this), and then the timer would set itself to go off at the next event.
I believe something like this was done by the utime patch (now with the
KURT project).

This way the RT processes would not need to depend on the HZ settings.

I'd be willing to implement this, since I'm doing it regardless for a
client of mine. But I would like to know your input on this.

Thanks,

-- Steve

