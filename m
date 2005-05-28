Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVE1CDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVE1CDm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 22:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVE1CDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 22:03:42 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:63470 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261966AbVE1CC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 22:02:59 -0400
Subject: Re: spinaphore conceptual draft (was discussion of RT patch)
From: Steven Rostedt <rostedt@goodmis.org>
To: David Nicol <davidnicol@gmail.com>
Cc: linux-kernel@vger.kernel.org, john cooper <john.cooper@timesys.com>
In-Reply-To: <934f64a205052715315c21d722@mail.gmail.com>
References: <934f64a205052715315c21d722@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 27 May 2005 22:02:45 -0400
Message-Id: <1117245765.6477.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing you are forgetting is that we are not just talking about the
latencies of contention.  We are talking about the latency of a high
priority process when it wakes up to the time it runs.  Most of the time
a spin lock stops preemption, either with (CONFIG_PREEMPT)
preempt_disable or simple turning off interrupts.  With Ingo's mutexes,
the places with spin_locks are now preemptable.  So there is probably
lots of times that it would be better to just spin on contention, but
that's not what Ingo's spin_locks are saving us.  It's to keep most of
the kernel preemptable.

The priority inheritance of spin_locks is simply there to protect from
priority inversion.

-- Steve


