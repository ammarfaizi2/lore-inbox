Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTGARvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 13:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTGARvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 13:51:41 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:28546 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263185AbTGARun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 13:50:43 -0400
Message-Id: <200307011804.h61I4jsG010605@ginger.cmf.nrl.navy.mil>
To: davem@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: [patch][2.4] atm_dev reference counting
Reply-To: chas3@users.sourceforge.net
Date: Tue, 01 Jul 2003 14:02:32 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is a back port from 2.5.

[atm]: add reference counting to atm_dev

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1012  -> 1.1013 
#	      net/atm/addr.c	1.2     -> 1.3    
#	       net/atm/lec.c	1.14    -> 1.15   
#	    drivers/atm/he.c	1.2     -> 1.3    
#	  net/atm/atm_misc.c	1.2     -> 1.3    
#	   drivers/atm/eni.c	1.7     -> 1.8    
#	       net/atm/mpc.c	1.7     -> 1.8    
#	include/linux/atmdev.h	1.8     -> 1.9    
#	      net/atm/proc.c	1.6     -> 1.7    
#	 net/atm/resources.c	1.5     -> 1.6    
#	      net/atm/clip.c	1.8     -> 1.9    
#	drivers/atm/fore200e.c	1.8     -> 1.9    
#	drivers/atm/idt77252.c	1.7     -> 1.8    
#	drivers/atm/atmtcp.c	1.3     -> 1.4    
#	 net/atm/signaling.c	1.4     -> 1.5    
#	 net/atm/resources.h	1.2     -> 1.3    
#	    net/atm/common.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/26	bdschuym@pandora.be	1.1005.4.16
# [NETFILTER]: Add arptables mangle module.
# --------------------------------------------
# 03/06/26	chas@cmf.nrl.navy.mil	1.1005.4.17
# [ATM]: ixmicro puts esi in different location
# --------------------------------------------
# 03/06/26	chas@cmd.nrl.navy.mil	1.1005.4.18
# [ATM]: remove iovcnt member in struct atm_skb
# --------------------------------------------
# 03/06/26	chas@cmf.nrl.navy.mil	1.1005.4.19
# [ATM]: lock neighbor entry during update in clip.c
# --------------------------------------------
# 03/06/26	chas@cmf.nrl.navy.mil	1.1005.4.20
# [ATM]: make sub skb->cb is clear before upcall to network
# --------------------------------------------
# 03/06/26	chas@cmf.nrl.navy.mil	1.1005.4.21
# [ATM]: eliminate ATM_PDU_OVHD, ops->free_rx_skb and ops->alloc_tx
# --------------------------------------------
# 03/06/26	chas@cmf.nrl.navy.mil	1.1005.4.22
# [ATM]: make clip buildable as a module
# --------------------------------------------
# 03/06/27	marcelo@freak.distro.conectiva	1.1011.1.1
# Merge bk://kernel.bkbits.net/davem/crypto-2.4
# into freak.distro.conectiva:/home/marcelo/bk/linux-2.4
# --------------------------------------------
# 03/06/27	bcollins@debian.org	1.1011.1.2
# [PATCH] Update IEEE1394 (r972)
# 
#  IEEE1394 : Add OUI database.
#  DV1394   : Fix endian conversion brokeness.
#  ETH1394  : Updates for async streams, EUI based ARP and packet
#             fragmentation.
#  IEEE1394 : Host key lookup improvements.
#  SBP2     : Fix > S400 max_payload setting.
#  IEEE1394 : Move hotplug declerations around to more generic place.
#  IEEE1394 : Fix possible memory leak in ISO code.
#  IEEE1394 : Fix proc output for > page size.
#  OHCI1394 : Async stream packets.
#  OHCI1394 : Trivial CONFIG_PM support.
#  SBP2     : Only allocate scsi_host for ieee1394_hosts that have sbp2
#             devices attached to it (on demand scsi_host allocation).
#  SBP2     : Code cleanups to bring closer to 2.5 code.
#  SBP2     : Handle Logical_Unit_Number entries.
#  VIDEO1394: Handle user pointer correctly.
#  IEEE1394 : Macro namespace cleanups.
#  ALL      : Cleanups of some C constructs.
#  ETH1394  : Limited multicast support.
# --------------------------------------------
# 03/06/27	schwidefsky@de.ibm.com	1.1011.1.3
# [PATCH] s390 base update
# 
# s/390 base fixes:
#  - docu: Correct description of 3270 device nodes
#  - arch: Do reate_proc_entry for debug feature outside spin locked code.
#  - arch: Set CR5 to get program checks for space switching instructions.
#  - arch: Use sig_exit in 64 bit signal handler.
#  - arch: Avoid warning in idals.h.
#  - arch: Do pfix early in the boot process. No pfix for 64 bit.
#  - arch: Fix linker output format for 64 bit kernels.
#  - arch: Fix race condition in dirty bit clearing.
#  - arch: Fix deadlock in pgd_populate.
# 
# diffstat:
#  arch/s390/kernel/debug.c       |   20 ++++--
#  arch/s390/kernel/head.S        |    2
#  arch/s390/kernel/s390_ksyms.c  |    5 +
#  arch/s390/kernel/setup.c       |  133 ++++++++++++++++++++++++++++++++++++++++-
#  arch/s390/mm/init.c            |    5 -
#  arch/s390x/kernel/debug.c      |   20 ++++--
#  arch/s390x/kernel/head.S       |   17 -----
#  arch/s390x/kernel/s390_ksyms.c |    2
#  arch/s390x/kernel/setup.c      |    6 -
#  arch/s390x/kernel/signal.c     |    5 -
#  arch/s390x/mm/init.c           |   74 ++++++++++++++++------
#  arch/s390x/vmlinux-shared.lds  |    2
#  arch/s390x/vmlinux.lds         |    2
#  include/asm-s390/idals.h       |    4 -
#  include/asm-s390/page.h        |   61 +-----------------
#  include/asm-s390/pgtable.h     |   36 ++---------
#  include/asm-s390x/idals.h      |    4 -
#  include/asm-s390x/page.h       |   61 +-----------------
#  include/asm-s390x/pgtable.h    |   36 ++---------
#  include/asm-s390x/setup.h      |    2
#  include/linux/mm.h             |   10 ++-
#  21 files changed, 261 insertions(+), 246 deletions(-)
# --------------------------------------------
# 03/06/27	schwidefsky@de.ibm.com	1.1011.1.4
# [PATCH] s390 common i/o layer fixes
# 
# Common i/o fixes:
#  - Don't confuse device drivers with zero sense data.
#  - Check return code for the start of the basic sense ccw.
#  - Fix deadlock in enable_cpu_sync_isc.
#  - Fix check for path not operational condition.
#  - Use unsigned long for flags variable in read_dev_chars.
#  - Only try sense path group id on available paths.
#  - Retry sense path group id on another path after deferred cc=3.
#  - Fix deadlock in link incident handler.
#  - Fix output in /proc/chpids.
#  - Adapt to latest path group algorithm.
#  - Fix handling of condition code 1 (status pending) on i/o operations.
#  - Only process status pending conditions when doing sync. i/o.
#  - Path revalidation fixes:
#    * Add a handler for machine checks with chpid sources.
#    * Distinguish between device gone and device not accessible in the
#      device not operational handler.
#    * Don't accept i/o from the device drivers while doing path revalidation.
#    * Use a bottom half for doing path verification from interrupt context.
#    * Don't do path verification if sync. isc is alread in use. Reschedule bh.
#    * Kill pending i/o before doing path verification.
#    * Always start with a logical path mask of 0xff because the information
#      store by stsch() can be outdated.
#  - Always use a tpi loop for basic sense.
#  - Lowered level of 'not operational' messages.
#  - Check after store event information if there are more crws pending.
#  - Make diag210 a non-inline function to avoid problems with modules loaded
#    above 2G.
#  - Show reserved devices as "boxed" instead of "unkown".
#  - Fix for path no operational condition in cio_start.
#  - Fix /proc/cio_ignore string parsing.
#  - Fix parsing of verbs in chandev.
# 
# diffstat:
#  drivers/s390/misc/chandev.c |    2
#  drivers/s390/s390io.c       | 2422 +++++++++++++++++++++++++-------------------
#  drivers/s390/s390mach.c     |   14
#  include/asm-s390/irq.h      |   43
#  include/asm-s390/s390io.h   |   14
#  include/asm-s390/setup.h    |    1
#  include/asm-s390x/irq.h     |   44
#  include/asm-s390x/s390io.h  |   16
#  include/asm-s390x/setup.h   |    1
#  9 files changed, 1494 insertions(+), 1063 deletions(-)
# --------------------------------------------
# 03/06/27	schwidefsky@de.ibm.com	1.1011.1.5
# [PATCH] s390 dasd driver update
# 
# Big patch for the dasd driver.
# 
# New features:
#  - Add 'set on/off' to /proc/dasd/statistics.
#  - Added BIODASDPSRD ioctl (Read Subsystem Performance Statistics).
#  - Added BIODASDSATTR ioctl (Set Cache Attributes).
#  - Support for XRC timestamping.
#  - Add support for breaking the reservation of a dasd (boxed dasd access).
#  - Implemented hotplug support for dasd.
#  - Support for ESS dasd devices.
# 
# Bug-Fixes:
#  - Use internal timer instead of DOIO_TIMEOUT option (cio).
#  - Use 'get_clock' instead of 'STCK....'
#  - Switch off autodetect/probeonly as default behaviour.
#  - Rework of dasd messages.
#  - Reseve IOCTL-NR 240-255 for EMC
#  - Fix statistics counting.
#  - Clear request queue in dasd_disable_blkdev.
#  - Fix for a race between dasd_format and sleep_on_req.
#  - Fix for a race between reserve timeout and successful completion.
#  - Set maximun end-cylinder to geometry cylinder -1 (in Define Extent).
#  - Private implementation of BLKROSET.
#  - Allow sharing of external interrupt 0x2603 between pfault and dasd diag.
#  - Plug devices during bringup.
#  - Get diag discipline to work again.
#  - Check diag discipline forst on dynamic attach of a device.
#  - EXPORT dasd_device_from_devno (needed by EMC)
#  - Fix problem with ext3 doing modifications to the first request on the
#    request queue.
#  - Prevent scheduling in timer_bh.
#  - Check for empty queue after state change pending interrupt.
#  - Register a dasd only if the blocksize and the number of blocks are valid.
#  - Check for spurious interrupts while waiting for basic sense data.
#  - Check for unformatted dasd in BIODASDINFO ioctl.
#  - Check for unformatted dasd in dasd_disable_blkdev.
#  - Fix oops during boot if an invalid dasd= parameter has been specified.
#  - Prevent dasd driver from creating /proc/partition names for scsi devices.
#  - Return error for non-dasd-devices in dasd ioctls.
#  - Add missing MODULE_LICENSE("GPL").
#  - Don't accept invalid device numbers in /proc/dasd/devices interface.
#  - Add check in dasd_discipline_del if discipline to be removed has been added.
#  - Remove static initializer from dasd_major_info and use proper
#    list_for_each operations for dasd_major_info list.
#  - Disable dasd diag for 64 bit.
#  - Fix race condition on timer variable in dasd_device_t.
#  - Fix timeout processing for reserve/release requests.
#  - Fix race condition between setup and first use of request_queue.
#  - make dasd_eckd compile with gcc 3.3.
#  - Post requests with invalid blocksize with i/o-error.
#  - Various fixes for ESS dasd device support.
#  - Fixed path revalidation.
#  - Retry i/o after path failure.
#  - Retry i/o after interface control check.
#  - Fix major&minor number for dynamically attached dasd devices.
#  - Fix low memory handling.
#  - Free spinlock in case of an error in dasd_device_from_devno.
#  - Head queue diag discipline to give it a chance to grab is device before eckd.
#  - Remove some warnings.
#  - Fix reserve/release for 64 bit.
#  - Add module licence to fba discipline.
# 
# diffstat:
#  drivers/s390/block/dasd.c          | 3568 ++++++++++++++++++++++++-------------
#  drivers/s390/block/dasd_3990_erp.c | 1347 ++++++-------
#  drivers/s390/block/dasd_diag.c     |  273 +-
#  drivers/s390/block/dasd_diag.h     |   20
#  drivers/s390/block/dasd_eckd.c     |  729 +++++--
#  drivers/s390/block/dasd_eckd.h     |  152 -
#  drivers/s390/block/dasd_fba.c      |  116 -
#  drivers/s390/block/dasd_fba.h      |   12
#  drivers/s390/block/dasd_int.h      |  353 ++-
#  include/asm-s390/ccwcache.h        |   38
#  include/asm-s390/dasd.h            |  187 +
#  include/asm-s390/vtoc.h            |    1
#  include/asm-s390x/ccwcache.h       |   38
#  include/asm-s390x/dasd.h           |  187 +
#  include/asm-s390x/vtoc.h           |    1
#  15 files changed, 4532 insertions(+), 2490 deletions(-)
# --------------------------------------------
# 03/06/27	schwidefsky@de.ibm.com	1.1011.1.6
# [PATCH] s390 31 bit compat.
# 
# 31 bit emulation changes:
#  - Support for PER_LINUX32 personality added.
#  - Added [un]register_ioctl32_conversion.
#  - Don't do float/integer conversion in save/restore_sigregs32.
#  - Add system call emulation for sys_readahead, sys_gettid, sys_tkill,
#    sys_sysctl and sys_stime.
#  - Add ioctl emulation for BLKBSZGET, BLKELVGET, BLKELVSET, BLKFLSBUF
#    BLKFRAGET, BLKFRASET, BLKGETSIZE, BLKGETSIZE64, BLKPG, BLKRASET
#    BLKROGET, BLKROSET, BLKSECTGET, BLKSECTSET, BLKSSZGET, LOOP_CLR_FD
#    LOOP_GET_STATUS, LOOP_SET_FD, LOOP_SET_STATUS, RAW_GETBIND
#    RAW_SETBIND and SIOCATMARK.
#  - Signal backchain fix for 31 bit emulation signal handler.
#  - Added missing check for SIGURG in emulation signal handler.
#  - sys_msgsnd and sys_msgrcv emulation fixes.
#  - Fix emulation for sys_getrlimit.
#  - Add check for (ssize_t32) count < 0 in read and write system call emulation.
#  - Check offset in pwrite system call emulation.
# 
# diffstat:
#  arch/s390x/kernel/Makefile        |    2
#  arch/s390x/kernel/binfmt_elf32.c  |    8
#  arch/s390x/kernel/entry.S         |   12 -
#  arch/s390x/kernel/exec_domain32.c |   30 +++
#  arch/s390x/kernel/ioctl32.c       |  181 ++++++++++++++++++
#  arch/s390x/kernel/linux32.c       |  364 +++++++++++++++++++++++++++++++++++---
#  arch/s390x/kernel/s390_ksyms.c    |   14 +
#  arch/s390x/kernel/signal32.c      |   14 +
#  arch/s390x/kernel/wrapper32.S     |   24 ++
#  9 files changed, 608 insertions(+), 41 deletions(-)
# --------------------------------------------
# 03/06/27	schwidefsky@de.ibm.com	1.1011.1.7
# [PATCH] s390 documentation update
# 
# S/390 Documentation changes:
#  - Updated section about /proc/subchannels.
#  - Added description for /proc/chpids.
#  - Added descriptions for get_irq_first() / get_irq_next().
#  - Added description  for read_conf_data().
#  - Added description  for s390_request_irq_special().
#  - Typos and minor improvements.
# 
# diffstat:
#  Documentation/s390/CommonIO         |   48 +++
#  Documentation/s390/Debugging390.txt |    8
#  Documentation/s390/cds.txt          |  442 ++++++++++++++++++++++++++++--------
#  3 files changed, 397 insertions(+), 101 deletions(-)
# --------------------------------------------
# 03/06/27	schwidefsky@de.ibm.com	1.1011.1.8
# [PATCH] Add Configure.help entries for s390 options
# 
# Update of s/390 specific documentation and help texts.
# 
# diffstat:
#  Documentation/Configure.help |   14 ++++++++++++++
#  Documentation/devices.txt    |   12 ++++++------
#  2 files changed, 20 insertions(+), 6 deletions(-)
# --------------------------------------------
# 03/06/27	schwidefsky@de.ibm.com	1.1011.1.9
# [PATCH] s390 3215 driver update
# 
# Changes for the 3215 driver and new control character helper functions.
# 
# diffstat:
#  drivers/s390/char/con3215.c  |   39 +++++++++++-------
#  drivers/s390/char/ctrlchar.c |   92 +++++++++++++++++++------------------------
#  drivers/s390/char/ctrlchar.h |   12 ++++-
#  3 files changed, 75 insertions(+), 68 deletions(-)
# --------------------------------------------
# 03/06/27	schwidefsky@de.ibm.com	1.1011.1.10
# [PATCH] s390 ctc network driver update
# 
# Changes for the ctc network driver:
#  - Fixed vary on/off issue.
#  - Implemented restart after -EIO.
#  - Changed severity of some warnings to debug.
#  - Fixed physical link lost problems.
# 
# diffstat:
#  drivers/s390/net/ctcmain.c |  969 ++++++++++++++++++++++++++++++---------------
#  drivers/s390/net/ctctty.c  |  106 +++-
#  drivers/s390/net/fsm.h     |    2
#  3 files changed, 735 insertions(+), 342 deletions(-)
# --------------------------------------------
# 03/06/27	schwidefsky@de.ibm.com	1.1011.1.11
# [PATCH] s390 iucv network driver.
# 
# Changes for the iucv network driver:
#  - Added mising call of release_param().
#  - Allow '$' in username.
#  - Workaround for VM bug.
#  - Don't rely on IUCV ipmsgtags.
#  - Additional debug code.
#  - Fix deadlock when starting more than 160 devices.
# 
# diffstat:
#  drivers/s390/net/iucv.c    |  125 +++++++++++++++++++++++++++++++++++++--------
#  drivers/s390/net/iucv.h    |    4 +
#  drivers/s390/net/netiucv.c |   83 +++++++++++++++++++++++------
#  3 files changed, 172 insertions(+), 40 deletions(-)
# --------------------------------------------
# 03/06/27	schwidefsky@de.ibm.com	1.1011.1.12
# [PATCH] s390 defconfigs update
# 
# New default configurations.
# 
# diffstat:
#  arch/s390/defconfig  |  218 ++++++++++++++++++++++++++++++++++++++++++---------
#  arch/s390x/defconfig |  166 ++++++++++++++++++++++++++++++--------
#  2 files changed, 312 insertions(+), 72 deletions(-)
# --------------------------------------------
# 03/06/27	schwidefsky@de.ibm.com	1.1011.1.13
# [PATCH] console semaphore fix.
# 
# Avoid BUG if panic is called from an interrupt context. This patch has been
# accepted to linux-2.5.
# 
# diffstat:
#  kernel/printk.c |    9 ++++++++-
#  1 files changed, 8 insertions(+), 1 deletion(-)
# --------------------------------------------
# 03/06/27	greg@kroah.com	1.1005.1.5
# Cset exclude: cweidema@indiana.edu|ChangeSet|20030620002017|05386
# --------------------------------------------
# 03/06/27	lethal@linux-sh.org	1.1011.1.14
# [PATCH] SH64 Merge
# 
# Here's the patch for sh64! This adds arch/sh64 and include/asm-sh64. All
# changes are localized to these directories.
# 
# Here's the diffstat output, nothing too terribly exciting:
# 
#  arch/sh64/Makefile                      |   91 +
#  arch/sh64/boot/Makefile                 |   34
#  arch/sh64/boot/compressed/Makefile      |   57
#  arch/sh64/boot/compressed/cache.c       |   39
#  arch/sh64/boot/compressed/head.S        |  164 ++
#  arch/sh64/boot/compressed/install.sh    |   56
#  arch/sh64/boot/compressed/misc.c        |  251 +++
#  arch/sh64/boot/compressed/vmlinux.lds.S |   65
#  arch/sh64/config.in                     |  298 ++++
#  arch/sh64/defconfig                     |  467 +++++++
#  arch/sh64/kernel/Makefile               |   38
#  arch/sh64/kernel/entry.S                | 2099 ++++++++++++++++++++++++++++++++
#  arch/sh64/kernel/fpu.c                  |  171 ++
#  arch/sh64/kernel/head.S                 |  347 +++++
#  arch/sh64/kernel/init_task.c            |   36
#  arch/sh64/kernel/irq.c                  |  706 ++++++++++
#  arch/sh64/kernel/irq_intc.c             |  269 ++++
#  arch/sh64/kernel/led.c                  |   69 +
#  arch/sh64/kernel/pci-dma.c              |   46
#  arch/sh64/kernel/pci_sh5.c              |  607 +++++++++
#  arch/sh64/kernel/pci_sh5.h              |  107 +
#  arch/sh64/kernel/pcibios.c              |  129 +
#  arch/sh64/kernel/process.c              |  903 +++++++++++++
#  arch/sh64/kernel/ptrace.c               |  375 +++++
#  arch/sh64/kernel/semaphore.c            |  137 ++
#  arch/sh64/kernel/setup.c                |  362 +++++
#  arch/sh64/kernel/sh_ksyms.c             |   78 +
#  arch/sh64/kernel/signal.c               |  821 ++++++++++++
#  arch/sh64/kernel/sys_sh64.c             |  268 ++++
#  arch/sh64/kernel/time.c                 |  552 ++++++++
#  arch/sh64/kernel/traps.c                |  263 ++++
#  arch/sh64/lib/Makefile                  |   26
#  arch/sh64/lib/c-checksum.c              |  330 +++++
#  arch/sh64/lib/checksum.S                |  656 ++++++++++
#  arch/sh64/lib/copy_user_memcpy.S        |  205 +++
#  arch/sh64/lib/dbg.c                     |  319 ++++
#  arch/sh64/lib/io.c                      |  200 +++
#  arch/sh64/lib/memcpy.c                  |   82 +
#  arch/sh64/lib/old-checksum.c            |   17
#  arch/sh64/lib/page_clear.S              |   46
#  arch/sh64/lib/page_copy.S               |   77 +
#  arch/sh64/lib/panic.c                   |   60
#  arch/sh64/lib/syscalltab.h              |  311 ++++
#  arch/sh64/lib/udelay.c                  |   53
#  arch/sh64/mach-cayman/Makefile          |   15
#  arch/sh64/mach-cayman/irq.c             |  188 ++
#  arch/sh64/mach-cayman/led.c             |   47
#  arch/sh64/mach-cayman/setup.c           |  209 +++
#  arch/sh64/mach-harp/Makefile            |   14
#  arch/sh64/mach-harp/setup.c             |  139 ++
#  arch/sh64/mach-sim/Makefile             |   14
#  arch/sh64/mach-sim/setup.c              |  164 ++
#  arch/sh64/mm/Makefile                   |   43
#  arch/sh64/mm/cache.c                    | 1062 ++++++++++++++++
#  arch/sh64/mm/extable.c                  |   95 +
#  arch/sh64/mm/fault.c                    |  716 ++++++++++
#  arch/sh64/mm/init.c                     |  203 +++
#  arch/sh64/mm/ioremap.c                  |  358 +++++
#  arch/sh64/mm/tlb.c                      |  166 ++
#  arch/sh64/mm/tlbmiss.c                  |  276 ++++
#  arch/sh64/vmlinux.lds.S                 |  158 ++
#  include/asm-sh64/a.out.h                |   37
#  include/asm-sh64/atomic.h               |  102 +
#  include/asm-sh64/bitops.h               |  364 +++++
#  include/asm-sh64/bugs.h                 |   38
#  include/asm-sh64/byteorder.h            |   49
#  include/asm-sh64/cache.h                |  139 ++
#  include/asm-sh64/cayman.h               |   20
#  include/asm-sh64/checksum.h             |  321 ++++
#  include/asm-sh64/current.h              |   31
#  include/asm-sh64/delay.h                |   11
#  include/asm-sh64/div64.h                |   21
#  include/asm-sh64/dma.h                  |   38
#  include/asm-sh64/elf.h                  |  101 +
#  include/asm-sh64/errno.h                |  143 ++
#  include/asm-sh64/fcntl.h                |   87 +
#  include/asm-sh64/hardirq.h              |   42
#  include/asm-sh64/hardware.h             |   19
#  include/asm-sh64/hw_irq.h               |   16
#  include/asm-sh64/init.h                 |   17
#  include/asm-sh64/io.h                   |  215 +++
#  include/asm-sh64/ioctl.h                |   83 +
#  include/asm-sh64/ioctls.h               |  110 +
#  include/asm-sh64/ipc.h                  |   42
#  include/asm-sh64/ipcbuf.h               |   40
#  include/asm-sh64/irq.h                  |  142 ++
#  include/asm-sh64/keyboard.h             |   74 +
#  include/asm-sh64/linux_logo.h           |   47
#  include/asm-sh64/mman.h                 |   49
#  include/asm-sh64/mmu.h                  |    7
#  include/asm-sh64/mmu_context.h          |  209 +++
#  include/asm-sh64/module.h               |   12
#  include/asm-sh64/msgbuf.h               |   42
#  include/asm-sh64/namei.h                |   24
#  include/asm-sh64/page.h                 |  129 +
#  include/asm-sh64/param.h                |   43
#  include/asm-sh64/pci.h                  |  230 +++
#  include/asm-sh64/pgalloc-3level.h       |   78 +
#  include/asm-sh64/pgalloc.h              |  173 ++
#  include/asm-sh64/pgtable-3level.h       |  152 ++
#  include/asm-sh64/pgtable.h              |  336 +++++
#  include/asm-sh64/platform.h             |   69 +
#  include/asm-sh64/poll.h                 |   36
#  include/asm-sh64/posix_types.h          |  128 +
#  include/asm-sh64/processor.h            |  273 ++++
#  include/asm-sh64/ptrace.h               |   38
#  include/asm-sh64/registers.h            |  199 +++
#  include/asm-sh64/resource.h             |   47
#  include/asm-sh64/scatterlist.h          |   36
#  include/asm-sh64/segment.h              |    6
#  include/asm-sh64/semaphore-helper.h     |  100 +
#  include/asm-sh64/semaphore.h            |  139 ++
#  include/asm-sh64/sembuf.h               |   36
#  include/asm-sh64/serial.h               |   33
#  include/asm-sh64/shmbuf.h               |   53
#  include/asm-sh64/shmparam.h             |   20
#  include/asm-sh64/sigcontext.h           |   30
#  include/asm-sh64/siginfo.h              |  233 +++
#  include/asm-sh64/signal.h               |  184 ++
#  include/asm-sh64/smp.h                  |   15
#  include/asm-sh64/smplock.h              |   77 +
#  include/asm-sh64/socket.h               |   64
#  include/asm-sh64/sockios.h              |   24
#  include/asm-sh64/softirq.h              |   30
#  include/asm-sh64/spinlock.h             |   17
#  include/asm-sh64/stat.h                 |   88 +
#  include/asm-sh64/statfs.h               |   36
#  include/asm-sh64/string.h               |   21
#  include/asm-sh64/system.h               |  405 ++++++
#  include/asm-sh64/termbits.h             |  183 ++
#  include/asm-sh64/termios.h              |  118 +
#  include/asm-sh64/timex.h                |   36
#  include/asm-sh64/tlb.h                  |   95 +
#  include/asm-sh64/types.h                |   66 +
#  include/asm-sh64/uaccess.h              |  288 ++++
#  include/asm-sh64/ucontext.h             |   23
#  include/asm-sh64/unaligned.h            |   30
#  include/asm-sh64/unistd.h               |  416 ++++++
#  include/asm-sh64/user.h                 |   71 +
#  139 files changed, 23750 insertions(+)
# 
# and here's the patch..
# --------------------------------------------
# 03/06/27	grigouze@noos.fr	1.1005.1.6
# [PATCH] USB: zaurus SL-C700
# 
# This is a patch for usbnet for working with Zaurus SL-C700.
# The productid is different from other Zaurus, so i add an entry for it :)
# --------------------------------------------
# 03/06/27	baldrick@wanadoo.fr	1.1005.1.7
# [PATCH] USB speedtouch: use common CRC library
# 
# Remove the speedtouch CRC library.  With this change, the speedtch
# module is no longer a multi-part object, so fix that up too.
# --------------------------------------------
# 03/06/27	abbotti@mev.co.uk	1.1005.1.8
# [PATCH] USB: several ftdi_sio driver patches
# 
# I have attached several patches for the ftdi_sio (USB serial device)
# driver that I have been accumulating over the last month or so as
# the official maintainer (Bill Ryder) has been rather quiet of late.
# He hasn't responded to any patches or other messages on
# ftdi-usb-sio-devel since the end of March.
# 
# The last patch Bill sent to linux-usb-devel was for ftdi_sio version
# 1.3.3, which is the latest available for download from the
# sourceforge project page.  Greg had some criticisms about
# whitespace, braces, etc. which was not replied to by Bill.
# 
# In this sequence of patches, I have tidied some things up, accepted
# patches and vid/pids for extra device support and fixed a spinlock
# bug.
# 
# The patches apply cleanly in the sequence presented here.  I have
# split the patches by function, but have attempted to preserve the
# chronology where possible - there is a certain amount of
# time-warping going on as can be seen from the file header comments
# changed by the patches!
# 
# The patches are as follows:
# 
# 2.4.21-ftdi_sio-p01-xonxoff.patch - John Wilkins Xon/Xoff patch
# (included in ftdi_sio-1.3.3)
# 
# 2.4.21-ftdi_sio-p02-homechoice.patch - John Wilkins vid/pid for
# Homechoice (included in ftdi_sio-1.3.3)
# 
# 2.4.21-ftdi_sio-p03-readspeed.patch - Richard Shooter's read
# speed-up code (included in ftdi_sio-1.3.3), but I've tidied up the
# source and moved some stuff around.  I've bumped the version to
# 1.3.3a to distinguish it from the 1.3.3 that Bill previously sent.
# 
# 2.4.21-ftdi_sio-p04-spinlockbug.patch - my patch to avoid copying
# user data with a spinlock held (and interrupts disabled).
# 
# 2.4.21-ftdi_sio-p05-sealink.patch - Adds Sealevel vid/pids - based
# on a patch by Tuan Hoang but with less bloat.
# 
# 2.4.21-ftdi_sio-p06-usbuirt.patch - David Norwood's patch for
# USB-UIRT device using a preset custom divisor.
# 
# 2.4.21-ftdi_sio-p07-writepooltidy.patch - my patch to take account
# of write urb pool table entries that failed allocation, and to free
# the write urb and transfer buffer allocated by the usbserial
# driver.
# 
# 2.4.21-ftdi_sio-p08-relais.patch - support for USB Relais pid,
# backported from 2.5.x.
# 
# 2.4.21-ftdi_sio-p09-tira1.patch - half of Erik Nygren's patch to
# support Home Electronics' Tira-1 IR tranceiver using a preset
# custom divisor.
# 
# 2.4.21-ftdi_sio-p10-forcebaud.patch - the other half of Erik
# Nygren's patch forces the baud rate setting to B38400 for USB-UIRT
# and Tira-1 devices and also forces RTS/CTS on for Tira-1.
# 
# 2.4.21-ftdi_sio-p11-paranoid.patch - my patch to make sure pointers
# that fail paranoid checks are not dereferenced.
# 
# 2.4.21-ftdi_sio-p12-versionbump.patch - my patch to bump the
# version.  This is stepping on Bill's toes a little, but I think
# whatever ends up in the 2.4.22 kernel should be labelled version
# 1.3.4.
# 
# I have a 2.5.x driver version as a work in progress containing most
# of the above changes.  I just need to finish it off a little and
# maybe replace the write urb pool stuff with something resembling
# the changes in the Visor driver.
# --------------------------------------------
# 03/06/27	david@csse.uwa.edu.au	1.1005.1.9
# [PATCH] USB: usb-uhci fix for one-shot interrupt problem
# 
# A change introduced into usb-uhci.c in 2.4.21 causes the kernel to
# freeze when usb-uhci is used with any driver using one-shot interrupt
# transfers. The attached fix was originally proposed by Frode Isaksen and
# improved by Pete Zaitcev. Pete Zaitcev has applied this patch as an
# errata fix for the RedHat 9.0 kernel.
# 
# Other than the serious problem that this causes with the Lego USB driver
# (and yes, this is used pretty heavily in Universities for teaching and
# some research), there are other drivers (e.g. Visor Treo 90) that this
# causes problems for.
# --------------------------------------------
# 03/06/27	david@csse.uwa.edu.au	1.1005.1.10
# [PATCH] USB: usb-ohci handling of one-shot interrupt transfers
# 
# A long standing problem has existed with usb-ohci handling of one-shot
# interrupt transfers (they never worked). Attached is a fix which was
# originally proposed by P.C. Chan and subsequently modified and
# re-presented by Frode Isaksen. The Lego USB driver does not work with
# ohci without this fix and so I would really appreciate it being applied.
# --------------------------------------------
# 03/06/27	oliver@neukum.org	1.1005.1.11
# [PATCH] USB: disconnect of v4l devices in 2.4
# 
# in 2.4 video_unregister_device() has lost its magic properties
# breaking most USB v4l drivers. IMHO they should be converted
# to delayed freeing resources just like ordinary character devices.
# Here's the change for vicam.c.
# --------------------------------------------
# 03/06/27	oliver@neukum.org	1.1005.1.12
# [PATCH] USB: fix to previous vicam patch
# 
# OK, I'll think next time.
#   - fix my own stupid oversight regarding disconnect()
# --------------------------------------------
# 03/06/27	greg@kroah.com	1.1005.1.13
# [PATCH] USB: compiler fixes for previous vicam patches.
# --------------------------------------------
# 03/06/27	greg@kroah.com	1.1011.1.15
# Merge kroah.com:/home/greg/linux/BK/bleed-2.4
# into kroah.com:/home/greg/linux/BK/gregkh-2.4
# --------------------------------------------
# 03/06/27	judd@jpilot.org	1.1011.1.16
# [PATCH] USB: visor.h[c] USB device IDs
# 
# Add ability to specify USB vendor and product ids as module options.
# --------------------------------------------
# 03/06/27	chas@relax.cmf.nrl.navy.mil	1.1013
# do reference counting of struct atm_dev
# --------------------------------------------
#
diff -Nru a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
--- a/drivers/atm/atmtcp.c	Mon Jun 30 13:23:17 2003
+++ b/drivers/atm/atmtcp.c	Mon Jun 30 13:23:17 2003
@@ -153,6 +153,7 @@
 
 static int atmtcp_v_ioctl(struct atm_dev *dev,unsigned int cmd,void *arg)
 {
+	unsigned long flags;
 	struct atm_cirange ci;
 	struct atm_vcc *vcc;
 
@@ -162,9 +163,14 @@
 	if (ci.vci_bits == ATM_CI_MAX) ci.vci_bits = MAX_VCI_BITS;
 	if (ci.vpi_bits > MAX_VPI_BITS || ci.vpi_bits < 0 ||
 	    ci.vci_bits > MAX_VCI_BITS || ci.vci_bits < 0) return -EINVAL;
+	spin_lock_irqsave(&dev->lock, flags);
 	for (vcc = dev->vccs; vcc; vcc = vcc->next)
 		if ((vcc->vpi >> ci.vpi_bits) ||
-		    (vcc->vci >> ci.vci_bits)) return -EBUSY;
+		    (vcc->vci >> ci.vci_bits)) {
+			spin_unlock_irqrestore(&dev->lock, flags);
+			return -EBUSY;
+		}
+	spin_unlock_irqrestore(&dev->lock, flags);
 	dev->ci_range = ci;
 	return 0;
 }
