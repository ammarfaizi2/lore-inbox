Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWCUQAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWCUQAJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWCUQAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:00:09 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:6823 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751444AbWCUQAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:00:07 -0500
Subject: [GIT PATCH] pending SCSI updates for post 2.6.16
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Mar 2006 09:59:55 -0600
Message-Id: <1142956795.4377.19.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the set of all the changes I've accumulated since 2.6.16 went
-rc.  I'm afraid its pretty hefty (another qla firmware update ... but
at least the built in firmware is now deprecated and we're moving to the
firmware loader interface)

The patch is available from

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git

The short changelog is:

adam radford:
  o 3ware 9000 add big endian support

Adrian Bunk:
  o sim710: fix a NULL pointer dereference
  o ibmmca: fix a NULL pointer dereference
  o dmx3191d: fix a NULL pointer dereference
  o NCR_D700: fix a NULL dereference
  o drivers/message/fusion/mptfc.c: make 2 functions static

Al Viro:
  o scsi_lib: fix recognition of cache type of Initio SBP-2 bridges

Alan Stern:
  o Recognize missing LUNs for non-standard devices

Alexey Dobriyan:
  o drivers/scsi/FlashPoint.c: don't use parenthesis with "return"
  o drivers/scsi/FlashPoint.c: Lindent
  o drivers/scsi/FlashPoint.c: untypedef struct SCCBcard
  o drivers/scsi/FlashPoint.c: untypedef struct NVRAMInfo
  o drivers/scsi/FlashPoint.c: untypedef struct SCCBMgr_tar_info
  o drivers/scsi/FlashPoint.c: untypedef struct SCCBMgr_info
  o drivers/scsi/FlashPoint.c: untypedef struct _SCCB
  o drivers/scsi/FlashPoint.c: use standard fixed size types
  o drivers/scsi/FlashPoint.c: remove ushort_ptr
  o drivers/scsi/FlashPoint.c: remove ULONG
  o drivers/scsi/FlashPoint.c: remove UINT
  o drivers/scsi/FlashPoint.c: remove USHORT
  o drivers/scsi/FlashPoint.c: remove UCHAR
  o drivers/scsi/FlashPoint.c: remove trivial wrappers
  o drivers/scsi/FlashPoint.c: remove unused things

Andrew Morton:
  o cciss: kfree(NULL) is legal

Andrew Vasquez:
  o qla2xxx: update MAINTAINERS
  o qla2xxx: Firmware updates
  o qla2xxx: Remove legacy ISP6312 firmware loader
  o qla2xxx: Correct FCAL login retry logic for ISP24xx
  o qla2xxx: Further restrict ZIO mode support
  o qla2xxx: Add VPD sysfs attribute
  o qla2xxx: Correct swing/emphasis settings on ISP24xx
  o qla2xxx: NVRAM id-list updates
  o qla2xxx: Consolidate ISP63xx handling
  o qla2xxx: Add ISP54xx support
  o qla2xxx: Convert IS_QLA*() defines to bit-operations

Brian King:
  o scsi: Handle device_add failure in scsi_alloc_target

Christoph Hellwig:
  o megaraid_sas: fix extended timeout handling
  o qla2xxx: use kthread_ API
  o aic7xxx: semaphore to completion conversion
  o aacraid: use kthread_ API
  o sas: add support for enclosure and bad ID rphy attributes
  o mptsas: add support for enclosure and bay identifier attributes

Dave Jones:
  o fix two leaks in scsi_alloc_sdev failure paths

Eric Moore:
  o fusion - bump version
  o fusion - expander hotplug suport in mptsas module
  o fusion - exposing raid components in mptsas
  o fusion - memory leak, and initializing fields
  o fusion - exclosure misspelled
  o fusion - cleanup mptsas event handling functions
  o fusion - removing target_id/bus_id from the VirtDevice structure
  o fusion - static fix's
  o fusion - move some debug firmware event debug msgs to verbose level
  o fusion - loginfo header update
  o drivers/base/bus.c - export reprobe
  o fusion - mptlan - remove wierd humor print

Greg Kroah-Hartman:
  o Remove devfs support from the SCSI subsystem

Hannes Reinecke:
  o aic79xx: Avoid renegotiation on inquiry
  o aic79xx: use BIOS settings
  o aic79xx: Invalid Sequencer interrupt occured
  o aic79xx: Update error recovery
  o aic79xx: Remove dead code
  o aic79xx: use tcq functions
  o aic79xx: remove qfrozen

