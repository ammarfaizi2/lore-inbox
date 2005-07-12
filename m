Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVGLWJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVGLWJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVGLWJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:09:31 -0400
Received: from zorn.worldpath.net ([206.152.180.10]:27779 "EHLO
	unix.worldpath.net") by vger.kernel.org with ESMTP id S262414AbVGLWHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:07:55 -0400
Subject: [GIT PATCH] ACPI patches for 2.6.13-rc2
From: Len Brown <len.brown@intel.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050701204741.GA1137@kroah.com>
References: <20050701204741.GA1137@kroah.com>
Content-Type: text/plain
Organization: Intel Open Source Technology Center
Date: Tue, 12 Jul 2005 18:12:12 -0400
Message-Id: <1121206332.27299.9.camel@firebird.lenb.worldpath.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/linux-2.6.git/
or master.kernel.org:/pub/scm/linux/kernel/git/lenb/linux-2.6.git/

This batch of patches was stranded in BK upon 2.6.12-rc2 and
has been in and out of the mm tree various times since.

thanks,
-Len

p.s.
Plain patches (with quilt series file) available here:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12/broken-out/
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13/broken-out/

 Documentation/acpi-hotkey.txt                     |   35 
 arch/frv/mb93090-mb00/pci-irq.c                   |    2 
 arch/i386/kernel/acpi/Makefile                    |    4 
 arch/i386/kernel/acpi/cstate.c                    |  103 ++
 arch/i386/kernel/acpi/wakeup.S                    |    5 
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    2 
 arch/i386/pci/irq.c                               |   16 
 arch/i386/pci/visws.c                             |    2 
 arch/ia64/kernel/acpi.c                           |   54 +
 arch/ia64/kernel/mca.c                            |    2 
 arch/ia64/kernel/process.c                        |    1 
 arch/ia64/kernel/setup.c                          |    3 
 arch/ia64/kernel/topology.c                       |    7 
 drivers/acpi/Kconfig                              |   38 
 drivers/acpi/Makefile                             |    5 
 drivers/acpi/asus_acpi.c                          |    4 
 drivers/acpi/bus.c                                |    8 
 drivers/acpi/button.c                             |  245 -----
 drivers/acpi/dispatcher/dsfield.c                 |   58 -
 drivers/acpi/dispatcher/dsinit.c                  |   28 
 drivers/acpi/dispatcher/dsmethod.c                |   11 
 drivers/acpi/dispatcher/dsmthdat.c                |  195 ++--
 drivers/acpi/dispatcher/dsobject.c                |   79 +
 drivers/acpi/dispatcher/dsopcode.c                |  105 +-
 drivers/acpi/dispatcher/dsutils.c                 |   41 
 drivers/acpi/dispatcher/dswexec.c                 |   57 -
 drivers/acpi/dispatcher/dswload.c                 |  118 +-
 drivers/acpi/dispatcher/dswscope.c                |   31 
 drivers/acpi/dispatcher/dswstate.c                |  458 +++++----
 drivers/acpi/ec.c                                 |  420 ++++++---
 drivers/acpi/events/evevent.c                     |   33 
 drivers/acpi/events/evgpe.c                       |   39 
 drivers/acpi/events/evgpeblk.c                    |   63 +
 drivers/acpi/events/evmisc.c                      |   97 +-
 drivers/acpi/events/evregion.c                    |   35 
 drivers/acpi/events/evrgnini.c                    |   14 
 drivers/acpi/events/evsci.c                       |   12 
 drivers/acpi/events/evxface.c                     |   19 
 drivers/acpi/events/evxfevnt.c                    |   25 
 drivers/acpi/executer/exconfig.c                  |   31 
 drivers/acpi/executer/exconvrt.c                  |   44 
 drivers/acpi/executer/excreate.c                  |   50 -
 drivers/acpi/executer/exdump.c                    |  105 +-
 drivers/acpi/executer/exfield.c                   |   25 
 drivers/acpi/executer/exfldio.c                   |  133 +-
 drivers/acpi/executer/exmisc.c                    |    7 
 drivers/acpi/executer/exmutex.c                   |   45 
 drivers/acpi/executer/exnames.c                   |   70 -
 drivers/acpi/executer/exoparg1.c                  |   94 +-
 drivers/acpi/executer/exoparg2.c                  |   69 -
 drivers/acpi/executer/exoparg3.c                  |   25 
 drivers/acpi/executer/exoparg6.c                  |   26 
 drivers/acpi/executer/exprep.c                    |  104 +-
 drivers/acpi/executer/exregion.c                  |   34 
 drivers/acpi/executer/exresnte.c                  |   24 
 drivers/acpi/executer/exresolv.c                  |   63 -
 drivers/acpi/executer/exresop.c                   |   80 +
 drivers/acpi/executer/exstore.c                   |  260 ++++-
 drivers/acpi/executer/exstoren.c                  |   20 
 drivers/acpi/executer/exstorob.c                  |    9 
 drivers/acpi/executer/exsystem.c                  |   48 -
 drivers/acpi/executer/exutils.c                   |   37 
 drivers/acpi/glue.c                               |  360 +++++++
 drivers/acpi/hardware/hwacpi.c                    |   19 
 drivers/acpi/hardware/hwgpe.c                     |   31 
 drivers/acpi/hardware/hwregs.c                    |  114 +-
 drivers/acpi/hardware/hwsleep.c                   |  101 +-
 drivers/acpi/hardware/hwtimer.c                   |    4 
 drivers/acpi/hotkey.c                             | 1019
++++++++++++++++++++++
 drivers/acpi/ibm_acpi.c                           |    8 
 drivers/acpi/namespace/nsaccess.c                 |    5 
 drivers/acpi/namespace/nsalloc.c                  |  121 +-
 drivers/acpi/namespace/nsdump.c                   |  109 +-
 drivers/acpi/namespace/nsdumpdv.c                 |   18 
 drivers/acpi/namespace/nseval.c                   |   70 +
 drivers/acpi/namespace/nsinit.c                   |   28 
 drivers/acpi/namespace/nsload.c                   |   28 
 drivers/acpi/namespace/nsnames.c                  |   12 
 drivers/acpi/namespace/nsobject.c                 |   14 
 drivers/acpi/namespace/nssearch.c                 |   29 
 drivers/acpi/namespace/nsutils.c                  |  167 ++-
 drivers/acpi/namespace/nswalk.c                   |    2 
 drivers/acpi/namespace/nsxfeval.c                 |   16 
 drivers/acpi/namespace/nsxfname.c                 |    8 
 drivers/acpi/namespace/nsxfobj.c                  |    4 
 drivers/acpi/osl.c                                |   12 
 drivers/acpi/parser/psargs.c                      |   55 -
 drivers/acpi/parser/psopcode.c                    |  298 ------
 drivers/acpi/parser/psparse.c                     |  144 +--
 drivers/acpi/parser/psscope.c                     |   45 
 drivers/acpi/parser/pstree.c                      |  159 +--
 drivers/acpi/parser/psutils.c                     |   15 
 drivers/acpi/parser/pswalk.c                      |   11 
 drivers/acpi/parser/psxface.c                     |   21 
 drivers/acpi/pci_link.c                           |   43 
 drivers/acpi/processor_core.c                     |   37 
 drivers/acpi/processor_idle.c                     |  138 ++
 drivers/acpi/processor_perflib.c                  |   33 
 drivers/acpi/resources/rsaddr.c                   |  480 ++++------
 drivers/acpi/resources/rscalc.c                   |  144 +--
 drivers/acpi/resources/rscreate.c                 |   45 
 drivers/acpi/resources/rsdump.c                   |  402 ++++----
 drivers/acpi/resources/rsio.c                     |  197 +---
 drivers/acpi/resources/rsirq.c                    |  167 +--
 drivers/acpi/resources/rslist.c                   |   68 -
 drivers/acpi/resources/rsmemory.c                 |  236 ++---
 drivers/acpi/resources/rsmisc.c                   |  160 +--
 drivers/acpi/resources/rsutils.c                  |   53 -
 drivers/acpi/resources/rsxface.c                  |   43 
 drivers/acpi/scan.c                               |   12 
 drivers/acpi/sleep/main.c                         |   74 -
 drivers/acpi/sleep/poweroff.c                     |   81 +
 drivers/acpi/sleep/proc.c                         |    9 
 drivers/acpi/tables/tbconvrt.c                    |  105 +-
 drivers/acpi/tables/tbget.c                       |   63 -
 drivers/acpi/tables/tbgetall.c                    |   45 
 drivers/acpi/tables/tbinstal.c                    |   31 
 drivers/acpi/tables/tbrsdt.c                      |   19 
 drivers/acpi/tables/tbutils.c                     |   97 +-
 drivers/acpi/tables/tbxface.c                     |   39 
 drivers/acpi/tables/tbxfroot.c                    |  123 +-
 drivers/acpi/toshiba_acpi.c                       |    8 
 drivers/acpi/utilities/utalloc.c                  |   84 +
 drivers/acpi/utilities/utcopy.c                   |  126 +-
 drivers/acpi/utilities/utdebug.c                  |  106 +-
 drivers/acpi/utilities/utdelete.c                 |   63 -
 drivers/acpi/utilities/uteval.c                   |   36 
 drivers/acpi/utilities/utglobal.c                 |  133 +-
 drivers/acpi/utilities/utinit.c                   |   36 
 drivers/acpi/utilities/utmath.c                   |    2 
 drivers/acpi/utilities/utmisc.c                   |  187 ++--
 drivers/acpi/utilities/utobject.c                 |   68 +
 drivers/acpi/utilities/utxface.c                  |   61 -
 drivers/acpi/video.c                              |   15 
 drivers/base/sys.c                                |    1 
 drivers/net/b44.c                                 |    3 
 drivers/net/ne2k-pci.c                            |    3 
 drivers/pci/pci-acpi.c                            |  110 ++
 drivers/pci/pci.c                                 |   22 
 drivers/pci/pci.h                                 |    4 
 drivers/pcmcia/yenta_socket.c                     |    3 
 drivers/pnp/pnpacpi/rsparser.c                    |   15 
 drivers/pnp/pnpbios/rsparser.c                    |    2 
 drivers/pnp/resource.c                            |    2 
 drivers/usb/core/hcd-pci.c                        |    1 
 include/acpi/acconfig.h                           |    7 
 include/acpi/acdebug.h                            |  146 ---
 include/acpi/acdisasm.h                           |  114 --
 include/acpi/acdispat.h                           |  171 +--
 include/acpi/acevents.h                           |   85 -
 include/acpi/acexcep.h                            |    5 
 include/acpi/acglobal.h                           |   12 
 include/acpi/achware.h                            |   52 -
 include/acpi/acinterp.h                           |  243 +----
 include/acpi/aclocal.h                            |   10 
 include/acpi/acmacros.h                           |   10 
 include/acpi/acnames.h                            |   84 +
 include/acpi/acnamesp.h                           |  163 ---
 include/acpi/acobject.h                           |    2 
 include/acpi/acopcode.h                           |  325 +++++++
 include/acpi/acparser.h                           |  134 +-
 include/acpi/acpi.h                               |    1 
 include/acpi/acpi_bus.h                           |   21 
 include/acpi/acpi_drivers.h                       |    5 
 include/acpi/acpiosxf.h                           |   18 
 include/acpi/acpixf.h                             |   13 
 include/acpi/acresrc.h                            |   67 -
 include/acpi/acstruct.h                           |    1 
 include/acpi/actables.h                           |   70 -
 include/acpi/actbl.h                              |    2 
 include/acpi/actypes.h                            |    2 
 include/acpi/acutils.h                            |  274 +----
 include/acpi/amlcode.h                            |   12 
 include/acpi/pdc_intel.h                          |   29 
 include/acpi/platform/acenv.h                     |   20 
 include/acpi/processor.h                          |   34 
 include/asm-alpha/pci.h                           |    2 
 include/asm-arm/pci.h                             |    2 
 include/asm-h8300/pci.h                           |    2 
 include/asm-i386/acpi.h                           |   10 
 include/asm-i386/apicdef.h                        |    6 
 include/asm-i386/pci.h                            |    2 
 include/asm-ia64/acpi.h                           |    9 
 include/asm-ia64/pci.h                            |    2 
 include/asm-m68k/pci.h                            |    2 
 include/asm-mips/pci.h                            |    2 
 include/asm-ppc/pci.h                             |    2 
 include/asm-ppc64/pci.h                           |    2 
 include/asm-sh/pci.h                              |    2 
 include/asm-sh64/pci.h                            |    2 
 include/asm-sparc/pci.h                           |    2 
 include/asm-sparc64/pci.h                         |    2 
 include/asm-x86_64/acpi.h                         |    8 
 include/asm-x86_64/pci.h                          |    2 
 include/linux/acpi.h                              |    7 
 include/linux/device.h                            |    6 
 include/linux/pm.h                                |    2 
 kernel/power/main.c                               |   16 
 198 files changed, 7755 insertions(+), 5428 deletions(-)

commit 5028770a42e7bc4d15791a44c28f0ad539323807
Merge: 9f02d6b7b43d46a74dd385f06090104ecd0fb807
d8683a0cb5d09cb7f19feefa708424a84577e68f
Author: Len Brown <len.brown@intel.com>
Date:   Tue Jul 12 17:21:56 2005 -0400

    [ACPI] merge acpi-2.6.12 branch into latest Linux 2.6.13-rc...
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d8683a0cb5d09cb7f19feefa708424a84577e68f
Author: Len Brown <len.brown@intel.com>
Date:   Sun Jul 3 16:42:23 2005 -0400

    [ACPI] increase MAX_IO_APICS to 64 on i386
    
    x86_64 was already 128
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3754
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 02df8b9385c21fdba165bd380f60eca1d3b0578b
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Fri Apr 15 15:07:10 2005 -0400

    [ACPI] enable C2 and C3 idle power states on SMP
    http://bugzilla.kernel.org/show_bug.cgi?id=4401
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 17e9c78a75ce9eacd61200f9e1f1924012e28846
Author: Luming Yu <luming.yu@intel.com>
Date:   Fri Apr 22 23:07:10 2005 -0400

    [ACPI] EC GPE-disabled issue
    http://bugzilla.kernel.org/show_bug.cgi?id=3851
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a27ac38efd6dc6dccebfc9bcc475ab4aa5fc4a56
Author: Len Brown <len.brown@intel.com>
Date:   Fri Apr 5 00:07:45 2019 -0500

    [ACPI] fix merge error that broke CONFIG_ACPI_DEBUG=y build
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 590275ce72c48fdbddea057bc9ee379c1fd851ef
Author: Jesse Barnes <jbarnes@sgi.com>
Date:   Mon Apr 18 23:52:17 2005 -0400

    [ACPI] cleanup: delete !IA64_SGI_SN from acpi/Kconfig
    
    Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6c4fa56033c11ad5c5929bf3edd1505d3d8a8c0b
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Mon Apr 18 23:06:47 2005 -0400

    [ACPI] fix C1 patch for IA64
    http://bugzilla.kernel.org/show_bug.cgi?id=4233
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ef7b06cd905424aea7c31f27fef622e84e75e650
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Mon Apr 18 22:59:23 2005 -0400

    [ACPI] quiet dmesg related to ACPI PM of PCI devices
    
    DBG("No ACPI bus support for %s\n", dev->bus_id);
    http://bugzilla.kernel.org/show_bug.cgi?id=4277
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 44f6c01242da4e162f28d8e1216a8c7a91174605
Author: Robert Moore <robert.moore@intel.com>
Date:   Mon Apr 18 22:49:35 2005 -0400

    ACPICA 20050408 from Bob Moore
    
    Fixed three cases in the interpreter where an "index"
    argument to an ASL function was still (internally) 32
    bits instead of the required 64 bits.  This was the Index
    argument to the Index, Mid, and Match operators.
    
    The "strupr" function is now permanently local
    (acpi_ut_strupr), since this is not a POSIX-defined
    function and not present in most kernel-level C
    libraries. References to the C library strupr function
    have been removed from the headers.
    
    Completed the deployment of static
    functions/prototypes. All prototypes with the static
    attribute have been moved from the headers to the owning
    C file.
    
    ACPICA 20050329 from Bob Moore
    
    An error is now generated if an attempt is made to create
    a Buffer Field of length zero (A CreateField with a length
    operand of zero.)
    
    The interpreter now issues a warning whenever executable
    code at the module level is detected during ACPI table
    load. This will give some idea of the prevalence of this
    type of code.
    
    Implemented support for references to named objects (other
    than control methods) within package objects.
    
    Enhanced package object output for the debug
    object. Package objects are now completely dumped, showing
    all elements.
    
    Enhanced miscellaneous object output for the debug
    object. Any object can now be written to the debug object
    (for example, a device object can be written, and the type
    of the object will be displayed.)
    
    The "static" qualifier has been added to all local
    functions across the core subsystem.
    
    The number of "long" lines (> 80 chars) within the source
    has been significantly reduced, by about 1/3.
    
    Cleaned up all header files to ensure that all CA/iASL
    functions are prototyped (even static functions) and the
    formatting is consistent.
    
    Two new header files have been added, acopcode.h and
    acnames.h.
    
    Removed several obsolete functions that were no longer
    used.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ebb6e1a6122fd6b7c96470cfd4ce0f04150e5084
Author: Len Brown <len.brown@intel.com>
Date:   Thu Apr 14 23:12:56 2005 -0400

    [ACPI] Deprecate /proc/acpi/sleep in favor of /sys/power/state
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9d9437759eb6fdb68f7b82cbee20b0fb711d9f0d
Author: Nickolai Zeldovich <kolya@MIT.EDU>
Date:   Fri Apr 8 23:37:34 2005 -0400

    [ACPI] S3 resume -- use lgdtl, not lgdt
    
    From: Nickolai Zeldovich <kolya@MIT.EDU>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c9c3e457de24cca2ca688fa397d93a241f472048
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Fri Apr 1 00:07:31 2005 -0500

    [ACPI] PNPACPI vs sound IRQ
    
    http://bugme.osdl.org/show_bug.cgi?id=4016
    
    Written-by: David Shaohua Li <shaohua.li@intel.com>
    Acked-by: Adam Belay <abelay@novell.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit acf05f4b7f558051ea0028e8e617144123650272
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Mar 31 23:23:15 2005 -0500

    [ACPI] update /proc/acpi/processor/*/power even if only C1 support
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 55e59c511cea3c6c721971467c707e9955922bc2
Author: Ashok Raj <ashok.raj@intel.com>
Date:   Thu Mar 31 22:51:10 2005 -0500

    [ACPI] Evaluate CPEI Processor Override flag
    
    ACPI 3.0 added a Correctable Platform Error Interrupt (CPEI)
    Processor Overide flag to MADT.Platform_Interrupt_Source.
    Record the processor that was provided as hint from ACPI.
    
    Signed-off-by: Ashok Raj <ashok.raj@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6940fabaa35b893163b7043d0d1dc5d715f9e1ca
Author: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Date:   Wed Mar 30 23:15:47 2005 -0500

    [ACPI] hotplug Processor consideration in acpi_bus_add()
    
    Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8de7a63b69a263b7549599be882d7aa15397f8b3
Author: Andrew Morton <akpm@osdl.org>
Date:   Wed Mar 30 22:53:30 2005 -0500

    [ACPI] fix debug-mode build warning in acpi/hotkey.c
    
    drivers/acpi/hotkey.c: In function `create_polling_proc':
    drivers/acpi/hotkey.c:334: warning: ISO C90 forbids mixed
declarations and code
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d1dd0c23916bd781de27bc5ec1c295064e9ce9cc
Author: Paulo Marques <pmarques@grupopie.com>
Date:   Wed Mar 30 22:39:49 2005 -0500

    [ACPI] fix kmalloc size bug in acpi/video.c
    
    acpi_video_device_find_cap() used &p instead of *p
    when calculating storage size, thus allocating
    only 4 or 8 bytes instead of 12...
    
    Also, kfree(NULL) is legal, so remove some unneeded checks.
    
    From: Paulo Marques <pmarques@grupopie.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7334571f724df7a19f48cc974e991e00afde1e2f
Author: Adrian Bunk <bunk@stusta.de>
Date:   Wed Mar 30 22:31:35 2005 -0500

    [ACPI] fix potential NULL dereference in acpi/video.c
    
    Found-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f4224153098c1103db592b28f304beeb9c02481b
Author: Panagiotis Issaris <takis@gna.org>
Date:   Wed Mar 30 22:15:36 2005 -0500

    [ACPI] check for kmalloc failure in toshiba_acpi.c
    
    Signed-off-by: Panagiotis Issaris <takis@gna.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 83ea7445221651dc43cf8d22f81089e0cbccf22b
Author: Andrew Morton <akpm@osdl.org>
Date:   Wed Mar 30 22:12:13 2005 -0500

    [ACPI] fix build warning
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f165b10f4a9aac7fee9b11a125de20a1712be128
Author: Greg Kroah-Hartman <gregkh@suse.de>
Date:   Wed Mar 30 21:23:19 2005 -0500

    cleanup: remove unnecessary initializer on static pointers
    
    Suggested-by: Greg KH <greg@kroah.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b008b8d7092053fc1f036cfc54dc11740cc424ed
Author: Matthieu Castet <castet.matthieu@free.fr>
Date:   Fri Mar 25 12:03:15 2005 -0500

    [ACPI] PNPACPI parse error
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3912
    
    Written-by: matthieu castet <castet.matthieu@free.fr>
    Acked-by: Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a406d9e63e1d7088aad22565449de2e109300e5c
Author: Len Brown <len.brown@intel.com>
Date:   Wed Mar 23 16:16:03 2005 -0500

    [ACPI] gut acpi_pci_choose_state() to avoid conflict
    with pending pm_message_t re-definition.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit fa9cd547e097df4966b8bd5c94aeed953e32b14d
Author: Luming Yu <luming.yu@intel.com>
Date:   Sat Mar 19 01:54:47 2005 -0500

    [ACPI] fix EC access width
    http://bugzilla.kernel.org/show_bug.cgi?id=4346
    
    Written-by: David Shaohua Li and Luming Yu
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 451566f45a2e6cd10ba56e7220a9dd84ba3ef550
Author: Dmitry Torokhov <dtor@mail.ru>
Date:   Sat Mar 19 01:10:05 2005 -0500

    [ACPI] Enable EC Burst Mode
    
    Fixes several Embedded Controller issues, including
    button failure and battery status AE_TIME failure.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3851
    
    Based on patch by: Andi Kleen <ak@suse.de>
    Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b913100d7304ea9596d8d85ab5f3ae04bd2b0ddb
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Sat Mar 19 00:16:18 2005 -0500

    [ACPI] pci_set_power_state() now calls
    	platform_pci_set_power_state()
    		and ACPI can answer
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4277
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0f64474b8f7f1f7f3af5b24ef997baa35f923509
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Sat Mar 19 00:15:48 2005 -0500

    [ACPI] PCI can now get suspend state from firmware
    
    pci_choose_state() can now call
    	platform_pci_choose_state()
    		and ACPI can answer
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4277
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 84df749f364209c9623304b7a94ddb954dc343bb
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Fri Mar 18 18:53:36 2005 -0500

    [ACPI] Bind ACPI and PCI devices
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4277
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4e10d12a3d88c88fba3258809aa42d14fd8cf1d1
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Fri Mar 18 18:45:35 2005 -0500

    [ACPI] Bind PCI devices with ACPI devices
    
    Implement the framework for binding physical devices
    with ACPI devices. A physical bus like PCI bus
    should create a 'acpi_bus_type', with:
    
    .find_device:
            For device which has parent such as normal PCI devices.
    
    .find_bridge:
            It's for special devices, such as PCI root bridge
    	or IDE controller.  Such devices generally haven't a
    	parent or ->bus. We use the special method
    	to get an ACPI handle.
    
    Uses new field in struct device: firmware_data
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4277
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit fb9802fa59b196d7f90bb3c2e33c555c6bdc4c54
Author: Luming Yu <luming.yu@intel.com>
Date:   Fri Mar 18 18:03:45 2005 -0500

    [ACPI] generic Hot Key support
    
    See Documentation/acpi-hotkey.txt
    
    Use cmdline "acpi_specific_hotkey" to enable
    legacy platform specific drivers.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3887
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d58da590451cf6ae75379a2ebf96d3afb8d810d8
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Fri Mar 18 16:43:54 2005 -0500

    [ACPI] S3 Suspend to RAM: fix driver suspend/resume methods
    
    Drivers should do this:
    
    .suspend()
    	pci_disable_device()
    
    .resume()
    	pci_enable_device()
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3469
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 362b06bb70b5a5779b2e852e0f2bdb437061106e
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Fri Mar 18 16:30:29 2005 -0500

    [ACPI] S3 Suspend to RAM: interrupt resume fix
    
    Delete PCI Interrupt Link Device .resume method --
    it is the device driver's job to request interrupts,
    not the Link's job to remember what the devices want.
    
    This addresses the issue of attempting to run
    the ACPI interpreter too early in resume, when
    interrupts are still disabled.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3469
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5ae947ecc9c1c23834201e5321684a5cb68bdd3f
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Fri Mar 18 16:27:13 2005 -0500

    [ACPI] Suspend to RAM fix
    
    Free some RAM before entering S3 so that upon
    resume we can be sure early allocations will succeed.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3469
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e2a5b420f716cd1a46674b1a90389612eced916f
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Fri Mar 18 16:20:46 2005 -0500

    [ACPI] ACPI poweroff fix
    
    Register an "acpi" system device to be notified of shutdown
preparation.
    This depends on CONFIG_PM
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4041
    
    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit be91492ca871e58f61b517cfba541095bb60001c
Author: Len Brown <len.brown@intel.com>
Date:   Fri Mar 18 16:00:29 2005 -0500

    [ACPI] CONFIG_ACPI now depends on CONFIG_PM
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bd4698dad3023ae137b366c736e29ca6eaf3b9f7
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Fri Mar 18 15:35:22 2005 -0500

    [ACPI] Allow simultaneous Fixed Feature and Control Method buttons
    delete /proc/acpi/button
    
    http://bugzilla.kernel.org/show_bug.cgi?id=1920
    
    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 45b1b196677b8009ab6cdc4b656265f1d7015c1b
Author: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Date:   Wed Mar 2 00:00:00 2005 -0500

    [ACPI] update CONFIG_ACPI_CONTAINER Kconfig help
    
    Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>



