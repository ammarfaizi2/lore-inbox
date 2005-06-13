Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVFMPBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVFMPBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVFMPBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:01:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64914 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261590AbVFMPBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:01:31 -0400
Date: Mon, 13 Jun 2005 17:00:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050613150021.GA5891@elte.hu>
References: <42AA6A6B.5040907@opersys.com> <20050611191448.GA24152@elte.hu> <42AB662B.4010104@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AB662B.4010104@opersys.com>
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


* Karim Yaghmour <karim@opersys.com> wrote:

> Ingo Molnar wrote:
> > how were interrupt response times measured, precisely? What did the 
> > target (measured) system have to do to respond to an interrupt? Did you 
> > use the RTC to measure IRQ latencies?
> 
> The logger used two TSC values. One prior to shooting the interrupt to 
> the target, and one when receiving the response. Responding to an 
> interrupt meant that a driver was hooked to the target's parallel port 
> interrupt and simply acted by toggling an output pin on the parallel 
> port, which in turn was hooked onto the logger's parallel port in a 
> similar fashion. [...]

FYI, there's a new feature in the -V0.7.48-25 (and later) -RT patches 
that implements this: CONFIG_LPPTEST. It is a simple standalone driver 
and userspace utility from Thomas Gleixner that can be used to measure 
the IRQ-latency of the system over a null-modem-parallel-cable.

to use it, enable CONFIG_LPPEST in the .config [disable CONFIG_PARPORT 
first], boot the kernel on both the target and the host systems, and 
then run the scripts/testlpp utility on the host system which will 
measure latencies and will do a maximum-search.

(the driver assumes normal LPT1 PC layout - 0x378/IRQ7)

	Ingo
