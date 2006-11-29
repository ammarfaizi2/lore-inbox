Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966209AbWK2IGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966209AbWK2IGa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966210AbWK2IGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:06:30 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:48228 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966209AbWK2IG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:06:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ssA/D+f03nRah4LeGirZF3t6vAd9h70kVlM/uYTYsj6X8HEFr6vLN3APlN+OjNzOSWkDv+Z/NYISKwfZvkb7POm7HhU7DXGEnnrbS5pe9vGsehsGTZQn/YXTSeQTlGHtsRFaZ0ZKyGBHCQsvtINVtSF/KxkwrYX7KfzuR2fToqE=  ;
X-YMail-OSG: CWEAHVMVM1koEpYjHad0L.8MCuNZ4UaVsTSRsk1WPuVj.u4eHe44MjHVqTJfhvTTHBwtBU.ua4sxLdOezy9ulGoOz6gLFC_znm05wpiWi9Anv97zGIvTvsyrT6qyIYZIviUuRUBL5o2tvro-
Message-ID: <456D3F52.6040308@yahoo.com.au>
Date: Wed, 29 Nov 2006 19:05:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@linux.intel.com>
CC: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] Mark rdtsc as sync only for netburst, not for core2
References: <1164709708.3276.72.camel@laptopd505.fenrus.org>	 <200611281136.29066.ak@suse.de> <1164774239.15257.5.camel@ymzhang> <456D372C.9080800@linux.intel.com>
In-Reply-To: <456D372C.9080800@linux.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Zhang, Yanmin wrote:
> 
>> If it's a single processor, the go backwards issue doesn't exist. 
>> Below is
>> my patch based on Arjan's. It's against 2.6.19-rc5-mm2.
> 
> Hi,
> 
> this patch is incorrect
> 
>> --- linux-2.6.19-rc5-mm2_arjan/arch/x86_64/kernel/setup.c    
>> 2006-11-29 10:41:21.000000000 +0800
>> +++ linux-2.6.19-rc5-mm2_arjan_fix/arch/x86_64/kernel/setup.c    
>> 2006-11-29 10:42:28.000000000 +0800
>> @@ -861,7 +861,7 @@ static void __cpuinit init_intel(struct          
>> set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
>>      if (c->x86 == 6)
>>          set_bit(X86_FEATURE_REP_GOOD, &c->x86_capability);
>> -    if (c->x86 == 15)
>> +    if (c->x86 == 15 && num_possible_cpus() != 1)
>>          set_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
> 
> 
> first of all, you probably meant "|| num_possible_cpus() == 1"
> 
> but second of all, the core2 cpus are dual core so.. .what does it bring 
> you at all?

I guess you could boot with a UP kernel or maxcpus=1?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
