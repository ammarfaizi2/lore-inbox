Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVGVOsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVGVOsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 10:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVGVOsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 10:48:10 -0400
Received: from ns2.suse.de ([195.135.220.15]:64433 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262104AbVGVOsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 10:48:07 -0400
Date: Fri, 22 Jul 2005 16:48:05 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] turn many #if $undefined_string into #ifdef $undefined_string
Message-ID: <20050722144805.GA26977@suse.de>
References: <20050721190209.GA13633@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050721190209.GA13633@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


turn many #if $undefined_string into #ifdef $undefined_string
to fix some warnings after -Wno-def was added to global CFLAGS

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/ppc64/kernel/udbg.c             |    2 +-
 arch/um/drivers/cow.h                |    4 ++--
 arch/um/kernel/skas/syscall_user.c   |    4 ++--
 arch/um/os-Linux/elf_aux.c           |    1 +
 arch/x86_64/ia32/ia32_aout.c         |    6 +++---
 arch/x86_64/kernel/smpboot.c         |   10 +++++-----
 drivers/block/sx8.c                  |    4 ++--
 drivers/cdrom/mcdx.c                 |    8 ++++----
 drivers/char/drm/drm_pci.c           |   10 +++++-----
 drivers/char/rio/rioboot.c           |   12 ++++++------
 drivers/char/rio/rioroute.c          |    2 +-
 drivers/char/rio/riotable.c          |    2 +-
 drivers/ieee1394/sbp2.c              |    1 +
 drivers/isdn/hisax/l3dss1.c          |    8 ++++----
 drivers/md/bitmap.c                  |    8 ++++----
 drivers/mtd/devices/docecc.c         |    1 +
 drivers/net/8139too.c                |    6 +++---
 drivers/net/amd8111e.c               |    2 +-
 drivers/net/ne.c                     |    4 ++--
 drivers/scsi/NCR53c406a.c            |    4 ++--
 drivers/scsi/aic7xxx/aic79xx_osm.c   |    2 +-
 drivers/scsi/aic7xxx/aic79xx_pci.c   |    2 +-
 drivers/scsi/dpt/dptsig.h            |    4 ++--
 drivers/scsi/dtc.c                   |    4 ----
 drivers/scsi/dtc.h                   |    4 ++++
 drivers/scsi/initio.c                |    2 +-
 drivers/scsi/lpfc/lpfc_compat.h      |    3 ++-
 drivers/scsi/lpfc/lpfc_scsi.h        |    3 ++-
 drivers/scsi/pas16.c                 |    1 +
 drivers/scsi/sym53c8xx_2/sym_hipd.h  |   16 ++++++++++------
 drivers/scsi/sym53c8xx_2/sym_nvram.c |    2 +-
 drivers/scsi/t128.h                  |    1 +
 fs/ntfs/sysctl.h                     |    2 +-
 include/linux/ftape.h                |    2 +-
 net/ipv6/ip6_output.c                |    7 +------
 sound/isa/sb/sb_mixer.c              |    4 ++--
 sound/oss/pss.c                      |    2 +-
 sound/pci/rme9652/rme9652.c          |    2 +-
 38 files changed, 84 insertions(+), 78 deletions(-)

