Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWA3UoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWA3UoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWA3UoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:44:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38874 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964971AbWA3UoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:44:17 -0500
Message-ID: <008901c625dd$d02e6760$6f00a8c0@comcast.net>
From: "John Hawkes" <hawkes@sgi.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Ingo Molnar" <mingo@elte.hu>
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, "Ingo Molnar" <mingo@redhat.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <200601271403.27065.bjorn.helgaas@hp.com> <20060130172140.GB11793@elte.hu> <20060130185301.GA4622@agluck-lia64.sc.intel.com>
Subject: Re: boot-time slowdown for measure_migration_cost
Date: Mon, 30 Jan 2006 12:43:22 -0800
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

From: "Luck, Tony" <tony.luck@intel.com>
...
> So the variation in the computed value of migration_cost was at worst
> 2% with these modifications to the algorithm.  Do you really need to know
> the value to this accuracy?  What 2nd order bad effects would occur from
> using an off-by-2% value for scheduling decisions?
>
> On the plus side Prarit's results show that this time isn't scaling with
> NR_CPUS ... apparently just cache size and number of domains are significant
> in the time to compute.

Yes, the calculation is done just once per domain level, and a desire to
achieve great accuracy for the calculation presupposes that the cpuM-to-cpuN
migration cost for a given domain level is identical (or very close) across
all the CPU pairs.  That is, for a given domain level, only one CPU pair are
chosen for the calculation.  For the ia64/sn2 NUMA Altix, and I suspect for
other NUMA platforms, this just isn't true for the middle domain level (i.e.,
the level that appears when the CPU count is >32p) -- i.e., some CPU pairs are
"closer" than other pairs.  The variation for other CPU pairs in this domain
level is certainly much greater than 2%.

John Hawkes

