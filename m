Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129448AbRBJMCQ>; Sat, 10 Feb 2001 07:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129751AbRBJMCG>; Sat, 10 Feb 2001 07:02:06 -0500
Received: from mail.kdt.de ([195.8.224.4]:64520 "EHLO mail.kdt.de")
	by vger.kernel.org with ESMTP id <S129448AbRBJMBz>;
	Sat, 10 Feb 2001 07:01:55 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Patch to support also new binutils versions
From: Andreas Jaeger <aj@suse.de>
Date: 10 Feb 2001 13:01:38 +0100
Message-ID: <u8k86yoifx.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

newer binutils (current CVS version and the soon to be release 2.11)
don't support "ld -oformat binary" anymore.  Instead two dashes should
be used ("ld --oformat binary").  This works with both old and new
binutils.

Please apply the appended patch which fixes all occurences in the
kernel.

Thanks,
Andreas

--- arch/i386/boot/Makefile	Tue Dec 21 05:00:53 1999
+++ /usr/src/linux-2.4.2-pre3/arch/i386/boot/Makefile	Sat Feb 10 12:56:36 2001
@@ -43,7 +43,7 @@
 	$(HOSTCC) $(HOSTCFLAGS) -o $@ $< -I$(TOPDIR)/include
 
 bootsect: bootsect.o
-	$(LD) -Ttext 0x0 -s -oformat binary -o $@ $<
+	$(LD) -Ttext 0x0 -s --oformat binary -o $@ $<
 
 bootsect.o: bootsect.s
 	$(AS) -o $@ $<
@@ -52,7 +52,7 @@
 	$(CPP) $(CPPFLAGS) -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
 bbootsect: bbootsect.o
-	$(LD) -Ttext 0x0 -s -oformat binary $< -o $@
+	$(LD) -Ttext 0x0 -s --oformat binary $< -o $@
 
 bbootsect.o: bbootsect.s
 	$(AS) -o $@ $<
@@ -61,7 +61,7 @@
 	$(CPP) $(CPPFLAGS) -D__BIG_KERNEL__ -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
 setup: setup.o
-	$(LD) -Ttext 0x0 -s -oformat binary -e begtext -o $@ $<
+	$(LD) -Ttext 0x0 -s --oformat binary -e begtext -o $@ $<
 
 setup.o: setup.s
 	$(AS) -o $@ $<
@@ -70,7 +70,7 @@
 	$(CPP) $(CPPFLAGS) -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
 bsetup: bsetup.o
-	$(LD) -Ttext 0x0 -s -oformat binary -e begtext -o $@ $<
+	$(LD) -Ttext 0x0 -s --oformat binary -e begtext -o $@ $<
 
 bsetup.o: bsetup.s
 	$(AS) -o $@ $<

-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
