Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbUKPRoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbUKPRoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbUKPRoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:44:24 -0500
Received: from mx2.elte.hu ([157.181.151.9]:46514 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262057AbUKPRoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:44:16 -0500
Date: Tue, 16 Nov 2004 19:43:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Florian Schmidt <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041116184315.GA5492@elte.hu>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> >ok, this new build still hangs at the same spot.
> 
> Me too. The serial console output follows at the end. Will try a few
> boot alternatives and let you know if I can get this to run.
> >From what I can tell, it was attempting to test the NMI watchdog
> when it failed.

i've uploaded -5 with a fix in profile_tick() - does it boot fine for
you now?

Btw., a good way to catch such early bootup bugs is to activate
early-printk over the serial console:

 earlyprintk=serial,ttyS0,38400 console=ttyS0,38400 console=tty0

and in this particular case the most effective serial logging method is:

 earlyprintk=serial,ttyS0,38400,keep console=ttyS0,38400 console=tty0

the 'keep' tells the kernel to keep the early console a bit longer -
which in this particular timer-interrupt crash case produces a more
usable log. (the 'keep' parameter makes the serial console a bit less
useful as a regular console later on, so it should only be used for
crashes that the normal early console doesnt catch.)

	Ingo
