Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbULAST6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbULAST6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 13:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbULAST6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 13:19:58 -0500
Received: from brown.brainfood.com ([146.82.138.61]:47811 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261408AbULASTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 13:19:53 -0500
Date: Wed, 1 Dec 2004 12:19:35 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: Eran Mann <emann@mrv.com>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
In-Reply-To: <20041201085337.GB15928@elte.hu>
Message-ID: <Pine.LNX.4.58.0412011218570.2173@gradall.private.brainfood.com>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93>
 <20041129111634.GB10123@elte.hu> <41ACB846.40400@free.fr> <20041130081548.GA8707@elte.hu>
 <41AD8122.4070108@mrv.com> <20041201085337.GB15928@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2004, Ingo Molnar wrote:

>
> * Eran Mann <emann@mrv.com> wrote:
>
> > Seems to be fixed by the patch below:
> >
> > --- kernel/latency.c.orig       2004-12-01 10:21:45.000000000 +0200
> > +++ kernel/latency.c    2004-12-01 10:11:37.000000000 +0200
> > @@ -762,7 +762,9 @@
> >         tr->critical_sequence = max_sequence;
> >         tr->preempt_timestamp = cycles();
> >         tr->early_warning = 0;
> > +#ifdef CONFIG_LATENCY_TRACE
> >         __trace(CALLER_ADDR0, parent_eip);
> > +#endif
>
> thanks, applied it and uploaded -V0.7.31-16.

Wouldn't it be better to change the definition of __trace()?  Always have it
defined, but make it empty if CONFIG_LATENCY_TRACE isn't set?

It'd keep the code from being littered with ifdef.

