Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130304AbRAaAJG>; Tue, 30 Jan 2001 19:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130993AbRAaAIo>; Tue, 30 Jan 2001 19:08:44 -0500
Received: from [209.245.157.113] ([209.245.157.113]:5383 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130092AbRAaAIe>; Tue, 30 Jan 2001 19:08:34 -0500
Date: Tue, 30 Jan 2001 16:08:32 -0800
From: Christopher Neufeld <neufeld@linuxcare.com>
Message-Id: <200101310008.f0V08Wv23250@localhost.localdomain>
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: linux-kernel@vger.kernel.org
Subject: Request: increase in PCI bus limit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hello,

   I'm working at a customer site with custom hardware.  The 2.4.0 series
kernel almost works out of the box, but the machine has 52 PCI busses.
Plans are to produce a 4-way box which would have over 80 PCI busses.  The
file include/asm-i386/mpspec.h allocates space for 32 busses in the
definition of the macro MAX_MP_BUSSES.  When 52 busses are probed, some
arrays are filled out past their ends (there is no bounds checking
performed on the array filling), and the kernel oopses out.  The only patch
which has to be applied to make Linux run stably on these systems is to
increase that limit.  Would it be possible to bump it up to 128, or even
256, in later 2.4.* kernel releases?  That would allow this customer to
work with an unpatched kernel, at the cost of an additional 3.5 kB of
variables in the kernel.

   Thank you for any help.
   For completeness, here's the patch (against 2.4.0):

--- linux-2.4.0/include/asm-i386/mpspec.h.orig  Tue Jan 30 16:06:08 2001
+++ linux-2.4.0/include/asm-i386/mpspec.h       Tue Jan 30 16:06:21 2001
@@ -157,7 +157,7 @@
  */
 
 #define MAX_IRQ_SOURCES 128
-#define MAX_MP_BUSSES 32
+#define MAX_MP_BUSSES 256
 enum mp_bustype {
        MP_BUS_ISA = 1,
        MP_BUS_EISA,



-- 
 Christopher Neufeld		 		 neufeld@linuxcare.com
 Home page:  http://caliban.physics.utoronto.ca/neufeld/Intro.html
 "Don't edit reality for the sake of simplicity"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
