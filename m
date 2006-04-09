Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWDISNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWDISNA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 14:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWDISNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 14:13:00 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:14064 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750834AbWDISM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 14:12:59 -0400
Date: Sun, 09 Apr 2006 12:12:54 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 2.6.16] Shared interrupts sometimes lost
In-reply-to: <5ZoDL-3rE-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Lee Revell <rlrevell@joe-job.com>
Message-id: <44394EA6.3000309@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5Zd5E-3vi-7@gated-at.bofh.it> <5ZoDL-3rE-7@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2006-04-08 at 14:10 +1000, Neil Brown wrote:
>>  To explain what I think is happening, let me start with a very simple
>>  case.  A number of PCI devices (this one included) have a number of
>>  events which can trigger an interrupt.  The events which are current
>>  are presented as bits in a register, and are ORed together (and
>>  possibly masked by another register) to make the IRQ line.
>>  When 1's are written to any bits in this register, it acknowledges
>>  the event and clears the bit.
>>  A typical code fragment is 
>>    events = read_register(INTERRUPTS);
>>    write_register(INTERRUPTS, events);
>>    ... handle each 1 bits in events ....
>>
> 
> Isn't a more typical IRQ handler:
> 
> while (events = read_register(INTERRUPTS) != 0) {
> 	...handle each bit in events and ACK it...
> }

That would be less efficient, it would read the register twice or more 
if any events have been set, and reading device registers can be 
expensive. In the unlikely event the event was set while inside the ISR 
the interrupt should be asserted again so there is no need to do this.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

