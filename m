Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVCRGZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVCRGZX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 01:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVCRGZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 01:25:23 -0500
Received: from fmr23.intel.com ([143.183.121.15]:26244 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261461AbVCRGYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 01:24:06 -0500
Subject: [BKPATCH] ACPI for 2.6.12-rc1
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1111127024.9332.157.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Mar 2005 01:23:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/to-linus

	This includes the ACPI part of memory hotplug,
	plus various fixes, BIOS workarounds and a fix for
	an interpreter regressions we had in 2.6.11 vs 2.6.10.

	All changes here have been through Andrew's mm tree.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.11/acpi-20050309-2.6.11.diff.gz

This will update the following files:

 arch/i386/kernel/acpi/sleep.c       |    3 
 arch/ia64/kernel/acpi.c             |    2 
 drivers/acpi/Kconfig                |   20 
 drivers/acpi/Makefile               |    1 
 drivers/acpi/ac.c                   |   18 
 drivers/acpi/acpi_memhotplug.c      |  542 ++++++++++++++++++++++++
 drivers/acpi/battery.c              |    2 
 drivers/acpi/button.c               |    4 
 drivers/acpi/container.c            |   15 
 drivers/acpi/debug.c                |    4 
 drivers/acpi/dispatcher/dsmethod.c  |   11 
 drivers/acpi/dispatcher/dsopcode.c  |    8 
 drivers/acpi/dispatcher/dsutils.c   |  166 +++++--
 drivers/acpi/dispatcher/dswexec.c   |   61 ++
 drivers/acpi/ec.c                   |    2 
 drivers/acpi/events/evxface.c       |    4 
 drivers/acpi/executer/exmisc.c      |    5 
 drivers/acpi/executer/exoparg2.c    |    6 
 drivers/acpi/executer/exresolv.c    |    6 
 drivers/acpi/executer/exstoren.c    |    7 
 drivers/acpi/executer/exstorob.c    |   27 -
 drivers/acpi/fan.c                  |   33 -
 drivers/acpi/ibm_acpi.c             |    4 
 drivers/acpi/numa.c                 |    2 
 drivers/acpi/osl.c                  |   10 
 drivers/acpi/parser/psopcode.c      |    2 
 drivers/acpi/parser/psparse.c       |   42 +
 drivers/acpi/parser/pswalk.c        |  254 +----------
 drivers/acpi/pci_irq.c              |   38 +
 drivers/acpi/pci_link.c             |   14 
 drivers/acpi/pci_root.c             |    4 
 drivers/acpi/power.c                |   10 
 drivers/acpi/processor_core.c       |    6 
 drivers/acpi/processor_thermal.c    |    2 
 drivers/acpi/processor_throttling.c |    2 
 drivers/acpi/resources/rsaddr.c     |  146 +++---
 drivers/acpi/resources/rscalc.c     |   14 
 drivers/acpi/resources/rsdump.c     |   23 -
 drivers/acpi/resources/rslist.c     |    1 
 drivers/acpi/scan.c                 |   47 +-
 drivers/acpi/thermal.c              |    2 
 drivers/acpi/toshiba_acpi.c         |    2 
 drivers/acpi/utilities/utcopy.c     |   19 
 drivers/acpi/utilities/utdelete.c   |   18 
 drivers/acpi/utilities/utglobal.c   |   10 
 drivers/acpi/utilities/utmisc.c     |   44 +
 drivers/acpi/video.c                |    2 
 drivers/pnp/pnpacpi/rsparser.c      |    9 
 include/acpi/acconfig.h             |    4 
 include/acpi/acdisasm.h             |    5 
 include/acpi/acdispat.h             |   10 
 include/acpi/acinterp.h             |    1 
 include/acpi/aclocal.h              |    4 
 include/acpi/acpi_bus.h             |    1 
 include/acpi/acpi_drivers.h         |    3 
 include/acpi/acstruct.h             |    1 
 include/acpi/actbl.h                |    4 
 include/acpi/actbl2.h               |   79 +++
 include/acpi/actypes.h              |   33 -
 include/acpi/platform/acenv.h       |    2 
 include/acpi/processor.h            |    2 
 include/linux/acpi.h                |    2 
 62 files changed, 1301 insertions(+), 524 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (05/03/17 1.2213)
   [ACPI] build fix in acpi_pci_irq_disable()
   
   bk-acpi-acpi_pci_irq_disable-build-fix.patch
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/09 1.1938.505.27)
   [ACPI] ACPICA 20050309 from Bob Moore
   
   The string-to-buffer implicit conversion code has been
   modified again after a change to the ACPI specification.
   In order to match the behavior of the other major ACPI
   implementation, the target buffer is no longer truncated
   if the source string is smaller than an existing target
   buffer. This change requires an update to the ACPI spec,
   and should eliminate the recent AE_AML_BUFFER_LIMIT issues.
   
   The "implicit return" support was rewritten to a new
   algorithm that solves the general case. Rather than
   attempt to determine when a method is about to exit,
   the result of every ASL operator is saved momentarily
   until the very next ASL operator is executed. Therefore,
   no matter how the method exits, there will always be a
   saved implicit return value.  This feature is only enabled
   with the acpi_gbl_enable_interpreter_slack flag which
   Linux enables unless "acpi=strict".  This should
   eliminate AE_AML_NO_RETURN_VALUE errors.
   
   Implemented implicit conversion support for the predicate
   (operand) of the If, Else, and While operators. String and
   Buffer arguments are automatically converted to Integers.
   
   Changed the string-to-integer conversion behavior to match
   the new ACPI errata: "If no integer object exists, a new
   integer is created. The ASCII string is interpreted as a
   hexadecimal constant. Each string character is interpreted
   as a hexadecimal value ('0'-'9', 'A'-'F', 'a', 'f'),
   starting with the first character as the most significant
   digit, and ending with the first non-hexadecimal character
   or end-of-string."  This means that the first non-hex
   character terminates the conversion and this is the code
   that was changed.
   
   Fixed a problem where the ObjectType operator would fail
   (fault) when used on an Index of a Package which pointed
   to a null package element.  The operator now properly
   returns zero (Uninitialized) in this case.
   
   Fixed a problem where the While operator used excessive
   memory by not properly popping the result stack during
   execution. There was no memory leak after execution,
   however. (Code provided by Valery Podrezov.)
   
   Fixed a problem where references to control methods within
   Package objects caused the method to be invoked, instead
   of producing a reference object pointing to the method.
   
   Restructured and simplified the pswalk.c module
   (acpi_ps_delete_parse_tree) to improve performance and reduce
   code size. (Code provided by Alexey Starikovskiy.)
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/09 1.1994.11.5)
   [ACPI] limit scope of various globals to static
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/09 1.1938.505.26)
   [ACPI] fix acpi_numa_init() build warning
   
   Signed-off-by: Randy Dunlap <rdddunlap@osdl.org>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/09 1.1938.505.25)
   [ACPI] Allow 4 digits when printing PCI segments
   to be consistent with the rest of the kernel.
   
   Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/08 1.1938.505.24)
   [ACPI] Make PCI device -> interrupt link associations explicit,
   
   ACPI: PCI Interrupt 0000:00:0f.2[A] -> Link [IUSB] -> GSI 10 (level,
low) -> IRQ 10
   
   Previously, you could sometimes infer an association based on the
