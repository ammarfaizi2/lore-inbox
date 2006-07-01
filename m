Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751932AbWGAV2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbWGAV2b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 17:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWGAV2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 17:28:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:22094 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751227AbWGAV23 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 17:28:29 -0400
X-IronPort-AV: i="4.06,198,1149490800"; 
   d="scan'208"; a="92103516:sNHT295513113"
From: Len Brown <len.brown@intel.com>
Organization: Intel Open Source Technology Center
To: torvalds@osdl.org
Subject: [GIT PATCH] ACPI for 2.6.18 -- partie trois
Date: Sat, 1 Jul 2006 17:30:23 -0400
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200606230437.50845.len.brown@intel.com> <200606300220.39405.len.brown@intel.com>
In-Reply-To: <200606300220.39405.len.brown@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607011730.24361.len.brown@intel.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This adds a "Smart Battery" support for systems that  do not have the
newer "ACPI Control Method" battery that Linux already supports.
The ACPI_SBS is marked EXPERIMENTAL because it is new to upstream.

This updates the acpi_asus driver to 0.30 -- a version that at least one distro
is shipping already.

Plus some misc cleanups, and a couple of workarounds for broken BIOS.

thanks!

-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.17/acpi-release-20060623-2.6.17.diff.gz

 arch/ia64/kernel/acpi-ext.c       |    2 
 arch/ia64/kernel/acpi.c           |   12 
 drivers/acpi/Kconfig              |   12 
 drivers/acpi/Makefile             |    2 
 drivers/acpi/ac.c                 |   32 
 drivers/acpi/acpi_memhotplug.c    |   18 
 drivers/acpi/asus_acpi.c          |  335 +++-
 drivers/acpi/battery.c            |   46 
 drivers/acpi/button.c             |   10 
 drivers/acpi/cm_sbs.c             |  131 +
 drivers/acpi/container.c          |    2 
 drivers/acpi/fan.c                |   10 
 drivers/acpi/glue.c               |    8 
 drivers/acpi/i2c_ec.c             |  406 +++++
 drivers/acpi/i2c_ec.h             |   23 
 drivers/acpi/namespace/nsxfeval.c |    2 
 drivers/acpi/numa.c               |    4 
 drivers/acpi/osl.c                |    9 
 drivers/acpi/pci_link.c           |   15 
 drivers/acpi/pci_root.c           |   20 
 drivers/acpi/power.c              |   22 
 drivers/acpi/processor_idle.c     |    2 
 drivers/acpi/processor_perflib.c  |    6 
 drivers/acpi/sbs.c                | 1766 ++++++++++++++++++++++++++
 drivers/acpi/scan.c               |    4 
 drivers/acpi/system.c             |    4 
 drivers/acpi/thermal.c            |   57 
 drivers/acpi/utilities/utalloc.c  |    4 
 drivers/acpi/utilities/utcache.c  |    2 
 drivers/acpi/utils.c              |    4 
 drivers/acpi/video.c              |   76 -
 include/acpi/acmacros.h           |    2 
 include/acpi/acpiosxf.h           |    2 
 33 files changed, 2732 insertions(+), 318 deletions(-)

through these commits:

Christian Lupien:
      ACPI: handle AC notify event on broken BIOS

Karol Kozimor:
      ACPI: asus_acpi: misc cleanups
      ACPI: asus_acpi: support A3G
      ACPI: asus_acpi: LED display support
      ACPI: asus_acpi: support W3400N
      ACPI: asus_acpi: support A4G
      ACPI: asus_acpi: handle internal Bluetooth / support W5A
      ACPI: asus_acpi: support L5D
      ACPI: asus_acpi: rework model detection
      ACPI: asus_acpi: add S1N WLED control
      ACPI: asus_acpi: add S1N WLED control
      ACPI: asus_acpi: correct M6N/M6R display nodes

