Return-Path: <linux-kernel-owner+w=401wt.eu-S964962AbWLTJfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWLTJfl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 04:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWLTJfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 04:35:41 -0500
Received: from hera.kernel.org ([140.211.167.34]:51338 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964956AbWLTJfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 04:35:37 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: "Torvalds, Linus" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH] ACPI patches for 2.6.20-rc1
Date: Wed, 20 Dec 2006 04:34:56 -0500
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612200434.56516.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

Highlights:

The Embedded Controller driver removes a GPE race condition.
Turns out we had been impatient with old machines, and
simply increasing an error timeout will make some of them work.

The platform specific drivers that use ACPI now send their
button events to the input layer.

Updated ibm-acpi driver from new sub-maintainer.

SGI is starting to leverage ACPI support, God bless them.

This will update the files shown below.

thanks!

-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.20/acpi-release-20060707-2.6.20-rc1.diff.gz

 Documentation/ibm-acpi.txt           |  151 ++-
 MAINTAINERS                          |    9 
 arch/i386/kernel/acpi/boot.c         |   22 
 drivers/acpi/Kconfig                 |   17 
 drivers/acpi/ac.c                    |    6 
 drivers/acpi/acpi_memhotplug.c       |    2 
 drivers/acpi/asus_acpi.c             |   69 +
 drivers/acpi/battery.c               |   22 
 drivers/acpi/button.c                |  223 +++-
 drivers/acpi/container.c             |    2 
 drivers/acpi/dock.c                  |  153 ++-
 drivers/acpi/ec.c                    |  347 +++----
 drivers/acpi/events/evmisc.c         |    1 
 drivers/acpi/executer/exmutex.c      |    6 
 drivers/acpi/fan.c                   |    6 
 drivers/acpi/glue.c                  |   10 
 drivers/acpi/hotkey.c                |    5 
 drivers/acpi/i2c_ec.c                |    2 
 drivers/acpi/ibm_acpi.c              | 1046 +++++++++++++++++++----
 drivers/acpi/namespace/nsxfobj.c     |   44 
 drivers/acpi/numa.c                  |    2 
 drivers/acpi/osl.c                   |    5 
 drivers/acpi/pci_bind.c              |    4 
 drivers/acpi/pci_irq.c               |    2 
 drivers/acpi/pci_link.c              |    8 
 drivers/acpi/pci_root.c              |   13 
 drivers/acpi/power.c                 |    6 
 drivers/acpi/processor_core.c        |   14 
 drivers/acpi/processor_idle.c        |   14 
 drivers/acpi/processor_perflib.c     |   10 
 drivers/acpi/processor_thermal.c     |    6 
 drivers/acpi/processor_throttling.c  |    6 
 drivers/acpi/sbs.c                   |   24 
 drivers/acpi/sleep/wakeup.c          |    6 
 drivers/acpi/tables.c                |    2 
 drivers/acpi/tables/tbxface.c        |   54 +
 drivers/acpi/thermal.c               |   30 
 drivers/acpi/toshiba_acpi.c          |   89 +
 drivers/acpi/utilities/utdebug.c     |    5 
 drivers/acpi/utilities/utmutex.c     |   16 
 drivers/acpi/utils.c                 |    4 
 drivers/acpi/video.c                 |  100 +-
 drivers/misc/msi-laptop.c            |    3 
 drivers/usb/misc/appledisplay.c      |    2 
 drivers/video/aty/aty128fb.c         |    2 
 drivers/video/aty/atyfb_base.c       |    2 
 drivers/video/aty/radeon_backlight.c |    2 
 drivers/video/backlight/backlight.c  |    7 
 drivers/video/nvidia/nv_backlight.c  |    2 
 drivers/video/riva/fbdev.c           |    2 
 include/acpi/acpixf.h                |    7 
 include/asm-i386/acpi.h              |   26 
 include/asm-x86_64/acpi.h            |   26 
 include/linux/backlight.h            |    2 
 kernel/power/disk.c                  |    8 
 kernel/power/main.c                  |    2 
 56 files changed, 1896 insertions(+), 760 deletions(-)

through these commits:

Adrian Bunk (2):
      ACPI: make drivers/acpi/ec.c:ec_ecdt static
      ACPI: fix NULL check in drivers/acpi/osl.c

Akinobu Mita (2):
      ACPI: fix single linked list manipulation
      ACPI: prevent processor module from loading on failures

Alexey Starikovskiy (15):
      ACPI: ec: Allow for write semantics in any command.
      ACPI: ec: Enable EC GPE at beginning of transaction
      ACPI: ec: Increase timeout from 50 to 500 ms to handle old slow machines.
      ACPI: ec: Read status register from check_status() function
      ACPI: ec: Remove expect_event and all races around it.
      ACPI: ec: Remove calls to clear_gpe() and enable_gpe(), as these are handled at
      ACPI: ec: Query only single query at a time.
      ACPI: ec: Change semaphore to mutex.
      ACPI: ec: Rename gpe_bit to gpe
      ACPI: ec: Drop udelay() from poll mode. Loop by reading status field instead.
      ACPI: ec: Acquire Global Lock under EC mutex.
      ACPI: ec: Style changes.
      ACPI: ec: Change #define to enums there possible.
      ACPI: ec: Lindent once again
      ACPI: ibm_acpi: allow clean removal

