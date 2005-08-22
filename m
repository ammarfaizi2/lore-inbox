Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVHVWaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVHVWaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVHVWaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:30:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21129 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751426AbVHVWZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:25:22 -0400
Date: Mon, 22 Aug 2005 09:57:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: 2.6.13-rc6-rt9
Message-ID: <20050822075722.GD19386@elte.hu>
References: <20050818060126.GA13152@elte.hu> <1124433586.5186.119.camel@localhost.localdomain> <1124456445.5186.124.camel@localhost.localdomain> <1124465786.5186.142.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124465786.5186.142.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 2005-08-19 at 09:00 -0400, Steven Rostedt wrote:
> > On Fri, 2005-08-19 at 02:39 -0400, Steven Rostedt wrote:
> 
> > I haven't thought of a good way yet to solve the race condition with
> > dependent sleeper. (Except by turning off CONFIG_WAKEUP_TIMING :-)
> > 
> 
> OK, I found one simple solution. The problem stems from max_mutex 
> being grabbed.  Since this uses the RT locks, and since tracing 
> shouldn't really care about PI and all that, I switched this to a 
> compat_semaphore, but only if CONFIG_WAKEUP_TIMING is set. This seems 
> to get rid of this race condition that I have.

ok, i have applied your patch and have done a small tweak: i made it a 
compat semaphore unconditionally. There's no point in #ifdefing it on 
WAKEUP_TIMING.

> I found more bugs, but for now this message is about this specific 
> race.

ok.

	Ingo
