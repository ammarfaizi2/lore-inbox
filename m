Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWHGFnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWHGFnn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWHGFnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:43:42 -0400
Received: from gw.goop.org ([64.81.55.164]:51841 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751080AbWHGFnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:43:42 -0400
Message-ID: <44D6D315.2030907@goop.org>
Date: Sun, 06 Aug 2006 22:43:49 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native
 ops
References: <1154925835.21647.29.camel@localhost.localdomain> <200608070730.17813.ak@muc.de>
In-Reply-To: <200608070730.17813.ak@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> +/* Stop speculative execution */
>> +static inline void sync_core(void)
>> +{
>> +	unsigned int eax = 1, ebx, ecx, edx;
>> +	__cpuid(&eax, &ebx, &ecx, &edx);
>> +}
>>     
>
> Actually I don't think this one should be para virtualized at all.
> I don't see any reason at all why a hypervisor should trap it and it
> is very time critical. I would recommend you move it back into the 
> normal files without hooks.
>   

When VT/AMDV is enabled, cpuid could cause a vm exit, so it would be 
nice to use one of the other serializing instructions in this case.  For 
the default implementation, it should probably be an explicit 
asm("cpuid") to make it clear that we don't want any paravirtualized cpuid.

    J

