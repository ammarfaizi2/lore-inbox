Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVEYSZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVEYSZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVEYSZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:25:31 -0400
Received: from earth.cora.nwra.com ([65.125.157.180]:55193 "EHLO
	earth.cora.nwra.com") by vger.kernel.org with ESMTP id S262368AbVEYSHk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:07:40 -0400
Message-ID: <4294BEDF.5060005@cora.nwra.com>
Date: Wed, 25 May 2005 12:07:27 -0600
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, oakad@yahoo.com, carlos@tarkus.se
Subject: [patch 1/1] DAC_SATA_3.4.0 marvell MV88SX50xx and MV88SX60x1 sata
 driver - use include directory
Content-Type: multipart/mixed;
 boundary="------------020009070805050906040606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020009070805050906040606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is for version 3.4.0 of the Marvell SATA driver available from 
ftp://ftp.abit.com.tw/pub/download/drivers/linux/marvell/mvsata340.zip, 
which isn't part of the linux kernel, but might be of use to folks.  This 
modifies the driver to use the headers in include/scsi rather than 
drivers/scsi and facilitates easier building for me for fedora kernels 
using /lib/modules/<ver>/build.

If anyone knows of a later version of this driver floating around, I'd like 
to know.

I'd also like to express my desire to see a libata version someday and 
willingness to test.

Orion




--------------020009070805050906040606
Content-Type: text/plain;
 name="DAC_SATA-MV8-3.4.0-include.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DAC_SATA-MV8-3.4.0-include.patch"

Only in DAC-SATA-MV8-3.4.0-cora/build/Linux/DebugError: mv_sata.ko
Only in DAC-SATA-MV8-3.4.0-cora/build/Linux/DebugFull: mv_sata.ko
Only in DAC-SATA-MV8-3.4.0-cora/build/Linux/Free: mv_sata.ko
Only in DAC-SATA-MV8-3.4.0-cora/LinuxIAL: build.out
Only in DAC-SATA-MV8-3.4.0-cora/LinuxIAL: gsub.sh
Only in DAC-SATA-MV8-3.4.0-cora/LinuxIAL: Makefile
diff -cr DAC-SATA-MV8-3.4.0/LinuxIAL/Makefile_2_6 DAC-SATA-MV8-3.4.0-cora/LinuxIAL/Makefile_2_6
*** DAC-SATA-MV8-3.4.0/LinuxIAL/Makefile_2_6	2004-08-16 12:08:54.000000000 -0600
--- DAC-SATA-MV8-3.4.0-cora/LinuxIAL/Makefile_2_6	2005-05-25 08:12:08.000000000 -0600
***************
*** 4,10 ****
  IAL_OBJS        := mvLinuxIalLib.o mvLinuxIalHt.o mvLinuxIalOs.o mvIALCommon.o mvIALCommonUtils.o mvLinuxIalSmart.o
  SAL_OBJS        := mvScsiAtaLayer.o
  PWD             := $(shell pwd)
! INCLUDE_DIRS    := -I$(KERNEL_SRC)/drivers/scsi
  TARGET          := mv_sata.o
  CFLAGS          += -DDEBUG=1 $(INCLUDE_DIRS) $(CFLAGS_EXTRA) -DLINUX
  
--- 4,10 ----
  IAL_OBJS        := mvLinuxIalLib.o mvLinuxIalHt.o mvLinuxIalOs.o mvIALCommon.o mvIALCommonUtils.o mvLinuxIalSmart.o
  SAL_OBJS        := mvScsiAtaLayer.o
  PWD             := $(shell pwd)
! INCLUDE_DIRS    := -I$(KERNEL_SRC)/include
  TARGET          := mv_sata.o
  CFLAGS          += -DDEBUG=1 $(INCLUDE_DIRS) $(CFLAGS_EXTRA) -DLINUX
  
diff -cr DAC-SATA-MV8-3.4.0/LinuxIAL/mvLinuxIalHt.c DAC-SATA-MV8-3.4.0-cora/LinuxIAL/mvLinuxIalHt.c
*** DAC-SATA-MV8-3.4.0/LinuxIAL/mvLinuxIalHt.c	2004-09-07 18:56:36.000000000 -0600
--- DAC-SATA-MV8-3.4.0-cora/LinuxIAL/mvLinuxIalHt.c	2005-05-25 08:30:08.000000000 -0600
***************
*** 78,84 ****
  #include "mvIALCommon.h"
  #include "mvLinuxIalSmart.h"
  
! extern Scsi_Host_Template driver_template;
  
  static void mv_ial_init_log(void);
  
--- 78,84 ----
  #include "mvIALCommon.h"
  #include "mvLinuxIalSmart.h"
  
! extern struct scsi_host_template driver_template;
  
  static void mv_ial_init_log(void);
  
***************
*** 104,113 ****
  #define __devexit_p(x)  x
  #endif
  static void mv_ial_ht_select_queue_depths (struct Scsi_Host* pHost,
!                                            Scsi_Device* pDevs);
  
  
! static inline struct Scsi_Host *scsi_host_alloc(Scsi_Host_Template *t, size_t s)
  {
      return scsi_register(t, s);
  }
--- 104,113 ----
  #define __devexit_p(x)  x
  #endif
  static void mv_ial_ht_select_queue_depths (struct Scsi_Host* pHost,
!                                            struct scsi_device* pDevs);
  
  
! static inline struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *t, size_t s)
  {
      return scsi_register(t, s);
  }
