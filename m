Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268098AbUHNG46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268098AbUHNG46 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 02:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUHNG4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 02:56:11 -0400
Received: from fmr02.intel.com ([192.55.52.25]:22453 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S268098AbUHNGzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 02:55:35 -0400
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1092466509.5028.248.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Aug 2004 02:55:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.8

	Key fixes for suspend/resume, a couple of common
	boot failures, and misc. random fixes.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.8/acpi-20040715-2.6.8.diff.gz

This will update the following files:

 arch/i386/kernel/acpi/boot.c        |    7 
 arch/i386/kernel/acpi/sleep.c       |    5 
 arch/i386/kernel/cpu/cpufreq/acpi.c |  103 +++++-
 arch/i386/kernel/dmi_scan.c         |   47 --
 arch/i386/kernel/i8259.c            |   25 +
 arch/i386/kernel/io_apic.c          |   93 +++++
 arch/i386/kernel/setup.c            |   15 
 arch/i386/kernel/smpboot.c          |    6 
 arch/i386/mm/discontig.c            |   15 
 arch/ia64/kernel/acpi.c             |    6 
 arch/x86_64/kernel/i8259.c          |   53 +++
 arch/x86_64/kernel/setup.c          |   17 +
 arch/x86_64/kernel/smpboot.c        |    2 
 drivers/acpi/Makefile               |    2 
 drivers/acpi/acpi_ksyms.c           |    2 
 drivers/acpi/asus_acpi.c            |   65 ++-
 drivers/acpi/blacklist.c            |   14 
 drivers/acpi/bus.c                  |   38 +-
 drivers/acpi/button.c               |    9 
 drivers/acpi/dispatcher/dsmethod.c  |   18 -
 drivers/acpi/dispatcher/dsmthdat.c  |    8 
 drivers/acpi/dispatcher/dsopcode.c  |    7 
 drivers/acpi/dispatcher/dswload.c   |   22 +
 drivers/acpi/dispatcher/dswstate.c  |   18 -
 drivers/acpi/ec.c                   |   13 
 drivers/acpi/events/evevent.c       |   12 
 drivers/acpi/events/evgpe.c         |  393 ++++++++++++++++++++++--
 drivers/acpi/events/evgpeblk.c      |  181 +++++++----
 drivers/acpi/events/evmisc.c        |   13 
 drivers/acpi/events/evregion.c      |  373 +++++++++++++++++++++-
 drivers/acpi/events/evxface.c       |  180 +++++++---
 drivers/acpi/events/evxfevnt.c      |  173 +++++-----
 drivers/acpi/events/evxfregn.c      |  201 ------------
 drivers/acpi/executer/exconfig.c    |   47 ++
 drivers/acpi/executer/exfldio.c     |  165 ++++++----
 drivers/acpi/executer/exmisc.c      |  151 +++++++--
 drivers/acpi/executer/exmutex.c     |   46 +-
 drivers/acpi/executer/exoparg2.c    |   48 ++
 drivers/acpi/executer/exresolv.c    |    8 
 drivers/acpi/executer/exstore.c     |   17 -
 drivers/acpi/hardware/hwgpe.c       |  339 +++++---------------
 drivers/acpi/hardware/hwregs.c      |   34 +-
 drivers/acpi/hardware/hwsleep.c     |   57 ++-
 drivers/acpi/motherboard.c          |  173 ++++++++++
 drivers/acpi/namespace/nsaccess.c   |    2 
 drivers/acpi/namespace/nsalloc.c    |    2 
 drivers/acpi/namespace/nseval.c     |   90 +----
 drivers/acpi/namespace/nsinit.c     |   42 +-
 drivers/acpi/namespace/nsparse.c    |    5 
 drivers/acpi/namespace/nsxfeval.c   |   52 +--
 drivers/acpi/namespace/nsxfname.c   |    4 
 drivers/acpi/osl.c                  |   30 +
 drivers/acpi/parser/psopcode.c      |    8 
 drivers/acpi/parser/psxface.c       |   51 +--
 drivers/acpi/pci_link.c             |   76 ++++
 drivers/acpi/power.c                |   80 ++++
 drivers/acpi/processor.c            |   74 +++-
 drivers/acpi/resources/rsutils.c    |    7 
 drivers/acpi/resources/rsxface.c    |    3 
 drivers/acpi/scan.c                 |  191 +++++++++--
 drivers/acpi/sleep/Makefile         |    2 
 drivers/acpi/sleep/main.c           |   33 +-
 drivers/acpi/sleep/proc.c           |   86 +++++
 drivers/acpi/sleep/sleep.h          |    3 
 drivers/acpi/sleep/wakeup.c         |  181 +++++++++++
 drivers/acpi/tables/tbxfroot.c      |  203 +++++++-----
 drivers/acpi/thermal.c              |   67 ++--
 drivers/acpi/utilities/utalloc.c    |   13 
 drivers/acpi/utilities/uteval.c     |   18 -
 drivers/acpi/utilities/utglobal.c   |   83 +++--
 drivers/acpi/utilities/utxface.c    |   41 +-
 include/acpi/acconfig.h             |   25 +
 include/acpi/acdebug.h              |    8 
 include/acpi/acdisasm.h             |   15 
 include/acpi/acdispat.h             |    3 
 include/acpi/acevents.h             |   54 +++
 include/acpi/acexcep.h              |    6 
 include/acpi/acglobal.h             |   44 ++
 include/acpi/achware.h              |   36 +-
 include/acpi/acinterp.h             |   15 
 include/acpi/aclocal.h              |   39 +-
 include/acpi/acmacros.h             |    5 
 include/acpi/acnamesp.h             |   18 -
 include/acpi/acobject.h             |   13 
 include/acpi/acparser.h             |    4 
 include/acpi/acpi_bus.h             |   28 +
 include/acpi/acpi_drivers.h         |    3 
 include/acpi/acpiosxf.h             |   15 
 include/acpi/acpixf.h               |   10 
 include/acpi/acstruct.h             |   23 +
 include/acpi/actbl.h                |   29 -
 include/acpi/actypes.h              |   84 +++--
 include/acpi/platform/acenv.h       |    8 
 include/acpi/platform/aclinux.h     |    2 
 include/asm-i386/acpi.h             |    8 
 include/asm-i386/smp.h              |    1 
 include/asm-ia64/acpi.h             |    2 
 include/asm-x86_64/acpi.h           |    2 
 init/main.c                         |    7 
 99 files changed, 3648 insertions(+), 1527 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/08/14 1.1731.1.29)
   [ACPI] Enter ACPI mode earlier
   Fixes two common boot failures due to buggy SMM BIOS code
   
   SMP boot crash if SMI_CMD=ACPI written from CPU1
   http://bugzilla.kernel.org/show_bug.cgi?id=2941
   
   laptop crash due to LAPIC timer before SMI_CMD=ACPI
   http://bugzilla.kernel.org/show_bug.cgi?id=1269

