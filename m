Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUIPCfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUIPCfK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 22:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUIPCfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 22:35:10 -0400
Received: from mail.renesas.com ([202.234.163.13]:53994 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S266555AbUIPCeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 22:34:04 -0400
Date: Thu, 16 Sep 2004 11:33:53 +0900 (JST)
Message-Id: <20040916.113353.596543062.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm5] [m32r] Slim arch/m32r/Kconfig
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, Zwane Mwaikambo <zwane@linuxpower.ca>,
       takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch to slim arch/m32r/Kconfig.
Useless CONFIG_ options are removed for m32r.
Please apply.

From: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: 2.6.9-rc1-mm3
Date: Fri, 3 Sep 2004 08:48:27 -0400 (EDT)
> - arch/m32r/Kconfig could do with some trimming.

Thanks.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/Kconfig |  182 ------------------------------------------------------
 1 files changed, 2 insertions(+), 180 deletions(-)


--- linux-2.6.9-rc1-mm5.orig/arch/m32r/Kconfig	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/Kconfig	2004-09-15 20:23:08.000000000 +0900
@@ -219,18 +219,12 @@ config SMP
 	  singleprocessor machines. On a singleprocessor machine, the kernel
 	  will run faster if you say N here.
 
-	  Note that if you say Y here and choose architecture "586" or
-	  "Pentium" under "Processor family", the kernel will not work on 486
-	  architectures. Similarly, multiprocessor kernels for the "PPro"
-	  architecture may not work on all Pentium based boards.
-
 	  People using multiprocessor machines who say Y here should also say
 	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
 	  Management" code will be disabled if you say Y here.
 
 	  See also the <file:Documentation/smp.tex>,
-	  <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
-	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
+	  <file:Documentation/smp.txt> and the SMP-HOWTO available at
 	  <http://www.linuxdoc.org/docs.html#howto>.
 
 	  If you don't know what to do here, say N.
@@ -271,158 +265,6 @@ config BOOT_IOREMAP
 endmenu
 
 
