Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264134AbUFPQsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUFPQsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbUFPQsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:48:15 -0400
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:24986 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S264134AbUFPQqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:46:12 -0400
Subject: Re: [PATCH]: Option to run cache reap in thread mode
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Dimitri Sivanich <sivanich@sgi.com>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF8BFC6C05.81791687-ON86256EB5.005A7A6C@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Wed, 16 Jun 2004 11:43:48 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(651HF13 | February 05, 2004) at
 06/16/2004 11:44:33 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





>Well, if you want deterministic interrupt latencies you should go for a
realtime OS.
>I know Linux is the big thing in the industry, but you're really better
off looking
>for a small Hard RT OS.  From the OpenSource world eCOS or RTEMS come to
mind.  Or even
>rtlinux/rtai if you want to run a full linux kernel as idle task.

I don't think the OP wants to run RT on Linux but has customers who want to
do so. Customers of course, are a pretty stubborn bunch and will demand to
use the system in ways you consider inappropriate. You may be arguing with
the wrong guy.

Getting back to the previous comment as well
>YAKT, sigh..  I don't quite understand what you mean with a "holdoff" so
>maybe you could explain what problem you see?  You don't like cache_reap
>beeing called from timer context?

Are you concerned so much about the proliferation of kernel threads or the
fact that this function is getting moved from the timer context to a
thread?

If the first case - one could argue that we don't need separate threads
titled
 - migration
 - ksoftirq
 - events
 - kblockd
 - aio
and so on [and now cache_reap], one per CPU if there was a mechanism to
schedule work to be done on a regular basis on each CPU. Perhaps this patch
should be modified to work with one of these existing kernel threads
instead (or collapse a few of these into a "janitor thread" per CPU).

If the second case, can you explain the rationale for the concern more
fully. I would expect moving stuff out of the timer context would be a
"good thing" for most if not all systems - not just those wanting good real
time response.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