<len.brown@intel.com> (04/08/13 1.1731.1.28)
   [ACPI] clean out blacklist entries that do nothing

<len.brown@intel.com> (04/08/09 1.1731.1.27)
   [ACPI] init wakeup devcies only if ACPI enabled (David Shaohua Li)

<len.brown@intel.com> (04/08/09 1.1731.1.26)
   [ACPI] acpi_bus_register_driver() now return a count
   consistent with pnp_register_driver() and pci_register_driver()
   
   All existing callers of acpi_bus_register_driver() either ignore the
   return value or check only for negative (error) return values.
   
   Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

<len.brown@intel.com> (04/08/09 1.1731.1.25)
   [ACPI] acpi for asus update from Karol Kozimor
   
   support for L4R and M5N, moves some bits for M6N
   and restores WLED functionality for M2N
   comment and whitespace cleanups
   fix get/set typo from /proc patch, delete trailing spaces

<len.brown@intel.com> (04/08/08 1.1731.1.24)
   [ACPI] acpi_system_write_wakeup_device() has the wrong return type
   and is missing the __user attribution from its buffer argument.
   This patch shuts up the resulting warnings on x86-64.
   
   From: William Lee Irwin III <wli@holomorphy.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org>

<nbryant@optonline.net> (04/08/04 1.1731.1.23)
   [ACPI] restore PCI Interrupt Link Devices upon resume
   
   * register as as a sys_device so that we can get resume callbacks and
restore
     interrupt routing state.
   * add acpi_pci_link_resume(), which will be called when resuming from
