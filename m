Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751751AbWI1JcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWI1JcD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWI1JcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:32:03 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:2709 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751751AbWI1JcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:32:00 -0400
Message-ID: <451B9675.8070406@t-online.de>
Date: Thu, 28 Sep 2006 11:31:33 +0200
From: Bernd Schmidt <bernds_cb1@t-online.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Robin Getz <rgetz@blackfin.uclinux.org>, luke Yang <luke.adi@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
References: <6.1.1.1.0.20060927121508.01ecea90@ptg1.spd.analog.com> <6.1.1.1.0.20060927130329.01ece2a0@ptg1.spd.analog.com> <200609272257.02385.arnd@arndb.de>
In-Reply-To: <200609272257.02385.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: rSHWfMZVZez7KPYrVmuqRu4yMbt9y+rn0eawqH5-i3RtM1OjUVgF8W
X-TOI-MSGID: b400d3ac-7f9b-4152-9bee-55c67a70ae75
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:

> static inline void local_irq_enable(void)
> {
> 	unsigned long unused_flags;
> 	asm volatile ("sti %0;" : : "d" (unused_flags));
> }
> 
> That completely avoids all the problems you might hit with macro expansion,
> while still compiling to the same code.

The operand is an input, not an output.  We want to restore the proper 
mask of enabled interrupts with the STI.  That mask is in the global 
irq_flags variable (which probably ought to have a different name that 
doesn't invite clashes).


Bernd
