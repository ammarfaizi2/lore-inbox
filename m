Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWFZUw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWFZUw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWFZUw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:52:56 -0400
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3]:1516 "EHLO
	lana.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S1751268AbWFZUwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:52:55 -0400
Message-ID: <20060626225254.6hxf233zz4koog40@mail.tu-chemnitz.de>
Date: Mon, 26 Jun 2006 22:52:54 +0200
From: Ingo van Lil <inguin@gmx.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial: UART_BUG_TXEN race conditions
References: <20060626220747.zmkyd4smqs0o044s@mail.tu-chemnitz.de>
	<20060626202536.GJ21272@flint.arm.linux.org.uk>
In-Reply-To: <20060626202536.GJ21272@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
X-Scan-Signature: f63ec78c36006dbd9f08cecca336b949
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> schrieb:

>> 1. What if the IIR actually equals UART_IIR_THRI at that point? The
>>    read access will clear the interrupt condition and the workaround
>>    will effect the actual opposite of its intention: Neither
>>    serial8250_start_tx() nor the interrupt handler will start
>>    transmitting characters for the ring buffer.
>
> Gah, looks like you're right - reading the IIR will clear the transmit
> pending interrupt, so we should probably just load the transmitter up
> with characters anyway if the TEMT bit is set.

How about doing that on any controller, not just the buggy ones? It 
shouldn't cause any problems even on well-behaved UARTs, or could it?

> This function is run under the port spinlock, so the interrupt handler
> will be held off until it completes.

OK, great. Forget about my second concern, then.

Cheers,
Ingo


