Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbUBXBGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUBXBGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:06:17 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:37011 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262120AbUBXBGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:06:06 -0500
Date: Mon, 23 Feb 2004 20:06:05 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] yenta: irq-routing for TI bridges
In-Reply-To: <200402240132.31659.daniel.ritz@gmx.ch>
Message-ID: <Pine.LNX.4.58.0402231947520.30747@marabou.research.att.com>
References: <200402240033.31042.daniel.ritz@gmx.ch> <20040224000051.C25358@flint.arm.linux.org.uk>
 <200402240132.31659.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Daniel Ritz wrote:

> ok, not good. what about: read the routing in MFUNC0, test if it works,
> only set to PCI if it doesn't work. the problem is we can't test if
> another device already sits on that irq. we shouldn't do anything then.

What if we just check if irqmux is 0.  Is it 0 on your card?  I believe
the only problem is the the cards that don't have irqmux initialized from
EEPROM.

I think that your fix is too intrusive.  I'm not sure it's worth it.
After all, we are not going to support every possible piece of broken
hardware, only those that are relatively widespread.  I have one, you have
one (presumably), let's see what we have.

Could you please give more information about your hardware?  My hardware
is a card based on TI PCI1410 with broken EEPROM.  It has one slot.
irqmux is 0 on startup.  Attempts to write to EEPROM damage the card
permanently.  It stops working as a valid PCI device and prevents booting
Linux with PCI support.

I'm concerned that you are reading irqmux in ti_override(), which is also
used in bridges without irqmux.  Those bridges only need changes in devctl
if any.  The fix should be in ti12xx_override() or even ti1250_override().

> yeah, not as it is now. more checks are needed, PCI fallback only if
> nothing else works. may be we should just make it a module param like in
> pcmcia-cs i82365.c?

The parameter would be the last resort.  Shifting the problem to the users
is more like a surrender than a victory.  Not to mention that such
approach won't work well with multiple card and/or solid kernel.

-- 
Regards,
Pavel Roskin
