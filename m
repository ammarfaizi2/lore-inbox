Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUFONMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUFONMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265508AbUFONMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:12:48 -0400
Received: from mail021.syd.optusnet.com.au ([211.29.132.132]:16054 "EHLO
	mail021.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262768AbUFONMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:12:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
Date: Tue, 15 Jun 2004 23:11:56 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@osdl.org>, markw@osdl.org
References: <200406121028.06812.kernel@kolivas.org> <20040615045616.GA2006@elte.hu>
In-Reply-To: <20040615045616.GA2006@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406152311.56633.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2004 14:56, Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> > with a little bit of detective work and help from Wli we tracked down
> > that this patch caused it:
> > [PATCH] sched: improve wakeup-affinity
> >
> > A massive increase in idle time was observed and the throughput
> > dropped by 40% Reversing this patch gave these results:
> >
> > backsched1: http://khack.osdl.org/stp/293865/
> > Composite 	Query Processing Power 	Throughput Numerical Quantity
> > 193.93 	145.95 	257.67
> >
> > It may be best to reverse this patch until the regression is better
> > understood.
>
> agreed. It is weird because Nick said that pgsql was tested with the
> patch - and we applied the patch based on those good results. Nick?
>
> Anyway, does the patch below fix the pgsql problem? It reverts to the
> more agressive idle-balancing variant (which isnt strictly necessary for
> the bw_pipe problem).

Better than the patch backed out but still worse than it was before: 
http://khack.osdl.org/stp/293958/
Composite 	Query Processing Power 	Throughput Numerical Quantity
161.42 	152.90 	170.41

Con
