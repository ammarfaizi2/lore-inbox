Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261983AbSIYOOo>; Wed, 25 Sep 2002 10:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261984AbSIYOOo>; Wed, 25 Sep 2002 10:14:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4107 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261983AbSIYOOm>;
	Wed, 25 Sep 2002 10:14:42 -0400
Date: Wed, 25 Sep 2002 15:19:43 +0100
From: Matthew Wilcox <willy@debian.org>
To: gerg@snapgear.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.5.38uc1 (MMU-less support)
Message-ID: <20020925151943.B25721@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for splitting the patch up, makes it easier to see what's going on.
Let's have another go at making this better...

Motorola 5272 ethernet driver:
* In Config.in, let's conditionalise it on CONFIG_PPC or something
* Can you use module_init() so it doesn't need an entry in Space.c?
* You're defining CONFIG_* variables in the .c file.  I don't know whether
  this is something we're still trying to avoid doing ... Greg, you seem
  to be CodingStyle enforcer, what's the word?
* Why do you need to EXPORT_SYMBOL fec_register_ph and fec_unregister_ph?
* There's an awful lot of stuff conditionalised on CONFIG_M5272.  In general,
  having #ifdefs within functions is frowned upon.

Motorola 68328 and ColdFire serial drivers:
* Move to drivers/serial
* Lose this change from the Makefile:
-			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o
+			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o \
* Drop the custom MIN() definition.
* Port to new serial driver framework.

MTD driver patches for uClinux supported platforms:
I don't see any problems.  Submit to Linus via Dave Woodhouse, I guess.

Motorola 68328 framebuffer:
Don't see any problems here either.

uClinux FLAT file format exe loader:
* Drop the MAX() macro.
* +#include "../lib/inflate2.c".  Er.  You seem to have missed inflate2.c
  from your patch, and this really isn't the right way to do it anyway.
  Can't you share inflate.c these days?
* I'm also a little unsure about your per-arch #defines.  Could you put
  comments by each saying why they're necessary?

I haven't reveiwed the other two patches.

-- 
Revolutions do not require corporate support.
