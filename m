Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267819AbUHKCVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267819AbUHKCVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 22:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267877AbUHKCVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 22:21:48 -0400
Received: from web13910.mail.yahoo.com ([216.136.172.95]:42647 "HELO
	web13910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267819AbUHKCVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 22:21:44 -0400
Message-ID: <20040811022143.4892.qmail@web13910.mail.yahoo.com>
Date: Tue, 10 Aug 2004 19:21:43 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and others)
To: linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20040811010116.GL11200@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- William Lee Irwin III <wli@holomorphy.com> wrote:
> 
> Wakeup bonuses etc. are starving tasks. Could you try Peter Williams'
> SPA patches with the do_promotions() function? I suspect these should
> pass your tests.
> 
> 
> -- wli
> 

I tried the patch-2.6.7-spa_hydra_FULL-v4.0 patch

I only changed the value of /proc/sys/kernel/cpusched/mode to switch between
different patches.

The 2 threads test passes successfuly (improvement over stock 2.6.7) but none
passed the 20 threads test:

eb

Tue Aug 10 19:10:48 PDT 2004
>>>>>>> delta = 6
Tue Aug 10 19:11:03 PDT 2004
>>>>>>> delta = 16
Tue Aug 10 19:11:13 PDT 2004
>>>>>>> delta = 9
Tue Aug 10 19:11:24 PDT 2004
>>>>>>> delta = 11
Tue Aug 10 19:11:34 PDT 2004
>>>>>>> delta = 10
Tue Aug 10 19:11:45 PDT 2004
>>>>>>> delta = 11
Tue Aug 10 19:11:56 PDT 2004
>>>>>>> delta = 11
Tue Aug 10 19:12:06 PDT 2004
>>>>>>> delta = 10



pb

Tue Aug 10 19:07:52 PDT 2004
>>>>>>> delta = 3
Tue Aug 10 19:07:55 PDT 2004
>>>>>>> delta = 3
Tue Aug 10 19:07:59 PDT 2004
>>>>>>> delta = 4
Tue Aug 10 19:08:02 PDT 2004
>>>>>>> delta = 3
Tue Aug 10 19:08:05 PDT 2004
>>>>>>> delta = 3

sc

Tue Aug 10 19:08:28 PDT 2004
>>>>>>> delta = 3
Tue Aug 10 19:09:08 PDT 2004
>>>>>>> delta = 3
Tue Aug 10 19:09:17 PDT 2004
>>>>>>> delta = 3
Tue Aug 10 19:09:23 PDT 2004
>>>>>>> delta = 3
Tue Aug 10 19:09:49 PDT 2004
>>>>>>> delta = 3
Tue Aug 10 19:09:53 PDT 2004
>>>>>>> delta = 3
Tue Aug 10 19:09:55 PDT 2004
>>>>>>> delta = 3


eb seemed to be the worst of the bunch with quite long system hangs on this
particular test.
With the default settings of:

base_promotion_interval 255
compute 0
cpu_hog_threshold 900
ia_threshold 900
initial_ia_bonus 1
interactive 0
log_at_exit 0
max_ia_bonus 9
max_tpt_bonus 4
sched_batch_time_slice_multiplier 10
sched_iso_threshold 50
sched_rr_time_slice 100
time_slice 100

I am not very familiar with all the parameters, so I just kept the defaults

Anything else I could try?

Nicolas


=====
------------------------------------------------------------
video meliora proboque deteriora sequor
------------------------------------------------------------
