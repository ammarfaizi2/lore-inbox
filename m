Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUL0SX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUL0SX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 13:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbUL0SX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 13:23:57 -0500
Received: from fmr13.intel.com ([192.55.52.67]:35564 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261939AbUL0SX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 13:23:28 -0500
Subject: [BKPATCH] ACPI for 2.6.11
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1104171786.18175.23.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Dec 2004 13:23:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/26-latest-release

	includes...

	Suspend/resume fixes
	ACPI-based Physical CPU hotplug
	AML interpreter fixes to issue found by new test suite.
	AML interpreter updates to handle most new ACPI 3.0 constructs
	Enable more power savings in idle through _CST and C4 support.
	Reduce stack consumption
	Misc fixes...

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.10/acpi-20041210-2.6.10-rc3.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt               |    2 
 arch/i386/kernel/acpi/boot.c                      |   22 
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    2 
 arch/i386/mach-default/topology.c                 |   31 
 arch/i386/pci/irq.c                               |    4 
 arch/ia64/dig/Makefile                            |    5 
 arch/ia64/dig/topology.c                          |   43 
 arch/ia64/kernel/Makefile                         |    3 
 arch/ia64/kernel/acpi.c                           |  108 
 arch/ia64/kernel/topology.c                       |   90 
 arch/ia64/mm/numa.c                               |   36 
 drivers/acpi/Kconfig                              |   18 
 drivers/acpi/Makefile                             |    7 
 drivers/acpi/asus_acpi.c                          |   18 
 drivers/acpi/bus.c                                |    6 
 drivers/acpi/container.c                          |  298 +
 drivers/acpi/dispatcher/dsopcode.c                |    5 
 drivers/acpi/dispatcher/dswexec.c                 |   24 
 drivers/acpi/ec.c                                 |  135 
 drivers/acpi/events/evgpe.c                       |   26 
 drivers/acpi/events/evxfevnt.c                    |    3 
 drivers/acpi/executer/exconfig.c                  |    2 
 drivers/acpi/executer/exconvrt.c                  |  108 
 drivers/acpi/executer/exdump.c                    |   11 
 drivers/acpi/executer/exfldio.c                   |  546 --
 drivers/acpi/executer/exmisc.c                    |    2 
 drivers/acpi/executer/exoparg1.c                  |   26 
 drivers/acpi/executer/exoparg2.c                  |    4 
 drivers/acpi/executer/exprep.c                    |   24 
 drivers/acpi/executer/exstore.c                   |   62 
 drivers/acpi/executer/exstorob.c                  |   19 
 drivers/acpi/hardware/hwsleep.c                   |   16 
 drivers/acpi/numa.c                               |   21 
 drivers/acpi/osl.c                                |    9 
 drivers/acpi/parser/psopcode.c                    |    8 
 drivers/acpi/pci_bind.c                           |   82 
 drivers/acpi/pci_irq.c                            |   59 
 drivers/acpi/pci_link.c                           |   66 
 drivers/acpi/processor.c                          | 2644 ----------
 drivers/acpi/processor_core.c                     |  989 +++
 drivers/acpi/processor_idle.c                     |  995 +++
 drivers/acpi/processor_perflib.c                  |  666 ++
 drivers/acpi/processor_thermal.c                  |  406 +
 drivers/acpi/processor_throttling.c               |  351 +
 drivers/acpi/scan.c                               |  288 +
 drivers/acpi/sleep/proc.c                         |   78 
 drivers/acpi/tables/tbconvrt.c                    |    4 
 drivers/acpi/tables/tbrsdt.c                      |    1 
 drivers/acpi/tables/tbxfroot.c                    |   45 
 drivers/acpi/thermal.c                            |   29 
 drivers/acpi/toshiba_acpi.c                       |    4 
 drivers/acpi/video.c                              |   13 
 drivers/base/cpu.c                                |   20 
 drivers/pci/quirks.c                              |   28 
 drivers/pnp/pnpacpi/core.c                        |    6 
 include/acpi/acconfig.h                           |    4 
 include/acpi/acdisasm.h                           |    6 
 include/acpi/aclocal.h                            |    2 
 include/acpi/acmacros.h                           |   25 
 include/acpi/acobject.h                           |    4 
 include/acpi/acoutput.h                           |    2 
 include/acpi/acpi_bus.h                           |   10 
 include/acpi/acpi_drivers.h                       |    2 
 include/acpi/acpixf.h                             |    2 
 include/acpi/actbl2.h                             |    2 
 include/acpi/amlcode.h                            |    1 
 include/acpi/amlresrc.h                           |   26 
 include/acpi/container.h                          |   13 
 include/acpi/processor.h                          |   98 
 include/asm-i386/acpi.h                           |    6 
 include/asm-i386/cpu.h                            |   17 
 include/asm-ia64/acpi.h                           |    2 
 include/asm-ia64/cpu.h                            |    5 
 include/linux/acpi.h                              |   14 
 include/linux/cpu.h                               |    3 
 75 files changed, 5220 insertions(+), 3542 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/12/23 1.1988.135.26)
   [ACPI] Fix suspend/resume lockup issue
   by leaving Bus Master Arbitration enabled.
   The ACPI spec mandates it be disabled only for C3.
   
   http://bugzilla.kernel.org/show_bug.cgi?id=3599
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/23 1.2072)
   [ACPI] apply via_interrupt_line_quirk in ACPI mode
   the same way it is applied in legacy mode.
   Delete redundant quirks.
   
   http://bugzilla.kernel.org/show_bug.cgi?id=3319
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/23 1.1988.135.25)
   [ACPI] another fix to the stack-audit patch
   http://bugzilla.kernel.org/show_bug.cgi?id=2901
     
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/23 1.2070)
   [ACPI] two fixups where promotion and demotion were mixed up
   
   Signed-off-by: Dominik Brodowski <linux@brodo.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/23 1.1988.135.24)
   [ACPI] fix to the stack-audit patch
   http://bugzilla.kernel.org/show_bug.cgi?id=2901
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/23 1.2069)
   [ACPI] add "processor.nocst" parameter
   which blocks _CST parsing and always uses FADT info instead.
   
   Signed-off-by: Dominik Brodowski <linux@brodo.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/23 1.2068)
   [ACPI] Let C4 demote to C3, not directly to C2.
   
   Signed-off-by: Dominik Brodowski <linux@brodo.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/23 1.2067)
   
   [ACPI] tweak /proc/acpi/processor/CPU0/power format
   Current policy is to name both C-state-types and the actual C-States
   "C[0-n]". Follow this rule...
   
   Signed-off-by: Dominik Brodowski <linux@brodo.de
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/23 1.2066)
   [ACPI] max_cstate shall limit C-states not C-state-types.
   
   Signed-off-by: Dominik Brodowski <linux@brodo.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/22 1.2064)
   [ACPI] Export /sys/module/processor/parameters/max_cstate
   
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/22 1.2063)
   [ACPI] Consolidate code in processor_idle().
   Only symbols "exported" are _init(), _exit() and _cst_has_changed()
   
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/22 1.2062)
   [ACPI] Notify the BIOS that Linux can handle _CST.
   
   http://bugzilla.kernel.org/show_bug.cgi?id=1958
   
   Signed-off-by: Bruno Ducrot <ducrot@poupinou.org>
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/22 1.2061)
   [ACPI] Handle _CST change notifications
   
   It is necessary to unload the processor idle handle for
   a short period of time to avoid for nasty races --
   and we don't want to grab too many locks
   so that the idle handler continues to be speedy.
   
   http://bugzilla.kernel.org/show_bug.cgi?id=1958
   
   Signed-off-by: Bruno Ducrot <ducrot@poupinou.org>
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/22 1.2060)
   [ACPI] Add _CST parsing
   
   http://bugzilla.kernel.org/show_bug.cgi?id=1958
   
   Signed-off-by: Bruno Ducrot <ducrot@poupinou.org>
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/22 1.2059)
   [ACPI] make the c-state policy decisions of demotion and promotion
   independent of the assumption "one state per type."
   make the state a pointer inside struct acpi_processor_cx_policy.
   make max_cstate aware of c-state types instead of c-state number.
   
   http://bugzilla.kernel.org/show_bug.cgi?id=1958
   
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/22 1.2058)
   [ACPI] make power.state a pointer
   
   http://bugzilla.kernel.org/show_bug.cgi?id=1958
   
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/22 1.2057)
   [ACPI] deleted unused default c-state
   
   http://bugzilla.kernel.org/show_bug.cgi?id=1958
   
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/22 1.2056)
   [ACPI] Split up the extraction of information from the FADT
   and the pblk_address (acpi_processor_get_power_info_fadt())
   and the validation whether the state is indeed available
   (acpi_processor_power_verify()).
   
   http://bugzilla.kernel.org/show_bug.cgi?id=1958
   
   Signed-off-by: Bruno Ducrot <ducrot@poupinou.org>
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/21 1.2055)
   [ACPI] Differentiate between C-States and C-state type.
   
   http://bugzilla.kernel.org/show_bug.cgi?id=1958
   
   Signed-off-by: Bruno Ducrot <ducrot@poupinou.org>
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/21 1.2054)
   [ACPI] Shorten the times IRQs are disabled in throttling.
   During calculations no disabling is necessary.
   
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/21 1.2053)
   [ACPI] Finalize the splitting of processor.c by moving the rest to