output
   when an interrupt link is enabled, but when interrupt links are
shared
   among several PCI devices, you could only make the inference for the
first
   device to be enabled.
   
   Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/08 1.1938.505.23)
   [ACPI] PNPACPI should ignore vendor-defined resources
   
   Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/03 1.1938.505.22)
   [ACPI] fix [ACPI_MTX_Hardware] AE_TIME warning
   which resulted from enabling the wake-on-RTC feature
   
   http://bugme.osdl.org/show_bug.cgi?id=3967
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/03 1.1938.505.21)
   [ACPI] ACPICA 20050303 from Bob Moore for AE_AML_BUFFER_LIMIT issue.
   
   It turns out that tightening up the interpreter to truncate buffers
   per the ACPI spec was a bad idea -- BIOS' in the field depended
   on old behaviour.  Instead, we'll endeavor to update the ACPI spec
   to reflect industry practice in this area.
   
   http://bugme.osdl.org/show_bug.cgi?id=4263
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/02 1.1938.505.20)
   [ACPI] fix sysfs "eject" file
   
   This fixes a if-statement in setup_sys_fs_device_files().  It seems
to
   assume that 'struct acpi_device_flags.ejectable' indicates whether a
device
   has _EJ0 or not.  But this is not a right assumption.  It indicates
whether
   a device has _EJ0|_EJD (See acpi_bus_get_flags() function).
   
   setup_sys_fs_device_files() creates 'eject' file for devices that
