Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267827AbUHJXlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267827AbUHJXlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267826AbUHJXjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:39:21 -0400
Received: from holomorphy.com ([207.189.100.168]:22253 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267814AbUHJXiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:38:20 -0400
Date: Tue, 10 Aug 2004 16:38:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Picco <Robert.Picco@hp.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1
Message-ID: <20040810233807.GH11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Picco <Robert.Picco@hp.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org> <200408100937.47451.jbarnes@engr.sgi.com> <20040810212033.GY11200@holomorphy.com> <41194EA5.80706@hp.com> <20040810222840.GA11200@holomorphy.com> <20040810223006.GB11200@holomorphy.com> <20040810224308.GC11200@holomorphy.com> <20040810224532.GD11200@holomorphy.com> <20040810230357.GE11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810230357.GE11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 03:45:32PM -0700, William Lee Irwin III wrote:
>> "whole affair" == NULL check in copy_thread(). Except this is a nop, so
>> I think we're just looking for something that survives copy_thread().

On Tue, Aug 10, 2004 at 04:03:57PM -0700, William Lee Irwin III wrote:
> I have an even better fix:
> +struct pt_regs * __init idle_regs(struct pt_regs *regs)
> +{
> +	return NULL;
> +}

Okay, this boots and runs here. I suspect if a non-NULL value of
pt_regs can be found that properly initializes things so copy_thread()
doesn't die and/or set up something that crashes on the AP, it can be
plugged in here transparently, the NULL check in copy_thread() removed,
and no core changes will be needed.

If you can advise on how to set up the switch_stack/bspstore/etc. to
this effect so it can be done right away, I'd be much obliged.


-- wli
