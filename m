Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbUKRTIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbUKRTIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbUKRTG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:06:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:60810 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262896AbUKRTEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:04:14 -0500
Date: Thu, 18 Nov 2004 21:06:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christian Meder <chris@onestepahead.de>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
Message-ID: <20041118200603.GC25938@elte.hu>
References: <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <1100791410.3397.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100791410.3397.15.camel@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christian Meder <chris@onestepahead.de> wrote:

> I've got one of those 'my box just locked up'. I can reproduce it with
> 0.7.25-1, 0.7.28-0 and 0.7.28-1 by starting the Jetty servlet
> container with our inhouse java project under a Blackdown 1.4 jdk.
> Within a minute the laptop just locks up: no mouse, no ping, console
> switching sysrq-t or anything. The peculiar thing is that I was
> running 0.7.25-1 for two or three days before and it was rocksolid. It
> was just when I started to work with the jvm that things fell apart.
> 
> Any chance to get any interesting and helpful data in this setup ?

best would be to have a reproducer. Can you trigger it over the network,
using a remote session? If yes then you might want to try this: let the
box boot in, switch it to a text console and dont touch the keyboard
after that. Do this over the remote session:

	echo 1 > /proc/sys/kernel/debug_direct_keyboard

this activates a direct interrupt line for the keyboard only. Keep the
box on the text-console, and try to reproduce the hang over the network. 
Once it triggers, try SysRq - does it work? (leds wont work, but normal
keys should work.)

if the keyboard still doesnt work then you could try nmi_watchdog=1 or
nmi_watchdog=2 (the latter on IO-APIC-less systems), and serial logging,
to capture a dump of the hard-lockup.

	Ingo
