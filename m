Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSEUXli>; Tue, 21 May 2002 19:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316790AbSEUXlh>; Tue, 21 May 2002 19:41:37 -0400
Received: from [195.39.17.254] ([195.39.17.254]:22426 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316786AbSEUXlg>;
	Tue, 21 May 2002 19:41:36 -0400
Date: Wed, 22 May 2002 01:40:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020521234025.GB16320@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0205211557410.1307-100000@penguin.transmeta.com> <Pine.LNX.4.33.0205211614200.15094-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Applied. Nothing needed but some time for me to look through it.
> 
> Well, I may have to revert that.
> 
> 	mm/mm.o: In function `rw_swap_page':
> 	mm/mm.o(.text+0xaeb2): undefined reference to `suspend_device'
> 
> Please send me a fix asap.

One more build fix, this time for !CONFIG_SOFTWARE_SUSPEND but
CONFIG_ACPI:

I choosen this solution for now, as it is safest for ACPI people. I'll
modify suspend.c so that freezing part can be included without whole
suspend-to-disk support being included.
									Pavel

--- linux-swsusp.linus/drivers/acpi/acpi_system.c	Sun May 19 17:25:33 2002
+++ linux-swsusp/drivers/acpi/acpi_system.c	Wed May 22 01:32:31 2002
@@ -34,6 +34,7 @@
 #include <linux/sysrq.h>
 #include <linux/pm.h>
 #include <linux/device.h>
+#include <linux/suspend.h>
 #include <asm/uaccess.h>
 #include <asm/acpi.h>
 #include "acpi_bus.h"
--- linux-swsusp.linus/include/linux/suspend.h	Wed May 22 00:02:21 2002
+++ linux-swsusp/include/linux/suspend.h	Wed May 22 01:30:08 2002
@@ -60,6 +60,8 @@
 #define register_suspend_notifier(a)	do { } while(0)
 #define unregister_suspend_notifier(a)	do { } while(0)
 #define refrigerator(a)			do { BUG(); } while(0)
+#define freeze_processes()		do { panic("You need CONFIG_SOFTWARE_SUSPEND to do sleeps."); } while(0)
+#define thaw_processes()		do { } while(0)
 #endif
 
 #endif /* _LINUX_SWSUSP_H */

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
