Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265881AbTFSSWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 14:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbTFSSWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 14:22:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:59119 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265881AbTFSSWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 14:22:53 -0400
Subject: RE: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
	sks
From: Robert Love <rml@tech9.net>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Ingo Molnar'" <mingo@elte.hu>, "'Andrew Morton'" <akpm@digeo.com>,
       "'george anzinger'" <george@mvista.com>,
       "'joe.korty@ccur.com'" <joe.korty@ccur.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Li, Adam" <adam.li@intel.com>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780E04087F@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780E04087F@orsmsx116.jf.intel.com>
Content-Type: text/plain
Message-Id: <1056047804.1066.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 19 Jun 2003 11:36:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-19 at 11:31, Perez-Gonzalez, Inaky wrote:


> I don't think is ideal either, but it is the only way I see where we
> can make sure that no user thread is going to stomp over the kernel
> toes and cause a deadlock (this is a extreme, but it can happen).

Hmm, I guess a deadlock _is_ possible but I think the issue is more of
starvation.

And we can prevent starvation just by running the kernel thread at
FIFO/99, because then it will never be starved by a higher priority
task. If the RT task being starved is also at priority 99, it will
eventually block (as in our example, on console I/O) and let the kernel
thread run. If the RT task being starved is lower priority, then there
is nothing to worry about.

I guess a real deadlock could only occur if the FIFO/99 task does not
block on the resource the kernel thread is providing but busy loops
waiting for it.

It is all a trade off, and rarely a pleasant one...

	Robert Love


