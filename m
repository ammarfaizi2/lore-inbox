Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVFAIfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVFAIfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 04:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVFAIfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 04:35:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64640 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261334AbVFAIfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 04:35:09 -0400
Date: Wed, 1 Jun 2005 10:23:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RT : 2.6.12rc5 + realtime-preempt-2.6.12-rc5-V0.7.47-15
Message-ID: <20050601082351.GA30690@elte.hu>
References: <1117551231.19367.48.camel@ibiza.btsn.frna.bull.fr> <1117568825.23283.5.camel@mindpipe> <1117613246.5580.70.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1117613246.5580.70.camel@ibiza.btsn.frna.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> Le mar 31/05/2005 à 21:47, Lee Revell a écrit :
> > On Tue, 2005-05-31 at 16:53 +0200, Serge Noiraud wrote:
> > > I have a test program which made a loop in RT to mesure the system
> > > perturbation.
> > > It works finely in a tty environment.
> > > When I run it in an X environment ( xterm ), I get something like if I
> > > click the Enter key in the active window.
> > > If I open a new xterm, this is the new active window which receive these
> > > events.
> > > These events stop when the program stop.
> > > 
> > > I tried with X in RT and no RT : I have the problem.
> > 
> > Try adding:
> > 
> > Option "NoAccel"
> Same problem.

could you enable latency timing and tracing in the .config:

 CONFIG_CRITICAL_PREEMPT_TIMING=y
 CONFIG_CRITICAL_IRQSOFF_TIMING=y
 CONFIG_LATENCY_TIMING=y
 CONFIG_LATENCY_TRACE=y

and start a new search for a maximum latency via:

 echo 0 > /proc/sys/kernel/preempt_max_latency

and then do the X test - what is the largest latency reported in 
'dmesg'? Also, please send me a (bzip2 -9 compressed, if too large) 
/proc/latency_trace trace output of the largest incident.

	Ingo
