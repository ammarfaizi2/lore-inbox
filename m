Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWKZXF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWKZXF2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 18:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbWKZXF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 18:05:28 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:34825 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751893AbWKZXF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 18:05:27 -0500
Date: Sun, 26 Nov 2006 23:05:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Build breakage ...
Message-ID: <20061126230515.GA30767@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
References: <20061126224928.GA22285@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061126224928.GA22285@linux-mips.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 10:49:28PM +0000, Ralf Baechle wrote:
> ee3ce191e8eaa4cc15c51a28b34143b36404c4f5 breaks MIPS completely:
> 
> In file included from include/linux/bitops.h:9,
>                  from include/linux/thread_info.h:20,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:46,
>                  from arch/mips/kernel/asm-offsets.c:13:
> include/asm/bitops.h: In function ???set_bit???:
> include/asm/bitops.h:100: warning: implicit declaration of function ???BUILD_BUG_ON???
> include/asm/bitops.h:100: warning: implicit declaration of function ???typecheck???
> include/asm/bitops.h:100: error: expected expression before ???unsigned???
> include/asm/bitops.h:102: error: expected expression before ???unsigned???
> include/asm/bitops.h: In function ???clear_bit???:
> include/asm/bitops.h:148: error: expected expression before ???unsigned???
> include/asm/bitops.h:150: error: expected expression before ???unsigned???
> include/asm/bitops.h: In function ???change_bit???:
> include/asm/bitops.h:198: error: expected expression before ???unsigned???
> include/asm/bitops.h:200: error: expected expression before ???unsigned???
> 
> That sort of patches really should go to /dev/null so short before a release.

Ditto on ARM.  This level of breakage is simply not acceptable soo
close to a release, and needs the change reverting.

Note that on ARM, "allmodconfig" is really meaningless since it only
tests one configuration.  Ditto for the other all*config options.
kautobuild (or building a range of defconfigs) is the only real way
to check for breakage on ARM.

arch/arm/mach-sa1100/leds-assabet.c:34: warning: implicit declaration of function 'BUILD_BUG_ON'
arch/arm/mach-sa1100/leds-assabet.c:34: warning: implicit declaration of function 'typecheck'
arch/arm/mach-sa1100/leds-assabet.c:34: error: syntax error before 'unsigned'
arch/arm/mach-sa1100/leds-assabet.c:113: error: syntax error before 'unsigned'
arch/arm/mach-sa1100/leds-cerf.c:31: warning: implicit declaration of function 'BUILD_BUG_ON'
arch/arm/mach-sa1100/leds-cerf.c:31: warning: implicit declaration of function 'typecheck'
arch/arm/mach-sa1100/leds-cerf.c:31: error: syntax error before 'unsigned'
arch/arm/mach-sa1100/leds-cerf.c:109: error: syntax error before 'unsigned'
arch/arm/mach-sa1100/leds-hackkit.c:35: warning: implicit declaration of function 'BUILD_BUG_ON'
arch/arm/mach-sa1100/leds-hackkit.c:35: warning: implicit declaration of function 'typecheck'
arch/arm/mach-sa1100/leds-hackkit.c:35: error: syntax error before 'unsigned'
arch/arm/mach-sa1100/leds-hackkit.c:111: error: syntax error before 'unsigned'
arch/arm/mach-sa1100/leds-lart.c:34: warning: implicit declaration of function 'BUILD_BUG_ON'
arch/arm/mach-sa1100/leds-lart.c:34: warning: implicit declaration of function 'typecheck'
arch/arm/mach-sa1100/leds-lart.c:34: error: syntax error before 'unsigned'
arch/arm/mach-sa1100/leds-lart.c:100: error: syntax error before 'unsigned'
arch/arm/mach-pxa/leds-idp.c:36: warning: implicit declaration of function 'BUILD_BUG_ON'
arch/arm/mach-pxa/leds-idp.c:36: warning: implicit declaration of function 'typecheck'
arch/arm/mach-pxa/leds-idp.c:36: error: syntax error before 'unsigned'
arch/arm/mach-pxa/leds-idp.c:115: error: syntax error before 'unsigned'
arch/arm/mach-pxa/leds-lubbock.c:50: warning: implicit declaration of function 'BUILD_BUG_ON'
arch/arm/mach-pxa/leds-lubbock.c:50: warning: implicit declaration of function 'typecheck'
arch/arm/mach-pxa/leds-lubbock.c:50: error: syntax error before 'unsigned'
arch/arm/mach-pxa/leds-lubbock.c:124: error: syntax error before 'unsigned'
arch/arm/mach-pxa/leds-mainstone.c:45: warning: implicit declaration of function 'BUILD_BUG_ON'
arch/arm/mach-pxa/leds-mainstone.c:45: warning: implicit declaration of function 'typecheck'
arch/arm/mach-pxa/leds-mainstone.c:45: error: syntax error before 'unsigned'
arch/arm/mach-pxa/leds-mainstone.c:119: error: syntax error before 'unsigned'
arch/arm/mach-pxa/leds-trizeps4.c:39: warning: implicit declaration of function 'BUILD_BUG_ON'
arch/arm/mach-pxa/leds-trizeps4.c:39: warning: implicit declaration of function 'typecheck'
arch/arm/mach-pxa/leds-trizeps4.c:39: error: syntax error before 'unsigned'
arch/arm/mach-pxa/leds-trizeps4.c:132: error: syntax error before 'unsigned'


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
