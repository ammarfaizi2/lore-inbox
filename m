Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbULNN2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbULNN2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 08:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbULNN2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 08:28:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:19677 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261504AbULNN2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 08:28:50 -0500
Date: Tue, 14 Dec 2004 14:28:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Message-ID: <20041214132834.GA32390@elte.hu>
References: <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207141123.GA12025@elte.hu>
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


i have released the -V0.7.33-0 Real-Time Preemption patch, which can be
downloaded from the usual place:

  http://redhat.com/~mingo/realtime-preempt/

this is mainly a port from -rc2-mm3 to -rc3-mm1. Changes:

- due to 2.6.10 release work the -mm kernel now is in fixes-mostly mode,
  but there's one interesting new feature: -rc3-mm1 introduced the
  ->unlocked_ioctl method which is now an official way to do BKL-less
  ioctls. I changed the ALSA ->ioctl_bkl changes in -RT to use this
  facility. The ALSA/sound guys might be interested in these bits. Thus
  another chunk of -RT could go upstream.

- IO-APIC/MSI fix from Steven Rostedt.

- fixed a tracer bug which would produce a kernel warning and an empty
  /proc/latency_trace if the trace buffer overflows.

to create a -V0.7.33-0 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc3.bz2
  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc3/2.6.10-rc3-mm1/2.6.10-rc3-mm1.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc3-mm1-V0.7.33-0

	Ingo
