Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWJRLqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWJRLqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 07:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWJRLqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 07:46:03 -0400
Received: from mga03.intel.com ([143.182.124.21]:48975 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1030248AbWJRLqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 07:46:01 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,324,1157353200"; 
   d="scan'208"; a="132609775:sNHT22040480"
Message-ID: <453613F6.7020800@intel.com>
Date: Wed, 18 Oct 2006 19:45:58 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64 add NX mask for PTE entry
References: <4535F0A4.1090709@intel.com> <200610181258.45176.ak@suse.de> <45360E99.7020001@intel.com>
In-Reply-To: <45360E99.7020001@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also I think change_page_attr is buggy. if orginal page is not
large page, when that page's previous attr is reverted revert_page()
function will be called to make that page huge. Indeed I think
there is no need to do this.

thanks
bibo,mao

bibo,mao wrote:
> Andi Kleen wrote:
>> On Wednesday 18 October 2006 11:15, bibo,mao wrote:
>>> Hi,
>>>     If function change_page_attr_addr calls revert_page to revert
>>> to original pte value, mk_pte_phys does not mask NX bit. If NX bit
>>> is set on no NX hardware supported x86_64 machine, there is will
>>> be RSVD type page fault and system will crash. This patch adds NX
>>> mask bit for PTE entry.
>>
>> Hmm, weird. I wonder why that didn't trip up earlier. Did you
>> actually see that happening? 
> I remember previous system worked well on 2.6.12 and 2.6.13 version,
> but recently even on older kernel(2.6.9) there will be many times of
> page fault error and system crashes at last when rebooting system.
> 
> I will paste the oops message tomorrow.
> 
> thanks
> bibo,mao
>>
>>
>> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
