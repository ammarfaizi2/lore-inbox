Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274078AbRISOxw>; Wed, 19 Sep 2001 10:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274082AbRISOxk>; Wed, 19 Sep 2001 10:53:40 -0400
Received: from t2.redhat.com ([199.183.24.243]:8184 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S274078AbRISOxG>; Wed, 19 Sep 2001 10:53:06 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Tue, 18 Sep 2001 09:49:42 PDT." <Pine.LNX.4.33.0109180948260.2077-100000@penguin.transmeta.com> 
Date: Wed, 19 Sep 2001 15:53:23 +0100
Message-ID: <5079.1000911203@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch to make rwsems unfair.

David


diff -uNr linux-2.4.10-pre12/arch/alpha/config.in linux-rwsem/arch/alpha/config.in
--- linux-2.4.10-pre12/arch/alpha/config.in	Tue Sep 18 08:45:58 2001
+++ linux-rwsem/arch/alpha/config.in	Wed Sep 19 14:46:18 2001
@@ -5,8 +5,6 @@
 
 define_bool CONFIG_ALPHA y
 define_bool CONFIG_UID16 n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 
 mainmenu_name "Kernel configuration of Linux for Alpha machines"
 
diff -uNr linux-2.4.10-pre12/arch/arm/config.in linux-rwsem/arch/arm/config.in
--- linux-2.4.10-pre12/arch/arm/config.in	Tue Sep 18 08:46:39 2001
+++ linux-rwsem/arch/arm/config.in	Wed Sep 19 14:46:18 2001
@@ -9,8 +9,6 @@
 define_bool CONFIG_SBUS n
 define_bool CONFIG_MCA n
 define_bool CONFIG_UID16 y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 
 mainmenu_option next_comment
diff -uNr linux-2.4.10-pre12/arch/arm/def-configs/anakin linux-rwsem/arch/arm/def-configs/anakin
--- linux-2.4.10-pre12/arch/arm/def-configs/anakin	Tue Sep 18 08:46:40 2001
+++ linux-rwsem/arch/arm/def-configs/anakin	Wed Sep 19 14:46:18 2001
@@ -6,8 +6,6 @@
 # CONFIG_SBUS is not set
 # CONFIG_MCA is not set
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/arm/def-configs/assabet linux-rwsem/arch/arm/def-configs/assabet
--- linux-2.4.10-pre12/arch/arm/def-configs/assabet	Tue Sep 18 08:46:40 2001
+++ linux-rwsem/arch/arm/def-configs/assabet	Wed Sep 19 14:46:18 2001
@@ -6,8 +6,6 @@
 # CONFIG_SBUS is not set
 # CONFIG_MCA is not set
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/arm/def-configs/bitsy linux-rwsem/arch/arm/def-configs/bitsy
--- linux-2.4.10-pre12/arch/arm/def-configs/bitsy	Tue Sep 18 08:46:40 2001
+++ linux-rwsem/arch/arm/def-configs/bitsy	Wed Sep 19 14:46:18 2001
@@ -6,8 +6,6 @@
 # CONFIG_SBUS is not set
 # CONFIG_MCA is not set
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/arm/def-configs/ebsa110 linux-rwsem/arch/arm/def-configs/ebsa110
--- linux-2.4.10-pre12/arch/arm/def-configs/ebsa110	Tue Sep 18 08:46:40 2001
+++ linux-rwsem/arch/arm/def-configs/ebsa110	Wed Sep 19 14:46:18 2001
@@ -6,8 +6,6 @@
 # CONFIG_SBUS is not set
 # CONFIG_MCA is not set
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/arm/def-configs/flexanet linux-rwsem/arch/arm/def-configs/flexanet
--- linux-2.4.10-pre12/arch/arm/def-configs/flexanet	Tue Sep 18 08:46:40 2001
+++ linux-rwsem/arch/arm/def-configs/flexanet	Wed Sep 19 14:46:18 2001
@@ -6,8 +6,6 @@
 # CONFIG_SBUS is not set
 # CONFIG_MCA is not set
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/arm/def-configs/integrator linux-rwsem/arch/arm/def-configs/integrator
--- linux-2.4.10-pre12/arch/arm/def-configs/integrator	Tue Sep 18 08:46:40 2001
+++ linux-rwsem/arch/arm/def-configs/integrator	Wed Sep 19 14:46:18 2001
@@ -6,8 +6,6 @@
 # CONFIG_SBUS is not set
 # CONFIG_MCA is not set
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/arm/def-configs/lart linux-rwsem/arch/arm/def-configs/lart
--- linux-2.4.10-pre12/arch/arm/def-configs/lart	Tue Sep 18 08:46:40 2001
+++ linux-rwsem/arch/arm/def-configs/lart	Wed Sep 19 14:46:18 2001
@@ -6,8 +6,6 @@
 # CONFIG_SBUS is not set
 # CONFIG_MCA is not set
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/arm/def-configs/neponset linux-rwsem/arch/arm/def-configs/neponset
--- linux-2.4.10-pre12/arch/arm/def-configs/neponset	Tue Sep 18 08:46:40 2001
+++ linux-rwsem/arch/arm/def-configs/neponset	Wed Sep 19 14:46:18 2001
@@ -6,8 +6,6 @@
 # CONFIG_SBUS is not set
 # CONFIG_MCA is not set
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/arm/def-configs/pleb linux-rwsem/arch/arm/def-configs/pleb
--- linux-2.4.10-pre12/arch/arm/def-configs/pleb	Tue Sep 18 08:46:40 2001
+++ linux-rwsem/arch/arm/def-configs/pleb	Wed Sep 19 14:46:18 2001
@@ -6,8 +6,6 @@
 # CONFIG_SBUS is not set
 # CONFIG_MCA is not set
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/arm/def-configs/rpc linux-rwsem/arch/arm/def-configs/rpc
--- linux-2.4.10-pre12/arch/arm/def-configs/rpc	Tue Sep 18 08:46:40 2001
+++ linux-rwsem/arch/arm/def-configs/rpc	Wed Sep 19 14:46:18 2001
@@ -6,8 +6,6 @@
 # CONFIG_SBUS is not set
 # CONFIG_MCA is not set
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/arm/def-configs/shark linux-rwsem/arch/arm/def-configs/shark
--- linux-2.4.10-pre12/arch/arm/def-configs/shark	Tue Sep 18 08:46:40 2001
+++ linux-rwsem/arch/arm/def-configs/shark	Wed Sep 19 14:46:18 2001
@@ -6,8 +6,6 @@
 # CONFIG_SBUS is not set
 # CONFIG_MCA is not set
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/cris/config.in linux-rwsem/arch/cris/config.in
--- linux-2.4.10-pre12/arch/cris/config.in	Tue Sep 18 08:46:43 2001
+++ linux-rwsem/arch/cris/config.in	Wed Sep 19 14:46:18 2001
@@ -5,8 +5,6 @@
 mainmenu_name "Linux/CRIS Kernel Configuration"
 
 define_bool CONFIG_UID16 y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
diff -uNr linux-2.4.10-pre12/arch/cris/defconfig linux-rwsem/arch/cris/defconfig
--- linux-2.4.10-pre12/arch/cris/defconfig	Tue Sep 18 08:46:43 2001
+++ linux-rwsem/arch/cris/defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/i386/config.in linux-rwsem/arch/i386/config.in
--- linux-2.4.10-pre12/arch/i386/config.in	Wed Sep 19 10:39:05 2001
+++ linux-rwsem/arch/i386/config.in	Wed Sep 19 14:46:18 2001
@@ -50,8 +50,6 @@
    define_bool CONFIG_X86_CMPXCHG n
    define_bool CONFIG_X86_XADD n
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
-   define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-   define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -59,8 +57,6 @@
    define_bool CONFIG_X86_XADD y
    define_bool CONFIG_X86_BSWAP y
    define_bool CONFIG_X86_POPAD_OK y
-   define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-   define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 fi
 if [ "$CONFIG_M486" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
diff -uNr linux-2.4.10-pre12/arch/i386/defconfig linux-rwsem/arch/i386/defconfig
--- linux-2.4.10-pre12/arch/i386/defconfig	Wed Sep 19 10:39:05 2001
+++ linux-rwsem/arch/i386/defconfig	Wed Sep 19 14:46:18 2001
@@ -42,8 +42,6 @@
 CONFIG_X86_XADD=y
 CONFIG_X86_BSWAP=y
 CONFIG_X86_POPAD_OK=y
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_X86_L1_CACHE_SHIFT=5
 CONFIG_X86_TSC=y
 CONFIG_X86_GOOD_APIC=y
diff -uNr linux-2.4.10-pre12/arch/ia64/config.in linux-rwsem/arch/ia64/config.in
--- linux-2.4.10-pre12/arch/ia64/config.in	Tue Sep 18 08:46:41 2001
+++ linux-rwsem/arch/ia64/config.in	Wed Sep 19 14:46:18 2001
@@ -23,8 +23,6 @@
 define_bool CONFIG_EISA n
 define_bool CONFIG_MCA n
 define_bool CONFIG_SBUS n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
   define_bool CONFIG_ACPI y
diff -uNr linux-2.4.10-pre12/arch/m68k/config.in linux-rwsem/arch/m68k/config.in
--- linux-2.4.10-pre12/arch/m68k/config.in	Tue Sep 18 08:46:04 2001
+++ linux-rwsem/arch/m68k/config.in	Wed Sep 19 14:46:18 2001
@@ -4,8 +4,6 @@
 #
 
 define_bool CONFIG_UID16 y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_name "Linux/68k Kernel Configuration"
 
diff -uNr linux-2.4.10-pre12/arch/mips/config.in linux-rwsem/arch/mips/config.in
--- linux-2.4.10-pre12/arch/mips/config.in	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/config.in	Wed Sep 19 14:46:18 2001
@@ -68,8 +68,6 @@
    fi
 bool 'Support for Alchemy Semi PB1000 board' CONFIG_MIPS_PB1000
 
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 #
 # Select some configuration options automatically for certain systems.
diff -uNr linux-2.4.10-pre12/arch/mips/defconfig linux-rwsem/arch/mips/defconfig
--- linux-2.4.10-pre12/arch/mips/defconfig	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/defconfig	Wed Sep 19 14:46:18 2001
@@ -32,8 +32,6 @@
 # CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MIPS_IVR is not set
 # CONFIG_MIPS_PB1000 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_ARC32=y
diff -uNr linux-2.4.10-pre12/arch/mips/defconfig-atlas linux-rwsem/arch/mips/defconfig-atlas
--- linux-2.4.10-pre12/arch/mips/defconfig-atlas	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/defconfig-atlas	Wed Sep 19 14:46:18 2001
@@ -32,8 +32,6 @@
 # CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MIPS_IVR is not set
 # CONFIG_MIPS_PB1000 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_PCI=y
diff -uNr linux-2.4.10-pre12/arch/mips/defconfig-ddb5476 linux-rwsem/arch/mips/defconfig-ddb5476
--- linux-2.4.10-pre12/arch/mips/defconfig-ddb5476	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/defconfig-ddb5476	Wed Sep 19 14:46:18 2001
@@ -32,8 +32,6 @@
 # CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MIPS_IVR is not set
 # CONFIG_MIPS_PB1000 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_ISA=y
diff -uNr linux-2.4.10-pre12/arch/mips/defconfig-ddb5477 linux-rwsem/arch/mips/defconfig-ddb5477
--- linux-2.4.10-pre12/arch/mips/defconfig-ddb5477	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/defconfig-ddb5477	Wed Sep 19 14:46:18 2001
@@ -32,8 +32,6 @@
 # CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MIPS_IVR is not set
 # CONFIG_MIPS_PB1000 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
diff -uNr linux-2.4.10-pre12/arch/mips/defconfig-decstation linux-rwsem/arch/mips/defconfig-decstation
--- linux-2.4.10-pre12/arch/mips/defconfig-decstation	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/defconfig-decstation	Wed Sep 19 14:46:18 2001
@@ -32,8 +32,6 @@
 # CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MIPS_IVR is not set
 # CONFIG_MIPS_PB1000 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 # CONFIG_ISA is not set
diff -uNr linux-2.4.10-pre12/arch/mips/defconfig-ip22 linux-rwsem/arch/mips/defconfig-ip22
--- linux-2.4.10-pre12/arch/mips/defconfig-ip22	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/defconfig-ip22	Wed Sep 19 14:46:18 2001
@@ -32,8 +32,6 @@
 # CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MIPS_IVR is not set
 # CONFIG_MIPS_PB1000 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_ARC32=y
diff -uNr linux-2.4.10-pre12/arch/mips/defconfig-it8172 linux-rwsem/arch/mips/defconfig-it8172
--- linux-2.4.10-pre12/arch/mips/defconfig-it8172	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/defconfig-it8172	Wed Sep 19 14:46:18 2001
@@ -37,8 +37,6 @@
 # CONFIG_IT8172_SCR1 is not set
 # CONFIG_MIPS_IVR is not set
 # CONFIG_MIPS_PB1000 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_PCI=y
diff -uNr linux-2.4.10-pre12/arch/mips/defconfig-malta linux-rwsem/arch/mips/defconfig-malta
--- linux-2.4.10-pre12/arch/mips/defconfig-malta	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/defconfig-malta	Wed Sep 19 14:46:18 2001
@@ -32,8 +32,6 @@
 # CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MIPS_IVR is not set
 # CONFIG_MIPS_PB1000 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_I8259=y
diff -uNr linux-2.4.10-pre12/arch/mips/defconfig-nino linux-rwsem/arch/mips/defconfig-nino
--- linux-2.4.10-pre12/arch/mips/defconfig-nino	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/defconfig-nino	Wed Sep 19 14:46:18 2001
@@ -35,8 +35,6 @@
 # CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MIPS_IVR is not set
 # CONFIG_MIPS_PB1000 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_PC_KEYB=y
diff -uNr linux-2.4.10-pre12/arch/mips/defconfig-ocelot linux-rwsem/arch/mips/defconfig-ocelot
--- linux-2.4.10-pre12/arch/mips/defconfig-ocelot	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/defconfig-ocelot	Wed Sep 19 14:46:18 2001
@@ -32,8 +32,6 @@
 # CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MIPS_IVR is not set
 # CONFIG_MIPS_PB1000 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_PCI=y
diff -uNr linux-2.4.10-pre12/arch/mips/defconfig-pb1000 linux-rwsem/arch/mips/defconfig-pb1000
--- linux-2.4.10-pre12/arch/mips/defconfig-pb1000	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/defconfig-pb1000	Wed Sep 19 14:46:18 2001
@@ -32,8 +32,6 @@
 # CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MIPS_IVR is not set
 CONFIG_MIPS_PB1000=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_MIPS_AU1000=y
diff -uNr linux-2.4.10-pre12/arch/mips/defconfig-rm200 linux-rwsem/arch/mips/defconfig-rm200
--- linux-2.4.10-pre12/arch/mips/defconfig-rm200	Wed Sep 19 10:39:06 2001
+++ linux-rwsem/arch/mips/defconfig-rm200	Wed Sep 19 14:46:18 2001
@@ -32,8 +32,6 @@
 # CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MIPS_IVR is not set
 # CONFIG_MIPS_PB1000 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_ARC32=y
diff -uNr linux-2.4.10-pre12/arch/mips64/config.in linux-rwsem/arch/mips64/config.in
--- linux-2.4.10-pre12/arch/mips64/config.in	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/mips64/config.in	Wed Sep 19 14:46:18 2001
@@ -27,8 +27,6 @@
 fi
 endmenu
 
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 #
 # Select some configuration options automatically based on user selections
diff -uNr linux-2.4.10-pre12/arch/mips64/defconfig linux-rwsem/arch/mips64/defconfig
--- linux-2.4.10-pre12/arch/mips64/defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/mips64/defconfig	Wed Sep 19 14:46:18 2001
@@ -19,8 +19,6 @@
 # CONFIG_REPLICATE_KTEXT is not set
 # CONFIG_REPLICATE_EXHANDLERS is not set
 CONFIG_SMP=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 CONFIG_BOOT_ELF64=y
 CONFIG_ARC64=y
 CONFIG_COHERENT_IO=y
diff -uNr linux-2.4.10-pre12/arch/mips64/defconfig-ip22 linux-rwsem/arch/mips64/defconfig-ip22
--- linux-2.4.10-pre12/arch/mips64/defconfig-ip22	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/mips64/defconfig-ip22	Wed Sep 19 14:46:18 2001
@@ -12,8 +12,6 @@
 #
 CONFIG_SGI_IP22=y
 # CONFIG_SGI_IP27 is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 CONFIG_BOOT_ELF32=y
 CONFIG_ARC32=y
 CONFIG_BOARD_SCACHE=y
diff -uNr linux-2.4.10-pre12/arch/mips64/defconfig-ip27 linux-rwsem/arch/mips64/defconfig-ip27
--- linux-2.4.10-pre12/arch/mips64/defconfig-ip27	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/mips64/defconfig-ip27	Wed Sep 19 14:46:18 2001
@@ -19,8 +19,6 @@
 # CONFIG_REPLICATE_KTEXT is not set
 # CONFIG_REPLICATE_EXHANDLERS is not set
 CONFIG_SMP=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 CONFIG_BOOT_ELF64=y
 CONFIG_ARC64=y
 CONFIG_COHERENT_IO=y
diff -uNr linux-2.4.10-pre12/arch/mips64/defconfig-ip32 linux-rwsem/arch/mips64/defconfig-ip32
--- linux-2.4.10-pre12/arch/mips64/defconfig-ip32	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/mips64/defconfig-ip32	Wed Sep 19 14:46:18 2001
@@ -13,8 +13,6 @@
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
 CONFIG_SGI_IP32=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 CONFIG_BOOT_ELF32=y
 CONFIG_ARC32=y
 CONFIG_PC_KEYB=y
diff -uNr linux-2.4.10-pre12/arch/parisc/config.in linux-rwsem/arch/parisc/config.in
--- linux-2.4.10-pre12/arch/parisc/config.in	Tue Sep 18 08:46:43 2001
+++ linux-rwsem/arch/parisc/config.in	Wed Sep 19 14:46:18 2001
@@ -7,8 +7,6 @@
 
 define_bool CONFIG_PARISC y
 define_bool CONFIG_UID16 n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
diff -uNr linux-2.4.10-pre12/arch/ppc/config.in linux-rwsem/arch/ppc/config.in
--- linux-2.4.10-pre12/arch/ppc/config.in	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/config.in	Wed Sep 19 14:46:18 2001
@@ -4,8 +4,6 @@
 # see Documentation/kbuild/config-language.txt.
 #
 define_bool CONFIG_UID16 n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 
 mainmenu_name "Linux/PowerPC Kernel Configuration"
 
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/IVMS8_defconfig linux-rwsem/arch/ppc/configs/IVMS8_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/IVMS8_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/IVMS8_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/SM850_defconfig linux-rwsem/arch/ppc/configs/SM850_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/SM850_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/SM850_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/SPD823TS_defconfig linux-rwsem/arch/ppc/configs/SPD823TS_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/SPD823TS_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/SPD823TS_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/TQM823L_defconfig linux-rwsem/arch/ppc/configs/TQM823L_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/TQM823L_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/TQM823L_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/TQM850L_defconfig linux-rwsem/arch/ppc/configs/TQM850L_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/TQM850L_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/TQM850L_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/TQM860L_defconfig linux-rwsem/arch/ppc/configs/TQM860L_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/TQM860L_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/TQM860L_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/apus_defconfig linux-rwsem/arch/ppc/configs/apus_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/apus_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/apus_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/bseip_defconfig linux-rwsem/arch/ppc/configs/bseip_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/bseip_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/bseip_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/common_defconfig linux-rwsem/arch/ppc/configs/common_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/common_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/common_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/est8260_defconfig linux-rwsem/arch/ppc/configs/est8260_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/est8260_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/est8260_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/gemini_defconfig linux-rwsem/arch/ppc/configs/gemini_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/gemini_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/gemini_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/ibmchrp_defconfig linux-rwsem/arch/ppc/configs/ibmchrp_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/ibmchrp_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/ibmchrp_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/mbx_defconfig linux-rwsem/arch/ppc/configs/mbx_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/mbx_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/mbx_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/oak_defconfig linux-rwsem/arch/ppc/configs/oak_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/oak_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/oak_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/power3_defconfig linux-rwsem/arch/ppc/configs/power3_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/power3_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/power3_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/rpxcllf_defconfig linux-rwsem/arch/ppc/configs/rpxcllf_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/rpxcllf_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/rpxcllf_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/rpxlite_defconfig linux-rwsem/arch/ppc/configs/rpxlite_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/rpxlite_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/rpxlite_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/configs/walnut_defconfig linux-rwsem/arch/ppc/configs/walnut_defconfig
--- linux-2.4.10-pre12/arch/ppc/configs/walnut_defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/configs/walnut_defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/ppc/defconfig linux-rwsem/arch/ppc/defconfig
--- linux-2.4.10-pre12/arch/ppc/defconfig	Wed Sep 19 10:39:07 2001
+++ linux-rwsem/arch/ppc/defconfig	Wed Sep 19 14:46:18 2001
@@ -2,8 +2,6 @@
 # Automatically generated make config: don't edit
 #
 # CONFIG_UID16 is not set
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 
 #
 # Code maturity level options
diff -uNr linux-2.4.10-pre12/arch/s390/config.in linux-rwsem/arch/s390/config.in
--- linux-2.4.10-pre12/arch/s390/config.in	Tue Sep 18 08:46:42 2001
+++ linux-rwsem/arch/s390/config.in	Wed Sep 19 14:46:18 2001
@@ -7,8 +7,6 @@
 define_bool CONFIG_EISA n
 define_bool CONFIG_MCA n
 define_bool CONFIG_UID16 y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_name "Linux Kernel Configuration"
 define_bool CONFIG_ARCH_S390 y
diff -uNr linux-2.4.10-pre12/arch/s390/defconfig linux-rwsem/arch/s390/defconfig
--- linux-2.4.10-pre12/arch/s390/defconfig	Tue Sep 18 08:46:42 2001
+++ linux-rwsem/arch/s390/defconfig	Wed Sep 19 14:46:18 2001
@@ -5,8 +5,6 @@
 # CONFIG_EISA is not set
 # CONFIG_MCA is not set
 CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 CONFIG_ARCH_S390=y
 
 #
diff -uNr linux-2.4.10-pre12/arch/s390x/config.in linux-rwsem/arch/s390x/config.in
--- linux-2.4.10-pre12/arch/s390x/config.in	Tue Sep 18 08:46:43 2001
+++ linux-rwsem/arch/s390x/config.in	Wed Sep 19 14:46:16 2001
@@ -6,8 +6,6 @@
 define_bool CONFIG_ISA n
 define_bool CONFIG_EISA n
 define_bool CONFIG_MCA n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_name "Linux Kernel Configuration"
 define_bool CONFIG_ARCH_S390 y
diff -uNr linux-2.4.10-pre12/arch/s390x/defconfig linux-rwsem/arch/s390x/defconfig
--- linux-2.4.10-pre12/arch/s390x/defconfig	Tue Sep 18 08:46:43 2001
+++ linux-rwsem/arch/s390x/defconfig	Wed Sep 19 14:45:43 2001
@@ -4,8 +4,6 @@
 # CONFIG_ISA is not set
 # CONFIG_EISA is not set
 # CONFIG_MCA is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 CONFIG_ARCH_S390=y
 CONFIG_ARCH_S390X=y
 
diff -uNr linux-2.4.10-pre12/arch/sh/config.in linux-rwsem/arch/sh/config.in
--- linux-2.4.10-pre12/arch/sh/config.in	Wed Sep 19 10:39:08 2001
+++ linux-rwsem/arch/sh/config.in	Wed Sep 19 14:46:18 2001
@@ -7,8 +7,6 @@
 define_bool CONFIG_SUPERH y
 
 define_bool CONFIG_UID16 y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
diff -uNr linux-2.4.10-pre12/arch/sparc/config.in linux-rwsem/arch/sparc/config.in
--- linux-2.4.10-pre12/arch/sparc/config.in	Tue Sep 18 08:45:59 2001
+++ linux-rwsem/arch/sparc/config.in	Wed Sep 19 14:46:18 2001
@@ -48,8 +48,6 @@
 define_bool CONFIG_SUN_CONSOLE y
 define_bool CONFIG_SUN_AUXIO y
 define_bool CONFIG_SUN_IO y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 bool 'Support for SUN4 machines (disables SUN4[CDM] support)' CONFIG_SUN4
 if [ "$CONFIG_SUN4" != "y" ]; then
diff -uNr linux-2.4.10-pre12/arch/sparc/defconfig linux-rwsem/arch/sparc/defconfig
--- linux-2.4.10-pre12/arch/sparc/defconfig	Tue Sep 18 08:45:59 2001
+++ linux-rwsem/arch/sparc/defconfig	Wed Sep 19 14:46:18 2001
@@ -38,8 +38,6 @@
 CONFIG_SUN_CONSOLE=y
 CONFIG_SUN_AUXIO=y
 CONFIG_SUN_IO=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_SUN4 is not set
 # CONFIG_PCI is not set
 CONFIG_SUN_OPENPROMFS=m
diff -uNr linux-2.4.10-pre12/arch/sparc64/config.in linux-rwsem/arch/sparc64/config.in
--- linux-2.4.10-pre12/arch/sparc64/config.in	Tue Sep 18 08:46:06 2001
+++ linux-rwsem/arch/sparc64/config.in	Wed Sep 19 14:46:18 2001
@@ -33,8 +33,6 @@
 
 # Global things across all Sun machines.
 define_bool CONFIG_HAVE_DEC_LOCK y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 define_bool CONFIG_ISA n
 define_bool CONFIG_ISAPNP n
 define_bool CONFIG_EISA n
diff -uNr linux-2.4.10-pre12/arch/sparc64/defconfig linux-rwsem/arch/sparc64/defconfig
--- linux-2.4.10-pre12/arch/sparc64/defconfig	Wed Sep 19 10:39:08 2001
+++ linux-rwsem/arch/sparc64/defconfig	Wed Sep 19 14:46:18 2001
@@ -23,8 +23,6 @@
 CONFIG_SMP=y
 CONFIG_SPARC64=y
 CONFIG_HAVE_DEC_LOCK=y
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 # CONFIG_ISA is not set
 # CONFIG_ISAPNP is not set
 # CONFIG_EISA is not set
diff -uNr linux-2.4.10-pre12/drivers/char/sysrq.c linux-rwsem/drivers/char/sysrq.c
--- linux-2.4.10-pre12/drivers/char/sysrq.c	Wed Sep 19 10:39:11 2001
+++ linux-rwsem/drivers/char/sysrq.c	Wed Sep 19 15:17:20 2001
@@ -32,7 +32,7 @@
 
 #include <asm/ptrace.h>
 
-extern void wakeup_bdflush(int);
+extern void wakeup_bdflush();
 extern void reset_vc(unsigned int);
 extern struct list_head super_blocks;
 
@@ -221,7 +221,7 @@
 static void sysrq_handle_sync(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	emergency_sync_scheduled = EMERG_SYNC;
-	wakeup_bdflush(0);
+	wakeup_bdflush();
 }
 static struct sysrq_key_op sysrq_sync_op = {
 	handler:	sysrq_handle_sync,
@@ -232,7 +232,7 @@
 static void sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	emergency_sync_scheduled = EMERG_REMOUNT;
-	wakeup_bdflush(0);
+	wakeup_bdflush();
 }
 static struct sysrq_key_op sysrq_mountro_op = {
 	handler:	sysrq_handle_mountro,
diff -uNr linux-2.4.10-pre12/include/asm-alpha/rwsem.h linux-rwsem/include/asm-alpha/rwsem.h
--- linux-2.4.10-pre12/include/asm-alpha/rwsem.h	Tue Sep 18 08:45:14 2001
+++ linux-rwsem/include/asm-alpha/rwsem.h	Thu Jan  1 01:00:00 1970
@@ -1,208 +0,0 @@
-#ifndef _ALPHA_RWSEM_H
-#define _ALPHA_RWSEM_H
-
-/*
- * Written by Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 2001.
- * Based on asm-alpha/semaphore.h and asm-i386/rwsem.h
- */
-
-#ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
-#endif
-
-#ifdef __KERNEL__
-
-#include <asm/compiler.h>
-#include <linux/list.h>
-#include <linux/spinlock.h>
-
-struct rwsem_waiter;
-
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	long			count;
-#define RWSEM_UNLOCKED_VALUE		0x0000000000000000L
-#define RWSEM_ACTIVE_BIAS		0x0000000000000001L
-#define RWSEM_ACTIVE_MASK		0x00000000ffffffffL
-#define RWSEM_WAITING_BIAS		(-0x0000000100000000L)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-}
-
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count;
-	sem->count += RWSEM_ACTIVE_READ_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	mb\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (__builtin_expect(oldcount < 0, 0))
-		rwsem_down_read_failed(sem);
-}
-
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count;
-	sem->count += RWSEM_ACTIVE_WRITE_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	mb\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (__builtin_expect(oldcount, 0))
-		rwsem_down_write_failed(sem);
-}
-
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count;
-	sem->count -= RWSEM_ACTIVE_READ_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"	mb\n"
-	"1:	ldq_l	%0,%1\n"
-	"	subq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (__builtin_expect(oldcount < 0, 0)) 
-		if ((int)oldcount - RWSEM_ACTIVE_READ_BIAS == 0)
-			rwsem_wake(sem);
-}
-
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	long count;
-#ifndef	CONFIG_SMP
-	sem->count -= RWSEM_ACTIVE_WRITE_BIAS;
-	count = sem->count;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"	mb\n"
-	"1:	ldq_l	%0,%1\n"
-	"	subq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	subq	%0,%3,%0\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (count), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (__builtin_expect(count, 0))
-		if ((int)count == 0)
-			rwsem_wake(sem);
-}
-
-static inline void rwsem_atomic_add(long val, struct rw_semaphore *sem)
-{
-#ifndef	CONFIG_SMP
-	sem->count += val;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%2,%0\n"
-	"	stq_c	%0,%1\n"
-	"	beq	%0,2f\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (temp), "=m" (sem->count)
-	:"Ir" (val), "m" (sem->count));
-#endif
-}
-
-static inline long rwsem_atomic_update(long val, struct rw_semaphore *sem)
-{
-#ifndef	CONFIG_SMP
-	sem->count += val;
-	return sem->count;
-#else
-	long ret, temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq 	%0,%3,%2\n"
-	"	addq	%0,%3,%0\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (ret), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (val), "m" (sem->count));
-
-	return ret;
-#endif
-}
-
-#endif /* __KERNEL__ */
-#endif /* _ALPHA_RWSEM_H */
diff -uNr linux-2.4.10-pre12/include/asm-i386/rwsem.h linux-rwsem/include/asm-i386/rwsem.h
--- linux-2.4.10-pre12/include/asm-i386/rwsem.h	Tue Sep 18 08:45:13 2001
+++ linux-rwsem/include/asm-i386/rwsem.h	Thu Jan  1 01:00:00 1970
@@ -1,226 +0,0 @@
-/* rwsem.h: R/W semaphores implemented using XADD/CMPXCHG for i486+
- *
- * Written by David Howells (dhowells@redhat.com).
- *
- * Derived from asm-i386/semaphore.h
- *
- *
- * The MSW of the count is the negated number of active writers and waiting
- * lockers, and the LSW is the total number of active locks
- *
- * The lock count is initialized to 0 (no active and no waiting lockers).
- *
- * When a writer subtracts WRITE_BIAS, it'll get 0xffff0001 for the case of an
- * uncontended lock. This can be determined because XADD returns the old value.
- * Readers increment by 1 and see a positive value when uncontended, negative
- * if there are writers (and maybe) readers waiting (in which case it goes to
- * sleep).
- *
- * The value of WAITING_BIAS supports up to 32766 waiting processes. This can
- * be extended to 65534 by manually checking the whole MSW rather than relying
- * on the S flag.
- *
- * The value of ACTIVE_BIAS supports up to 65535 active processes.
- *
- * This should be totally fair - if anything is waiting, a process that wants a
- * lock will go to the back of the queue. When the currently active lock is
- * released, if there's a writer at the front of the queue, then that and only
- * that will be woken up; if there's a bunch of consequtive readers at the
- * front, then they'll all be woken up, but no other readers will be.
- */
-
-#ifndef _I386_RWSEM_H
-#define _I386_RWSEM_H
-
-#ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
-#endif
-
-#ifdef __KERNEL__
-
-#include <linux/list.h>
-#include <linux/spinlock.h>
-
-struct rwsem_waiter;
-
-extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *));
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
-	__RWSEM_DEBUG_INIT }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-}
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning down_read\n\t"
-LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
-		"  js        2f\n\t" /* jump if we weren't granted the lock */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  pushl     %%ecx\n\t"
-		"  pushl     %%edx\n\t"
-		"  call      rwsem_down_read_failed\n\t"
-		"  popl      %%edx\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		".previous"
-		"# ending down_read\n\t"
-		: "+m"(sem->count)
-		: "a"(sem)
-		: "memory", "cc");
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = RWSEM_ACTIVE_WRITE_BIAS;
-	__asm__ __volatile__(
-		"# beginning down_write\n\t"
-LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t" /* subtract 0x0000ffff, returns the old value */
-		"  testl     %0,%0\n\t" /* was the count 0 before? */
-		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  pushl     %%ecx\n\t"
-		"  call      rwsem_down_write_failed\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		".previous\n"
-		"# ending down_write"
-		: "+d"(tmp), "+m"(sem->count)
-		: "a"(sem)
-		: "memory", "cc");
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	__s32 tmp = -RWSEM_ACTIVE_READ_BIAS;
-	__asm__ __volatile__(
-		"# beginning __up_read\n\t"
-LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
-		"  js        2f\n\t" /* jump if the lock is being waited upon */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  decw      %%dx\n\t" /* do nothing if still outstanding active readers */
-		"  jnz       1b\n\t"
-		"  pushl     %%ecx\n\t"
-		"  call      rwsem_wake\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		".previous\n"
-		"# ending __up_read\n"
-		: "+m"(sem->count), "+d"(tmp)
-		: "a"(sem)
-		: "memory", "cc");
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning __up_write\n\t"
-		"  movl      %2,%%edx\n\t"
-LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
-		"  jnz       2f\n\t" /* jump if the lock is being waited upon */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  decw      %%dx\n\t" /* did the active count reduce to 0? */
-		"  jnz       1b\n\t" /* jump back if not */
-		"  pushl     %%ecx\n\t"
-		"  call      rwsem_wake\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		".previous\n"
-		"# ending __up_write\n"
-		: "+m"(sem->count)
-		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS)
-		: "memory", "cc", "edx");
-}
-
-/*
- * implement atomic add functionality
- */
-static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-LOCK_PREFIX	"addl %1,%0"
-		:"=m"(sem->count)
-		:"ir"(delta), "m"(sem->count));
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	int tmp = delta;
-
-	__asm__ __volatile__(
-LOCK_PREFIX	"xadd %0,(%2)"
-		: "+r"(tmp), "=m"(sem->count)
-		: "r"(sem), "m"(sem->count)
-		: "memory");
-
-	return tmp+delta;
-}
-
-#endif /* __KERNEL__ */
-#endif /* _I386_RWSEM_H */
diff -uNr linux-2.4.10-pre12/include/asm-ppc/rwsem.h linux-rwsem/include/asm-ppc/rwsem.h
--- linux-2.4.10-pre12/include/asm-ppc/rwsem.h	Tue Sep 18 08:45:14 2001
+++ linux-rwsem/include/asm-ppc/rwsem.h	Thu Jan  1 01:00:00 1970
@@ -1,137 +0,0 @@
-/*
- * BK Id: SCCS/s.rwsem.h 1.6 05/17/01 18:14:25 cort
- */
-/*
- * include/asm-ppc/rwsem.h: R/W semaphores for PPC using the stuff
- * in lib/rwsem.c.  Adapted largely from include/asm-i386/rwsem.h
- * by Paul Mackerras <paulus@samba.org>.
- */
-
-#ifndef _PPC_RWSEM_H
-#define _PPC_RWSEM_H
-
-#ifdef __KERNEL__
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	/* XXX this should be able to be an atomic_t  -- paulus */
-	signed long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) \
-	  __RWSEM_DEBUG_INIT }
-
-#define DECLARE_RWSEM(name)		\
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-}
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	if (atomic_inc_return((atomic_t *)(&sem->count)) >= 0)
-		smp_wmb();
-	else
-		rwsem_down_read_failed(sem);
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = atomic_add_return(RWSEM_ACTIVE_WRITE_BIAS,
-				(atomic_t *)(&sem->count));
-	if (tmp == RWSEM_ACTIVE_WRITE_BIAS)
-		smp_wmb();
-	else
-		rwsem_down_write_failed(sem);
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	smp_wmb();
-	tmp = atomic_dec_return((atomic_t *)(&sem->count));
-	if (tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0)
-		rwsem_wake(sem);
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	smp_wmb();
-	if (atomic_sub_return(RWSEM_ACTIVE_WRITE_BIAS,
-			      (atomic_t *)(&sem->count)) < 0)
-		rwsem_wake(sem);
-}
-
-/*
- * implement atomic add functionality
- */
-static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
-{
-	atomic_add(delta, (atomic_t *)(&sem->count));
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	smp_mb();
-	return atomic_add_return(delta, (atomic_t *)(&sem->count));
-}
-
-#endif /* __KERNEL__ */
-#endif /* _PPC_RWSEM_XADD_H */
diff -uNr linux-2.4.10-pre12/include/asm-sparc64/rwsem.h linux-rwsem/include/asm-sparc64/rwsem.h
--- linux-2.4.10-pre12/include/asm-sparc64/rwsem.h	Tue Sep 18 08:45:14 2001
+++ linux-rwsem/include/asm-sparc64/rwsem.h	Thu Jan  1 01:00:00 1970
@@ -1,233 +0,0 @@
-/* $Id: rwsem.h,v 1.4 2001/04/26 02:36:36 davem Exp $
- * rwsem.h: R/W semaphores implemented using CAS
- *
- * Written by David S. Miller (davem@redhat.com), 2001.
- * Derived from asm-i386/rwsem.h
- */
-#ifndef _SPARC64_RWSEM_H
-#define _SPARC64_RWSEM_H
-
-#ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
-#endif
-
-#ifdef __KERNEL__
-
-#include <linux/list.h>
-#include <linux/spinlock.h>
-
-struct rwsem_waiter;
-
-extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *));
-
-struct rw_semaphore {
-	signed int count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		0xffff0000
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-};
-
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-}
-
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"! beginning __down_read\n"
-		"1:\tlduw	[%0], %%g5\n\t"
-		"add		%%g5, 1, %%g7\n\t"
-		"cas		[%0], %%g5, %%g7\n\t"
-		"cmp		%%g5, %%g7\n\t"
-		"bne,pn		%%icc, 1b\n\t"
-		" add		%%g7, 1, %%g7\n\t"
-		"cmp		%%g7, 0\n\t"
-		"bl,pn		%%icc, 3f\n\t"
-		" membar	#StoreStore\n"
-		"2:\n\t"
-		".subsection	2\n"
-		"3:\tmov	%0, %%g5\n\t"
-		"save		%%sp, -160, %%sp\n\t"
-		"mov		%%g1, %%l1\n\t"
-		"mov		%%g2, %%l2\n\t"
-		"mov		%%g3, %%l3\n\t"
-		"call		%1\n\t"
-		" mov		%%g5, %%o0\n\t"
-		"mov		%%l1, %%g1\n\t"
-		"mov		%%l2, %%g2\n\t"
-		"ba,pt		%%xcc, 2b\n\t"
-		" restore	%%l3, %%g0, %%g3\n\t"
-		".previous\n\t"
-		"! ending __down_read"
-		: : "r" (sem), "i" (rwsem_down_read_failed)
-		: "g5", "g7", "memory", "cc");
-}
-
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"! beginning __down_write\n\t"
-		"sethi		%%hi(%2), %%g1\n\t"
-		"or		%%g1, %%lo(%2), %%g1\n"
-		"1:\tlduw	[%0], %%g5\n\t"
-		"add		%%g5, %%g1, %%g7\n\t"
-		"cas		[%0], %%g5, %%g7\n\t"
-		"cmp		%%g5, %%g7\n\t"
-		"bne,pn		%%icc, 1b\n\t"
-		" cmp		%%g7, 0\n\t"
-		"bne,pn		%%icc, 3f\n\t"
-		" membar	#StoreStore\n"
-		"2:\n\t"
-		".subsection	2\n"
-		"3:\tmov	%0, %%g5\n\t"
-		"save		%%sp, -160, %%sp\n\t"
-		"mov		%%g2, %%l2\n\t"
-		"mov		%%g3, %%l3\n\t"
-		"call		%1\n\t"
-		" mov		%%g5, %%o0\n\t"
-		"mov		%%l2, %%g2\n\t"
-		"ba,pt		%%xcc, 2b\n\t"
-		" restore	%%l3, %%g0, %%g3\n\t"
-		".previous\n\t"
-		"! ending __down_write"
-		: : "r" (sem), "i" (rwsem_down_write_failed),
-		    "i" (RWSEM_ACTIVE_WRITE_BIAS)
-		: "g1", "g5", "g7", "memory", "cc");
-}
-
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"! beginning __up_read\n\t"
-		"1:\tlduw	[%0], %%g5\n\t"
-		"sub		%%g5, 1, %%g7\n\t"
-		"cas		[%0], %%g5, %%g7\n\t"
-		"cmp		%%g5, %%g7\n\t"
-		"bne,pn		%%icc, 1b\n\t"
-		" cmp		%%g7, 0\n\t"
-		"bl,pn		%%icc, 3f\n\t"
-		" membar	#StoreStore\n"
-		"2:\n\t"
-		".subsection	2\n"
-		"3:\tsethi	%%hi(%2), %%g1\n\t"
-		"sub		%%g7, 1, %%g7\n\t"
-		"or		%%g1, %%lo(%2), %%g1\n\t"
-		"andcc		%%g7, %%g1, %%g0\n\t"
-		"bne,pn		%%icc, 2b\n\t"
-		" mov		%0, %%g5\n\t"
-		"save		%%sp, -160, %%sp\n\t"
-		"mov		%%g2, %%l2\n\t"
-		"mov		%%g3, %%l3\n\t"
-		"call		%1\n\t"
-		" mov		%%g5, %%o0\n\t"
-		"mov		%%l2, %%g2\n\t"
-		"ba,pt		%%xcc, 2b\n\t"
-		" restore	%%l3, %%g0, %%g3\n\t"
-		".previous\n\t"
-		"! ending __up_read"
-		: : "r" (sem), "i" (rwsem_wake),
-		    "i" (RWSEM_ACTIVE_MASK)
-		: "g1", "g5", "g7", "memory", "cc");
-}
-
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"! beginning __up_write\n\t"
-		"sethi		%%hi(%2), %%g1\n\t"
-		"or		%%g1, %%lo(%2), %%g1\n"
-		"1:\tlduw	[%0], %%g5\n\t"
-		"sub		%%g5, %%g1, %%g7\n\t"
-		"cas		[%0], %%g5, %%g7\n\t"
-		"cmp		%%g5, %%g7\n\t"
-		"bne,pn		%%icc, 1b\n\t"
-		" sub		%%g7, %%g1, %%g7\n\t"
-		"cmp		%%g7, 0\n\t"
-		"bl,pn		%%icc, 3f\n\t"
-		" membar	#StoreStore\n"
-		"2:\n\t"
-		".subsection 2\n"
-		"3:\tmov	%0, %%g5\n\t"
-		"save		%%sp, -160, %%sp\n\t"
-		"mov		%%g2, %%l2\n\t"
-		"mov		%%g3, %%l3\n\t"
-		"call		%1\n\t"
-		" mov		%%g5, %%o0\n\t"
-		"mov		%%l2, %%g2\n\t"
-		"ba,pt		%%xcc, 2b\n\t"
-		" restore	%%l3, %%g0, %%g3\n\t"
-		".previous\n\t"
-		"! ending __up_write"
-		: : "r" (sem), "i" (rwsem_wake),
-		    "i" (RWSEM_ACTIVE_WRITE_BIAS)
-		: "g1", "g5", "g7", "memory", "cc");
-}
-
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	int tmp = delta;
-
-	__asm__ __volatile__(
-		"1:\tlduw	[%2], %%g5\n\t"
-		"add		%%g5, %1, %%g7\n\t"
-		"cas		[%2], %%g5, %%g7\n\t"
-		"cmp		%%g5, %%g7\n\t"
-		"bne,pn		%%icc, 1b\n\t"
-		" nop\n\t"
-		"mov		%%g7, %0\n\t"
-		: "=&r" (tmp)
-		: "0" (tmp), "r" (sem)
-		: "g5", "g7", "memory");
-
-	return tmp + delta;
-}
-
-#define rwsem_atomic_add rwsem_atomic_update
-
-static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 __old, __u16 __new)
-{
-	u32 old = (sem->count & 0xffff0000) | (u32) __old;
-	u32 new = (old & 0xffff0000) | (u32) __new;
-	u32 prev;
-
-again:
-	__asm__ __volatile__("cas	[%2], %3, %0\n\t"
-			     "membar	#StoreStore | #StoreLoad"
-			     : "=&r" (prev)
-			     : "0" (new), "r" (sem), "r" (old)
-			     : "memory");
-
-	/* To give the same semantics as x86 cmpxchgw, keep trying
-	 * if only the upper 16-bits changed.
-	 */
-	if (prev != old &&
-	    ((prev & 0xffff) == (old & 0xffff)))
-		goto again;
-
-	return prev & 0xffff;
-}
-
-static inline signed long rwsem_cmpxchg(struct rw_semaphore *sem, signed long old, signed long new)
-{
-	return cmpxchg(&sem->count,old,new);
-}
-
-#endif /* __KERNEL__ */
-
-#endif /* _SPARC64_RWSEM_H */
diff -uNr linux-2.4.10-pre12/include/linux/rwsem-spinlock.h linux-rwsem/include/linux/rwsem-spinlock.h
--- linux-2.4.10-pre12/include/linux/rwsem-spinlock.h	Tue Sep 18 08:45:13 2001
+++ linux-rwsem/include/linux/rwsem-spinlock.h	Thu Jan  1 01:00:00 1970
@@ -1,62 +0,0 @@
-/* rwsem-spinlock.h: fallback C implementation
- *
- * Copyright (c) 2001   David Howells (dhowells@redhat.com).
- * - Derived partially from ideas by Andrea Arcangeli <andrea@suse.de>
- * - Derived also from comments by Linus
- */
-
-#ifndef _LINUX_RWSEM_SPINLOCK_H
-#define _LINUX_RWSEM_SPINLOCK_H
-
-#ifndef _LINUX_RWSEM_H
-#error please dont include linux/rwsem-spinlock.h directly, use linux/rwsem.h instead
-#endif
-
-#include <linux/spinlock.h>
-#include <linux/list.h>
-
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-
-struct rwsem_waiter;
-
-/*
- * the rw-semaphore definition
- * - if activity is 0 then there are no active readers or writers
- * - if activity is +ve then that is the number of active readers
- * - if activity is -1 then there is one active writer
- * - if wait_list is not empty, then there are processes waiting for the semaphore
- */
-struct rw_semaphore {
-	__s32			activity;
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-extern void FASTCALL(init_rwsem(struct rw_semaphore *sem));
-extern void FASTCALL(__down_read(struct rw_semaphore *sem));
-extern void FASTCALL(__down_write(struct rw_semaphore *sem));
-extern void FASTCALL(__up_read(struct rw_semaphore *sem));
-extern void FASTCALL(__up_write(struct rw_semaphore *sem));
-
-#endif /* __KERNEL__ */
-#endif /* _LINUX_RWSEM_SPINLOCK_H */
diff -uNr linux-2.4.10-pre12/include/linux/rwsem.h linux-rwsem/include/linux/rwsem.h
--- linux-2.4.10-pre12/include/linux/rwsem.h	Tue Sep 18 08:45:13 2001
+++ linux-rwsem/include/linux/rwsem.h	Wed Sep 19 14:50:22 2001
@@ -9,40 +9,59 @@
 
 #include <linux/linkage.h>
 
-#define RWSEM_DEBUG 0
-
 #ifdef __KERNEL__
 
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
 #include <asm/system.h>
-#include <asm/atomic.h>
 
-struct rw_semaphore;
+/*
+ * the rw-semaphore definition
+ * - if activity is 0 then there are no active readers or writers
+ * - if activity is +ve then that is the number of active readers
+ * - if activity is -1 then there is one active writer
+ * - if wait_list is not empty, then there are processes waiting for the semaphore
+ */
+struct rw_semaphore {
+	int			activity;
+	spinlock_t		lock;
+	struct list_head	wait_list;
+};
+
+/*
+ * initialisation
+ */
+#define __RWSEM_INITIALIZER(name) \
+{ 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) }
+
+#define DECLARE_RWSEM(name) \
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
+
+static inline void init_rwsem(struct rw_semaphore *sem)
+{
+	sem->activity = 0;
+	spin_lock_init(&sem->lock);
+	INIT_LIST_HEAD(&sem->wait_list);
+}
 
