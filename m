Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318914AbSHWQkf>; Fri, 23 Aug 2002 12:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318918AbSHWQkf>; Fri, 23 Aug 2002 12:40:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27008 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318914AbSHWQke>; Fri, 23 Aug 2002 12:40:34 -0400
Date: Fri, 23 Aug 2002 12:45:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Robert Love <rml@tech9.net>
cc: sanket rathi <sanket@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: interrupt handler
In-Reply-To: <1030119432.863.3674.camel@phantasy>
Message-ID: <Pine.LNX.3.95.1020823123854.2797A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Aug 2002, Robert Love wrote:

> On Fri, 2002-08-23 at 08:17, Richard B. Johnson wrote:
> 
> > Interrupts default to OFF within an interrupt handler. Given this,
> > why would you use a spin-lock within the ISR on a single-processor
> > machine?
> 
> Only the current interrupt handler is disabled... interrupts are
> normally ON.
> 
> 	Robert Love

No. Check out irq.c, line 446. The interrupts are turned back on
only if the flag did not have SA_INTERRUPT set. Certainly most
requests for interrupt services within drivers have SA_INTERRUPT
set.

This is linux-2.4.18 or 2.4.19. If the current code, 2.5+ enables
by default, it's broken and should be fixed.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

