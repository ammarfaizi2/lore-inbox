Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWCPBfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWCPBfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 20:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWCPBfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 20:35:33 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:59150 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932599AbWCPBfd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 20:35:33 -0500
Message-ID: <4418C06D.4050600@vmware.com>
Date: Wed, 15 Mar 2006 17:33:33 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VMI Interface Proposal Documentation for I386, Part 5
References: <4415CE76.9030006@vmware.com> <Pine.LNX.4.64.0603132328270.11606@montezuma.fsmlabs.com> <44167E03.3060807@vmware.com> <20060315234137.GF1919@elf.ucw.cz>
In-Reply-To: <20060315234137.GF1919@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> from the hypervisor perspective - if the guest enables interrupts, and 
>> you have something pending to deliver, for correctness, you have to 
>> deliver it, right now.  But does the kernel truly require that interrupt 
>> deliver immediately - in most cases, no.  In particular, on the fast 
>>     
>
> I'd say PCI hardware can delay interrupts for any arbitrary
> delay... so if driver expects to get them "immediately", I'd say it is
> broken. It should be enough to deliver them "soon enough", like not
> more than 1msec late...
>   

I agree.  One case we hit that did cause us a bug was local APIC 
delivery of self-IPIs.  I didn't dig too deep into why Linux was unhappy 
without immediate delivery (we deferred delivery here unnecessarily, but 
did not stop it).  I believe this was in SMP specific code that was 
using self-IPIs to regenerate IRQs .

Zach
