Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265659AbUFDIql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbUFDIql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 04:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUFDIql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 04:46:41 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:31195 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265659AbUFDIqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 04:46:40 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@sgi.com>, Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>, Simon Derr <Simon.Derr@bull.net>
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation 
In-reply-to: Your message of "Fri, 04 Jun 2004 01:19:06 MST."
             <20040604081906.GR21007@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 Jun 2004 18:43:43 +1000
Message-ID: <17995.1086338623@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004 01:19:06 -0700, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>On Thu, Jun 03, 2004 at 10:10:10AM -0700, Paul Jackson wrote:
>> @@ -1206,9 +1207,10 @@
>>  {
>>  	struct ino_bucket *bp = ivector_table + (long)data;
>>  	struct irqaction *ap = bp->irq_info;
>> -	cpumask_t mask = get_smpaff_in_irqaction(ap);
>> +	cpumask_t mask;
>>  	int len;
>>  
>> +	cpus_addr(mask)[0] = get_smpaff_in_irqaction(ap);
>>  	if (cpus_empty(mask))
>>  		mask = cpu_online_map;
>
>This is an improvement?

The existing code assumes that cpumask_t fits in a long; struct
irqaction->mask is defined as a long.  Paul marked such suspect code
with cpus_addr(), it needs to be reviewed and corrected.