@@ -227,6 +233,7 @@
 
 static void atmtcp_c_close(struct atm_vcc *vcc)
 {
+	unsigned long flags;
 	struct atm_dev *atmtcp_dev;
 	struct atmtcp_dev_data *dev_data;
 	struct atm_vcc *walk;
@@ -239,13 +246,16 @@
 	kfree(dev_data);
 	shutdown_atm_dev(atmtcp_dev);
 	vcc->dev_data = NULL;
+	spin_lock_irqsave(&atmtcp_dev->lock, flags);
 	for (walk = atmtcp_dev->vccs; walk; walk = walk->next)
 		wake_up(&walk->sleep);
+	spin_unlock_irqrestore(&atmtcp_dev->lock, flags);
 }
 
 
 static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 {
+	unsigned long flags;
 	struct atm_dev *dev;
 	struct atmtcp_hdr *hdr;
 	struct atm_vcc *out_vcc;
@@ -260,11 +270,13 @@
 		    (struct atmtcp_control *) skb->data);
 		goto done;
 	}
+	spin_lock_irqsave(&dev->lock, flags);
 	for (out_vcc = dev->vccs; out_vcc; out_vcc = out_vcc->next)
 		if (out_vcc->vpi == ntohs(hdr->vpi) &&
 		    out_vcc->vci == ntohs(hdr->vci) &&
 		    out_vcc->qos.rxtp.traffic_class != ATM_NONE)
 			break;
