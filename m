Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUE2B1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUE2B1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 21:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUE2B1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 21:27:42 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:49491 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261987AbUE2B1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 21:27:40 -0400
Message-ID: <40B7E708.1030603@yahoo.com.au>
Date: Sat, 29 May 2004 11:27:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
References: <7F740D512C7C1046AB53446D372001730182BC35@scsmsx402.amr.corp.intel.com> <20040528225426.GA89095@colin2.muc.de>
In-Reply-To: <20040528225426.GA89095@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> And handling all interrupts at CPU #0 during early boot up is 
> not really an issue.
> 
> An kernel implementation may make sense when you're doing something
> really dynamic: e.g. not just a timer, but dynamically redirecting
> network interrupts to the CPU the process who will read from the
> socket runs on. Obviously it would need kernel support for that, since
> user space could not keep up with such a high sampling rate. But that's
> future research work (if it can be even done generically at all)
> and I don't see it on the radar screen anytime soon. We first need to solve
> the NUMA scheduling problem, which is already hard enough ;-) 
> 

We're actually doing the converse of this in the sched-domain
scheduler. Processes have a tendancy to follow the interrupts
(ie. try to get onto the same CPU as them).

This makes good interrupt balancing important.

I have a feeling it might be best to keep the interrupts on
the closest CPUs, and move processes to match. Or possibly a
mix of both approaches.
