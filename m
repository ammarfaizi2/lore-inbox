Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTHWQ5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 12:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263321AbTHWQ5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:57:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:10169 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263485AbTHWOck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 10:32:40 -0400
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
Date: Sat, 23 Aug 2003 09:32:24 -0500
User-Agent: KMail/1.5
Cc: Bill Davidsen <davidsen@tmr.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Andi Kleen <ak@muc.de>,
       torvalds@osdl.org, mingo@elte.hu
References: <Pine.LNX.3.96.1030813163849.12417I-100000@gatekeeper.tmr.com> <200308221912.38184.habanero@us.ibm.com> <3F46B561.7060706@cyberone.com.au>
In-Reply-To: <3F46B561.7060706@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308230932.24832.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >AMD is 1 because there's no need to balance within a node, so I want the
> >inter-node balance frequency to be as often as it was with just O(1). 
> > This interval would not work well with other NUMA boxes, so that's the
> > main reason to have arch specific intervals.
>
> OK, I misread the patch. IIRC AMD has 1 CPU per node? If so, why doesn't
> this simply prevent balancing within a node?

Yes, one cpu/node.  Oh, it does prevent it, but with the current intervals, we 
end up not really balancing as often (since we need a inter-node balance), 
and when we call load_balance in schedule when idle, we don't balance at all 
since it's only a node local balance.

> >  And, as a general guideline, boxes with
> >different local-remote latency ratios will probably benefit from different
> >inter-node balance intervals.  I don't know what these ratios are, but I'd
> >like the kernel to have the ability to change for one arch and not affect
> >another.
>
> I fully appreciate there are huge differences... I am curious if
> you can see much improvements in practice.

I think AMD would be the first good test.  Maybe Andi has some results on 
numasched vs O(1), which would be a good indication.
