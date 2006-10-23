Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWJWFws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWJWFws (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 01:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWJWFwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 01:52:47 -0400
Received: from mga07.intel.com ([143.182.124.22]:5741 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751533AbWJWFwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 01:52:47 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,341,1157353200"; 
   d="scan'208"; a="134552392:sNHT26860078"
Message-ID: <453C58AA.6070307@linux.intel.com>
Date: Mon, 23 Oct 2006 13:52:42 +0800
From: "bibo,mao" <bibo_mao@linux.intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix minor error about efi memory_present
References: <453C3A29.4010606@intel.com> <20061022214508.6c4f30c6.akpm@osdl.org>
In-Reply-To: <20061022214508.6c4f30c6.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 23 Oct 2006 11:42:33 +0800
> "bibo,mao" <bibo.mao@intel.com> wrote:
> 
>> Hi, 
>>    Function efi_memory_present_wrapper parameter start/end is physical address,
>> but function memory_present parameter is PFN, this patch converts physical
>> address to PFN.
>>
>>   Signed-off-by: bibo, mao <bibo.mao@intel.com>
>>
>> thanks
>> bibo,mao
>>
>> diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
>> index 519e63c..141041d 100644
>> --- a/arch/i386/kernel/setup.c
>> +++ b/arch/i386/kernel/setup.c
>> @@ -846,7 +846,7 @@ efi_find_max_pfn(unsigned long start, un
>>  static int __init
>>  efi_memory_present_wrapper(unsigned long start, unsigned long end, void *arg)
>>  {
>> -	memory_present(0, start, end);
>> +	memory_present(0, PFN_UP(start), PFN_DOWN(end));
>>  	return 0;
>>  }
>>  
> 
> It doesn't _seem_ like a "minor error".  How come people's machines haven't
> been crashing all over the place?
This patch is only efi bios relative, most machines in the market are
legacy bios. System only crashes when booting from EFI bios.

thanks
bibo,mao
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