***************
*** 121,127 ****
  
  #else
  
! static int mv_ial_ht_slave_configure (Scsi_Device* pDevs);
  static int __devinit  mv_ial_probe_device(struct pci_dev *pci_dev, const struct pci_device_id *ent);
  static void __devexit mv_ial_remove_device(struct pci_dev *pci_dev);
  
--- 121,127 ----
  
  #else
  
! static int mv_ial_ht_slave_configure (struct scsi_device* pDevs);
  static int __devinit  mv_ial_probe_device(struct pci_dev *pci_dev, const struct pci_device_id *ent);
  static void __devexit mv_ial_remove_device(struct pci_dev *pci_dev);
  
***************
*** 593,599 ****
   *  Returns:        Number of adapters installed.
   *
   ****************************************************************/
! int mv_ial_ht_detect (Scsi_Host_Template *tpnt)
  {
      int                 num_hosts=0;
      struct pci_dev      *pcidev = NULL;
--- 593,599 ----
   *  Returns:        Number of adapters installed.
   *
   ****************************************************************/
! int mv_ial_ht_detect (struct scsi_host_template *tpnt)
  {
      int                 num_hosts=0;
      struct pci_dev      *pcidev = NULL;
***************
*** 665,671 ****
      MV_U8 channel;
      MV_SATA_ADAPTER * pMvSataAdapter = &pAdapter->mvSataAdapter;
      unsigned long lock_flags;
!     Scsi_Cmnd *cmnds_done_list = NULL;
      IAL_HOST_T          *ial_host = HOSTDATA(pHost);
  
      channel = ial_host->channelIndex;
--- 665,671 ----
      MV_U8 channel;
      MV_SATA_ADAPTER * pMvSataAdapter = &pAdapter->mvSataAdapter;
      unsigned long lock_flags;
!     struct scsi_cmnd *cmnds_done_list = NULL;
      IAL_HOST_T          *ial_host = HOSTDATA(pHost);
  
      channel = ial_host->channelIndex;
***************
*** 784,790 ****
   *  Returns:        Status code.
   *
   ****************************************************************/
! int mv_ial_ht_queuecommand (Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
  {
      IAL_ADAPTER_T   *pAdapter = MV_IAL_ADAPTER(SCpnt->device->host);
      MV_SATA_ADAPTER *pMvSataAdapter;
--- 784,790 ----
   *  Returns:        Status code.
   *
   ****************************************************************/
! int mv_ial_ht_queuecommand (struct scsi_cmnd * SCpnt, void (*done) (struct scsi_cmnd *))
  {
      IAL_ADAPTER_T   *pAdapter = MV_IAL_ADAPTER(SCpnt->device->host);
      MV_SATA_ADAPTER *pMvSataAdapter;
***************
*** 799,805 ****
      unsigned int prd_size;
      unsigned long lock_flags;
  
!     Scsi_Cmnd   *cmnds_done_list = NULL;
  
      mvLogMsg(MV_IAL_LOG_ID, MV_DEBUG, " :queuecommand host=%d, bus=%d, channel=%d\n",
               SCpnt->device->host->host_no,
--- 799,805 ----
      unsigned int prd_size;
      unsigned long lock_flags;
  
!     struct scsi_cmnd   *cmnds_done_list = NULL;
  
      mvLogMsg(MV_IAL_LOG_ID, MV_DEBUG, " :queuecommand host=%d, bus=%d, channel=%d\n",
               SCpnt->device->host->host_no,
***************
*** 957,963 ****
   *  Returns:        Status code.
   *
   ****************************************************************/
! int mv_ial_ht_bus_reset (Scsi_Cmnd *SCpnt)
  {
      IAL_ADAPTER_T   *pAdapter = MV_IAL_ADAPTER(SCpnt->device->host);
      MV_SATA_ADAPTER *pMvSataAdapter = &pAdapter->mvSataAdapter;
--- 957,963 ----
   *  Returns:        Status code.
   *
   ****************************************************************/
! int mv_ial_ht_bus_reset (struct scsi_cmnd *SCpnt)
  {
      IAL_ADAPTER_T   *pAdapter = MV_IAL_ADAPTER(SCpnt->device->host);
      MV_SATA_ADAPTER *pMvSataAdapter = &pAdapter->mvSataAdapter;
***************
*** 1320,1330 ****
  
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
  
! static int mv_ial_ht_slave_configure (Scsi_Device* pDevs)
  {
      IAL_HOST_T *pHost = HOSTDATA (pDevs->host);
      struct Scsi_Host* scsiHost = pDevs->host;
!     Scsi_Device*    pDevice = NULL;
      mvLogMsg(MV_IAL_LOG_ID, MV_DEBUG, "[%d]: slave configure\n",
                          pHost->pAdapter->mvSataAdapter.adapterId);
      shost_for_each_device(pDevice, scsiHost)
--- 1320,1330 ----
  
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
  
! static int mv_ial_ht_slave_configure (struct scsi_device* pDevs)
  {
      IAL_HOST_T *pHost = HOSTDATA (pDevs->host);
      struct Scsi_Host* scsiHost = pDevs->host;
!     struct scsi_device*    pDevice = NULL;
      mvLogMsg(MV_IAL_LOG_ID, MV_DEBUG, "[%d]: slave configure\n",
                          pHost->pAdapter->mvSataAdapter.adapterId);
      shost_for_each_device(pDevice, scsiHost)
***************
*** 1340,1349 ****
  }
  #else
  static void mv_ial_ht_select_queue_depths (struct Scsi_Host* pHost,
!                                            Scsi_Device* pDevs)
  {
      IAL_HOST_T *ial_host = HOSTDATA (pHost);
!     Scsi_Device* pDevice;
      if (ial_host != NULL && ial_host->queueDepth > 0)
      {
          mvLogMsg(MV_IAL_LOG_ID, MV_DEBUG, "[%d %d]: adjust queue depth to %d\n",
--- 1340,1349 ----
  }
  #else
  static void mv_ial_ht_select_queue_depths (struct Scsi_Host* pHost,
!                                            struct scsi_device* pDevs)
  {
      IAL_HOST_T *ial_host = HOSTDATA (pHost);
!     struct scsi_device* pDevice;
      if (ial_host != NULL && ial_host->queueDepth > 0)
      {
          mvLogMsg(MV_IAL_LOG_ID, MV_DEBUG, "[%d %d]: adjust queue depth to %d\n",
***************
*** 1371,1377 ****
  }
  #endif
  
! int mv_ial_ht_abort(Scsi_Cmnd *SCpnt)
  {
      IAL_ADAPTER_T   *pAdapter;
      IAL_HOST_T      *pHost;
--- 1371,1377 ----
  }
  #endif
  
! int mv_ial_ht_abort(struct scsi_cmnd *SCpnt)
  {
      IAL_ADAPTER_T   *pAdapter;
      IAL_HOST_T      *pHost;
***************
*** 1379,1385 ****
      MV_SATA_ADAPTER *pMvSataAdapter;
      MV_U8           channel;
      unsigned long lock_flags;
!     Scsi_Cmnd *cmnds_done_list = NULL;
  
      mvLogMsg(MV_IAL_LOG_ID, MV_DEBUG, "abort command %p\n", SCpnt);
      if (SCpnt == NULL)
--- 1379,1385 ----
      MV_SATA_ADAPTER *pMvSataAdapter;
      MV_U8           channel;
      unsigned long lock_flags;
!     struct scsi_cmnd *cmnds_done_list = NULL;
  
      mvLogMsg(MV_IAL_LOG_ID, MV_DEBUG, "abort command %p\n", SCpnt);
      if (SCpnt == NULL)
***************
*** 1431,1437 ****
  }
  
  
! Scsi_Host_Template driver_template = mvSata;
  
  MODULE_LICENSE("Marvell");
  MODULE_DESCRIPTION("Marvell Serial ATA PCI-X Adapter");
--- 1431,1437 ----
  }
  
  
! struct scsi_host_template driver_template = mvSata;
  
  MODULE_LICENSE("Marvell");
  MODULE_DESCRIPTION("Marvell Serial ATA PCI-X Adapter");
diff -cr DAC-SATA-MV8-3.4.0/LinuxIAL/mvLinuxIalHt.h DAC-SATA-MV8-3.4.0-cora/LinuxIAL/mvLinuxIalHt.h
*** DAC-SATA-MV8-3.4.0/LinuxIAL/mvLinuxIalHt.h	2004-08-24 22:04:14.000000000 -0600
--- DAC-SATA-MV8-3.4.0-cora/LinuxIAL/mvLinuxIalHt.h	2005-05-25 11:40:02.585540599 -0600
***************
*** 42,51 ****
  #include <scsi/scsi.h>
  #include <scsi/scsi_cmnd.h>
  #include <scsi/scsi_device.h>
  #include <scsi/scsi_host.h>
  #include <scsi/scsi_tcq.h>
- //#include "scsi_typedefs.h"
- #include "scsi.h"
  #else
  #include <linux/blk.h>
  #include "scsi.h"
--- 42,50 ----
  #include <scsi/scsi.h>
  #include <scsi/scsi_cmnd.h>
  #include <scsi/scsi_device.h>
+ #include <scsi/scsi_eh.h>
  #include <scsi/scsi_host.h>
  #include <scsi/scsi_tcq.h>
  #else
  #include <linux/blk.h>
  #include "scsi.h"
***************
*** 65,76 ****
  
  /* Interfaces to the midlevel Linux SCSI driver */
  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
! extern int mv_ial_ht_detect (Scsi_Host_Template *);
  #endif
  extern int mv_ial_ht_release (struct Scsi_Host *);
! extern int mv_ial_ht_queuecommand (Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
! extern int mv_ial_ht_bus_reset (Scsi_Cmnd *);
! extern int mv_ial_ht_abort(Scsi_Cmnd *SCpnt);
  
  #define HOSTDATA(host) ((IAL_HOST_T *)&host->hostdata)
  #define MV_IAL_ADAPTER(host) (HOSTDATA(host)->pAdapter)
--- 64,75 ----
  
  /* Interfaces to the midlevel Linux SCSI driver */
  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
! extern int mv_ial_ht_detect (struct scsi_host_template *);
  #endif
  extern int mv_ial_ht_release (struct Scsi_Host *);
! extern int mv_ial_ht_queuecommand (struct scsi_cmnd *, void (*done) (struct scsi_cmnd *));
! extern int mv_ial_ht_bus_reset (struct scsi_cmnd *);
! extern int mv_ial_ht_abort(struct scsi_cmnd *SCpnt);
  
  #define HOSTDATA(host) ((IAL_HOST_T *)&host->hostdata)
  #define MV_IAL_ADAPTER(host) (HOSTDATA(host)->pAdapter)
***************
*** 178,184 ****
      void  *prdPool[MV_SATA_SW_QUEUE_SIZE];
      void  *prdPoolAligned[MV_SATA_SW_QUEUE_SIZE];
      MV_U32  freePRDsNum;
!     Scsi_Cmnd *scsi_cmnd_done_head, *scsi_cmnd_done_tail;
      MV_BOOLEAN  hostBlocked;
  } IAL_HOST_T;
  
--- 177,183 ----
      void  *prdPool[MV_SATA_SW_QUEUE_SIZE];
      void  *prdPoolAligned[MV_SATA_SW_QUEUE_SIZE];
      MV_U32  freePRDsNum;
!     struct scsi_cmnd *scsi_cmnd_done_head, *scsi_cmnd_done_tail;
      MV_BOOLEAN  hostBlocked;
  } IAL_HOST_T;
  
***************
*** 193,206 ****
  /* UDMA command completion info */
  struct mv_comp_info
  {
!     Scsi_Cmnd           *SCpnt;
      MV_SATA_EDMA_PRD_ENTRY  *cpu_PRDpnt;
      dma_addr_t      dma_PRDpnt;
      dma_addr_t      single_buff_busaddr;
      unsigned int        allocated_entries;
      unsigned int        seq_number;
      MV_SATA_SCSI_CMD_BLOCK  *pSALBlock;
!     Scsi_Cmnd           *next_done;
  };
  
  
--- 192,205 ----
  /* UDMA command completion info */
  struct mv_comp_info
  {
!     struct scsi_cmnd           *SCpnt;
      MV_SATA_EDMA_PRD_ENTRY  *cpu_PRDpnt;
      dma_addr_t      dma_PRDpnt;
      dma_addr_t      single_buff_busaddr;
      unsigned int        allocated_entries;
      unsigned int        seq_number;
      MV_SATA_SCSI_CMD_BLOCK  *pSALBlock;
!     struct scsi_cmnd           *next_done;
  };
  
  
diff -cr DAC-SATA-MV8-3.4.0/LinuxIAL/mvLinuxIalLib.c DAC-SATA-MV8-3.4.0-cora/LinuxIAL/mvLinuxIalLib.c
*** DAC-SATA-MV8-3.4.0/LinuxIAL/mvLinuxIalLib.c	2004-09-01 19:53:02.000000000 -0600
--- DAC-SATA-MV8-3.4.0-cora/LinuxIAL/mvLinuxIalLib.c	2005-05-25 11:39:21.122782674 -0600
***************
*** 160,166 ****
   ******************************************************************************/
  void mv_ial_lib_add_done_queue (struct IALAdapter *pAdapter,
                                  MV_U8 channel,
!                                 Scsi_Cmnd   *scsi_cmnd)
  {
      /* Put new command in the tail of the queue and make it point to NULL */
      ((struct mv_comp_info *)(&scsi_cmnd->SCp))->next_done = NULL;
--- 160,166 ----
   ******************************************************************************/
  void mv_ial_lib_add_done_queue (struct IALAdapter *pAdapter,
                                  MV_U8 channel,
!                                 struct scsi_cmnd   *scsi_cmnd)
  {
      /* Put new command in the tail of the queue and make it point to NULL */
      ((struct mv_comp_info *)(&scsi_cmnd->SCp))->next_done = NULL;
***************
*** 197,207 ****
   *
   *  Return Value:   Pointer to first scsi command in chain
   ******************************************************************************/
! Scsi_Cmnd * mv_ial_lib_get_first_cmnd (struct IALAdapter *pAdapter, MV_U8 channel)
  {
      if (pAdapter->host[channel] != NULL)
      {
!     Scsi_Cmnd *cmnd = pAdapter->host[channel]->scsi_cmnd_done_head;
      pAdapter->host[channel]->scsi_cmnd_done_head = NULL;
      pAdapter->host[channel]->scsi_cmnd_done_tail = NULL;
      return cmnd;
--- 197,207 ----
   *
   *  Return Value:   Pointer to first scsi command in chain
   ******************************************************************************/
! struct scsi_cmnd * mv_ial_lib_get_first_cmnd (struct IALAdapter *pAdapter, MV_U8 channel)
  {
      if (pAdapter->host[channel] != NULL)
      {
!     struct scsi_cmnd *cmnd = pAdapter->host[channel]->scsi_cmnd_done_head;
      pAdapter->host[channel]->scsi_cmnd_done_head = NULL;
      pAdapter->host[channel]->scsi_cmnd_done_tail = NULL;
      return cmnd;
***************
*** 219,230 ****
   *  Parameters:     cmnd - First command in scsi commands chain
   *
   ******************************************************************************/
! void mv_ial_lib_do_done (Scsi_Cmnd *cmnd)
  {
      /* Call done function for all commands in queue */
      while (cmnd)
      {
!         Scsi_Cmnd *temp;
          temp = ((struct mv_comp_info *)(&cmnd->SCp))->next_done;
  
          if (cmnd->scsi_done == NULL)
--- 219,230 ----
   *  Parameters:     cmnd - First command in scsi commands chain
   *
   ******************************************************************************/
! void mv_ial_lib_do_done (struct scsi_cmnd *cmnd)
  {
      /* Call done function for all commands in queue */
      while (cmnd)
      {
!         struct scsi_cmnd *temp;
          temp = ((struct mv_comp_info *)(&cmnd->SCp))->next_done;
  
          if (cmnd->scsi_done == NULL)
***************
*** 362,368 ****
      IAL_ADAPTER_T       *pAdapter;
      unsigned long       flags;
      int                 handled = 0;
!     Scsi_Cmnd *cmnds_done_list = NULL;
      pAdapter = (IAL_ADAPTER_T *)dev_id;
  
  /*
--- 362,368 ----
      IAL_ADAPTER_T       *pAdapter;
      unsigned long       flags;
      int                 handled = 0;
!     struct scsi_cmnd *cmnds_done_list = NULL;
      pAdapter = (IAL_ADAPTER_T *)dev_id;
  
  /*
***************
*** 512,518 ****
  }
  
  /* map to pci */
! int mv_ial_lib_generate_prd(MV_SATA_ADAPTER *pMvSataAdapter, Scsi_Cmnd *SCpnt,
                              MV_SATA_EDMA_PRD_ENTRY **ppPRD_table,
                              dma_addr_t *pPRD_dma_address,
                              unsigned int *pPrd_size, dma_addr_t *pBusaddr)
--- 512,518 ----
  }
  
  /* map to pci */
! int mv_ial_lib_generate_prd(MV_SATA_ADAPTER *pMvSataAdapter, struct scsi_cmnd *SCpnt,
                              MV_SATA_EDMA_PRD_ENTRY **ppPRD_table,
                              dma_addr_t *pPRD_dma_address,
                              unsigned int *pPrd_size, dma_addr_t *pBusaddr)
***************
*** 851,857 ****
  {
      struct rescan_wrapper* rescan = (struct rescan_wrapper*)data;
      struct Scsi_Host *host;
!     Scsi_Device *sdev = NULL;
      MV_U16 target;
      if (rescan->pAdapter->host[rescan->channelIndex] == NULL)
      {
--- 851,857 ----
  {
      struct rescan_wrapper* rescan = (struct rescan_wrapper*)data;
      struct Scsi_Host *host;
!     struct scsi_device *sdev = NULL;
      MV_U16 target;
      if (rescan->pAdapter->host[rescan->channelIndex] == NULL)
      {
***************
*** 962,968 ****
  {
      IAL_ADAPTER_T   *pAdapter = (IAL_ADAPTER_T *)data;
      unsigned long       flags;
!     Scsi_Cmnd *cmnds_done_list = NULL;
      MV_U8 i;
  
      spin_lock_irqsave(&pAdapter->adapter_lock, flags);
--- 962,968 ----
  {
      IAL_ADAPTER_T   *pAdapter = (IAL_ADAPTER_T *)data;
      unsigned long       flags;
!     struct scsi_cmnd *cmnds_done_list = NULL;
      MV_U8 i;
  
      spin_lock_irqsave(&pAdapter->adapter_lock, flags);
***************
*** 1147,1153 ****
  MV_BOOLEAN IALCompletion(struct mvSataAdapter *pSataAdapter,
                           MV_SATA_SCSI_CMD_BLOCK *pCmdBlock)
  {
!     Scsi_Cmnd   *SCpnt = (Scsi_Cmnd *)pCmdBlock->IALData;
      struct mv_comp_info *pInfo = ( struct mv_comp_info *) &(SCpnt->SCp);
      MV_U8       host_status;
  
--- 1147,1153 ----
  MV_BOOLEAN IALCompletion(struct mvSataAdapter *pSataAdapter,
                           MV_SATA_SCSI_CMD_BLOCK *pCmdBlock)
  {
!     struct scsi_cmnd   *SCpnt = (struct scsi_cmnd *)pCmdBlock->IALData;
      struct mv_comp_info *pInfo = ( struct mv_comp_info *) &(SCpnt->SCp);
      MV_U8       host_status;
  
diff -cr DAC-SATA-MV8-3.4.0/LinuxIAL/mvLinuxIalLib.h DAC-SATA-MV8-3.4.0-cora/LinuxIAL/mvLinuxIalLib.h
*** DAC-SATA-MV8-3.4.0/LinuxIAL/mvLinuxIalLib.h	2004-08-29 12:46:12.000000000 -0600
--- DAC-SATA-MV8-3.4.0-cora/LinuxIAL/mvLinuxIalLib.h	2005-05-25 08:18:53.000000000 -0600
***************
*** 61,67 ****
  
  
  
! int mv_ial_lib_generate_prd(MV_SATA_ADAPTER *pMvSataAdapter, Scsi_Cmnd *SCpnt,
                              MV_SATA_EDMA_PRD_ENTRY **ppPRD_table,
                              dma_addr_t *pPRD_dma_address,
                              unsigned int *pPrd_size, dma_addr_t *pBusaddr);
--- 61,67 ----
  
  
  
! int mv_ial_lib_generate_prd(MV_SATA_ADAPTER *pMvSataAdapter, struct scsi_cmnd *SCpnt,
                              MV_SATA_EDMA_PRD_ENTRY **ppPRD_table,
                              dma_addr_t *pPRD_dma_address,
                              unsigned int *pPrd_size, dma_addr_t *pBusaddr);
***************
*** 87,98 ****
  /* SCSI done queuing and callback */
  void mv_ial_lib_add_done_queue (struct IALAdapter *pAdapter,
                                  MV_U8 channel,
!                                 Scsi_Cmnd   *scsi_cmnd);
  
! Scsi_Cmnd * mv_ial_lib_get_first_cmnd (struct IALAdapter *pAdapter,
                                         MV_U8 channel);
  
! void mv_ial_lib_do_done (Scsi_Cmnd *cmnd);
  
  void mv_ial_block_requests(struct IALAdapter *pAdapter, MV_U8 channelIndex);
  
--- 87,98 ----
  /* SCSI done queuing and callback */
  void mv_ial_lib_add_done_queue (struct IALAdapter *pAdapter,
                                  MV_U8 channel,
!                                 struct scsi_cmnd   *scsi_cmnd);
  
! struct scsi_cmnd * mv_ial_lib_get_first_cmnd (struct IALAdapter *pAdapter,
                                         MV_U8 channel);
  
! void mv_ial_lib_do_done (struct scsi_cmnd *cmnd);
  
  void mv_ial_block_requests(struct IALAdapter *pAdapter, MV_U8 channelIndex);
  
Only in DAC-SATA-MV8-3.4.0/LinuxIAL: mv_sata.mod.c
Only in DAC-SATA-MV8-3.4.0-cora/LinuxIAL/.tmp_versions: mv_sata.mod

--------------020009070805050906040606--
