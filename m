Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUBUAak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbUBUAak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:30:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:65451 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261452AbUBUAab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:30:31 -0500
Subject: Re: Fix silly thinko in sungem network driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20040220162318.097006ee.davem@redhat.com>
References: <200402202307.i1KN7GBR003938@hera.kernel.org>
	 <1077321849.9719.32.camel@gaston> <1077322322.9623.34.camel@gaston>
	 <20040220162318.097006ee.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1077323090.10877.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 11:24:50 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-21 at 11:23, David S. Miller wrote:

> I thought the idea was that if IBURST doesn't stick, then the Apple specific
> bits aren't implemented?
> 
> That's what the comment says.

I though the IBURST that doesn't stick was specific to latest Apple versions ?
Those latest Apple versions are _also_ the ones implementing the magic bug
fix bits (those appeared with the G5).

Or did I get it backward ? Hrm, maybe I did... Here's Apple code:

	fConfiguration	= kConfiguration_TX_DMA_Limit		// default Configuration value
					| kConfiguration_RX_DMA_Limit
					| kConfiguration_Infinite_Burst
					| kConfiguration_RonPaulBit
					| kConfiguration_EnableBug2Fix;
	WRITE_REGISTER( Configuration, fConfiguration );	// try the default

	ui32 = READ_REGISTER( Configuration );				// read it back
    if ( (ui32 & kConfiguration_Infinite_Burst) == 0 )	
    {													// not infinite-burst capable:
        ELG( 0, 0, 'Lims', "UniNEnet::initChip: set TX_DMA_Limit and RX_DMA_Limit." );
		fConfiguration	= (0x02 << 1) | (0x08 << 6);	// change TX_DMA_Limit, RX_DMA_Limit
		WRITE_REGISTER( Configuration, fConfiguration );
    }

What does your doco says ?

Ben.


