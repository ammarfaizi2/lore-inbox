Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVCaSuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVCaSuj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVCaSuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:50:39 -0500
Received: from fmr17.intel.com ([134.134.136.16]:30403 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261622AbVCaSuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:50:10 -0500
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
Date: Thu, 31 Mar 2005 10:41:05 -0800
User-Agent: KMail/1.5.4
References: <200502141240.14355.mgross@linux.intel.com> <200502170814.42903.mgross@linux.intel.com> <20050329085734.GA7074@elte.hu>
In-Reply-To: <20050329085734.GA7074@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Cc: rostedt@kihontech.com, Steven Rostedt <rostedt@goodmis.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       Mark_H_Johnson@raytheon.com
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503311041.05955.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 March 2005 00:57, Ingo Molnar wrote:
> * Mark Gross <mgross@linux.intel.com> wrote:
> > > As I mentioned earlier, what would it take to be able to group
> > > softirq threads that should not preempt each other, but still keep
> > > preemption available for other threads?
> >
> > It would only take the creationt of multiple softIRQd threads per CPU.
> > Just keep net_rx and net_tx in the same work queue.
>
> we could work around the net_rx/net_tx assumptions by moving them to the
> same softirq thread - but i'm a bit uneasy about the whole concept: e.g.
> how about SCSI softirq processing and timer softirq processing, can they
> preempt each other?
>
I think they can.  

BTW:

My work on this has been mostly in the context of a 2.6 kernel based 
generalization of a softIRQ as thread patch for 2.4 that enables priority 
tuning of the bottom half processing as well as /proc support for turning on 
and off the feature.   We got it to work.

However; I don't know what good workloads and metrics to measure the goodness 
of the work look like.  If folks think priority tuning of bottom half 
processing is worth persuing and can help me quantify its effectiveness 
better than running a jitter test while doing a BONNIE test run on a SCSI 
JBOD, then I'm happy to do more with this.

--mgross