Andrew Morton (3):
      ACPI: uninline ACPI global locking functions
      ACPI: acpi-cpufreq: remove unused data when !CONFIG_SMP
      ACPI: Kconfig - depend on PM rather than selecting it

Chen, Justin (1):
      ACPI: optimize pci_rootbridge search

Dmitry Torokhov (1):
      ACPI: button: register with input layer

Henrique de Moraes Holschuh (22):
      ACPI: ibm-acpi: new ibm-acpi maintainer
      ACPI: ibm-acpi: do not use / in driver names
      ACPI: ibm-acpi: trivial Lindent cleanups
      ACPI: ibm-acpi: Use a enum to select the thermal sensor reading strategy
      ACPI: ibm-acpi: Implement direct-ec-access thermal reading modes for up to 16 sensors
      ACPI: ibm-acpi: document thermal sensor locations for the A31
      ACPI: ibm-acpi: prepare to cleanup fan_read and fan_write
      ACPI: ibm-acpi: clean up fan_read
      ACPI: ibm-acpi: break fan_read into separate functions
      ACPI: ibm-acpi: cleanup fan_write
      ACPI: ibm-acpi: document fan control
      ACPI: ibm-acpi: extend fan status functions
      ACPI: ibm-acpi: fix and extend fan enable
      ACPI: ibm-acpi: fix and extend fan control functions
      ACPI: ibm-acpi: store embedded controller firmware version for matching
      ACPI: ibm-acpi: workaround for EC 0x2f initialization bug
      ACPI: ibm-acpi: implement fan watchdog command
      ACPI: ibm-acpi: add support for the ultrabay on the T60,X60
      ACPI: ibm-acpi: make non-generic bay support optional
      ACPI: ibm-acpi: backlight device cleanup
      ACPI: ibm-acpi: style fixes and cruft removal
      ACPI: ibm-acpi: update version and copyright

Holger Macht (3):
      ACPI: ibm_acpi: Add support for the generic backlight device
      ACPI: asus_acpi: Add support for the generic backlight device
      ACPI: toshiba_acpi: Add support for the generic backlight device

James Simmons (1):
      fbdev: update after backlight argument change

Jan Engelhardt (1):
      ACPI: Remove unnecessary from/to-void* and to-void casts in drivers/acpi

Jesper Juhl (1):
      ACPI: Get rid of 'unused variable' warning in acpi_ev_global_lock_handler()

John Keller (1):
      ACPI: Add support for acpi_load_table/acpi_unload_table_id

Kristen Carlson Accardi (3):
      ACPI: dock: use mutex instead of spinlock
      ACPI: dock: Make the dock station driver a platform device driver.
      ACPI: dock: add uevent to indicate change in device status

Len Brown (3):
      ACPI: dock: fix build warning
      ACPI: ibm_acpi: respond to workqueue update
      ACPI: fix git automerge failure

Martin Bligh (1):
      ACPI: avoid gcc warnings in ACPI mutex debug code

Prarit Bhargava (1):
      ACPI: dock: Fix symbol conflict between acpiphp and dock

Rafael J. Wysocki (1):
      ACPI: S4: Use "platform" rather than "shutdown" mode by default

Randy Dunlap (1):
      ACPI: make ec_transaction not extern

Satoru Takeuchi (1):
      ACPI: update comment

Thomas Tuttle (1):
      ACPI: Implement acpi_video_get_next_level()

Yu Luming (1):
      ACPI: video: Add dev argument for backlight_device_register

brandon@ifup.org (1):
      ACPI: dock: Add a docked sysfs file to the dock driver.

with this log:

commit 5b7b4119553dd7cc0bc200c0d1b1598e158eec9a
Merge: 9774f33... 0f0fe1a...
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 20 02:53:27 2006 -0500

    Pull sgi into test branch

commit 9774f3384125912eb491ca77f77907324db3ed05
Merge: 3be11c8... f238085...
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 20 02:53:13 2006 -0500

    merge linus into test branch

commit 3be11c8f4f2fa194834c2e83540f34da442b8977
Merge: 706b75d... 6796a12...
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 20 02:52:50 2006 -0500

    Pull bugfix into test branch

commit 706b75ddbe36d20d071424f9867385c319b67f8d
Merge: 40b20c2... a854e08...
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 20 02:52:33 2006 -0500

    Pull ec into test branch

commit 40b20c257a13c5a526ac540bc5e43d0fdf29792a
Merge: cece901... a8274d5...
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 20 02:52:17 2006 -0500

    Pull platform-drivers into test branch

