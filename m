Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVATRTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVATRTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVATRTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:19:37 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24327
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262241AbVATRPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 12:15:50 -0500
Date: Thu, 20 Jan 2005 18:15:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: oom killer gone nuts
Message-ID: <20050120171544.GN12647@dualathlon.random>
References: <20050120123402.GA4782@suse.de> <20050120131556.GC10457@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120131556.GC10457@pclin040.win.tue.nl>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 38 12 CD 76 E4 82 94 AF 02 0C 0F FA E1 FF 55 9D 9B 4F A5 9B
X-Cpushare-SSL-MD5-Cert: ED A5 F2 DA 1D 32 75 60 5E 07 6C 91 BF FC B8 85
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 02:15:56PM +0100, Andries Brouwer wrote:
> On Thu, Jan 20, 2005 at 01:34:06PM +0100, Jens Axboe wrote:
> 
> > Using current BK on my x86-64 workstation, it went completely nuts today
> > killing tasks left and right with oodles of free memory available.
> 
> Yes, the fact that the oom-killer exists is a serious problem.
> People work on trying to tune it, instead of just removing it.

I'm working on fixing it, not just tuning it. The bugs in mainline
aren't about the selection algorithm (which is normally what people
calls oom killer). The bugs in mainline are about being able to kill a
task reliably, regardless of which task we pick, and every linux kernel
out there has always killed some task when it was oom. So the bugs are
just obvious regressions of 2.6 if compared to 2.4.

But this is all fixed now, I'm starting sending the first patches to
Anderw very shortly (last week there was still the oracle stuff going
on). Now I can fix the rejects.

I will guarantee nothing about which task will be picked (that's the old
code at works, I changed not a bit in what normally people calls "the oom
killer", plus the recent improvement from Thomas), but I guarantee the
VM won't kill tasks right and left like it does now (i.e. by invoking the
oom killer multiple times).
