Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLSFpy>; Tue, 19 Dec 2000 00:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQLSFpp>; Tue, 19 Dec 2000 00:45:45 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:38616 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129289AbQLSFpc>; Tue, 19 Dec 2000 00:45:32 -0500
Date: Mon, 18 Dec 2000 21:15:04 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: linux-2.4.0-test13pre3/arch/i386/math-emu/fpu_system.h compilation error
Message-ID: <20001218211504.A22646@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	In linux-2.4.0-test13pre3 (or maybe pre1 or pre2),
mm_struct->segments became mm_struct->context.segmnets.  This change
adjusts linux-2.4.0-test13pre3/arch/i386/math-emu/fpu_system.h accordingly
so that i386 math emulation will compile again.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diffs

--- linux-2.4.0-test13-pre3/arch/i386/math-emu/fpu_system.h	Mon Dec 11 13:34:33 2000
+++ linux/arch/i386/math-emu/fpu_system.h	Mon Dec 18 21:10:35 2000
@@ -20,7 +20,7 @@
    of the stack frame of math_emulate() */
 #define SETUP_DATA_AREA(arg)	FPU_info = (struct info *) &arg
 
-#define LDT_DESCRIPTOR(s)	(((struct desc_struct *)current->mm->segments)[(s) >> 3])
+#define LDT_DESCRIPTOR(s)	(((struct desc_struct *)current->mm->context.segments)[(s) >> 3])
 #define SEG_D_SIZE(x)		((x).b & (3 << 21))
 #define SEG_G_BIT(x)		((x).b & (1 << 23))
 #define SEG_GRANULARITY(x)	(((x).b & (1 << 23)) ? 4096 : 1)

--IS0zKkzwUGydFO0o--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