processor_core.c
   
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/21 1.2052)
   [ACPI] Split the ACPI Processor passive cooling code into a different
file
   
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/21 1.2051)
   [ACPI] Split the ACPI Processor C-States handling into a different
file
   
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/21 1.2050)
   [ACPI] Split the ACPI Processor T-States handling into a different
file
   
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/21 1.2049)
   [ACPI] Split the ACPI Processor P-States library into a different
file
   
   Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/21 1.1988.135.23)
   [ACPI] ACPICA 20041210 from Bob Moore
   
   ACPI 3.0 support is nearing completion in both the iASL
   compiler and the ACPI CA core subsystem.
   
   Fixed a problem in the ToDecimalString operator where the
   resulting string length was incorrectly calculated. The
   length is now calculated exactly, eliminating incorrect
   AE_STRING_LIMIT exceptions.
   
   Fixed a problem in the ToHexString operator to allow a
   maximum 200 character string to be produced.
   
   Fixed a problem in the internal string-to-buffer and
   buffer-to-buffer copy routine where the length of the
   resulting buffer was not truncated to the new size (if
   the target buffer already existed).
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/21 1.1988.135.22)
   [ACPI] fix return syntax
   
   Signed-off-by: Pavel Machek <pavel@suse.cz>
   Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

<len.brown@intel.com> (04/12/08 1.2034.1.53)
   [ACPI] fix polarity of CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI message
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/08 1.1988.135.21)
   [ACPI] remove duplicate _PDC #defines resulting from mis-merge
   
   Signed-off-by: Zhenyu Z. Wang <zhenyu.z.wang@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/06 1.1988.135.20)
   [ACPI] ACPICA 20041203 from Bob Moore and Alexey Starikovskiy
   
   The low-level field insertion/extraction code (exfldio)
   has been completely rewritten to eliminate unnecessary
   complexity, bugs, and boundary conditions.
   
   Fixed a problem in the ToInteger, ToBuffer, ToHexString,
   and ToDecimalString operators where the input operand could
   be inadvertently deleted if no conversion was necessary
   (e.g., if the input to ToInteger was an Integer object.)
   
   Fixed a problem with the ToDecimalString and ToHexString
   where an incorrect exception code was returned if the
   resulting string would be > 200 chars.  AE_STRING_LIMIT is
   now returned.
   
   Fixed a problem with the Concatenate operator where AE_OK
   was always returned, even if the operation failed.
   
   Fixed a problem in oswinxf (used by AcpiExec and iASL)
   to allow > 128 semaphores to be allocated.
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/06 1.1988.135.19)
   [ACPI] ACPICA 20041119 from Bob Moore
   
   Fixed a problem in acpi_ex_convert_to_integer
   where new integers were not truncated to 32 bits for
   32-bit ACPI tables. This routine converts buffers and
   strings to integers.
   
   Implemented support to store a value to an Index() on a
   String object.  This is an ACPI 2.0 feature that had not
   yet been implemented.
   
   Implemented new behavior for storing objects to individual
   package elements (via the Index() operator). The
   previous behavior was to invoke the implicit conversion
   rules if an object was already present at the index.
   The new behavior is to simply delete any existing object
   and directly store the new object. Although the ACPI
   specification seems unclear on this subject, other ACPI
   implementations behave in this manner.  (This is the root
   of the AE_BAD_HEX_CONSTANT issue.)
   
   Modified the RSDP memory scan mechanism to support the
   extended checksum for ACPI 2.0 (and above) RSDPs. Note
   that the search continues until a valid RSDP signature is
   found with a valid checksum.
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/06 1.1988.135.18)
   build fix

