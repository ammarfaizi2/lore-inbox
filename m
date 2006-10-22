Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWJVRDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWJVRDe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWJVRDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:03:34 -0400
Received: from outmx007.isp.belgacom.be ([195.238.5.234]:42456 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751305AbWJVRDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:03:32 -0400
Date: Sun, 22 Oct 2006 19:03:05 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Victor <andrew@sanpeople.com>, Jean Delvare <khali@linux-fr.org>,
       Jeff Garzik <jeff@garzik.org>,
       Arnaud Patard <arnaud.patard@rtp-net.org>,
       Amol Lad <amol@verismonetworks.com>, Samuel Tardieu <sam@rfc1149.net>,
       Marcus Junker <junker@anduras.de>, Sven Anders <anders@anduras.de>
Subject: Re: [WATCHDOG] v2.6.19 watchdog patches - part 3
Message-ID: <20061022170305.GA2564@infomag.infomag.iguana.be>
References: <20061015174146.GA2559@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061015174146.GA2559@infomag.infomag.iguana.be>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I didn't get or see any objections to the below patches.
So can you please pull from 'master' branch of
	git://git.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
or from master.kernel.org:
	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

Thanks in advance,
Wim.

> Hi Linus,
> 
> If no-one objects, can you please pull from 'master' branch of
> 	git://git.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
> 
> This will update the following files:
> 
>  Documentation/watchdog/src/watchdog-simple.c |    2 
>  arch/arm/configs/at91rm9200dk_defconfig      |    2 
>  arch/arm/configs/at91rm9200ek_defconfig      |    2 
>  arch/arm/configs/csb337_defconfig            |    2 
>  arch/arm/configs/csb637_defconfig            |    2 
>  arch/arm/configs/kafa_defconfig              |    2 
>  arch/arm/configs/onearm_defconfig            |    2 
>  drivers/char/watchdog/Kconfig                |   65 ++
>  drivers/char/watchdog/Makefile               |    4 
>  drivers/char/watchdog/at91_wdt.c             |  287 ------------
>  drivers/char/watchdog/at91rm9200_wdt.c       |  287 ++++++++++++
>  drivers/char/watchdog/iTCO_wdt.c             |   21 
>  drivers/char/watchdog/s3c2410_wdt.c          |    5 
>  drivers/char/watchdog/smsc37b787_wdt.c       |  627 +++++++++++++++++++++++++++
>  drivers/char/watchdog/w83627hf_wdt.c         |    8 
>  drivers/char/watchdog/w83697hf_wdt.c         |  450 +++++++++++++++++++
>  16 files changed, 1457 insertions(+), 311 deletions(-)
> 
> with these Changes:
> 
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date:   Sat Oct 14 20:18:47 2006 +0200
> 
>     [WATCHDOG] remove experimental on iTCO_wdt.c
>     
>     The iTCO_wdt.c driver has been tested enough. So we can
>     remove the experimental classification.
>     
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Andrew Victor <andrew@sanpeople.com>
> Date:   Tue Sep 26 17:49:30 2006 +0200
> 
>     [WATCHDOG] Atmel AT91RM9200 rename.
>     
>     The new Atmel AT91SAM9261 and AT91SAM9260 processors use a different
>     internal watchdog peripheral.  This watchdog driver is therefore
>     AT91RM9200-specific.
>     
>     This patch renames at91_wdt.c to at91rm9200_wdt.c, and changes the name
>     of the configuration option.
>     
>     Signed-off-by: Andrew Victor <andrew@sanpeople.com>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Jean Delvare <khali@linux-fr.org>
> Date:   Thu Sep 28 09:35:27 2006 +0200
> 
>     [WATCHDOG] includes for sample watchdog program.
>     
>     Add missing includes to sample watchdog program.
>     
>     Signed-off-by: Jean Delvare <khali@linux-fr.org>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Jeff Garzik <jeff@garzik.org>
> Date:   Tue Oct 10 03:40:44 2006 -0400
> 
>     [WATCHDOG] watchdog/iTCO_wdt: fix bug related to gcc uninit warning
>     
>     gcc emits the following warning:
>     
>     drivers/char/watchdog/iTCO_wdt.c: In function ‘iTCO_wdt_ioctl’:
>     drivers/char/watchdog/iTCO_wdt.c:429: warning: ‘time_left’ may be used uninitialized in this function
>     
>     This indicates a condition near enough to a bug, to want to fix.
>     iTCO_wdt_get_timeleft() stores a value in 'time_left' iff
>     iTCO_version==(1 or 2).  This driver only supports versions
>     1 or 2, so this is ok.  However, since (a) the return value of
>     iTCO_wdt_get_timeleft() is handled anyway, (b) it fixes the warning,
>     and (c) it future-proofs the driver, we go ahead and add the obvious
>     return value.
>     
>     Signed-off-by: Jeff Garzik <jeff@garzik.org>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date:   Sun Oct 8 21:05:21 2006 +0200
> 
>     [WATCHDOG] add ich8 support to iTCO_wdt.c (patch 2)
>     
>     Add ICH8 support to the iTCO_wdt driver.
>     
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
> Date:   Wed Oct 4 14:18:29 2006 +0200
> 
>     [WATCHDOG] add ich8 support to iTCO_wdt.c
>     
>     Add ICH8 support to the iTCO_wdt driver.
>     
>     Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Amol Lad <amol@verismonetworks.com>
> Date:   Fri Oct 6 13:41:12 2006 -0700
> 
>     [WATCHDOG] ioremap balanced with iounmap for drivers/char/watchdog/s3c2410_wdt.c
>     
>     ioremap must be balanced by an iounmap and failing to do so can result
>     in a memory leak.
>     
>     Signed-off-by: Amol Lad <amol@verismonetworks.com>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - Kconfig patch
>     
>     Update Kconfig for the w83697hf/hg watchdog driver.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date:   Fri Sep 15 17:59:07 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - autodetect patch
>     
>     Change the autodetect code so that it is more generic.
>     
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 16
>     
>     This is patch 16 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - Add copyright notice for Samuel Tardieu also.
>     
>     This is the last patch in this series.
>     
>     The original description for Samuel's driver was:
>     driver for the Winbond W83697HF/W83697HG watchdog timer
>     
>     The Winbond SuperIO W83697HF/HG includes a watchdog that can count from
>     1 to 255 seconds (or minutes). This drivers allows the seconds mode to
>     be used. It exposes a standard /dev/watchdog interface. This chip is
>     currently being used on some motherboards designed by VIA.
>     
>     By default, the module looks for a chip at I/O port 0x2e. The chip can
>     be configured to be at 0x4e on some motherboards, the address can be
>     chosen using the wdt_io module parameter. Using 0 will try to autodetect
>     the address.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 15
>     
>     This is patch 15 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - Clean-up initialization code - part 2:
>        * the line reading "set second mode & disable keyboard ..."
>          is plain wrong, the register being manipulated (CRF4) is
>          the counter itself, not the control byte (CRF3) -- looks
>          like it has been copied from another driver.
>        * I think garbage is being written in CRF3 (the control word)
>          as the timeout value is being stored in this register (such
>          as 60 for 60 seconds).
>        * We only want to set pin 119 to WDTO# mode and leave the rest
>          of CR29 like it is.
>        * Set count mode to seconds and not minutes.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 14
>     
>     This is patch 14 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - Clean-up initialization code (part 1: remove
>        w83697hf_select_wd_register() and
>        w83697hf_unselect_wd_register() functions).
>      - Make sure that the watchdog device is stopped
>        as soon as we found it.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 13
>     
>     This is patch 13 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - Remove wdt_ctrl (it has been replaced with the
>        w83697hf_write_timeout() function) and redo/clean-up
>        the start/stop/ping code.
>      - Make sure that the watchdog is enabled or disabled
>        When starting or stoping the device (with a call
>        to w83697hf_set_reg(0x30, ?); ).
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 12
>     
>     This is patch 12 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - Add w83697hf_write_timeout() to set the
>        watchdog's timeout value.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 11
>     
>     This is patch 11 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - Add w83697hf_select_wdt() and w83697hf_deselect_wdt()
>        so that the start/stop/ping code can directly talk to
>        the watchdog.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 10
>     
>     This is patch 10 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - check whether the device is really present
>        (we *can* probe for the device now).
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 9
>     
>     This is patch 9 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - add w83697hf_get_reg() and w83697hf_set_reg()
>        functions.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 8
>     
>     This is patch 8 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - add w83697hf_lock function to leave the
>        chipsets extended function mode.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 7
>     
>     This is patch 7 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - add w83697hf_unlock function to enter the
>        chipsets extended function mode.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 6
>     
>     This is patch 6 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - The driver works for both the w83697hf
>        and the w83697hg chipset's.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 5
>     
>     This is patch 5 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - Rename the Extended Function Registers to the names
>        used in the data-sheet.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 4
>     
>     This is patch 4 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - limits the watchdog timeout to 1-63 while this
>        device accepts 1-255.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 3
>     
>     This is patch 3 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - Fix identation.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 2
>     
>     This is patch 2 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - wdt_io is 2 bytes long. We should do a
>        request_region for 2 bytes instead of 1.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Samuel Tardieu <sam@rfc1149.net>
> Date:   Thu Sep 7 11:57:00 2006 +0200
> 
>     [WATCHDOG] w83697hf/hg WDT driver - patch 1
>     
>     This is patch 1 in the series of patches that converts
>     Marcus Junker's w83697hf watchdog driver to Samuel Tardieau's
>     w83697hf/hg watchdog driver.
>     
>     This patch contains following changes:
>      - the note concerning tyan motherboards has been copied from
>        another driver, This doesn't apply here.
>      - the comments concerning CRF6 are wrong as CRF3 is manipulated
>        and CRF6 is never read nor written.
>      - the comments concerning CRF5 are wrong as CRF4 is manipulated
>        and CRF5 is never read nor written.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date:   Wed Sep 13 21:27:29 2006 +0200
> 
>     [WATCHDOG] use ENOTTY instead of ENOIOCTLCMD in ioctl()
>     
>     Return ENOTTY instead of ENOIOCTLCMD in user-visible ioctl() results
>     
>     The watchdog drivers used to return ENOIOCTLCMD for bad ioctl() commands.
>     ENOIOCTLCMD should not be visible by the user, so use ENOTTY instead.
>     
>     Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>     Acked-by: Alan Cox <alan@redhat.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date:   Sat Sep 2 19:04:02 2006 +0200
> 
>     [WATCHDOG] Kconfig clean up
>     
>     fixed some more trailing spaces.
>     
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date:   Sat Sep 2 18:50:20 2006 +0200
> 
>     [WATCHDOG] w836?7hf_wdt spinlock fixes.
>     
>     Add io spinlocks to prevent possible race
>     conditions between start and stop operations
>     that are issued from different child processes
>     where the master process opened /dev/watchdog.
>     
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date:   Sat Sep 2 17:59:54 2006 +0200
> 
>     [WATCHDOG] Kconfig clean-up
>     
>     * fix typo's according to spellings checker
>     * Fix some leading and trailing spaces
>     
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Marcus Junker <junker@anduras.de>
> Date:   Thu Aug 24 17:11:50 2006 +0200
> 
>     [WATCHDOG] w83697hf WDT driver
>     
>     New watchdog driver for the Winbond W83697HF chipset.
>     
>     Signed-off-by: Marcus Junker <junker@anduras.de>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date:   Sat Sep 2 20:53:19 2006 +0200
> 
>     [WATCHDOG] Winbond SMsC37B787 watchdog fixes
>     
>     * Added io spinlocking
>     * Deleted WATCHDOG_MINOR (it's in the miscdevice include
>     * Changed timer_enabled to use set_bit functions
>     * WDIOC_GETSUPPORT should return -EFAULT or 0
>     * timeout should be correct before we initialize the watchdog
>     * we should initialize the watchdog before we give access
>       to userspace
>     * Third parameter of module_param is not the default or
>       initial value
>     
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date:   Sat Sep 2 19:32:26 2006 +0200
> 
>     [WATCHDOG] Winbond SMsC37B787 - remove trailing whitespace
>     
>     Remove trailing whitespace.
>     
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Author: Sven Anders <anders@anduras.de>
> Date:   Thu Aug 24 17:11:50 2006 +0200
> 
>     [WATCHDOG] Winbond SMsC37B787 watchdog driver
>     
>     New watchdog driver for the Winbond SMsC37B787 chipset.
>     
>     Signed-off-by: Sven Anders <anders@anduras.de>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> The Changes can also be looked at on:
> 	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary
> 
> For completeness, I added the overal diff below.
> 
> Greetings,
> Wim.
> 
