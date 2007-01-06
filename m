Return-Path: <linux-kernel-owner+w=401wt.eu-S1751330AbXAFJuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbXAFJuy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 04:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXAFJuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 04:50:54 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:43661 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbXAFJux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 04:50:53 -0500
Message-ID: <459F70FC.6090908@vmware.com>
Date: Sat, 06 Jan 2007 01:50:52 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch] paravirt: isolate module ops
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com> <1168064710.20372.28.camel@localhost.localdomain> <20070106071424.GB11232@elte.hu>
In-Reply-To: <20070106071424.GB11232@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>   
>> +EXPORT_SYMBOL(clts);
>> +EXPORT_SYMBOL(read_cr0);
>> +EXPORT_SYMBOL(write_cr0);
>>     
>
> mark these a _GPL export. Perhaps even mark the symbol deprecated, to be 
> unexported once we fix raid6.
>   

read / write cr0 must not be GPL, since kernel_fpu_end uses them and is 
inline.  clts I don't think matters.


>> +EXPORT_SYMBOL(wbinvd);
>> +EXPORT_SYMBOL(raw_safe_halt);
>> +EXPORT_SYMBOL(halt);
>> +EXPORT_SYMBOL_GPL(apic_write);
>> +EXPORT_SYMBOL_GPL(apic_read);
>>     
>
> these should be _GPL too. If any module uses it and breaks a user's box 
> we need that big licensing hint to be able to debug them ...
>   

Perhaps also, MSRs are too dangerous for binary modules to be messing with.

Agree on halt - but wbinvd can theoretically be used for device mapped 
memory consistency.

Zach
