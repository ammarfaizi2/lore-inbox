Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268532AbUHRAdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268532AbUHRAdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 20:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUHRAdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 20:33:08 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:30653 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268534AbUHRAc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 20:32:56 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040817081829.GA1977@elte.hu>
References: <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <20040817021431.169d07db@mango.fruits.de>
	 <1092701223.13981.106.camel@krustophenia.net>
	 <20040817073927.GA594@elte.hu>  <20040817081829.GA1977@elte.hu>
Content-Type: text/plain
Message-Id: <1092789242.813.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 20:34:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 04:18, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > Yes, Ingo identified an issue with copy_page_range, I don't think it's
> > > fixed yet.  See the voluntary-preempt-2.6.8.1-P0 thread.
> > 
> > right, it's not fixed yet. It's not a trivial critical section - we
> > are holding two locks and are mapping two atomic kmaps.
> 
> fortunately it's easier than i thought - neither the source pmd nor the
> target pmd can go away so we can simply drop the locks, reschedule, and
> remap. Does the patch below (ontop of -P3) fix the copy_page_range()
> latencies you are seeing?
> 

Yes, this fixes it.  Now the most frequent issue is the xfree86
unmap_vmas latency:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P3

Lee

