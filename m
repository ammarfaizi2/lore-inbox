Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285629AbRLGWm1>; Fri, 7 Dec 2001 17:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285631AbRLGWmR>; Fri, 7 Dec 2001 17:42:17 -0500
Received: from mtiwmhc22.worldnet.att.net ([204.127.131.47]:54981 "EHLO
	mtiwmhc22.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S285630AbRLGWmH>; Fri, 7 Dec 2001 17:42:07 -0500
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011207164817.179789a7.dang@fprintf.net>
In-Reply-To: <Pine.LNX.4.33.0112070925280.851-100000@segfault.osdlab.org>
	<1007760235.10687.0.camel@localhost.localdomain> 
	<20011207164817.179789a7.dang@fprintf.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 14:32:54 -0800
Message-Id: <1007764377.10793.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-07 at 13:48, Daniel Gryniewicz wrote:
> I have a N5415 with the shipped BIOS.  (I've downloaded but not applied the
> BIOS update.  I'd have to boot into Windows to apply it. :)  What do you want
> me to send you?

Thanks for the response! I'm assuming the N5415 is an AMD Athlon or
Duron based notebook (some are PIII/Celeron). Are you having the same
problem with USB?

WRT the BIOS update, if you have WINE, you can run the .exe (I had to
use the keyboard shortcut for "Next", clicking didn't work). It won't
actually create the update disk, but it will extract the disk image into
an oddly-named directory under your WINE "TMP" directory. Look for
BIOS.IMG. Then run "dd if=BIOS.IMG of=/dev/fd0 bs=32c skip=1" (their
image format has a 32-byte header) and boom, there's your update disk!
It's even bootable.

The following patch will cause your DMI info to be printed to the screen
on boot. If you just apply the patch, recompile, and email (off-list) me
the "dmesg" output, that should be all I need. If you're feeling extra
helpful, email me the output of "dump_pirq" (from the pcmcia-cs package,
in the "debug-tools" directory) and "lspci -vvvxxx", too.

*** CUT HERE ***
--- linux/arch/i386/kernel/dmi_scan.c	Mon Nov 26 14:39:41 2001
+++ linux/arch/i386/kernel/dmi_scan.c	Fri Dec  7 14:25:18 2001
@@ -20,8 +20,8 @@
 	u16	handle;
 };
 
-#define dmi_printk(x)
-//#define dmi_printk(x) printk x
+//#define dmi_printk(x)
+#define dmi_printk(x) printk x
 
 static char * __init dmi_string(struct dmi_header *dm, u8 s)
 {
*** CUT HERE ***

Thanks again!

-Cory

