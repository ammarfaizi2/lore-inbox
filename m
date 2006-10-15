Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWJOSkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWJOSkk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 14:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWJOSkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 14:40:40 -0400
Received: from outmx015.isp.belgacom.be ([195.238.4.87]:47309 "EHLO
	outmx015.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751161AbWJOSkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 14:40:37 -0400
Date: Sun, 15 Oct 2006 19:41:46 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Victor <andrew@sanpeople.com>, Jean Delvare <khali@linux-fr.org>,
       Jeff Garzik <jeff@garzik.org>,
       Arnaud Patard <arnaud.patard@rtp-net.org>,
       Amol Lad <amol@verismonetworks.com>, Samuel Tardieu <sam@rfc1149.net>,
       Marcus Junker <junker@anduras.de>, Sven Anders <anders@anduras.de>
Subject: [WATCHDOG] v2.6.19 watchdog patches - part 3
Message-ID: <20061015174146.GA2559@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

If no-one objects, can you please pull from 'master' branch of
	git://git.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 Documentation/watchdog/src/watchdog-simple.c |    2 
 arch/arm/configs/at91rm9200dk_defconfig      |    2 
 arch/arm/configs/at91rm9200ek_defconfig      |    2 
 arch/arm/configs/csb337_defconfig            |    2 
 arch/arm/configs/csb637_defconfig            |    2 
 arch/arm/configs/kafa_defconfig              |    2 
 arch/arm/configs/onearm_defconfig            |    2 
 drivers/char/watchdog/Kconfig                |   65 ++
 drivers/char/watchdog/Makefile               |    4 
 drivers/char/watchdog/at91_wdt.c             |  287 ------------
 drivers/char/watchdog/at91rm9200_wdt.c       |  287 ++++++++++++
 drivers/char/watchdog/iTCO_wdt.c             |   21 
 drivers/char/watchdog/s3c2410_wdt.c          |    5 
 drivers/char/watchdog/smsc37b787_wdt.c       |  627 +++++++++++++++++++++++++++
 drivers/char/watchdog/w83627hf_wdt.c         |    8 
 drivers/char/watchdog/w83697hf_wdt.c         |  450 +++++++++++++++++++
 16 files changed, 1457 insertions(+), 311 deletions(-)

with these Changes:

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sat Oct 14 20:18:47 2006 +0200

    [WATCHDOG] remove experimental on iTCO_wdt.c
    
    The iTCO_wdt.c driver has been tested enough. So we can
    remove the experimental classification.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Andrew Victor <andrew@sanpeople.com>
Date:   Tue Sep 26 17:49:30 2006 +0200

    [WATCHDOG] Atmel AT91RM9200 rename.
    
    The new Atmel AT91SAM9261 and AT91SAM9260 processors use a different
    internal watchdog peripheral.  This watchdog driver is therefore
    AT91RM9200-specific.
    
    This patch renames at91_wdt.c to at91rm9200_wdt.c, and changes the name
    of the configuration option.
    
    Signed-off-by: Andrew Victor <andrew@sanpeople.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Jean Delvare <khali@linux-fr.org>
Date:   Thu Sep 28 09:35:27 2006 +0200

    [WATCHDOG] includes for sample watchdog program.
    
    Add missing includes to sample watchdog program.
    
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Oct 10 03:40:44 2006 -0400

    [WATCHDOG] watchdog/iTCO_wdt: fix bug related to gcc uninit warning
    
    gcc emits the following warning:
    
    drivers/char/watchdog/iTCO_wdt.c: In function ‘iTCO_wdt_ioctl’:
    drivers/char/watchdog/iTCO_wdt.c:429: warning: ‘time_left’ may be used uninitialized in this function
    
    This indicates a condition near enough to a bug, to want to fix.
    iTCO_wdt_get_timeleft() stores a value in 'time_left' iff
    iTCO_version==(1 or 2).  This driver only supports versions
    1 or 2, so this is ok.  However, since (a) the return value of
    iTCO_wdt_get_timeleft() is handled anyway, (b) it fixes the warning,
    and (c) it future-proofs the driver, we go ahead and add the obvious
    return value.
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Oct 8 21:05:21 2006 +0200

    [WATCHDOG] add ich8 support to iTCO_wdt.c (patch 2)
    
    Add ICH8 support to the iTCO_wdt driver.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Date:   Wed Oct 4 14:18:29 2006 +0200

    [WATCHDOG] add ich8 support to iTCO_wdt.c
    
    Add ICH8 support to the iTCO_wdt driver.
    
    Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Amol Lad <amol@verismonetworks.com>
Date:   Fri Oct 6 13:41:12 2006 -0700

    [WATCHDOG] ioremap balanced with iounmap for drivers/char/watchdog/s3c2410_wdt.c
    
    ioremap must be balanced by an iounmap and failing to do so can result
    in a memory leak.
    
    Signed-off-by: Amol Lad <amol@verismonetworks.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - Kconfig patch
    
    Update Kconfig for the w83697hf/hg watchdog driver.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Fri Sep 15 17:59:07 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - autodetect patch
    
    Change the autodetect code so that it is more generic.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 16
    
    This is patch 16 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - Add copyright notice for Samuel Tardieu also.
    
    This is the last patch in this series.
    
    The original description for Samuel's driver was:
    driver for the Winbond W83697HF/W83697HG watchdog timer
    
    The Winbond SuperIO W83697HF/HG includes a watchdog that can count from
    1 to 255 seconds (or minutes). This drivers allows the seconds mode to
    be used. It exposes a standard /dev/watchdog interface. This chip is
    currently being used on some motherboards designed by VIA.
    
    By default, the module looks for a chip at I/O port 0x2e. The chip can
    be configured to be at 0x4e on some motherboards, the address can be
    chosen using the wdt_io module parameter. Using 0 will try to autodetect
    the address.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 15
    
    This is patch 15 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - Clean-up initialization code - part 2:
       * the line reading "set second mode & disable keyboard ..."
         is plain wrong, the register being manipulated (CRF4) is
         the counter itself, not the control byte (CRF3) -- looks
         like it has been copied from another driver.
       * I think garbage is being written in CRF3 (the control word)
         as the timeout value is being stored in this register (such
         as 60 for 60 seconds).
       * We only want to set pin 119 to WDTO# mode and leave the rest
         of CR29 like it is.
       * Set count mode to seconds and not minutes.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 14
    
    This is patch 14 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - Clean-up initialization code (part 1: remove
       w83697hf_select_wd_register() and
       w83697hf_unselect_wd_register() functions).
     - Make sure that the watchdog device is stopped
       as soon as we found it.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 13
    
    This is patch 13 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - Remove wdt_ctrl (it has been replaced with the
       w83697hf_write_timeout() function) and redo/clean-up
       the start/stop/ping code.
     - Make sure that the watchdog is enabled or disabled
       When starting or stoping the device (with a call
       to w83697hf_set_reg(0x30, ?); ).
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 12
    
    This is patch 12 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - Add w83697hf_write_timeout() to set the
       watchdog's timeout value.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 11
    
    This is patch 11 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - Add w83697hf_select_wdt() and w83697hf_deselect_wdt()
       so that the start/stop/ping code can directly talk to
       the watchdog.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 10
    
    This is patch 10 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - check whether the device is really present
       (we *can* probe for the device now).
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 9
    
    This is patch 9 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - add w83697hf_get_reg() and w83697hf_set_reg()
       functions.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 8
    
    This is patch 8 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - add w83697hf_lock function to leave the
       chipsets extended function mode.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 7
    
    This is patch 7 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - add w83697hf_unlock function to enter the
       chipsets extended function mode.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 6
    
    This is patch 6 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - The driver works for both the w83697hf
       and the w83697hg chipset's.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 5
    
    This is patch 5 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - Rename the Extended Function Registers to the names
       used in the data-sheet.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 4
    
    This is patch 4 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - limits the watchdog timeout to 1-63 while this
       device accepts 1-255.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 3
    
    This is patch 3 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - Fix identation.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 2
    
    This is patch 2 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - wdt_io is 2 bytes long. We should do a
       request_region for 2 bytes instead of 1.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Thu Sep 7 11:57:00 2006 +0200

    [WATCHDOG] w83697hf/hg WDT driver - patch 1
    
    This is patch 1 in the series of patches that converts
    Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
    w83697hf/hg watchdog driver.
    
    This patch contains following changes:
     - the note concerning tyan motherboards has been copied from
       another driver, This doesn't apply here.
     - the comments concerning CRF6 are wrong as CRF3 is manipulated
       and CRF6 is never read nor written.
     - the comments concerning CRF5 are wrong as CRF4 is manipulated
       and CRF5 is never read nor written.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Wed Sep 13 21:27:29 2006 +0200

    [WATCHDOG] use ENOTTY instead of ENOIOCTLCMD in ioctl()
    
    Return ENOTTY instead of ENOIOCTLCMD in user-visible ioctl() results
    
    The watchdog drivers used to return ENOIOCTLCMD for bad ioctl() commands.
    ENOIOCTLCMD should not be visible by the user, so use ENOTTY instead.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Acked-by: Alan Cox <alan@redhat.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sat Sep 2 19:04:02 2006 +0200

    [WATCHDOG] Kconfig clean up
    
    fixed some more trailing spaces.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sat Sep 2 18:50:20 2006 +0200

    [WATCHDOG] w836?7hf_wdt spinlock fixes.
    
    Add io spinlocks to prevent possible race
    conditions between start and stop operations
    that are issued from different child processes
    where the master process opened /dev/watchdog.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sat Sep 2 17:59:54 2006 +0200

    [WATCHDOG] Kconfig clean-up
    
    * fix typo's according to spellings checker
    * Fix some leading and trailing spaces
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Marcus Junker <junker@anduras.de>
Date:   Thu Aug 24 17:11:50 2006 +0200

    [WATCHDOG] w83697hf WDT driver
    
    New watchdog driver for the Winbond W83697HF chipset.
    
    Signed-off-by: Marcus Junker <junker@anduras.de>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sat Sep 2 20:53:19 2006 +0200

    [WATCHDOG] Winbond SMsC37B787 watchdog fixes
    
    * Added io spinlocking
    * Deleted WATCHDOG_MINOR (it's in the miscdevice include
    * Changed timer_enabled to use set_bit functions
    * WDIOC_GETSUPPORT should return -EFAULT or 0
    * timeout should be correct before we initialize the watchdog
    * we should initialize the watchdog before we give access
      to userspace
    * Third parameter of module_param is not the default or
      initial value
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sat Sep 2 19:32:26 2006 +0200

    [WATCHDOG] Winbond SMsC37B787 - remove trailing whitespace
    
    Remove trailing whitespace.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Sven Anders <anders@anduras.de>
Date:   Thu Aug 24 17:11:50 2006 +0200

    [WATCHDOG] Winbond SMsC37B787 watchdog driver
    
    New watchdog driver for the Winbond SMsC37B787 chipset.
    
    Signed-off-by: Sven Anders <anders@anduras.de>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/watchdog/src/watchdog-simple.c b/Documentation/watchdog/src/watchdog-simple.c
index 85cf17c..47801bc 100644
--- a/Documentation/watchdog/src/watchdog-simple.c
+++ b/Documentation/watchdog/src/watchdog-simple.c
@@ -1,4 +1,6 @@
+#include <stdio.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include <fcntl.h>
 
 int main(int argc, const char *argv[]) {
diff --git a/arch/arm/configs/at91rm9200dk_defconfig b/arch/arm/configs/at91rm9200dk_defconfig
index c82e466..b430414 100644
--- a/arch/arm/configs/at91rm9200dk_defconfig
+++ b/arch/arm/configs/at91rm9200dk_defconfig
@@ -577,7 +577,7 @@ #
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-CONFIG_AT91_WATCHDOG=y
+CONFIG_AT91RM9200_WATCHDOG=y
 
 #
 # USB-based Watchdog Cards
diff --git a/arch/arm/configs/at91rm9200ek_defconfig b/arch/arm/configs/at91rm9200ek_defconfig
index b983fc5..d96fc83 100644
--- a/arch/arm/configs/at91rm9200ek_defconfig
+++ b/arch/arm/configs/at91rm9200ek_defconfig
@@ -558,7 +558,7 @@ #
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-CONFIG_AT91_WATCHDOG=y
+CONFIG_AT91RM9200_WATCHDOG=y
 
 #
 # USB-based Watchdog Cards
diff --git a/arch/arm/configs/csb337_defconfig b/arch/arm/configs/csb337_defconfig
index a2d6fd3..20e6825 100644
--- a/arch/arm/configs/csb337_defconfig
+++ b/arch/arm/configs/csb337_defconfig
@@ -615,7 +615,7 @@ #
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-CONFIG_AT91_WATCHDOG=y
+CONFIG_AT91RM9200_WATCHDOG=y
 
 #
 # USB-based Watchdog Cards
diff --git a/arch/arm/configs/csb637_defconfig b/arch/arm/configs/csb637_defconfig
index 2a1ac6c..df8595a 100644
--- a/arch/arm/configs/csb637_defconfig
+++ b/arch/arm/configs/csb637_defconfig
@@ -615,7 +615,7 @@ #
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-CONFIG_AT91_WATCHDOG=y
+CONFIG_AT91RM9200_WATCHDOG=y
 
 #
 # USB-based Watchdog Cards
diff --git a/arch/arm/configs/kafa_defconfig b/arch/arm/configs/kafa_defconfig
index 54fcd75..a4cdafc 100644
--- a/arch/arm/configs/kafa_defconfig
+++ b/arch/arm/configs/kafa_defconfig
@@ -560,7 +560,7 @@ #
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-CONFIG_AT91_WATCHDOG=y
+CONFIG_AT91RM9200_WATCHDOG=y
 # CONFIG_NVRAM is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
diff --git a/arch/arm/configs/onearm_defconfig b/arch/arm/configs/onearm_defconfig
index cb1d94f..9b9f215 100644
--- a/arch/arm/configs/onearm_defconfig
+++ b/arch/arm/configs/onearm_defconfig
@@ -607,7 +607,7 @@ #
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-CONFIG_AT91_WATCHDOG=y
+CONFIG_AT91RM9200_WATCHDOG=y
 
 #
 # USB-based Watchdog Cards
diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
index 89e46d6..0187b11 100644
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -13,7 +13,7 @@ config WATCHDOG
 	  subsequently opening the file and then failing to write to it for
 	  longer than 1 minute will result in rebooting the machine. This
 	  could be useful for a networked machine that needs to come back
-	  online as fast as possible after a lock-up. There's both a watchdog
+	  on-line as fast as possible after a lock-up. There's both a watchdog
 	  implementation entirely in software (which can sometimes fail to
 	  reboot the machine) and a driver for hardware watchdog boards, which
 	  are more robust and can also keep track of the temperature inside
@@ -60,7 +60,7 @@ config SOFT_WATCHDOG
 
 # ARM Architecture
 
-config AT91_WATCHDOG
+config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
 	depends on WATCHDOG && ARCH_AT91RM9200
 	help
@@ -71,7 +71,7 @@ config 21285_WATCHDOG
 	tristate "DC21285 watchdog"
 	depends on WATCHDOG && FOOTBRIDGE
 	help
-	  The Intel Footbridge chip contains a builtin watchdog circuit. Say Y
+	  The Intel Footbridge chip contains a built-in watchdog circuit. Say Y
 	  here if you wish to use this. Alternatively say M to compile the
 	  driver as a module, which will be called wdt285.
 
@@ -269,11 +269,11 @@ config IB700_WDT
 	  Most people will say N.
 
 config IBMASR
-        tristate "IBM Automatic Server Restart"
-        depends on WATCHDOG && X86
-        help
+	tristate "IBM Automatic Server Restart"
+	depends on WATCHDOG && X86
+	help
 	  This is the driver for the IBM Automatic Server Restart watchdog
-	  timer builtin into some eServer xSeries machines.
+	  timer built-in into some eServer xSeries machines.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ibmasr.
@@ -316,13 +316,16 @@ config I8XX_TCO
 	  To compile this driver as a module, choose M here: the
 	  module will be called i8xx_tco.
 
+	  Note: This driver will be removed in the near future. Please
+	  use the Intel TCO Timer/Watchdog driver.
+
 config ITCO_WDT
-	tristate "Intel TCO Timer/Watchdog (EXPERIMENTAL)"
-	depends on WATCHDOG && (X86 || IA64) && PCI && EXPERIMENTAL
+	tristate "Intel TCO Timer/Watchdog"
+	depends on WATCHDOG && (X86 || IA64) && PCI
 	---help---
 	  Hardware driver for the intel TCO timer based watchdog devices.
 	  These drivers are included in the Intel 82801 I/O Controller
-	  Hub family 'from ICH0 up to ICH7) and in the Intel 6300ESB
+	  Hub family (from ICH0 up to ICH8) and in the Intel 6300ESB
 	  controller hub.
 
 	  The TCO (Total Cost of Ownership) timer is a watchdog timer
@@ -395,6 +398,26 @@ config CPU5_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called cpu5wdt.
 
+config SMSC37B787_WDT
+	tristate "Winbond SMsC37B787 Watchdog Timer"
+	depends on WATCHDOG && X86
+	---help---
+	  This is the driver for the hardware watchdog component on the
+	  Winbond SMsC37B787 chipset as used on the NetRunner Mainboard
+	  from Vision Systems and maybe others.
+
+	  This watchdog simply watches your kernel to make sure it doesn't
+	  freeze, and if it does, it reboots your computer after a certain
+	  amount of time.
+
+	  Usually a userspace daemon will notify the kernel WDT driver that
+	  userspace is still alive, at regular intervals.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called smsc37b787_wdt.
+
+	  Most people will say N.
+
 config W83627HF_WDT
 	tristate "W83627HF Watchdog Timer"
 	depends on WATCHDOG && X86
@@ -410,6 +433,21 @@ config W83627HF_WDT
 
 	  Most people will say N.
 
+config W83697HF_WDT
+	tristate "W83697HF/W83697HG Watchdog Timer"
+	depends on WATCHDOG && X86
+	---help---
+	  This is the driver for the hardware watchdog on the W83697HF/HG
+	  chipset as used in Dedibox/VIA motherboards (and likely others).
+	  This watchdog simply watches your kernel to make sure it doesn't
+	  freeze, and if it does, it reboots your computer after a certain
+	  amount of time.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called w83697hf_wdt.
+
+	  Most people will say N.
+
 config W83877F_WDT
 	tristate "W83877F (EMACS) Watchdog Timer"
 	depends on WATCHDOG && X86
@@ -443,7 +481,7 @@ config MACHZ_WDT
 	depends on WATCHDOG && X86
 	---help---
 	  If you are using a ZF Micro MachZ processor, say Y here, otherwise
-	  N.  This is the driver for the watchdog timer builtin on that
+	  N.  This is the driver for the watchdog timer built-in on that
 	  processor using ZF-Logic interface.  This watchdog simply watches
 	  your kernel to make sure it doesn't freeze, and if it does, it
 	  reboots your computer after a certain amount of time.
@@ -472,7 +510,6 @@ config SBC_EPX_C3_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called sbc_epx_c3.
 
-
 # PowerPC Architecture
 
 config 8xx_WDT
@@ -502,7 +539,7 @@ config WATCHDOG_RTAS
 	help
 	  This driver adds watchdog support for the RTAS watchdog.
 
-          To compile this driver as a module, choose M here. The module
+	  To compile this driver as a module, choose M here. The module
 	  will be called wdrtas.
 
 # MIPS Architecture
@@ -556,7 +593,7 @@ config SH_WDT_MMAP
 	help
 	  If you say Y here, user applications will be able to mmap the
 	  WDT/CPG registers.
-#
+
 # SPARC64 Architecture
 
 config WATCHDOG_CP1XXX
diff --git a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
index 7f70aba..3644049 100644
--- a/drivers/char/watchdog/Makefile
+++ b/drivers/char/watchdog/Makefile
@@ -23,7 +23,7 @@ # USB-based Watchdog Cards
 obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
 
 # ARM Architecture
-obj-$(CONFIG_AT91_WATCHDOG) += at91_wdt.o
+obj-$(CONFIG_AT91RM9200_WATCHDOG) += at91rm9200_wdt.o
 obj-$(CONFIG_OMAP_WATCHDOG) += omap_wdt.o
 obj-$(CONFIG_21285_WATCHDOG) += wdt285.o
 obj-$(CONFIG_977_WATCHDOG) += wdt977.o
@@ -53,7 +53,9 @@ obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
 obj-$(CONFIG_60XX_WDT) += sbc60xxwdt.o
 obj-$(CONFIG_SBC8360_WDT) += sbc8360.o
 obj-$(CONFIG_CPU5_WDT) += cpu5wdt.o
+obj-$(CONFIG_SMSC37B787_WDT) += smsc37b787_wdt.o
 obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
+obj-$(CONFIG_W83697HF_WDT) += w83697hf_wdt.o
 obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
 obj-$(CONFIG_W83977F_WDT) += w83977f_wdt.o
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
diff --git a/drivers/char/watchdog/at91_wdt.c b/drivers/char/watchdog/at91_wdt.c
deleted file mode 100644
index 4e7a114..0000000
--- a/drivers/char/watchdog/at91_wdt.c
+++ /dev/null
@@ -1,287 +0,0 @@
-/*
- * Watchdog driver for Atmel AT91RM9200 (Thunder)
- *
- *  Copyright (C) 2003 SAN People (Pty) Ltd
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/miscdevice.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/platform_device.h>
-#include <linux/types.h>
-#include <linux/watchdog.h>
-#include <asm/bitops.h>
-#include <asm/uaccess.h>
-
-
-#define WDT_DEFAULT_TIME	5	/* seconds */
-#define WDT_MAX_TIME		256	/* seconds */
-
-static int wdt_time = WDT_DEFAULT_TIME;
-static int nowayout = WATCHDOG_NOWAYOUT;
-
-module_param(wdt_time, int, 0);
-MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="__MODULE_STRING(WDT_DEFAULT_TIME) ")");
-
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-module_param(nowayout, int, 0);
-MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-#endif
-
-
-static unsigned long at91wdt_busy;
-
-/* ......................................................................... */
-
-/*
- * Disable the watchdog.
- */
-static void inline at91_wdt_stop(void)
-{
-	at91_sys_write(AT91_ST_WDMR, AT91_ST_EXTEN);
-}
-
-/*
- * Enable and reset the watchdog.
- */
-static void inline at91_wdt_start(void)
-{
-	at91_sys_write(AT91_ST_WDMR, AT91_ST_EXTEN | AT91_ST_RSTEN | (((65536 * wdt_time) >> 8) & AT91_ST_WDV));
-	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
-}
-
-/*
- * Reload the watchdog timer.  (ie, pat the watchdog)
- */
-static void inline at91_wdt_reload(void)
-{
-	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
-}
-
-/* ......................................................................... */
-
-/*
- * Watchdog device is opened, and watchdog starts running.
- */
-static int at91_wdt_open(struct inode *inode, struct file *file)
-{
-	if (test_and_set_bit(0, &at91wdt_busy))
-		return -EBUSY;
-
-	at91_wdt_start();
-	return nonseekable_open(inode, file);
-}
-
-/*
- * Close the watchdog device.
- * If CONFIG_WATCHDOG_NOWAYOUT is NOT defined then the watchdog is also
- *  disabled.
- */
-static int at91_wdt_close(struct inode *inode, struct file *file)
-{
-	if (!nowayout)
-		at91_wdt_stop();	/* Disable the watchdog when file is closed */
-
-	clear_bit(0, &at91wdt_busy);
-	return 0;
-}
-
-/*
- * Change the watchdog time interval.
- */
-static int at91_wdt_settimeout(int new_time)
-{
-	/*
-	 * All counting occurs at SLOW_CLOCK / 128 = 0.256 Hz
-	 *
-	 * Since WDV is a 16-bit counter, the maximum period is
-	 * 65536 / 0.256 = 256 seconds.
-	 */
-	if ((new_time <= 0) || (new_time > WDT_MAX_TIME))
-		return -EINVAL;
-
-	/* Set new watchdog time. It will be used when at91_wdt_start() is called. */
-	wdt_time = new_time;
-	return 0;
-}
-
-static struct watchdog_info at91_wdt_info = {
-	.identity	= "at91 watchdog",
-	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
-};
-
-/*
- * Handle commands from user-space.
- */
-static int at91_wdt_ioctl(struct inode *inode, struct file *file,
-		unsigned int cmd, unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	int __user *p = argp;
-	int new_value;
-
-	switch(cmd) {
-		case WDIOC_KEEPALIVE:
-			at91_wdt_reload();	/* pat the watchdog */
-			return 0;
-
-		case WDIOC_GETSUPPORT:
-			return copy_to_user(argp, &at91_wdt_info, sizeof(at91_wdt_info)) ? -EFAULT : 0;
-
-		case WDIOC_SETTIMEOUT:
-			if (get_user(new_value, p))
-				return -EFAULT;
-
-			if (at91_wdt_settimeout(new_value))
-				return -EINVAL;
-
-			/* Enable new time value */
-			at91_wdt_start();
-
-			/* Return current value */
-			return put_user(wdt_time, p);
-
-		case WDIOC_GETTIMEOUT:
-			return put_user(wdt_time, p);
-
-		case WDIOC_GETSTATUS:
-		case WDIOC_GETBOOTSTATUS:
-			return put_user(0, p);
-
-		case WDIOC_SETOPTIONS:
-			if (get_user(new_value, p))
-				return -EFAULT;
-
-			if (new_value & WDIOS_DISABLECARD)
-				at91_wdt_stop();
-			if (new_value & WDIOS_ENABLECARD)
-				at91_wdt_start();
-			return 0;
-
-		default:
-			return -ENOTTY;
-	}
-}
-
-/*
- * Pat the watchdog whenever device is written to.
- */
-static ssize_t at91_wdt_write(struct file *file, const char *data, size_t len, loff_t *ppos)
-{
-	at91_wdt_reload();		/* pat the watchdog */
-	return len;
-}
-
-/* ......................................................................... */
-
-static const struct file_operations at91wdt_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.ioctl		= at91_wdt_ioctl,
-	.open		= at91_wdt_open,
-	.release	= at91_wdt_close,
-	.write		= at91_wdt_write,
-};
-
-static struct miscdevice at91wdt_miscdev = {
-	.minor		= WATCHDOG_MINOR,
-	.name		= "watchdog",
-	.fops		= &at91wdt_fops,
-};
-
-static int __init at91wdt_probe(struct platform_device *pdev)
-{
-	int res;
-
-	if (at91wdt_miscdev.dev)
-		return -EBUSY;
-	at91wdt_miscdev.dev = &pdev->dev;
-
-	res = misc_register(&at91wdt_miscdev);
-	if (res)
-		return res;
-
-	printk("AT91 Watchdog Timer enabled (%d seconds%s)\n", wdt_time, nowayout ? ", nowayout" : "");
-	return 0;
-}
-
-static int __exit at91wdt_remove(struct platform_device *pdev)
-{
-	int res;
-
-	res = misc_deregister(&at91wdt_miscdev);
-	if (!res)
-		at91wdt_miscdev.dev = NULL;
-
-	return res;
-}
-
-static void at91wdt_shutdown(struct platform_device *pdev)
-{
-	at91_wdt_stop();
-}
-
-#ifdef CONFIG_PM
-
-static int at91wdt_suspend(struct platform_device *pdev, pm_message_t message)
-{
-	at91_wdt_stop();
-	return 0;
-}
-
-static int at91wdt_resume(struct platform_device *pdev)
-{
-	if (at91wdt_busy)
-		at91_wdt_start();
-		return 0;
-}
-
-#else
-#define at91wdt_suspend NULL
-#define at91wdt_resume	NULL
-#endif
-
-static struct platform_driver at91wdt_driver = {
-	.probe		= at91wdt_probe,
-	.remove		= __exit_p(at91wdt_remove),
-	.shutdown	= at91wdt_shutdown,
-	.suspend	= at91wdt_suspend,
-	.resume		= at91wdt_resume,
-	.driver		= {
-		.name	= "at91_wdt",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __init at91_wdt_init(void)
-{
-	/* Check that the heartbeat value is within range; if not reset to the default */
-	if (at91_wdt_settimeout(wdt_time)) {
-		at91_wdt_settimeout(WDT_DEFAULT_TIME);
-		pr_info("at91_wdt: wdt_time value must be 1 <= wdt_time <= 256, using %d\n", wdt_time);
-	}
-
-	return platform_driver_register(&at91wdt_driver);
-}
-
-static void __exit at91_wdt_exit(void)
-{
-	platform_driver_unregister(&at91wdt_driver);
-}
-
-module_init(at91_wdt_init);
-module_exit(at91_wdt_exit);
-
-MODULE_AUTHOR("Andrew Victor");
-MODULE_DESCRIPTION("Watchdog driver for Atmel AT91RM9200");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff --git a/drivers/char/watchdog/at91rm9200_wdt.c b/drivers/char/watchdog/at91rm9200_wdt.c
new file mode 100644
index 0000000..4e7a114
--- /dev/null
+++ b/drivers/char/watchdog/at91rm9200_wdt.c
@@ -0,0 +1,287 @@
+/*
+ * Watchdog driver for Atmel AT91RM9200 (Thunder)
+ *
+ *  Copyright (C) 2003 SAN People (Pty) Ltd
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+#include <asm/bitops.h>
+#include <asm/uaccess.h>
+
+
+#define WDT_DEFAULT_TIME	5	/* seconds */
+#define WDT_MAX_TIME		256	/* seconds */
+
+static int wdt_time = WDT_DEFAULT_TIME;
+static int nowayout = WATCHDOG_NOWAYOUT;
+
+module_param(wdt_time, int, 0);
+MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="__MODULE_STRING(WDT_DEFAULT_TIME) ")");
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+#endif
+
+
+static unsigned long at91wdt_busy;
+
+/* ......................................................................... */
+
+/*
+ * Disable the watchdog.
+ */
+static void inline at91_wdt_stop(void)
+{
+	at91_sys_write(AT91_ST_WDMR, AT91_ST_EXTEN);
+}
+
+/*
+ * Enable and reset the watchdog.
+ */
+static void inline at91_wdt_start(void)
+{
+	at91_sys_write(AT91_ST_WDMR, AT91_ST_EXTEN | AT91_ST_RSTEN | (((65536 * wdt_time) >> 8) & AT91_ST_WDV));
+	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
+}
+
+/*
+ * Reload the watchdog timer.  (ie, pat the watchdog)
+ */
+static void inline at91_wdt_reload(void)
+{
+	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
+}
+
+/* ......................................................................... */
+
+/*
+ * Watchdog device is opened, and watchdog starts running.
+ */
+static int at91_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(0, &at91wdt_busy))
+		return -EBUSY;
+
+	at91_wdt_start();
+	return nonseekable_open(inode, file);
+}
+
+/*
+ * Close the watchdog device.
+ * If CONFIG_WATCHDOG_NOWAYOUT is NOT defined then the watchdog is also
+ *  disabled.
+ */
+static int at91_wdt_close(struct inode *inode, struct file *file)
+{
+	if (!nowayout)
+		at91_wdt_stop();	/* Disable the watchdog when file is closed */
+
+	clear_bit(0, &at91wdt_busy);
+	return 0;
+}
+
+/*
+ * Change the watchdog time interval.
+ */
+static int at91_wdt_settimeout(int new_time)
+{
+	/*
+	 * All counting occurs at SLOW_CLOCK / 128 = 0.256 Hz
+	 *
+	 * Since WDV is a 16-bit counter, the maximum period is
+	 * 65536 / 0.256 = 256 seconds.
+	 */
+	if ((new_time <= 0) || (new_time > WDT_MAX_TIME))
+		return -EINVAL;
+
+	/* Set new watchdog time. It will be used when at91_wdt_start() is called. */
+	wdt_time = new_time;
+	return 0;
+}
+
+static struct watchdog_info at91_wdt_info = {
+	.identity	= "at91 watchdog",
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+};
+
+/*
+ * Handle commands from user-space.
+ */
+static int at91_wdt_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	int new_value;
+
+	switch(cmd) {
+		case WDIOC_KEEPALIVE:
+			at91_wdt_reload();	/* pat the watchdog */
+			return 0;
+
+		case WDIOC_GETSUPPORT:
+			return copy_to_user(argp, &at91_wdt_info, sizeof(at91_wdt_info)) ? -EFAULT : 0;
+
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_value, p))
+				return -EFAULT;
+
+			if (at91_wdt_settimeout(new_value))
+				return -EINVAL;
+
+			/* Enable new time value */
+			at91_wdt_start();
+
+			/* Return current value */
+			return put_user(wdt_time, p);
+
+		case WDIOC_GETTIMEOUT:
+			return put_user(wdt_time, p);
+
+		case WDIOC_GETSTATUS:
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(0, p);
+
+		case WDIOC_SETOPTIONS:
+			if (get_user(new_value, p))
+				return -EFAULT;
+
+			if (new_value & WDIOS_DISABLECARD)
+				at91_wdt_stop();
+			if (new_value & WDIOS_ENABLECARD)
+				at91_wdt_start();
+			return 0;
+
+		default:
+			return -ENOTTY;
+	}
+}
+
+/*
+ * Pat the watchdog whenever device is written to.
+ */
+static ssize_t at91_wdt_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+{
+	at91_wdt_reload();		/* pat the watchdog */
+	return len;
+}
+
+/* ......................................................................... */
+
+static const struct file_operations at91wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= at91_wdt_ioctl,
+	.open		= at91_wdt_open,
+	.release	= at91_wdt_close,
+	.write		= at91_wdt_write,
+};
+
+static struct miscdevice at91wdt_miscdev = {
+	.minor		= WATCHDOG_MINOR,
+	.name		= "watchdog",
+	.fops		= &at91wdt_fops,
+};
+
+static int __init at91wdt_probe(struct platform_device *pdev)
+{
+	int res;
+
+	if (at91wdt_miscdev.dev)
+		return -EBUSY;
+	at91wdt_miscdev.dev = &pdev->dev;
+
+	res = misc_register(&at91wdt_miscdev);
+	if (res)
+		return res;
+
+	printk("AT91 Watchdog Timer enabled (%d seconds%s)\n", wdt_time, nowayout ? ", nowayout" : "");
+	return 0;
+}
+
+static int __exit at91wdt_remove(struct platform_device *pdev)
+{
+	int res;
+
+	res = misc_deregister(&at91wdt_miscdev);
+	if (!res)
+		at91wdt_miscdev.dev = NULL;
+
+	return res;
+}
+
+static void at91wdt_shutdown(struct platform_device *pdev)
+{
+	at91_wdt_stop();
+}
+
+#ifdef CONFIG_PM
+
+static int at91wdt_suspend(struct platform_device *pdev, pm_message_t message)
+{
+	at91_wdt_stop();
+	return 0;
+}
+
+static int at91wdt_resume(struct platform_device *pdev)
+{
+	if (at91wdt_busy)
+		at91_wdt_start();
+		return 0;
+}
+
+#else
+#define at91wdt_suspend NULL
+#define at91wdt_resume	NULL
+#endif
+
+static struct platform_driver at91wdt_driver = {
+	.probe		= at91wdt_probe,
+	.remove		= __exit_p(at91wdt_remove),
+	.shutdown	= at91wdt_shutdown,
+	.suspend	= at91wdt_suspend,
+	.resume		= at91wdt_resume,
+	.driver		= {
+		.name	= "at91_wdt",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init at91_wdt_init(void)
+{
+	/* Check that the heartbeat value is within range; if not reset to the default */
+	if (at91_wdt_settimeout(wdt_time)) {
+		at91_wdt_settimeout(WDT_DEFAULT_TIME);
+		pr_info("at91_wdt: wdt_time value must be 1 <= wdt_time <= 256, using %d\n", wdt_time);
+	}
+
+	return platform_driver_register(&at91wdt_driver);
+}
+
+static void __exit at91_wdt_exit(void)
+{
+	platform_driver_unregister(&at91wdt_driver);
+}
+
+module_init(at91_wdt_init);
+module_exit(at91_wdt_exit);
+
+MODULE_AUTHOR("Andrew Victor");
+MODULE_DESCRIPTION("Watchdog driver for Atmel AT91RM9200");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff --git a/drivers/char/watchdog/iTCO_wdt.c b/drivers/char/watchdog/iTCO_wdt.c
index aaac94d..b6f29cb 100644
--- a/drivers/char/watchdog/iTCO_wdt.c
+++ b/drivers/char/watchdog/iTCO_wdt.c
@@ -35,6 +35,10 @@
  *	82801GDH (ICH7DH)    : document number 307013-002, 307014-009,
  *	82801GBM (ICH7-M)    : document number 307013-002, 307014-009,
  *	82801GHM (ICH7-M DH) : document number 307013-002, 307014-009,
+ *	82801HB  (ICH8)      : document number 313056-002, 313057-004,
+ *	82801HR  (ICH8R)     : document number 313056-002, 313057-004,
+ *	82801HH  (ICH8DH)    : document number 313056-002, 313057-004,
+ *	82801HO  (ICH8DO)    : document number 313056-002, 313057-004,
  *	6300ESB  (6300ESB)   : document number 300641-003
  */
 
@@ -45,7 +49,7 @@
 /* Module and version information */
 #define DRV_NAME        "iTCO_wdt"
 #define DRV_VERSION     "1.00"
-#define DRV_RELDATE     "30-Jul-2006"
+#define DRV_RELDATE     "08-Oct-2006"
 #define PFX		DRV_NAME ": "
 
 /* Includes */
@@ -85,6 +89,9 @@ enum iTCO_chipsets {
 	TCO_ICH7,	/* ICH7 & ICH7R */
 	TCO_ICH7M,	/* ICH7-M */
 	TCO_ICH7MDH,	/* ICH7-M DH */
+	TCO_ICH8,	/* ICH8 & ICH8R */
+	TCO_ICH8DH,	/* ICH8DH */
+	TCO_ICH8DO,	/* ICH8DO */
 };
 
 static struct {
@@ -108,6 +115,9 @@ static struct {
 	{"ICH7 or ICH7R", 2},
 	{"ICH7-M", 2},
 	{"ICH7-M DH", 2},
+	{"ICH8 or ICH8R", 2},
+	{"ICH8DH", 2},
+	{"ICH8DO", 2},
 	{NULL,0}
 };
 
@@ -135,6 +145,9 @@ static struct pci_device_id iTCO_wdt_pci
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, TCO_ICH7    },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_1,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, TCO_ICH7M   },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_31,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, TCO_ICH7MDH },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_0,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, TCO_ICH8    },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_2,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, TCO_ICH8DH  },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_3,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, TCO_ICH8DO  },
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE (pci, iTCO_wdt_pci_tbl);
@@ -355,7 +368,8 @@ static int iTCO_wdt_get_timeleft (int *t
 		spin_unlock(&iTCO_wdt_private.io_lock);
 
 		*time_left = (val8 * 6) / 10;
-	}
+	} else
+		return -EINVAL;
 	return 0;
 }
 
