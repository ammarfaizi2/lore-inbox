Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131831AbRAUAH1>; Sat, 20 Jan 2001 19:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132101AbRAUAHS>; Sat, 20 Jan 2001 19:07:18 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:48900 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131831AbRAUAHH>; Sat, 20 Jan 2001 19:07:07 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200101210006.BAA06025@green.mif.pg.gda.pl>
Subject: Re: Linux 2.4.0-ac10
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 21 Jan 2001 01:06:58 +0100 (CET)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

--- linux-2.4.0-ac9/arch/i386/boot/bootsect.S   Tue Jul 18 23:55:01 2000
+++ linux-2.4.0-ac10/arch/i386/boot/bootsect.S  Sat Jan 20 02:47:07 2001
@@ -5,8 +5,12 @@
  *     modified by Bruce Evans (bde)
  *     modified by Chris Noe (May 1999) (as86 -> gas)
  *
- * bootsect is loaded at 0x7c00 by the bios-startup routines, and moves
- * itself out of the way to address 0x90000, and jumps there.
+ * 360k/720k disk support: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>

I wonder how this line gets into your patch. Please, remove it (patch follows).
My bootsector patch is NOT enclosed into 2.4.0-ac10.

Yes, I did rewrite some time ago the bootsect.S to enable booting a kernel
with (bootsect.o + setup.o) > 4 kB   
[ it happens eg. when video selection is compiled in ]
from a 360k/720k (8 sec/track) floppy, but AFAIR it is alredy obsolete and
has never been ported to 2.4.

Note that it is almost impossible to compile an usable [you must turn off
networking] i386 2.4 kernel which fits into 360k floppy...

And there are other bootsect.S related unsolved problems [large kernels].

Regards
   Andrzej

**************************************************
--- arch/i386/boot/bootsect.S.orig	Sat Jan 20 18:36:39 2001
+++ arch/i386/boot/bootsect.S	Sat Jan 20 18:36:55 2001
@@ -5,8 +5,6 @@
  *	modified by Bruce Evans (bde)
  *	modified by Chris Noe (May 1999) (as86 -> gas)
  *
- * 360k/720k disk support: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
- *
  * BIG FAT NOTE: We're in real mode using 64k segments.  Therefore segment
  * addresses must be multiplied by 16 to obtain their respective linear
  * addresses. To avoid confusion, linear addresses are written using leading
**************************************************
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