+	spin_unlock_irqrestore(&dev->lock, flags);
 	if (!out_vcc) {
 		atomic_inc(&vcc->stats->tx_err);
 		goto done;
@@ -293,13 +305,13 @@
 
 
 static struct atmdev_ops atmtcp_v_dev_ops = {
-	dev_close:	atmtcp_v_dev_close,
-	open:		atmtcp_v_open,
-	close:		atmtcp_v_close,
-	ioctl:		atmtcp_v_ioctl,
-	send:		atmtcp_v_send,
-	proc_read:	atmtcp_v_proc,
-	owner:		THIS_MODULE
+	.dev_close	= atmtcp_v_dev_close,
+	.open		= atmtcp_v_open,
+	.close		= atmtcp_v_close,
+	.ioctl		= atmtcp_v_ioctl,
+	.send		= atmtcp_v_send,
+	.proc_read	= atmtcp_v_proc,
+	.owner		= THIS_MODULE
 };
 
 
@@ -309,21 +321,16 @@
 
 
 static struct atmdev_ops atmtcp_c_dev_ops = {
-	close:		atmtcp_c_close,
-	send:		atmtcp_c_send
+	.close		= atmtcp_c_close,
+	.send		= atmtcp_c_send
 };
 
 
 static struct atm_dev atmtcp_control_dev = {
-	&atmtcp_c_dev_ops,
-	NULL,		/* no PHY */
-	"atmtcp",	/* type */
-	999,		/* dummy device number */
-	NULL,NULL,	/* pretend not to have any VCCs */
-	NULL,NULL,	/* no data */
-	{ 0 },		/* no flags */
-	NULL,		/* no local address */
-	{ 0 }		/* no ESI, no statistics */
+	.ops		= &atmtcp_c_dev_ops,
+	.type		= "atmtcp",
+	.number		= 999,
+	.lock		= SPIN_LOCK_UNLOCKED
 };
 
 
@@ -356,9 +363,12 @@
 	struct atm_dev *dev;
 
 	dev = NULL;
-	if (itf != -1) dev = atm_find_dev(itf);
+	if (itf != -1) dev = atm_dev_lookup(itf);
 	if (dev) {
-		if (dev->ops != &atmtcp_v_dev_ops) return -EMEDIUMTYPE;
+		if (dev->ops != &atmtcp_v_dev_ops) {
+			atm_dev_release(dev);
+			return -EMEDIUMTYPE;
+		}
 		if (PRIV(dev)->vcc) return -EBUSY;
 	}
 	else {
@@ -389,14 +399,18 @@
 	struct atm_dev *dev;
 	struct atmtcp_dev_data *dev_data;
 
-	dev = atm_find_dev(itf);
+	dev = atm_dev_lookup(itf);
 	if (!dev) return -ENODEV;
-	if (dev->ops != &atmtcp_v_dev_ops) return -EMEDIUMTYPE;
+	if (dev->ops != &atmtcp_v_dev_ops) {
+		atm_dev_release(dev);
+		return -EMEDIUMTYPE;
+	}
 	dev_data = PRIV(dev);
 	if (!dev_data->persist) return 0;
 	dev_data->persist = 0;
 	if (PRIV(dev)->vcc) return 0;
 	kfree(dev_data);
+	atm_dev_release(dev);
 	shutdown_atm_dev(dev);
 	return 0;
 }
diff -Nru a/drivers/atm/eni.c b/drivers/atm/eni.c
--- a/drivers/atm/eni.c	Mon Jun 30 13:23:17 2003
+++ b/drivers/atm/eni.c	Mon Jun 30 13:23:17 2003
@@ -1887,8 +1887,10 @@
 
 static int get_ci(struct atm_vcc *vcc,short *vpi,int *vci)
 {
+	unsigned long flags;
 	struct atm_vcc *walk;
 
+	spin_lock_irqsave(&vcc->dev->lock, flags);
 	if (*vpi == ATM_VPI_ANY) *vpi = 0;
 	if (*vci == ATM_VCI_ANY) {
 		for (*vci = ATM_NOT_RSV_VCI; *vci < NR_VCI; (*vci)++) {
@@ -1907,17 +1909,29 @@
 			}
 			break;
 		}
+		spin_unlock_irqrestore(&vcc->dev->lock, flags);
 		return *vci == NR_VCI ? -EADDRINUSE : 0;
 	}
-	if (*vci == ATM_VCI_UNSPEC) return 0;
+	if (*vci == ATM_VCI_UNSPEC) {
+		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+		return 0;
+	}
 	if (vcc->qos.rxtp.traffic_class != ATM_NONE &&
-	    ENI_DEV(vcc->dev)->rx_map[*vci])
+	    ENI_DEV(vcc->dev)->rx_map[*vci]) {
+		spin_unlock_irqrestore(&vcc->dev->lock, flags);
 		return -EADDRINUSE;
-	if (vcc->qos.txtp.traffic_class == ATM_NONE) return 0;
+	}
+	if (vcc->qos.txtp.traffic_class == ATM_NONE) {
+		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+		return 0;
+	}
 	for (walk = vcc->dev->vccs; walk; walk = walk->next)
 		if (test_bit(ATM_VF_ADDR,&walk->flags) && walk->vci == *vci &&
-		    walk->qos.txtp.traffic_class != ATM_NONE)
+		    walk->qos.txtp.traffic_class != ATM_NONE) {
+			spin_unlock_irqrestore(&vcc->dev->lock, flags);
 			return -EADDRINUSE;
+		}
+	spin_unlock_irqrestore(&vcc->dev->lock, flags);
 	return 0;
 }
 
