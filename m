Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUCPObN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUCPObK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:31:10 -0500
Received: from styx.suse.cz ([82.208.2.94]:2434 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261943AbUCPOTs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:48 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467773240@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 31/44] Fix i8042 PS/2 mouse on ARM
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <1079446777406@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.61.4, 2004-03-05 09:29:47+01:00, rmk@arm.linux.org.uk
  input: Fix i8042 PS/2 mouse on ARM.


 drivers/input/serio/i8042-io.h      |    3 +++
 include/asm-arm/arch-ebsa285/irqs.h |    4 ++--
 include/asm-arm/arch-shark/irqs.h   |    3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
--- a/drivers/input/serio/i8042-io.h	Tue Mar 16 13:18:11 2004
+++ b/drivers/input/serio/i8042-io.h	Tue Mar 16 13:18:11 2004
@@ -25,6 +25,9 @@
 #elif defined(__ia64__)
 # define I8042_KBD_IRQ isa_irq_to_vector(1)
 # define I8042_AUX_IRQ isa_irq_to_vector(12)
+#elif defined(__arm__)
+/* defined in include/asm-arm/arch-xxx/irqs.h */
+#include <asm/irq.h>
 #else
 # define I8042_KBD_IRQ	1
 # define I8042_AUX_IRQ	12
diff -Nru a/include/asm-arm/arch-ebsa285/irqs.h b/include/asm-arm/arch-ebsa285/irqs.h
--- a/include/asm-arm/arch-ebsa285/irqs.h	Tue Mar 16 13:18:11 2004
+++ b/include/asm-arm/arch-ebsa285/irqs.h	Tue Mar 16 13:18:11 2004
@@ -91,8 +91,8 @@
 
 #undef RTC_IRQ
 #define RTC_IRQ		IRQ_ISA_RTC_ALARM
-#undef AUX_IRQ
-#define AUX_IRQ		(machine_is_netwinder() ? IRQ_NETWINDER_PS2MOUSE : IRQ_ISA_PS2MOUSE)
+#define I8042_KBD_IRQ	IRQ_ISA_KEYBOARD
+#define I8042_AUX_IRQ	(machine_is_netwinder() ? IRQ_NETWINDER_PS2MOUSE : IRQ_ISA_PS2MOUSE)
 #define IRQ_FLOPPYDISK	IRQ_ISA_FLOPPY
 
 #define irq_canonicalize(_i)	(((_i) == IRQ_ISA_CASCADE) ? IRQ_ISA_2 : _i)
diff -Nru a/include/asm-arm/arch-shark/irqs.h b/include/asm-arm/arch-shark/irqs.h
--- a/include/asm-arm/arch-shark/irqs.h	Tue Mar 16 13:18:11 2004
+++ b/include/asm-arm/arch-shark/irqs.h	Tue Mar 16 13:18:11 2004
@@ -8,5 +8,6 @@
 
 #define IRQ_ISA_KEYBOARD	 1
 #define RTC_IRQ			 8
-#define AUX_IRQ			12
+#define I8042_KBD_IRQ		 1
+#define I8042_AUX_IRQ		12
 #define IRQ_HARDDISK            14