have _EJ0
   control method under a corresponding directory in
   /sys/firmware/acpi/namespace/ACPI/.  'eject' file is used to trigger
   hot-removal function from userland.
   
   <Note that we expect this file location to change in the future.>
   
   Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/02 1.1938.505.19)
   [ACPI] fix ACPI container driver's notify handler.
   
   Previously, the handler tried to make a container device be offline
if an
   ACPI_NOTIFY_BUS/DEVICE_CHECK notification is performed on the device
was
   present and has its acpi_device.  But, the condition is weird. 
Whenever
   the notification is performed, there should be only the following two
   conditions:
   
     1. the device is present, but does not have its acpi_device.
     2. the device is not present, but has its acpi_device.
   
   #1 is a hot-addition case, which was handled properly also in
previous
   handler.  #2 is a surprising hot-removal case, which was not handled
in
   previous handler.
   
   Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/02 1.1938.505.18)
   [ACPI] fix kobject_hotplug() use by ACPI processor and container
drivers
   
   A while ago, the drivers used their own function
   'processor_run_sbin_hotplug() and container_run_sbin_hotplug()' to
notify
   the agent script using /sbin/hotplug mechanism.  But, they were
changed to
   use kobject_hotplug() instead and this has caused a side effect.
   
   The container driver was supposed to invoke a container.agent (user
mode
   agent script) using /sbin/hotplug mechanism, but after the changes,
it is
   not able to call the agent any more and kobject_hotplug() in the
   container.c became to invoke a namespace.agent instead if exists. 
So, I
   would like to use the namespace.agent to handle container hotplug
event (or
   something else) and let the agent to call proper agent (e.g. 
   container.agent).  But, there is an issue we need to solve.  When the
   namespace.agent is called, a path name of associated kobject is
passed as a
   DEVPATH (e.g./sys/firmware/ acpi/namespace/ACPI/_SB/DEV0).  However,
the
   agent would not know what device is associated with the DEVPATH nor
which
   agents to call since the DEVPATH name depends on platform.  The
attached
   patch is to add .hotplug_ops member to acpi_namespace_kset structure
and
   let it to set a driver name attached to the target kobject into the
envp[]
   variable as a DRV_NAME element.  With this, the namespace.agent can
call
   proper agents (e.g.  container.agent) by refering the DRV_NAME.
   
   Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/02 1.1938.505.17)
   [ACPI] flush TLB in init_low_mappings()
   
   From: Li Shaohua <shaohua.li@intel.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/02 1.1938.505.16)
   [ACPI] enhance fan output in error path
   
   Currently, fan.c ignores errors from acpi_bus_get_power.  On compaq
evo
   notebook that leads to very confusing empty output.
   
   From: Pavel Machek <pavel@ucw.cz>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/02 1.1938.505.15)
   [ACPI] CONFIG_ACPI_NUMA build fix
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/03/01 1.1938.505.14)
   [ACPI] ACPICA 20050228 from Bob Moore
   
   Fixed a problem where the result of an Index() operator
   (an object reference) must increment the reference count
   on the target object for the life of the object reference.
   
   Implemented AML Interpreter and Debugger support for
   the new ACPI 3.0 Extended Address (IO, Memory, Space),
   QwordSpace, DwordSpace, and WordSpace resource descriptors.
   
   Implemented support in the _OSI method for the ACPI 3.0
   "Extended Address Space Descriptor" string, indicating
   interpreter support for the descriptors above.
   
   Implemented header support for the new ACPI 3.0 FADT
   flag bits.
   
   Implemented header support for the new ACPI 3.0 PCI Express
   bits for the PM1 status/enable registers.
   
   Updated header support for the MADT processor local Apic
   struct and MADT platform interrupt source struct for new
   ACPI 3.0 fields.
   
   Implemented header support for the SRAT and SLIT ACPI
   tables.
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/02/17 1.1982.92.2)
   [ACPI] Add ACPI-based memory hot plug driver.
   
   The ACPI based memory hot plug driver patch supports physical hotplug
   operations on memory. This driver fields notifications for memory add
   and remove operations from firmware and notifies the VM of the
affected
   memory ranges. Accordingly, this driver also maintains and updates
the
   states of all the memory ranges. This driver is useful on hardware
which
   helps firmware generating ACPI events for every physical hotplug
   operation of memory boards on the system during runtime.
   
   Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
   Signed-off-by: Naveen B S <naveen.b.s@intel.com>
   Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>