@@ -2125,6 +2139,7 @@
 
 static int eni_proc_read(struct atm_dev *dev,loff_t *pos,char *page)
 {
+	unsigned long flags;
 	static const char *signal[] = { "LOST","unknown","okay" };
 	struct eni_dev *eni_dev = ENI_DEV(dev);
 	struct atm_vcc *vcc;
@@ -2197,6 +2212,7 @@
 		return sprintf(page,"%10sbacklog %u packets\n","",
 		    skb_queue_len(&tx->backlog));
 	}
+	spin_lock_irqsave(&dev->lock, flags);
 	for (vcc = dev->vccs; vcc; vcc = vcc->next) {
 		struct eni_vcc *eni_vcc = ENI_VCC(vcc);
 		int length;
@@ -2215,8 +2231,10 @@
 			length += sprintf(page+length,"tx[%d], txing %d bytes",
 			    eni_vcc->tx->index,eni_vcc->txing);
 		page[length] = '\n';
+		spin_unlock_irqrestore(&dev->lock, flags);
 		return length+1;
 	}
+	spin_unlock_irqrestore(&dev->lock, flags);
 	for (i = 0; i < eni_dev->free_len; i++) {
 		struct eni_free *fe = eni_dev->free_list+i;
 		unsigned long offset;
diff -Nru a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
--- a/drivers/atm/fore200e.c	Mon Jun 30 13:23:17 2003
+++ b/drivers/atm/fore200e.c	Mon Jun 30 13:23:17 2003
@@ -1077,13 +1077,16 @@
 static struct atm_vcc* 
 fore200e_find_vcc(struct fore200e* fore200e, struct rpd* rpd)
 {
+    unsigned long flags;
     struct atm_vcc* vcc;
 
+    spin_lock_irqsave(&fore200e->atm_dev->lock, flags);
     for (vcc = fore200e->atm_dev->vccs; vcc; vcc = vcc->next) {
 
 	if (vcc->vpi == rpd->atm_header.vpi && vcc->vci == rpd->atm_header.vci)
 	    break;
     }
+    spin_unlock_irqrestore(&fore200e->atm_dev->lock, flags);
     
     return vcc;
 }
@@ -1354,9 +1357,13 @@
 static int
 fore200e_walk_vccs(struct atm_vcc *vcc, short *vpi, int *vci)
 {
+    unsigned long flags;
     struct atm_vcc* walk;
 
     /* find a free VPI */
+
+    spin_lock_irqsave(&vcc->dev->lock, flags);
+
     if (*vpi == ATM_VPI_ANY) {
 
 	for (*vpi = 0, walk = vcc->dev->vccs; walk; walk = walk->next) {
@@ -1380,6 +1387,8 @@
 	}
     }
 
+    spin_unlock_irqrestore(&vcc->dev->lock, flags);
+
     return 0;
 }
 
@@ -2640,6 +2649,7 @@
 static int
 fore200e_proc_read(struct atm_dev *dev,loff_t* pos,char* page)
 {
+    unsigned long flags;
     struct fore200e* fore200e  = FORE200E_DEV(dev);
     int              len, left = *pos;
 
@@ -2886,6 +2896,7 @@
 	len = sprintf(page,"\n"    
 		      " VCCs:\n  address\tVPI.VCI:AAL\t(min/max tx PDU size) (min/max rx PDU size)\n");
 	
+	spin_lock_irqsave(&fore200e->atm_dev->lock, flags);
 	for (vcc = fore200e->atm_dev->vccs; vcc; vcc = vcc->next) {
 
 	    fore200e_vcc = FORE200E_VCC(vcc);
@@ -2900,6 +2911,7 @@
 			   fore200e_vcc->rx_max_pdu
 		);
 	}
+	spin_unlock_irqrestore(&fore200e->atm_dev->lock, flags);
 
 	return len;
     }
