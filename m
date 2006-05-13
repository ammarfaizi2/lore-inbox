Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWEMPj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWEMPj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWEMPj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:39:57 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:35781 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751332AbWEMPj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:39:57 -0400
Date: Sat, 13 May 2006 11:39:41 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mike Galbraith <efault@gmx.de>
cc: Florian Paul Schmidt <mista.tapas@gmx.net>,
       Darren Hart <dvhltc@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt20 scheduling latency testcase and failure data
In-Reply-To: <1147521338.7909.5.camel@homer>
Message-ID: <Pine.LNX.4.58.0605131137070.27751@gandalf.stny.rr.com>
References: <200605121924.53917.dvhltc@us.ibm.com>  <20060513112039.41536fb5@mango.fruits>
 <1147521338.7909.5.camel@homer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 May 2006, Mike Galbraith wrote:

> On Sat, 2006-05-13 at 11:20 +0200, Florian Paul Schmidt wrote:
>
> > P.S.: I ran the test a few [20 or so] times and didn't get any failures
> > of the sort you see. Even with a 1ms period:
>
> Something odd happened here... the first time I booted rt21, I could
> reproduce the problem quite regularly.  Since reboot though, poof.
>
> Elves and Gremlins.
>

Careful, rt21 has a bug slipped in that might have funny results on SMP
machines:

+		if (!cpus_equal(current->cpus_allowed, irq_affinity[irq]));
+			set_cpus_allowed(current, irq_affinity[irq]);

John (although he later fixed it) added a ; after the if.  But the fix is
not yet in Ingo's patch.

-- Steve
