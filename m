Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWBQTz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWBQTz0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWBQTz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:55:26 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:32900 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751580AbWBQTzY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:55:24 -0500
Date: Fri, 17 Feb 2006 20:55:15 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
Message-ID: <20060217195515.GA12501@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Ulrich Drepper <drepper@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arjan van de Ven <arjan@infradead.org>,
	David Singleton <dsingleton@mvista.com>,
	Andrew Morton <akpm@osdl.org>
References: <20060215151711.GA31569@elte.hu> <20060216145823.GA25759@linuxtv.org> <20060216172007.GB29151@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216172007.GB29151@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 84.190.141.209
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006, Ingo Molnar wrote:
> 
> * Johannes Stezenbach <js@linuxtv.org> wrote:
> 
> > Anyway: If a process can trash its robust futext list and then die 
> > with a segfault, why are the futexes still robust? In this case the 
> > kernel has no way to wake up waiters with FUTEX_OWNER_DEAD, or does 
> > it?
> 
> that's memory corruption - which robust futexes do not (and cannot) 
> solve. Robustness is mostly about handling sudden death (e.g. which is 
> due to oom, or is due to a user killing the task, or due to the 
> application crashing in some non-memory-corrupting way), but it cannot 
> handle all possible failure modes.

Hm, OK, from reading this and the other threads on this
topic I get:

- there is a tradeoff between speed and robustness
- the focus for "robust futexes" is on speed
  (else they wouldn't deserve to be called futexes)
- thus it is acceptable if they are just 99% robust

That's OK, but IMHO it wouldn't hurt to clearly spell
it out in the documentation.


However, this leaves the question: Is there a slower, but 100% robust
alternative on Linux for applications which need it?


Johannes