diff -Nru a/drivers/atm/he.c b/drivers/atm/he.c
--- a/drivers/atm/he.c	Mon Jun 30 13:23:17 2003
+++ b/drivers/atm/he.c	Mon Jun 30 13:23:17 2003
@@ -329,6 +329,7 @@
 static __inline__ struct atm_vcc*
 he_find_vcc(struct he_dev *he_dev, unsigned cid)
 {
+	unsigned long flags;
 	struct atm_vcc *vcc;
 	short vpi;
 	int vci;
@@ -336,10 +337,15 @@
 	vpi = cid >> he_dev->vcibits;
 	vci = cid & ((1 << he_dev->vcibits) - 1);
 
+	spin_lock_irqsave(&he_dev->atm_dev->lock, flags);
 	for (vcc = he_dev->atm_dev->vccs; vcc; vcc = vcc->next)
 		if (vcc->vci == vci && vcc->vpi == vpi
-			&& vcc->qos.rxtp.traffic_class != ATM_NONE) return vcc;
+			&& vcc->qos.rxtp.traffic_class != ATM_NONE) {
+				spin_unlock_irqrestore(&he_dev->atm_dev->lock, flags);
+				return vcc;
+			}
 
+	spin_unlock_irqrestore(&he_dev->atm_dev->lock, flags);
 	return NULL;
 }
 
diff -Nru a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
--- a/drivers/atm/idt77252.c	Mon Jun 30 13:23:17 2003
+++ b/drivers/atm/idt77252.c	Mon Jun 30 13:23:17 2003
@@ -2404,8 +2404,10 @@
 static int
 idt77252_find_vcc(struct atm_vcc *vcc, short *vpi, int *vci)
 {
+	unsigned long flags;
 	struct atm_vcc *walk;
 
+	spin_lock_irqsave(&vcc->dev->lock, flags);
 	if (*vpi == ATM_VPI_ANY) {
 		*vpi = 0;
 		walk = vcc->dev->vccs;
@@ -2432,6 +2434,7 @@
 		}
 	}
 
+	spin_unlock_irqrestore(&vcc->dev->lock, flags);
 	return 0;
 }
 
diff -Nru a/include/linux/atmdev.h b/include/linux/atmdev.h
--- a/include/linux/atmdev.h	Mon Jun 30 13:23:17 2003
+++ b/include/linux/atmdev.h	Mon Jun 30 13:23:17 2003
@@ -341,6 +341,8 @@
 	struct k_atm_dev_stats stats;	/* statistics */
 	char		signal;		/* signal status (ATM_PHY_SIG_*) */
 	int		link_rate;	/* link rate (default: OC3) */
+	atomic_t	refcnt;		/* reference count */
+	spinlock_t	lock;		/* protect internal members */
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *proc_entry; /* proc entry */
 	char *proc_name;		/* proc entry name */
@@ -402,7 +404,7 @@
 
 struct atm_dev *atm_dev_register(const char *type,const struct atmdev_ops *ops,
     int number,atm_dev_flags_t *flags); /* number == -1: pick first available */
-struct atm_dev *atm_find_dev(int number);
+struct atm_dev *atm_dev_lookup(int number);
 void atm_dev_deregister(struct atm_dev *dev);
 void shutdown_atm_dev(struct atm_dev *dev);
 void bind_vcc(struct atm_vcc *vcc,struct atm_dev *dev);
@@ -413,27 +415,43 @@
  *
  */
 
-static __inline__ int atm_guess_pdu2truesize(int pdu_size)
+static inline int atm_guess_pdu2truesize(int pdu_size)
 {
 	return ((pdu_size+15) & ~15) + sizeof(struct sk_buff);
 }
 
 
-static __inline__ void atm_force_charge(struct atm_vcc *vcc,int truesize)
+static inline void atm_force_charge(struct atm_vcc *vcc,int truesize)
 {
 	atomic_add(truesize, &vcc->sk->rmem_alloc);
 }
 
 
-static __inline__ void atm_return(struct atm_vcc *vcc,int truesize)
+static inline void atm_return(struct atm_vcc *vcc,int truesize)
 {
 	atomic_sub(truesize, &vcc->sk->rmem_alloc);
 }
 
 
-static __inline__ int atm_may_send(struct atm_vcc *vcc,unsigned int size)
+static inline int atm_may_send(struct atm_vcc *vcc,unsigned int size)
 {
 	return (size + atomic_read(&vcc->sk->wmem_alloc)) < vcc->sk->sndbuf;
+}
+
+
+static inline void atm_dev_hold(struct atm_dev *dev)
+{
+	atomic_inc(&dev->refcnt);
+}
+
+
+static inline void atm_dev_release(struct atm_dev *dev)
+{
+	atomic_dec(&dev->refcnt);
+
+	if ((atomic_read(&dev->refcnt) == 1) &&
+	    test_bit(ATM_DF_CLOSE,&dev->flags))
+		shutdown_atm_dev(dev);
 }
 
 
diff -Nru a/net/atm/addr.c b/net/atm/addr.c
--- a/net/atm/addr.c	Mon Jun 30 13:23:17 2003
+++ b/net/atm/addr.c	Mon Jun 30 13:23:17 2003
@@ -36,14 +36,6 @@
 }
 
 
-/*
- * Avoid modification of any list of local interfaces while reading it
- * (which may involve page faults and therefore rescheduling)
- */
-
-static DECLARE_MUTEX(local_lock);
-extern  spinlock_t atm_dev_lock;
-
 static void notify_sigd(struct atm_dev *dev)
 {
 	struct sockaddr_atmpvc pvc;
@@ -52,46 +44,46 @@
 	sigd_enq(NULL,as_itf_notify,NULL,&pvc,NULL);
 }
 
-/*
- *	This is called from atm_ioctl only. You must hold the lock as a caller
- */
 
 void atm_reset_addr(struct atm_dev *dev)
 {
+	unsigned long flags;
 	struct atm_dev_addr *this;
 
-	down(&local_lock);
+	spin_lock_irqsave(&dev->lock, flags);
 	while (dev->local) {
 		this = dev->local;
 		dev->local = this->next;
 		kfree(this);
 	}
-	up(&local_lock);
+	spin_unlock_irqrestore(&dev->lock, flags);
 	notify_sigd(dev);
 }
 
 
 int atm_add_addr(struct atm_dev *dev,struct sockaddr_atmsvc *addr)
 {
+	unsigned long flags;
 	struct atm_dev_addr **walk;
 	int error;
 
 	error = check_addr(addr);
-	if (error) return error;
-	down(&local_lock);
+	if (error)
+		return error;
+	spin_lock_irqsave(&dev->lock, flags);
 	for (walk = &dev->local; *walk; walk = &(*walk)->next)
 		if (identical(&(*walk)->addr,addr)) {
-			up(&local_lock);
+			spin_unlock_irqrestore(&dev->lock, flags);
 			return -EEXIST;
 		}
-	*walk = kmalloc(sizeof(struct atm_dev_addr),GFP_KERNEL);
+	*walk = kmalloc(sizeof(struct atm_dev_addr), GFP_ATOMIC);
 	if (!*walk) {
-		up(&local_lock);
+		spin_unlock_irqrestore(&dev->lock, flags);
 		return -ENOMEM;
 	}
 	(*walk)->addr = *addr;
 	(*walk)->next = NULL;
-	up(&local_lock);
+	spin_unlock_irqrestore(&dev->lock, flags);
 	notify_sigd(dev);
 	return 0;
 }
@@ -99,22 +91,24 @@
 
 int atm_del_addr(struct atm_dev *dev,struct sockaddr_atmsvc *addr)
 {
+	unsigned long flags;
 	struct atm_dev_addr **walk,*this;
 	int error;
 
 	error = check_addr(addr);
-	if (error) return error;
-	down(&local_lock);
+	if (error)
+		return error;
+	spin_lock_irqsave(&dev->lock, flags);
 	for (walk = &dev->local; *walk; walk = &(*walk)->next)
 		if (identical(&(*walk)->addr,addr)) break;
 	if (!*walk) {
-		up(&local_lock);
+		spin_unlock_irqrestore(&dev->lock, flags);
 		return -ENOENT;
 	}
 	this = *walk;
 	*walk = this->next;
 	kfree(this);
-	up(&local_lock);
+	spin_unlock_irqrestore(&dev->lock, flags);
 	notify_sigd(dev);
 	return 0;
 }
@@ -122,24 +116,25 @@
 
 int atm_get_addr(struct atm_dev *dev,struct sockaddr_atmsvc *u_buf,int size)
 {
+	unsigned long flags;
 	struct atm_dev_addr *walk;
 	int total;
 
-	down(&local_lock);
+	spin_lock_irqsave(&dev->lock, flags);
 	total = 0;
 	for (walk = dev->local; walk; walk = walk->next) {
 		total += sizeof(struct sockaddr_atmsvc);
 		if (total > size) {
-			up(&local_lock);
+			spin_unlock_irqrestore(&dev->lock, flags);
 			return -E2BIG;
 		}
 		if (copy_to_user(u_buf,&walk->addr,
 		    sizeof(struct sockaddr_atmsvc))) {
-			up(&local_lock);
+			spin_unlock_irqrestore(&dev->lock, flags);
 			return -EFAULT;
 		}
 		u_buf++;
 	}
-	up(&local_lock);
+	spin_unlock_irqrestore(&dev->lock, flags);
 	return total;
 }