a suspend
     state that needs IRQ routing to be restored. This fixes issues
reported on
     the mailing lists, e.g.:
   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
   * rename setonboot --> initialized
   * change to test acpi_noirq in init
   
   We want to initialize everything on S3 resume in case the BIOS points
an
   interrupt link somewhere we didn't expect. (Doing so avoids "missing
interrupt"
   or "irq x: nobody cared" problems.) According to Len, past experience
has shown
   that it's a good idea to initialize only devices that exist or were
explicitly
   asked for, so we try to initialize only the IRQ's that were
previously
   initialized at some point before suspend, by checking the
"initialized" flag.
   This corresponds to links that have PCI devices attached.  Everything
else, we
   leave alone. Assuming the BIOS does the same thing on resume that it
did on
   boot, this will leave all the unused links in the same state that
they were on
   boot.
   
   We are registered as a sysdev in order to do this work fairly early
during
   resume, before devices are resumed; some devices may not call
   pci_device_enable.
   
   Previous "setonboot once" behavior is left in place, to be
conservative.

<len.brown@intel.com> (04/08/03 1.1731.1.22)
   [ACPI] BIOS workaround allowing devices to use reserved IO ports
   Author: David Shaohua Li
   http://bugzilla.kernel.org/show_bug.cgi?id=3049

<len.brown@intel.com> (04/07/28 1.1731.1.21)
   [ACPI] fix build warning (Andrew Morton)

<len.brown@intel.com> (04/07/28 1.1731.1.20)
   [ACPI] synchronize_kernel for idle-loop unload (Zwane Mwaikambo)
   http://bugzilla.kernel.org/show_bug.cgi?id=1716

<len.brown@intel.com> (04/07/28 1.1731.1.19)
   [ACPI] S3 is independent of CONFIG_X86_PAE (David Shaohua Li)

<len.brown@intel.com> (04/07/17 1.1731.1.18)
   [ACPI] ACPICA 20040715 from Bob Moore
   
   Restructured the internal HW GPE interfaces to pass/track
   the current state of interrupts (enabled/disabled) in
   order to avoid possible deadlock and increase flexibility
   of the interfaces.
   
   Implemented a "lexicographical compare" for String and
   Buffer objects within the logical operators -- LGreater,
   LLess, LGreaterEqual, and LLessEqual -- as per further
   clarification to the ACPI specification.  Behavior is
   similar to C library "strcmp".
   
   Completed a major reduction in CPU stack use for the
   acpi_get_firmware_table external function.  In the 32-bit
   non-debug case, the stack use has been reduced from 168
   bytes to 32 bytes.
   
   Deployed a new run-time configuration flag,
   acpi_gbl_enable_interpeter_slack, whose purpose is to allow
   the AML interpreter to forgive certain bad AML constructs.
   Default setting is FALSE.
   
   Implemented the first use of acpi_gbl_enable_interpeter_slack
   in the Field IO support code.  If enabled, it allows field
   access to go beyond the end of a region definition if the
   field is within the region length rounded up to the next
   access width boundary (a common coding error.)
   
   Renamed OSD_HANDLER to acpi_osd_handler, and
   OSD_EXECUTION_CALLBACK to acpi_osd_exec_callback for
   consistency with other ACPI symbols.  Also, these symbols
   are lowercased by the latest version of the acpisrc tool.
   
   The prototypes for the PCI interfaces in acpiosxf.h
   have been updated to rename "register" to simply "reg"
   to prevent certain compilers from complaining.

