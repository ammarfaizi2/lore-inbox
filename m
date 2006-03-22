Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWCVLMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWCVLMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 06:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWCVLMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 06:12:24 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:16227 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750735AbWCVLMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 06:12:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vu2QOb7ySCVWN1Nv5c+48ztz1UNs3k/jO3k0weultOY6XysPzzYV6ldHAIKq6rmRyu9v05SWGuixoXjk+J3+W4HogMHfXzeCU83oxeVq45ObaGMzeV5/OPeMdyO413lhBtKr57Uoae4FSMNr7vuGWz0g4VQoZqwiECysbKN3P4w=  ;
Message-ID: <44212338.3050309@yahoo.com.au>
Date: Wed, 22 Mar 2006 21:13:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "Li, Shaohua" <shaohua.li@intel.com>,
       "'lkml'" <linux-kernel@vger.kernel.org>,
       "'Andrew Morton'" <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] less tlb flush in unmap_vmas
References: <200603220744.k2M7iBg05206@unix-os.sc.intel.com>
In-Reply-To: <200603220744.k2M7iBg05206@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Nick Piggin wrote on Tuesday, March 21, 2006 11:30 PM
> 

>>Well mmu_gather uses a per-cpu data structure and is non preemptible,
>>which I guess is one of the main reasons why we have this preemption
>>here.
>>
>>You're right that another good reason would be ptl lock contention,
>>however I don't think that alleviating that problem alone would allow
>>longer mmu_gather scheduling latencies, because the longest latency
>>is still the mmu_gather <--> mmu_finish span.
> 
> 
> OK, I think it would be beneficial to take a latency measurement again,
> just to see how it perform now a day.  The dynamics might changed.
> 

Well I wouldn't argue against further investigation or fine tuning
the present code, however also remember that the way of unconditionally
finishing the mmu_gather that the patch is aimed to prevent never
actually lowered ptl hold times itself.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