<len.brown@intel.com> (04/12/06 1.1988.135.17)
   [ACPI] 32-bit EC access
   
   http://bugzilla.kernel.org/show_bug.cgi?id=1744
   
   Signed-off-by: Luming Yu <luming.yu@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/06 1.1988.135.16)
   build fix

<len.brown@intel.com> (04/12/05 1.1988.135.15)
   [ACPI] fixes from stack consumption audit
   
   http://bugzilla.kernel.org/show_bug.cgi?id=2901
   
   Signed-off-by: Luming Yu <luming.yu@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/05 1.1988.135.14)
   [ACPI] handle GPE sharing between button and lid
   
   http://bugzilla.kernel.org/show_bug.cgi?id=3518
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/05 1.1988.135.13)
   [ACPI] add "acpi_fake_ecdt" workaround for Gateway:
   ex_access_region Region EmbeddedControl(3) has no handler
   
   http://bugzilla.kernel.org/show_bug.cgi?id=1690
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/05 1.1988.135.12)
   [ACPI] fix "Error getting context for object" warning
   http://bugzilla.kernel.org/show_bug.cgi?id=3805
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/05 1.1988.135.11)
   [ACPI] S3 resume using RTC
   http://bugzilla.kernel.org/show_bug.cgi?id=1320
   
   By: Patrick Mochel, Karol Kozimor, Shaohua Li
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/03 1.2034.1.46)
   [ACPI] fix VIA IRQ issue by enabling VIA quirk
   http://bugzilla.kernel.org/show_bug.cgi?id=3319
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/11 1.2044)
   [ACPI] CPU hotplug, use kobject_hotplug(), kobject_register()
   
   Signed-off-by: Anil S. Keshavamurthy <anil.s.keshavamurthy@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/31 1.2042)
   [ACPI] fix mis-merge in processor.c

