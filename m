Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267757AbUHJVhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267757AbUHJVhy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUHJVgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:36:25 -0400
Received: from jade.spiritone.com ([216.99.193.136]:31188 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267753AbUHJVfw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:35:52 -0400
Date: Tue, 10 Aug 2004 07:55:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm2 
Message-ID: <2726910000.1092149728@[10.10.2.4]>
In-Reply-To: <200408100834.i7A8Y7e06476@owlet.beaverton.ibm.com>
References: <200408100834.i7A8Y7e06476@owlet.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     - Added a little patch to the CPU scheduler which disables its array
>       switching.
>     
>       This is purely experimental and will cause high-priority tasks
>       to starve lower-priority tasks indefinitely.  It is here to
>       determine whether it is this aspect of the scheduler which caused
>       the staircase scheduler to exhibit improved throughput in some
>       tests on NUMAq.
> 
> Here's the results of tests with sdet.  The summary is that yes, we
> did reach the peak we saw with the staircase scheduler (2.6.8-rc2-mm2).
> Dropping the expired array does make a difference.  But it looks like
> that wasn't all of it, though, because we see it fails to reach the same
> scores in all *but* the peak run.

Eh? what's the peak run? the one out of 10 with best performace. Oddly,
what you're seeing doesn't match what I'm seeing at all ... I'm looking
at average runtime. SDET is fairly variable - I don't think looking at
the best run is a good idea.

> Overall, I'd say I still like the staircase patch as a whole.  Not only
> did it increase the benchmark numbers, but I like the simplicity it
> (re)introduces for interactive bonus calculations.

Me too.

> Sdet
> Scripts                      1       4      16      64
>         2.6.8-rc2-mm2     32.46%  58.58% 100.00%  74.20%
> 2.6.8-rc2-mm2-noscase     23.62%  43.95%  90.92%  74.16%
>         2.6.8-rc3-mm2     16.44%  43.26% 102.95%  71.26%

Very odd. would suggest you do a few more runs - for 4 scripts,
you're matching the results of nostaircase, for 16, without it.

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
                2.6.8-rc2       100.0%         2.3%
   2.6.8-rc2-mm2-oldsched       100.2%         0.4%
            2.6.8-rc2-mm2       116.2%         3.3%
            2.6.8-rc3-mm2       102.9%         1.9%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
                2.6.8-rc2       100.0%         1.4%
   2.6.8-rc2-mm2-oldsched        98.2%         1.0%
            2.6.8-rc2-mm2       114.5%         4.0%
            2.6.8-rc3-mm2       100.5%         1.3%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
                2.6.8-rc2       100.0%         1.1%
   2.6.8-rc2-mm2-oldsched       101.2%         0.3%
            2.6.8-rc2-mm2       112.8%         0.5%
            2.6.8-rc3-mm2        99.2%         0.8%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
                2.6.8-rc2       100.0%         1.0%
   2.6.8-rc2-mm2-oldsched       100.5%         0.4%
            2.6.8-rc2-mm2       117.2%         0.9%
            2.6.8-rc3-mm2       101.7%         0.6%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
                2.6.8-rc2       100.0%         0.3%
   2.6.8-rc2-mm2-oldsched       104.3%         0.5%
            2.6.8-rc2-mm2       119.1%         0.6%
            2.6.8-rc3-mm2       103.4%         0.2%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
                2.6.8-rc2       100.0%         0.4%
   2.6.8-rc2-mm2-oldsched       101.2%         0.1%
            2.6.8-rc2-mm2       102.4%         0.8%
            2.6.8-rc3-mm2        99.2%         0.4%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
                2.6.8-rc2       100.0%         0.4%
   2.6.8-rc2-mm2-oldsched        99.6%         0.0%
            2.6.8-rc2-mm2       101.6%         0.0%
            2.6.8-rc3-mm2       100.0%         0.4%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
                2.6.8-rc2       100.0%         0.1%
   2.6.8-rc2-mm2-oldsched       101.7%         0.1%
            2.6.8-rc2-mm2       102.8%         0.3%
            2.6.8-rc3-mm2       104.5%         0.5%

