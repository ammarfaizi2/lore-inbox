Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129375AbRBPHI7>; Fri, 16 Feb 2001 02:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129379AbRBPHIt>; Fri, 16 Feb 2001 02:08:49 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:14258 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129375AbRBPHIi>; Fri, 16 Feb 2001 02:08:38 -0500
Date: Thu, 15 Feb 2001 23:08:36 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: linux-2.4.2-pre3/arch/i386/boot/Makefile breaks with binutils-2.10.1.0.7
Message-ID: <20010215230836.A10861@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The "ld" program in binutils-2.10.1.0.7 and in
binutils-2.10.91.0.2 now requires "--oformat" instead of "-oformat".
This breaks linux-2.4.2-pre3/arch/i386/boot/Makefile.  I have attached
the fix below.  I am running a kernel built with this updated Makefile.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ld.diff"

--- linux-2.4.2-pre3/arch/i386/boot/Makefile	Mon Dec 20 14:43:39 1999
+++ linux/arch/i386/boot/Makefile	Fri Feb  9 15:37:53 2001
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

--TB36FDmn/VVEgNH/--
