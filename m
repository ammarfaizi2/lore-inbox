Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbRBVT55>; Thu, 22 Feb 2001 14:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRBVT5i>; Thu, 22 Feb 2001 14:57:38 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:22801 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129185AbRBVT51>;
	Thu, 22 Feb 2001 14:57:27 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Heitzso <xxh1@cdc.gov>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        torvalds@transmeta.com
Subject: Re: trouble with 2.4.2 just released 
In-Reply-To: Your message of "Thu, 22 Feb 2001 13:55:28 CDT."
             <B7F9A3E3FDDDD11185510000F8BDBBF2049E810D@mcdc-atl-5.cdc.gov> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 23 Feb 2001 06:57:20 +1100
Message-ID: <7820.982871840@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001 13:55:28 -0500, 
Heitzso <xxh1@cdc.gov> wrote:
>ld: cannot open binary: no such file or directory

Binutils incompatibility.  Linus, please apply.

Index: 2.1/arch/i386/boot/Makefile
--- 2.1/arch/i386/boot/Makefile Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/T/c/44_Makefile 1.1 644)
+++ 2.1(w)/arch/i386/boot/Makefile Fri, 23 Feb 2001 06:55:22 +1100 kaos (linux-2.4/T/c/44_Makefile 1.1 644)
@@ -27,7 +27,7 @@ compressed/bvmlinux: $(TOPDIR)/vmlinux
 	@$(MAKE) -C compressed bvmlinux
 
 zdisk: $(BOOTIMAGE)
-	dd bs=8192 if=$(BOOTIMAGE) of=/dev/fd0
+	dd conv=notrunc bs=8192 if=$(BOOTIMAGE) of=/dev/fd0
 
 zlilo: $(CONFIGURE) $(BOOTIMAGE)
 	if [ -f $(INSTALL_PATH)/vmlinuz ]; then mv $(INSTALL_PATH)/vmlinuz $(INSTALL_PATH)/vmlinuz.old; fi
@@ -43,7 +43,7 @@ tools/build: tools/build.c
 	$(HOSTCC) $(HOSTCFLAGS) -o $@ $< -I$(TOPDIR)/include
 
 bootsect: bootsect.o
-	$(LD) -Ttext 0x0 -s -oformat binary -o $@ $<
+	$(LD) -Ttext 0x0 -s --oformat binary -o $@ $<
 
 bootsect.o: bootsect.s
 	$(AS) -o $@ $<
@@ -52,7 +52,7 @@ bootsect.s: bootsect.S Makefile $(BOOT_I
 	$(CPP) $(CPPFLAGS) -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
 bbootsect: bbootsect.o
-	$(LD) -Ttext 0x0 -s -oformat binary $< -o $@
+	$(LD) -Ttext 0x0 -s --oformat binary $< -o $@
 
 bbootsect.o: bbootsect.s
 	$(AS) -o $@ $<
@@ -61,7 +61,7 @@ bbootsect.s: bootsect.S Makefile $(BOOT_
 	$(CPP) $(CPPFLAGS) -D__BIG_KERNEL__ -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
 setup: setup.o
-	$(LD) -Ttext 0x0 -s -oformat binary -e begtext -o $@ $<
+	$(LD) -Ttext 0x0 -s --oformat binary -e begtext -o $@ $<
 
 setup.o: setup.s
 	$(AS) -o $@ $<
@@ -70,7 +70,7 @@ setup.s: setup.S video.S Makefile $(BOOT
 	$(CPP) $(CPPFLAGS) -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
 
 bsetup: bsetup.o
-	$(LD) -Ttext 0x0 -s -oformat binary -e begtext -o $@ $<
+	$(LD) -Ttext 0x0 -s --oformat binary -e begtext -o $@ $<
 
 bsetup.o: bsetup.s
 	$(AS) -o $@ $<

