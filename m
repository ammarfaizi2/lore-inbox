Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVC2JBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVC2JBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVC2JBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:01:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62378 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262224AbVC2I5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:57:48 -0500
Date: Tue, 29 Mar 2005 10:57:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Gross <mgross@linux.intel.com>
Cc: rostedt@kihontech.com, Steven Rostedt <rostedt@goodmis.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       Mark_H_Johnson@raytheon.com
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
Message-ID: <20050329085734.GA7074@elte.hu>
References: <200502141240.14355.mgross@linux.intel.com> <20050217075212.GA21621@elte.hu> <Pine.LNX.4.58.0502170944500.14536@localhost.localdomain> <200502170814.42903.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502170814.42903.mgross@linux.intel.com>
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


* Mark Gross <mgross@linux.intel.com> wrote:

> > As I mentioned earlier, what would it take to be able to group
> > softirq threads that should not preempt each other, but still keep
> > preemption available for other threads?
> 
> It would only take the creationt of multiple softIRQd threads per CPU.  
> Just keep net_rx and net_tx in the same work queue.

we could work around the net_rx/net_tx assumptions by moving them to the 
same softirq thread - but i'm a bit uneasy about the whole concept: e.g.  
how about SCSI softirq processing and timer softirq processing, can they 
preempt each other?

	Ingo
