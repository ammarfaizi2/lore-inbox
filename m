Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267191AbUHDBvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267191AbUHDBvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbUHDBvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:51:22 -0400
Received: from holomorphy.com ([207.189.100.168]:35768 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267191AbUHDBvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:51:20 -0400
Date: Tue, 3 Aug 2004 18:51:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
Message-ID: <20040804015115.GF2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Williams <pwil3058@bigpond.net.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
References: <410DDFD2.5090400@bigpond.net.au> <20040802134257.GE2334@holomorphy.com> <410EDD60.8040406@bigpond.net.au> <20040803020345.GU2334@holomorphy.com> <410F08D6.5050200@bigpond.net.au> <20040803104912.GW2334@holomorphy.com> <41102FE5.9010507@bigpond.net.au> <20040804005034.GE2334@holomorphy.com> <41103DBB.6090100@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41103DBB.6090100@bigpond.net.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Aperiodic rotations defer movement until MAX_RT_PRIO's slot is evacuated.

On Wed, Aug 04, 2004 at 11:36:59AM +1000, Peter Williams wrote:
> Unfortunately, to ensure no starvation, promotion has to continue even 
> when there are tasks in MAX_RT_PRIO's slot.

One may either demote to evict MAX_RT_PRIO immediately prior to
rotation or rely on timeslice expiry to evict MAX_RT_PRIO. Forcibly
evicting MAX_RT_PRIO undesirably accumulates tasks at the fencepost.


William Lee Irwin III wrote:
>> The primary concern was that ticklessness etc. may require it to occur
>> during context switches.

On Wed, Aug 04, 2004 at 11:36:59AM +1000, Peter Williams wrote:
> On a tickless system, I'd consider using a timer to control when 
> do_promotions() gets called.  I imagine something similar will be 
> necessary to manage time slices?

This is an alternative to scheduler accounting in context switches.
Periodicity often loses power conservation benefits.


-- wli