-#ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
-#include <linux/rwsem-spinlock.h> /* use a generic implementation */
-#else
-#include <asm/rwsem.h> /* use an arch-specific implementation */
-#endif
-
-#ifndef rwsemtrace
-#if RWSEM_DEBUG
-extern void FASTCALL(rwsemtrace(struct rw_semaphore *sem, const char *str));
-#else
-#define rwsemtrace(SEM,FMT)
-#endif
-#endif
+extern void FASTCALL(__rwsem_wait(struct rw_semaphore *sem, int bias));
+extern void FASTCALL(__rwsem_wake(struct rw_semaphore *sem));
 
 /*
  * lock for reading
  */
 static inline void down_read(struct rw_semaphore *sem)
 {
-	rwsemtrace(sem,"Entering down_read");
-	__down_read(sem);
-	rwsemtrace(sem,"Leaving down_read");
+	spin_lock(&sem->lock);
+	if (sem->activity>=0) {
+		sem->activity++;
+		spin_unlock(&sem->lock);
+	}
+	else
+		__rwsem_wait(sem,1);
 }
 
 /*
@@ -50,9 +69,13 @@
  */
 static inline void down_write(struct rw_semaphore *sem)
 {
-	rwsemtrace(sem,"Entering down_write");
-	__down_write(sem);
-	rwsemtrace(sem,"Leaving down_write");
+	spin_lock(&sem->lock);
+	if (sem->activity==0) {
+		sem->activity--;
+		spin_unlock(&sem->lock);
+	}
+	else
+		__rwsem_wait(sem,-1);
 }
 
 /*
@@ -60,9 +83,10 @@
  */
 static inline void up_read(struct rw_semaphore *sem)
 {
-	rwsemtrace(sem,"Entering up_read");
-	__up_read(sem);
-	rwsemtrace(sem,"Leaving up_read");
+	spin_lock(&sem->lock);
+	if (!--sem->activity && !list_empty(&sem->wait_list))
+		__rwsem_wake(sem);
+	spin_unlock(&sem->lock);
 }
 
 /*
@@ -70,9 +94,11 @@
  */
 static inline void up_write(struct rw_semaphore *sem)
 {
-	rwsemtrace(sem,"Entering up_write");
-	__up_write(sem);
-	rwsemtrace(sem,"Leaving up_write");
+	spin_lock(&sem->lock);
+	sem->activity++;
+	if (!list_empty(&sem->wait_list))
+		__rwsem_wake(sem);
+	spin_unlock(&sem->lock);
 }
 
 
