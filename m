Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268962AbTGOQvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268964AbTGOQvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:51:38 -0400
Received: from mail5.iserv.net ([204.177.184.155]:22180 "EHLO mail5.iserv.net")
	by vger.kernel.org with ESMTP id S268962AbTGOQvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:51:35 -0400
Message-ID: <3F14348B.4050606@didntduck.org>
Date: Tue, 15 Jul 2003 13:06:19 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kathy Frazier <kfrazier@mdc-dayton.com>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: Interrupt doesn't make it to the 8259 on a ASUS P4PE mobo
References: <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com>
In-Reply-To: <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kathy Frazier wrote:
> Thanks for your reply, Andi.
> 
> 
>>>We have a proprietary PCI board installed in a (UP) system with an ASUS
> 
> P4PE
> 
>>>motherboard (uses Intel 845PE chipset). This system is running Red Hat
> 
> 9.0
> 
> 
>>Have you checked the 845 errata sheets on the Intel website?
>>Perhaps it is some known hardware bug.
> 
> 
>>One thing you could try is to use Local APIC / IO APIC interrupt processing
>>instead of 8259.
> 
> 
> Our hardware engineer has combed the Intel and ASUS websites, but found
> nothing.  I'll give the APIC a try and see if I get different results and
> let you know.
> 
> 
>>>/* start timer */
>>>dmatimer.expires = jiffies + 0.5*HZ;
> 
> 
>>That's a serious bug. You cannot use floating point in the kernel.
>>It will corrupt the FP state of the user process.
> 
> 
> HZ on the INTEL platform is 100, so this should simply add 50 to the current
> value of jiffies.  Besides, assigning the value to the unsigned int field
> (expires) will truncate it to an integer anyway.

Use HZ/2 instead.  GCC doesn't optimize floating point constants to the 
same degree it does integers, because it doesn't know what mode 
(rounding, precision) the FPU is in.

--
				Brian Gerst

