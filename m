Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUCYQYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbUCYQYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:24:34 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:31138 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263226AbUCYQYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:24:33 -0500
Message-ID: <004101c41285$4e820270$6800a8c0@comcast.net>
From: "John Hawkes" <hawkes@sgi.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>, "Andi Kleen" <ak@suse.de>,
       "Ingo Molnar" <mingo@elte.hu>
Cc: <piggin@cyberone.com.au>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <kernel@kolivas.org>, <rusty@rustcorp.com.au>, <ricklind@us.ibm.com>,
       <anton@samba.org>, <lse-tech@lists.sourceforge.net>,
       <mbligh@aracnet.com>
References: <7F740D512C7C1046AB53446D3720017301119907@scsmsx402.sc.intel.com>
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Date: Thu, 25 Mar 2004 08:19:28 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Nakajima, Jun" <jun.nakajima@intel.com>
> We have found some performance regressions (e.g. SPECjbb) with the
> scheduler on a large IA-64 NUMA machine, and we are debugging it. On SMP
> machines, we haven't seen performance regressions.

I've run a flavor of AIM7 and kernbench on a variety of ia64-NUMA CPU counts,
ranging up to 128p (and my 2.6.4 + Piggin-scheduler kernel hangs during boot
at >=192p, vs. 2.6.4 + vanilla-scheduler booting and running at 512p), and the
Piggin scheduler is 10-15% slower at 64p, and even worse at 128p.  I did,
however, produce superior performance (superior to the vanilla scheduler) with
AIM7 by increasing the sched_domain->busy_factor by 4x.  I tried a few other
things, but nothing improved performance on these big systems better than a
simple increase of busy_factor.

John Hawkes