James Bottomley:
  o eliminate rphy allocation in favour of expander/end device allocation
  o convert mptsas over to end_device/expander allocations
  o allow displaying and setting of cache type via sysfs
  o add scsi_mode_select to scsi_lib.c
  o add scsi_reprobe_device
  o Merge ../linux-2.6
  o add preliminary expander support to the sas transport class
  o mptscsih: remove unused page 1 setting function
  o fix minor problem in spi transport message functions
  o add missing transport_container_unregister in sas class
  o sr: partial revert of 24669f75a3231fa37444977c92d1f4838bec1233
  o lpfc: minor syntax fixes
  o [PATCH] convert aic94xx over to using the sas transport end device
  o make some sas class properties optional
  o add 6.0 Gbit phy definitions to the sas transport class
  o mptspi: Add transport class Domain Validation
  o fix scsi process problems and clean up the target reap issues
  o add execute_in_process_context() API
  o Add EXPORT_SYMBOL for spi msg functions

James Smart:
  o FC transport : Avoid device offline cases by stalling aborts until device unblocked
  o lpfc 8.1.4 : Change version number to 8.1.4
  o lpfc 8.1.4 : Two misc fixes
  o lpfc 8.1.4 : Introduce lpfc_reset_barrier() function for resets on dual channel adapters
  o lpfc 8.1.4 : Fixed a timer panic due to timer firing after freeing ndlp
  o lpfc 8.1.4 : Fixed RSCN handling when a PLOGI is in retry
  o lpfc 8.1.4 : Fix Discovery processing for NPorts that change their NPortId on the fly

Jamie Wellnitz:
  o [PATCH] lpfc 8.1.3: Change version number to 8.1.3
  o [PATCH] lpfc 8.1.3: Fix polling mode panic
  o [PATCH] lpfc 8.1.3: Protect NPL lists with host lock
  o [PATCH] lpfc 8.1.3: Fix deadlock in lpfc_fdmi_tmo_handler
  o [PATCH] lpfc 8.1.3: Fix performance when using multiple SLI rings
  o [PATCH] lpfc 8.1.3: Remove unused MBhostaddr from lpfc_sli structure
  o [PATCH] lpfc 8.1.3: PCI hrd_type should be obtained with pci_read_config_byte() macro
  o [PATCH] lpfc 8.1.3: Derive supported speeds from LMT field in the READ_CONFIG
  o lpfc 8.1.2: Change version number to 8.1.2
  o lpfc 8.1.2: Modify RSCN handling to unregister rpis on lost FCP_TARGETs immediately
  o lpfc 8.1.2: Fix panic caused by HBA resets and target side cable pulls
  o lpfc 8.1.2: Fixed module parameter descriptions
  o lpfc 8.1.2: Code cleanup of lpfc_mbx_cmpl_config_link
  o lpfc 8.1.2: Allow turning on internal loop-back mode
  o lpfc 8.1.2: Code style changes for Discovery code
  o lpfc 8.1.2: Make lpfc_els_rsp_rps_acc and lpfc_els_rsp_rpl_acc static
  o lpfc 8.1.2: Added support for FAN
  o lpfc 8.1.2: Add ERROR and WARM_START modes for diagnostic purposes
  o lpfc 8.1.2: Remove hba_list from struct lpfc_hba
  o lpfc 8.1.2: Correct use of the hostdata field in scsi_host
  o lpfc 8.1.2: Misc FC Discovery changes
  o lpfc 8.1.2: Add module parameter to limit number of outstanding commands per lpfc HBA
  o lpfc 8.1.2: Fixed a double insertion of mail box object to the SLI mailbox list
  o lpfc 8.1.2: Fixed system panic in lpfc_sli_brdreset during dynamic add of LP11K
  o lpfc 8.1.2: Explicitly initialize the skip_post argument to lpfc_sli_send_reset
  o lpfc 8.1.2: Fixed a race condition in the PLOGI retry logic
  o lpfc 8.1.2: Handling of ELS commands RRQ, RPS, RPL and LIRR correctly
  o lpfc 8.1.2: Remove unused SLI_IOCB_HIGH_PRIORITY
  o lpfc 8.1.2: Remove unreferenced cfg_fcp_bind_method from struct lpfc_hba
  o lpfc 8.1.2: Remove unused prototypes from lpfc_crtn.h

Jes Sorensen:
  o core kmalloc2kzalloc

Linas Vepstas:
  o PCI Error Recovery: IPR SCSI device driver

