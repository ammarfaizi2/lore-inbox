Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268954AbTGTWvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 18:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268909AbTGTWup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 18:50:45 -0400
Received: from aneto.able.es ([212.97.163.22]:19171 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S268827AbTGTWug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 18:50:36 -0400
Date: Mon, 21 Jul 2003 01:05:35 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "William M. Quarles" <quarlewm@jmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4 CPU Arch issues
Message-ID: <20030720230535.GA3708@werewolf.able.es>
References: <3F1B1E77.2020205@jmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3F1B1E77.2020205@jmu.edu>; from quarlewm@jmu.edu on Mon, Jul 21, 2003 at 00:57:59 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.21, William M. Quarles wrote:
> Hi,
> 
> In the 2.4 kernel, is it possible for you to separate the Pentium II and 
> Pentium Pro as confiugration options, as you have done for the 2.6 
> kernel, or is it too late in the development for that?
> 

Something like this ?

--- linux-2.4.21-pre5-jam1/arch/i386/config.in.orig	2003-03-07 02:52:48.000000000 +0100
+++ linux-2.4.21-pre5-jam1/arch/i386/config.in	2003-03-07 02:57:27.000000000 +0100
@@ -31,7 +31,8 @@
 	 586/K5/5x86/6x86/6x86MX		CONFIG_M586 \
 	 Pentium-Classic			CONFIG_M586TSC \
 	 Pentium-MMX				CONFIG_M586MMX \
-	 Pentium-Pro/Celeron/Pentium-II		CONFIG_M686 \
+	 Pentium-Pro				CONFIG_M686 \
+	 Pentium-II/Celeron			CONFIG_MPENTIUMII \
 	 Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUMIII \
 	 Pentium-4				CONFIG_MPENTIUM4 \
 	 K6/K6-II/K6-III			CONFIG_MK6 \
@@ -106,6 +107,14 @@
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
+if [ "$CONFIG_MPENTIUMII" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_bool CONFIG_X86_HAS_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_PGE y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_F00F_WORKS_OK y
+fi
 if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_HAS_TSC y
--- linux-2.4.21-pre5-jam1/arch/i386/Makefile.orig	2003-03-07 02:59:46.000000000 +0100
+++ linux-2.4.21-pre5-jam1/arch/i386/Makefile	2003-03-07 03:00:08.000000000 +0100
@@ -52,6 +52,10 @@
 CFLAGS += -march=i686
 endif
 
+ifdef CONFIG_MPENTIUMII
+CFLAGS += $(call check_gcc,-march=pentium2,-march=i686)
+endif
+
 ifdef CONFIG_MPENTIUMIII
 CFLAGS += -march=i686
 endif
--- linux-2.4.21-pre5-jam1/Documentation/Configure.help.orig	2003-03-07 03:02:41.000000000 +0100
+++ linux-2.4.21-pre5-jam1/Documentation/Configure.help	2003-03-07 03:03:45.000000000 +0100
@@ -4203,7 +4203,8 @@
      (time stamp counter) register.
    - "Pentium-Classic" for the Intel Pentium.
    - "Pentium-MMX" for the Intel Pentium MMX.
-   - "Pentium-Pro" for the Intel Pentium Pro/Celeron/Pentium II.
+   - "Pentium-Pro" for the Intel Pentium Pro.
+   - "Pentium-II" for the Intel Pentium II/Celeron.
    - "Pentium-III" for the Intel Pentium III
      and Celerons based on the Coppermine core.
    - "Pentium-4" for the Intel Pentium 4.


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre7-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.5mdk))
