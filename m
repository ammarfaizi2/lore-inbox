Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWHWJOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWHWJOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWHWJOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:14:38 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:43724 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751466AbWHWJOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:14:37 -0400
Message-ID: <44EC1C7C.9020304@vmware.com>
Date: Wed, 23 Aug 2006 02:14:36 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain> <200608231050.13272.ak@suse.de> <44EC194E.6080606@vmware.com> <200608231106.26696.ak@suse.de>
In-Reply-To: <200608231106.26696.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 23 August 2006 11:01, Zachary Amsden wrote:
>   
>> Andi Kleen wrote:
>>     
>>>> Yes, after discussion with Rusty, it appears that beefing up 
>>>> stop_machine_run is the right way to go.  And it has benefits for 
>>>> non-paravirt code as well, such as allowing plug-in kprobes or oprofile 
>>>> extension modules to be loaded without having to deal with a debug 
>>>> exception or NMI during module load/unload.
>>>>     
>>>>         
>>> I'm still unclear where you think those debug exceptions will come from
>>>       
>> kprobes set in the stop_machine code - which is probably a really bad 
>> idea, but nothing today actively stops kprobes from doing that.
>>     
>
> kprobes don't cause any debug exceptions. You mean int3?
>
> Anyways this can be fixed by marking the stop machine code __kprobes
>
> -Andi
>   

I need to look at the kprobes code in more depth to answer completely.  
But in general, there could be a problem if DRs are set to fire on any 
EIP or memory address touched during the critical stop_machine region, 
or int3 breakpoints are set in that code or any code it calls.

Zach
