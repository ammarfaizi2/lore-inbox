Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265810AbUHAL3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUHAL3L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 07:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUHAL3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 07:29:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37082 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265810AbUHAL3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 07:29:07 -0400
Date: Sun, 1 Aug 2004 07:28:18 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Scott Wood <scott@timesys.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
In-Reply-To: <1091234100.1677.41.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com>
References: <1090732537.738.2.camel@mindpipe>  <1090795742.719.4.camel@mindpipe>
 <20040726082330.GA22764@elte.hu>  <1090830574.6936.96.camel@mindpipe>
 <20040726083537.GA24948@elte.hu>  <1090832436.6936.105.camel@mindpipe>
 <20040726124059.GA14005@elte.hu>  <20040726204720.GA26561@elte.hu>
 <20040729222657.GA10449@elte.hu>  <1091141622.30033.3.camel@mindpipe> 
 <20040730064431.GA17777@elte.hu>  <1091228074.805.6.camel@mindpipe>
 <1091234100.1677.41.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Jul 2004, Lee Revell wrote:

> Results with 2.6.8-rc2-M5:
> 
> Configuration						max usecs
> -----------------------------------------------------------------
> All IRQs threaded					370 
> Soundcard IRQ not threaded				335
> Soundcard IRQ not threaded + max_sectors_kb -> 64	161
> 
> So, it looks like the added configurability does add some overhead - 161
> usecs vs. 50. [...]

+110 usecs is too much to be explained by redirection and configurability
overhead. The configurability overhead is near zero.

could you try to repeat the '50 usecs' test with -L2 [that was the one you
used?] to make sure it's repeatable? The latencies of -L2 and -M5 should
be near identical. The configurability should at most cause a 1-2 usecs
overhead - definitely not two orders of magnitude higher. So if there's a
difference then i must have degraded one of the latency reduction changes
between L2 and M5.

	Ingo
