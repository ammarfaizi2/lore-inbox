Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263508AbTH0PxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbTH0PxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:53:06 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:48777 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263508AbTH0PxA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:53:00 -0400
Date: Wed, 27 Aug 2003 08:52:46 -0700
From: Larry McVoy <lm@bitmover.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030827155246.GA23609@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Peter Chubb <peterc@gelato.unsw.edu.au>, akpm@digeo.com,
	linux-kernel@vger.kernel.org
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au> <20030827065435.GV4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827065435.GV4306@holomorphy.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I normally hate ifdefs but this might be a good place to use a bunch of 
macros and make them conditional on config_stats or something.  Updating
counters is going to add to the size of the data cache footprint and it
would be nice, for those people working on embedded low speed processors,
if they could config this out.  I personally would leave it in, I like
this stats.  I just know that the path to slowness is paved one cache
miss at a time.

On Tue, Aug 26, 2003 at 11:54:35PM -0700, William Lee Irwin III wrote:
> On Wed, Aug 27, 2003 at 10:57:44AM +1000, Peter Chubb wrote:
> > Currently, the context switch counters reported by getrusage() are
> > always zero.  The appended patch adds fields to struct task_struct to
> > count context switches, and adds code to do the counting.
> > The patch adds 4 longs to struct task struct, and a single addition to
> > the fast path in schedule().
> 
> Thanks, this will be useful. We're still missing a fair number of them:
> 
> struct  rusage {
>         struct timeval ru_utime;        /* user time used */
>         struct timeval ru_stime;        /* system time used */
>         long    ru_maxrss;              /* maximum resident set size */
>         long    ru_ixrss;               /* integral shared memory size */
>         long    ru_idrss;               /* integral unshared data size */
>         long    ru_isrss;               /* integral unshared stack size */
>         long    ru_minflt;              /* page reclaims */
>         long    ru_majflt;              /* page faults */
>         long    ru_nswap;               /* swaps */
>         long    ru_inblock;             /* block input operations */
>         long    ru_oublock;             /* block output operations */
>         long    ru_msgsnd;              /* messages sent */
>         long    ru_msgrcv;              /* messages received */
>         long    ru_nsignals;            /* signals received */
>         long    ru_nvcsw;               /* voluntary context switches */
>         long    ru_nivcsw;              /* involuntary " */
> };
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
