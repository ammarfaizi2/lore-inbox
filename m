Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932953AbWKQTPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932953AbWKQTPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933573AbWKQTPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:15:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35522 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933577AbWKQTOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:14:52 -0500
Date: Fri, 17 Nov 2006 20:13:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Walker <dwalker@mvista.com>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
Message-ID: <20061117191350.GA19101@elte.hu>
References: <20061116153553.GA12583@elte.hu> <1163694712.26026.1.camel@localhost.localdomain> <Pine.LNX.4.64.0611162212110.21141@frodo.shire> <1163713469.26026.4.camel@localhost.localdomain> <20061116220733.GA17217@elte.hu> <1163779116.6953.38.camel@mindpipe> <20061117161742.GA10182@elte.hu> <1163789144.6953.57.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163789144.6953.57.camel@mindpipe>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Fri, 2006-11-17 at 17:17 +0100, Ingo Molnar wrote:
> > thanks, please do that. Right now i have no open boot-crash regression 
> > left that i can reproduce.
> 
> Possibly old news, but with 2.6.18-rt7 this user gets an Oops in
> read_hpet() if high res timers are enabled.
> 
> http://ubuntuforums.org/showthread.php?t=292071

hm, that bug could still be around - does the patch below fix it? I've 
uploaded -rt3 and soon there will be -rt3 rpms in the YUM repository 
too.

	Ingo

Index: linux/drivers/char/hpet.c
===================================================================
--- linux.orig/drivers/char/hpet.c
+++ linux/drivers/char/hpet.c
@@ -909,9 +909,7 @@ int hpet_alloc(struct hpet_data *hdp)
 	hpetp->hp_delta = hpet_calibrate(hpetp);
 
 	if (!hpet_clocksource_p) {
-#ifdef CONFIG_IA64
-        	clocksource_hpet.fsys_mmio_ptr = hpet_mc_ptr = &hpetp->hp_hpet->hpet_mc;
-#endif
+        	hpet_mc_ptr = &hpetp->hp_hpet->hpet_mc;
         	clocksource_hpet.mult = clocksource_hz2mult(hpetp->hp_tick_freq,
                                                    clocksource_hpet.shift);
         	clocksource_register(&clocksource_hpet);
