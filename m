Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271202AbTG1XX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271205AbTG1XX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:23:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8176 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S271202AbTG1XXX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:23:23 -0400
Subject: Re: as / scheduler question
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030728160117.3f679f01.akpm@osdl.org>
References: <200307290908.09065.kernel@kolivas.org>
	 <20030728160117.3f679f01.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1059435029.931.33.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 28 Jul 2003 16:30:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-28 at 16:01, Andrew Morton wrote:

> What does "requeues all threads at 25ms" mean?

I think he is talking about the timeslice granularity Ingo readded in
his latest patch (TIMESLICE_GRANULARITY, which is 25ms with HZ=1000).
Every 25ms the currently running task is preempted if there is another
runnable task at its current priority. I.e., tasks at the same priority
are round-robined every 25ms, until there timeslices expire.

> The only dependency we should have there is that kblockd should be scheduled
> promptly after it is woken.  It is reniced by -10 so it should be OK. 
> Renicing it further or making it SCHED_RR/FIFO would be interesting.

Yep, and I don't think Ingo's patch would effect this.

	Robert Love