Len Brown:
      ACPI: delete acpi_os_free(), use kfree() directly
      ACPI: remove function tracing macros from drivers/acpi/*.c

Patrick Mochel:
      ACPI: ac: Add struct acpi_device to struct acpi_ac.
      ACPI: acpi_memhotplug: add struct acpi_device to struct acpi_memory_device.
      ACPI: battery: add struct acpi_device to struct acpi_battery.
      ACPI: fan: add struct acpi_device to struct acpi_fan.
      ACPI: pci root: add struct acpi_device to struct acpi_pci_root.
      ACPI: thermal: add struct acpi_device to struct acpi_thermal.
      ACPI: power: add struct acpi_device to struct acpi_power_resource
      ACPI: video: add struct acpi_device to struct acpi_video_bus.
      ACPI: ac: Use acpi_device's handle instead of driver's
      ACPI: acpi_memhotplug: Use acpi_device's handle instead of driver's
      ACPI: battery: Use acpi_device's handle instead of driver's
      ACPI: button: Use acpi_device's handle instead of driver's
      ACPI: fan: Use acpi_device's handle instead of driver's
      ACPI: pci_link: Use acpi_device's handle instead of driver's
      ACPI: pci_root: Use acpi_device's handle instead of driver's
      ACPI: power: Use acpi_device's handle instead of driver's
      ACPI: thermal: Use acpi_device's handle instead of driver's
      ACPI: video: Use acpi_device's handle instead of driver's
      ACPI: ac: Remove unneeded acpi_handle from driver.
      ACPI: acpi_memhotplug: Remove unneeded acpi_handle from driver.
      ACPI: battery: Remove unneeded acpi_handle from driver.
      ACPI: button: Remove unneeded acpi_handle from driver.
      ACPI: fan: Remove unneeded acpi_handle from driver.
      ACPI: pci_link: Remove unneeded acpi_handle from driver.
      ACPI: pci_root: Remove unneeded acpi_handle from driver.
      ACPI: power: Remove unneeded acpi_handle from driver.
      ACPI: thermal: Remove unneeded acpi_handle from driver.
      ACPI: video: Remove unneeded acpi_handle from driver.

Rich Townsend:
      ACPI: add support for Smart Battery

Vladimir Lebedev:
      ACPI: handle battery notify event on broken BIOS

with this log:

commit 309b0f125a22ee34c8f6962677255f7bf6af5e3d
Merge: d0e5f39... 635227e...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jul 1 17:21:39 2006 -0400

    Pull smart-battery into release branch

commit d0e5f39f1ee2e55d140064bb6d74c8bad25d71d0
Merge: 361ea93... 9fdae72...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jul 1 17:21:26 2006 -0400

    Pull bugzilla-3241 into release branch

commit 361ea93cbff0e42cbc6a0f3c7a8238db9ed15648
Merge: 5f765b8... 9becf5b...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jul 1 17:20:40 2006 -0400

    Pull asus_acpi-0.30 into release branch

commit 5f765b8d68fe99c8a575265d81c62382893e1e8a
Merge: b197ba3... d07a857...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jul 1 17:19:34 2006 -0400

    Pull acpi_device_handle_cleanup into release branch

commit b197ba3c70638a3a2ae39296781912f26ac0f991
Merge: fc25465... 02438d8...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jul 1 17:19:08 2006 -0400

    Pull acpi_os_free into release branch

commit 635227ee89929a6e2920fc8aa1cd48f7225d3d93
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jul 1 16:48:23 2006 -0400

    ACPI: remove function tracing macros from drivers/acpi/*.c
    
    a few invocations appeared due to the SBS and other patches.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3f86b83243d59bb50caf5938d284d22e10d082a4
Author: Rich Townsend <rhdt@bartol.udel.edu>
Date:   Sat Jul 1 11:36:54 2006 -0400

    ACPI: add support for Smart Battery
    
    Most batteries today are ACPI "Control Method" batteries,
    but some models ship with the older "Smart Battery"
    that requires this code.
    
    Rich Townsend and Bruno Ducrot were the original authors.
    Vladimir Lebedev updated to run on latest kernel.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3734
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9becf5b91ec7b600a3cfea12724165aaaf4d4527
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Fri Jun 30 19:15:00 2006 -0400

    ACPI: asus_acpi: correct M6N/M6R display nodes
    
    This patch switches back the display nodes for M6R and M6N -- this happened
    a while ago when a patch was misapplied (only the in-tree version was
    affected).
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9fdae727645215d4dbb88912b9a176ef87911a05
Author: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
Date:   Tue Jun 27 04:49:00 2006 -0400

    ACPI: handle battery notify event on broken BIOS
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3241
    
    Signed-off-by: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 03d782524e2d0511317769521c8d5daadbab8482
Author: Christian Lupien <lupien@physique.usherbrooke.ca>
Date:   Thu Aug 19 01:26:00 2004 -0400

    ACPI: handle AC notify event on broken BIOS
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3241
    
    updated by Vladimir Lebedev
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 37672d4c5263d54ee4302f55242f6fd5317b0f9f
Merge: b2f71ba... 2df8386...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jul 1 11:06:01 2006 -0400

    Pull asus_acpi-0.30 into release branch

commit b2f71bade430d468398167d696731bf770de2db8
Merge: ba290ab... d07a857...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jul 1 11:05:19 2006 -0400

    Pull acpi_device_handle_cleanup into release branch

commit 2df8386cec47520b76822cb39d96709f5d353cf8
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Fri Jun 30 19:15:00 2006 -0400

    ACPI: asus_acpi: add S1N WLED control
    
    This patch switches back the display nodes for M6R and M6N -- this happened
    a while ago when a patch was misapplied (only the in-tree version was
    affected).
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 96d1142084281ae4601fab02be061e1267e431a3
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Fri Jun 30 19:13:00 2006 -0400

    ACPI: asus_acpi: add S1N WLED control
    
    This small patch adds back WLED control for S1N models, this was
    accidentally removed a while ago.
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ffab0d9507dc527ff6d704ec5e7e7ccfee119fb1
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Fri Jun 30 19:11:00 2006 -0400

    ACPI: asus_acpi: rework model detection
    
    This patch reworks laptop model detection.
    
    This addresses the Samsung P30 issue, where the INIT method would return no
    object, but the implicit return in the AML interpreter would confuse the
    driver. It also accounts for a newer batch of Asus models whose INIT
    returns ACPI_TYPE_BUFFER instead of STRING.
    
    The handling is now much leaner, if we get a buffer or a string, we check
    against known values, in every other case we use a different path
    (currently DSDT signatures). The bulk of this patch is separating the
    string matching from asus_hotk_get_info() into a separate function.
    
    This patch properly fixes http://bugme.osdl.org/show_bug.cgi?id=5067 and
    http://bugme.osdl.org/show_bug.cgi?id=5092 and makes the driver fully
    functional again with acpi=strict on all machines.
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ebccb84810729f0e86a83a65681ba2de45ff84d8
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Fri Jun 30 19:08:00 2006 -0400

    ACPI: asus_acpi: support L5D
    
    This patch adds support for Asus L5D and thus fixes
    http://bugme.osdl.org/show_bug.cgi?id=4695
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e067aaa7612c273d4bfd70d1bd8d80313a57685c
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Fri Jun 30 19:07:00 2006 -0400

    ACPI: asus_acpi: handle internal Bluetooth / support W5A
    
    This patch creates a new file named "bluetooth" under /proc/acpi/asus/.
    This file controls both the internal Bluetooth adapter's presence on the
    USB bus and the associated LED.
    
    echo 1 > /proc/acpi/asus/bluetooth to enable, 0 to disable.
    
    Additionally, the patch add support for Asus W5A, the first model that uses
    this feature.
    
    Patch originally by Fernando A. P. Gomes.
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f78c589d108f4b06a012817536c9ced37f473eae
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Fri Jun 30 19:06:00 2006 -0400

    ACPI: asus_acpi: support A4G
    
    This patch adds support for Asus A4G.
    Originally by Giuseppe Rota.
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c067a7899790ed4c03b00ed186c6e3b6a3964379
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Fri Jun 30 19:05:00 2006 -0400

    ACPI: asus_acpi: support W3400N
    
    This patch adds support for Asus W3400N.
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 42cb891295795ed9b3048c8922d93f7a71f63968
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Fri Jun 30 19:04:00 2006 -0400

    ACPI: asus_acpi: LED display support
    
    This patch adds handling for front LED displays found on W1N and the like.
    Additionally, W1N is given its own model_data instance.
    
    Patch originally by Éric Burghard.
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ed2cb07b2bb04f14793cdeecb0b384374e979525
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Fri Jun 30 19:03:00 2006 -0400

    ACPI: asus_acpi: support A3G
    
    This patch adds support for Asus A3G.
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a170a5317c0298538deb170028376ec1631acc2f
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Fri Jun 30 19:03:00 2006 -0400

    ACPI: asus_acpi: misc cleanups
    
    This patch updates the version string, copyright notices and does
    whitespace cleanup (it looks weird, blame Lindent).
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ba290ab7dace8b3339c0cc86c221d48eed21e956
Merge: 9262e91... 02438d8...
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jun 30 20:07:01 2006 -0400

    Pull kmalloc into release branch

commit 02438d8771ae6a4b215938959827692026380bf9
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jun 30 03:19:10 2006 -0400

    ACPI: delete acpi_os_free(), use kfree() directly
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d07a8577f695c807977af003b6e75f996e01a15f
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:52 2006 -0400

    ACPI: video: Remove unneeded acpi_handle from driver.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8a4444bf5a3fd890441e6cbd5022a3c24edbe69a
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:51 2006 -0400

    ACPI: thermal: Remove unneeded acpi_handle from driver.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 14747204055d4b8fb2f8517beca91985ac617c17
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:51 2006 -0400

    ACPI: power: Remove unneeded acpi_handle from driver.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 432bfaba7d4e70483fc5af164e020066f4921bff
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:51 2006 -0400

    ACPI: pci_root: Remove unneeded acpi_handle from driver.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e0e4e117d4c898b0df749d5b88c86955151abf53
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:50 2006 -0400

    ACPI: pci_link: Remove unneeded acpi_handle from driver.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 579c896cc91434e4feb938f780eba580c93fa0da
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:50 2006 -0400

    ACPI: fan: Remove unneeded acpi_handle from driver.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6c689537726ec665246d2f60c48475be2efac2d0
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:50 2006 -0400

    ACPI: button: Remove unneeded acpi_handle from driver.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 39cb61e26771891f843cb433ee6febd9159bce73
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:49 2006 -0400

    ACPI: battery: Remove unneeded acpi_handle from driver.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9453ece92688fedd7755d2ea54b2efe88822a91b
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:49 2006 -0400

    ACPI: acpi_memhotplug: Remove unneeded acpi_handle from driver.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1b5b8b81bddd1c5dcf690f43422e20b0e964c349
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:49 2006 -0400

    ACPI: ac: Remove unneeded acpi_handle from driver.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 901302688cb85b49a9551ec1f6aa86fb081ae49e
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:48 2006 -0400

    ACPI: video: Use acpi_device's handle instead of driver's
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 38ba7c9ed2e1a222103332031f76c28b726573f5
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:48 2006 -0400

    ACPI: thermal: Use acpi_device's handle instead of driver's
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5fbc19efdbedf9c9125774f66f80d6a6ccce4566
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:43 2006 -0400

    ACPI: power: Use acpi_device's handle instead of driver's
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2d1e0a02f16f84c2358843d91d6ca0131a0587ce
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:43 2006 -0400

    ACPI: pci_root: Use acpi_device's handle instead of driver's
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 67a7136573b24a0d1f85a4aab131558a02910d25
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:42 2006 -0400

    ACPI: pci_link: Use acpi_device's handle instead of driver's
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit dc8c2b2744f8563aa5feb07488e4cc207a70ac70
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:42 2006 -0400

    ACPI: fan: Use acpi_device's handle instead of driver's
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 27b1d3e85b1dfd9037d3fbb98b2e2aacca01da39
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:42 2006 -0400

    ACPI: button: Use acpi_device's handle instead of driver's
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3b073ec3667ee63e35b66752a30eeedef1e1e772
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:41 2006 -0400

    ACPI: battery: Use acpi_device's handle instead of driver's
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b863278523f7adbacb9e34133f4b6397cdab9977
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:41 2006 -0400

    ACPI: acpi_memhotplug: Use acpi_device's handle instead of driver's
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a6ba5ebef91a59fabd45962e576c02468dbcd33f
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:41 2006 -0400

    ACPI: ac: Use acpi_device's handle instead of driver's
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e6afa0de1476290a876dfd1237a97cce7735581c
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:40 2006 -0400

    ACPI: video: add struct acpi_device to struct acpi_video_bus.
    
    - Use it instead of acpi_bus_get_device() in acpi_video_bus_notify()
      and use the one from struct acpi_video_device in
      acpi_video_device_notify().
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 415985728895ba3127116bc4f999caf94420ed85
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:40 2006 -0400

    ACPI: power: add struct acpi_device to struct acpi_power_resource
    
    - Use it instead of acpi_bus_get_device() where we can..
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8348e1b19a06b1932f65e84e1d59be29e1626c2b
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:40 2006 -0400

    ACPI: thermal: add struct acpi_device to struct acpi_thermal.
    
    - Use it instead of acpi_bus_get_device() where we can..
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 32917e5b589d813c9dc0f2d140d8c52898ddb6fb
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:39 2006 -0400

    ACPI: pci root: add struct acpi_device to struct acpi_pci_root.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 74b142e0fe039fcde42030c064763577e11ca004
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:39 2006 -0400

    ACPI: fan: add struct acpi_device to struct acpi_fan.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 145def84a177c01cf3cc6cfbb67a029f39a8ac35
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:39 2006 -0400

    ACPI: battery: add struct acpi_device to struct acpi_battery.
    
    - Use it instead of acpi_bus_get_device()..
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3b74863df5d46f794052b5ee010cfc8fd66819dd
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:38 2006 -0400

    ACPI: acpi_memhotplug: add struct acpi_device to struct acpi_memory_device.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit af96179a8298832cc58be212d0e4988d8a1e11bf
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Fri May 19 16:54:32 2006 -0400

    ACPI: ac: Add struct acpi_device to struct acpi_ac.
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
