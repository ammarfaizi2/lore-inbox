Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVHSDfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVHSDfD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbVHSDfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:35:01 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26832 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932086AbVHSDfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:35:00 -0400
Subject: Re: [RFC] IPV4 long lasting timer function
From: Lee Revell <rlrevell@joe-job.com>
To: tglx@linutronix.de
Cc: "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1124312341.23647.277.camel@tglx.tec.linutronix.de>
References: <1124312341.23647.277.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 23:34:57 -0400
Message-Id: <1124422498.25424.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 22:59 +0200, Thomas Gleixner wrote:
> Hi,
> 
> while tracking down some timer related ugliness I stumbled over the
> timer driven function rt_secret_rebuild(), which does a loop over
> rt_has_mask (1024 in my case) entries and possibly some subsequent
> variable sized loops inside each step.
> 
> On a 300MHZ PPC system this accumulated to a worst case total of >5ms. I
> could not reproduce it with this magnitude, but applying heavy
> networking load is definitely triggering this behaviour.
> 
> Shouldn't this be converted to a workqueue, which gets triggered by a
> timer instead of blocking the timer softirq and therefor the delivery of
> other timer functions that long ?

Wow, blast from the past!  This was one of the very first problematic
code paths Ingo and I identified in the early days of the voluntary
preempt patch (using the crude ALSA xrun debug mechanism which was the
best we had before /proc/latency_trace).

IIRC I was able to trivially reproduce it by leaving gtk-gnutella
running overnight with a few active searches/downloads.

Lee