-menu "Power management options (ACPI, APM)"
-
-source kernel/power/Kconfig
-
-config APM
-	tristate "Advanced Power Management BIOS support"
-	depends on PM
-	---help---
-	  APM is a BIOS specification for saving power using several different
-	  techniques. This is mostly useful for battery powered laptops with
-	  APM compliant BIOSes. If you say Y here, the system time will be
-	  reset after a RESUME operation, the /proc/apm device will provide
-	  battery status information, and user-space programs will receive
-	  notification of APM "events" (e.g. battery status change).
-
-	  If you select "Y" here, you can disable actual use of the APM
-	  BIOS by passing the "apm=off" option to the kernel at boot time.
-
-	  Note that the APM support is almost completely disabled for
-	  machines with more than one CPU.
-
-	  In order to use APM, you will need supporting software. For location
-	  and more information, read <file:Documentation/pm.txt> and the
-	  Battery Powered Linux mini-HOWTO, available from
-	  <http://www.linuxdoc.org/docs.html#howto>.
-
-	  This driver does not spin down disk drives (see the hdparm(8)
-	  manpage ("man 8 hdparm") for that), and it doesn't turn off
-	  VESA-compliant "green" monitors.
-
-	  This driver does not support the TI 4000M TravelMate and the ACER
-	  486/DX4/75 because they don't have compliant BIOSes. Many "green"
-	  desktop machines also don't have compliant BIOSes, and this driver
-	  may cause those machines to panic during the boot phase.
-
-	  Generally, if you don't have a battery in your machine, there isn't
-	  much point in using this driver and you should say N. If you get
-	  random kernel OOPSes or reboots that don't seem to be related to
-	  anything, try disabling/enabling this option (or disabling/enabling
-	  APM in your BIOS).
-
-	  Some other things you should try when experiencing seemingly random,
-	  "weird" problems:
-
-	  1) make sure that you have enough swap space and that it is
-	  enabled.
-	  2) pass the "no-hlt" option to the kernel
-	  3) switch on floating point emulation in the kernel and pass
-	  the "no387" option to the kernel
-	  4) pass the "floppy=nodma" option to the kernel
-	  5) pass the "mem=4M" option to the kernel (thereby disabling
-	  all but the first 4 MB of RAM)
-	  6) make sure that the CPU is not over clocked.
-	  7) read the sig11 FAQ at <http://www.bitwizard.nl/sig11/>
-	  8) disable the cache from your BIOS settings
-	  9) install a fan for the video card or exchange video RAM
-	  10) install a better fan for the CPU
-	  11) exchange RAM chips
-	  12) exchange the motherboard.
-
-	  To compile this driver as a module ( = code which can be inserted in
-	  and removed from the running kernel whenever you want), say M here
-	  and read <file:Documentation/modules.txt>. The module will be called
-	  apm.
-
-config APM_IGNORE_USER_SUSPEND
-	bool "Ignore USER SUSPEND"
-	depends on APM
-	help
-	  This option will ignore USER SUSPEND requests. On machines with a
-	  compliant APM BIOS, you want to say N. However, on the NEC Versa M
-	  series notebooks, it is necessary to say Y because of a BIOS bug.
-
-config APM_DO_ENABLE
-	bool "Enable PM at boot time"
-	depends on APM
-	---help---
-	  Enable APM features at boot time. From page 36 of the APM BIOS
-	  specification: "When disabled, the APM BIOS does not automatically
-	  power manage devices, enter the Standby State, enter the Suspend
-	  State, or take power saving steps in response to CPU Idle calls."
-	  This driver will make CPU Idle calls when Linux is idle (unless this
-	  feature is turned off -- see "Do CPU IDLE calls", below). This
-	  should always save battery power, but more complicated APM features
-	  will be dependent on your BIOS implementation. You may need to turn
-	  this option off if your computer hangs at boot time when using APM
-	  support, or if it beeps continuously instead of suspending. Turn
-	  this off if you have a NEC UltraLite Versa 33/C or a Toshiba
-	  T400CDT. This is off by default since most machines do fine without
-	  this feature.
-
-config APM_CPU_IDLE
-	bool "Make CPU Idle calls when idle"
-	depends on APM
-	help
-	  Enable calls to APM CPU Idle/CPU Busy inside the kernel's idle loop.
-	  On some machines, this can activate improved power savings, such as
-	  a slowed CPU clock rate, when the machine is idle. These idle calls
-	  are made after the idle loop has run for some length of time (e.g.,
-	  333 mS). On some machines, this will cause a hang at boot time or
-	  whenever the CPU becomes idle. (On machines with more than one CPU,
-	  this option does nothing.)
-
-config APM_DISPLAY_BLANK
-	bool "Enable console blanking using APM"
-	depends on APM
-	help
-	  Enable console blanking using the APM. Some laptops can use this to
-	  turn off the LCD backlight when the screen blanker of the Linux
-	  virtual console blanks the screen. Note that this is only used by
-	  the virtual console screen blanker, and won't turn off the backlight
-	  when using the X Window system. This also doesn't have anything to
-	  do with your VESA-compliant power-saving monitor. Further, this
-	  option doesn't work for all laptops -- it might not turn off your
-	  backlight at all, or it might print a lot of errors to the console,
-	  especially if you are using gpm.
-
-config APM_RTC_IS_GMT
-	bool "RTC stores time in GMT"
-	depends on APM
-	help
-	  Say Y here if your RTC (Real Time Clock a.k.a. hardware clock)
-	  stores the time in GMT (Greenwich Mean Time). Say N if your RTC
-	  stores localtime.
-
-	  It is in fact recommended to store GMT in your RTC, because then you
-	  don't have to worry about daylight savings time changes. The only
-	  reason not to use GMT in your RTC is if you also run a broken OS
-	  that doesn't understand GMT.
-
-config APM_ALLOW_INTS
-	bool "Allow interrupts during APM BIOS calls"
-	depends on APM
-	help
-	  Normally we disable external interrupts while we are making calls to
-	  the APM BIOS as a measure to lessen the effects of a badly behaving
-	  BIOS implementation.  The BIOS should reenable interrupts if it
-	  needs to.  Unfortunately, some BIOSes do not -- especially those in
-	  many of the newer IBM Thinkpads.  If you experience hangs when you
-	  suspend, try setting this to Y.  Otherwise, say N.
-
-config APM_REAL_MODE_POWER_OFF
-	bool "Use real mode APM BIOS call to power off"
-	depends on APM
-	help
-	  Use real mode APM BIOS calls to switch off the computer. This is
-	  a work-around for a number of buggy BIOSes. Switch this option on if
-	  your computer crashes instead of powering off properly.
-
-endmenu
-
-
 menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
 
 config PCI
@@ -485,27 +327,7 @@ config ISA
 	help
 	  Find out whether you have ISA slots on your motherboard.  ISA is the
 	  name of a bus system, i.e. the way the CPU talks to the other stuff
-	  inside your box.  Other bus systems are PCI, EISA, MicroChannel
-	  (MCA) or VESA.  ISA is an older system, now being displaced by PCI;
-	  newer boards don't support it.  If you have ISA, say Y, otherwise N.
-
-config EISA
-	bool "EISA support"
-	depends on ISA
-	---help---
-	  The Extended Industry Standard Architecture (EISA) bus was
-	  developed as an open alternative to the IBM MicroChannel bus.
-
-	  The EISA bus provided some of the features of the IBM MicroChannel
-	  bus while maintaining backward compatibility with cards made for
-	  the older ISA bus.  The EISA bus saw limited use between 1988 and
-	  1995 when it was made obsolete by the PCI bus.
-
-	  Say Y here if you are building a kernel for an EISA-based machine.
-
-	  Otherwise, say N.
-
-source "drivers/eisa/Kconfig"
+	  inside your box.  If you have ISA, say Y, otherwise N.
 
 source "drivers/pcmcia/Kconfig"
 

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
