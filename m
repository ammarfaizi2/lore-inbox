Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbRBXMjJ>; Sat, 24 Feb 2001 07:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129317AbRBXMi7>; Sat, 24 Feb 2001 07:38:59 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:52749 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129307AbRBXMir>; Sat, 24 Feb 2001 07:38:47 -0500
Date: Sun, 25 Feb 2001 01:38:43 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.2 'ld' fix
Message-ID: <20010225013843.A11029@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus/Alan

The ld in newer bintuils doesn't like -oformat, rather it
requires --oformat instead. This is backwards compatible at
least to 2.9.5 so shouldn't break anything :)

As far as I can tell on i386 uses ld in such a way.




  --cw


diff -Nur linux-2.4.2/arch/i386/boot/Makefile linux-2.4.2.new/arch/i386/boot/Makefile
--- linux-2.4.2/arch/i386/boot/Makefile	Tue Dec 21 11:43:39 1999
+++ linux-2.4.2.new/arch/i386/boot/Makefile	Sun Feb 25 01:12:23 2001
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
