Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVBJHxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVBJHxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 02:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVBJHxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 02:53:44 -0500
Received: from mx1.elte.hu ([157.181.1.137]:31940 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262040AbVBJHxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 02:53:37 -0500
Date: Thu, 10 Feb 2005 08:52:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@lysdexia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050210075234.GC9436@elte.hu>
References: <20050204100347.GA13186@elte.hu> <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org> <20050209115121.GA13608@elte.hu> <Pine.LNX.4.58.0502091233360.4599@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502091233360.4599@echo.lysdexia.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-3.012, required 5.9,
	BAYES_00 -4.90, PORN_4 1.89
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@lysdexia.org> wrote:

> > what is the longest wakeup latency the tracer shows? You can start the
> > measurement anew via:
> > 
> > 	echo 0 > /proc/sys/kernel/preempt_max_latency
> 
> Max latency is in the realm of 13-18 after runs of jack_test4.1.

that's 13-18 microsecond worst-case delay from point of wakeup to the
point the woken up task has been context-switched to - pretty good for a
generic OS ;-)

> See http://www.sysex.net/testing/ for the all of the test results and
> system info on a 2.6.11-rc3-RT-V0.7.38-06 kernel.

your latency traces look perfectly fine, and the jack_test results look
good too.

> Now that the priorities are tuned, I get no xruns while running
> wmcube, compiling a kernel, and running latencytest or jack_test4.1.

ah, very good! Now that the setup is properly tuned for audio latencies,
you might want to try to push up the number of jack_test clients again,
to see how far you can go. Right now there's a ~50% DSP load with 14
clients, so maybe you can push it up to 20 clients. (for this test
you'll likely want to turn off all options in the 'Kernel Hacking' menu
- they increase overhead. Otherwise you probably want to run with the
current options, so that you can send me BUG and latency traces ;) )

> This patch does fix the MIDI playback BUG I was seeing.

ok.

	Ingo