@@ -426,7 +440,6 @@ static int iTCO_wdt_ioctl (struct inode 
 {
 	int new_options, retval = -EINVAL;
 	int new_heartbeat;
-	int time_left;
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
 	static struct watchdog_info ident = {
@@ -486,6 +499,8 @@ static int iTCO_wdt_ioctl (struct inode 
 
 		case WDIOC_GETTIMELEFT:
 		{
+			int time_left;
+
 			if (iTCO_wdt_get_timeleft(&time_left))
 				return -EINVAL;
 
diff --git a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
index 68b1ca9..18cb050 100644
--- a/drivers/char/watchdog/s3c2410_wdt.c
+++ b/drivers/char/watchdog/s3c2410_wdt.c
@@ -380,18 +380,21 @@ static int s3c2410wdt_probe(struct platf
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res == NULL) {
 		printk(KERN_INFO PFX "failed to get irq resource\n");
+		iounmap(wdt_base);
 		return -ENOENT;
 	}
 
 	ret = request_irq(res->start, s3c2410wdt_irq, 0, pdev->name, pdev);
 	if (ret != 0) {
 		printk(KERN_INFO PFX "failed to install irq (%d)\n", ret);
+		iounmap(wdt_base);
 		return ret;
 	}
 
 	wdt_clock = clk_get(&pdev->dev, "watchdog");
 	if (wdt_clock == NULL) {
 		printk(KERN_INFO PFX "failed to find watchdog clock source\n");
+		iounmap(wdt_base);
 		return -ENOENT;
 	}
 
@@ -415,6 +418,7 @@ static int s3c2410wdt_probe(struct platf
 	if (ret) {
 		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (%d)\n",
 			WATCHDOG_MINOR, ret);
+		iounmap(wdt_base);
 		return ret;
 	}
 
@@ -451,6 +455,7 @@ static int s3c2410wdt_remove(struct plat
 		wdt_clock = NULL;
 	}
 
+	iounmap(wdt_base);
 	misc_deregister(&s3c2410wdt_miscdev);
 	return 0;
 }
diff --git a/drivers/char/watchdog/smsc37b787_wdt.c b/drivers/char/watchdog/smsc37b787_wdt.c
new file mode 100644
index 0000000..9f56913
--- /dev/null
+++ b/drivers/char/watchdog/smsc37b787_wdt.c
@@ -0,0 +1,627 @@
+/*
+ *	SMsC 37B787 Watchdog Timer driver for Linux 2.6.x.x
+ *
+ *      Based on acquirewdt.c by Alan Cox <alan@redhat.com>
+ *       and some other existing drivers
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	The authors do NOT admit liability nor provide warranty for
+ *	any of this software. This material is provided "AS-IS" in
+ *      the hope that it may be useful for others.
+ *
+ *	(C) Copyright 2003-2006  Sven Anders <anders@anduras.de>
+ *
+ *  History:
+ *	2003 - Created version 1.0 for Linux 2.4.x.
+ *	2006 - Ported to Linux 2.6, added nowayout and MAGICCLOSE
+ *             features. Released version 1.1
+ *
+ *  Theory of operation:
+ *
+ *      A Watchdog Timer (WDT) is a hardware circuit that can
+ *      reset the computer system in case of a software fault.
+ *      You probably knew that already.
+ *
+ *      Usually a userspace daemon will notify the kernel WDT driver
+ *      via the /dev/watchdog special device file that userspace is
+ *      still alive, at regular intervals.  When such a notification
+ *      occurs, the driver will usually tell the hardware watchdog
+ *      that everything is in order, and that the watchdog should wait
+ *      for yet another little while to reset the system.
+ *      If userspace fails (RAM error, kernel bug, whatever), the
+ *      notifications cease to occur, and the hardware watchdog will
+ *      reset the system (causing a reboot) after the timeout occurs.
+ *
+ * Create device with:
+ *  mknod /dev/watchdog c 10 130
+ *
+ * For an example userspace keep-alive daemon, see:
+ *   Documentation/watchdog/watchdog.txt
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/ioport.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+/* enable support for minutes as units? */
+/* (does not always work correctly, so disabled by default!) */
+#define SMSC_SUPPORT_MINUTES
+#undef SMSC_SUPPORT_MINUTES
+
+#define MAX_TIMEOUT     255
+
+#define UNIT_SECOND     0
+#define UNIT_MINUTE     1
+
+#define MODNAME		"smsc37b787_wdt: "
+#define VERSION         "1.1"
+
+#define IOPORT          0x3F0
+#define IOPORT_SIZE     2
+#define IODEV_NO        8
+
+static int unit = UNIT_SECOND;  /* timer's unit */
+static int timeout = 60;        /* timeout value: default is 60 "units" */
+static unsigned long timer_enabled = 0;   /* is the timer enabled? */
+
+static char expect_close;       /* is the close expected? */
+
+static spinlock_t io_lock;	/* to guard the watchdog from io races */
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+
+/* -- Low level function ----------------------------------------*/
+
+/* unlock the IO chip */
+
+static inline void open_io_config(void)
+{
+        outb(0x55, IOPORT);
+	mdelay(1);
+        outb(0x55, IOPORT);
+}
+
+/* lock the IO chip */
+static inline void close_io_config(void)
+{
+        outb(0xAA, IOPORT);
+}
+
+/* select the IO device */
+static inline void select_io_device(unsigned char devno)
+{
+        outb(0x07, IOPORT);
+        outb(devno, IOPORT+1);
+}
+
+/* write to the control register */
+static inline void write_io_cr(unsigned char reg, unsigned char data)
+{
+        outb(reg, IOPORT);
+        outb(data, IOPORT+1);
+}
+
+/* read from the control register */
+static inline char read_io_cr(unsigned char reg)
+{
+        outb(reg, IOPORT);
+        return inb(IOPORT+1);
+}
+
+/* -- Medium level functions ------------------------------------*/
+
+static inline void gpio_bit12(unsigned char reg)
+{
+	// -- General Purpose I/O Bit 1.2 --
+	// Bit 0,   In/Out: 0 = Output, 1 = Input
+	// Bit 1,   Polarity: 0 = No Invert, 1 = Invert
+	// Bit 2,   Group Enable Intr.: 0 = Disable, 1 = Enable
+	// Bit 3/4, Function select: 00 = GPI/O, 01 = WDT, 10 = P17,
+	//                           11 = Either Edge Triggered Intr. 2
+        // Bit 5/6  (Reserved)
+	// Bit 7,   Output Type: 0 = Push Pull Bit, 1 = Open Drain
+        write_io_cr(0xE2, reg);
+}
+
+static inline void gpio_bit13(unsigned char reg)
+{
+	// -- General Purpose I/O Bit 1.3 --
+	// Bit 0,  In/Out: 0 = Output, 1 = Input
+	// Bit 1,  Polarity: 0 = No Invert, 1 = Invert
+	// Bit 2,  Group Enable Intr.: 0 = Disable, 1 = Enable
+	// Bit 3,  Function select: 0 = GPI/O, 1 = LED
+        // Bit 4-6 (Reserved)
+	// Bit 7,  Output Type: 0 = Push Pull Bit, 1 = Open Drain
+        write_io_cr(0xE3, reg);
+}
+
+static inline void wdt_timer_units(unsigned char new_units)
+{
+	// -- Watchdog timer units --
+	// Bit 0-6 (Reserved)
+	// Bit 7,  WDT Time-out Value Units Select
+	//         (0 = Minutes, 1 = Seconds)
+        write_io_cr(0xF1, new_units);
+}
+
+static inline void wdt_timeout_value(unsigned char new_timeout)
+{
+	// -- Watchdog Timer Time-out Value --
+	// Bit 0-7 Binary coded units (0=Disabled, 1..255)
+        write_io_cr(0xF2, new_timeout);
+}
+
+static inline void wdt_timer_conf(unsigned char conf)
+{
+	// -- Watchdog timer configuration --
+	// Bit 0   Joystick enable: 0* = No Reset, 1 = Reset WDT upon Gameport I/O
+	// Bit 1   Keyboard enable: 0* = No Reset, 1 = Reset WDT upon KBD Intr.
+	// Bit 2   Mouse enable: 0* = No Reset, 1 = Reset WDT upon Mouse Intr.
+        // Bit 3   Reset the timer
+        //         (Wrong in SMsC documentation? Given as: PowerLED Timout Enabled)
+	// Bit 4-7 WDT Interrupt Mapping: (0000* = Disabled,
+	//            0001=IRQ1, 0010=(Invalid), 0011=IRQ3 to 1111=IRQ15)
+        write_io_cr(0xF3, conf);
+}
+
+static inline void wdt_timer_ctrl(unsigned char reg)
+{
+	// -- Watchdog timer control --
+	// Bit 0   Status Bit: 0 = Timer counting, 1 = Timeout occured
+	// Bit 1   Power LED Toggle: 0 = Disable Toggle, 1 = Toggle at 1 Hz
+	// Bit 2   Force Timeout: 1 = Forces WD timeout event (self-cleaning)
+	// Bit 3   P20 Force Timeout enabled:
+	//          0 = P20 activity does not generate the WD timeout event
+	//          1 = P20 Allows rising edge of P20, from the keyboard
+	//              controller, to force the WD timeout event.
+	// Bit 4   (Reserved)
+	// -- Soft power management --
+	// Bit 5   Stop Counter: 1 = Stop software power down counter
+	//            set via register 0xB8, (self-cleaning)
+	//            (Upon read: 0 = Counter running, 1 = Counter stopped)
+	// Bit 6   Restart Counter: 1 = Restart software power down counter
+	//            set via register 0xB8, (self-cleaning)
+	// Bit 7   SPOFF: 1 = Force software power down (self-cleaning)
+
+        write_io_cr(0xF4, reg);
+}
+
+/* -- Higher level functions ------------------------------------*/
+
+/* initialize watchdog */
+
+static void wb_smsc_wdt_initialize(void)
+{
+        unsigned char old;
+
+	spin_lock(&io_lock);
+        open_io_config();
+        select_io_device(IODEV_NO);
+
+	// enable the watchdog
+	gpio_bit13(0x08);  // Select pin 80 = LED not GPIO
+	gpio_bit12(0x0A);  // Set pin 79 = WDT not GPIO/Output/Polarity=Invert
+
+	// disable the timeout
+        wdt_timeout_value(0);
+
+	// reset control register
+        wdt_timer_ctrl(0x00);
+
+	// reset configuration register
+	wdt_timer_conf(0x00);
+
+	// read old (timer units) register
+        old = read_io_cr(0xF1) & 0x7F;
+        if (unit == UNIT_SECOND) old |= 0x80; // set to seconds
+
+	// set the watchdog timer units
+        wdt_timer_units(old);
+
+        close_io_config();
+	spin_unlock(&io_lock);
+}
+
+/* shutdown the watchdog */
+
+static void wb_smsc_wdt_shutdown(void)
+{
+	spin_lock(&io_lock);
+        open_io_config();
+        select_io_device(IODEV_NO);
+
+	// disable the watchdog
+        gpio_bit13(0x09);
+        gpio_bit12(0x09);
+
+	// reset watchdog config register
+	wdt_timer_conf(0x00);
+
+	// reset watchdog control register
+        wdt_timer_ctrl(0x00);
+
+	// disable timeout
+        wdt_timeout_value(0x00);
+
+        close_io_config();
+	spin_unlock(&io_lock);
+}
+
+/* set timeout => enable watchdog */
+
+static void wb_smsc_wdt_set_timeout(unsigned char new_timeout)
+{
+	spin_lock(&io_lock);
+        open_io_config();
+        select_io_device(IODEV_NO);
+
+	// set Power LED to blink, if we enable the timeout
+        wdt_timer_ctrl((new_timeout == 0) ? 0x00 : 0x02);
+
+	// set timeout value
+        wdt_timeout_value(new_timeout);
+
+        close_io_config();
+	spin_unlock(&io_lock);
+}
+
+/* get timeout */
+
+static unsigned char wb_smsc_wdt_get_timeout(void)
+{
+        unsigned char set_timeout;
+
+	spin_lock(&io_lock);
+        open_io_config();
+        select_io_device(IODEV_NO);
+        set_timeout = read_io_cr(0xF2);
+        close_io_config();
+	spin_unlock(&io_lock);
+
+        return set_timeout;
+}
+
+/* disable watchdog */
+
+static void wb_smsc_wdt_disable(void)
+{
+        // set the timeout to 0 to disable the watchdog
+        wb_smsc_wdt_set_timeout(0);
+}
+
+/* enable watchdog by setting the current timeout */
+
+static void wb_smsc_wdt_enable(void)
+{
+        // set the current timeout...
+        wb_smsc_wdt_set_timeout(timeout);
+}
+
+/* reset the timer */
+
+static void wb_smsc_wdt_reset_timer(void)
+{
+	spin_lock(&io_lock);
+        open_io_config();
+        select_io_device(IODEV_NO);
+
+	// reset the timer
+	wdt_timeout_value(timeout);
+	wdt_timer_conf(0x08);
+
+        close_io_config();
+	spin_unlock(&io_lock);
+}
+
+/* return, if the watchdog is enabled (timeout is set...) */
+
+static int wb_smsc_wdt_status(void)
+{
+	return (wb_smsc_wdt_get_timeout() == 0) ? 0 : WDIOF_KEEPALIVEPING;
+}
+
+
+/* -- File operations -------------------------------------------*/
+
+/* open => enable watchdog and set initial timeout */
+
+static int wb_smsc_wdt_open(struct inode *inode, struct file *file)
+{
+	/* /dev/watchdog can only be opened once */
+
+	if (test_and_set_bit(0, &timer_enabled))
+		return -EBUSY;
+
+	if (nowayout)
+		__module_get(THIS_MODULE);
+
+	/* Reload and activate timer */
+	wb_smsc_wdt_enable();
+
+	printk(KERN_INFO MODNAME "Watchdog enabled. Timeout set to %d %s.\n", timeout, (unit == UNIT_SECOND) ? "second(s)" : "minute(s)");
+
+	return nonseekable_open(inode, file);
+}
+
+/* close => shut off the timer */
+
+static int wb_smsc_wdt_release(struct inode *inode, struct file *file)
+{
+	/* Shut off the timer. */
+
+	if (expect_close == 42) {
+	        wb_smsc_wdt_disable();
+		printk(KERN_INFO MODNAME "Watchdog disabled, sleeping again...\n");
+	} else {
+		printk(KERN_CRIT MODNAME "Unexpected close, not stopping watchdog!\n");
+		wb_smsc_wdt_reset_timer();
+	}
+
+	clear_bit(0, &timer_enabled);
+	expect_close = 0;
+	return 0;
+}
+
+/* write => update the timer to keep the machine alive */
+
+static ssize_t wb_smsc_wdt_write(struct file *file, const char __user *data,
+				 size_t len, loff_t *ppos)
+{
+	/* See if we got the magic character 'V' and reload the timer */
+	if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			/* reset expect flag */
+			expect_close = 0;
+
+			/* scan to see whether or not we got the magic character */
+			for (i = 0; i != len; i++) {
+				char c;
+				if (get_user(c, data+i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 42;
+			}
+		}
+
+		/* someone wrote to us, we should reload the timer */
+		wb_smsc_wdt_reset_timer();
+	}
+	return len;
+}
+
+/* ioctl => control interface */
+
+static int wb_smsc_wdt_ioctl(struct inode *inode, struct file *file,
+			     unsigned int cmd, unsigned long arg)
+{
+	int new_timeout;
+
+	union {
+		struct watchdog_info __user *ident;
+		int __user *i;
+	} uarg;
+
+	static struct watchdog_info ident = {
+		.options = 		WDIOF_KEEPALIVEPING |
+		                        WDIOF_SETTIMEOUT |
+					WDIOF_MAGICCLOSE,
+		.firmware_version =	0,
+		.identity = 		"SMsC 37B787 Watchdog"
+	};
+
+	uarg.i = (int __user *)arg;
+
+	switch (cmd) {
+		default:
+			return -ENOTTY;
+
+		case WDIOC_GETSUPPORT:
+			return copy_to_user(uarg.ident, &ident,
+				sizeof(ident)) ? -EFAULT : 0;
+
+		case WDIOC_GETSTATUS:
+			return put_user(wb_smsc_wdt_status(), uarg.i);
+
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(0, uarg.i);
+
+		case WDIOC_KEEPALIVE:
+			wb_smsc_wdt_reset_timer();
+			return 0;
+
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_timeout, uarg.i))
+				return -EFAULT;
+
+			// the API states this is given in secs
+			if (unit == UNIT_MINUTE)
+			  new_timeout /= 60;
+
+			if (new_timeout < 0 || new_timeout > MAX_TIMEOUT)
+				return -EINVAL;
+
+			timeout = new_timeout;
+			wb_smsc_wdt_set_timeout(timeout);
+
+			// fall through and return the new timeout...
+
+		case WDIOC_GETTIMEOUT:
+
+		        new_timeout = timeout;
+
+			if (unit == UNIT_MINUTE)
+			  new_timeout *= 60;
+
+			return put_user(new_timeout, uarg.i);
+
+		case WDIOC_SETOPTIONS:
+		{
+			int options, retval = -EINVAL;
+
+			if (get_user(options, uarg.i))
+				return -EFAULT;
+
+			if (options & WDIOS_DISABLECARD) {
+				wb_smsc_wdt_disable();
+				retval = 0;
+			}
+
+			if (options & WDIOS_ENABLECARD) {
+				wb_smsc_wdt_enable();
+				retval = 0;
+			}
+
+			return retval;
+		}
+	}
+}
+
+/* -- Notifier funtions -----------------------------------------*/
+
+static int wb_smsc_wdt_notify_sys(struct notifier_block *this, unsigned long code, void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT)
+	{
+                // set timeout to 0, to avoid possible race-condition
+	        timeout = 0;
+		wb_smsc_wdt_disable();
+	}
+	return NOTIFY_DONE;
+}
+
+/* -- Module's structures ---------------------------------------*/
+
+static struct file_operations wb_smsc_wdt_fops =
+{
+	.owner          = THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= wb_smsc_wdt_write,
+	.ioctl		= wb_smsc_wdt_ioctl,
+	.open		= wb_smsc_wdt_open,
+	.release	= wb_smsc_wdt_release,
+};
+
+static struct notifier_block wb_smsc_wdt_notifier =
+{
+	.notifier_call  = wb_smsc_wdt_notify_sys,
+};
+
+static struct miscdevice wb_smsc_wdt_miscdev =
+{
+	.minor		= WATCHDOG_MINOR,
+	.name		= "watchdog",
+	.fops		= &wb_smsc_wdt_fops,
+};
+
+/* -- Module init functions -------------------------------------*/
+
+/* module's "constructor" */
+
+static int __init wb_smsc_wdt_init(void)
+{
+	int ret;
+
+	spin_lock_init(&io_lock);
+
+	printk("SMsC 37B787 watchdog component driver " VERSION " initialising...\n");
+
+	if (!request_region(IOPORT, IOPORT_SIZE, "SMsC 37B787 watchdog")) {
+		printk(KERN_ERR MODNAME "Unable to register IO port %#x\n", IOPORT);
+		ret = -EBUSY;
+		goto out_pnp;
+	}
+
+        // set new maximum, if it's too big
+        if (timeout > MAX_TIMEOUT)
+               timeout = MAX_TIMEOUT;
+
+        // init the watchdog timer
+        wb_smsc_wdt_initialize();
+
+	ret = register_reboot_notifier(&wb_smsc_wdt_notifier);
+	if (ret) {
+		printk(KERN_ERR MODNAME "Unable to register reboot notifier err = %d\n", ret);
+		goto out_io;
+	}
+
+	ret = misc_register(&wb_smsc_wdt_miscdev);
+	if (ret) {
+		printk(KERN_ERR MODNAME "Unable to register miscdev on minor %d\n", WATCHDOG_MINOR);
+		goto out_rbt;
+	}
+
+	// output info
+	printk(KERN_INFO MODNAME "Timeout set to %d %s.\n", timeout, (unit == UNIT_SECOND) ? "second(s)" : "minute(s)");
+	printk(KERN_INFO MODNAME "Watchdog initialized and sleeping (nowayout=%d)...\n", nowayout);
+
+	// ret = 0
+
+out_clean:
+	return ret;
+
+out_rbt:
+	unregister_reboot_notifier(&wb_smsc_wdt_notifier);
+
+out_io:
+	release_region(IOPORT, IOPORT_SIZE);
+
+out_pnp:
+	goto out_clean;
+}
+
+/* module's "destructor" */
+
+static void __exit wb_smsc_wdt_exit(void)
+{
+	/* Stop the timer before we leave */
+	if (!nowayout)
+	{
+		wb_smsc_wdt_shutdown();
+		printk(KERN_INFO MODNAME "Watchdog disabled.\n");
+	}
+
+	misc_deregister(&wb_smsc_wdt_miscdev);
+	unregister_reboot_notifier(&wb_smsc_wdt_notifier);
+	release_region(IOPORT, IOPORT_SIZE);
+
+	printk("SMsC 37B787 watchdog component driver removed.\n");
+}
+
+module_init(wb_smsc_wdt_init);
+module_exit(wb_smsc_wdt_exit);
+
+MODULE_AUTHOR("Sven Anders <anders@anduras.de>");
+MODULE_DESCRIPTION("Driver for SMsC 37B787 watchdog component (Version " VERSION ")");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+
+#ifdef SMSC_SUPPORT_MINUTES
+module_param(unit, int, 0);
+MODULE_PARM_DESC(unit, "set unit to use, 0=seconds or 1=minutes, default is 0");
+#endif
+
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "range is 1-255 units, default is 60");
+
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
diff --git a/drivers/char/watchdog/w83627hf_wdt.c b/drivers/char/watchdog/w83627hf_wdt.c
index b4adc52..07d4bff 100644
--- a/drivers/char/watchdog/w83627hf_wdt.c
+++ b/drivers/char/watchdog/w83627hf_wdt.c
@@ -33,6 +33,7 @@ #include <linux/ioport.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/spinlock.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -44,6 +45,7 @@ #define WATCHDOG_TIMEOUT 60		/* 60 sec d
 
 static unsigned long wdt_is_open;
 static char expect_close;
