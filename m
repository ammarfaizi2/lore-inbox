Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270861AbTGPORb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270863AbTGPORa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:17:30 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:8947 "EHLO fed1mtao08.cox.net")
	by vger.kernel.org with ESMTP id S270861AbTGPOR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:17:29 -0400
Date: Wed, 16 Jul 2003 07:32:21 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm1
Message-ID: <20030716143221.GD25829@ip68-4-255-84.oc.oc.cox.net>
References: <20030715225608.0d3bff77.akpm@osdl.org> <20030716104448.GC25869@ip68-4-255-84.oc.oc.cox.net> <20030716035848.560674ac.akpm@osdl.org> <20030716122454.GJ15452@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716122454.GJ15452@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 05:24:54AM -0700, William Lee Irwin III wrote:
> "Barry K. Nathan" <barryn@pobox.com> wrote:
> >>  arch/ppc/kernel/irq.c: At top level:  
> >>  arch/ppc/kernel/irq.c:575: braced-group within expression allowed only
> >>  inside a function
> 
> On Wed, Jul 16, 2003 at 03:58:48AM -0700, Andrew Morton wrote:
> > Bill?
> 
> Building a cross-compiler and taking a stab at fixing it...

Preprocessed output for arch/ppc/kernel/irq.c includes this:

cpumask_t irq_affinity [256 ] =
        { [0 ... 256 -1] = ({   cpumask_t __tmp__;      (( __tmp__
).mask[0])  =  1 ;   __tmp__;        })    };

AFAICT it's starting from this:
cpumask_t irq_affinity [NR_IRQS] =
        { [0 ... NR_IRQS-1] = DEFAULT_CPU_AFFINITY };

and NR_IRQS-1 is becoming 256, DEFAULT_CPU_AFFINITY is becoming
cpumask_of_cpu(0). Then cpumask_of_cpu(0) is getting transformed some
more (I haven't quite figured out what's going on there).

Does this help at all?

-Barry K. Nathan <barryn@pobox.com>