<len.brown@intel.com> (04/10/28 1.2040)
   [ACPI] Initial container driver to support hotplug notifications
   on ACPI0004, PNP0A05 and PNP0A06 devices.
   
   Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/28 1.2039)
   [ACPI] Extend processor driver to support ACPI-based Physical CPU
hotplug
   
   Signed-off-by Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
   Signed-off-by: Len Brown <len.brown2intel.com>

<len.brown@intel.com> (04/10/28 1.2038)
   IA64 CPU hotplug topology
   
   Extend support for dynamic registration and unregistration of the
cpu,
   by implementing and exporting
arch_register_cpu()/arch_unregister_cpu().
   Also combine multiple implementation of topology_init() functions to
   single topology_init() in case of ia64 architecture.
   
   Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/28 1.2037)
   [ACPI] IA64-specific support for mapping lsapic to cpu array.
   analogous i386 and x86_64 code TBD
   
   Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/28 1.2036)
   [ACPI] create ACPI hotplug eject interface
   
   The kernel when it receives an hardware sci eject request it simply
passes this
   to user mode agent and the agent in turn will offline all the child
devices and
   then echo's 1 onto the eject file for that acpi device.
   
   This patch provides the sysfs "eject" interface for the user mode
agent
   to notify the core acpi so that the core acpi can trim its bus which 
   causes .remove function to be called for all child devices.
   
   For example for LSB0 which is an ejectable device, we will see
   /sys/firmware/acpi/namespace/ACPI/_SB/LSB/eject.
   
   Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/28 1.2035)
   [ACPI] Provide core hotplug support in ACPI
   
   Create acpi_bus_trim(), acpi_bus_remove() and acpi_pci_unbind(),
   The reverse of of acpi_bus_scan(), acpi_bus_add() and acpi_pci_bind()
   
   Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>