diff -uNr linux-2.4.10-pre12/lib/Makefile linux-rwsem/lib/Makefile
--- linux-2.4.10-pre12/lib/Makefile	Wed Sep 19 10:39:23 2001
+++ linux-rwsem/lib/Makefile	Wed Sep 19 14:49:09 2001
@@ -8,12 +8,9 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o
+export-objs := cmdline.o dec_and_lock.o rwsem.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o
-
-obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
-obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o rwsem.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o
diff -uNr linux-2.4.10-pre12/lib/rwsem-spinlock.c linux-rwsem/lib/rwsem-spinlock.c
--- linux-2.4.10-pre12/lib/rwsem-spinlock.c	Tue Sep 18 08:45:12 2001
+++ linux-rwsem/lib/rwsem-spinlock.c	Thu Jan  1 01:00:00 1970
@@ -1,239 +0,0 @@
-/* rwsem-spinlock.c: R/W semaphores: contention handling functions for generic spinlock
- *                                   implementation
- *
- * Copyright (c) 2001   David Howells (dhowells@redhat.com).
- * - Derived partially from idea by Andrea Arcangeli <andrea@suse.de>
- * - Derived also from comments by Linus
- */
-#include <linux/rwsem.h>
-#include <linux/sched.h>
-#include <linux/module.h>
-
-struct rwsem_waiter {
-	struct list_head	list;
-	struct task_struct	*task;
-	unsigned int		flags;
-#define RWSEM_WAITING_FOR_READ	0x00000001
-#define RWSEM_WAITING_FOR_WRITE	0x00000002
-};
-
-#if RWSEM_DEBUG
-void rwsemtrace(struct rw_semaphore *sem, const char *str)
-{
-	if (sem->debug)
-		printk("[%d] %s({%d,%d})\n",
-		       current->pid,str,sem->activity,list_empty(&sem->wait_list)?0:1);
-}
-#endif
-
-/*
- * initialise the semaphore
- */
-void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->activity = 0;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-}
-
-/*
- * handle the lock being released whilst there are processes blocked on it that can now run
- * - if we come here, then:
- *   - the 'active count' _reached_ zero
- *   - the 'waiting count' is non-zero
- * - the spinlock must be held by the caller
- * - woken process blocks are discarded from the list after having flags zeroised
- */
-static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter *waiter;
-	int woken;
-
-	rwsemtrace(sem,"Entering __rwsem_do_wake");
-
-	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
-
-	/* try to grant a single write lock if there's a writer at the front of the queue
-	 * - we leave the 'waiting count' incremented to signify potential contention
-	 */
-	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
-		sem->activity = -1;
-		list_del(&waiter->list);
-		waiter->flags = 0;
-		wake_up_process(waiter->task);
-		goto out;
-	}
-
-	/* grant an infinite number of read locks to the readers at the front of the queue */
-	woken = 0;
-	do {
-		list_del(&waiter->list);
-		waiter->flags = 0;
-		wake_up_process(waiter->task);
-		woken++;
-		if (list_empty(&sem->wait_list))
-			break;
-		waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
-	} while (waiter->flags&RWSEM_WAITING_FOR_READ);
-
-	sem->activity += woken;
-
- out:
-	rwsemtrace(sem,"Leaving __rwsem_do_wake");
-	return sem;
-}
-
-/*
- * wake a single writer
- */
-static inline struct rw_semaphore *__rwsem_wake_one_writer(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter *waiter;
-
-	sem->activity = -1;
-
-	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
-	list_del(&waiter->list);
-
-	waiter->flags = 0;
-	wake_up_process(waiter->task);
-	return sem;
-}
-
-/*
- * get a read lock on the semaphore
- */
-void __down_read(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter waiter;
-	struct task_struct *tsk;
-
-	rwsemtrace(sem,"Entering __down_read");
-
-	spin_lock(&sem->wait_lock);
-
-	if (sem->activity>=0 && list_empty(&sem->wait_list)) {
-		/* granted */
-		sem->activity++;
-		spin_unlock(&sem->wait_lock);
-		goto out;
-	}
-
-	tsk = current;
-	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
-
-	/* set up my own style of waitqueue */
-	waiter.task = tsk;
-	waiter.flags = RWSEM_WAITING_FOR_READ;
-
-	list_add_tail(&waiter.list,&sem->wait_list);
-
-	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock(&sem->wait_lock);
-
-	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter.flags)
-			break;
-		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	}
-
-	tsk->state = TASK_RUNNING;
-
- out:
-	rwsemtrace(sem,"Leaving __down_read");
-}
-
-/*
- * get a write lock on the semaphore
- * - note that we increment the waiting count anyway to indicate an exclusive lock
- */
-void __down_write(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter waiter;
-	struct task_struct *tsk;
-
-	rwsemtrace(sem,"Entering __down_write");
-
-	spin_lock(&sem->wait_lock);
-
-	if (sem->activity==0 && list_empty(&sem->wait_list)) {
-		/* granted */
-		sem->activity = -1;
-		spin_unlock(&sem->wait_lock);
-		goto out;
-	}
-
-	tsk = current;
-	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
-
-	/* set up my own style of waitqueue */
-	waiter.task = tsk;
-	waiter.flags = RWSEM_WAITING_FOR_WRITE;
-
-	list_add_tail(&waiter.list,&sem->wait_list);
-
-	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock(&sem->wait_lock);
-
-	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter.flags)
-			break;
-		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	}
-
-	tsk->state = TASK_RUNNING;
-
- out:
-	rwsemtrace(sem,"Leaving __down_write");
-}
-
-/*
- * release a read lock on the semaphore
- */
-void __up_read(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering __up_read");
-
-	spin_lock(&sem->wait_lock);
-
-	if (--sem->activity==0 && !list_empty(&sem->wait_list))
-		sem = __rwsem_wake_one_writer(sem);
-
-	spin_unlock(&sem->wait_lock);
-
-	rwsemtrace(sem,"Leaving __up_read");
-}
-
-/*
- * release a write lock on the semaphore
- */
-void __up_write(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering __up_write");
-
-	spin_lock(&sem->wait_lock);
-
-	sem->activity = 0;
-	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem);
-
-	spin_unlock(&sem->wait_lock);
-
-	rwsemtrace(sem,"Leaving __up_write");
-}
-
-EXPORT_SYMBOL(init_rwsem);
-EXPORT_SYMBOL(__down_read);
-EXPORT_SYMBOL(__down_write);
-EXPORT_SYMBOL(__up_read);
-EXPORT_SYMBOL(__up_write);
-#if RWSEM_DEBUG
-EXPORT_SYMBOL(rwsemtrace);
-#endif
diff -uNr linux-2.4.10-pre12/lib/rwsem.c linux-rwsem/lib/rwsem.c
--- linux-2.4.10-pre12/lib/rwsem.c	Tue Sep 18 08:45:12 2001
+++ linux-rwsem/lib/rwsem.c	Wed Sep 19 15:09:25 2001
@@ -1,7 +1,8 @@
 /* rwsem.c: R/W semaphores: contention handling functions
  *
- * Written by David Howells (dhowells@redhat.com).
- * Derived from arch/i386/kernel/semaphore.c
+ * Copyright (c) 2001   David Howells (dhowells@redhat.com).
+ * - Derived partially from idea by Andrea Arcangeli <andrea@suse.de>
+ * - Derived also from comments by Linus
  */
 #include <linux/rwsem.h>
 #include <linux/sched.h>
