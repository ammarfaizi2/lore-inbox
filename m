Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVHQPFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVHQPFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 11:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVHQPFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 11:05:48 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:41375 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751113AbVHQPFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 11:05:47 -0400
Date: Wed, 17 Aug 2005 17:05:23 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Hardeman <david@2gen.com>,
       Naveen Gupta <ngupta@google.com>, Jiri Slaby <xslaby@fi.muni.cz>,
       "P @ Draig Brady" <P@draigBrady.com>, Ben Dooks <ben-linux@fluff.org>,
       James Chapman <jchapman@katalix.com>, Olaf Hering <olh@suse.de>
Subject: watchdog-mm git tree
Message-ID: <20050817150523.GA19487@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I (finaly) converted the watchdog-mm bitkeeper tree to a git repository:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog-mm.git

The tree contains the following patches at this moment (in reverse order):

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Tue Aug 16 14:52:23 2005 -0700

    [WATCHDOG] Kconfig-clean
    
    Move the ppc64 rtas drivers together with the other ppc drivers.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Naveen Gupta <ngupta@google.com>
Date:   Tue Aug 16 14:46:17 2005 -0700

    [WATCHDOG] i6300esb-set_correct_reload_register_bit
    
    This patch writes into bit 8 of the reload register to perform the
    correct 'Reload Sequence' instead of writing into bit 4 of Watchdog for
    Intel 6300ESB chipset.
    
    Signed-off-by: Naveen Gupta <ngupta@google.com>
    Signed-off-by: David Härdeman <david@2gen.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Naveen Gupta <ngupta@google.com>
Date:   Tue Aug 16 14:41:06 2005 -0700

    [WATCHDOG] i6300esb.c-WDT_ENABLE-bug
    
    This patch sets the WDT_ENABLE bit of the Lock Register to enable the
    watchdog and WDT_LOCK bit only if nowayout is set. The old code always
    sets the WDT_LOCK bit of watchdog timer for Intel 6300ESB chipset. So, we
    end up locking the watchdog instead of enabling it.
    
    Signed-off-by: Naveen Gupta <ngupta@google.com>
    Signed-off-by: David Härdeman <david@2gen.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Jiri Slaby <xslaby@fi.muni.cz>
Date:   Tue Aug 16 14:35:42 2005 -0700

    [WATCHDOG] removes pci_find_device from i6300esb.c
    
    This patch changes pci_find_device to pci_get_device
    (encapsulated in for_each_pci_dev) in i6300esb watchdog
    card with appropriate adding pci_dev_put.
    
    Generated in 2.6.13-rc5-mm1 kernel version.
    
    Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: David Hardeman <david@2gen.com>
Date:   Tue Aug 16 14:17:18 2005 -0700

    [WATCHDOG] i6300esb.patch
    
    From: David Hardeman <david@2gen.com>
    
    I wrote earlier to the list[1] asking for a driver for the watchdog
    included in the 6300ESB chipset.  I got a 2.4 driver via private email
    from Ross Biro which I've changed into what I hope resembles a 2.6
    driver (which was done by looking a lot at the watchdog drivers
    already in the 2.6 tree).
    
    I've attached the result, and I'm hoping to get some feedback on the
    coding as a first step.  I can't actually test it on the hardware
    right now as I won't have physical access until April. So my own tests
    have been limited to "compiles-without-warnings" and
    "can-be-insmodded-in-other-machine-without-oops".
    
    [1] http://marc.theaimsgroup.com/?l=linux-kernel&m=110711079825794&w=2
    [2] http://marc.theaimsgroup.com/?l=linux-kernel&m=110711973917746&w=2
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: P@Draig Brady <P@draigBrady.com>
Date:   Tue Aug 16 14:02:15 2005 -0700

    [WATCHDOG] w83627hf_wdt.c-initialized_bios_bug
    
    Attached is a small update to the w83627hf watchdog driver
    to initialise appropriately if it was already initialised
    in the BIOS. On tyan motherboards for e.g. you can init
    the watchdog to 4 mins, then when the driver is loaded it
    sets the watchdog to "seconds" mode, and then machine will
    reboot within 4 seconds. So this patch resets the timeout
    to the configured value if the watchdog is already running.
    
    Signed-off-by: P@draig Brady <P@draigBrady.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Ben Dooks <ben-linux@fluff.org>
Date:   Tue Aug 16 13:51:51 2005 -0700

    [WATCHDOG] s3c2410 watchdog - replace reboot notifier
    
    Patch from Dimitry Andric <dimitry.andric@tomtom.com>
    
    Change to using platfrom driver's .shutdown method instead
    of an reboot notifier
    
    Signed-off-by: Dimitry Andric <dimitry.andric@tomtom.com>
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Ben Dooks <ben-linux@fluff.org>
Date:   Tue Aug 16 13:45:04 2005 -0700

    [WATCHDOG] s3c2410 watchdog power management
    
    Patch from Dimitry Andric <dimitry.andric@tomtom.com>, updated
    by Ben Dooks <ben-linux@fluff.org>. Patch is against 2.6.11-mm2
    
    Add power management support to the s3c2410 watchdog, so that
    it is shut-down over suspend, and re-initialised on resume.
    
    Also add Dimitry to the list of authors.
    
    Signed-off-by: Dimitry Andric <dimitry.andric@tomtom.com>
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: James Chapman <jchapman@katalix.com>
Date:   Tue Aug 16 13:38:15 2005 -0700

    [WATCHDOG] mv64x60_wdt.patch
    
    Add mv64x60 (Marvell Discovery) watchdog support.
    
    Signed-off-by: James Chapman <jchapman@katalix.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Olaf Hering <olh@suse.de>
Date:   Tue Aug 16 13:23:31 2005 -0700

    [WATCHDOG] correct sysfs name for watchdog devices
    
    While looking for possible candidates for our udev.rules package,
    I found a few odd ->name properties. /dev/watchdog has minor 130
    according to devices.txt. Since all watchdog drivers use the
    misc_register() call, they will end up in /sys/class/misc/$foo.
    udev may create the /dev/watchdog node if the driver is loaded.
    I dont have such a device, so I cant test it.
    The drivers below provide names with spaces and even with / in it.
    Not a big deal, but apps may expect /dev/watchdog.
    
    Signed-off-by: Olaf Hering <olh@suse.de>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Tue Aug 16 13:08:25 2005 -0700

    [WATCHDOG] Makefile-probe_order-patch
    
    Re-arrange Makefile according to what we want to probe first.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Greetings,
Wim.

