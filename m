Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVBZQXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVBZQXw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 11:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVBZQXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 11:23:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57869 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261230AbVBZQXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 11:23:44 -0500
Date: Sat, 26 Feb 2005 17:23:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] deprecate EXPORT_SYMBOL(do_settimeofday)
Message-ID: <20050226162341.GN3311@stusta.de>
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org> <20050226133337.GK3311@stusta.de> <20050226144635.B7151@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226144635.B7151@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 02:46:35PM +0000, Russell King wrote:
> On Sat, Feb 26, 2005 at 02:33:37PM +0100, Adrian Bunk wrote:
> 
> Please don't deprecate this symbol.  ARM has a large variety of RTC
> implementations, some of which reside in I2C modules which are yet
> to be merged.
> 
> Firstly, these aren't accessible until the i2c subsystem has been
> initialised.  Secondly, i2c is modular, so this function must be
> accessible from a module in order for the system time/date to be
> initialised from the RTC with a modular build.
> 
> (It can be argued that you wouldn't want to build such a thing as a
> module in the first place, in which case removing the export would
> of course be fine.  However, we can't sanely force I2C to be either
> always builtin, and placing this expectation on people will eventually
> lead other janitors to complain that the symbol is used by modules but
> isn't exported.)

I saw drivers/acorn/char/i2c.c, but this file is always built statically 
on ARCH_ACORN without any dependency between ARCH_ACORN and I2C.
This is buggy.

Why can't such drivers select I2C and other required I2C_* variables?

Appropriate depends or selects are required in any case.
If you plan to make drivers like drivers/acorn/char/i2c.c modular, my 
patch is void.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

