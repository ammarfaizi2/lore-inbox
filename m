Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbTAQTYH>; Fri, 17 Jan 2003 14:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbTAQTYG>; Fri, 17 Jan 2003 14:24:06 -0500
Received: from havoc.daloft.com ([64.213.145.173]:26256 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267643AbTAQTYE>;
	Fri, 17 Jan 2003 14:24:04 -0500
Date: Fri, 17 Jan 2003 14:32:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Initcall / device model meltdown?
Message-ID: <20030117193256.GE8304@gtf.org>
References: <20030117192356.F13888@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117192356.F13888@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 07:23:56PM +0000, Russell King wrote:
> 1. the device model requires a certain initialisation order.
> 2. modules need to use module_init() which means the initialisation order
>    is link-order dependent, despite our multi-level initialisation system.
> 
> Obviously one solution would be to spread the drivers for this
> multifunction chip throughout the kernel tree (ie, by function not
> by device) so the touchscreen driver would live under drivers/input.
> 
> However, then we need to make sure that the multifunction chip's
> bus type is initialised before any of the other subsystems, and of
> course, the bus type is initialised using module_init() since it
> lives in a module...
> 
> I think we need to re-think what we're doing with the initialisation
> handling and the device model before these sorts of problems get out
> of hand.

IMO this link order business is a problem that's existed for ages,
it's unrelated to the device model, and adding seven levels of
initcalls merely hid this problem a little bit.

Back when I was doing fbdev stuff, I just gave up and did things "the
old way", a la

	#ifdef MODULE
	module_init(my_driver);
	#endif

and then call my_driver from other code, when it is built into the
kernel, overriding link order.

Not a great solution, I know.  My preferred solution has always been to
explicitly list the dependencies, so a build-time tool can figure out
the link order automagically.

	Jeff



