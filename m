Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWGRL2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWGRL2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWGRL2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:28:03 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:14013 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932141AbWGRL2C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:28:02 -0400
Message-ID: <44BCC5C1.5020305@vmware.com>
Date: Tue, 18 Jul 2006 04:28:01 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 15/33] move segment checks to subarch
References: <20060718091807.467468000@sous-sol.org>	 <20060718091952.263186000@sous-sol.org> <1153217344.3038.31.camel@laptopd505.fenrus.org>
In-Reply-To: <1153217344.3038.31.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
>   
>> plain text document attachment (i386-segments)
>> We allow for the fact that the guest kernel may not run in ring 0.
>> This requires some abstraction in a few places when setting %cs or
>> checking privilege level (user vs kernel).
>>     
>
>   
>> -	regs.xcs = __KERNEL_CS;
>> +	regs.xcs = get_kernel_cs();
>>     
>
> Hi,
>
> wouldn't this patch be simpler if __KERNEL_CS just became the macro that
> currently is get_kernel_cs() for the XEN case? then code like this
> doesn't need changing at all...
>   

The tradeoff is that then you can't use __KERNEL_CS is assembler code, 
and it is used in entry.S to detect NMI / debug trap workarounds - which 
don't actually need to be paravirtualized, as it is easier to hide the 
nasty cases which cause those side effects.

Zach