commit 0f0fe1a08aa421266060ac67e50453a06d9ceb63
Author: John Keller <jpk@sgi.com>
Date:   Tue Dec 19 12:56:19 2006 -0800

    ACPI: Add support for acpi_load_table/acpi_unload_table_id
    
    Make acpi_load_table() available for use by removing it from the #ifdef
    ACPI_FUTURE_USAGE.
    
    Also add a new routine used to unload an ACPI table of a given type and "id" -
    acpi_unload_table_id().  The implementation of this new routine was almost a
    direct copy of existing routine acpi_unload_table() - only difference being
    that it only removes a specific table id instead of ALL tables of a given
    type.  The SN hotplug driver (sgi_hotplug.c) now uses both of these interfaces
    to dynamically load and unload SSDT ACPI tables.
    
    Also, a few other ACPI routines now used by the SN hotplug driver are exported
    (since the driver can be a loadable module):
    
     acpi_ns_map_handle_to_node
     acpi_ns_convert_entry_to_handle
     acpi_ns_get_next_node
    
    Signed-off-by: Aaron Young <ayoung@sgi.com>
    Cc: Greg KH <greg@kroah.com>
    Cc: "Luck, Tony" <tony.luck@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a8274d57afb83e4954ddcb3f8b7dd1c03a379bd4
Author: James Simmons <jsimmons@infradead.org>
Date:   Tue Dec 19 12:56:16 2006 -0800

    fbdev: update after backlight argument change
    
    Update the frambuffer drivers to the backlight_device_registers changes.
    
    Signed-off-by: James Simmons <jsimmons@infradead.org>
    Cc: Luming Yu <Luming.yu@intel.com>
    Cc: "Antonino A. Daplas" <adaplas@pol.net>
    Cc: Greg KH <greg@kroah.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 519ab5f2be65b72cf12ae99c89752bbe79b44df6
Author: Yu Luming <luming.yu@gmail.com>
Date:   Tue Dec 19 12:56:15 2006 -0800

    ACPI: video: Add dev argument for backlight_device_register
    
    This patch set adds generic abstract layer support for acpi video driver to
    have generic user interface to control backlight and output switch control by
    leveraging the existing backlight sysfs class driver, and by adding a new
    video output sysfs class driver.
    
    This patch:
    
    Add dev argument for backlight_device_register to link the class device to
    real device object.  The platform specific driver should find a way to get the
    real device object for their video device.
    
    [akpm@osdl.org: build fix]
    [akpm@osdl.org: fix msi-laptop.c]
    Signed-off-by: Luming Yu <Luming.yu@intel.com>
    Cc: "Antonino A. Daplas" <adaplas@pol.net>
    Cc: Greg KH <greg@kroah.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f4715189dfb1c381ad36b7e02e3716fb7a7f84db