@@ -15,196 +16,78 @@
 #define RWSEM_WAITING_FOR_WRITE	0x00000002
 };
 
-#if RWSEM_DEBUG
-#undef rwsemtrace
-void rwsemtrace(struct rw_semaphore *sem, const char *str)
-{
-	printk("sem=%p\n",sem);
-	printk("(sem)=%08lx\n",sem->count);
-	if (sem->debug)
-		printk("[%d] %s({%08lx})\n",current->pid,str,sem->count);
-}
-#endif
-
 /*
  * handle the lock being released whilst there are processes blocked on it that can now run
  * - if we come here, then:
- *   - the 'active part' of the count (&0x0000ffff) reached zero but has been re-incremented
- *   - the 'waiting part' of the count (&0xffff0000) is negative (and will still be so)
- *   - there must be someone on the queue
+ *   - the 'active count' _reached_ zero
+ *   - the 'waiting count' is non-zero
  * - the spinlock must be held by the caller
  * - woken process blocks are discarded from the list after having flags zeroised
  */
-static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
+void __rwsem_wake(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter *waiter;
-	struct list_head *next;
-	signed long oldcount;
-	int woken, loop;
-
-	rwsemtrace(sem,"Entering __rwsem_do_wake");
-
-	/* only wake someone up if we can transition the active part of the count from 0 -> 1 */
- try_again:
-	oldcount = rwsem_atomic_update(RWSEM_ACTIVE_BIAS,sem) - RWSEM_ACTIVE_BIAS;
-	if (oldcount & RWSEM_ACTIVE_MASK)
-		goto undo;
+	int woken;
 
 	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
 
 	/* try to grant a single write lock if there's a writer at the front of the queue
-	 * - note we leave the 'active part' of the count incremented by 1 and the waiting part
-	 *   incremented by 0x00010000
+	 * - we leave the 'waiting count' incremented to signify potential contention
 	 */
-	if (!(waiter->flags & RWSEM_WAITING_FOR_WRITE))
-		goto readers_only;
+	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
+		sem->activity = -1;
+		list_del(&waiter->list);
+		waiter->flags = 0;
+		wake_up_process(waiter->task);
+		return;
+	}
 
