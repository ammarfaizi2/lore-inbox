Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266908AbUKAQDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266908AbUKAQDN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269146AbUKAQDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 11:03:12 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:58535
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S267540AbUKAPzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 10:55:35 -0500
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
In-Reply-To: <20041101140630.GA20448@elte.hu>
References: <20041031120721.GA19450@elte.hu>
	 <20041031124828.GA22008@elte.hu>
	 <1099227269.1459.45.camel@krustophenia.net>
	 <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu>
	 <20041031162059.1a3dd9eb@mango.fruits.de>
	 <20041031165913.2d0ad21e@mango.fruits.de>
	 <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu>
	 <20041101135358.GA19718@elte.hu>  <20041101140630.GA20448@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Organization: linutronix
Date: Mon, 01 Nov 2004 16:47:20 +0100
Message-Id: <1099324040.3337.32.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 15:06 +0100, Ingo Molnar wrote:
> ah, found it. Only RT tasks were supposed to get special priority
> handling, while in fact all tasks got it - so when Thomas ran hackbench
> (Thomas, you did, right?) it created an O(nr_hackbench) overhead within
> the mutex code ... I've uploaded -V0.6.5 to the usual place:

Yes, I was running hackbench as usual

>   http://redhat.com/~mingo/realtime-preempt/
> 
> Thomas, can you confirm that this kernel fixes the irqs-off latencies? 
> (the priority loop indeed was done with irqs turned off.)

The latencies are still there. I have the feeling it's worse than 0.6.2.

It's definitely irq-off. I have a card with a controller, which produces
an 2ms interrupt. The controller busy loops until the second level ack
is done. The time is measured from raising the irq to the 2nd level ack.

The irqhandler is using NODELAY and keeps irqs disabled. So the measured
time in the controller is the irqs disabled time + the irq latency
(which is ~7µs). The testrun on 0.6.5 showed latencies up to 600µs
within 10 minutes.

After 15 Mintes the keyboard was dead. 

I'm porting some of the Libertos debugging stuff into 0.6.5, so I can
instrument the problem. 

More later.

tglx