Index: linux-2.6.13-rc3-git4/arch/ppc64/kernel/udbg.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/arch/ppc64/kernel/udbg.c
+++ linux-2.6.13-rc3-git4/arch/ppc64/kernel/udbg.c
@@ -141,7 +141,7 @@ void udbg_init_scc(struct device_node *n
 
 #endif /* CONFIG_PPC_PMAC */
 
-#if CONFIG_PPC_PMAC
+#ifdef CONFIG_PPC_PMAC
 static void udbg_real_putc(unsigned char c)
 {
 	while ((real_readb(sccc) & SCC_TXRDY) == 0)
Index: linux-2.6.13-rc3-git4/arch/um/drivers/cow.h
===================================================================
--- linux-2.6.13-rc3-git4.orig/arch/um/drivers/cow.h
+++ linux-2.6.13-rc3-git4/arch/um/drivers/cow.h
@@ -3,10 +3,10 @@
 
 #include <asm/types.h>
 
-#if __BYTE_ORDER == __BIG_ENDIAN
+#if defined(__BIG_ENDIAN)
 # define ntohll(x) (x)
 # define htonll(x) (x)
-#elif __BYTE_ORDER == __LITTLE_ENDIAN
+#elif defined(__LITTLE_ENDIAN)
 # define ntohll(x)  bswap_64(x)
 # define htonll(x)  bswap_64(x)
 #else
Index: linux-2.6.13-rc3-git4/arch/um/kernel/skas/syscall_user.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/arch/um/kernel/skas/syscall_user.c
+++ linux-2.6.13-rc3-git4/arch/um/kernel/skas/syscall_user.c
@@ -15,7 +15,7 @@
 void handle_syscall(union uml_pt_regs *regs)
 {
 	long result;
-#if UML_CONFIG_SYSCALL_DEBUG
+#ifdef UML_CONFIG_SYSCALL_DEBUG
   	int index;
 
   	index = record_syscall_start(UPT_SYSCALL_NR(regs));
@@ -27,7 +27,7 @@ void handle_syscall(union uml_pt_regs *r
 	REGS_SET_SYSCALL_RETURN(regs->skas.regs, result);
 
 	syscall_trace(regs, 1);
-#if UML_CONFIG_SYSCALL_DEBUG
+#ifdef UML_CONFIG_SYSCALL_DEBUG
   	record_syscall_end(index, result);
 #endif
 }
Index: linux-2.6.13-rc3-git4/arch/um/os-Linux/elf_aux.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/arch/um/os-Linux/elf_aux.c
+++ linux-2.6.13-rc3-git4/arch/um/os-Linux/elf_aux.c
@@ -11,6 +11,7 @@
 #include <stddef.h>
 #include "init.h"
 #include "elf_user.h"
+#include <asm/elf.h>
 
 #if ELF_CLASS == ELFCLASS32
 typedef Elf32_auxv_t elf_auxv_t;
Index: linux-2.6.13-rc3-git4/arch/x86_64/ia32/ia32_aout.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/arch/x86_64/ia32/ia32_aout.c
+++ linux-2.6.13-rc3-git4/arch/x86_64/ia32/ia32_aout.c
@@ -42,7 +42,7 @@ extern int ia32_setup_arg_pages(struct l
 static int load_aout_binary(struct linux_binprm *, struct pt_regs * regs);
 static int load_aout_library(struct file*);
 
-#if CORE_DUMP
+#ifdef CORE_DUMP
 static int aout_core_dump(long signr, struct pt_regs * regs, struct file *file);
 
 /*
@@ -103,7 +103,7 @@ static struct linux_binfmt aout_format =
 	.module		= THIS_MODULE,
 	.load_binary	= load_aout_binary,
 	.load_shlib	= load_aout_library,
-#if CORE_DUMP
+#ifdef CORE_DUMP
 	.core_dump	= aout_core_dump,
 #endif
 	.min_coredump	= PAGE_SIZE
@@ -120,7 +120,7 @@ static void set_brk(unsigned long start,
 	up_write(&current->mm->mmap_sem);
 }
 
-#if CORE_DUMP
+#ifdef CORE_DUMP
 /*
  * These are the only things you should do on a core-file: use only these
  * macros to write out all the necessary info.
Index: linux-2.6.13-rc3-git4/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/arch/x86_64/kernel/smpboot.c
+++ linux-2.6.13-rc3-git4/arch/x86_64/kernel/smpboot.c
@@ -285,7 +285,7 @@ static __cpuinit void sync_tsc(void)
 	int i, done = 0;
 	long delta, adj, adjust_latency = 0;
 	unsigned long flags, rt, master_time_stamp, bound;
-#if DEBUG_TSC_SYNC
+#ifdef DEBUG_TSC_SYNC
 	static struct syncdebug {
 		long rt;	/* roundtrip time */
 		long master;	/* master's timestamp */
@@ -321,7 +321,7 @@ static __cpuinit void sync_tsc(void)
 				rdtscll(t);
 				wrmsrl(MSR_IA32_TSC, t + adj);
 			}
-#if DEBUG_TSC_SYNC
+#ifdef DEBUG_TSC_SYNC
 			t[i].rt = rt;
 			t[i].master = master_time_stamp;
 			t[i].diff = delta;
@@ -331,7 +331,7 @@ static __cpuinit void sync_tsc(void)
 	}
 	spin_unlock_irqrestore(&tsc_sync_lock, flags);
 
-#if DEBUG_TSC_SYNC
+#ifdef DEBUG_TSC_SYNC
 	for (i = 0; i < NUM_ROUNDS; ++i)
 		printk("rt=%5ld master=%5ld diff=%5ld adjlat=%5ld\n",
 		       t[i].rt, t[i].master, t[i].diff, t[i].lat);
@@ -537,7 +537,7 @@ void __cpuinit start_secondary(void)
 extern volatile unsigned long init_rsp;
 extern void (*initial_code)(void);
 
-#if APIC_DEBUG
+#ifdef APIC_DEBUG
 static void inquire_remote_apic(int apicid)
 {
 	unsigned i, regs[] = { APIC_ID >> 4, APIC_LVR >> 4, APIC_SPIV >> 4 };
@@ -841,7 +841,7 @@ do_rest:
 			else
 				/* trampoline code not run */
 				printk("Not responding.\n");
-#if APIC_DEBUG
+#ifdef APIC_DEBUG
 			inquire_remote_apic(apicid);
 #endif
 		}
Index: linux-2.6.13-rc3-git4/drivers/block/sx8.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/block/sx8.c
+++ linux-2.6.13-rc3-git4/drivers/block/sx8.c
@@ -1582,7 +1582,7 @@ static int carm_init_one (struct pci_dev
 	if (rc)
 		goto err_out;
 
-#if IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
+#ifdef IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
 	rc = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
 	if (!rc) {
 		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
@@ -1601,7 +1601,7 @@ static int carm_init_one (struct pci_dev
 			goto err_out_regions;
 		}
 		pci_dac = 0;
-#if IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
+#ifdef IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
 	}
 #endif
 
Index: linux-2.6.13-rc3-git4/drivers/cdrom/mcdx.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/cdrom/mcdx.c
+++ linux-2.6.13-rc3-git4/drivers/cdrom/mcdx.c
@@ -51,7 +51,7 @@
  */
 
 
-#if RCS
+#ifdef RCS
 static const char *mcdx_c_version
     = "$Id: mcdx.c,v 1.21 1997/01/26 07:12:59 davem Exp $";
 #endif
@@ -706,7 +706,7 @@ static int mcdx_open(struct cdrom_device
 		xtrace(OPENCLOSE, "open() init irq generation\n");
 		if (-1 == mcdx_config(stuffp, 1))
 			return -EIO;
-#if FALLBACK
+#ifdef FALLBACK
 		/* Set the read speed */
 		xwarn("AAA %x AAA\n", stuffp->readcmd);
 		if (stuffp->readerrs)
@@ -1216,7 +1216,7 @@ static int __init mcdx_init_drive(int dr
 	}
 
 
-#if WE_KNOW_WHY
+#ifdef WE_KNOW_WHY
 	/* irq 11 -> channel register */
 	outb(0x50, stuffp->wreg_chn);
 #endif
@@ -1294,7 +1294,7 @@ static int mcdx_transfer(struct s_drive_
 
 	ans = mcdx_xfer(stuffp, p, sector, nr_sectors);
 	return ans;
-#if FALLBACK
+#ifdef FALLBACK
 	if (-1 == ans)
 		stuffp->readerrs++;
 	else
Index: linux-2.6.13-rc3-git4/drivers/char/drm/drm_pci.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/char/drm/drm_pci.c
+++ linux-2.6.13-rc3-git4/drivers/char/drm/drm_pci.c
@@ -50,7 +50,7 @@ void *drm_pci_alloc(drm_device_t * dev, 
 		    dma_addr_t maxaddr, dma_addr_t * busaddr)
 {
 	void *address;
-#if DRM_DEBUG_MEMORY
+#ifdef DRM_DEBUG_MEMORY
 	int area = DRM_MEM_DMA;
 
 	spin_lock(&drm_mem_lock);
@@ -76,7 +76,7 @@ void *drm_pci_alloc(drm_device_t * dev, 
 
 	address = pci_alloc_consistent(dev->pdev, size, busaddr);
 
-#if DRM_DEBUG_MEMORY
+#ifdef DRM_DEBUG_MEMORY
 	if (address == NULL) {
 		spin_lock(&drm_mem_lock);
 		++drm_mem_stats[area].fail_count;
@@ -106,21 +106,21 @@ EXPORT_SYMBOL(drm_pci_alloc);
 void
 drm_pci_free(drm_device_t * dev, size_t size, void *vaddr, dma_addr_t busaddr)
 {
-#if DRM_DEBUG_MEMORY
+#ifdef DRM_DEBUG_MEMORY
 	int area = DRM_MEM_DMA;
 	int alloc_count;
 	int free_count;
 #endif
 
 	if (!vaddr) {
-#if DRM_DEBUG_MEMORY
+#ifdef DRM_DEBUG_MEMORY
 		DRM_MEM_ERROR(area, "Attempt to free address 0\n");
 #endif
 	} else {
 		pci_free_consistent(dev->pdev, size, vaddr, busaddr);
 	}
 
-#if DRM_DEBUG_MEMORY
+#ifdef DRM_DEBUG_MEMORY
 	spin_lock(&drm_mem_lock);
 	free_count = ++drm_mem_stats[area].free_count;
 	alloc_count = drm_mem_stats[area].succeed_count;
Index: linux-2.6.13-rc3-git4/drivers/char/rio/rioboot.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/char/rio/rioboot.c
+++ linux-2.6.13-rc3-git4/drivers/char/rio/rioboot.c
@@ -902,7 +902,7 @@ static int RIOBootComplete( struct rio_i
 	       (HostP->Mapping[entry].RtaUniqueNum==RtaUniq))
 	    {
 	        HostP->Mapping[entry].Flags |= RTA_BOOTED|RTA_NEWBOOT;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 		RIO_SV_BROADCAST(HostP->svFlags[entry]);
 #endif
 		if ( (sysport=HostP->Mapping[entry].SysPort) != NO_PORT )
@@ -918,7 +918,7 @@ static int RIOBootComplete( struct rio_i
 		   {
 			entry2 = HostP->Mapping[entry].ID2 - 1;
 			HostP->Mapping[entry2].Flags |= RTA_BOOTED|RTA_NEWBOOT;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 			RIO_SV_BROADCAST(HostP->svFlags[entry2]);
 #endif
 			sysport = HostP->Mapping[entry2].SysPort;
@@ -1143,7 +1143,7 @@ static int RIOBootComplete( struct rio_i
 		    CCOPY( MapP->Name, HostP->Mapping[entry].Name, MAX_NAME_LEN );
 		    HostP->Mapping[entry].Flags =
 		     SLOT_IN_USE | RTA_BOOTED | RTA_NEWBOOT;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 		    RIO_SV_BROADCAST(HostP->svFlags[entry]);
 #endif
 		    RIOReMapPorts( p, HostP, &HostP->Mapping[entry] );
@@ -1159,7 +1159,7 @@ static int RIOBootComplete( struct rio_i
    "This RTA has a tentative entry on another host - delete that entry (1)\n");
 		    HostP->Mapping[entry].Flags =
 		     SLOT_TENTATIVE | RTA_BOOTED | RTA_NEWBOOT;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 		    RIO_SV_BROADCAST(HostP->svFlags[entry]);
 #endif
 		}
@@ -1169,7 +1169,7 @@ static int RIOBootComplete( struct rio_i
 		    {
 			HostP->Mapping[entry2].Flags = SLOT_IN_USE |
 			 RTA_BOOTED | RTA_NEWBOOT | RTA16_SECOND_SLOT;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 			RIO_SV_BROADCAST(HostP->svFlags[entry2]);
 #endif
 			HostP->Mapping[entry2].SysPort = MapP2->SysPort;
@@ -1188,7 +1188,7 @@ static int RIOBootComplete( struct rio_i
 		    else
 			HostP->Mapping[entry2].Flags = SLOT_TENTATIVE |
 			 RTA_BOOTED | RTA_NEWBOOT | RTA16_SECOND_SLOT;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 			RIO_SV_BROADCAST(HostP->svFlags[entry2]);
 #endif
 		    bzero( (caddr_t)MapP2, sizeof(struct Map) );
Index: linux-2.6.13-rc3-git4/drivers/char/rio/rioroute.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/char/rio/rioroute.c
+++ linux-2.6.13-rc3-git4/drivers/char/rio/rioroute.c
@@ -1023,7 +1023,7 @@ RIOFreeDisconnected(struct rio_info *p, 
     if (link < LINKS_PER_UNIT)
 	    return 1;
 
-#if NEED_TO_FIX_THIS
+#ifdef NEED_TO_FIX_THIS
     /* Ok so all the links are disconnected. But we may have only just
     ** made this slot tentative and not yet received a topology update.
     ** Lets check how long ago we made it tentative.
Index: linux-2.6.13-rc3-git4/drivers/char/rio/riotable.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/char/rio/riotable.c
+++ linux-2.6.13-rc3-git4/drivers/char/rio/riotable.c
@@ -771,7 +771,7 @@ int RIOAssignRta( struct rio_info *p, st
 	    if ((MapP->Flags & RTA16_SECOND_SLOT) == 0)
 	      CCOPY( MapP->Name, HostMapP->Name, MAX_NAME_LEN );
 	    HostMapP->Flags = SLOT_IN_USE | RTA_BOOTED;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 	    RIO_SV_BROADCAST(p->RIOHosts[host].svFlags[MapP->ID-1]);
 #endif
 	    if (MapP->Flags & RTA16_SECOND_SLOT)
Index: linux-2.6.13-rc3-git4/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/ieee1394/sbp2.c
+++ linux-2.6.13-rc3-git4/drivers/ieee1394/sbp2.c
@@ -169,6 +169,7 @@ MODULE_DEVICE_TABLE(ieee1394, sbp2_id_ta
  * Debug levels, configured via kernel config, or enable here.
  */
 
+#define CONFIG_IEEE1394_SBP2_DEBUG 0
 /* #define CONFIG_IEEE1394_SBP2_DEBUG_ORBS */
 /* #define CONFIG_IEEE1394_SBP2_DEBUG_DMA */
 /* #define CONFIG_IEEE1394_SBP2_DEBUG 1 */
Index: linux-2.6.13-rc3-git4/drivers/isdn/hisax/l3dss1.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/isdn/hisax/l3dss1.c
+++ linux-2.6.13-rc3-git4/drivers/isdn/hisax/l3dss1.c
@@ -353,7 +353,7 @@ l3dss1_parse_facility(struct PStack *st,
 			         { l3dss1_dummy_invoke(st, cr, id, ident, p, nlen);
                                    return;
                                  } 
-#if HISAX_DE_AOC
+#ifdef HISAX_DE_AOC
 			{
 
 #define FOO1(s,a,b) \
@@ -977,7 +977,7 @@ l3dss1_release_cmpl(struct l3_process *p
 	dss1_release_l3_process(pc);
 }
 
-#if EXT_BEARER_CAPS
+#ifdef EXT_BEARER_CAPS
 
 static u_char *
 EncodeASyncParams(u_char * p, u_char si2)
@@ -1369,7 +1369,7 @@ l3dss1_setup_req(struct l3_process *pc, 
 				*p++ = *sub++ & 0x7f;
 		}
         }
-#if EXT_BEARER_CAPS
+#ifdef EXT_BEARER_CAPS
 	if ((pc->para.setup.si2 >= 160) && (pc->para.setup.si2 <= 175)) {	// sync. Bitratenadaption, V.110/X.30
 
 		*p++ = IE_LLC;
@@ -1609,7 +1609,7 @@ l3dss1_setup(struct l3_process *pc, u_ch
 				case 0x08: /* Unrestricted digital information */
 					pc->para.setup.si1 = 7;
 /* JIM, 05.11.97 I wanna set service indicator 2 */
-#if EXT_BEARER_CAPS
+#ifdef EXT_BEARER_CAPS
 					pc->para.setup.si2 = DecodeSI2(skb);
 #endif
 					break;
Index: linux-2.6.13-rc3-git4/drivers/md/bitmap.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/md/bitmap.c
+++ linux-2.6.13-rc3-git4/drivers/md/bitmap.c
@@ -108,7 +108,7 @@ static unsigned char *bitmap_alloc_page(
 {
 	unsigned char *page;
 
-#if INJECT_FAULTS_1
+#ifdef INJECT_FAULTS_1
 	page = NULL;
 #else
 	page = kmalloc(PAGE_SIZE, GFP_NOIO);
@@ -843,7 +843,7 @@ static int bitmap_init_from_disk(struct 
 
 	BUG_ON(!file && !bitmap->offset);
 
-#if INJECT_FAULTS_3
+#ifdef INJECT_FAULTS_3
 	outofdate = 1;
 #else
 	outofdate = bitmap->flags & BITMAP_STALE;
@@ -1187,7 +1187,7 @@ static int bitmap_start_daemon(struct bi
 
 	spin_unlock_irqrestore(&bitmap->lock, flags);
 
-#if INJECT_FATAL_FAULT_2
+#ifdef INJECT_FATAL_FAULT_2
 	daemon = NULL;
 #else
 	sprintf(namebuf, "%%s_%s", name);
@@ -1552,7 +1552,7 @@ int bitmap_create(mddev_t *mddev)
 
 	bitmap->syncchunk = ~0UL;
 
-#if INJECT_FATAL_FAULT_1
+#ifdef INJECT_FATAL_FAULT_1
 	bitmap->bp = NULL;
 #else
 	bitmap->bp = kmalloc(pages * sizeof(*bitmap->bp), GFP_KERNEL);
Index: linux-2.6.13-rc3-git4/drivers/mtd/devices/docecc.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/mtd/devices/docecc.c
+++ linux-2.6.13-rc3-git4/drivers/mtd/devices/docecc.c
@@ -40,6 +40,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/doc2000.h>
 
+#define DEBUG 0
 /* need to undef it (from asm/termbits.h) */
 #undef B0
 
Index: linux-2.6.13-rc3-git4/drivers/net/8139too.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/net/8139too.c
+++ linux-2.6.13-rc3-git4/drivers/net/8139too.c
@@ -126,14 +126,14 @@
 #define USE_IO_OPS 1
 #endif
 
-/* define to 1 to enable copious debugging info */
-#undef RTL8139_DEBUG
+/* define to 1, 2 or 3 to enable copious debugging info */
+#define RTL8139_DEBUG 0
 
 /* define to 1 to disable lightweight runtime debugging checks */
 #undef RTL8139_NDEBUG
 
 
-#ifdef RTL8139_DEBUG
+#if RTL8139_DEBUG
 /* note: prints function name for you */
 #  define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
 #else
Index: linux-2.6.13-rc3-git4/drivers/net/amd8111e.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/net/amd8111e.c
+++ linux-2.6.13-rc3-git4/drivers/net/amd8111e.c
@@ -1290,7 +1290,7 @@ static irqreturn_t amd8111e_interrupt(in
 	writel(intr0, mmio + INT0);
 
 	/* Check if Receive Interrupt has occurred. */
-#if CONFIG_AMD8111E_NAPI
+#ifdef CONFIG_AMD8111E_NAPI
 	if(intr0 & RINT0){
 		if(netif_rx_schedule_prep(dev)){
 			/* Disable receive interupts */
Index: linux-2.6.13-rc3-git4/drivers/net/ne.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/net/ne.c
+++ linux-2.6.13-rc3-git4/drivers/net/ne.c
@@ -129,9 +129,9 @@ bad_clone_list[] __initdata = {
 #define NESM_START_PG	0x40	/* First page of TX buffer */
 #define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
 
-#ifdef CONFIG_PLAT_MAPPI
+#if defined(CONFIG_PLAT_MAPPI)
 #  define DCR_VAL 0x4b
-#elif CONFIG_PLAT_OAKS32R
+#elif defined(CONFIG_PLAT_OAKS32R)
 #  define DCR_VAL 0x48
 #else
 #  define DCR_VAL 0x49
Index: linux-2.6.13-rc3-git4/drivers/scsi/NCR53c406a.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/NCR53c406a.c
+++ linux-2.6.13-rc3-git4/drivers/scsi/NCR53c406a.c
@@ -182,13 +182,13 @@ static int irq_probe(void);
 static void *bios_base;
 #endif
 
-#if PORT_BASE
+#ifdef PORT_BASE
 static int port_base = PORT_BASE;
 #else
 static int port_base;
 #endif
 
-#if IRQ_LEV
+#ifdef IRQ_LEV
 static int irq_level = IRQ_LEV;
 #else
 static int irq_level = -1;	/* 0 is 'no irq', so use -1 for 'uninitialized' */
Index: linux-2.6.13-rc3-git4/drivers/scsi/aic7xxx/aic79xx_osm.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ linux-2.6.13-rc3-git4/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -1505,7 +1505,7 @@ ahd_linux_dev_reset(Scsi_Cmnd *cmd)
 	memset(recovery_cmd, 0, sizeof(struct scsi_cmnd));
 	recovery_cmd->device = cmd->device;
 	recovery_cmd->scsi_done = ahd_linux_dev_reset_complete;
-#if AHD_DEBUG
+#ifdef AHD_DEBUG
 	if ((ahd_debug & AHD_SHOW_RECOVERY) != 0)
 		printf("%s:%d:%d:%d: Device reset called for cmd %p\n",
 		       ahd_name(ahd), cmd->device->channel, cmd->device->id,
Index: linux-2.6.13-rc3-git4/drivers/scsi/aic7xxx/aic79xx_pci.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/aic7xxx/aic79xx_pci.c
+++ linux-2.6.13-rc3-git4/drivers/scsi/aic7xxx/aic79xx_pci.c
@@ -582,7 +582,7 @@ ahd_check_extport(struct ahd_softc *ahd)
 		}
 	}
 
-#if AHD_DEBUG
+#ifdef AHD_DEBUG
 	if (have_seeprom != 0
 	 && (ahd_debug & AHD_DUMP_SEEPROM) != 0) {
 		uint16_t *sc_data;
Index: linux-2.6.13-rc3-git4/drivers/scsi/dpt/dptsig.h
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/dpt/dptsig.h
+++ linux-2.6.13-rc3-git4/drivers/scsi/dpt/dptsig.h
@@ -76,7 +76,7 @@ typedef unsigned long sigLONG;
 #endif  /* aix */
 #endif
 /* For the Macintosh */
-#if STRUCTALIGNMENTSUPPORTED
+#ifdef STRUCTALIGNMENTSUPPORTED
 #pragma options align=mac68k
 #endif
 
@@ -332,7 +332,7 @@ typedef struct dpt_sig {
 #endif  /* aix */
 #endif
 /* For the Macintosh */
-#if STRUCTALIGNMENTSUPPORTED
+#ifdef STRUCTALIGNMENTSUPPORTED
 #pragma options align=reset
 #endif
 
Index: linux-2.6.13-rc3-git4/drivers/scsi/dtc.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/dtc.c
+++ linux-2.6.13-rc3-git4/drivers/scsi/dtc.c
@@ -92,10 +92,6 @@
 
 #define DTC_PUBLIC_RELEASE 2
 
-/*#define DTCDEBUG 0x1*/
-#define DTCDEBUG_INIT	0x1
-#define DTCDEBUG_TRANSFER 0x2
-
 /*
  * The DTC3180 & 3280 boards are memory mapped.
  * 
Index: linux-2.6.13-rc3-git4/drivers/scsi/dtc.h
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/dtc.h
+++ linux-2.6.13-rc3-git4/drivers/scsi/dtc.h
@@ -28,6 +28,10 @@
 #ifndef DTC3280_H
 #define DTC3280_H
 
+#define DTCDEBUG 0
+#define DTCDEBUG_INIT	0x1
+#define DTCDEBUG_TRANSFER 0x2
+
 static int dtc_abort(Scsi_Cmnd *);
 static int dtc_biosparam(struct scsi_device *, struct block_device *,
 		         sector_t, int*);
Index: linux-2.6.13-rc3-git4/drivers/scsi/initio.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/initio.c
+++ linux-2.6.13-rc3-git4/drivers/scsi/initio.c
@@ -716,7 +716,7 @@ static int init_tulip(HCS * pCurHcb, SCB
 	pCurHcb->HCS_SCSI_ID = i91unvramp->NVM_SCSIInfo[0].NVM_ChSCSIID;
 	pCurHcb->HCS_IdMask = ~(1 << pCurHcb->HCS_SCSI_ID);
 
-#if CHK_PARITY
+#ifdef CHK_PARITY
 	/* Enable parity error response */
 	TUL_WR(pCurHcb->HCS_Base + TUL_PCMD, TUL_RD(pCurHcb->HCS_Base, TUL_PCMD) | 0x40);
 #endif
Index: linux-2.6.13-rc3-git4/drivers/scsi/lpfc/lpfc_compat.h
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/lpfc/lpfc_compat.h
+++ linux-2.6.13-rc3-git4/drivers/scsi/lpfc/lpfc_compat.h
@@ -32,8 +32,9 @@ memcpy_toio() and memcpy_fromio() can be
 However on a big-endian host, copy 4 bytes at a time,
 using writel() and readl().
  *******************************************************************/
+#include <asm/byteorder.h>
 
-#if __BIG_ENDIAN
+#ifdef __BIG_ENDIAN
 
 static inline void
 lpfc_memcpy_to_slim(void __iomem *dest, void *src, unsigned int bytes)
Index: linux-2.6.13-rc3-git4/drivers/scsi/lpfc/lpfc_scsi.h
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/lpfc/lpfc_scsi.h
+++ linux-2.6.13-rc3-git4/drivers/scsi/lpfc/lpfc_scsi.h
@@ -21,6 +21,7 @@
 /*
  * $Id: lpfc_scsi.h 1.83 2005/04/07 08:47:43EDT sf_support Exp  $
  */
+#include <asm/byteorder.h>
 
 struct lpfc_hba;
 
@@ -85,7 +86,7 @@ struct fcp_cmnd {
 	/* # of bits to shift lun id to end up in right
 	 * payload word, little endian = 8, big = 16.
 	 */
-#if __BIG_ENDIAN
+#ifdef __BIG_ENDIAN
 #define FC_LUN_SHIFT         16
 #define FC_ADDR_MODE_SHIFT   24
 #else	/*  __LITTLE_ENDIAN */
Index: linux-2.6.13-rc3-git4/drivers/scsi/pas16.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/pas16.c
+++ linux-2.6.13-rc3-git4/drivers/scsi/pas16.c
@@ -2,6 +2,7 @@
 #define PSEUDO_DMA
 #define FOO
 #define UNSAFE  /* Not unsafe for PAS16 -- use it */
+#define PDEBUG 0
 
 /*
  * This driver adapted from Drew Eckhardt's Trantor T128 driver
Index: linux-2.6.13-rc3-git4/drivers/scsi/sym53c8xx_2/sym_hipd.h
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/sym53c8xx_2/sym_hipd.h
+++ linux-2.6.13-rc3-git4/drivers/scsi/sym53c8xx_2/sym_hipd.h
@@ -151,6 +151,16 @@
  */
 #define	SYM_CONF_MIN_ASYNC (40)
 
+
+/*
+ * MEMORY ALLOCATOR.
+ */
+
+#define SYM_MEM_WARN	1	/* Warn on failed operations */
+
+#define SYM_MEM_PAGE_ORDER 0	/* 1 PAGE  maximum */
+#define SYM_MEM_CLUSTER_SHIFT	(PAGE_SHIFT+SYM_MEM_PAGE_ORDER)
+#define SYM_MEM_FREE_UNUSED	/* Free unused pages immediately */
 /*
  *  Shortest memory chunk is (1<<SYM_MEM_SHIFT), currently 16.
  *  Actual allocations happen as SYM_MEM_CLUSTER_SIZE sized.
@@ -1192,12 +1202,6 @@ static inline void sym_setup_data_pointe
  *  MEMORY ALLOCATOR.
  */
 
-#define SYM_MEM_PAGE_ORDER 0	/* 1 PAGE  maximum */
-#define SYM_MEM_CLUSTER_SHIFT	(PAGE_SHIFT+SYM_MEM_PAGE_ORDER)
-#define SYM_MEM_FREE_UNUSED	/* Free unused pages immediately */
-
-#define SYM_MEM_WARN	1	/* Warn on failed operations */
-
 #define sym_get_mem_cluster()	\
 	(void *) __get_free_pages(GFP_ATOMIC, SYM_MEM_PAGE_ORDER)
 #define sym_free_mem_cluster(p)	\
Index: linux-2.6.13-rc3-git4/drivers/scsi/sym53c8xx_2/sym_nvram.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/sym53c8xx_2/sym_nvram.c
+++ linux-2.6.13-rc3-git4/drivers/scsi/sym53c8xx_2/sym_nvram.c
@@ -367,7 +367,7 @@ static void S24C16_read_byte(struct sym_
 	S24C16_write_ack(np, ack_data, gpreg, gpcntl);
 }
 
-#if SYM_CONF_NVRAM_WRITE_SUPPORT
+#ifdef SYM_CONF_NVRAM_WRITE_SUPPORT
 /*
  *  Write 'len' bytes starting at 'offset'.
  */
Index: linux-2.6.13-rc3-git4/drivers/scsi/t128.h
===================================================================
--- linux-2.6.13-rc3-git4.orig/drivers/scsi/t128.h
+++ linux-2.6.13-rc3-git4/drivers/scsi/t128.h
@@ -43,6 +43,7 @@
 
 #define T128_PUBLIC_RELEASE 3
 
+#define TDEBUG		0
 #define TDEBUG_INIT	0x1
 #define TDEBUG_TRANSFER 0x2
 
Index: linux-2.6.13-rc3-git4/fs/ntfs/sysctl.h
===================================================================
--- linux-2.6.13-rc3-git4.orig/fs/ntfs/sysctl.h
+++ linux-2.6.13-rc3-git4/fs/ntfs/sysctl.h
@@ -26,7 +26,7 @@
 
 #include <linux/config.h>
 
-#if (DEBUG && CONFIG_SYSCTL)
+#if defined(DEBUG) && defined(CONFIG_SYSCTL)
 
 extern int ntfs_sysctl(int add);
 
Index: linux-2.6.13-rc3-git4/include/linux/ftape.h
===================================================================
--- linux-2.6.13-rc3-git4.orig/include/linux/ftape.h
+++ linux-2.6.13-rc3-git4/include/linux/ftape.h
@@ -165,7 +165,7 @@ typedef union {
 #  undef  CONFIG_FT_FDC_DMA
 #  define CONFIG_FT_FDC_DMA 2
 # endif
-#elif CONFIG_FT_ALT_FDC == 1  /* CONFIG_FT_MACH2 */
+#elif defined(CONFIG_FT_ALT_FDC)  /* CONFIG_FT_MACH2 */
 # if CONFIG_FT_FDC_BASE == 0
 #  undef  CONFIG_FT_FDC_BASE
 #  define CONFIG_FT_FDC_BASE 0x370
Index: linux-2.6.13-rc3-git4/net/ipv6/ip6_output.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/net/ipv6/ip6_output.c
+++ linux-2.6.13-rc3-git4/net/ipv6/ip6_output.c
@@ -792,13 +792,8 @@ int ip6_dst_lookup(struct sock *sk, stru
 	if (ipv6_addr_any(&fl->fl6_src)) {
 		err = ipv6_get_saddr(*dst, &fl->fl6_dst, &fl->fl6_src);
 
-		if (err) {
-#if IP6_DEBUG >= 2
-			printk(KERN_DEBUG "ip6_dst_lookup: "
-			       "no available source address\n");
-#endif
+		if (err)
 			goto out_err_release;
-		}
 	}
 
 	return 0;
Index: linux-2.6.13-rc3-git4/sound/isa/sb/sb_mixer.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/sound/isa/sb/sb_mixer.c
+++ linux-2.6.13-rc3-git4/sound/isa/sb/sb_mixer.c
@@ -688,7 +688,7 @@ static struct sbmix_elem snd_als4000_ctl
 	SB_SINGLE("3D PowerOff Switch", SB_ALS4000_3D_TIME_DELAY, 4, 0x01);
 static struct sbmix_elem snd_als4000_ctl_3d_delay =
 	SB_SINGLE("3D Delay", SB_ALS4000_3D_TIME_DELAY, 0, 0x0f);
-#if NOT_AVAILABLE
+#ifdef NOT_AVAILABLE
 static struct sbmix_elem snd_als4000_ctl_fmdac =
 	SB_SINGLE("FMDAC Switch (Option ?)", SB_ALS4000_FMDAC, 0, 0x01);
 static struct sbmix_elem snd_als4000_ctl_qsound =
@@ -723,7 +723,7 @@ static struct sbmix_elem *snd_als4000_co
 	&snd_als4000_ctl_3d_output_ratio,
 	&snd_als4000_ctl_3d_delay,
 	&snd_als4000_ctl_3d_poweroff_switch,
-#if NOT_AVAILABLE
+#ifdef NOT_AVAILABLE
 	&snd_als4000_ctl_fmdac,
 	&snd_als4000_ctl_qsound,
 #endif
Index: linux-2.6.13-rc3-git4/sound/oss/pss.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/sound/oss/pss.c
+++ linux-2.6.13-rc3-git4/sound/oss/pss.c
@@ -714,7 +714,7 @@ static int __init attach_pss(struct addr
 	 
 	disable_all_emulations();
 
-#if YOU_REALLY_WANT_TO_ALLOCATE_THESE_RESOURCES
+#ifdef YOU_REALLY_WANT_TO_ALLOCATE_THESE_RESOURCES
 	if (sound_alloc_dma(hw_config->dma, "PSS"))
 	{
 		printk("pss.c: Can't allocate DMA channel.\n");
Index: linux-2.6.13-rc3-git4/sound/pci/rme9652/rme9652.c
===================================================================
--- linux-2.6.13-rc3-git4.orig/sound/pci/rme9652/rme9652.c
+++ linux-2.6.13-rc3-git4/sound/pci/rme9652/rme9652.c
@@ -1470,7 +1470,7 @@ static int snd_rme9652_get_tc_valid(snd_
 	return 0;
 }
 
-#if ALSA_HAS_STANDARD_WAY_OF_RETURNING_TIMECODE
+#ifdef ALSA_HAS_STANDARD_WAY_OF_RETURNING_TIMECODE
 
 /* FIXME: this routine needs a port to the new control API --jk */
 