diff -Nru a/net/atm/atm_misc.c b/net/atm/atm_misc.c
--- a/net/atm/atm_misc.c	Mon Jun 30 13:23:17 2003
+++ b/net/atm/atm_misc.c	Mon Jun 30 13:23:17 2003
@@ -63,13 +63,19 @@
 
 int atm_find_ci(struct atm_vcc *vcc,short *vpi,int *vci)
 {
+	unsigned long flags;
 	static short p = 0; /* poor man's per-device cache */
 	static int c = 0;
 	short old_p;
 	int old_c;
+	int err;
 
-	if (*vpi != ATM_VPI_ANY && *vci != ATM_VCI_ANY)
-		return check_ci(vcc,*vpi,*vci);
+	spin_lock_irqsave(&vcc->dev->lock, flags);
+	if (*vpi != ATM_VPI_ANY && *vci != ATM_VCI_ANY) {
+		err = check_ci(vcc,*vpi,*vci);
+		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+		return err;
+	}
 	/* last scan may have left values out of bounds for current device */
 	if (*vpi != ATM_VPI_ANY) p = *vpi;
 	else if (p >= 1 << vcc->dev->ci_range.vpi_bits) p = 0;
@@ -82,6 +88,7 @@
 		if (!check_ci(vcc,p,c)) {
 			*vpi = p;
 			*vci = c;
+			spin_unlock_irqrestore(&vcc->dev->lock, flags);
 			return 0;
 		}
 		if (*vci == ATM_VCI_ANY) {
@@ -96,6 +103,7 @@
 		}
 	}
 	while (old_p != p || old_c != c);
+	spin_unlock_irqrestore(&vcc->dev->lock, flags);
 	return -EADDRINUSE;
 }
 
diff -Nru a/net/atm/clip.c b/net/atm/clip.c
--- a/net/atm/clip.c	Mon Jun 30 13:23:17 2003
+++ b/net/atm/clip.c	Mon Jun 30 13:23:17 2003
@@ -713,9 +713,10 @@
 
 
 static struct atm_dev atmarpd_dev = {
-	.ops =			&atmarpd_dev_ops,
-	.type =			"arpd",
-	.number =		999,
+	.ops =		&atmarpd_dev_ops,
+	.type =		"arpd",
+	.number =	999,
+	.lock =		SPIN_LOCK_UNLOCKED
 };
 
 
diff -Nru a/net/atm/common.c b/net/atm/common.c
--- a/net/atm/common.c	Mon Jun 30 13:23:17 2003
+++ b/net/atm/common.c	Mon Jun 30 13:23:17 2003
@@ -116,7 +116,6 @@
 #define DPRINTK(format,args...)
 #endif
 
-spinlock_t atm_dev_lock = SPIN_LOCK_UNLOCKED;
 
 static struct sk_buff *alloc_tx(struct atm_vcc *vcc,unsigned int size)
 {
@@ -178,19 +177,18 @@
 			atm_return(vcc,skb->truesize);
 			kfree_skb(skb);
 		}
-		spin_lock (&atm_dev_lock);	
-		fops_put (vcc->dev->ops);
+
+		if (vcc->dev->ops->owner)
+			__MOD_DEC_USE_COUNT(vcc->dev->ops->owner);
+		atm_dev_release(vcc->dev);
 		if (atomic_read(&vcc->sk->rmem_alloc))
 			printk(KERN_WARNING "atm_release_vcc: strange ... "
 			    "rmem_alloc == %d after closing\n",
 			    atomic_read(&vcc->sk->rmem_alloc));
 		bind_vcc(vcc,NULL);
-	} else
-		spin_lock (&atm_dev_lock);	
+	}
 
 	if (free_sk) free_atm_vcc_sk(sk);
-
-	spin_unlock (&atm_dev_lock);
 }
 
 
@@ -283,11 +281,13 @@
 	    vcc->qos.txtp.min_pcr,vcc->qos.txtp.max_pcr,vcc->qos.txtp.max_sdu);
 	DPRINTK("  RX: %d, PCR %d..%d, SDU %d\n",vcc->qos.rxtp.traffic_class,
 	    vcc->qos.rxtp.min_pcr,vcc->qos.rxtp.max_pcr,vcc->qos.rxtp.max_sdu);
-	fops_get (dev->ops);
+	if (!try_inc_mod_count(dev->ops->owner))
+		return -ENODEV;
 	if (dev->ops->open) {
 		error = dev->ops->open(vcc,vpi,vci);
 		if (error) {
-			fops_put (dev->ops);
+			if (dev->ops->owner)
+				__MOD_DEC_USE_COUNT(dev->ops->owner);
 			bind_vcc(vcc,NULL);
 			return error;
 		}
@@ -301,14 +301,13 @@
 	struct atm_dev *dev;
 	int return_val;
 
-	spin_lock (&atm_dev_lock);
-	dev = atm_find_dev(itf);
+	dev = atm_dev_lookup(itf);
 	if (!dev)
 		return_val =  -ENODEV;
-	else
+	else {
 		return_val = atm_do_connect_dev(vcc,dev,vpi,vci);
-
-	spin_unlock (&atm_dev_lock);
+		if (return_val) atm_dev_release(dev);
+	}
 
 	return return_val;
 }
@@ -339,15 +338,20 @@
 	}
 	else {
 		struct atm_dev *dev = NULL;
-		struct list_head *p;
+		struct list_head *p, *next;
 
-		spin_lock (&atm_dev_lock);
-		list_for_each(p, &atm_devs) {
+		spin_lock(&atm_dev_lock);
+		list_for_each_safe(p, next, &atm_devs) {
 			dev = list_entry(p, struct atm_dev, dev_list);
-			if (!atm_do_connect_dev(vcc,dev,vpi,vci)) break;
+			atm_dev_hold(dev);
+			spin_unlock(&atm_dev_lock);
+			if (!atm_do_connect_dev(vcc,dev,vpi,vci))
+				break;
+			atm_dev_release(dev);
 			dev = NULL;
+			spin_lock(&atm_dev_lock);
 		}
-		spin_unlock (&atm_dev_lock);
+		spin_unlock(&atm_dev_lock);
 		if (!dev) return -ENODEV;
 	}
 	if (vpi == ATM_VPI_UNSPEC || vci == ATM_VCI_UNSPEC)
@@ -565,7 +569,6 @@
 	int error,len,size,number, ret_val;
 
 	ret_val = 0;
-	spin_lock (&atm_dev_lock);
 	vcc = ATM_SD(sock);
 	switch (cmd) {
 		case SIOCOUTQ:
@@ -603,14 +606,17 @@
 				goto done;
 			}
 			size = 0;
+			spin_lock(&atm_dev_lock);
 			list_for_each(p, &atm_devs)
 				size += sizeof(int);
 			if (size > len) {
+				spin_unlock(&atm_dev_lock);
 				ret_val = -E2BIG;
 				goto done;
 			}
-			tmp_buf = kmalloc(size,GFP_KERNEL);
+			tmp_buf = kmalloc(size, GFP_ATOMIC);
 			if (!tmp_buf) {
+				spin_unlock(&atm_dev_lock);
 				ret_val = -ENOMEM;
 				goto done;
 			}
@@ -619,6 +625,7 @@
 				dev = list_entry(p, struct atm_dev, dev_list);
 				*tmp_p++ = dev->number;
 			}
+			spin_unlock(&atm_dev_lock);
 		        ret_val = ((copy_to_user(buf, tmp_buf, size)) ||
 			    put_user(size, &((struct atm_iobuf *) arg)->length)
 			    ) ? -EFAULT : 0;
@@ -845,7 +852,7 @@
 		ret_val = -EFAULT;
 		goto done;
 	}
-	if (!(dev = atm_find_dev(number))) {
+	if (!(dev = atm_dev_lookup(number))) {
 		ret_val = -ENODEV;
 		goto done;
 	}
@@ -856,14 +863,14 @@
 			size = strlen(dev->type)+1;
 			if (copy_to_user(buf,dev->type,size)) {
 				ret_val = -EFAULT;
-				goto done;
+				goto done_release;
 			}
 			break;
 		case ATM_GETESI:
 			size = ESI_LEN;
 			if (copy_to_user(buf,dev->esi,size)) {
 				ret_val = -EFAULT;
-				goto done;
+				goto done_release;
 			}
 			break;
 		case ATM_SETESI:
@@ -873,7 +880,7 @@
 				for (i = 0; i < ESI_LEN; i++)
 					if (dev->esi[i]) {
 						ret_val = -EEXIST;
-						goto done;
+						goto done_release;
 					}
 			}
 			/* fall through */
@@ -883,20 +890,20 @@
 
 				if (!capable(CAP_NET_ADMIN)) {
 					ret_val = -EPERM;
-					goto done;
+					goto done_release;
 				}
 				if (copy_from_user(esi,buf,ESI_LEN)) {
 					ret_val = -EFAULT;
-					goto done;
+					goto done_release;
 				}
 				memcpy(dev->esi,esi,ESI_LEN);
 				ret_val =  ESI_LEN;
-				goto done;
+				goto done_release;
 			}
 		case ATM_GETSTATZ:
 			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
-				goto done;
+				goto done_release;
 			}
 			/* fall through */
 		case ATM_GETSTAT:
@@ -904,27 +911,27 @@
 			error = fetch_stats(dev,buf,cmd == ATM_GETSTATZ);
 			if (error) {
 				ret_val = error;
-				goto done;
+				goto done_release;
 			}
 			break;
 		case ATM_GETCIRANGE:
 			size = sizeof(struct atm_cirange);
 			if (copy_to_user(buf,&dev->ci_range,size)) {
 				ret_val = -EFAULT;
-				goto done;
+				goto done_release;
 			}
 			break;
 		case ATM_GETLINKRATE:
 			size = sizeof(int);
 			if (copy_to_user(buf,&dev->link_rate,size)) {
 				ret_val = -EFAULT;
-				goto done;
+				goto done_release;
 			}
 			break;
 		case ATM_RSTADDR:
 			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
-				goto done;
+				goto done_release;
 			}
 			atm_reset_addr(dev);
 			break;
@@ -932,20 +939,20 @@
 		case ATM_DELADDR:
 			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
-				goto done;
+				goto done_release;
 			}
 			{
 				struct sockaddr_atmsvc addr;
 
 				if (copy_from_user(&addr,buf,sizeof(addr))) {
 					ret_val = -EFAULT;
-					goto done;
+					goto done_release;
 				}
 				if (cmd == ATM_ADDADDR)
 					ret_val = atm_add_addr(dev,&addr);
 				else
 					ret_val = atm_del_addr(dev,&addr);
-				goto done;
+				goto done_release;
 			}
 		case ATM_GETADDR:
 			size = atm_get_addr(dev,buf,len);
@@ -956,13 +963,13 @@
 			   write the length" */
 				ret_val = put_user(size,
 						   &((struct atmif_sioc *) arg)->length) ? -EFAULT : 0;
-			goto done;
+			goto done_release;
 		case ATM_SETLOOP:
 			if (__ATM_LM_XTRMT((int) (long) buf) &&
 			    __ATM_LM_XTLOC((int) (long) buf) >
 			    __ATM_LM_XTRMT((int) (long) buf)) {
 				ret_val = -EINVAL;
-				goto done;
+				goto done_release;
 			}
 			/* fall through */
 		case ATM_SETCIRANGE:
