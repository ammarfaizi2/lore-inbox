Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVABRf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVABRf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 12:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVABRf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 12:35:57 -0500
Received: from mail.tmr.com ([216.238.38.203]:22217 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261297AbVABRft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 12:35:49 -0500
Message-ID: <41D833A3.6060003@tmr.com>
Date: Sun, 02 Jan 2005 12:47:15 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.10 - Misrouted IRQ recovery for review
References: <1104249508.22366.101.camel@localhost.localdomain>	 <41D70AF4.7030901@tmr.com> <1104679098.14712.68.camel@localhost.localdomain>
In-Reply-To: <1104679098.14712.68.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>I saw this message coming out of ac2 with my runaway IRQ 18 problem, so 
>>I tried irqpoll, and it just "went away" beyond sysreq or other gentle 
>>recovery.
> 
> 
> That means that the cause of the IRQ that hung your machine was not one
> we had any driver for. Thats generally BIOS bogosities on a large scale.
> The irqpoll code can recover from cases where an IRQ turns up on the
> wrong IRQ line but for a registered driver and when an IRQ fails to turn
> up in which case the timer tick picks it up on x86 (which may or may not
> make it "useful").
> 
> 
>>I suspect that the problem lies in sharing the shared IRQ, and that 
>>polling doesn't solve the problem, just changes it to a hang witing for 
>>the misrouted IRQ. Still poking for the real cause, no patch or 
>>anything, but acpi={off,ht}, noapic, pci=routeirq, etc have no benefit 
>>(for me).
> 
> 
> That wouldn't really fit how the hardware works. You appear to have some
> unsupported device connected to that line and asserting IRQ right from
> boot.

I cautiously say I don't think that's the case. I can boot and run in 
console mode for hours, as long as I don't do anything which accesses 
the DVD burner master on ide1. Both drives on ide0 work fine, network 
works, audio works, etc.

The instant I use hdc (which *is* IRQ shared with ide0) I get the storm 
and it continues until reboot. I have tried about every acpi=, pci=, and 
noapic option I can find, without success. However, some options do move 
the IRQ for both ide interfaces to IRQ 11, where the behaviour is identical.

Under 2.4.22 from FC1 it all works fine. I do use a vaimraid driver in 
2.4 (taints kernel), but everything works fine with or without it 
loaded, and the VIAraid comes up on another IRQ in any case.

Feel free to tell me this could still be another device, but it behaves 
as if it were the ide1 (DVD) access. Oh, I did try making ide1=nodma 
without change.

Thanks for the feedback, though.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
