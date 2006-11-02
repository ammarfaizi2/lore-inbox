Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752042AbWKBLEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbWKBLEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 06:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbWKBLEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 06:04:51 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:3304 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752042AbWKBLEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 06:04:51 -0500
Message-ID: <4549D0D2.6050309@vmware.com>
Date: Thu, 02 Nov 2006 03:04:50 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, ak@muc.de,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 4/7] Allow selected bug checks to be skipped by paravirt
 kernels
References: <20061029024504.760769000@sous-sol.org> <20061029024606.496399000@sous-sol.org> <20061101121753.GA2205@elf.ucw.cz> <45492CBC.8020501@vmware.com> <20061102102059.GB1990@elf.ucw.cz>
In-Reply-To: <20061102102059.GB1990@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>>> How can hlt check break? It is hlt;hlt;hlt, IIRC, that looks fairly
>>> innocent to me.
>>>  
>>>       
>> Not if you use tickless timers that don't generate interrupts to unhalt 
>> you, or if you delay ticks until the next scheduled timeout and you 
>> haven't yet scheduled any timeout.  Both are likely in a hypervisor.
>>     
>
> Well.. but you are working around problem, instead of fixing it.
>
> Tickless kernels are possible on normal machines, too.
>
> Please fix it properly... probably by requesting timer 10msec in
> advance or something.
> 									Pavel
>   

Well, I agree in spirit, but there is something to be said for keeping 
the code less complicated by removing these workarounds for broken 
processors.  Preferably, we could remove the hlt check entirely, but 
then those people with these broken processors would not get the 
expected behavior of stalling during boot - that is the expected 
behavior of failure, correct?  In any case, I added this workaround for 
the case when running under Xen.  I would rather not add a dependence on 
timer scheduling to legacy bug checking code when the number of timer 
sources and tickless variations available is proliferating and the 
number of legacy processors that would even need this check is rapidly 
approaching zero.

Zach
