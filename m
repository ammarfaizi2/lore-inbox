Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266110AbUFPDo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUFPDo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbUFPDo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:44:29 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:53521 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S266110AbUFPDoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 23:44:17 -0400
Message-ID: <1087348945.40cfa0d1c94a3@vds.kolivas.org>
Date: Wed, 16 Jun 2004 11:22:25 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@osdl.org>, markw@osdl.org
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
References: <200406121028.06812.kernel@kolivas.org> <20040615045616.GA2006@elte.hu> <40CFB7B0.5090702@yahoo.com.au>
In-Reply-To: <40CFB7B0.5090702@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Piggin <nickpiggin@yahoo.com.au>:
> Ingo Molnar wrote:
> >* Con Kolivas <kernel@kolivas.org> wrote:
> >>with a little bit of detective work and help from Wli we tracked down that
> 
> >>this patch caused it:
> >>[PATCH] sched: improve wakeup-affinity
> >>
> >
> >>A massive increase in idle time was observed and the throughput
> >>dropped by 40% Reversing this patch gave these results:
> >>
> >
> >>backsched1: http://khack.osdl.org/stp/293865/
> >>Composite 	Query Processing Power 	Throughput Numerical Quantity
> >>193.93 	145.95 	257.67
> >>
> >>It may be best to reverse this patch until the regression is better 
> >>understood.
> >agreed. It is weird because Nick said that pgsql was tested with the
> >patch - and we applied the patch based on those good results. Nick?
> Sigh, yes, Mark did run a test for me, but I think it was dbt2-pgsql.
> This one is dbt3-pgsql. Also, his system was a 4 logical CPU Xeon.
> 
> Strangely enough, Mark's setup was showing a fairly large too-much-idle
> regression not long ago, while these 8-ways weren't.
> 
> Anyway, Linus has reverted my patch now, which is the right thing to
> do. Your sync wakeup change is still in there, so that will hopefully
> help bw_pipe scores.

The sync wakeup change was worth about 1% detriment to this benchmark which, if
offset by significant performance gains elsewhere, is worth tolerating.

Con
