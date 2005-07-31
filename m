Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVGaW50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVGaW50 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVGaW5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:57:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55005 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262017AbVGaWzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:55:45 -0400
Date: Sun, 31 Jul 2005 15:55:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: ambx1@neo.rr.com
cc: Pavel Machek <pavel@ucw.cz>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <2e00842e116e.2e116e2e0084@columbus.rr.com>
Message-ID: <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Jul 2005 ambx1@neo.rr.com wrote:
> 
> In general, I think that calling free_irq is the right behavior.

I DO NOT CARE!

It breaks hundreds of drivers. End of discussion.

You can do the free_irq() and request_irq() changes _without_ breaking 
hundreds of drivers by just doing one driver at a time. 

And if ACPI then restores the irq controller state, the drivers that 
_don't_ do this will _also_ continue to work.

Let me re-iterate: the ACPI changes provably BROKE REAL PEOPLES SETUPS. 

For absolutely _zero_ gain. Drivers that want to free and re-aquire an 
interrupt can do so _regardless_ of whether ACPI restores irq routings 
automatically or not.

And that's my argument. We don't do stupid things that break peoples 
existing setups in ways that nobody can debug. 

		Linus
