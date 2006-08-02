Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWHBX2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWHBX2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 19:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWHBX2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 19:28:18 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:46532 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932333AbWHBX2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 19:28:17 -0400
Message-ID: <44D13510.1040309@vc.cvut.cz>
Date: Thu, 03 Aug 2006 01:28:16 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Mathias Adam <a2@adamis.de>
Subject: Re: make 16C950 UARTs work
References: <20060802194938.GL5972@redhat.com> <1154556536.23655.30.camel@localhost.localdomain> <20060802215958.GA19669@flint.arm.linux.org.uk>
In-Reply-To: <20060802215958.GA19669@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Aug 02, 2006 at 11:08:56PM +0100, Alan Cox wrote:
> 
>>Ar Mer, 2006-08-02 am 15:49 -0400, ysgrifennodd Dave Jones:
>>
>>>This patch has been submitted a number of times, and doesn't seem
>>>to get any upstream traction, which is a shame, as it seems to work
>>>for users, and I keep inadvertantly dropping it from the Fedora
>>>kernel everytime I rebase it.
>>
>>We really ought to do that based on the PCI subvendor/subdevice id of
>>the boards in use if possible surely ? It ought to be safe for x86
>>because nobody is going to use anything but chip default values so they
>>can avoid needing a ROM.
> 
> 
> Not correct - there are PCMCIA-based versions of these chips and they
> do have weirdo values in the registers to cope with custom crystals
> which magically vanish if you reset the UART.

But current serial.c IS resetting UART.  Unconditionally.  So I have no idea how 
is card setup supposed to survive...

> dwmw2's 950-based bluetooth CF card does exactly this.

To my knowledge right fix for this is allowing non-standard baud rates and then 
asking Dave to find which xtal his card uses.  I have to use baud_base 50400 
(xtal 806.4kHz) with one of my 16c950 pcmcia modems, and 1152000 with another 
(xtal 18.432MHz) one.  Under Windows both work "out of the box" as prescaller is 
programmed to 7/16 (resp. 10) by their EPROM, but Linux driver ditches this 
setting out of 16c950 registers (by resetting chip).  In second case fortunately 
code knows how to program 10 times bigger values to the registers, but with 
first modem it fails as it has no idea how to derive 115200Bd from 806kHz XTAL...
					Thanks,
						Petr Vandrovec

