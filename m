Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbWBBFJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbWBBFJA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 00:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbWBBFJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 00:09:00 -0500
Received: from fmr23.intel.com ([143.183.121.15]:40413 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1161086AbWBBFI5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 00:08:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [GIT PATCH] ACPI patches for 2.6.16-rc1
Date: Thu, 2 Feb 2006 00:08:41 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005EC95CD@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [GIT PATCH] ACPI patches for 2.6.16-rc1
Thread-Index: AcYntrwFZEm7jGkqQWGkT9W7BsV2vQ==
From: "Brown, Len" <len.brown@intel.com>
To: <torvalds@osdl.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-acpi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Feb 2006 05:08:45.0984 (UTC) FILETIME=[BE7A1200:01C627B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
release

This updates the ACPICA core interpreter to the latest,
which includes a number of bug-fixes from simulation
and workarounds in response to failures in the field,
plus a resource manager update from several months ago
that has already shipped in some other operating systems.

This patch enables interrupt-mode of the Embedded Controller.
Polling mode can be restored with "ec_intr=0" if necessary,
though at least one major Linux distro has shipped a version
of this as default already without complaints.

One key fix is for bugzilla 5483 where Linux now tells the
BIOS only once about its Processor Driver Capabilities (_PDC).
This is for compatibility with BIOS in the field that were
confused by Linux and not confused by Windows.
For Linux it means that on systems which could run either the
acpi-cpufreq or speedstep-centrino drivers, only the
(preferred) speedstep-centrino driver will load and
acpi-cpufreq will not load.  The possible side-effect is
if somebody configures only the non-preferred acpi-cpufreq,
it will not load.  As the major distros ship both,
I don't expect this to be a problem.  In the long term
we need to merge these two drivers to make configuration
more idiot proof.

All of these patches except one are in the latest -mm,
and have been in previous -mm patches for various tenures.

This will update the files shown below.

thanks!

-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2
.6.16/acpi-20060127-2.6.16-rc1.diff.gz

 Documentation/kernel-parameters.txt               |    5 
 arch/i386/kernel/acpi/Makefile                    |    2 
 arch/i386/kernel/acpi/boot.c                      |    6 
 arch/i386/kernel/acpi/cstate.c                    |   58 
 arch/i386/kernel/acpi/processor.c                 |   75 
 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c       |   71 
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |   12 
 arch/i386/kernel/mpparse.c                        |    8 
 arch/ia64/kernel/Makefile                         |    5 
 arch/ia64/kernel/acpi-ext.c                       |   24 
 arch/ia64/kernel/acpi-processor.c                 |   67 
 arch/ia64/kernel/acpi.c                           |    6 
 arch/ia64/kernel/cpufreq/Makefile                 |    9 
 arch/ia64/kernel/cpufreq/acpi-cpufreq.c           |   51 
 arch/ia64/kernel/cpufreq/acpi-processor.c         |  134 
 arch/ia64/pci/pci.c                               |   10 
 arch/x86_64/kernel/acpi/Makefile                  |    5 
 arch/x86_64/kernel/acpi/processor.c               |   72 
 arch/x86_64/kernel/io_apic.c                      |   10 
 arch/x86_64/kernel/mpparse.c                      |   10 
 drivers/acpi/Kconfig                              |    1 
 drivers/acpi/acpi_memhotplug.c                    |   17 
 drivers/acpi/asus_acpi.c                          |   35 
 drivers/acpi/dispatcher/dsfield.c                 |   43 
 drivers/acpi/dispatcher/dsinit.c                  |   59 
 drivers/acpi/dispatcher/dsmethod.c                |  410 -
 drivers/acpi/dispatcher/dsmthdat.c                |   53 
 drivers/acpi/dispatcher/dsobject.c                |  122 
 drivers/acpi/dispatcher/dsopcode.c                |   86 
 drivers/acpi/dispatcher/dsutils.c                 |   45 
 drivers/acpi/dispatcher/dswexec.c                 |  100 
 drivers/acpi/dispatcher/dswload.c                 |  272 
 drivers/acpi/dispatcher/dswscope.c                |   10 
 drivers/acpi/dispatcher/dswstate.c                |  200 
 drivers/acpi/ec.c                                 |  301 -
 drivers/acpi/events/evevent.c                     |   65 
 drivers/acpi/events/evgpe.c                       |   80 
 drivers/acpi/events/evgpeblk.c                    |  239 
 drivers/acpi/events/evmisc.c                      |   32 
 drivers/acpi/events/evregion.c                    |   89 
 drivers/acpi/events/evrgnini.c                    |    8 
 drivers/acpi/events/evsci.c                       |    6 
 drivers/acpi/events/evxface.c                     |   29 
 drivers/acpi/events/evxfevnt.c                    |   50 
 drivers/acpi/events/evxfregn.c                    |    2 
 drivers/acpi/executer/exconfig.c                  |   10 
 drivers/acpi/executer/exconvrt.c                  |   38 
 drivers/acpi/executer/excreate.c                  |    6 
 drivers/acpi/executer/exdump.c                    |  683 +-
 drivers/acpi/executer/exfield.c                   |   11 
 drivers/acpi/executer/exfldio.c                   |  125 
 drivers/acpi/executer/exmisc.c                    |  145 
 drivers/acpi/executer/exmutex.c                   |   28 
 drivers/acpi/executer/exnames.c                   |   35 
 drivers/acpi/executer/exoparg1.c                  |  116 
 drivers/acpi/executer/exoparg2.c                  |   68 
 drivers/acpi/executer/exoparg3.c                  |   20 
 drivers/acpi/executer/exoparg6.c                  |   24 
 drivers/acpi/executer/exprep.c                    |   40 
 drivers/acpi/executer/exregion.c                  |   41 
 drivers/acpi/executer/exresnte.c                  |   87 
 drivers/acpi/executer/exresolv.c                  |   65 
 drivers/acpi/executer/exresop.c                   |  187 
 drivers/acpi/executer/exstore.c                   |   37 
 drivers/acpi/executer/exstoren.c                  |   30 
 drivers/acpi/executer/exstorob.c                  |    6 
 drivers/acpi/executer/exsystem.c                  |    8 
 drivers/acpi/executer/exutils.c                   |   22 
 drivers/acpi/glue.c                               |   14 
 drivers/acpi/hardware/hwacpi.c                    |   29 
 drivers/acpi/hardware/hwgpe.c                     |    2 
 drivers/acpi/hardware/hwregs.c                    |   75 
 drivers/acpi/hardware/hwsleep.c                   |   23 
 drivers/acpi/hardware/hwtimer.c                   |    2 
 drivers/acpi/motherboard.c                        |   34 
 drivers/acpi/namespace/nsaccess.c                 |   49 
 drivers/acpi/namespace/nsalloc.c                  |   15 
 drivers/acpi/namespace/nsdump.c                   |   17 
 drivers/acpi/namespace/nsdumpdv.c                 |    2 
 drivers/acpi/namespace/nseval.c                   |    7 
 drivers/acpi/namespace/nsinit.c                   |  125 
 drivers/acpi/namespace/nsload.c                   |   14 
 drivers/acpi/namespace/nsnames.c                  |   18 
 drivers/acpi/namespace/nsobject.c                 |   21 
 drivers/acpi/namespace/nsparse.c                  |    2 
 drivers/acpi/namespace/nssearch.c                 |   36 
 drivers/acpi/namespace/nsutils.c                  |   53 
 drivers/acpi/namespace/nswalk.c                   |    2 
 drivers/acpi/namespace/nsxfeval.c                 |   45 
 drivers/acpi/namespace/nsxfname.c                 |    5 
 drivers/acpi/namespace/nsxfobj.c                  |    2 
 drivers/acpi/osl.c                                |   18 
 drivers/acpi/parser/psargs.c                      |  370 -
 drivers/acpi/parser/psloop.c                      |   47 
 drivers/acpi/parser/psopcode.c                    |    4 
 drivers/acpi/parser/psparse.c                     |   69 
 drivers/acpi/parser/psscope.c                     |    2 
 drivers/acpi/parser/pstree.c                      |    9 
 drivers/acpi/parser/psutils.c                     |    2 
 drivers/acpi/parser/pswalk.c                      |    2 
 drivers/acpi/parser/psxface.c                     |  146 
 drivers/acpi/pci_irq.c                            |   48 
 drivers/acpi/pci_link.c                           |  106 
 drivers/acpi/pci_root.c                           |   14 
 drivers/acpi/processor_core.c                     |   30 
 drivers/acpi/processor_idle.c                     |  133 
 drivers/acpi/processor_perflib.c                  |    4 
 drivers/acpi/processor_thermal.c                  |    7 
 drivers/acpi/processor_throttling.c               |    7 
 drivers/acpi/resources/Makefile                   |    2 
 drivers/acpi/resources/rsaddr.c                   | 2000 ++----
 drivers/acpi/resources/rscalc.c                   | 1695 ++---
 drivers/acpi/resources/rscreate.c                 |  245 
 drivers/acpi/resources/rsdump.c                   | 2927 ++++------
 drivers/acpi/resources/rsinfo.c                   |  220 
 drivers/acpi/resources/rsio.c                     |  866 +-
 drivers/acpi/resources/rsirq.c                    |  988 +--
 drivers/acpi/resources/rslist.c                   | 1134 +--
 drivers/acpi/resources/rsmemory.c                 |  861 +-
 drivers/acpi/resources/rsmisc.c                   | 1888 +++---
 drivers/acpi/resources/rsutils.c                  |  818 ++
 drivers/acpi/resources/rsxface.c                  |  258 
 drivers/acpi/scan.c                               |    2 
 drivers/acpi/sleep/poweroff.c                     |   15 
 drivers/acpi/sleep/sleep.h                        |    2 
 drivers/acpi/sleep/wakeup.c                       |    6 
 drivers/acpi/tables/tbconvrt.c                    |   23 
 drivers/acpi/tables/tbget.c                       |   43 
 drivers/acpi/tables/tbgetall.c                    |   27 
 drivers/acpi/tables/tbinstal.c                    |   12 
 drivers/acpi/tables/tbrsdt.c                      |   38 
 drivers/acpi/tables/tbutils.c                     |   64 
 drivers/acpi/tables/tbxface.c                     |   36 
 drivers/acpi/tables/tbxfroot.c                    |   45 
 drivers/acpi/utilities/Makefile                   |    5 
 drivers/acpi/utilities/utalloc.c                  |   95 
 drivers/acpi/utilities/utcache.c                  |    2 
 drivers/acpi/utilities/utcopy.c                   |   31 
 drivers/acpi/utilities/utdebug.c                  |    2 
 drivers/acpi/utilities/utdelete.c                 |   19 
 drivers/acpi/utilities/uteval.c                   |   60 
 drivers/acpi/utilities/utglobal.c                 |  114 
 drivers/acpi/utilities/utinit.c                   |   15 
 drivers/acpi/utilities/utmath.c                   |   18 
 drivers/acpi/utilities/utmisc.c                   |  527 -
 drivers/acpi/utilities/utmutex.c                  |   70 
 drivers/acpi/utilities/utobject.c                 |   57 
 drivers/acpi/utilities/utresrc.c                  |  574 +
 drivers/acpi/utilities/utstate.c                  |    4 
 drivers/acpi/utilities/utxface.c                  |   73 
 drivers/acpi/video.c                              |    8 
 drivers/char/hpet.c                               |   28 
 drivers/pnp/pnpacpi/core.c                        |   14 
 drivers/pnp/pnpacpi/rsparser.c                    |  615 +-
 drivers/serial/8250_acpi.c                        |   28 
 include/acpi/acconfig.h                           |   40 
 include/acpi/acdebug.h                            |    2 
 include/acpi/acdisasm.h                           |  117 
 include/acpi/acdispat.h                           |    5 
 include/acpi/acevents.h                           |    8 
 include/acpi/acexcep.h                            |    2 
 include/acpi/acglobal.h                           |   25 
 include/acpi/achware.h                            |    2 
 include/acpi/acinterp.h                           |   48 
 include/acpi/aclocal.h                            |  148 
 include/acpi/acmacros.h                           |  301 -
 include/acpi/acnames.h                            |    2 
 include/acpi/acnamesp.h                           |    4 
 include/acpi/acobject.h                           |    4 
 include/acpi/acopcode.h                           |    2 
 include/acpi/acoutput.h                           |   12 
 include/acpi/acparser.h                           |    2 
 include/acpi/acpi.h                               |    2 
 include/acpi/acpi_drivers.h                       |    4 
 include/acpi/acpiosxf.h                           |   10 
 include/acpi/acpixf.h                             |   13 
 include/acpi/acresrc.h                            |  802 +-
 include/acpi/acstruct.h                           |    2 
 include/acpi/actables.h                           |    2 
 include/acpi/actbl.h                              |    8 
 include/acpi/actbl1.h                             |    2 
 include/acpi/actbl2.h                             |    2 
 include/acpi/actypes.h                            |  717 +-
 include/acpi/acutils.h                            |   82 
 include/acpi/amlcode.h                            |    2 
 include/acpi/amlresrc.h                           |  319 -
 include/acpi/pdc_intel.h                          |    4 
 include/acpi/platform/acenv.h                     |   24 
 include/acpi/platform/acgcc.h                     |   10 
 include/acpi/platform/aclinux.h                   |    8 
 include/acpi/processor.h                          |   28 
 include/asm-i386/acpi.h                           |    2 
 include/asm-x86_64/mpspec.h                       |    2 
 include/linux/acpi.h                              |    2 
 include/linux/kernel.h                            |    1 
 include/linux/reboot.h                            |    3 
 kernel/power/disk.c                               |    9 
 kernel/power/main.c                               |    4 
 kernel/sys.c                                      |   25 
 199 files changed, 12892 insertions(+), 12931 deletions(-)

through these commits:

Adrian Bunk:
      [ACPI] make two processor functions static

Alexey Starikovskiy:
      [ACPI] fix reboot upon suspend-to-disk

Arjan van de Ven:
      [ACPI] move some run-time structure inits to compile time

Benoit Boissinot:
      [ACPI] fix acpi_cpufreq.c build warrning

Bjorn Helgaas:
      [ACPI] enable PNPACPI support for resource types used by HP serial
ports

Bob Moore:
      [ACPI] ACPICA 20050930
      [ACPI] ACPICA 20051021
      [ACPI] ACPICA 20051102
      [ACPI] ACPICA 20051117
      [ACPI] ACPICA 20051202
      [ACPI] ACPICA 20051216
      [ACPI] ACPICA 20060113
      [ACPI] ACPICA 20060127

David Shaohua Li:
      [ACPI] SMP S3 resume: evaluate _WAK after INIT

Janosch Machowinski:
      [ACPI] handle BIOS with implicit C1 in _CST

KAMEZAWA Hiroyuki:
      [ACPI] acpi_memhotplug.c build fix

Karol Kozimor:
      [ASUS_ACPI] work around Samsung P30s oops
      [ACPI_ASUS] M6R display reading
      [ACPI_ASUS] fix asus module param description

Kenji Kaneshige:
      [ACPI] build EC driver on IA64

Len Brown:
      [ACPI] handle ACPICA 20050916's acpi_resource.type rename
      [ACPI] clean up ACPICA 20050916's rscalc typedef syntax
      [ACPI] 8250_acpi.c buildfix
      [ACPI] Embedded Controller (EC) driver syntax update
      [ACPI] Enable Embedded Controller (EC) interrupt mode by default
      [ACPI] Embedded Controller (EC) driver printk syntax update
      [ACPI] acpi_register_gsi() fix needed for ACPICA 20051021
      [ACPI] fix osl.c build warning
      [ACPI] fix pnpacpi regression resulting from ACPICA 20051117
      Revert "[ACPI] fix pnpacpi regression resulting from ACPICA
20051117"
      [ACPI] better fix for pnpacpi regression resulting from ACPICA
20051117
      [ACPI] delete message "**** SET: Misaligned resource pointer:"
      [ACPI] remove "Resource isn't an IRQ" warning

Luming Yu:
      [ACPI] Disable EC burst mode w/o disabling EC interrupts

MAEDA Naoaki:
      [ACPI] ia64 build fix

matthieu castet:
      [PNPACPI] Ignore devices that have no resources
      [PNPACPI] clean excluded_id_list[]

Robert Moore:
      [ACPI] ACPICA 20050916

Thomas Rosner:
      [ACPI] Disable C2/C3 for _all_ IBM R40e Laptops

Venkatesh Pallipadi:
      [ACPI] Avoid BIOS inflicted crashes by evaluating _PDC only once
      [ACPI] IA64 ZX1 buildfix for _PDC patch

Yu Luming:
      [ACPI] fix acpi_os_wait_sempahore() finite timeout case (AE_TIME
warning)

with this log:

commit b8e4d89357fc434618a59c1047cac72641191805
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Jan 27 16:43:00 2006 -0500

    [ACPI] ACPICA 20060127
    
    Implemented support in the Resource Manager to allow
    unresolved namestring references within resource package
    objects for the _PRT method. This support is in addition
    to the previously implemented unresolved reference
    support within the AML parser. If the interpreter slack
    mode is enabled (true on Linux unless acpi=strict),
    these unresolved references will be passed through
    to the caller as a NULL package entry.
    http://bugzilla.kernel.org/show_bug.cgi?id=5741
    
    Implemented and deployed new macros and functions for
    error and warning messages across the subsystem. These
    macros are simpler and generate less code than their
    predecessors. The new macros ACPI_ERROR, ACPI_EXCEPTION,
    ACPI_WARNING, and ACPI_INFO replace the ACPI_REPORT_*
    macros.
    
    Implemented the acpi_cpu_flags type to simplify host OS
    integration of the Acquire/Release Lock OSL interfaces.
    Suggested by Steven Rostedt and Andrew Morton.
    
    Fixed a problem where Alias ASL operators are sometimes
    not correctly resolved. causing AE_AML_INTERNAL
    http://bugzilla.kernel.org/show_bug.cgi?id=5189
    http://bugzilla.kernel.org/show_bug.cgi?id=5674
    
    Fixed several problems with the implementation of the
    ConcatenateResTemplate ASL operator. As per the ACPI
    specification, zero length buffers are now treated as a
    single EndTag. One-length buffers always cause a fatal
    exception. Non-zero length buffers that do not end with
    a full 2-byte EndTag cause a fatal exception.
    
    Fixed a possible structure overwrite in the
    AcpiGetObjectInfo external interface. (With assistance
    from Thomas Renninger)
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 292dd876ee765c478b27c93cc51e93a558ed58bf
Merge: d4ec6c7cc9a15a7a529719bc3b84f46812f9842e
9fdb62af92c741addbea15545f214a6e89460865
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jan 27 17:18:29 2006 -0500

    Pull release into acpica branch

commit d4ec6c7cc9a15a7a529719bc3b84f46812f9842e
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jan 26 17:23:38 2006 -0500

    [ACPI] remove "Resource isn't an IRQ" warning
    
    In the case where a (broken) BIOS gives  us a blank _CRS for
    a PCI Interrupt Link Device, the acpi_walk_resources()
    will not terminate, but will then give the callback
    the resource end tag.  Ignore the end tag.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9fdb62af92c741addbea15545f214a6e89460865
Merge: 3ee68c4af3fd7228c1be63254b9f884614f9ebb2
876c184b31dc73cc3f38c5b86dee55d091a56769
729b4d4ce1982c52040bbf22d6711cdf8db07ad8
cf82478840188f8c8494c1d7a668a8ae170d0e07
dacd9b80355525be0e3c519687868410e304ad1c
63c94b68ec30847a6e2b36651703f41066f91480
35f652b5ef4ef145ac5514f6302b3f4cebfbbad4
1a38416cea8ac801ae8f261074721f35317613dc
4a90c7e86202f46fa9af011bdbcdf36e355d1721
aea19aa0780d4b006372fedab8434226e1cc7686
757b18661ea0a0d890e8ce7b1a391e5b7d417d78
c4bb6f5ad968540d7f9619565bacd18d7419b85f
Author: Len Brown <len.brown@intel.com>
Date:   Tue Jan 24 17:52:48 2006 -0500

    [ACPI] merge 3549 4320 4485 4588 4980 5483 5651 acpica asus fops
pnpacpi branches into release
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4a90c7e86202f46fa9af011bdbcdf36e355d1721
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Jan 13 16:22:00 2006 -0500

    [ACPI] ACPICA 20060113
    
    Added 2006 copyright.
    
    At SuSE's suggestion, enabled all error messages
    without enabling function tracing, ie with CONFIG_ACPI_DEBUG=n
    
    Replaced all instances of the ACPI_DEBUG_PRINT macro invoked at
    the ACPI_DB_ERROR and ACPI_DB_WARN debug levels with
    the ACPI_REPORT_ERROR and ACPI_REPORT_WARNING macros,
    respectively. This preserves all error and warning messages
    in the non-debug version of the ACPICA code (this has been
    referred to as the "debug lite" option.) Over 200 cases
    were converted to create a total of over 380 error/warning
    messages across the ACPICA code. This increases the code
    and data size of the default non-debug version by about 13K.
    Added ACPI_NO_ERROR_MESSAGES flag to enable deleting all messages.
    The size of the debug version remains about the same.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3c5c363826e435cf4d54d917202567e5b57cae5f
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jan 20 01:17:42 2006 -0500

    [ACPI] delete message "**** SET: Misaligned resource pointer:"
    
    This check, added in ACPICA 20051021, was overly paranoid.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0af5853bccd263161df80c259d61fc71211c5ac3
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jan 20 01:11:37 2006 -0500

    [ACPI] better fix for pnpacpi regression resulting from ACPICA
20051117
    
    Rather than tweaking acpi_walk_resource() again not return end tags,
    modify the pnpacpi code to ignore them.
    
    The pnpacpi resource type switch statements now include all known
    types in the order that they're defined -- so it is easy to see
    what is not implemented.  The code will squawk only if it sees
    a truly undefined type.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2ae4117435b30c7f9c12c89bcb323ce48b08c16a
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jan 16 15:22:45 2006 -0500

    Revert "[ACPI] fix pnpacpi regression resulting from ACPICA
20051117"
    
    This reverts ed349a8a0a780ed27e2a765f16cee54d9b63bfee commit.

commit 757b18661ea0a0d890e8ce7b1a391e5b7d417d78
Author: Adrian Bunk <bunk@stusta.de>
Date:   Sat Jan 7 13:19:00 2006 -0500

    [ACPI] make two processor functions static
    
    acpi_processor_write_throttling()
    acpi_processor_write_limit()
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c4bb6f5ad968540d7f9619565bacd18d7419b85f
Author: matthieu castet <castet.matthieu@free.fr>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [PNPACPI] clean excluded_id_list[]
    
    Clean the blacklist.  Battery, Button, Fan have no _CRS
    and can be removed.  PCI root is in pnpbios and is harmless.
    
    Cc: Adam Belay <ambx1@neo.rr.com>
    Cc: "Li, Shaohua" <shaohua.li@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 07b0120d53a3e7cbc88458a64a4d668fc416100f
Author: matthieu castet <castet.matthieu@free.fr>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [PNPACPI] Ignore devices that have no resources
    
    Ignore devices that don't have a _CRS method.
    They are useless for the PNP layer as they don't provide any
resources.
    
    Cc: Adam Belay <ambx1@neo.rr.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 876c184b31dc73cc3f38c5b86dee55d091a56769
Author: Thomas Rosner <kernel-bugs@digital-trauma.de>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [ACPI] Disable C2/C3 for _all_ IBM R40e Laptops
    
    This adds all known BIOS versions of IBM R40e Laptops to the C2/C3
    processor state blacklist and thus prevents them from crashing.
    workaround for http://bugzilla.kernel.org/show_bug.cgi?id=3549
    
    Signed-off-by: Thomas Rosner <kernel-bugs@digital-trauma.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 35f652b5ef4ef145ac5514f6302b3f4cebfbbad4
Author: Benoit Boissinot <bboissin@gmail.com>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [ACPI] fix acpi_cpufreq.c build warrning
    
    Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3963f00831bc01f509c7dc38d050505fca64f67d
Author: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [ACPI] acpi_memhotplug.c build fix
    
    drivers/acpi/acpi_memhotplug.c: In function
`acpi_memory_get_device_resources':
    drivers/acpi/acpi_memhotplug.c:101: error: structure has no member
named `attribute'
    drivers/acpi/acpi_memhotplug.c:103: error: structure has no member
named `attribute'
    drivers/acpi/acpi_memhotplug.c: In function
`acpi_memory_disable_device':
    drivers/acpi/acpi_memhotplug.c:253: warning: unused variable `attr'
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d479e908457f4972205fcafa054f8030e91781ef
Author: Arjan van de Ven <arjan@infradead.org>
Date:   Fri Jan 6 16:47:00 2006 -0500

    [ACPI] move some run-time structure inits to compile time
    
    acpi_processor_limit_fops.write was written at run time,
    but can be initiailized at compile-time instead.
    
    Similar for acpi_video_bus_POST_fops.write and friends,
    but keep doing those at runtime to avoid prototype-hell.
    
    Signed-off-by: Arjan van de Ven <arjan@infradead.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ed03f430cdc8c802652467e9097606fedc2c7abc
Merge: ed349a8a0a780ed27e2a765f16cee54d9b63bfee
6f957eaf79356a32e838f5f262ee9a60544b1d5b
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jan 7 03:50:18 2006 -0500

    Pull pnpacpi into acpica branch

commit 6f957eaf79356a32e838f5f262ee9a60544b1d5b
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Sep 20 15:26:00 2005 -0400

    [ACPI] enable PNPACPI support for resource types used by HP serial
ports
    
    PNPACPI complained about and ignored devices with ADDRESS16,
ADDRESS32, or
    ADDRESS64 descriptors in _PRS.  HP firmware uses them for built-in
serial
    ports, so this patch adds support for parsing these descriptors from
_PRS.
    
    Note that this does not add the corresponding support for encoding
them in
    preparation for _SRS, because I don't have any machine that supports
_SRS
    on these descriptors, so I couldn't test that support.  Attempts to
encode
    them will cause a warning and an -EINVAL return.
    
 
http://sourceforge.net/mailarchive/forum.php?thread_id=8250154&forum_id=
6102
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ed349a8a0a780ed27e2a765f16cee54d9b63bfee
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jan 5 02:40:11 2006 -0500

    [ACPI] fix pnpacpi regression resulting from ACPICA 20051117
    
    In ACPICA 20051117, acpi_walk_resources() started
    sending ACPI_RESOURCE_TYPE_END_TAG to the callback
    routine which wasn't prepared for it, causing
    _CRS to fail and PnPACPI to not recognize any devices:
    
    pnp: ACPI device : hid PNP0C02
    pnp: PnPACPI: unknown resource type 7
    pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c02
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit aea19aa0780d4b006372fedab8434226e1cc7686
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Tue Jan 3 23:05:00 2006 -0500

    [ACPI_ASUS] fix asus module param description
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bb84db937a875045de9e6d08d177ad3223ae0ae3
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Tue Jan 3 23:03:00 2006 -0500

    [ACPI_ASUS] M6R display reading
    
    This patch corrects the node to read display settings on M6R
laptops.
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit dacd9b80355525be0e3c519687868410e304ad1c
Author: Yu Luming <luming.yu@intel.com>
Date:   Sat Dec 31 01:45:00 2005 -0500

    [ACPI] fix acpi_os_wait_sempahore() finite timeout case (AE_TIME
warning)
    
    Before this fix, the finite timeout case
    behaved like the no-timeout (trylock) case.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4588
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b697b5372ecfe0c57ee26e0c3787fc2306109228
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Thu Dec 22 12:42:00 2005 -0500

    [ASUS_ACPI] work around Samsung P30s oops
    
    The code used to rely on a certain method to return a NULL buffer,
which
    is now hardly possible with the implicit return code on by default.
This
    sort of fixes bugs #5067 and #5092 for now.
    
    Note: this patch makes the driver unusable on said machines (and on
said
    machines only) iff acpi=strict is specified, but it seems noone
really uses
    that.
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3173cdfe02995f6c6841a28b5148f94cefd8ab77
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 28 03:20:03 2005 -0500

    [ACPI] fix osl.c build warning
    
    typecheck complains on i386 that u32 != unsigned long
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit defba1d8f233c0d5cf3e1ea6aeb898eca7231860
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Dec 16 17:05:00 2005 -0500

    [ACPI] ACPICA 20051216
    
    Implemented optional support to allow unresolved names
    within ASL Package objects. A null object is inserted in
    the package when a named reference cannot be located in
    the current namespace. Enabled via the interpreter slack
    flag which Linux has enabled by default (acpi=strict
    to disable slack).  This should eliminate AE_NOT_FOUND
    exceptions seen on machines that contain such code.
    
    Implemented an optimization to the initialization
    sequence that can improve boot time. During ACPI device
    initialization, the _STA method is now run if and only
    if the _INI method exists. The _STA method is used to
    determine if the device is present; An _INI can only be
    run if _STA returns present, but it is a waste of time to
    run the _STA method if the _INI does not exist. (Prototype
    and assistance from Dong Wei)
    
    Implemented use of the C99 uintptr_t for the pointer
    casting macros if it is available in the current
    compiler. Otherwise, the default (void *) cast is used
    as before.
    
    Fixed some possible memory leaks found within the
    execution path of the Break, Continue, If, and CreateField
    operators. (Valery Podrezov)
    
    Fixed a problem introduced in the 20051202 release where
    an exception is generated during method execution if a
    control method attempts to declare another method.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cb654695f6b912cef7cb3271665b6ee0d416124c
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 28 02:43:51 2005 -0500

    [ACPI] acpi_register_gsi() fix needed for ACPICA 20051021
    
    Use the #define for ACPI_LEVEL_SENSITIVE instead of assuming
    non-zero, because ACPICA 20051021 changes its value to zero.
    
    Also, use uniform variable names:
    edge_level -> triggering
    active_high_low -> polarity
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 63c94b68ec30847a6e2b36651703f41066f91480
Author: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date:   Mon Dec 5 20:51:00 2005 -0500

    [ACPI] build EC driver on IA64
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 729b4d4ce1982c52040bbf22d6711cdf8db07ad8
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 1 04:29:00 2005 -0500

    [ACPI] fix reboot upon suspend-to-disk
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4320
    
    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Acked-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 28f55ebce5bd2fceec8adc7c8860953d3e4532a8
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Dec 2 18:27:00 2005 -0500

    [ACPI] ACPICA 20051202
    
    Modified the parsing of control methods to no longer
    create namespace objects during the first pass of the
    parse. Objects are now created only during the execute
    phase, at the moment the namespace creation operator
    is encountered in the AML (Name, OperationRegion,
    CreateByteField, etc.) This should eliminate ALREADY_EXISTS
    exceptions seen on some machines where reentrant control
    methods are protected by an AML mutex. The mutex will now
    correctly block multiple threads from attempting to create
    the same object more than once.
    
    Increased the number of available Owner Ids for namespace
    object tracking from 32 to 255. This should eliminate the
    OWNER_ID_LIMIT exceptions seen on some machines with a
    large number of ACPI tables (either static or dynamic).
    
    Enhanced the namespace dump routine to output the owner
    ID for each namespace object.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c51a4de85de720670f2fbc592a6f8040af72ad87
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Nov 17 13:07:00 2005 -0500

    [ACPI] ACPICA 20051117
    
    Fixed a problem in the AML parser where the method thread
    count could be decremented below zero if any errors
    occurred during the method parse phase. This should
    eliminate AE_AML_METHOD_LIMIT exceptions seen on some
    machines. This also fixed a related regression with the
    mechanism that detects and corrects methods that cannot
    properly handle reentrancy (related to the deployment of
    the new OwnerId mechanism.)
    
    Eliminated the pre-parsing of control methods (to detect
    errors) during table load. Related to the problem above,
    this was causing unwind issues if any errors occurred
    during the parse, and it seemed to be overkill. A table
    load should not be aborted if there are problems with
    any single control method, thus rendering this feature
    rather pointless.
    
    Fixed a problem with the new table-driven resource manager
    where an internal buffer overflow could occur for small
    resource templates.
    
    Implemented a new external interface, acpi_get_vendor_resource()
    This interface will find and return a vendor-defined
    resource descriptor within a _CRS or _PRS
    method via an ACPI 3.0 UUID match. (from Bjorn Helgaas)
    
    Removed the length limit (200) on string objects as
    per the upcoming ACPI 3.0A specification. This affects
    the following areas of the interpreter: 1) any implicit
    conversion of a Buffer to a String, 2) a String object
    result of the ASL Concatentate operator, 3) the String
    object result of the ASL ToString operator.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 96db255c8f014ae3497507104e8df809785a619f
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Nov 2 00:00:00 2005 -0500

    [ACPI] ACPICA 20051102
    
    Modified the subsystem initialization sequence to improve
    GPE support. The GPE initialization has been split into
    two parts in order to defer execution of the _PRW methods
    (Power Resources for Wake) until after the hardware is
    fully initialized and the SCI handler is installed. This
    allows the _PRW methods to access fields protected by the
    Global Lock. This will fix systems where a NO_GLOBAL_LOCK
    exception has been seen during initialization.
    
    Fixed a regression with the ConcatenateResTemplate()
    ASL operator introduced in the 20051021 release.
    
    Implemented support for "local" internal ACPI object
    types within the debugger "Object" command and the
    acpi_walk_namespace() external interfaces. These local
    types include RegionFields, BankFields, IndexFields, Alias,
    and reference objects.
    
    Moved common AML resource handling code into a new file,
    "utresrc.c". This code is shared by both the Resource
    Manager and the AML Debugger.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0897831bb54eb36fd9e2a22da7f0f64be1b20d09
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Oct 21 00:00:00 2005 -0400

    [ACPI] ACPICA 20051021
    
    Implemented support for the EM64T and other x86_64
    processors. This essentially entails recognizing
    that these processors support non-aligned memory
    transfers. Previously, all 64-bit processors were assumed
    to lack hardware support for non-aligned transfers.
    
    Completed conversion of the Resource Manager to nearly
    full table-driven operation. Specifically, the resource
    conversion code (convert AML to internal format and the
    reverse) and the debug code to dump internal resource
    descriptors are fully table-driven, reducing code and data
    size and improving maintainability.
    
    The OSL interfaces for Acquire and Release Lock now use a
    64-bit flag word on 64-bit processors instead of a fixed
    32-bit word. (Alexey Starikovskiy)
    
    Implemented support within the resource conversion code
    for the Type-Specific byte within the various ACPI 3.0
    *WordSpace macros.
    
    Fixed some issues within the resource conversion code for
    the type-specific flags for both Memory and I/O address
    resource descriptors. For Memory, implemented support
    for the MTP and TTP flags. For I/O, split the TRS and TTP
    flags into two separate fields.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 50eca3eb89d73d9f0aa070b126c7ee6a616016ab
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Sep 30 19:03:00 2005 -0400

    [ACPI] ACPICA 20050930
    
    Completed a major overhaul of the Resource Manager code -
    specifically, optimizations in the area of the AML/internal
    resource conversion code. The code has been optimized to
    simplify and eliminate duplicated code, CPU stack use has
    been decreased by optimizing function parameters and local
    variables, and naming conventions across the manager have
    been standardized for clarity and ease of maintenance (this
    includes function, parameter, variable, and struct/typedef
    names.)
    
    All Resource Manager dispatch and information tables have
    been moved to a single location for clarity and ease of
    maintenance. One new file was created, named "rsinfo.c".
    
    The ACPI return macros (return_ACPI_STATUS, etc.) have
    been modified to guarantee that the argument is
    not evaluated twice, making them less prone to macro
    side-effects. However, since there exists the possibility
    of additional stack use if a particular compiler cannot
    optimize them (such as in the debug generation case),
    the original macros are optionally available.  Note that
    some invocations of the return_VALUE macro may now cause
    size mismatch warnings; the return_UINT8 and return_UINT32
    macros are provided to eliminate these. (From Randy Dunlap)
    
    Implemented a new mechanism to enable debug tracing for
    individual control methods. A new external interface,
    acpi_debug_trace(), is provided to enable this mechanism. The
    intent is to allow the host OS to easily enable and disable
    tracing for problematic control methods. This interface
    can be easily exposed to a user or debugger interface if
    desired. See the file psxface.c for details.
    
    acpi_ut_callocate() will now return a valid pointer if a
    length of zero is specified - a length of one is used
    and a warning is issued. This matches the behavior of
    acpi_ut_allocate().
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3d5271f9883cba7b54762bc4fe027d4172f06db7
Merge: 378b2556f4e09fa6f87ff0cb5c4395ff28257d02
9115a6c787596e687df03010d97fccc5e0762506
Author: Len Brown <len.brown@intel.com>
Date:   Tue Dec 6 17:31:30 2005 -0500

    Pull release into acpica branch

commit 9115a6c787596e687df03010d97fccc5e0762506
Merge: 927fe18397b3b1194a5b26b1d388d97e391e5fd2
e4f5c82a92c2a546a16af1614114eec19120e40a
Author: Len Brown <len.brown@intel.com>
Date:   Tue Dec 6 16:27:40 2005 -0500

    Auto-update from upstream

commit c82e6abfb3182c84d0204b178363086b09881a4a
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Dec 1 18:16:00 2005 -0500

    [ACPI] IA64 ZX1 buildfix for _PDC patch
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5483
    
    ZX1 config doesn't include cpufreq, so move move acpi-processor.c
    up out of ia64/cpufreq directory.
    
    no functional changes
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1e8df53c925024548cca4374f03bed1a7e2b0c45
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 16:47:46 2005 -0500

    [ACPI] Embedded Controller (EC) driver printk syntax update
    
    no functional changes
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 53f11d4ff8797bcceaf014e62bd39f16ce84baec
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 16:46:36 2005 -0500

    [ACPI] Enable Embedded Controller (EC) interrupt mode by default
    
    "ec_intr=0" reverts to polling
    "ec_burst=" no longer exists.
    
    Signed-off-by: Len Brown <len.brown@intel.com>
    Acked-by: Luming Yu <luming.yu@intel.com>

commit 02b28a33aae93a3b53068e0858d62f8bcaef60a3
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 16:33:04 2005 -0500

    [ACPI] Embedded Controller (EC) driver syntax update
    
    "intr" largely replaces "burst" for syntax to follow semantics
    "poll" largely replaces "polling" for economy of expression
    append "interrupt mode" or "polling mode" to dmesg line
    
    no functional changes
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 06a2a3855e20ed3df380d69b37130ba86bec8001
Author: Luming Yu <luming.yu@intel.com>
Date:   Tue Sep 27 00:43:00 2005 -0400

    [ACPI] Disable EC burst mode w/o disabling EC interrupts
    
    Need to de-couple the concept of polling/interrupts
    vs burst/non-burst.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4980
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cf82478840188f8c8494c1d7a668a8ae170d0e07
Author: Janosch Machowinski <jmachowinski@gmx.de>
Date:   Sat Aug 20 08:02:00 2005 -0400

    [ACPI] handle BIOS with implicit C1 in _CST
    
    The ASUS M6Ne specifies C2, implying C1
    but not explicitly specifying it.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4485
    
    Signed-off-by: Janosch Machowinski <jmachowinski@gmx.de>
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 05131ecc99ea9da7f45ba3058fe8a2c1d0ceeab8
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Sun Oct 23 16:31:00 2005 -0400

    [ACPI] Avoid BIOS inflicted crashes by evaluating _PDC only once
    
    Linux invokes the AML _PDC method (Processor Driver Capabilities)
    to tell the BIOS what features it can handle.  While the ACPI
    spec says nothing about the OS invoking _PDC multiple times,
    doing so with changing bits seems to hopelessly confuse the BIOS
    on multiple platforms up to and including crashing the system.
    
    Factor out the _PDC invocation so Linux invokes it only once.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5483
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1a38416cea8ac801ae8f261074721f35317613dc
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Wed Nov 23 12:36:00 2005 -0500

    [ACPI] SMP S3 resume: evaluate _WAK after INIT
    
    On SMP resume from S3, we reset (INIT) the non-boot
    processors to boot them cleanly.  But the BIOS needs
    to execute _WAK after INIT in order to properly
    initialized these processors upon resume.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5651
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 378b2556f4e09fa6f87ff0cb5c4395ff28257d02
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 21:03:21 2005 -0500

    [ACPI] 8250_acpi.c buildfix
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c780f964902a8c4e7f702ff3e0a2b754e82b3ca3
Author: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Date:   Wed Nov 30 18:00:24 2005 -0500

    [ACPI] ia64 build fix
    
    arch/ia64/kernel/acpi-ext.c: In function
`acpi_vendor_resource_match':
    arch/ia64/kernel/acpi-ext.c:38: error: structure has no member named
`id'
    
    Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 486368bf33a2844319ad4865039543cd50ac90dd
Author: Len Brown <len.brown@intel.com>
Date:   Thu Sep 22 01:57:01 2005 -0400

    [ACPI] clean up ACPICA 20050916's rscalc typedef syntax
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit eca008c8134df15262a0362623edb59902628c95
Author: Len Brown <len.brown@intel.com>
Date:   Thu Sep 22 00:25:18 2005 -0400

    [ACPI] handle ACPICA 20050916's acpi_resource.type rename
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bda663d36b94c723153246a4231bbc0f1cd1836e
Author: Robert Moore <Robert.Moore@intel.com>
Date:   Fri Sep 16 16:51:15 2005 -0400

    [ACPI] ACPICA 20050916
    
    Fixed a problem within the Resource Manager where
    support for the Generic Register descriptor was not fully
    implemented.  This descriptor is now fully recognized,
    parsed, disassembled, and displayed.
    
    Restructured the Resource Manager code to utilize
    table-driven dispatch and lookup, eliminating many of the
    large switch() statements.  This reduces overall subsystem
    code size and code complexity.  Affects the resource parsing
    and construction, disassembly, and debug dump output.
    
    Cleaned up and restructured the debug dump output for all
    resource descriptors.  Improved readability of the output
    and reduced code size.
    
    Fixed a problem where changes to internal data structures
    caused the optional ACPI_MUTEX_DEBUG code to fail
    compilation if specified.
    
    Signed-off-by: Robert Moore <Robert.Moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
