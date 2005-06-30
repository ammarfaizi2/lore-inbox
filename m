Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbVF3Kgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbVF3Kgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVF3Kew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:34:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57277 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262938AbVF3KdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:33:11 -0400
Date: Thu, 30 Jun 2005 12:32:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050630103205.GA32508@elte.hu>
References: <42C320C4.9000302@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C320C4.9000302@opersys.com>
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


* Kristian Benoit <kbenoit@opersys.com> wrote:

> This is the 3rd run of our tests.

i'm still having problems reproducing your numbers, even the 'plain' 
ones. I cannot even get the same ballpark figures, on 3 separate 
systems. To pick one number:

> "plain" run:
> 
> Measurements   |   Vanilla   |  preemp_rt     |
> ---------------+-------------+----------------+
> mmap           |     660us   | 2867us (+334%) |

i was unable to reproduce this level of lat_mmap degradation. I do 
indeed see a slowdown [*], but nowhere near the 4.3x slowdown measured 
here. I have tried the very lmbench version you used (2.0.4) on 3 
different systems (Athlon64 2GHz, Celeron 466MHz, Xeon 2.4GHz - the last 
one should be pretty similar to your 2.8GHz Xeon testbox) and neither 
showed this level of slowdown.

i couldnt figure out which precise options were used by your test, 
because i only found the summary lmbench page of one of the older tests 
- so i did my lat_mmap testing with various sizes: 10MB, 30MB, 70MB, 
150MB, 200MB, 500MB. (My best guess would be that since your target box 
has 512MB of RAM, lmbench will pick an mmap-file size of 144 MB. Or if 
it's the 256MB box, lmbench will pick roughly 70 MB. I covered those 
likely sizes too.) Neither size showed this level of slowdown.

so my tentative conclusion would be that the -RT kernel is still 
misconfigured somehow. Did you have HIGHMEM64 and HIGHPTE enabled 
perhaps? Those i suggested to be turned off in one of my first mails to 
you, it is something that will cause bad performance under PREEMPT_RT.  
(Highmem64 is unwarranted for an embedded test anyway - it's only needed 
to support more than 4 GB of RAM.) Could you send me the test 3 .config 
you used on the -RT kernel?

	Ingo

[*] fixed in -50-36 and later PREEMPT_RT kernels
