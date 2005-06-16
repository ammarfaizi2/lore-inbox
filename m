Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVFPGtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVFPGtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 02:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVFPGtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 02:49:08 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43672 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261761AbVFPGtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 02:49:02 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: karim@opersys.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spurious parport interrupts (IRQ 7) / rt benchmarking
Date: Thu, 16 Jun 2005 09:48:42 +0300
User-Agent: KMail/1.5.4
Cc: Kristian Benoit <kbenoit@opersys.com>
References: <42B09CB3.4030101@opersys.com>
In-Reply-To: <42B09CB3.4030101@opersys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506160948.42880.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 June 2005 00:25, Karim Yaghmour wrote:
> 
> This is related to our continued benchmarking of the rt stuff.
> 
> Using the same setup we described earlier, we're now getting
> some really odd behavior on rc6. Basically, our target system
> is getting more interrupts than our logger is sending to it.
> 
> [ recap: our target and logger are rigged via the parallel
> port. The logger toggles an output pin on the parallel pin
> which, in turn, generates an interrupt on the target. Our
> driver on the target catches the interrupt and then toggles
> an output pin on the target's parallel port. This, in turn,
> generates an interrupt on the logger. The difference between
> the time the interrupt was sent by the logger and the time
> the interrupt is received from the target on the logger is
> what we measure as the interrupt response time. ]
> 
> Under ping flood conditions with vanilla Linux, and in that
> case only, rc6 gets more interrupts than the logger sends
> to it. We've double checked this by not sending any ints
> from the logger whatsoever, and ping flooding the rc6 on
> the target, and the moment we do that our driver on the
> target starts responding to phantom interrupts.
> 
> It must be noted that when we did these tests on rc4 we didn't
> have such spurious interrupts. Also, we don't get these when
> PREEMPT_RT is applied to rc6 (all of which under ping flood
> conditions.)
> 
> We've tried to find a pattern in the spuriousness, but there
> really isn't any.
> 
> We've spent quite some time tracking this down, hence the
> delayed publication of new numbers.
> 
> Any insight anyone may have on this issue would be greatly
> appreciated.

IIRC specs of old AT PIC say that if input interrupt pins
are no longer asserted by the time when CPU asserts IRQ and tries
to read IRQ# from PIC, PIC returns 7. Thus you get IRQ7 or IRQ15
depending on where that happened, on primary or secondary PIC.

Presumably there can be 'bad' devices which momentarily flash
their IRQ, confusing PIC.

However, I am a bit surprized how often these IRQ7s happen.
Maybe APIC's PIC emulation just reuses this convention to
indicate APIC errors in PIC emulation mode. I am not familiar
with APIC, tho... I did not yet read APIC docs.
--
vda

