Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752140AbWCCB7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbWCCB7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbWCCB7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:59:22 -0500
Received: from fmr21.intel.com ([143.183.121.13]:46309 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1752140AbWCCB7W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:59:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Patch] Move swiotlb_init early on X86_64
Date: Thu, 2 Mar 2006 17:59:10 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60076C30F4@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] Move swiotlb_init early on X86_64
Thread-Index: AcY+YtYT2hXESft7TBWbnHtnkLJolAAApQiQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       "LKML" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 03 Mar 2006 01:59:11.0748 (UTC) FILETIME=[10E22440:01C63E66]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Andi Kleen [mailto:ak@suse.de] 
>Sent: Thursday, March 02, 2006 5:32 PM
>To: Zou, Nanhai
>Cc: Zhang, Yanmin; Luck, Tony; LKML; Andrew Morton; Pallipadi, 
>Venkatesh
>Subject: Re: [Patch] Move swiotlb_init early on X86_64
>
>On Friday 03 March 2006 00:35, Zou Nan hai wrote:
>
>> This patch modify the bootmem allocator,
>> let normal bootmem allocation on 64 bit system first go above 4G
>> address.
>
>That's very ugly and likely to break some architectures. Sorry
>but #ifdefs is the wrong way to do this.
>
>Passing a limit parameter is better and use that in the swiotlb
>allocation. If you're worried about changing too many callers
>you could add a new entry point.
>

Another potential issue with this approach:
On a 64 bit system with less than 4G phys memory, we will fail
to get any memory above 4G and fall back to start from '0'.
This is different from original behaviour, where goal was 
MAX_DMA_ADDRESS (16M) and we would allocate memory starting 
from 16M. As a result, we will now eat up memory in 0-16M range 
and may break some legacy drivers as they will not get any memory.

If we go this way, then we should fallback to original goal if we 
are not able to get greater than 4G memory.

Thanks,
Venki
