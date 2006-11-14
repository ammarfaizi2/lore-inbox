Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966455AbWKNXPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966455AbWKNXPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966469AbWKNXPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:15:08 -0500
Received: from mga03.intel.com ([143.182.124.21]:58416 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S966455AbWKNXPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:15:06 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,422,1157353200"; 
   d="scan'208"; a="146257930:sNHT19807522"
Message-ID: <455A4DED.8090107@intel.com>
Date: Tue, 14 Nov 2006 15:14:53 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: eli@dev.mellanox.co.il, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: UDP packets loss
References: <60157.89.139.64.58.1163542547.squirrel@dev.mellanox.co.il> <20061114143531.2ee7eae0@freekitty>
In-Reply-To: <20061114143531.2ee7eae0@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Nov 2006 23:14:53.0680 (UTC) FILETIME=[B12E1700:01C70842]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Wed, 15 Nov 2006 00:15:47 +0200 (IST)
> eli@dev.mellanox.co.il wrote:
>> The secod question is how do I make the interrupts be srviced by all CPUs?
>> I tried through the procfs as described by IRQ-affinity.txt but I can set
>> the mask to 0F bu then I read back and see it is indeed 0f but after a few
>> seconds I see it back to 02 (which means only CPU1).
> 
> Most likely, the user level irq balance daemon (irqbalanced) is adjusting it?

Having it bounce between cpu's would likely result in a lower performance anyway: you 
really want it bound to a single CPU to benefit from cache hits on the various involved 
data structs that are needed to receive the data from hardware, do accounting etc.

the userspace irq balance daemon attempts to keep network interrupts on the same cpu for 
longer periods. The old obsolete kernel-space daemon did exactly the opposite completely 
destroying network performance.

I'm not sure whether this is completely optimal on newer chips like conroe with large 
shared caches though...

Cheers,

Auke
