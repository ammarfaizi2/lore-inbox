Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267793AbUHJWne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267793AbUHJWne (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267795AbUHJWne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:43:34 -0400
Received: from holomorphy.com ([207.189.100.168]:65004 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267793AbUHJWnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:43:14 -0400
Date: Tue, 10 Aug 2004 15:43:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Picco <Robert.Picco@hp.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1
Message-ID: <20040810224308.GC11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Picco <Robert.Picco@hp.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org> <200408100937.47451.jbarnes@engr.sgi.com> <20040810212033.GY11200@holomorphy.com> <41194EA5.80706@hp.com> <20040810222840.GA11200@holomorphy.com> <20040810223006.GB11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810223006.GB11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 03:28:40PM -0700, William Lee Irwin III wrote:
>> Please, let's do this instead:

On Tue, Aug 10, 2004 at 03:30:06PM -0700, William Lee Irwin III wrote:
> +task_t * __init __fork_idle(int cpu, struct pt_regs *regs)
> +{
> +	task_t *task = copy_process(CLONE_VM, 0, regs, 0, NULL, NULL, 0);
>  	if (!task)
>  		return ERR_PTR(-ENOMEM);
>  	init_idle(task, cpu);

This still doesn't eliminate the branch in ia64's copy_thread().
The best solution possible would be to redo the whole affair as an
ia64-specific cleanup pass, and to find some initial setting of regs
that works for all architectures (it seems memset(&regs, 0, ...) doesn't).


-- wli
