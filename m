Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbRLWOkr>; Sun, 23 Dec 2001 09:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283782AbRLWOki>; Sun, 23 Dec 2001 09:40:38 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:8140 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S282967AbRLWOk1>; Sun, 23 Dec 2001 09:40:27 -0500
Message-ID: <3C25ECBF.AF0E819C@Synopsys.COM>
Date: Sun, 23 Dec 2001 15:39:59 +0100
From: Harald Dunkel <harri@synopsys.COM>
Reply-To: harri@synopsys.COM
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Patch: Support for grub at installation time
Content-Type: multipart/mixed;
 boundary="------------96D855C91D04051D742DE622"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------96D855C91D04051D742DE622
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi folks,

Below you can find a tiny patch to add 2 new targets to the top level 
Makefile: bzgrub and zgrub. This is a suggestion about how the Grub 
boot loader could be supported.

It would be nice if you could consider this patch to be included in 
one of the future kernels. I am not the kernel patch specialist, so 
please excuse if I missed to follow a specific procedure.


Regards

Harri
--
Harald Dunkel | dunkel@Synopsys.COM  |  Against stupidity the very gods
Synopsys GmbH | Kaiserstr. 100       |  Themselves contend in vain. 
52134 Herzogenrath, Germany          |  
+49 2407 9558 (fax? 44: 0)           |  Schiller, The Maid of Orleans
--------------96D855C91D04051D742DE622
Content-Type: text/plain; charset=us-ascii;
 name="grub.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="grub.patch"

diff -cr linux.orig/Documentation/kbuild/commands.txt linux/Documentation/kbuild/commands.txt
*** linux.orig/Documentation/kbuild/commands.txt	Fri Jul 28 21:50:51 2000
--- linux/Documentation/kbuild/commands.txt	Sun Dec 23 14:36:09 2001
***************
*** 24,38 ****
  text interface, or 'make xconfig' for an X interface using TCL/TK.
  
  'make bzImage' will leave your new kernel image in arch/i386/boot/bzImage.
! You can also use 'make bzdisk' or 'make bzlilo'.
  
! See the lilo documentation for more information on how to use lilo.
  You can also use the 'loadlin' program to boot Linux from MS-DOS.
  
  Some computers won't work with 'make bzImage', either due to hardware
  problems or very old versions of lilo or loadlin.  If your kernel image
! is small, you may use 'make zImage', 'make zdisk', or 'make zlilo'
! on theses systems.
  
  If you find a file name 'vmlinux' in the top directory of the source tree,
  just ignore it.  This is an intermediate file and you can't boot from it.
--- 24,38 ----
  text interface, or 'make xconfig' for an X interface using TCL/TK.
  
  'make bzImage' will leave your new kernel image in arch/i386/boot/bzImage.
! You can also use 'make bzdisk', 'make bzgrub' or 'make bzlilo'.
  
! See the documentation for more information on how to use lilo or grub.
  You can also use the 'loadlin' program to boot Linux from MS-DOS.
  
  Some computers won't work with 'make bzImage', either due to hardware
  problems or very old versions of lilo or loadlin.  If your kernel image
! is small, you may use 'make zImage', 'make zdisk', 'make zgrub', or 
! 'make zlilo' on theses systems.
  
  If you find a file name 'vmlinux' in the top directory of the source tree,
  just ignore it.  This is an intermediate file and you can't boot from it.
diff -cr linux.orig/Documentation/kbuild/makefiles.txt linux/Documentation/kbuild/makefiles.txt
*** linux.orig/Documentation/kbuild/makefiles.txt	Tue Feb 13 23:13:42 2001
--- linux/Documentation/kbuild/makefiles.txt	Sun Dec 23 14:39:49 2001
***************
*** 427,432 ****
--- 427,433 ----
      bootpfile		alpha, ia64
      bzImage		i386, m68k
      bzdisk		i386
+     bzgrub		i386
      bzlilo		i386
      compressed		i386, m68k, mips, mips64, sh
      dasdfmt		s390
***************
*** 446,451 ****
--- 447,453 ----
      zImage		arm, i386, m68k, mips, mips64, ppc, sh
      zImage.initrd	ppc
      zdisk		i386, mips, mips64, sh
+     zgrub		i386
      zinstall		arm
      zlilo		i386
      znetboot.initrd	ppc
diff -cr linux.orig/arch/i386/Makefile linux/arch/i386/Makefile
*** linux.orig/arch/i386/Makefile	Thu Apr 12 21:20:31 2001
--- linux/arch/i386/Makefile	Sun Dec 23 13:37:16 2001
***************
*** 111,116 ****
--- 111,117 ----
  FORCE: ;
  
  .PHONY: zImage bzImage compressed zlilo bzlilo zdisk bzdisk install \
+ 		zgrub bzgrub \
  		clean archclean archmrproper archdep
  
  zImage: vmlinux
***************
*** 128,133 ****
--- 129,140 ----
  	@$(MAKEBOOT) BOOTIMAGE=bzImage zlilo
  bzlilo: vmlinux
  	@$(MAKEBOOT) BOOTIMAGE=bzImage zlilo
+ 
+ zgrub: vmlinux
+ 	@$(MAKEBOOT) BOOTIMAGE=zImage zgrub
+ 
+ bzgrub: vmlinux
+ 	@$(MAKEBOOT) BOOTIMAGE=bzImage zgrub
  
  zdisk: vmlinux
  	@$(MAKEBOOT) BOOTIMAGE=zImage zdisk
diff -cr linux.orig/arch/i386/boot/Makefile linux/arch/i386/boot/Makefile
*** linux.orig/arch/i386/boot/Makefile	Sun Aug  5 22:13:19 2001
--- linux/arch/i386/boot/Makefile	Sun Dec 23 13:48:10 2001
***************
*** 36,41 ****
--- 36,46 ----
  	cp $(TOPDIR)/System.map $(INSTALL_PATH)/
  	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
  
+ zgrub: $(CONFIGURE) $(BOOTIMAGE)
+ 	cat $(BOOTIMAGE) > /boot/vmlinuz-$(KERNELRELEASE)
+ 	cp $(TOPDIR)/System.map /boot/System.map-$(KERNELRELEASE)
+ 	if [ -x /sbin/update-grub ]; then /sbin/update-grub; fi
+ 
  install: $(CONFIGURE) $(BOOTIMAGE)
  	sh -x ./install.sh $(KERNELRELEASE) $(BOOTIMAGE) $(TOPDIR)/System.map "$(INSTALL_PATH)"
  

--------------96D855C91D04051D742DE622--

