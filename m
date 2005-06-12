Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVFLOzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVFLOzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 10:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVFLOzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 10:55:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15838 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262615AbVFLOzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 10:55:16 -0400
Date: Sun, 12 Jun 2005 16:54:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: James R Bruce <bruce@andrew.cmu.edu>
Cc: Karim Yaghmour <karim@opersys.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, pmarques@grupopie.com,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050612145401.GB15864@elte.hu>
References: <42AA6A6B.5040907@opersys.com> <20050611070845.GA4609@elte.hu> <42AAF5CE.9080607@opersys.com> <20050611145240.GA10881@elte.hu> <42AB2209.9080006@opersys.com> <20050611181528.GA15019@elte.hu> <38010.210.137.194.5.1118573221.squirrel@210.137.194.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38010.210.137.194.5.1118573221.squirrel@210.137.194.5>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* James R Bruce <bruce@andrew.cmu.edu> wrote:

> Ingo, if you could document the right options required for decent 
> performace somewhere it would be quite helpful (maybe in 
> Documentation/rt-preempt?).  My first test of Preempt-RT showed 
> unexpectedly high overhead for a fairly benign network load (120 UDP 
> packets/sec), but that was likely the result of leaving some debugging 
> options on.

agreed, this needs to be addressed.

in the latest patch (-48-17 or later) i have changed the debugging 
options to default to off. (this wont turn them off if your .config has 
them turned on already, but will turn them off for new testers' 
.configs)

I also added a prominent boot-time message that, if certain 
high-overhead debugging options are enabled, says:

*****************************************************************************
*                                                                           *
* WARNING, the following debugging options are turned on in your .config:   *
*                                                                           *
*        CONFIG_DEBUG_RT_LOCKING_MODE                                       *
*        CONFIG_RT_DEADLOCK_DETECT                                          *
*        CONFIG_DEBUG_PREEMPT                                               *
*        CONFIG_CRITICAL_PREEMPT_TIMING                                     *
*        CONFIG_CRITICAL_IRQSOFF_TIMING                                     *
*        CONFIG_LATENCY_TRACE                                               *
*        CONFIG_DEBUG_SLAB                                                  *
*                                                                           *
* they may increase runtime overhead and latencies considerably!            *
*                                                                           *
*****************************************************************************

wrt. documentation - i'm not a big doc writer, but i'm taking patches
:-)

	Ingo
