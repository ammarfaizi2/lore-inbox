Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUGMMyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUGMMyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 08:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUGMMyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 08:54:43 -0400
Received: from holomorphy.com ([207.189.100.168]:917 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264961AbUGMMxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 08:53:37 -0400
Date: Tue, 13 Jul 2004 05:53:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
Message-ID: <20040713125331.GA21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <20040713122805.GZ21066@holomorphy.com> <40F3DACC.9070703@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F3DACC.9070703@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>>+		unsigned long preempt_exit
>>+				= (unsigned long)__builtin_return_address(0);
>>+		hold = sched_clock() - __get_cpu_var(preempt_timings) + 
>>999999;
>>+		do_div(hold, 1000000);
>>+		if (preempt_thresh && hold > preempt_thresh &&
>>+							printk_ratelimit()) {

On Tue, Jul 13, 2004 at 10:51:24PM +1000, Nick Piggin wrote:
> This looks wrong. This means hold times of 1ns to 1000000ns trigger the
> exceeded 1ms threshold, 1000001 to 2000000 trigger the 2ms one, etc.
> Removing the + 999999 gives the correct result:
> 1000000 - 1999999ns triggers the 1ms threshold
> 2000000 - 2999999ns triggers the 2ms threshold
> etc
> Or have I missed something?

AFAICT this is nothing more than rounding up.


-- wli