Matthew Wilcox:
  o Missing names from SPI3, SPI4 and SPI5
  o Improve message printing code
  o Make spi_print_msg more consistent
  o Add spi_populate_*_msg functions
  o ncr53c8xx update
  o unused show_spi_transport_period_helper parameter
  o fix uninitialized variable error
  o Neaten comments in scsi_cmnd.h

Mike Anderson:
  o scsi: move target_destroy call

Mike Christie:
  o don't call ips_eh_reset in ips_queue to avoid deadlock

Ralf B�hle:
  o Make sgiwd93_detect and sgiwd93_detect static
  o wd33c93: Fix missing prototypes by including <linux/interrupt.h>
  o jazz_esp: Fix sparse warnings
  o jazz_esp: Delete useless prototype

Rene Herman:
  o MODULE_ALIAS_{BLOCK,CHAR}DEV_MAJOR for drivers/scsi

Vasily Averin:
  o i2o: fix memory leak in i2o_exec_lct_modified

Willem Riede:
  o osst: changes required to move forward to block request

And the diffstat:

 b/MAINTAINERS                              |    2 
 b/drivers/base/bus.c                       |   22 
 b/drivers/block/cciss.c                    |    3 
 b/drivers/message/fusion/Kconfig           |    1 
 b/drivers/message/fusion/Makefile          |    1 
 b/drivers/message/fusion/lsi/mpi_log_sas.h |  105 
 b/drivers/message/fusion/mptbase.c         |  205 
 b/drivers/message/fusion/mptbase.h         |   36 
 b/drivers/message/fusion/mptctl.c          |    8 
 b/drivers/message/fusion/mptfc.c           |   39 
 b/drivers/message/fusion/mptlan.c          |    5 
 b/drivers/message/fusion/mptsas.c          |  818 -
 b/drivers/message/fusion/mptscsih.c        | 2516 ---
 b/drivers/message/fusion/mptscsih.h        |   12 
 b/drivers/message/fusion/mptspi.c          |  735 -
 b/drivers/message/i2o/exec-osm.c           |   21 
 b/drivers/scsi/3w-9xxx.c                   |  138 
 b/drivers/scsi/3w-9xxx.h                   |   18 
 b/drivers/scsi/53c700.c                    |   18 
 b/drivers/scsi/FlashPoint.c                | 9787 ++++++-------
 b/drivers/scsi/NCR_D700.c                  |    2 
 b/drivers/scsi/aacraid/aacraid.h           |    5 
 b/drivers/scsi/aacraid/comminit.c          |    1 
 b/drivers/scsi/aacraid/commsup.c           |   14 
 b/drivers/scsi/aacraid/linit.c             |   14 
 b/drivers/scsi/aha152x.c                   |    7 
 b/drivers/scsi/aic7xxx/aic79xx_core.c      |   33 
 b/drivers/scsi/aic7xxx/aic79xx_osm.c       |  559 
 b/drivers/scsi/aic7xxx/aic79xx_osm.h       |    7 
 b/drivers/scsi/aic7xxx/aic7xxx_core.c      |   24 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.c       |   45 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.h       |    5 
 b/drivers/scsi/ch.c                        |    1 
 b/drivers/scsi/dmx3191d.c                  |    2 
 b/drivers/scsi/hosts.c                     |    3 
 b/drivers/scsi/ibmmca.c                    |    3 
 b/drivers/scsi/ipr.c                       |  109 
 b/drivers/scsi/ips.c                       |    2 
 b/drivers/scsi/jazz_esp.c                  |   19 
 b/drivers/scsi/lpfc/lpfc.h                 |   41 
 b/drivers/scsi/lpfc/lpfc_attr.c            |  164 
 b/drivers/scsi/lpfc/lpfc_crtn.h            |   37 
 b/drivers/scsi/lpfc/lpfc_ct.c              |   74 
 b/drivers/scsi/lpfc/lpfc_disc.h            |   19 
 b/drivers/scsi/lpfc/lpfc_els.c             | 1012 -
 b/drivers/scsi/lpfc/lpfc_hbadisc.c         |  571 
 b/drivers/scsi/lpfc/lpfc_hw.h              |   65 
 b/drivers/scsi/lpfc/lpfc_init.c            |  265 
 b/drivers/scsi/lpfc/lpfc_mbox.c            |   33 
 b/drivers/scsi/lpfc/lpfc_nportdisc.c       |  391 
 b/drivers/scsi/lpfc/lpfc_scsi.c            |   25 
 b/drivers/scsi/lpfc/lpfc_scsi.h            |    5 
 b/drivers/scsi/lpfc/lpfc_sli.c             |  470 
 b/drivers/scsi/lpfc/lpfc_sli.h             |    5 
 b/drivers/scsi/lpfc/lpfc_version.h         |    6 
 b/drivers/scsi/megaraid/megaraid_sas.c     |   26 
 b/drivers/scsi/ncr53c8xx.c                 |  127 
 b/drivers/scsi/ncr53c8xx.h                 |   37 
 b/drivers/scsi/osst.c                      |  532 
 b/drivers/scsi/osst.h                      |   12 
 b/drivers/scsi/qla2xxx/Kconfig             |   31 
 b/drivers/scsi/qla2xxx/Makefile            |    2 
 b/drivers/scsi/qla2xxx/ql2300.c            |   12 
 b/drivers/scsi/qla2xxx/ql2300_fw.c         |14624 ++++++++++----------
 b/drivers/scsi/qla2xxx/ql2322.c            |   12 
 b/drivers/scsi/qla2xxx/ql2322_fw.c         |14135 +++++++++----------
 b/drivers/scsi/qla2xxx/ql2400.c            |   27 
 b/drivers/scsi/qla2xxx/ql2400_fw.c         |20826 ++++++++++++++---------------
 b/drivers/scsi/qla2xxx/qla_attr.c          |   82 
 b/drivers/scsi/qla2xxx/qla_def.h           |  126 
 b/drivers/scsi/qla2xxx/qla_devtbl.h        |  219 
 b/drivers/scsi/qla2xxx/qla_fw.h            |    2 
 b/drivers/scsi/qla2xxx/qla_gbl.h           |    7 
 b/drivers/scsi/qla2xxx/qla_gs.c            |   10 
 b/drivers/scsi/qla2xxx/qla_init.c          |   39 
 b/drivers/scsi/qla2xxx/qla_inline.h        |    2 
 b/drivers/scsi/qla2xxx/qla_iocb.c          |    6 
 b/drivers/scsi/qla2xxx/qla_isr.c           |   23 
 b/drivers/scsi/qla2xxx/qla_mbx.c           |   63 
 b/drivers/scsi/qla2xxx/qla_os.c            |  165 
 b/drivers/scsi/qla2xxx/qla_sup.c           |    9 
 b/drivers/scsi/scsi.c                      |    6 
 b/drivers/scsi/scsi_debug.c                |    9 
 b/drivers/scsi/scsi_error.c                |    9 
 b/drivers/scsi/scsi_ioctl.c                |    3 
 b/drivers/scsi/scsi_lib.c                  |  157 
 b/drivers/scsi/scsi_scan.c                 |  106 
 b/drivers/scsi/scsi_sysfs.c                |    4 
 b/drivers/scsi/scsi_transport_fc.c         |   46 
 b/drivers/scsi/scsi_transport_iscsi.c      |    3 
 b/drivers/scsi/scsi_transport_sas.c        |  412 
 b/drivers/scsi/scsi_transport_spi.c        |  109 
 b/drivers/scsi/sd.c                        |  172 
 b/drivers/scsi/sg.c                        |   18 
 b/drivers/scsi/sgiwd93.c                   |    4 
 b/drivers/scsi/sim710.c                    |    2 
 b/drivers/scsi/sr.c                        |    9 
 b/drivers/scsi/st.c                        |   32 
 b/drivers/scsi/sym53c8xx_2/sym_hipd.c      |   53 
 b/drivers/scsi/wd33c93.c                   |    2 
 b/include/linux/device.h                   |    1 
 b/include/linux/pci_ids.h                  |    2 
 b/include/linux/workqueue.h                |    6 
 b/include/scsi/scsi.h                      |    2 
 b/include/scsi/scsi_cmnd.h                 |   20 
 b/include/scsi/scsi_device.h               |   26 
 b/include/scsi/scsi_host.h                 |   14 
 b/include/scsi/scsi_transport.h            |   11 
 b/include/scsi/scsi_transport_sas.h        |   50 
 b/include/scsi/scsi_transport_spi.h        |    4 
 b/kernel/workqueue.c                       |   29 
 drivers/scsi/qla2xxx/ql6312.c              |  101 
 drivers/scsi/qla2xxx/ql6312_fw.c           | 7078 ---------
 113 files changed, 35502 insertions(+), 42682 deletions(-)

James