-	list_del(&waiter->list);
-	waiter->flags = 0;
-	wake_up_process(waiter->task);
-	goto out;
-
-	/* grant an infinite number of read locks to the readers at the front of the queue
-	 * - note we increment the 'active part' of the count by the number of readers (less one
-	 *   for the activity decrement we've already done) before waking any processes up
-	 */
- readers_only:
+	/* grant an infinite number of read locks to the readers at the front of the queue */
 	woken = 0;
 	do {
-		woken++;
-
-		if (waiter->list.next==&sem->wait_list)
-			break;
-
-		waiter = list_entry(waiter->list.next,struct rwsem_waiter,list);
-
-	} while (waiter->flags & RWSEM_WAITING_FOR_READ);
-
-	loop = woken;
-	woken *= RWSEM_ACTIVE_BIAS-RWSEM_WAITING_BIAS;
-	woken -= RWSEM_ACTIVE_BIAS;
-	rwsem_atomic_add(woken,sem);
-
-	next = sem->wait_list.next;
-	for (; loop>0; loop--) {
-		waiter = list_entry(next,struct rwsem_waiter,list);
-		next = waiter->list.next;
+		list_del(&waiter->list);
 		waiter->flags = 0;
 		wake_up_process(waiter->task);
-	}
-
-	sem->wait_list.next = next;
-	next->prev = &sem->wait_list;
+		woken++;
+		if (list_empty(&sem->wait_list))
+			break;
+		waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
+	} while (waiter->flags&RWSEM_WAITING_FOR_READ);
 
