Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbUK0ESf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbUK0ESf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbUK0EMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:12:39 -0500
Received: from zeus.kernel.org ([204.152.189.113]:28865 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262234AbUKZTQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:16:17 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Jackit-devel] Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
References: <20041029203320.GC5186@elte.hu>
	<200410292051.i9TKptOi007283@localhost.localdomain>
	<20041029211112.GA9836@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: 26 Nov 2004 11:16:38 -0600
In-Reply-To: <20041029211112.GA9836@elte.hu>
Message-ID: <87mzx4pm2x.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> if it's possible to 'silently' overrun the next due interrupt (somewhat,
> but not large enough overrun to cause a hard ALSA xrun) then the
> processing delay will i believe be accounted as a 'wakeup delay'. In
> that case to make the delayed_usecs value truly accurate, i'd at least
> add this:
> 
>                 poll_enter = jack_get_microseconds ();
> 
> 		if (poll_enter > driver->poll_next) {
> 			/*
> 			 * This processing cycle got delayed over
> 			 * the next due interrupt! Do not account this
> 			 * as a wakeup delay:
> 			 */
> 			driver->poll_next = 0;
> 		}
> 
> but i'd also suggest to put in a counter into that branch so that this
> condition doesnt get lost. 

Added the test Ingo suggests plus a new counter (poll_late) to CVS,
JACK version 0.99.13.
-- 
  joq
