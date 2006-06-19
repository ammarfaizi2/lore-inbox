Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWFSVwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWFSVwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWFSVwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:52:24 -0400
Received: from rtr.ca ([64.26.128.89]:60604 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964922AbWFSVwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:52:23 -0400
Message-ID: <44971C95.7050700@rtr.ca>
Date: Mon, 19 Jun 2006 17:52:21 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
References: <20060619180658.58945.qmail@web52908.mail.yahoo.com>	 <20060619184706.GH3479@flint.arm.linux.org.uk>  <4496FEC2.8050903@rtr.ca> <1150751212.2871.44.camel@localhost.localdomain>
In-Reply-To: <1150751212.2871.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Llu, 2006-06-19 am 15:45 -0400, ysgrifennodd Mark Lord:
>> If the drivers are written "correctly", they shouldn't grab the IRQ
>> until someone actually opens the device.  Which means they should be
>> able the share the IRQ, so long as both devices are not in use (open)
>> at the same time.
> 
> This is not the case for ISA bus. Most ISA hardware is physically unable
> to share and the drivers for such hardware intentionally grab the IRQ at
> load time to avoid it being mis-reused.

Eh?  The vast majority of ISA bus devices have open-collector IRQ lines,
which means that two devices on the same IRQ are "wire-ORed" (but they really
use edges).  There's no problem whatsoever with this in most setups.
I even implemented full support for it in the Linux IDE driver, way back when,
so that multiple cards could be installed on the same IRQ, and would work
just fine so long as access was serialized.  This was the one of the original
motivations for the IDE "serialize=" parameter.

Cheers