<len.brown@intel.com> (04/07/15 1.1731.1.17)
   [ACPI] Enable run-time CM button/LID events (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=1415

<len.brown@intel.com> (04/07/15 1.1731.1.16)
   [ACPI] Create /proc/acpi/wakeup to allow enabling
   the optional wakeup event sources. (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=1415

<len.brown@intel.com> (04/07/15 1.1731.1.15)
   [ACPI] ACPI bus support for wakeup GPE (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=1415

<len.brown@intel.com> (04/07/15 1.1731.1.14)
   [ACPI] IOAPIC suspend/resume (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=3037

<len.brown@intel.com> (04/07/14 1.1731.1.13)
   [ACPI] Tell the BIOS Linux can handle
   Enhanced Speed Step (EST). (Venkatesh Pallipadi)
   http://bugzilla.kernel.org/show_bug.cgi?id=2712

<len.brown@intel.com> (04/07/14 1.1731.1.12)
   [ACPI] add SMP suport to processor driver (Venkatesh Pallipadi)
   http://bugzilla.kernel.org/show_bug.cgi?id=2615

<len.brown@intel.com> (04/07/14 1.1731.1.11)
   [ACPI] save/restore ELCR on suspend/resume (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=2643

<len.brown@intel.com> (04/07/14 1.1731.1.10)
   [ACPI] /proc/acpi/thermal_zone/THRM/cooling_mode
   Add concept of (mandatory) "critical", when (optional)
   "passive" and "active" are not present.  (Zhenyu Z Wang)
   http://bugzilla.kernel.org/show_bug.cgi?id=1770

<len.brown@intel.com> (04/07/14 1.1731.1.9)
   [ACPI] fix ability to set thermal trip points (Hugo Haas, Stefan
Seyfried)
   eg. # echo -n "100:90:80:70:60:50" >
/proc/acpi/thermal_zone/THRM/trip_points
   http://bugzilla.kernel.org/show_bug.cgi?id=2588

<len.brown@intel.com> (04/07/07 1.1731.1.8)
   [ACPI] reserve EBDA for Dell BIOS that neglects to. (David Shaohua
Li)
   http://bugme.osdl.org/show_bug.cgi?id=2990

<len.brown@intel.com> (04/06/24 1.1731.1.7)
   [ACPI] reserve IOPORTS for ACPI (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=2641

<len.brown@intel.com> (04/06/24 1.1731.1.6)
   [ACPI] enable GPE for ECDT (David Shaohua Li)

<len.brown@intel.com> (04/06/23 1.1731.1.5)
   [ACPI] enable Embedded Controller (EC)'s
   General Purpose Event (GPE) from David Shaohua Li

<len.brown@intel.com> (04/06/23 1.1728.2.5)
   [ACPI] fix return-from-sleep PM/ACPI state conversion bug (David
Shaohua Li)

<len.brown@intel.com> (04/06/22 1.1371.717.27)
   [ACPI] update EC GPE handler to new ACPICA handler type

<len.brown@intel.com> (04/06/22 1.1371.717.26)
   [ACPI] ACPICA 20040615 from Bob Moore
   
   Implemented support for Buffer and String objects (as
   per ACPI 2.0) for the following ASL operators: LEqual,
   LGreater, LLess, LGreaterEqual, and LLessEqual.

<len.brown@intel.com> (04/06/22 1.1371.717.25)
   [ACPI] ACPICA 20040527 from Bob Moore
   
   Completed a new design and implementation for EBDA
   (Extended BIOS Data Area) support in the RSDP scan code.
   The original code improperly scanned for the EBDA by simply
   scanning from memory location 0 to 0x400.  The correct
   method is to first obtain the EBDA pointer from within
   the BIOS data area, then scan 1K of memory starting at the
   EBDA pointer.  There appear to be few if any machines that
   place the RSDP in the EBDA, however.
   http://bugme.osdl.org/show_bug.cgi?id=2415
   
   Integrated a fix for a possible fault during evaluation
   of BufferField arguments.  Obsolete code that was causing
   the problem was removed. (Asus laptop boot crash)
   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=121760
   
   Found and fixed a problem in the Field Support Code
   where data could be corrupted on a bit field read that
   starts on an aligned boundary but does not end on an
   aligned boundary.  Merged the read/write "datum length"
   calculation code into a common procedure.

<len.brown@intel.com> (04/06/22 1.1371.717.24)
   [ACPI] ACPICA 20040514 from Bob Moore
   
   Fixed a problem where hardware GPE enable bits sometimes
   not set properly during and after GPE method execution.
   Result of ACPICA 20040427 changes.
   
   Removed extra "clear all GPEs" when sleeping/waking.
   
   Removed acpi_ht_enable_gpe and acpi_hw_disable_gpe, replaced
   by the single acpi_hw_write_gpe_enable_reg. Changed a couple
   of calls to the functions above to the new acpi_ev* calls
   as appropriate.
   
   ACPI_OS_NAME was removed from the OS-specific headers.
   The default name is now "Microsoft Windows NT" for maximum
   compatibility. However this can be changed by modifying
   the acconfig.h file.  Fixes EHCI probe issue:
   http://bugme.osdl.org/show_bug.cgi?id=1762
   
   Allow a single invocation of acpi_install_notify_handler
   for a handler that traps both types of notifies (System,
   Device). Use ACPI_ALL_NOTIFY flag.
   
   Run _INI methods on ThermalZone objects. This is against
   the ACPI specification, but there is apparently ASL code
   in the field that has these _INI methods, and apparently
   "other" AML interpreters execute them.
   
   Performed a full 16/32/64 bit lint that resulted in some
   small changes.

<len.brown@intel.com> (04/05/07 1.1371.717.23)
   [ACPI] ACPICA 20040427 from Bob Moore
   
   Completed a major overhaul of the GPE handling within ACPI CA.
   There are now three types of GPEs:
   wake-only; runtime-only; combination wake/run.
   
   The only GPEs allowed to be combination wake/run are for
   button-style devices such as a control-method power button,
   control-method sleep button, or a notebook lid switch.
   GPEs that have an _Lxx or _Exx method and are not referenced
   by any _PRW methods are marked for "runtime" and hardware enabled.
   
   Any GPE that is referenced by a _PRW method is marked for "wake"
   (and disabled at runtime).  However, at sleep time, only those
   GPEs that have been specifically enabled for wake via the
   acpi_enable_gpe() interface will actually be hardware enabled.
   
   A new external interface has been added, acpi_set_gpe_type()
   that is meant to be used by device drivers to force a GPE
   to a particular type.  It will be especially useful for the
   drivers for the button devices mentioned above.
   
   Completed restructuring of the ACPI CA initialization sequence
   so that default operation region handlers are installed
   before GPEs are initialized and the _PRW methods are executed.
   This will prevent errors when the _PRW methods attempt to
   access system memory or I/O space.
   
   GPE enable/disable no longer reads the GPE enable register.
   We now keep the enable info for runtime and wake separate
   and in the GPE_EVENT_INFO.  We thus no longer depend on
   the hardware to maintain these bits.
   
   Always clear the wake status and fixed/GPE status bits
   before sleep, even for state S5.
   
   Improved the AML debugger output for displaying the
   GPE blocks and their current status.
   
   Added new strings for the _OSI method, of the form
   "Windows 2001 SPx" where x = 0,1,2,3,4.
   
   Fixed a problem where the physical address was incorrectly
   calculated when the Load() operator was used to directly
   load from an Operation Region (vs. loading from a Field object.)
   Also added check for minimum table length for this case.
   
   Fix for multiple mutex acquisition.  Restore original thread
   SyncLevel on mutex release.
   
   Added ACPI_VALID_SXDS flag to the acpi_get_object_info interface
   for consistency with the other fields returned.
   
   Shrunk the ACPI_GPE_EVENT_INFO structure by 40%.
   There is one such structure for each GPE in the system,
   so the size of this structure is important.
   
   CPU stack requirement reduction:
   Cleaned up the method execution and object evaluation paths
   so that now a parameter structure is passed, instead of copying
   the various method parameters over and over again.
   
   In evregion.c:
   Correctly exit and reenter the interpreter region if and only
   if dispatching an operation region request to a user-installed
   handler. Do not exit/reenter when dispatching to a default
   handler (e.g., default system memory or I/O handlers)

<len.brown@intel.com> (04/05/07 1.1371.717.22)
   [ACPI] ACPICA 20040402 from Bob Moore
   
   Fixed an interpreter problem where an indirect store through an
   ArgX parameter was incorrectly applying the "implicit conversion
   rules" during the store.  From the ACPI specification: "If the
   target is a method local or argument (LocalX or ArgX), no
   conversion is performed and the result is stored directly to the
   target".  The new behavior is to disable implicit conversion
   during ALL stores to an ArgX.
   
   Changed the behavior of the _PRW method scan to ignore any and
   all errors returned by a given _PRW.  This prevents the scan from
   aborting from the failure of any single _PRW.
   
   Moved the runtime configuration parameters from the global init
   procedure to static variables in acglobal.h.  This will allow the
   host to override the default values easily.

<len.brown@intel.com> (04/05/03 1.1371.717.21)
   Cset exclude: torvalds@evo.osdl.org|ChangeSet|20040401021818|60003




