Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752119AbWJNH7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbWJNH7F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 03:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbWJNH7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 03:59:05 -0400
Received: from hera.kernel.org ([140.211.167.34]:21632 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1752118AbWJNH7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 03:59:01 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Linus Torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [GIT PATCH] ACPI for 2.6.19-rc2
Date: Sat, 14 Oct 2006 04:01:13 -0400
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610140401.14440.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

All of these patches have been through -mm, and have been
re-based to apply cleanly to 2.6.19-rc2

The C-state  changes add support for recently released
MONITOR/MWAIT hardware extensions for deep C-states -- a lower overhead
method than the IO port method they replace.

The EC driver deltas are a long overdue clean-up -- no significant functionality.

The msi-laptop driver is new.  Although we are at rc2, I think it is a good idea
to push it upstream b/c it is a better example than the current upstream
platform-specific drivers at using ACPI without _exposing_ ACPI to the user.
Andrew seemed supportive of me not waiting to push it upstream, so here you go.

thanks!

-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.19/acpi-test-20060707-2.6.19-rc2.diff.gz

 Documentation/ibm-acpi.txt     |   75 -
 MAINTAINERS                    |    7 
 arch/i386/kernel/acpi/boot.c   |   10 
 arch/i386/kernel/acpi/cstate.c |  122 +++
 arch/i386/kernel/process.c     |   22 
 arch/x86_64/kernel/process.c   |   22 
 drivers/acpi/asus_acpi.c       |   67 -
 drivers/acpi/battery.c         |   14 
 drivers/acpi/ec.c              | 1096 +++++++----------------------
 drivers/acpi/events/evmisc.c   |   14 
 drivers/acpi/events/evrgnini.c |   13 
 drivers/acpi/ibm_acpi.c        |    2 
 drivers/acpi/motherboard.c     |    6 
 drivers/acpi/osl.c             |   34 
 drivers/acpi/pci_link.c        |    2 
 drivers/acpi/power.c           |    9 
 drivers/acpi/processor_core.c  |    2 
 drivers/acpi/processor_idle.c  |  103 +-
 drivers/acpi/sbs.c             |   20 
 drivers/acpi/tables/tbget.c    |    2 
 drivers/acpi/tables/tbrsdt.c   |    2 
 drivers/misc/Kconfig           |   19 
 drivers/misc/Makefile          |    1 
 drivers/misc/msi-laptop.c      |  395 ++++++++++
 include/acpi/pdc_intel.h       |    9 
 include/acpi/processor.h       |   18 
 include/asm-i386/processor.h   |    2 
 include/asm-x86_64/processor.h |    2 
 include/linux/acpi.h           |    3 
 29 files changed, 1088 insertions(+), 1005 deletions(-)

through these commits:

Alexey Dobriyan (1):
      ACPI: asus_acpi: don't printk on writing garbage to proc files

Alexey Y. Starikovskiy (2):
      ACPI: Remove deferred execution from global lock acquire wakeup path
      ACPI: created a dedicated workqueue for notify() execution

Darren Jenkins (1):
      ACPI: asus_acpi: fix proc files parsing

Denis M. Sadykov (5):
      ACPI: EC: Remove unnecessary delay added by previous transation patch.
      ACPI: EC: Remove unused variables and duplicated code
      ACPI: EC: Unify poll and interrupt mode transaction functions
      ACPI: EC: Unify poll and interrupt gpe handlers
      ACPI: EC: Simplify acpi_hw_low_level*() with inb()/outb().

Dmitry Torokhov (1):
      ACPI: fix potential OOPS in power driver with CONFIG_ACPI_DEBUG

Eiichiro Oiwa (1):
      ACPICA: Fix incorrect handling of PCI Express Root Bridge _HID

Jiri Kosina (2):
      ACPI: acpi_pci_link_set() can allocate with either GFP_ATOMIC or GFP_KERNEL
      ACPI: check battery status on resume for un/plug events during sleep

Kimball Murray (1):
      ACPI: SCI interrupt source override

Lebedev, Vladimir P (2):
      ACPI: sbs: check for NULL device pointer
      ACPI: sbs: fix module_param() initializers

Len Brown (1):
      ACPI: update comments in motherboard.c

Lennart Poettering (3):
      ACPI: consolidate functions in acpi ec driver
      ACPI: EC: export ec_transaction() for msi-laptop driver
      MSI S270 Laptop support: backlight, wlan, bluetooth states

Marek W (1):
      ACPI: asus_acpi: W3000 support

Pavel Machek (1):
      ACPI: ibm_acpi: delete obsolete documentation

Pierre Ossman (1):
      ACPI: fix section for CPU init functions

Randy Dunlap (1):
      ACPI: fix printk format warnings

Stefan Schmidt (3):
      ACPI: ibm_acpi: Remove experimental status for brightness and volume.
      ACPI: ibm_acpi: Update documentation for brightness and volume.
      ACPI: ibm_acpi: Documentation the wan feature.

Venkatesh Pallipadi (1):
      ACPI: Processor native C-states using MWAIT

with this log:

commit 9aaed2b42d00d4abb2748d72d599a8033600e2bf
Merge: 18d508b... a790b32...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Oct 14 02:28:07 2006 -0400

    Pull trivial into test branch

commit 18d508bf5144e645443e80c606ed513f77369a50
Merge: 384bc8f... 281ea49...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Oct 14 02:27:52 2006 -0400

    Pull sci into test branch

commit 384bc8f07075804b9ce8807ed54dd7a483bd749a
Merge: e0749be... 37605a6...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Oct 14 02:26:42 2006 -0400

    Pull bugzilla-5534 into test branch

commit e0749be933c3b0c4498d693524b0aa15cbdf0f8b
Merge: ed3269a... 8c4c731...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Oct 14 02:26:18 2006 -0400

    Pull msi-laptop into test branch

commit ed3269a31be516db7e5c415703e7c8eb09751083
Merge: d7321ad... ab9e43c...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Oct 14 02:26:10 2006 -0400

    Pull ec into test branch

commit d7321ad2936c48a95af5187d4d676118cb59aa5f
Merge: 1d5b30f... 991528d...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Oct 14 02:25:59 2006 -0400

    Pull mwait into test branch

commit 1d5b30fc339fe2865599c70486abccc18200317d
Merge: c92fd49... 34c4415...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Oct 14 02:25:48 2006 -0400

    Pull battery into test branch

commit c92fd49c547c607e23b2687f0f65f762b7210035
Merge: 9443d7c... 2fe6dff...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Oct 14 02:25:40 2006 -0400

    Pull ibm into test branch

commit 9443d7c93499e2b4bd37d30c09e8ac3aa4208466
Merge: aeb1104... 6df0570...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Oct 14 02:25:33 2006 -0400

    Pull asus into test branch

commit 34c4415ab857dc6d51db08d62bcd45d4b8513bb6
Author: Jiri Kosina <jikos@jikos.cz>
Date:   Tue Oct 10 14:20:41 2006 -0700

    ACPI: check battery status on resume for un/plug events during sleep
    
    Add ->resume method to the ACPI battery handler to check
    if the battery state has changed during sleep.
    If yes, update the ACPI internal data structures
    for benefit of /proc/acpi/battery/.
    
    Signed-off-by: Jiri Kosina <jikos@jikos.cz>
    Cc: Stefan Seyfried <seife@suse.de>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit aeb1104814e1177b865eec4f4b364602f5fcb6d1
Author: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>
Date:   Mon Oct 2 19:18:03 2006 +0400

    ACPICA: Fix incorrect handling of PCI Express Root Bridge _HID
    
    I could not get correct PCI Express bus number from the structure of
    acpi_object_extra. I always get zero as bus number regardless of bus
    location. I found that there is incorrect comparison with _HID (PNP0A08) in
    acpi/events/evrgnini.c and PCI Express _BBN method always fail.
    Therefore, we always get zero as PCI Express bus number.
    http://bugzilla.kernel.org/show_bug.cgi?id=7145
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6df05702f97f99e038ab817f4466386f6255f58d
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Tue Oct 10 14:20:36 2006 -0700

    ACPI: asus_acpi: don't printk on writing garbage to proc files
    
    This reporting is useless (we errno anyway).
    
    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6311f0dac006032b82e3556874a1e18b31e80de2
Author: Darren Jenkins <darrenrjenkins@gmail.com>
Date:   Tue Oct 10 14:20:35 2006 -0700

    ACPI: asus_acpi: fix proc files parsing
    
    ICC complains about a "Pointless comparsion of unsigned interger with zero"
    @ line 760 & 808 of asus_acpi.c
    
    parse_arg() mentioned below returns -E but it's copied into unsigned variable...
    
    Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 281ea49b0c294649a6de47a6f8fbe5611137726b
Author: Kimball Murray <kimball.murray@gmail.com>
Date:   Tue Oct 10 14:20:33 2006 -0700

    ACPI: SCI interrupt source override
    
    The Linux group at Stratus Technologies has come across an issue with SCI
    routing under ACPI.  We were bitten by this when we made an x86_64 platform
    whose BIOS provides an Interrupt Source Override for the SCI itself.
    Apparently the override has no effect for the System Control Interrupt, and
    this appears to be because of the way the SCI is setup in the ACPI code.
    It does not handle the case where busirq != gsi.
    
    The code that sets up the SCI routing assumes that bus irq == global irq.
    So there is simply no provision for telling it otherwise.  The attached
    patch provides this mechanism.
    
    This patch provided by David Bulkow, was tested on an i386 platform, which
    does not use the SCI override, and also on an x86_64 platform which does
    use an override.
    
    Signed-off-by: David Bulkow <david.bulkow@stratus.com>
    Cc: Andi Kleen <ak@muc.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a790b323fb1b73f9388426bf3b96f153d1c90d2c
Author: Randy Dunlap <rdunlap@xenotime.net>
Date:   Tue Oct 10 14:20:32 2006 -0700

    ACPI: fix printk format warnings
    
    Fix printk format warnings in drivers/acpi:
    drivers/acpi/tables/tbget.c:326: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'
    drivers/acpi/tables/tbrsdt.c:189: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'
    
    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7af8b66004fa827958b4871112e59a07db5b3f6b
Author: Pierre Ossman <drzeus@drzeus.cx>
Date:   Tue Oct 10 14:20:31 2006 -0700

    ACPI: fix section for CPU init functions
    
    The ACPI processor init functions should be marked as __cpuinit as they use
    structures marked with __cpuinitdata.
    
    Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f4d2e2d87eac0338884b2c26f6bafed115dbac5e
Author: Len Brown <len.brown@intel.com>
Date:   Thu Sep 14 17:16:22 2006 -0400

    ACPI: update comments in motherboard.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 168a328f30e9d1a8bc6ff55c0501e0bdc08bee60
Author: Jiri Kosina <jikos@jikos.cz>
Date:   Thu Aug 24 00:36:19 2006 -0400

    ACPI: acpi_pci_link_set() can allocate with either GFP_ATOMIC or GFP_KERNEL
    
    acpi_pci_link_set() allocates both with interrupts on
    and with interrupts off (resume-time), so check interrupts
    and decide on GFP_ATOMIC or GFP_KERNEL at run-time.
    
    Signed-off-by: Jiri Kosina <jikos@jikos.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 786f18c666d7202a86a8aa42a98783b115fe8739
Author: Dmitry Torokhov <dtor@insightbb.com>
Date:   Wed Aug 23 23:18:06 2006 -0400

    ACPI: fix potential OOPS in power driver with CONFIG_ACPI_DEBUG
    
    device was set to null and used before set in a debug printk
    
    Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2fe6dffabb06bfa0591c8c490b092b458fba1f06
Author: Pavel Machek <pavel@suse.cz>
Date:   Thu Aug 31 14:15:54 2006 +0200

    ACPI: ibm_acpi: delete obsolete documentation
    
    As this module is now part of the kernel tree, there is no need
    for instructions on how to download it and build an external module.
    
    Signed-off-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 37605a6900f6b4d886d995751fcfeef88c4e462c
Author: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Tue Sep 26 04:20:47 2006 -0400

    ACPI: created a dedicated workqueue for notify() execution
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5534#c160
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit fcfc638c6b1345b6646523dbab0065b36a868ffc
Author: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Tue Sep 26 04:18:16 2006 -0400

    ACPI: Remove deferred execution from global lock acquire wakeup path
    
    On acquiring the ACPI global lock, if there were sleepers on the lock,
    we used to use acpi_os_execute() to defer a thread which would signal
    sleepers.  Now just signal the semaphore directly.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5534#c159
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8c4c731a89ea6458001f48033f8988447736fb38
Author: Lennart Poettering <mzxreary@0pointer.de>
Date:   Fri Oct 6 01:27:02 2006 -0400

    MSI S270 Laptop support: backlight, wlan, bluetooth states
    
    Create a driver to support the platform-specific features
    of MSI S270 laptops (and maybe other MSI laptops).
    This driver implements a backlight device for controlling LCD brightness
    (/sys/class/backlight/msi-laptop-bl/).
    In addition it allows access to the WLAN and Bluetooth states
    through a platform driver (/sys/devices/platform/msi-laptop-pf/).
    
    Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>
    Cc: Dmitry Torokhov <dtor@mail.ru>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ab9e43c640b2b7d6e296fc39dd8cbcb96f9ae393
Author: Lennart Poettering <mzxreary@0pointer.de>
Date:   Tue Oct 3 22:49:00 2006 -0400

    ACPI: EC: export ec_transaction() for msi-laptop driver
    
    Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6ffb221a82de962f31034b45d945e203a0f0500f
Author: Denis M. Sadykov <denis.m.sadykov@intel.com>
Date:   Tue Sep 26 19:50:33 2006 +0400

    ACPI: EC: Simplify acpi_hw_low_level*() with inb()/outb().
    
    Simplify acpi_hw_low_level_xxx() functions to inb() and outb().
    
    Signed-off-by: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8e0341ba791cc72c643340b0d8119141ae5a80c5
Author: Denis M. Sadykov <denis.m.sadykov@intel.com>
Date:   Tue Sep 26 19:50:33 2006 +0400

    ACPI: EC: Unify poll and interrupt gpe handlers
    
    Signed-off-by: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3576cf619b73d850f5b21375609645f221e6270f
Author: Denis M. Sadykov <denis.m.sadykov@intel.com>
Date:   Tue Sep 26 19:50:33 2006 +0400

    ACPI: EC: Unify poll and interrupt mode transaction functions
    
    Signed-off-by: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 703959d47e887a29dc58123c05aa0ffcbbfa131d
Author: Denis M. Sadykov <denis.m.sadykov@intel.com>
Date:   Tue Sep 26 19:50:33 2006 +0400

    ACPI: EC: Remove unused variables and duplicated code
    
    Signed-off-by: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7c6db5e51227761f42c6ac8260753f5c24dc1dde
Author: Denis M. Sadykov <denis.m.sadykov@intel.com>
Date:   Tue Sep 26 19:50:33 2006 +0400

    ACPI: EC: Remove unnecessary delay added by previous transation patch.
    
    Remove unnecessary delay (50 ms) while reading data from EC in interrupt mode.
    
    Signed-off-by: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d7a76e4cb3b4469b1eccb6204c053e3ebcd4c196
Author: Lennart Poettering <mzxreary@0pointer.de>
Date:   Tue Sep 5 12:12:24 2006 -0400

    ACPI: consolidate functions in acpi ec driver
    
    Unify the following functions:
    
        acpi_ec_poll_read()
        acpi_ec_poll_write()
        acpi_ec_poll_query()
        acpi_ec_intr_read()
        acpi_ec_intr_write()
        acpi_ec_intr_query()
    
    into:
    
        acpi_ec_poll_transaction()
        acpi_ec_intr_transaction()
    
    These new functions take as arguments an ACPI EC command, a few bytes
    to write to the EC data register and a buffer for a few bytes to read
    from the EC data register. The old _read(), _write(), _query() are
    just special cases of these functions.
    
    Then unified the code in acpi_ec_poll_transaction() and
    acpi_ec_intr_transaction() a little more. Both functions are now just
    wrappers around the new acpi_ec_transaction_unlocked() function. The
    latter contains the EC access logic, the two original
    function now just do their special way of locking and call the the
    new function for the actual work.
    
    This saves a lot of very similar code. The primary reason for doing
    this, however, is that my driver for MSI 270 laptops needs to issue
    some non-standard EC commands in a safe way. Due to this I added a new
    exported function similar to ec_write()/ec_write() which is called
    ec_transaction() and is essentially just a wrapper around
    acpi_ec_{poll,intr}_transaction().
    
    Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>
    Acked-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 991528d7348667924176f3e29addea0675298944
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Mon Sep 25 16:28:13 2006 -0700

    ACPI: Processor native C-states using MWAIT
    
    Intel processors starting with the Core Duo support
    support processor native C-state using the MWAIT instruction.
    Refer: Intel Architecture Software Developer's Manual
    http://www.intel.com/design/Pentium4/manuals/253668.htm
    
    Platform firmware exports the support for Native C-state to OS using
    ACPI _PDC and _CST methods.
    Refer: Intel Processor Vendor-Specific ACPI: Interface Specification
    http://www.intel.com/technology/iapc/acpi/downloads/302223.htm
    
    With Processor Native C-state, we use 'MWAIT' instruction on the processor
    to enter different C-states (C1, C2, C3).  We won't use the special IO
    ports to enter C-state and no SMM mode etc required to enter C-state.
    Overall this will mean better C-state support.
    
    One major advantage of using MWAIT for all C-states is, with this and
    "treat interrupt as break event" feature of MWAIT, we can now get accurate
    timing for the time spent in C1, C2, ..  states.
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3cd5b87d96db503f69a5892b8f5350d356d18969
Author: Lebedev, Vladimir P <vladimir.p.lebedev@intel.com>
Date:   Tue Sep 5 19:59:22 2006 +0400

    ACPI: sbs: fix module_param() initializers
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 963497c12acb4d43caa9751b9291b014eea51a1a
Author: Lebedev, Vladimir P <vladimir.p.lebedev@intel.com>
Date:   Tue Sep 5 19:49:13 2006 +0400

    ACPI: sbs: check for NULL device pointer
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 28b779d127d3038ff83f42259d135a063b7cd848
Author: Stefan Schmidt <stefan@datenfreihafen.org>
Date:   Fri Sep 22 12:19:16 2006 +0200

    ACPI: ibm_acpi: Documentation the wan feature.
    
    Document the wan feature Jeremy Fitzhardinge added to ibm_acpi.
    
    Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
    Acked-by: Borislav Deianov <borislav@users.sourceforge.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 24f7ff0af855ece60064a2532d8b316df02983c6
Author: Stefan Schmidt <stefan@datenfreihafen.org>
Date:   Fri Sep 22 12:19:15 2006 +0200

    ACPI: ibm_acpi: Update documentation for brightness and volume.
    
    Document the change of the experimental flag for brightness and volume.
    
    Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
    Acked-by: Borislav Deianov <borislav@users.sourceforge.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4d6bd5ea4ec4991901a8cf5a586babef68e1fa3f
Author: Stefan Schmidt <stefan@datenfreihafen.org>
Date:   Fri Sep 22 12:19:14 2006 +0200

    ACPI: ibm_acpi: Remove experimental status for brightness and volume.
    
    The brightness and volume features from ibm-acpi are stable.
    The experimental flag is no longer needed.
    
    Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
    Acked-by: Borislav Deianov <borislav@users.sourceforge.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 288f3ad406460f03642a41bb945826891a7b866f
Author: Marek W <marekw1977@yahoo.com.au>
Date:   Mon Aug 14 22:37:20 2006 -0700

    ACPI: asus_acpi: W3000 support
    
    Add support for W3000 (W3V) and indirectly fixes an issue with kmilo under KDE
    (it was triggering excessive LCD read error messages by querying asus_acpi
    module) allowing people (I am probably the only one who tested this) with
    W3000 to run kmilo.
    
    Cc: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>
