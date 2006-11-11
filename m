Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424487AbWKKCFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424487AbWKKCFa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 21:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424494AbWKKCFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 21:05:30 -0500
Received: from mga03.intel.com ([143.182.124.21]:4152 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1424487AbWKKCF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 21:05:29 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,412,1157353200"; 
   d="scan'208"; a="144497088:sNHT17508288"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>, "Ingo Molnar" <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, <akpm@osdl.org>,
       <mm-commits@vger.kernel.org>, <nickpiggin@yahoo.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: RE: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Date: Fri, 10 Nov 2006 18:05:28 -0800
Message-ID: <000701c70535$dc0d8e70$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccFLPPyDLav2pLzR4aRqnlmB1vH+AACCuyg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <Pine.LNX.4.64.0611101648310.26789@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Friday, November 10, 2006 5:01 PM
> On Fri, 10 Nov 2006, Ingo Molnar wrote:
> 
> > ok, that's what i suspected - what made the difference wasnt the fact 
> > that it was moved out of irqs-off section, but that it was running 
> > globally, instead of in parallel on every cpu. I have no conceptual 
> > problem with single-threading the more invasive load-balancing bits. 
> > (since it has to touch every runqueue anyway there's probably little 
> > parallelism possible) But it's a scary change nevertheless, it 
> > materially affects every SMP system's balancing characteristics.
> 
> We saw multiple issues. The first we saw was interrupt holdoff related 
> since IPIs took a long time to complete. The other was that multiple 
> load balance actions in multiple CPUs seem to serialize on the locks 
> trying each to move tasks off the same busy processor. So both better be 
> addressed.

So designate only one CPU within a domain to do load balance between groups
for that specific sched domain should in theory fix the 2nd problem you
identified.  Did you get a chance to look at the patch Suresh posted?