+static spinlock_t io_lock;
 
 /* You must set this - there is no sane way to probe for this board. */
 static int wdt_io = 0x2E;
@@ -110,12 +112,16 @@ w83627hf_init(void)
 static void
 wdt_ctrl(int timeout)
 {
+	spin_lock(&io_lock);
+	
 	w83627hf_select_wd_register();
 
 	outb_p(0xF6, WDT_EFER);    /* Select CRF6 */
 	outb_p(timeout, WDT_EFDR); /* Write Timeout counter to CRF6 */
 
 	w83627hf_unselect_wd_register();
+
+	spin_unlock(&io_lock);
 }
 
 static int
@@ -303,6 +309,8 @@ wdt_init(void)
 {
 	int ret;
 
+	spin_lock_init(&io_lock);
+
 	printk(KERN_INFO "WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.\n");
 
 	if (wdt_set_heartbeat(timeout)) {
diff --git a/drivers/char/watchdog/w83697hf_wdt.c b/drivers/char/watchdog/w83697hf_wdt.c
new file mode 100644
index 0000000..7768b55
--- /dev/null
+++ b/drivers/char/watchdog/w83697hf_wdt.c
@@ -0,0 +1,450 @@
+/*
+ *	w83697hf/hg WDT driver
+ *
+ *	(c) Copyright 2006 Samuel Tardieu <sam@rfc1149.net>
+ *	(c) Copyright 2006 Marcus Junker <junker@anduras.de>
+ *
+ *	Based on w83627hf_wdt.c which is based on advantechwdt.c
+ *	which is based on wdt.c.
+ *	Original copyright messages:
+ *
+ *	(c) Copyright 2003 P�draig Brady <P@draigBrady.com>
+ *
+ *	(c) Copyright 2000-2001 Marek Michalkiewicz <marekm@linux.org.pl>
+ *
+ *	(c) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
+ *				http://www.redhat.com
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Neither Marcus Junker nor ANDURAS AG admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/fs.h>
+#include <linux/ioport.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#define WATCHDOG_NAME "w83697hf/hg WDT"
+#define PFX WATCHDOG_NAME ": "
+#define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
+
+static unsigned long wdt_is_open;
+static char expect_close;
+static spinlock_t io_lock;
+
+/* You must set this - there is no sane way to probe for this board. */
+static int wdt_io = 0x2e;
+module_param(wdt_io, int, 0);
+MODULE_PARM_DESC(wdt_io, "w83697hf/hg WDT io port (default 0x2e, 0 = autodetect)");
+
+static int timeout = WATCHDOG_TIMEOUT;	/* in seconds */
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. 1<= timeout <=255, default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+/*
+ *	Kernel methods.
+ */
+
+#define W83697HF_EFER (wdt_io+0)	/* Extended Function Enable Register */
+#define W83697HF_EFIR (wdt_io+0)	/* Extended Function Index Register (same as EFER) */
+#define W83697HF_EFDR (wdt_io+1)	/* Extended Function Data Register */
+
+static inline void
+w83697hf_unlock(void)
+{
+	outb_p(0x87, W83697HF_EFER);	/* Enter extended function mode */
+	outb_p(0x87, W83697HF_EFER);	/* Again according to manual */
+}
+
+static inline void
+w83697hf_lock(void)
+{
+	outb_p(0xAA, W83697HF_EFER);	/* Leave extended function mode */
+}
+
+/*
+ *	The three functions w83697hf_get_reg(), w83697hf_set_reg() and
+ *	w83697hf_write_timeout() must be called with the device unlocked.
+ */
+
+static unsigned char
+w83697hf_get_reg(unsigned char reg)
+{
+	outb_p(reg, W83697HF_EFIR);
+	return inb_p(W83697HF_EFDR);
+}
+
+static void
+w83697hf_set_reg(unsigned char reg, unsigned char data)
+{
+	outb_p(reg, W83697HF_EFIR);
+	outb_p(data, W83697HF_EFDR);
+}
+
+static void
+w83697hf_write_timeout(int timeout)
+{
+	w83697hf_set_reg(0xF4, timeout);	/* Write Timeout counter to CRF4 */
+}
+
+static void
+w83697hf_select_wdt(void)
+{
+	w83697hf_unlock();
+	w83697hf_set_reg(0x07, 0x08);	/* Switch to logic device 8 (GPIO2) */
+}
+
+static inline void
+w83697hf_deselect_wdt(void)
+{
+	w83697hf_lock();
+}
+
+static void
+w83697hf_init(void)
+{
+	unsigned char bbuf;
+
+	w83697hf_select_wdt();
+
+	bbuf = w83697hf_get_reg(0x29);
+	bbuf &= ~0x60;
+	bbuf |= 0x20;
+	w83697hf_set_reg(0x29, bbuf);	/* Set pin 119 to WDTO# mode (= CR29, WDT0) */
+
+	bbuf = w83697hf_get_reg(0xF3);
+	bbuf &= ~0x04;
+	w83697hf_set_reg(0xF3, bbuf);	/* Count mode is seconds */
+
+	w83697hf_deselect_wdt();
+}
+
+static int
+wdt_ping(void)
+{
+	spin_lock(&io_lock);
+	w83697hf_select_wdt();
+
+	w83697hf_write_timeout(timeout);
+
+	w83697hf_deselect_wdt();
+	spin_unlock(&io_lock);
+	return 0;
+}
+
+static int
+wdt_enable(void)
+{
+	spin_lock(&io_lock);
+	w83697hf_select_wdt();
+
+	w83697hf_write_timeout(timeout);
+	w83697hf_set_reg(0x30, 1);	/* Enable timer */
+
+	w83697hf_deselect_wdt();
+	spin_unlock(&io_lock);
+	return 0;
+}
+
+static int
+wdt_disable(void)
+{
+	spin_lock(&io_lock);
+	w83697hf_select_wdt();
+
+	w83697hf_set_reg(0x30, 0);	/* Disable timer */
+	w83697hf_write_timeout(0);
+
+	w83697hf_deselect_wdt();
+	spin_unlock(&io_lock);
+	return 0;
+}
+
+static int
+wdt_set_heartbeat(int t)
+{
+	if ((t < 1) || (t > 255))
+		return -EINVAL;
+
+	timeout = t;
+	return 0;
+}
+
+static ssize_t
+wdt_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+{
+	if (count) {
+		if (!nowayout) {
+			size_t i;
+
+			expect_close = 0;
+
+			for (i = 0; i != count; i++) {
+				char c;
+				if (get_user(c, buf+i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 42;
+			}
+		}
+		wdt_ping();
+	}
+	return count;
+}
+
+static int
+wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	  unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	int new_timeout;
+	static struct watchdog_info ident = {
+		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
+		.firmware_version = 1,
+		.identity = "W83697HF WDT",
+	};
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user(argp, &ident, sizeof(ident)))
+			return -EFAULT;
+		break;
+
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		return put_user(0, p);
+
+	case WDIOC_KEEPALIVE:
+		wdt_ping();
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_timeout, p))
+			return -EFAULT;
+		if (wdt_set_heartbeat(new_timeout))
+			return -EINVAL;
+		wdt_ping();
+		/* Fall */
+
+	case WDIOC_GETTIMEOUT:
+		return put_user(timeout, p);
+
+	case WDIOC_SETOPTIONS:
+	{
+		int options, retval = -EINVAL;
+
+		if (get_user(options, p))
+			return -EFAULT;
+
+		if (options & WDIOS_DISABLECARD) {
+			wdt_disable();
+			retval = 0;
+		}
+
+		if (options & WDIOS_ENABLECARD) {
+			wdt_enable();
+			retval = 0;
+		}
+
+		return retval;
+	}
+
+	default:
+		return -ENOTTY;
+	}
+	return 0;
+}
+
+static int
+wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(0, &wdt_is_open))
+		return -EBUSY;
+	/*
+	 *	Activate
+	 */
+
+	wdt_enable();
+	return nonseekable_open(inode, file);
+}
+
+static int
+wdt_close(struct inode *inode, struct file *file)
+{
+	if (expect_close == 42) {
+		wdt_disable();
+	} else {
+		printk (KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
+		wdt_ping();
+	}
+	expect_close = 0;
+	clear_bit(0, &wdt_is_open);
+	return 0;
+}
+
+/*
+ *	Notifier for system down
+ */
+
+static int
+wdt_notify_sys(struct notifier_block *this, unsigned long code,
+	void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT) {
+		/* Turn the WDT off */
+		wdt_disable();
+	}
+	return NOTIFY_DONE;
+}
+
+/*
+ *	Kernel Interfaces
+ */
+
+static struct file_operations wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= wdt_write,
+	.ioctl		= wdt_ioctl,
+	.open		= wdt_open,
+	.release	= wdt_close,
+};
+
+static struct miscdevice wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &wdt_fops,
+};
+
+/*
+ *	The WDT needs to learn about soft shutdowns in order to
+ *	turn the timebomb registers off.
+ */
+
+static struct notifier_block wdt_notifier = {
+	.notifier_call = wdt_notify_sys,
+};
+
+static int
+w83697hf_check_wdt(void)
+{
+	if (!request_region(wdt_io, 2, WATCHDOG_NAME)) {
+		printk (KERN_ERR PFX "I/O address 0x%x already in use\n", wdt_io);
+		return -EIO;
+	}
+
+	printk (KERN_DEBUG PFX "Looking for watchdog at address 0x%x\n", wdt_io);
+	w83697hf_unlock();
+	if (w83697hf_get_reg(0x20) == 0x60) {
+		printk (KERN_INFO PFX "watchdog found at address 0x%x\n", wdt_io);
+		w83697hf_lock();
+		return 0;
+	}
+	w83697hf_lock();	/* Reprotect in case it was a compatible device */
+
+	printk (KERN_INFO PFX "watchdog not found at address 0x%x\n", wdt_io);
+	release_region(wdt_io, 2);
+	return -EIO;
+}
+
+static int w83697hf_ioports[] = { 0x2e, 0x4e, 0x00 };
+
+static int __init
+wdt_init(void)
+{
+	int ret, i, found = 0;
+
+	spin_lock_init(&io_lock);
+
+	printk (KERN_INFO PFX "WDT driver for W83697HF/HG initializing\n");
+
+	if (wdt_io == 0) {
+		/* we will autodetect the W83697HF/HG watchdog */
+		for (i = 0; ((!found) && (w83697hf_ioports[i] != 0)); i++) {
+			wdt_io = w83697hf_ioports[i];
+			if (!w83697hf_check_wdt())
+				found++;
+		}
+	} else {
+		if (!w83697hf_check_wdt())
+			found++;
+	}
+
+	if (!found) {
+		printk (KERN_ERR PFX "No W83697HF/HG could be found\n");
+		ret = -EIO;
+		goto out;
+	}
+
+	w83697hf_init();
+	wdt_disable();	/* Disable watchdog until first use */
+
+	if (wdt_set_heartbeat(timeout)) {
+		wdt_set_heartbeat(WATCHDOG_TIMEOUT);
+		printk (KERN_INFO PFX "timeout value must be 1<=timeout<=255, using %d\n",
+			WATCHDOG_TIMEOUT);
+	}
+
+	ret = register_reboot_notifier(&wdt_notifier);
+	if (ret != 0) {
+		printk (KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			ret);
+		goto unreg_regions;
+	}
+
+	ret = misc_register(&wdt_miscdev);
+	if (ret != 0) {
+		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		goto unreg_reboot;
+	}
+
+	printk (KERN_INFO PFX "initialized. timeout=%d sec (nowayout=%d)\n",
+		timeout, nowayout);
+
+out:
+	return ret;
+unreg_reboot:
+	unregister_reboot_notifier(&wdt_notifier);
+unreg_regions:
+	release_region(wdt_io, 2);
+	goto out;
+}
+
+static void __exit
+wdt_exit(void)
+{
+	misc_deregister(&wdt_miscdev);
+	unregister_reboot_notifier(&wdt_notifier);
+	release_region(wdt_io, 2);
+}
+
+module_init(wdt_init);
+module_exit(wdt_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Marcus Junker <junker@anduras.de>, Samuel Tardieu <sam@rfc1149.net>");
+MODULE_DESCRIPTION("w83697hf/hg WDT driver");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
