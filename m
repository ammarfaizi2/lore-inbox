Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVBGI5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVBGI5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 03:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVBGI5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 03:57:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64467 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261242AbVBGI5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 03:57:43 -0500
Date: Mon, 7 Feb 2005 09:57:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.11-rc3-mm1: softlockup and suspend/resume
Message-ID: <20050207085728.GA17197@elte.hu>
References: <20050204103350.241a907a.akpm@osdl.org> <200502051548.26729.rjw@sisk.pl> <20050205190700.GA2323@elte.hu> <200502062015.56458.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502062015.56458.rjw@sisk.pl>
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


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > ah, ok. Could you try my patch and add touch_softlockup_watchdog() to
> > the resume code (before interrupts are re-enabled)?
> 
> I did:
> 
> --- /home/rafael/tmp/kernel/testing/linux-2.6.11-rc3-mm1/kernel/power/swsusp.c	2005-02-05 20:57:03.000000000 +0100
> +++ linux-2.6.11-rc3-mm1/kernel/power/swsusp.c	2005-02-06 19:07:39.000000000 +0100
> @@ -871,6 +869,7 @@
>  	restore_processor_state();
>  	restore_highmem();
>  	device_power_up();
> +	touch_softlockup_watchdog();
>  	local_irq_enable();
>  	return error;
>  }
> 
> and it still complains, but the call trace is now different:

could you describe the timings a bit more - how long it takes to do the
resume, and when does the watchdog print out its warning. Is it a single
warning only, and once the resume succeeds, the watchdog doesnt complain
anymore, correct?

	Ingo
