Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWCNQpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWCNQpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWCNQpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:45:51 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:33548 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751345AbWCNQpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:45:50 -0500
Message-ID: <4416F30D.3040403@vmware.com>
Date: Tue, 14 Mar 2006 08:45:01 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VMI Interface Proposal Documentation for I386, Part 5
References: <4415CE76.9030006@vmware.com> <Pine.LNX.4.64.0603132328270.11606@montezuma.fsmlabs.com> <44167E03.3060807@vmware.com> <Pine.LNX.4.64.0603140040230.11606@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.64.0603140040230.11606@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> Hello Zach,
>
> On Tue, 14 Mar 2006, Zachary Amsden wrote:
>
>   
>> It could be possible to change the semantics of the interrupt masking
>> interface in Linux, such that enable_interrupts() did just that - but did not
>> yet deliver pending IRQs.  As did restore_interrupt_mask().  This would
>> require inspection of many drivers to ensure that they don't rely on those
>> actions causing immediate interrupt delivery.  And if they did, they would
>> require a call, say, deliver_pending_irqs() to accomplish that.
>>     
>
> I think we can break these down into low level and higher level interrupt 
> enabling. Lower level tends to be call sites like exception entry, in that 
> particular case drivers aren't aware of the interrupt enable/disable 
> semantics so it's safe to enable without dispatch. Higher up is where 
> dispatch makes sense and we can closer mimick hardware.
>   

Yes, there may clearly be a benefit to having a low level / high level 
separation - say STI / PUSHF / POPF, and EnableInterrupts, 
SaveInterruptFlag, RestoreInterruptFlag.  I didn't want to do that yet, 
since it adds bulk to the interface, but there clearly is some value 
there.  And as you point out, it does save a driver audit.

Zach
