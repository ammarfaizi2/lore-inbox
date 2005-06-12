Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVFLLMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVFLLMc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVFLLMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:12:32 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:54195 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261747AbVFLLM2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:12:28 -0400
Message-ID: <39352.210.137.194.5.1118574705.squirrel@210.137.194.5>
In-Reply-To: <42AA6A6B.5040907@opersys.com>
References: <42AA6A6B.5040907@opersys.com>
Date: Sun, 12 Jun 2005 07:11:45 -0400 (EDT)
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
From: "James R Bruce" <bruce@andrew.cmu.edu>
To: "Kristian Benoit" <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org, kbenoit@opersys.com
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian,
thanks for getting some real response time data, but I have some reproducibility questions.  If we look at the following excerpt of your results, check out the max latency column:

Interrupt response times (all in micro-seconds):
+--------------------+------------+------+-------+------+--------+
| Kernel             | sys load   | Aver | Max   | Min  | StdDev |
+====================+============+======+=======+======+========+
|                    | None       | 13.4 |  53.3 | 13.2 | 0.2    |
|                    | Ping       | 13.8 |  53.3 | 13.3 | 0.6    |
| with Adeos-r10c3   | lm.+ ping  | 13.9 |  21.8 | 13.2 | 0.7    |
|                    | lmbench    | 13.9 |  21.3 | 13.3 | 0.6    |
|                    | lm. + hd   | 13.9 |  53.2 | 13.2 | 0.5    |
+====================+============+======+=======+======+========+

It seems that running lmbench improves the maximum response time considerably compared to an idle system, unless you touch the hard drive.  That sort of thing makes very little sense though, and thus is likely an artifact of the testing.  Maybe the test needs to be run for longer, or maybe each test should be duplicated a few times?  I realize the max is always going to be pretty noisy, but we can't really compare approaches much if it jumps around by a factor of 2.5.  Then again, maybe lmbench *does* improve latency and that would definitely be a bug somewhere that you've uncovered :)

The nicest results would be CDFs or histograms of the response times, plotted againts each other for east comparison.  Obviously that makes more work for you, however.  If we can get full traces from the logger as text, then its easy for us to make such graphs, or add some scripts to your testbed once its released to generate them automatically with gnuplot/etc.

 - Jim

P.S. Thanks again for injecting some real numbers into this discussion.