Author: Thomas Tuttle <linux-kernel@ttuttle.net>
Date:   Tue Dec 19 12:56:14 2006 -0800

    ACPI: Implement acpi_video_get_next_level()
    
    acpi_video_get_next_level was supposed to implement an algorithm to select
    a new brightness level based on the old brightness level of an ACPI video
    device, but it simply says "/* Fix me */" and returns the current
    brightness.
    
    This patch implements acpi_video_get_next_level properly.  It had to change
    a few constants at the top of the file because they were (apparently)
    wrong, but it appears to work on my Dell Inspiron e1405 (with BIOS A05
    only--BIOS A04 doesn't seem to send ACPI video hotkey events).
    
    [akpm@osdl.org: cleanups]
    Signed-off-by: Thomas Tuttle <linux-kernel@ttuttle.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6796a1204cfeac6dab1c2dd682d1138454eca661
Author: Andrew Morton <akpm@osdl.org>
Date:   Tue Dec 19 12:56:13 2006 -0800

    ACPI: Kconfig - depend on PM rather than selecting it
    
    Make ACPI depend on PM rather than selecting it.
    Otherwise it's a nightmare working out why CONFIG_PM keeps getting set.
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a6fdbf90b94fa4e2f5f7cbb526c71160b6c561c8
Author: Adrian Bunk <bunk@stusta.de>
Date:   Tue Dec 19 12:56:13 2006 -0800

    ACPI: fix NULL check in drivers/acpi/osl.c
    
    Spotted by the Coverity checker.
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a854e08a5a4f57d54991b3a40a80823dd548339d
Author: Adrian Bunk <bunk@stusta.de>
Date:   Tue Dec 19 12:56:12 2006 -0800

    ACPI: make drivers/acpi/ec.c:ec_ecdt static
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 83822fc9e6ad2e0f3799174f7c6ad3aa285b9488
Author: Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue Dec 19 12:56:10 2006 -0800

    ACPI: prevent processor module from loading on failures
    
    Make loading processor.ko fail when an error happens.
    
    Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f10bb2544bab75b3e8df15a7b51a833c78cbd77f
Author: Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue Dec 19 12:56:09 2006 -0800

    ACPI: fix single linked list manipulation
    
    Fix single linked list manipulation for sub_driver.  If the remving entry
    is not on the head of the sub_driver list, it goes into infinate loop.
    
    Though that infinite loop doesn't happen.  Because the only user of
    acpi_pci_register_dirver() is acpiphp.
    
    Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4afaf54b3b97fa8cf2d1d9bcd7612b195acb53ae
Author: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Date:   Mon Dec 18 14:53:33 2006 -0300

    ACPI: ibm_acpi: allow clean removal
    
    Allow clean removal by setting notify_installed in the right place.
    
    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cece901481bafbf14de8cbd3a89ae869ea881055
Merge: cfee47f... 50dd096...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 16 01:04:27 2006 -0500

    Pull style into test branch
    
    Conflicts:
    
    	drivers/acpi/button.c
    	drivers/acpi/ec.c
    	drivers/acpi/osl.c
    	drivers/acpi/sbs.c

commit cfee47f99bc14a6d7c6b0be2284db2cef310a815
Merge: 7e24432... 9185cfa...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 16 01:01:18 2006 -0500

    Pull bugfix into test branch
    
    Conflicts:
    
    	kernel/power/disk.c

commit 7e244322cd4ea361ef9ee623b3fcb4d9f4ff841c
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 16 00:59:38 2006 -0500

    ACPI: fix git automerge failure
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 463e7c7cf9aaf95dd05e97e1a47854fdf5454cdc
Merge: 25c68a3... 7d63c67...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 16 00:45:07 2006 -0500

    Pull trivial into test branch
    
    Conflicts:
    
    	drivers/acpi/ec.c

commit 25c68a33b7b74b37793b1250007e5e21d621a7fc
Author: Len Brown <len.brown@intel.com>
Date:   Fri Dec 8 04:43:41 2006 -0500

    ACPI: ibm_acpi: respond to workqueue update
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6bfe5c9d6f4dcaa998f67e691359cf7b1c4b443d
Merge: b361735... f9ff43a...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 16 00:34:18 2006 -0500

    Pull platform-drivers into test branch

commit b361735043e3001eadb1d40916fd1a4fca1a9363
Merge: fb76655... c0968f0...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 16 00:34:00 2006 -0500

    Pull button into test branch

commit fb7665544dd60e016494cd5531f5b65ddae22ddc
Merge: 678f2b7... 8ea86e0...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 16 00:33:45 2006 -0500

    Pull dock into test branch

commit 678f2b7df24c34f90fee264fa3a8069bca9c99ad
Merge: d1998ef... 6ccedb1...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 16 00:32:42 2006 -0500

    Pull ec into test branch

commit 8ea86e0ba7c9d16ae0f35cb0c4165194fa573f7a
Author: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Date:   Mon Dec 11 12:05:08 2006 -0800

    ACPI: dock: add uevent to indicate change in device status
    
    Send a uevent to indicate a device change whenever we dock or
    undock, so that userspace may now check the dock status via sysfs.
    
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Holger Macht <hmacht@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6ccedb10e39c34a4cb68f6c8dae67ecdd3e0b138
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:17 2006 +0300

    ACPI: ec: Lindent once again
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3261ff4db3a33ac7e1b9ed98e905663845cadbc6
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:17 2006 +0300

    ACPI: ec: Change #define to enums there possible.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 78d0af3392cba6dfdd1dc1eab5a86ba8e4af8fff
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:17 2006 +0300

    ACPI: ec: Style changes.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 523953b41e52952347d7d50dcc4bfc27bc001dc8
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:17 2006 +0300

    ACPI: ec: Acquire Global Lock under EC mutex.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 50c1e1138cb94f6aca0f8555777edbcefe0324e2
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:17 2006 +0300

    ACPI: ec: Drop udelay() from poll mode. Loop by reading status field instead.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a86e277259b08be0f00cfcb182922da3ffc50f04
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:16 2006 +0300

    ACPI: ec: Rename gpe_bit to gpe
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c787a8551e7fee85366962881e7a4f2fda656dfc
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:16 2006 +0300

    ACPI: ec: Change semaphore to mutex.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5d0c288b7362ad7ee235b59352ac2a89480e4757
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:16 2006 +0300

    ACPI: ec: Query only single query at a time.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e41334c0a6ef71458f255db25f011d15099e7cca
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:16 2006 +0300

    ACPI: ec: Remove calls to clear_gpe() and enable_gpe(), as these are handled at
    
    dispatch_gpe() level.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit af3fd1404fd4f0f58ebbb52b22be4f1ca0794cda
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:16 2006 +0300

    ACPI: ec: Remove expect_event and all races around it.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bec5a1e0604d1b829b87b4b7e85f71ccc43dda50
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:16 2006 +0300

    ACPI: ec: Read status register from check_status() function
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5c4064124a5720a2576eb4bd5b7200d70052e9b5
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:16 2006 +0300

    ACPI: ec: Increase timeout from 50 to 500 ms to handle old slow machines.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=7466
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5d57a6a55ec0bdcb952dbcd3f8ffcde8a3ee9413
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:16 2006 +0300

    ACPI: ec: Enable EC GPE at beginning of transaction
    
    Temporary measure until resume sequence is right.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d91df1aaa9e4c06f8ea10d4935888c4f1976ef56
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 7 18:42:16 2006 +0300

    ACPI: ec: Allow for write semantics in any command.
    
    Check for transaction attributes, not command index to decide on event to
    expect.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2548c06b72396e28abdb5dd572ab589c3c22f4b9
Author: Prarit Bhargava <prarit@redhat.com>
Date:   Mon Dec 4 14:50:17 2006 -0800

    ACPI: dock: Fix symbol conflict between acpiphp and dock
    
    Fix bug which will cause acpiphp to not be able to load when dock.ko
    cannot load.
    
    Signed-off-by: Prarit Bhargava <prarit@redhat.com>
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c80fdbe81a617c82e2f95233f8ddcf046ffe21b3
Author: brandon@ifup.org <brandon@ifup.org>
Date:   Mon Dec 4 14:49:58 2006 -0800

    ACPI: dock: Add a docked sysfs file to the dock driver.
    
    Add 2 sysfs files for user interface.
    1) docked - 1/0 (read only) - indicates whether the software believes the
    laptop is docked in a docking station.
    2) undock - (write only) - writing to this file causes the software to
    initiate an undock request to the firmware.
    
    Signed-off-by: Brandon Philips <brandon@ifup.org>
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e67beb37df7a9da9d5d1e59c5358654d007a97c5
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 7 04:17:35 2006 -0500

    ACPI: dock: fix build warning
    
    drivers/acpi/dock.c:689: warning: too many arguments for format
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 671adbec210efc15cef81b4616adae8bcd667296
Author: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Date:   Mon Dec 4 14:49:43 2006 -0800

    ACPI: dock: Make the dock station driver a platform device driver.
    
    Make the dock station driver a platform device driver so that
    we can create sysfs entries under /sys/device/platform.
    
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f9ff43a6268d36acf8df18a76bb881a26a42dc1e
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Nov 25 16:37:38 2006 -0200

    ACPI: ibm-acpi: update version and copyright
    
    Bump up module version, add myself to copyright and MODULE_AUTHOR.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 9a8e1738c1136a857c1fd3ae0c5019f9767427ad
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Nov 25 16:36:00 2006 -0200

    ACPI: ibm-acpi: style fixes and cruft removal
    
    This patch just fixes style, move some #defines to enums, and removes some
    old cruft.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit fb87a811a4c232e2af8d746dc75330cbe5b0780c
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Nov 25 16:35:09 2006 -0200

    ACPI: ibm-acpi: backlight device cleanup
    
    This patch cleans up the recently added backlight device support by Holger
    Macht <hmacht@suse.de> to fit well with the rest of the code, using the
    ibms struct as the other "subdrivers" in ibm-acpi.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 2df910b4c3edcce9a0c12394db6f5f4a6e69c712
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Nov 25 16:35:09 2006 -0200

    ACPI: ibm-acpi: make non-generic bay support optional
    
    This patch makes it possible to disable ibm-acpi non-generic bay support,
    as generic bay support already works well for a number of ThinkPads.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit e0298997acdba929e7f5b5987d305b67b50a3969
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Nov 25 16:35:09 2006 -0200

    ACPI: ibm-acpi: add support for the ultrabay on the T60,X60
    
    This patch adds support for the ultrabay on the T60, X60 and other new
    ThinkPads that have a SATA ultrabay.
    
    I intend to keep bay and dock support in ibm-acpi working and updated until
    it finally gets deprecated and removed in favour of the generic dock and
    bay support.  But we aren't there yet.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 16663a87ad1df7022661bc8813b7a2e84e7f5e66
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:14 2006 -0200

    ACPI: ibm-acpi: implement fan watchdog command
    
    This patch implements a fan control safety watchdog, by request of the
    authors of userspace fan control scripts.
    
    When the watchdog timer expires, the equivalent action of a "fan enable"
    command is executed.  The watchdog timer is reset at every reception of a
    fan control command that could change the state of the fan itself.
    
    This command is meant to be used by userspace fan control daemons, to make
    sure the fan is never left set to an unsafe level because of userspace
    problems.
    
    Users of the X31/X40/X41 "speed" command are on their own, the current
    implementation of "speed" is just too incomplete to be used safely,
    anyway.  Better to never use it, and just use the "level" command instead.
    
    The watchdog is programmed using echo "watchdog <number>" > fan, where
    number is the number of seconds to wait before doing an "enable", and zero
    disables the watchdog.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 778b4d742b210b9cac31f223527f30f1fc70312b
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:14 2006 -0200

    ACPI: ibm-acpi: workaround for EC 0x2f initialization bug
    
    A few ThinkPads fail to initialize EC register 0x2f both in the EC
    firmware and ACPI DSDT.  If the BIOS and the ACPI DSDT also do not
    initialize it, then the initial status of that register does not
    correspond to reality.
    
    On all reported buggy machines, EC 0x2f will read 0x07 (fan level 7) upon
    cold boot, when the EC is actually in mode 0x80 (auto mode).  Since
    returning a text string ("unknown") would break a number of userspace
    programs, instead we correct the reading for the most probably correct
    answer, and return it is in auto mode.
    
    The workaround flags the status and level as unknown on module load/kernel
    boot, until we are certain at least one fan control command was issued,
    either by us, or by something else.
    
    We don't work around the bug by doing a "fan enable" at module
    load/startup (which would initialize the EC register) because it is not
    known if these ThinkPad ACPI DSDT might have set the fan to level 7
    instead of "auto" (we don't know if they can do this or not) due to a
    thermal condition, and we don't want to override that, should they be
    capable of it.
    
    We should be setting the workaround flag to "status known" upon resume, as
    both reports and a exaustive search on the DSDT tables at acpi.sf.net show
    that the DSDTs always enable the fan on resume, thus working around the
    bug.  But since we don't have suspend/resume handlers in ibm-acpi yet and
    the "EC register 0x2f was modified" logic is likely to catch the change
    anyway, we don't.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 49a13cd6a2acd284ee106eaea7eeea8f2cc6796a
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:13 2006 -0200

    ACPI: ibm-acpi: store embedded controller firmware version for matching
    
    This patch changes the ThinkPad Embedded Controller DMI matching
    code to store the firmware version of the EC for later usage, e.g.
    for quirks.
    
    It also prints the firmware version when starting up.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit a12095c2b50c8a7c80517e37c00d6e6c863d43c5
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:13 2006 -0200

    ACPI: ibm-acpi: fix and extend fan control functions
    
    This patch extend fan control functions, implementing enable/disable for
    all write access modes, implementing level control for all level-capable
    write access modes.
    
    The patch also updates the documentation, explaining levels auto and
    disengaged.
    
    ABI changes:
    	1. Support level 0 as an equivalent to disable
    	2. Add support for level auto and level disengaged when doing
    	   EC 0x2f fan control
    	3. Support enable/disable for all level-based write access modes
    	4. Add support for level command on FANS thinkpads, as per
    	   thinkwiki reports
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 1c6a334e9c028c2b72c5350650cb14e6d5fdc232
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:12 2006 -0200

    ACPI: ibm-acpi: fix and extend fan enable
    
    This patch fix fan enable to attempt to do the right thing and not slow
    down the fan if it is forced to the maximum speed.  It also extends fan
    enable to work on older thinkpads.
    
    ABI changes:
    	1.  Support enable/disable for all level-based write access modes
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit bab812a329cc244ca63c2675b0e05016518855ce
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:12 2006 -0200

    ACPI: ibm-acpi: extend fan status functions
    
    This patch fixes fan_read to return correct values for all fan access
    modes.  It also implements some fan access mode status output that was
    missing, and normalizes the proc fan abi to return consistent data across
    all fan read/write modes.
    
    Userspace ABI changes and extensions:
    	1. Return status: enable/disable for *all* modes
    	   (this actually improves compatibility with userspace utils!)
    	2. Return level: auto and level: disengaged for EC 2f access mode
    	3. Return level: <number> for EC 0x2f access mode
    	4. Return level 0 as well as "disabled" in level-aware modes
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit a8b7a6626d7605a795b33317cd730b7d76da3d0a
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:11 2006 -0200

    ACPI: ibm-acpi: document fan control
    
    This patch documents the ThinkPad fan control strategies.  Source of the
    data:
    
    0. ibm-acpi source
    1. DSDTs for various ThinkPads (770, X31, X40, X41, T43, A21m, T22)
    2. http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
    3. http://thinkwiki.org/wiki/How_to_control_fan_speed
    4. Various threads about windows fan control utilities in thinkpads.com
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 18ad7996e17649d81c15a2c9dae03c75050a05a8
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:11 2006 -0200

    ACPI: ibm-acpi: cleanup fan_write
    
    This patch cleans up fan_write so that it is much easier to read and
    extend.  It separates the proc api handling from the operations themselves.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit c52f0aa574246f133a0bc2041e9468a06d34da7b
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:10 2006 -0200

    ACPI: ibm-acpi: break fan_read into separate functions
    
    This patch breaks fan_read mechanics into a generic function to get fan
    status and speed, and leaves only the procfs interface code in fan_read.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 3ef8a6096ca98d45a54999a97c7c8e14977d2e3e
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:10 2006 -0200

    ACPI: ibm-acpi: clean up fan_read
    
    This patch cleans up fan_read so that it is much easier to read and
    extend.
    
    The patch fixes the userspace ABI to return "status: not supported" (like
    all other ibm-acpi functions) when neither fan status or fan control are
    possible.
    
    It also fixes the userspace ABI to return EIO if ACPI access to the EC
    fails, instead of returning "status: unreadable" or "speed: unreadable".
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 69ba91cbd6d79aa197adbdd10a44e71c84044b44
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:09 2006 -0200

    ACPI: ibm-acpi: prepare to cleanup fan_read and fan_write
    
    This patch lays some groundwork for a fan_read and fan_write cleanup in the
    next patches.  To do so, it provides a new fan_init initializer, and also some
    constants (through enums).
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 88679a15b3a84366e90cee2a84973abef962b727
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:09 2006 -0200

    ACPI: ibm-acpi: document thermal sensor locations for the A31
    
    The A31 has a very atypical layout, so I separated its thermal sensors
    location in a separate patch.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 60eb0b35a9cc3400251cb4028d100e350649cf8a
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:08 2006 -0200

    ACPI: ibm-acpi: Implement direct-ec-access thermal reading modes for up to 16 sensors
    
    This patch extends ibm-acpi to support reading thermal sensors directly
    through ACPI EC register access.  It uses a DMI match to detect ThinkPads
    with a new-style embedded controller, that are known to have forward-
    compatible register maps and use 0x00 to fill in non-used registers and
    export thermal sensors at EC offsets 0x78-7F and 0xC0-C7.
    
    Direct ACPI EC register access is implemented for 8-sensor and 16-sensor
    new-style ThinkPad controller firmwares as an experimental feature.  The
    code does some limited sanity checks on the temperatures read through EC
    access, and will default to the old ACPI TMP0-7 mode if anything is amiss.
    
    Userspace ABI is not changed for 8 sensors, but /proc/acpi/ibm/thermal is
    extended for 16 sensors if the firmware supports 16 sensors.
    
    A documentation update is also provided.
    
    The information about the ThinkPad register map was determined by studying
    ibm-acpi "ecdump" output from various ThinkPad models, submitted by
    subscribers of the linux-thinkpad mailinglist.  Futher information was
    gathered from the DSDT tables, as they describe the EC register map in
    recent ThinkPads.
    
    DSDT source shows that TMP0-7 access and direct register access are
    actually the same thing on these firmwares, but unfortunately IBM never
    did update their DSDT EC register map to export TMP8-TMP15 for the second
    range of sensors.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit a26f878abcd0491906b5bbac8dd174f27019e907
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:08 2006 -0200

    ACPI: ibm-acpi: Use a enum to select the thermal sensor reading strategy
    
    This patch consolidades all decisions regarding the strategy to be used to
    read thinkpad thermal sensors into a single enum, and refactors the
    thermal sensor reading code to use a much more readable (and easier to
    extend) switch() construct, in a separate function.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 8d29726434697a5ed08d4e0dfba9399a098922f4
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 11:47:07 2006 -0200

    ACPI: ibm-acpi: trivial Lindent cleanups
    
    This patch just makes drives/acpi/ibm-acpi.c Lindent-clean, as requested by
    Len Brown.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 3dfd35cd214f7874c4917dfedff81f107d845c15
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Fri Nov 24 10:32:32 2006 -0200

    ACPI: ibm-acpi: do not use / in driver names
    
    ibm-acpi uses sub-device names like ibm/hotkey, which get in the way of
    a sysfs conversion.  Fix it to use ibm_hotkey instead.  Thanks to Zhang
    Rui for noticing this.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

commit 7d63c6759188b9b35c789159f6e02cd02d49ec7d
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Wed Nov 8 13:18:29 2006 -0200

    ACPI: ibm-acpi: new ibm-acpi maintainer
    
    I will be taking care of ibm-acpi maintenance for now on, with Borislav's
    blessing.  Many thanks to Borislav Deianov for writing this driver and for
    the many years he took care of it: his efforts made our ThinkPads much nicer
    devices to run Linux on, and are very much appreciated.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Cc: Borislav Deianov <borislav@users.sourceforge.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c0968f0ea21d10b6720246e1e96bd6a7a161964d
Author: Dmitry Torokhov <dtor@insightbb.com>
Date:   Thu Nov 9 00:40:13 2006 -0500

    ACPI: button: register with input layer
    
    In addition to signalling button/lid events through /proc/acpi/event,
    create separate input devices and report KEY_POWER, KEY_SLEEP and
    SW_LID through input layer.  Also remove unnecessary casts and variable
    initializations, clean up formatting.
    
    Sleep button may autorepeat but userspace will have to filter duplicate
    sleep requests anyway (and discard unprocessed events right after
    wakeup).
    
    Unlike /proc/acpi/event interface input device corresponding to LID
    switch reports true lid state instead of just a counter. SW_LID is
    active when lid is closed.
    
    The driver now depends on CONFIG_INPUT.
    
    Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b7b09b1cdf4de7e28424250972d4a5526e5bdfb9
Author: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
Date:   Thu Nov 2 19:08:57 2006 +0900

    ACPI: update comment
    
    Fixing wrong description for acpi_gpe_sleep_prepare().
    
    acpi_gpe_sleep_prepare() had only used on power off and was changed
    to also used on entering some sleep state. However its description
    isn't changed yet.
    
    Signed-off-by: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6b15484ccb91e85100cf164067bf3bc6c5038726
Author: Jesper Juhl <jesper.juhl@gmail.com>
Date:   Thu Nov 2 13:13:22 2006 +0100

    ACPI: Get rid of 'unused variable' warning in acpi_ev_global_lock_handler()
    
    Fix this warning :
      drivers/acpi/events/evmisc.c: In function `acpi_ev_global_lock_handler':
      drivers/acpi/events/evmisc.c:334: warning: unused variable `status'
    
    Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9185cfa92507d07ac787bc73d06c42222eec7239
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Wed Nov 1 13:23:14 2006 +0100

    ACPI: S4: Use "platform" rather than "shutdown" mode by default
    
    It has been reported that on some systems the functionality after a resume
    from disk is limited if the system is simply powered off during the suspend
    instead of using the ACPI S4 suspend (aka platform mode).
    
    Unfortunately the default is currently to power off the system during the
    suspend so the users of these systems experience problems after the resume
    if they don't switch to the platform mode explicitly.  This patch makes swsusp
    use the platform mode by default to avoid such situations.
    
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Stefan Seyfried <seife@suse.de>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8b0dc866dd9b8d10a53cb3537385a51b7ee54b62
Author: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Date:   Mon Oct 30 11:18:45 2006 -0800

    ACPI: dock: use mutex instead of spinlock
    
    http://bugzilla.kernel.org/show_bug.cgi?id=7303
    
    Use a mutex instead of a spinlock for locking the
    hotplug list because we need to call into the ACPI
    subsystem which might sleep.
    
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2f000f5c153e984d5c166e42a9d38113de8693b3
Author: Chen, Justin <justin.chen@hp.com>
Date:   Tue Oct 10 17:07:00 2006 -0400

    ACPI: optimize pci_rootbridge search
    
    acpi_get_pci_rootbridge_handle() walks the ACPI name space
    searching for seg, bus and the PCI_ROOT_HID_STRING --
    returning the handle as soon as if find the match.
    
    But the current codes always parses through the whole namespace because
    the user_function find_pci_rootbridge() returns status=AE_OK when it finds the match.
    
    Make the find_pci_rootbridge() return AE_CTRL_TERMINATE when it finds the match.
    This reduces the ACPI namespace walk for acpi_get_pci_rootbridge_handle().
    
    Signed-off-by: Justin Chen <justin.chen@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 616362de2fe224512fe105aec08f19f5470afb01
Author: Randy Dunlap <randy.dunlap@oracle.com>
Date:   Fri Oct 27 01:47:34 2006 -0400

    ACPI: make ec_transaction not extern
    
    Fix sparse warning:
    drivers/acpi/ec.c:372:12: warning: function 'ec_transaction' with external linkage has definition
    
    Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c92635572489b810d03acdf03f61bf6dd1af5433
Author: Holger Macht <hmacht@suse.de>
Date:   Fri Oct 20 14:30:29 2006 -0700

    ACPI: toshiba_acpi: Add support for the generic backlight device
    
    Add support for the generic backlight interface below /sys/class/backlight.
    Keep the procfs brightness handling for backward compatibility.
    
    To achive this, add two generic functions get_lcd and set_lcd
    to be used both by the procfs related and the sysfs related methods.
    
    [apw@shadowen.org: backlight users need to select BACKLIGHT_CLASS_DEVICE]
    
    Signed-off-by: Holger Macht <hmacht@suse.de>
    Signed-off-by: Andy Whitcroft <apw@shadowen.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2039a6eb72d4b5d0dd71de5c4dff5db129848c44
Author: Holger Macht <hmacht@suse.de>
Date:   Fri Oct 20 14:30:29 2006 -0700

    ACPI: asus_acpi: Add support for the generic backlight device
    
    Add support for the generic backlight interface below /sys/class/backlight.
    Keep the procfs brightness handling for backward compatibility.
    
    [apw@shadowen.org: backlight users need to select BACKLIGHT_CLASS_DEVICE]
    
    Signed-off-by: Holger Macht <hmacht@suse.de>
    Signed-off-by: Andy Whitcroft <apw@shadowen.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8acb025085aa88c41063bfa0f2c3b4d0a3f2ef11
Author: Holger Macht <hmacht@suse.de>
Date:   Fri Oct 20 14:30:28 2006 -0700

    ACPI: ibm_acpi: Add support for the generic backlight device
    
    Add support for the generic backlight interface below /sys/class/backlight.
    The patch keeps the procfs brightness handling for backward compatibility.
    
    Add two generic functions brightness_get and brightness_set
    to be used both by the procfs related and the sysfs related methods.
    
    [apw@shadowen.org: backlight users need to select BACKLIGHT_CLASS_DEVICE]
    
    Signed-off-by: Holger Macht <hmacht@suse.de>
    Signed-off-by: Andy Whitcroft <apw@shadowen.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5c5e81aaa821822309fd2663c22c94ca0802e407
Author: Andrew Morton <akpm@osdl.org>
Date:   Fri Oct 20 14:30:30 2006 -0700

    ACPI: acpi-cpufreq: remove unused data when !CONFIG_SMP
    
    acpi-cpufreq.c, speedstep-centrino.c: warning: 'sw_any_bug_dmi_table' defined but not used
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d0a9081b1e75ba62bb4450c5b8e8299a41d25278
Author: Andrew Morton <akpm@osdl.org>
Date:   Fri Oct 20 14:30:27 2006 -0700

    ACPI: uninline ACPI global locking functions
    
    - Fixes a build problem with CONFIG_M386=y (include file dependencies get
      messy).
    
    - Share the implementation between x86 and x86_64
    
    - These are too big to inline anyway.
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 965a3d447276491b7ed053b25679c062beb04194
Author: Martin Bligh <mbligh@google.com>
Date:   Fri Oct 20 14:30:26 2006 -0700

    ACPI: avoid gcc warnings in ACPI mutex debug code
    
    32bit vs 64 bit issues.  sizeof(sizeof) and sizeof(pointer) is variable,
    but we're trying to print it as unsigned int or u32.
    
    Casts to unsigned long are used because type acpi_thread_id can be any one of
    
    typedef u64 acpi_native_uint;
    typedef u32 acpi_native_uint;
    typedef u16 acpi_native_uint;
    #define acpi_thread_id struct task_struct *
    
    Signed-off-by: Martin J. Bligh <mbligh@google.com>
    Acked-by: Jeff Garzik <jeff@garzik.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 50dd096973f1d95aa03c6a6d9e148d706b62b68e
Author: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date:   Sun Oct 1 00:28:50 2006 +0200

    ACPI: Remove unnecessary from/to-void* and to-void casts in drivers/acpi
    
    Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
    Signed-off-by: Len Brown <len.brown@intel.com>