@@ -972,18 +979,18 @@
 		case SONET_SETFRAMING:
 			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
-				goto done;
+				goto done_release;
 			}
 			/* fall through */
 		default:
 			if (!dev->ops->ioctl) {
 				ret_val = -EINVAL;
-				goto done;
+				goto done_release;
 			}
 			size = dev->ops->ioctl(dev,cmd,buf);
 			if (size < 0) {
 				ret_val = (size == -ENOIOCTLCMD ? -EINVAL : size);
-				goto done;
+				goto done_release;
 			}
 	}
 	
@@ -992,9 +999,10 @@
 			-EFAULT : 0;
 	else
 		ret_val = 0;
+done_release:
+	atm_dev_release(dev);
 
- done:
-	spin_unlock (&atm_dev_lock); 
+done:
 	return ret_val;
 }
 
diff -Nru a/net/atm/lec.c b/net/atm/lec.c
--- a/net/atm/lec.c	Mon Jun 30 13:23:17 2003
+++ b/net/atm/lec.c	Mon Jun 30 13:23:17 2003
@@ -550,20 +550,15 @@
 }
 
 static struct atmdev_ops lecdev_ops = {
-        close:	lec_atm_close,
-        send:	lec_atm_send
+	.close	= lec_atm_close,
+	.send	= lec_atm_send
 };
 
 static struct atm_dev lecatm_dev = {
-        &lecdev_ops,
-        NULL,	    /*PHY*/
-        "lec",	    /*type*/
-        999,	    /*dummy device number*/
-        NULL,NULL,  /*no VCCs*/
-        NULL,NULL,  /*no data*/
-        { 0 },	    /*no flags*/
-        NULL,	    /* no local address*/
-        { 0 }	    /*no ESI or rest of the atm_dev struct things*/
+	.ops	= &lecdev_ops,
+	.type	= "lec",
+	.number	= 999,
+	.lock	= SPIN_LOCK_UNLOCKED
 };
 
 /*
diff -Nru a/net/atm/mpc.c b/net/atm/mpc.c
--- a/net/atm/mpc.c	Mon Jun 30 13:23:17 2003
+++ b/net/atm/mpc.c	Mon Jun 30 13:23:17 2003
@@ -736,22 +736,15 @@
 }
 
 static struct atmdev_ops mpc_ops = { /* only send is required */
-	close:	mpoad_close,
-	send:	msg_from_mpoad
+	.close	= mpoad_close,
+	.send	= msg_from_mpoad
 };
 
 static struct atm_dev mpc_dev = {
-	&mpc_ops,       /* device operations    */
-	NULL,           /* PHY operations       */
-	"mpc",          /* device type name     */
-	42,             /* device index (dummy) */
-	NULL,           /* VCC table            */
-	NULL,           /* last VCC             */
-	NULL,           /* per-device data      */
-	NULL,           /* private PHY data     */
-	{ 0 },          /* device flags         */
-	NULL,           /* local ATM address    */
-	{ 0 }           /* no ESI               */
+	.ops	= &mpc_ops,
+	.type	= "mpc",
+	.number	= 42,
+	.lock	= SPIN_LOCK_UNLOCKED
 	/* rest of the members will be 0 */
 };
 
diff -Nru a/net/atm/proc.c b/net/atm/proc.c
--- a/net/atm/proc.c	Mon Jun 30 13:23:17 2003
+++ b/net/atm/proc.c	Mon Jun 30 13:23:17 2003
@@ -84,6 +84,7 @@
 	add_stats(buf,"0",&dev->stats.aal0);
 	strcat(buf,"  ");
 	add_stats(buf,"5",&dev->stats.aal5);
+	sprintf(strchr(buf,0), "\t[%d]", atomic_read(&dev->refcnt));
 	strcat(buf,"\n");
 }
 
@@ -161,7 +162,7 @@
 #endif
 
 
-static void pvc_info(struct atm_vcc *vcc,char *buf)
+static void pvc_info(struct atm_vcc *vcc, char *buf, int clip_info)
 {
 	static const char *class_name[] = { "off","UBR","CBR","VBR","ABR" };
 	static const char *aal_name[] = {
@@ -178,20 +179,17 @@
 	    class_name[vcc->qos.rxtp.traffic_class],vcc->qos.txtp.min_pcr,
 	    class_name[vcc->qos.txtp.traffic_class]);
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-	if (try_atm_clip_ops()) {
-		if (vcc->push == atm_clip_ops->clip_push) {
-			struct clip_vcc *clip_vcc = CLIP_VCC(vcc);
-			struct net_device *dev;
-
-			dev = clip_vcc->entry ? clip_vcc->entry->neigh->dev : NULL;
-			off += sprintf(buf+off,"CLIP, Itf:%s, Encap:",
-			    dev ? dev->name : "none?");
-			if (clip_vcc->encap)
-				off += sprintf(buf+off,"LLC/SNAP");
-			else
-				off += sprintf(buf+off,"None");
-		}
-		__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+	if (clip_info && (vcc->push == atm_clip_ops->clip_push)) {
+		struct clip_vcc *clip_vcc = CLIP_VCC(vcc);
+		struct net_device *dev;
+
+		dev = clip_vcc->entry ? clip_vcc->entry->neigh->dev : NULL;
+		off += sprintf(buf+off,"CLIP, Itf:%s, Encap:",
+		    dev ? dev->name : "none?");
+		if (clip_vcc->encap)
+			off += sprintf(buf+off,"LLC/SNAP");
+		else
+			off += sprintf(buf+off,"None");
 	}
 #endif
 	strcpy(buf+off,"\n");
@@ -312,16 +310,19 @@
 
 	if (!pos) {
 		return sprintf(buf,"Itf Type    ESI/\"MAC\"addr "
-		    "AAL(TX,err,RX,err,drop) ...\n");
+		    "AAL(TX,err,RX,err,drop) ...               [refcnt]\n");
 	}
 	left = pos-1;
+	spin_lock(&atm_dev_lock);
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
 		if (left-- == 0) {
 			dev_info(dev,buf);
+			spin_unlock(&atm_dev_lock);
 			return strlen(buf);
 		}
 	}
+	spin_unlock(&atm_dev_lock);
 	return 0;
 }
 
@@ -332,31 +333,50 @@
 
 static int atm_pvc_info(loff_t pos,char *buf)
 {
+	unsigned long flags;
 	struct atm_dev *dev;
 	struct list_head *p;
 	struct atm_vcc *vcc;
-	int left;
+	int left, clip_info = 0;
 
 	if (!pos) {
 		return sprintf(buf,"Itf VPI VCI   AAL RX(PCR,Class) "
 		    "TX(PCR,Class)\n");
 	}
 	left = pos-1;
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+	if (try_atm_clip_ops())
+		clip_info = 1;
+#endif
+	spin_lock(&atm_dev_lock);
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
+		spin_lock_irqsave(&dev->lock, flags);
 		for (vcc = dev->vccs; vcc; vcc = vcc->next)
-			if (vcc->sk->family == PF_ATMPVC &&
-			    vcc->dev && !left--) {
-				pvc_info(vcc,buf);
+			if (vcc->sk->family == PF_ATMPVC && vcc->dev && !left--) {
+				pvc_info(vcc,buf,clip_info);
+				spin_unlock_irqrestore(&dev->lock, flags);
+				spin_unlock(&atm_dev_lock);
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+				if (clip_info)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+#endif
 				return strlen(buf);
 			}
+		spin_unlock_irqrestore(&dev->lock, flags);
 	}
+	spin_unlock(&atm_dev_lock);
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+	if (clip_info)
+		__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+#endif
 	return 0;
 }
 
 
 static int atm_vc_info(loff_t pos,char *buf)
 {
+	unsigned long flags;
 	struct atm_dev *dev;
 	struct list_head *p;
 	struct atm_vcc *vcc;
@@ -367,19 +387,20 @@
 		    "Address"," Itf VPI VCI   Fam Flags Reply Send buffer"
 		    "     Recv buffer\n");
 	left = pos-1;
+	spin_lock(&atm_dev_lock);
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
+		spin_lock_irqsave(&dev->lock, flags);
 		for (vcc = dev->vccs; vcc; vcc = vcc->next)
 			if (!left--) {
 				vc_info(vcc,buf);
+				spin_unlock_irqrestore(&dev->lock, flags);
+				spin_unlock(&atm_dev_lock);
 				return strlen(buf);
 			}
+		spin_unlock_irqrestore(&dev->lock, flags);
 	}
-	for (vcc = nodev_vccs; vcc; vcc = vcc->next)
-		if (!left--) {
-			vc_info(vcc,buf);
-			return strlen(buf);
-		}
+	spin_unlock(&atm_dev_lock);
 
 	return 0;
 }
@@ -387,6 +408,7 @@
 
 static int atm_svc_info(loff_t pos,char *buf)
 {
+	unsigned long flags;
 	struct atm_dev *dev;
 	struct list_head *p;
 	struct atm_vcc *vcc;
@@ -395,19 +417,21 @@
 	if (!pos)
 		return sprintf(buf,"Itf VPI VCI           State      Remote\n");
 	left = pos-1;
+	spin_lock(&atm_dev_lock);
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
+		spin_lock_irqsave(&dev->lock, flags);
 		for (vcc = dev->vccs; vcc; vcc = vcc->next)
 			if (vcc->sk->family == PF_ATMSVC && !left--) {
 				svc_info(vcc,buf);
+				spin_unlock_irqrestore(&dev->lock, flags);
+				spin_unlock(&atm_dev_lock);
 				return strlen(buf);
 			}
+		spin_unlock_irqrestore(&dev->lock, flags);
 	}
-	for (vcc = nodev_vccs; vcc; vcc = vcc->next)
-		if (vcc->sk->family == PF_ATMSVC && !left--) {
-			svc_info(vcc,buf);
-			return strlen(buf);
-		}
+	spin_unlock(&atm_dev_lock);
+
 	return 0;
 }
 
diff -Nru a/net/atm/resources.c b/net/atm/resources.c
--- a/net/atm/resources.c	Mon Jun 30 13:23:17 2003
+++ b/net/atm/resources.c	Mon Jun 30 13:23:17 2003
@@ -23,67 +23,83 @@
 
 
 LIST_HEAD(atm_devs);
-struct atm_vcc *nodev_vccs = NULL;
-extern spinlock_t atm_dev_lock;
+spinlock_t atm_dev_lock = SPIN_LOCK_UNLOCKED;
 
 
-static struct atm_dev *alloc_atm_dev(const char *type)
+static struct atm_dev *__alloc_atm_dev(const char *type)
 {
 	struct atm_dev *dev;
 
 	dev = kmalloc(sizeof(*dev), GFP_ATOMIC);
-	if (!dev) return NULL;
-	memset(dev,0,sizeof(*dev));
+	if (!dev)
+		return NULL;
+	memset(dev, 0, sizeof(*dev));
 	dev->type = type;
 	dev->signal = ATM_PHY_SIG_UNKNOWN;
 	dev->link_rate = ATM_OC3_PCR;
-	list_add_tail(&dev->dev_list, &atm_devs);
+	spin_lock_init(&dev->lock);
 
 	return dev;
 }
 
 
