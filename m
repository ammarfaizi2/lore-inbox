Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264811AbTE1SBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 14:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbTE1SBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 14:01:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:20901 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264811AbTE1SBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 14:01:52 -0400
Message-Id: <200305281814.h4SIEgj02186@owlet.beaverton.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Erich Focht <efocht@hpce.nec.com>, Andi Kleen <ak@suse.de>,
       LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension 
In-reply-to: Your message of "Wed, 28 May 2003 10:13:26 PDT."
             <26980000.1054142004@[10.10.2.4]> 
Date: Wed, 28 May 2003 11:14:42 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Can you define what you mean by big vs small? I presume you mean RSS?
    There are several factors that come into play here, at least:
    
    1. RSS (and which bits of this lie on which node)
    2. CPU utilisation of the task
    3. Task duration
    4. Cache warmth
    5. the current balance situation.

Along the same lines, would it make sense to *permit* imbalances for some
classes of tasks?  It may be worth it, for example, to let three threads
sharing a lot of data to saturate one cpu because what they lose from
their self-competition is saved from the extremely warm cache.

So you leave cpu0 at 7 tasks even though cpu1 only has 4, because the 7 are
"related" and the 4 are "dissimilar"?  The equation changes dramatically,
perhaps, once their is an idle cpu, but if everything is busy does it make
sense to weight the items in the runqueues in any way?

Rick
