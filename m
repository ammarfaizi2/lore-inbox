Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbUBUAiw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbUBUAiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:38:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:2476 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261457AbUBUAig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:38:36 -0500
Subject: Re: Fix silly thinko in sungem network driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1077323090.10877.9.camel@gaston>
References: <200402202307.i1KN7GBR003938@hera.kernel.org>
	 <1077321849.9719.32.camel@gaston> <1077322322.9623.34.camel@gaston>
	 <20040220162318.097006ee.davem@redhat.com>
	 <1077323090.10877.9.camel@gaston>
Content-Type: text/plain
Message-Id: <1077323574.10862.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 11:32:54 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And some more data:

Apple .h says:

#define kConfiguration_Infinite_Burst	0x00000001	// for Tx only
#define kConfiguration_RonPaulBit		0x00000800	// for pci reads at end of infinite burst, next command is memory read multiple
#define kConfiguration_EnableBug2Fix	0x00001000	// fix Rx hang after overflow

And the OF firmware (forth) driver does:

config rl@ 801 or config rl!

Which is interesting, that is it sets the RonPaulBit and the Infinite
Burst bit, and doesn't test the result...

Linus, does your G5 infinite burst bit sticks at all ? I think the
idea is that _older_ apple ones didn't have infinite burst, while newer
(G5) ones do, but also need the bug fix bits.

Which means the code Linus has is ok (without my latest patch).

Ben.