-static void free_atm_dev(struct atm_dev *dev)
+static void __free_atm_dev(struct atm_dev *dev)
 {
-	list_del(&dev->dev_list);
 	kfree(dev);
 }
 
-struct atm_dev *atm_find_dev(int number)
+static struct atm_dev *__atm_dev_lookup(int number)
 {
 	struct atm_dev *dev;
 	struct list_head *p;
 
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
-		if (dev->ops && dev->number == number)
+		if ((dev->ops) && (dev->number == number)) {
+			atm_dev_hold(dev);
 			return dev;
+		}
 	}
 	return NULL;
 }
 
-struct atm_dev *atm_dev_register(const char *type,const struct atmdev_ops *ops,
-    int number,atm_dev_flags_t *flags)
+struct atm_dev *atm_dev_lookup(int number)
 {
-	struct atm_dev *dev = NULL;
+	struct atm_dev *dev;
 
 	spin_lock(&atm_dev_lock);
+	dev = __atm_dev_lookup(number);
+	spin_unlock(&atm_dev_lock);
+	return dev;
+}
 
-	dev = alloc_atm_dev(type);
+struct atm_dev *atm_dev_register(const char *type, const struct atmdev_ops *ops,
+				 int number, atm_dev_flags_t *flags)
+{
+	struct atm_dev *dev, *inuse;
+
+
+	dev = __alloc_atm_dev(type);
 	if (!dev) {
 		printk(KERN_ERR "atm_dev_register: no space for dev %s\n",
 		    type);
-		goto done;
+		return NULL;
 	}
+	spin_lock(&atm_dev_lock);
 	if (number != -1) {
-		if (atm_find_dev(number)) {
-			free_atm_dev(dev);
+		if ((inuse = __atm_dev_lookup(number))) {
+			atm_dev_release(inuse);
+			spin_unlock(&atm_dev_lock);
+			__free_atm_dev(dev);
 			return NULL;
 		}
 		dev->number = number;
 	} else {
 		dev->number = 0;
-		while (atm_find_dev(dev->number)) dev->number++;
+		while ((inuse = __atm_dev_lookup(dev->number))) {
+			atm_dev_release(inuse);
+			dev->number++;
+		}
 	}
 	dev->vccs = dev->last = NULL;
 	dev->dev_data = NULL;
@@ -92,41 +108,66 @@
 	if (flags) 
 		dev->flags = *flags;
 	else 
-		memset(&dev->flags,0,sizeof(dev->flags));
-	memset((void *) &dev->stats,0,sizeof(dev->stats));
+		memset(&dev->flags, 0, sizeof(dev->flags));
+	memset(&dev->stats, 0, sizeof(dev->stats));
+	atomic_set(&dev->refcnt, 1);
+	list_add_tail(&dev->dev_list, &atm_devs);
+	spin_unlock(&atm_dev_lock);
+
 #ifdef CONFIG_PROC_FS
-	if (ops->proc_read)
+	if (ops->proc_read) {
 		if (atm_proc_dev_register(dev) < 0) {
 			printk(KERN_ERR "atm_dev_register: "
-			    "atm_proc_dev_register failed for dev %s\n",type);
-			free_atm_dev(dev);
-			goto done;
+			       "atm_proc_dev_register failed for dev %s\n",
+			       type);
+			spin_lock(&atm_dev_lock);
+			list_del(&dev->dev_list);
+			spin_unlock(&atm_dev_lock);
+			__free_atm_dev(dev);
+			return NULL;
 		}
+	}
 #endif
 
-done:
-	spin_unlock(&atm_dev_lock);
 	return dev;
 }
 
 
 void atm_dev_deregister(struct atm_dev *dev)
 {
+	unsigned long warning_time;
+
 #ifdef CONFIG_PROC_FS
 	if (dev->ops->proc_read) atm_proc_dev_deregister(dev);
 #endif
 	spin_lock(&atm_dev_lock);
-	free_atm_dev(dev);
+	list_del(&dev->dev_list);
 	spin_unlock(&atm_dev_lock);
+
+	warning_time = jiffies;
+	while (atomic_read(&dev->refcnt) != 1) {
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(HZ / 4);
+		current->state = TASK_RUNNING;
+		if ((jiffies - warning_time) > 10 * HZ) {
+			printk(KERN_EMERG "atm_dev_deregister: waiting for "
+			       "dev %d to become free. Usage count = %d\n",
+			       dev->number, atomic_read(&dev->refcnt));
+			warning_time = jiffies;
+		}
+	}
+
+	__free_atm_dev(dev);
 }
 
 void shutdown_atm_dev(struct atm_dev *dev)
 {
-	if (dev->vccs) {
-		set_bit(ATM_DF_CLOSE,&dev->flags);
+	if (atomic_read(&dev->refcnt) > 1) {
+		set_bit(ATM_DF_CLOSE, &dev->flags);
 		return;
 	}
-	if (dev->ops->dev_close) dev->ops->dev_close(dev);
+	if (dev->ops->dev_close)
+		dev->ops->dev_close(dev);
 	atm_dev_deregister(dev);
 }
 
@@ -143,66 +184,69 @@
 	struct atm_vcc *vcc;
 
 	sk = sk_alloc(family, GFP_KERNEL, 1);
-	if (!sk) return NULL;
-	vcc = sk->protinfo.af_atm = kmalloc(sizeof(*vcc),GFP_KERNEL);
+	if (!sk)
+		return NULL;
+	vcc = sk->protinfo.af_atm = kmalloc(sizeof(*vcc), GFP_KERNEL);
 	if (!vcc) {
 		sk_free(sk);
 		return NULL;
 	}
-	sock_init_data(NULL,sk);
+	sock_init_data(NULL, sk);
 	sk->destruct = atm_free_sock;
-	memset(vcc,0,sizeof(*vcc));
+	memset(vcc, 0, sizeof(*vcc));
 	vcc->sk = sk;
-	if (nodev_vccs) nodev_vccs->prev = vcc;
-	vcc->prev = NULL;
-	vcc->next = nodev_vccs;
-	nodev_vccs = vcc;
+
 	return sk;
 }
 
 
-static void unlink_vcc(struct atm_vcc *vcc,struct atm_dev *hold_dev)
+static void unlink_vcc(struct atm_vcc *vcc)
 {
-	if (vcc->prev) vcc->prev->next = vcc->next;
-	else if (vcc->dev) vcc->dev->vccs = vcc->next;
-	    else nodev_vccs = vcc->next;
-	if (vcc->next) vcc->next->prev = vcc->prev;
-	else if (vcc->dev) vcc->dev->last = vcc->prev;
-	if (vcc->dev && vcc->dev != hold_dev && !vcc->dev->vccs &&
-	    test_bit(ATM_DF_CLOSE,&vcc->dev->flags))
-		shutdown_atm_dev(vcc->dev);
+	unsigned long flags;
+	if (vcc->dev) {
+		spin_lock_irqsave(&vcc->dev->lock, flags);
+		if (vcc->prev)
+			vcc->prev->next = vcc->next;
+		else
+			vcc->dev->vccs = vcc->next;
+
+		if (vcc->next)
+			vcc->next->prev = vcc->prev;
+		else
+			vcc->dev->last = vcc->prev;
+		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+	}
 }
 
 
+
 void free_atm_vcc_sk(struct sock *sk)
 {
-	unlink_vcc(sk->protinfo.af_atm,NULL);
+	unlink_vcc(sk->protinfo.af_atm);
 	sk_free(sk);
 }
 
 
 void bind_vcc(struct atm_vcc *vcc,struct atm_dev *dev)
 {
-	unlink_vcc(vcc,dev);
+	unsigned long flags;
+
+	unlink_vcc(vcc);
 	vcc->dev = dev;
 	if (dev) {
+		spin_lock_irqsave(&dev->lock, flags);
 		vcc->next = NULL;
 		vcc->prev = dev->last;
 		if (dev->vccs) dev->last->next = vcc;
 		else dev->vccs = vcc;
 		dev->last = vcc;
-	}
-	else {
-		if (nodev_vccs) nodev_vccs->prev = vcc;
-		vcc->next = nodev_vccs;
-		vcc->prev = NULL;
-		nodev_vccs = vcc;
+		spin_unlock_irqrestore(&dev->lock, flags);
 	}
 }
 
 
 EXPORT_SYMBOL(atm_dev_register);
 EXPORT_SYMBOL(atm_dev_deregister);
-EXPORT_SYMBOL(atm_find_dev);
+EXPORT_SYMBOL(atm_dev_lookup);
 EXPORT_SYMBOL(shutdown_atm_dev);
 EXPORT_SYMBOL(bind_vcc);
diff -Nru a/net/atm/resources.h b/net/atm/resources.h
--- a/net/atm/resources.h	Mon Jun 30 13:23:17 2003
+++ b/net/atm/resources.h	Mon Jun 30 13:23:17 2003
@@ -11,7 +11,7 @@
 
 
 extern struct list_head atm_devs;
-extern struct atm_vcc *nodev_vccs; /* VCCs not linked to any device */
+extern spinlock_t atm_dev_lock;
 
 
 struct sock *alloc_atm_vcc_sk(int family);
diff -Nru a/net/atm/signaling.c b/net/atm/signaling.c
--- a/net/atm/signaling.c	Mon Jun 30 13:23:17 2003
+++ b/net/atm/signaling.c	Mon Jun 30 13:23:17 2003
@@ -33,7 +33,6 @@
 struct atm_vcc *sigd = NULL;
 static DECLARE_WAIT_QUEUE_HEAD(sigd_sleep);
 
-extern spinlock_t atm_dev_lock;
 
 static void sigd_put_skb(struct sk_buff *skb)
 {
@@ -211,6 +210,7 @@
 
 static void sigd_close(struct atm_vcc *vcc)
 {
+	unsigned long flags;
 	struct atm_dev *dev;
 	struct list_head *p;
 
@@ -219,33 +219,29 @@
 	if (skb_peek(&vcc->sk->receive_queue))
 		printk(KERN_ERR "sigd_close: closing with requests pending\n");
 	skb_queue_purge(&vcc->sk->receive_queue);
-	purge_vccs(nodev_vccs);
 
-	spin_lock (&atm_dev_lock);
+	spin_lock(&atm_dev_lock);
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
+		spin_lock_irqsave(&dev->lock, flags);
 		purge_vccs(dev->vccs);
+		spin_unlock_irqrestore(&dev->lock, flags);
 	}
-	spin_unlock (&atm_dev_lock);
+	spin_unlock(&atm_dev_lock);
 }
 
 
 static struct atmdev_ops sigd_dev_ops = {
-	close:	sigd_close,
-	send:	sigd_send
+	.close =	sigd_close,
+	.send =		sigd_send
 };
 
 
 static struct atm_dev sigd_dev = {
-	&sigd_dev_ops,
-	NULL,		/* no PHY */
-    	"sig",		/* type */
-	999,		/* dummy device number */
-	NULL,NULL,	/* pretend not to have any VCCs */
-	NULL,NULL,	/* no data */
-	{ 0 },		/* no flags */
-	NULL,		/* no local address */
-	{ 0 }		/* no ESI, no statistics */
+	.ops =		&sigd_dev_ops,
+	.type =		"sig",
+	.number =	999,
+	.lock =		SPIN_LOCK_UNLOCKED
 };
 
 