- out:
-	rwsemtrace(sem,"Leaving __rwsem_do_wake");
-	return sem;
-
-	/* undo the change to count, but check for a transition 1->0 */
- undo:
-	if (rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem)!=0)
-		goto out;
-	goto try_again;
+	sem->activity += woken;
 }
 
 /*
- * wait for a lock to be granted
+ * wait for a lock on the rw_semaphore
+ * - must be entered with the rwsemsem_lock spinlock held
  */
-static inline struct rw_semaphore *rwsem_down_failed_common(struct rw_semaphore *sem,
-								 struct rwsem_waiter *waiter,
-								 signed long adjustment)
+void __rwsem_wait(struct rw_semaphore *sem, int bias)
 {
-	struct task_struct *tsk = current;
-	signed long count;
+	struct rwsem_waiter waiter;
+	struct task_struct *tsk;
 
+	tsk = current;
 	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
 
-	/* set up my own style of waitqueue */
-	spin_lock(&sem->wait_lock);
-	waiter->task = tsk;
-
-	list_add_tail(&waiter->list,&sem->wait_list);
-
-	/* note that we're now waiting on the lock, but no longer actively read-locking */
-	count = rwsem_atomic_update(adjustment,sem);
+	/* add to the waitqueue */
+	waiter.task = tsk;
+	waiter.flags = RWSEM_WAITING_FOR_READ;
 
-	/* if there are no longer active locks, wake the front queued process(es) up
-	 * - it might even be this process, since the waker takes a more active part
-	 */
-	if (!(count & RWSEM_ACTIVE_MASK))
-		sem = __rwsem_do_wake(sem);
+	list_add_tail(&waiter.list,&sem->wait_list);
 
-	spin_unlock(&sem->wait_lock);
+	/* we don't need to touch the semaphore anymore */
+	spin_unlock(&sem->lock);
 
 	/* wait to be given the lock */
 	for (;;) {
-		if (!waiter->flags)
+		if (!waiter.flags)
 			break;
 		schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
 
 	tsk->state = TASK_RUNNING;
-
-	return sem;
-}
-
-/*
- * wait for the read lock to be granted
- */
-struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter waiter;
-
-	rwsemtrace(sem,"Entering rwsem_down_read_failed");
-
-	waiter.flags = RWSEM_WAITING_FOR_READ;
-	rwsem_down_failed_common(sem,&waiter,RWSEM_WAITING_BIAS-RWSEM_ACTIVE_BIAS);
-
-	rwsemtrace(sem,"Leaving rwsem_down_read_failed");
-	return sem;
-}
-
-/*
- * wait for the write lock to be granted
- */
-struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter waiter;
-
-	rwsemtrace(sem,"Entering rwsem_down_write_failed");
-
-	waiter.flags = RWSEM_WAITING_FOR_WRITE;
-	rwsem_down_failed_common(sem,&waiter,-RWSEM_ACTIVE_BIAS);
-
-	rwsemtrace(sem,"Leaving rwsem_down_write_failed");
-	return sem;
-}
-
-/*
- * handle waking up a waiter on the semaphore
- * - up_read has decremented the active part of the count if we come here
- */
-struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering rwsem_wake");
-
-	spin_lock(&sem->wait_lock);
-
-	/* do nothing if list empty */
-	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem);
-
-	spin_unlock(&sem->wait_lock);
-
-	rwsemtrace(sem,"Leaving rwsem_wake");
-
-	return sem;
 }
 
-EXPORT_SYMBOL_NOVERS(rwsem_down_read_failed);
-EXPORT_SYMBOL_NOVERS(rwsem_down_write_failed);
-EXPORT_SYMBOL_NOVERS(rwsem_wake);
-#if RWSEM_DEBUG
-EXPORT_SYMBOL(rwsemtrace);
-#endif
+EXPORT_SYMBOL(__rwsem_wait);
+EXPORT_SYMBOL(__rwsem_wake);
