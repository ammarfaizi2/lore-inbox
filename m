Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTJXWpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTJXWpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:45:51 -0400
Received: from mail0.lsil.com ([147.145.40.20]:63988 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261965AbTJXWmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:42:20 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E57035A94E6@exa-atlanta.se.lsil.com>
From: "Moore, Eric Dean" <emoore@lsil.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH]  2.4.23-pre8 driver udpate for MPT Fusion (2.05.10)
Date: Fri, 24 Oct 2003 18:42:02 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch for 2.4.23-pre8 kernel for MPT Fusion driver, coming from LSI
Logic.  I posted this as a link to the patch earlier today.  
It's been recommended that I post the patch directly to this mailing list.
Please
forgive me if this is incorrect due to the size of this patch(60KB). Please
refer to
previous email posted today which has the change log provided.

Here goes:


diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/isense.c
linux-2.4.23-pre8/drivers/message/fusion/isense.c
--- linux-2.4.23-pre8-reference/drivers/message/fusion/isense.c	2003-08-25
05:44:42.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/isense.c	2003-10-23
12:36:21.000000000 -0600
@@ -9,7 +9,7 @@
  *  Written By: Steven J. Ralston
  *  (yes I wrote some of the orig. code back in 1991!)
  *  (mailto:sjralston1@netscape.net)
- *  (mailto:lstephens@lsil.com)
+ *  (mailto:mpt_linux_developer@lsil.com)
  *
  *  $Id: isense.c,v 1.34 2003/03/18 22:49:48 pdelaney Exp $
  */
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/linux_compat.h
linux-2.4.23-pre8/drivers/message/fusion/linux_compat.h
--- linux-2.4.23-pre8-reference/drivers/message/fusion/linux_compat.h
2003-10-23 12:34:47.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/linux_compat.h	2003-10-23
12:42:33.000000000 -0600
@@ -267,9 +267,9 @@
 #endif
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,28)
-#define mptscsih_sync_irq(_irq) synchronize_irq(_irq)
+#define mpt_sync_irq(_irq) synchronize_irq(_irq)
 #else
-#define mptscsih_sync_irq(_irq) synchronize_irq()
+#define mpt_sync_irq(_irq) synchronize_irq()
 #endif
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,58)
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi_cnfg.h
linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi_cnfg.h
--- linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi_cnfg.h
2003-06-13 08:51:34.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi_cnfg.h	2003-10-23
12:36:21.000000000 -0600
@@ -1,12 +1,12 @@
 /*
- *  Copyright (c) 2000-2002 LSI Logic Corporation.
+ *  Copyright (c) 2000-2003 LSI Logic Corporation.
  *
  *
  *           Name:  MPI_CNFG.H
  *          Title:  MPI Config message, structures, and Pages
  *  Creation Date:  July 27, 2000
  *
- *    MPI_CNFG.H Version:  01.02.09
+ *    MPI_CNFG.H Version:  01.02.12
  *
  *  Version History
  *  ---------------
@@ -127,7 +127,24 @@
  *                      MPI_SCSIDEVPAGE1_CONF_EXTENDED_PARAMS_ENABLE.
  *                      Added new config page: CONFIG_PAGE_SCSI_DEVICE_3.
  *                      Modified MPI_FCPORTPAGE5_FLAGS_ defines.
- *  09-16-02 01.02.09   Added more MPI_SCSIDEVPAGE1_CONF_FORCE_PPR_MSG
define.
+ *  09-16-02 01.02.09   Added MPI_SCSIDEVPAGE1_CONF_FORCE_PPR_MSG define.
+ *  11-15-02 01.02.10   Added ConnectedID defines for
CONFIG_PAGE_SCSI_PORT_0.
+ *                      Added more Flags defines for CONFIG_PAGE_FC_PORT_1.
+ *                      Added more Flags defines for
CONFIG_PAGE_FC_DEVICE_0.
+ *  04-01-03 01.02.11   Added RR_TOV field and additional Flags defines for
+ *                      CONFIG_PAGE_FC_PORT_1.
+ *                      Added define MPI_FCPORTPAGE5_FLAGS_DISABLE to
disable
+ *                      an alias.
+ *                      Added more device id defines.
+ *  06-26-03 01.02.12   Added MPI_IOUNITPAGE1_IR_USE_STATIC_VOLUME_ID
define.
+ *                      Added TargetConfig and IDConfig fields to
+ *                      CONFIG_PAGE_SCSI_PORT_1.
+ *                      Added more PortFlags defines for
CONFIG_PAGE_SCSI_PORT_2
+ *                      to control DV.
+ *                      Added more Flags defines for CONFIG_PAGE_FC_PORT_1.
+ *                      In CONFIG_PAGE_FC_DEVICE_0, replaced Reserved1
field
+ *                      with ADISCHardALPA.
+ *                      Added MPI_FC_DEVICE_PAGE0_PROT_FCP_RETRY define.
  *
--------------------------------------------------------------------------
  */
 
@@ -281,6 +298,9 @@
 
/***************************************************************************
*
 *   Manufacturing Config pages
 
****************************************************************************
/
+#define MPI_MANUFACTPAGE_VENDORID_LSILOGIC          (0x1000)
+#define MPI_MANUFACTPAGE_VENDORID_TREBIA            (0x1783)
+
 #define MPI_MANUFACTPAGE_DEVICEID_FC909             (0x0621)
 #define MPI_MANUFACTPAGE_DEVICEID_FC919             (0x0624)
 #define MPI_MANUFACTPAGE_DEVICEID_FC929             (0x0622)
@@ -299,6 +319,10 @@
 #define MPI_MANUFACTPAGE_DEVID_SA2020               (0x0806)
 #define MPI_MANUFACTPAGE_DEVID_SA2020ZC             (0x0807)
 
+#define MPI_MANUFACTPAGE_DEVID_SNP1000              (0x0010)
+#define MPI_MANUFACTPAGE_DEVID_SNP500               (0x0020)
+
+
 
 typedef struct _CONFIG_PAGE_MANUFACTURING_0
 {
@@ -422,6 +446,7 @@
 #define MPI_IOUNITPAGE1_SINGLE_FUNCTION                 (0x00000001)
 #define MPI_IOUNITPAGE1_MULTI_PATHING                   (0x00000002)
 #define MPI_IOUNITPAGE1_SINGLE_PATHING                  (0x00000000)
+#define MPI_IOUNITPAGE1_IR_USE_STATIC_VOLUME_ID         (0x00000004)
 #define MPI_IOUNITPAGE1_DISABLE_IR                      (0x00000040)
 #define MPI_IOUNITPAGE1_FORCE_32                        (0x00000080)
 
@@ -694,6 +719,10 @@
 #define MPI_SCSIPORTPAGE0_PHY_SIGNAL_HVD                (0x01)
 #define MPI_SCSIPORTPAGE0_PHY_SIGNAL_SE                 (0x02)
 #define MPI_SCSIPORTPAGE0_PHY_SIGNAL_LVD                (0x03)
+#define MPI_SCSIPORTPAGE0_PHY_MASK_CONNECTED_ID         (0xFF000000)
+#define MPI_SCSIPORTPAGE0_PHY_SHIFT_CONNECTED_ID        (24)
+#define MPI_SCSIPORTPAGE0_PHY_BUS_FREE_CONNECTED_ID     (0xFE)
+#define MPI_SCSIPORTPAGE0_PHY_UNKNOWN_CONNECTED_ID      (0xFF)
 
 
 typedef struct _CONFIG_PAGE_SCSI_PORT_1
@@ -701,14 +730,22 @@
     fCONFIG_PAGE_HEADER      Header;                     /* 00h */
     U32                     Configuration;              /* 04h */
     U32                     OnBusTimerValue;            /* 08h */
+    U8                      TargetConfig;               /* 0Ch */
+    U8                      Reserved1;                  /* 0Dh */
+    U16                     IDConfig;                   /* 0Eh */
 } fCONFIG_PAGE_SCSI_PORT_1, MPI_POINTER PTR_CONFIG_PAGE_SCSI_PORT_1,
   SCSIPortPage1_t, MPI_POINTER pSCSIPortPage1_t;
 
 #define MPI_SCSIPORTPAGE1_PAGEVERSION                   (0x02)
 
+/* Configuration values */
 #define MPI_SCSIPORTPAGE1_CFG_PORT_SCSI_ID_MASK         (0x000000FF)
 #define MPI_SCSIPORTPAGE1_CFG_PORT_RESPONSE_ID_MASK     (0xFFFF0000)
 
+/* TargetConfig values */
+#define MPI_SCSIPORTPAGE1_TARGCONFIG_TARG_ONLY        (0x01)
+#define MPI_SCSIPORTPAGE1_TARGCONFIG_INIT_TARG        (0x02)
+
 
 typedef struct _MPI_DEVICE_INFO
 {
@@ -727,13 +764,20 @@
 } fCONFIG_PAGE_SCSI_PORT_2, MPI_POINTER PTR_CONFIG_PAGE_SCSI_PORT_2,
   SCSIPortPage2_t, MPI_POINTER pSCSIPortPage2_t;
 
-#define MPI_SCSIPORTPAGE2_PAGEVERSION                       (0x01)
+#define MPI_SCSIPORTPAGE2_PAGEVERSION                       (0x02)
 
+/* PortFlags values */
 #define MPI_SCSIPORTPAGE2_PORT_FLAGS_SCAN_HIGH_TO_LOW       (0x00000001)
 #define MPI_SCSIPORTPAGE2_PORT_FLAGS_AVOID_SCSI_RESET       (0x00000004)
 #define MPI_SCSIPORTPAGE2_PORT_FLAGS_ALTERNATE_CHS          (0x00000008)
 #define MPI_SCSIPORTPAGE2_PORT_FLAGS_TERMINATION_DISABLE    (0x00000010)
 
+#define MPI_SCSIPORTPAGE2_PORT_FLAGS_DV_MASK                (0x00000060)
+#define MPI_SCSIPORTPAGE2_PORT_FLAGS_FULL_DV                (0x00000000)
+#define MPI_SCSIPORTPAGE2_PORT_FLAGS_BASIC_DV_ONLY          (0x00000020)
+#define MPI_SCSIPORTPAGE2_PORT_FLAGS_OFF_DV                 (0x00000060)
+
+/* PortSettings values */
 #define MPI_SCSIPORTPAGE2_PORT_HOST_ID_MASK                 (0x0000000F)
 #define MPI_SCSIPORTPAGE2_PORT_MASK_INIT_HBA                (0x00000030)
 #define MPI_SCSIPORTPAGE2_PORT_DISABLE_INIT_HBA             (0x00000000)
@@ -915,7 +959,7 @@
 
 #define MPI_FCPORTPAGE0_FLAGS_ALIAS_ALPA_SUPPORTED      (0x00000010)
 #define MPI_FCPORTPAGE0_FLAGS_ALIAS_WWN_SUPPORTED       (0x00000020)
-#define MPI_FCPORTPAGE0_FLAGS_FABRIC_WWN_VALID          (0x00000030)
+#define MPI_FCPORTPAGE0_FLAGS_FABRIC_WWN_VALID          (0x00000040)
 
 #define MPI_FCPORTPAGE0_FLAGS_ATTACH_TYPE_MASK          (0x00000F00)
 #define MPI_FCPORTPAGE0_FLAGS_ATTACH_NO_INIT            (0x00000000)
@@ -974,15 +1018,23 @@
     U8                      TopologyConfig;             /* 1Ah */
     U8                      AltConnector;               /* 1Bh */
     U8                      NumRequestedAliases;        /* 1Ch */
-    U8                      Reserved1;                  /* 1Dh */
+    U8                      RR_TOV;                     /* 1Dh */
     U16                     Reserved2;                  /* 1Eh */
 } fCONFIG_PAGE_FC_PORT_1, MPI_POINTER PTR_CONFIG_PAGE_FC_PORT_1,
   FCPortPage1_t, MPI_POINTER pFCPortPage1_t;
 
-#define MPI_FCPORTPAGE1_PAGEVERSION                     (0x04)
+#define MPI_FCPORTPAGE1_PAGEVERSION                     (0x05)
 
 #define MPI_FCPORTPAGE1_FLAGS_EXT_FCP_STATUS_EN         (0x08000000)
 #define MPI_FCPORTPAGE1_FLAGS_IMMEDIATE_ERROR_REPLY     (0x04000000)
+#define MPI_FCPORTPAGE1_FLAGS_FORCE_USE_NOSEEPROM_WWNS  (0x02000000)
+#define MPI_FCPORTPAGE1_FLAGS_VERBOSE_RESCAN_EVENTS     (0x01000000)
+#define MPI_FCPORTPAGE1_FLAGS_TARGET_MODE_OXID          (0x00800000)
+#define MPI_FCPORTPAGE1_FLAGS_PORT_OFFLINE              (0x00400000)
+#define MPI_FCPORTPAGE1_FLAGS_MASK_RR_TOV_UNITS         (0x00000070)
+#define MPI_FCPORTPAGE1_FLAGS_SUPPRESS_PROT_REG         (0x00000008)
+#define MPI_FCPORTPAGE1_FLAGS_PLOGI_ON_LOGO             (0x00000004)
+#define MPI_FCPORTPAGE1_FLAGS_MAINTAIN_LOGINS           (0x00000002)
 #define MPI_FCPORTPAGE1_FLAGS_SORT_BY_DID               (0x00000001)
 #define MPI_FCPORTPAGE1_FLAGS_SORT_BY_WWN               (0x00000000)
 
@@ -993,6 +1045,11 @@
 #define MPI_FCPORTPAGE1_FLAGS_PROT_LAN
((U32)MPI_PORTFACTS_PROTOCOL_LAN << MPI_FCPORTPAGE1_FLAGS_PROT_SHIFT)
 #define MPI_FCPORTPAGE1_FLAGS_PROT_LOGBUSADDR
((U32)MPI_PORTFACTS_PROTOCOL_LOGBUSADDR << MPI_FCPORTPAGE1_FLAGS_PROT_SHIFT)
 
+#define MPI_FCPORTPAGE1_FLAGS_NONE_RR_TOV_UNITS         (0x00000000)
+#define MPI_FCPORTPAGE1_FLAGS_THOUSANDTH_RR_TOV_UNITS   (0x00000010)
+#define MPI_FCPORTPAGE1_FLAGS_TENTH_RR_TOV_UNITS        (0x00000030)
+#define MPI_FCPORTPAGE1_FLAGS_TEN_RR_TOV_UNITS          (0x00000050)
+
 #define MPI_FCPORTPAGE1_HARD_ALPA_NOT_USED              (0xFF)
 
 #define MPI_FCPORTPAGE1_LCONFIG_SPEED_MASK              (0x0F)
@@ -1108,12 +1165,13 @@
 } fCONFIG_PAGE_FC_PORT_5, MPI_POINTER PTR_CONFIG_PAGE_FC_PORT_5,
   FCPortPage5_t, MPI_POINTER pFCPortPage5_t;
 
-#define MPI_FCPORTPAGE5_PAGEVERSION                     (0x01)
+#define MPI_FCPORTPAGE5_PAGEVERSION                     (0x02)
 
 #define MPI_FCPORTPAGE5_FLAGS_ALPA_ACQUIRED             (0x01)
 #define MPI_FCPORTPAGE5_FLAGS_HARD_ALPA                 (0x02)
 #define MPI_FCPORTPAGE5_FLAGS_HARD_WWNN                 (0x04)
 #define MPI_FCPORTPAGE5_FLAGS_HARD_WWPN                 (0x08)
+#define MPI_FCPORTPAGE5_FLAGS_DISABLE                   (0x10)
 
 typedef struct _CONFIG_PAGE_FC_PORT_6
 {
@@ -1322,7 +1380,7 @@
     U8                      Flags;                      /* 19h */
     U16                     BBCredit;                   /* 1Ah */
     U16                     MaxRxFrameSize;             /* 1Ch */
-    U8                      Reserved1;                  /* 1Eh */
+    U8                      ADISCHardALPA;              /* 1Eh */
     U8                      PortNumber;                 /* 1Fh */
     U8                      FcPhLowestVersion;          /* 20h */
     U8                      FcPhHighestVersion;         /* 21h */
@@ -1331,13 +1389,16 @@
 } fCONFIG_PAGE_FC_DEVICE_0, MPI_POINTER PTR_CONFIG_PAGE_FC_DEVICE_0,
   FCDevicePage0_t, MPI_POINTER pFCDevicePage0_t;
 
-#define MPI_FC_DEVICE_PAGE0_PAGEVERSION                 (0x02)
+#define MPI_FC_DEVICE_PAGE0_PAGEVERSION                 (0x03)
 
 #define MPI_FC_DEVICE_PAGE0_FLAGS_TARGETID_BUS_VALID    (0x01)
+#define MPI_FC_DEVICE_PAGE0_FLAGS_PLOGI_INVALID         (0x02)
+#define MPI_FC_DEVICE_PAGE0_FLAGS_PRLI_INVALID          (0x04)
 
 #define MPI_FC_DEVICE_PAGE0_PROT_IP                     (0x01)
 #define MPI_FC_DEVICE_PAGE0_PROT_FCP_TARGET             (0x02)
 #define MPI_FC_DEVICE_PAGE0_PROT_FCP_INITIATOR          (0x04)
+#define MPI_FC_DEVICE_PAGE0_PROT_FCP_RETRY              (0x08)
 
 #define MPI_FC_DEVICE_PAGE0_PGAD_PORT_MASK
(MPI_FC_DEVICE_PGAD_PORT_MASK)
 #define MPI_FC_DEVICE_PAGE0_PGAD_FORM_MASK
(MPI_FC_DEVICE_PGAD_FORM_MASK)
@@ -1348,6 +1409,7 @@
 #define MPI_FC_DEVICE_PAGE0_PGAD_BUS_SHIFT
(MPI_FC_DEVICE_PGAD_BT_BUS_SHIFT)
 #define MPI_FC_DEVICE_PAGE0_PGAD_TID_MASK
(MPI_FC_DEVICE_PGAD_BT_TID_MASK)
 
+#define MPI_FC_DEVICE_PAGE0_HARD_ALPA_UNKNOWN   (0xFF)
 
 
/***************************************************************************
*
 *   RAID Volume Config Pages
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi.h
linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi.h
--- linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi.h
2003-06-13 08:51:34.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi.h	2003-10-23
12:36:21.000000000 -0600
@@ -1,12 +1,12 @@
 /*
- *  Copyright (c) 2000-2002 LSI Logic Corporation.
+ *  Copyright (c) 2000-2003 LSI Logic Corporation.
  *
  *
  *           Name:  MPI.H
  *          Title:  MPI Message independent structures and definitions
  *  Creation Date:  July 27, 2000
  *
- *    MPI.H Version:  01.02.07
+ *    MPI.H Version:  01.02.10
  *
  *  Version History
  *  ---------------
@@ -48,6 +48,10 @@
  *  05-31-02  01.02.05  Bumped MPI_HEADER_VERSION_UNIT.
  *  07-12-02  01.02.06  Added define for MPI_FUNCTION_MAILBOX.
  *  09-16-02  01.02.07  Bumped value for MPI_HEADER_VERSION_UNIT.
+ *  11-15-02  01.02.08  Added define MPI_IOCSTATUS_TARGET_INVALID_IO_INDEX
and
+ *                      obsoleted define
MPI_IOCSTATUS_TARGET_INVALID_IOCINDEX.
+ *  04-01-03  01.02.09  New IOCStatus code:
MPI_IOCSTATUS_FC_EXCHANGE_CANCELED
+ *  06-26-03  01.02.10  Bumped MPI_HEADER_VERSION_UNIT value.
  *
--------------------------------------------------------------------------
  */
 
@@ -76,7 +80,7 @@
 /* Note: The major versions of 0xe0 through 0xff are reserved */
 
 /* versioning for this MPI header set */
-#define MPI_HEADER_VERSION_UNIT             (0x09)
+#define MPI_HEADER_VERSION_UNIT             (0x0C)
 #define MPI_HEADER_VERSION_DEV              (0x00)
 #define MPI_HEADER_VERSION_UNIT_MASK        (0xFF00)
 #define MPI_HEADER_VERSION_UNIT_SHIFT       (8)
@@ -618,7 +622,8 @@
 
 #define MPI_IOCSTATUS_TARGET_PRIORITY_IO         (0x0060)
 #define MPI_IOCSTATUS_TARGET_INVALID_PORT        (0x0061)
-#define MPI_IOCSTATUS_TARGET_INVALID_IOCINDEX    (0x0062)
+#define MPI_IOCSTATUS_TARGET_INVALID_IOCINDEX    (0x0062)   /* obsolete */
+#define MPI_IOCSTATUS_TARGET_INVALID_IO_INDEX    (0x0062)
 #define MPI_IOCSTATUS_TARGET_ABORTED             (0x0063)
 #define MPI_IOCSTATUS_TARGET_NO_CONN_RETRYABLE   (0x0064)
 #define MPI_IOCSTATUS_TARGET_NO_CONNECTION       (0x0065)
@@ -642,6 +647,7 @@
 #define MPI_IOCSTATUS_FC_RX_ID_INVALID          (0x0067)
 #define MPI_IOCSTATUS_FC_DID_INVALID            (0x0068)
 #define MPI_IOCSTATUS_FC_NODE_LOGGED_OUT        (0x0069)
+#define MPI_IOCSTATUS_FC_EXCHANGE_CANCELED      (0x006C)
 
 
/***************************************************************************
*/
 /*  LAN values
*/
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi_init.h
linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi_init.h
--- linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi_init.h
2003-06-13 08:51:34.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi_init.h	2003-10-23
12:36:21.000000000 -0600
@@ -6,7 +6,7 @@
  *          Title:  MPI initiator mode messages and structures
  *  Creation Date:  June 8, 2000
  *
- *    MPI_INIT.H Version:  01.02.05
+ *    MPI_INIT.H Version:  01.02.07
  *
  *  Version History
  *  ---------------
@@ -31,6 +31,8 @@
  *  10-04-01  01.02.04  Added defines for SEP request Action field.
  *  05-31-02  01.02.05  Added MPI_SCSIIO_MSGFLGS_CMD_DETERMINES_DATA_DIR
define
  *                      for SCSI IO requests.
+ *  11-15-02  01.02.06  Added special extended SCSI Status defines for FCP.
+ *  06-26-03  01.02.07  Added MPI_SCSI_STATUS_FCPEXT_UNASSIGNED define.
  *
--------------------------------------------------------------------------
  */
 
@@ -153,6 +155,10 @@
 #define MPI_SCSI_STATUS_TASK_SET_FULL           (0x28)
 #define MPI_SCSI_STATUS_ACA_ACTIVE              (0x30)
 
+#define MPI_SCSI_STATUS_FCPEXT_DEVICE_LOGGED_OUT    (0x80)
+#define MPI_SCSI_STATUS_FCPEXT_NO_LINK              (0x81)
+#define MPI_SCSI_STATUS_FCPEXT_UNASSIGNED           (0x82)
+
 
 /* SCSI IO Reply SCSIState values */
 
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi_ioc.h
linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi_ioc.h
--- linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi_ioc.h
2003-06-13 08:51:34.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi_ioc.h	2003-10-23
12:36:21.000000000 -0600
@@ -1,12 +1,12 @@
 /*
- *  Copyright (c) 2000-2002 LSI Logic Corporation.
+ *  Copyright (c) 2000-2003 LSI Logic Corporation.
  *
  *
  *           Name:  MPI_IOC.H
  *          Title:  MPI IOC, Port, Event, FW Download, and FW Upload
messages
  *  Creation Date:  August 11, 2000
  *
- *    MPI_IOC.H Version:  01.02.06
+ *    MPI_IOC.H Version:  01.02.08
  *
  *  Version History
  *  ---------------
@@ -55,6 +55,8 @@
  *  05-31-02  01.02.06  Added define for
  *                      MPI_IOCFACTS_EXCEPT_RAID_CONFIG_INVALID.
  *                      Added AliasIndex to EVENT_DATA_LOGOUT structure.
+ *  04-01-03  01.02.07  Added defines for MPI_FW_HEADER_SIGNATURE_.
+ *  06-26-03  01.02.08  Added new values to the product family defines.
  *
--------------------------------------------------------------------------
  */
 
@@ -654,6 +656,10 @@
 #define MPI_FW_HEADER_PID_TYPE_SCSI             (0x0000)
 #define MPI_FW_HEADER_PID_TYPE_FC               (0x1000)
 
+#define MPI_FW_HEADER_SIGNATURE_0               (0x5AEAA55A)
+#define MPI_FW_HEADER_SIGNATURE_1               (0xA55AEAA5)
+#define MPI_FW_HEADER_SIGNATURE_2               (0x5AA55AEA)
+
 #define MPI_FW_HEADER_PID_PROD_MASK                     (0x0F00)
 #define MPI_FW_HEADER_PID_PROD_INITIATOR_SCSI           (0x0100)
 #define MPI_FW_HEADER_PID_PROD_TARGET_INITIATOR_SCSI    (0x0200)
@@ -673,6 +679,8 @@
 #define MPI_FW_HEADER_PID_FAMILY_1020C0_SCSI    (0x0008)
 #define MPI_FW_HEADER_PID_FAMILY_1035A0_SCSI    (0x0009)
 #define MPI_FW_HEADER_PID_FAMILY_1035B0_SCSI    (0x000A)
+#define MPI_FW_HEADER_PID_FAMILY_1030TA0_SCSI   (0x000B)
+#define MPI_FW_HEADER_PID_FAMILY_1020TA0_SCSI   (0x000C)
 #define MPI_FW_HEADER_PID_FAMILY_909_FC         (0x0000)
 #define MPI_FW_HEADER_PID_FAMILY_919_FC         (0x0001)
 #define MPI_FW_HEADER_PID_FAMILY_919X_FC        (0x0002)
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi_raid.h
linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi_raid.h
--- linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi_raid.h
2003-06-13 08:51:34.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi_raid.h	2003-10-23
12:36:21.000000000 -0600
@@ -1,12 +1,12 @@
 /*
- *  Copyright (c) 2001-2002 LSI Logic Corporation.
+ *  Copyright (c) 2001-2003 LSI Logic Corporation.
  *
  *
  *           Name:  MPI_RAID.H
  *          Title:  MPI RAID message and structures
  *  Creation Date:  February 27, 2001
  *
- *    MPI_RAID.H Version:  01.02.07
+ *    MPI_RAID.H Version:  01.02.09
  *
  *  Version History
  *  ---------------
@@ -25,6 +25,9 @@
  *                      MPI_RAID_ACTION_INACTIVATE_VOLUME, and
  *                      MPI_RAID_ACTION_ADATA_INACTIVATE_ALL.
  *  07-12-02  01.02.07  Added structures for Mailbox request and reply.
+ *  11-15-02  01.02.08  Added missing MsgContext field to
MSG_MAILBOX_REQUEST.
+ *  04-01-03  01.02.09  New action data option flag for
+ *                      MPI_RAID_ACTION_DELETE_VOLUME.
  *
--------------------------------------------------------------------------
  */
 
@@ -90,6 +93,9 @@
 #define MPI_RAID_ACTION_ADATA_KEEP_PHYS_DISKS       (0x00000000)
 #define MPI_RAID_ACTION_ADATA_DEL_PHYS_DISKS        (0x00000001)
 
+#define MPI_RAID_ACTION_ADATA_KEEP_LBA0             (0x00000000)
+#define MPI_RAID_ACTION_ADATA_ZERO_LBA0             (0x00000002)
+
 /* ActionDataWord defines for use with MPI_RAID_ACTION_ACTIVATE_VOLUME
action */
 #define MPI_RAID_ACTION_ADATA_INACTIVATE_ALL        (0x00000001)
 
@@ -195,6 +201,7 @@
     U16                     Reserved2;
     U8                      Reserved3;
     U8                      MsgFlags;
+    U32                     MsgContext;
     U8                      Command[10];
     U16                     Reserved4;
     SGE_IO_UNION            SGL;
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi_targ.h
linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi_targ.h
--- linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi_targ.h
2003-06-13 08:51:34.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi_targ.h	2003-10-23
12:36:21.000000000 -0600
@@ -1,12 +1,12 @@
 /*
- *  Copyright (c) 2000-2002 LSI Logic Corporation.
+ *  Copyright (c) 2000-2003 LSI Logic Corporation.
  *
  *
  *           Name:  MPI_TARG.H
  *          Title:  MPI Target mode messages and structures
  *  Creation Date:  June 22, 2000
  *
- *    MPI_TARG.H Version:  01.02.07
+ *    MPI_TARG.H Version:  01.02.09
  *
  *  Version History
  *  ---------------
@@ -41,6 +41,8 @@
  *                      Added AliasIndex field to
MPI_TARGET_FCP_CMD_BUFFER.
  *  09-16-02  01.02.07  Added flags for confirmed completion.
  *                      Added PRIORITY_REASON_TARGET_BUSY.
+ *  11-15-02  01.02.08  Added AliasID field to
MPI_TARGET_SCSI_SPI_CMD_BUFFER.
+ *  04-01-03  01.02.09  Added OptionalOxid field to
MPI_TARGET_FCP_CMD_BUFFER.
  *
--------------------------------------------------------------------------
  */
 
@@ -171,7 +173,7 @@
     U32     FcpDl;                                      /* 1Ch */
     U8      AliasIndex;                                 /* 20h */
     U8      Reserved1;                                  /* 21h */
-    U16     Reserved2;                                  /* 22h */
+    U16     OptionalOxid;                               /* 22h */
 } MPI_TARGET_FCP_CMD_BUFFER, MPI_POINTER PTR_MPI_TARGET_FCP_CMD_BUFFER,
   MpiTargetFcpCmdBuffer, MPI_POINTER pMpiTargetFcpCmdBuffer;
 
@@ -190,6 +192,10 @@
     U8      TaskManagementFlags;                        /* 12h */
     U8      AdditionalCDBLength;                        /* 13h */
     U8      CDB[16];                                    /* 14h */
+    /* Alias ID */
+    U8      AliasID;                                    /* 24h */
+    U8      Reserved1;                                  /* 25h */
+    U16     Reserved2;                                  /* 26h */
 } MPI_TARGET_SCSI_SPI_CMD_BUFFER,
   MPI_POINTER PTR_MPI_TARGET_SCSI_SPI_CMD_BUFFER,
   MpiTargetScsiSpiCmdBuffer, MPI_POINTER pMpiTargetScsiSpiCmdBuffer;
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi_tool.h
linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi_tool.h
--- linux-2.4.23-pre8-reference/drivers/message/fusion/lsi/mpi_tool.h
1969-12-31 17:00:00.000000000 -0700
+++ linux-2.4.23-pre8/drivers/message/fusion/lsi/mpi_tool.h	2003-10-23
12:36:21.000000000 -0600
@@ -0,0 +1,129 @@
+/*
+ *  Copyright (c) 2001 LSI Logic Corporation.
+ *
+ *
+ *           Name:  MPI_TOOL.H
+ *          Title:  MPI Toolbox structures and definitions
+ *  Creation Date:  July 30, 2001
+ *
+ *    MPI Version:  01.02.02
+ *
+ *  Version History
+ *  ---------------
+ *
+ *  Date      Version   Description
+ *  --------  --------
------------------------------------------------------
+ *  08-08-01  01.02.01  Original release.
+ *  08-29-01  01.02.02  Added DIAG_DATA_UPLOAD_HEADER and related defines.
+ *
--------------------------------------------------------------------------
+ */
+
+#ifndef MPI_TOOL_H
+#define MPI_TOOL_H
+
+#define MPI_TOOLBOX_CLEAN_TOOL                      (0x00)
+#define MPI_TOOLBOX_MEMORY_MOVE_TOOL                (0x01)
+#define MPI_TOOLBOX_DIAG_DATA_UPLOAD_TOOL           (0x02)
+
+
+/**************************************************************************
**/
+/* Toolbox reply
*/
+/**************************************************************************
**/
+
+typedef struct _MSG_TOOLBOX_REPLY
+{
+    U8                      Tool;                       /* 00h */
+    U8                      Reserved;                   /* 01h */
+    U8                      MsgLength;                  /* 02h */
+    U8                      Function;                   /* 03h */
+    U16                     Reserved1;                  /* 04h */
+    U8                      Reserved2;                  /* 06h */
+    U8                      MsgFlags;                   /* 07h */
+    U32                     MsgContext;                 /* 08h */
+    U16                     Reserved3;                  /* 0Ch */
+    U16                     IOCStatus;                  /* 0Eh */
+    U32                     IOCLogInfo;                 /* 10h */
+} MSG_TOOLBOX_REPLY, MPI_POINTER PTR_MSG_TOOLBOX_REPLY,
+  ToolboxReply_t, MPI_POINTER pToolboxReply_t;
+
+
+/**************************************************************************
**/
+/* Toolbox Clean Tool request
*/
+/**************************************************************************
**/
+
+typedef struct _MSG_TOOLBOX_CLEAN_REQUEST
+{
+    U8                      Tool;                       /* 00h */
+    U8                      Reserved;                   /* 01h */
+    U8                      ChainOffset;                /* 02h */
+    U8                      Function;                   /* 03h */
+    U16                     Reserved1;                  /* 04h */
+    U8                      Reserved2;                  /* 06h */
+    U8                      MsgFlags;                   /* 07h */
+    U32                     MsgContext;                 /* 08h */
+    U32                     Flags;                      /* 0Ch */
+} MSG_TOOLBOX_CLEAN_REQUEST, MPI_POINTER PTR_MSG_TOOLBOX_CLEAN_REQUEST,
+  ToolboxCleanRequest_t, MPI_POINTER pToolboxCleanRequest_t;
+
+#define MPI_TOOLBOX_CLEAN_NVSRAM                    (0x00000001)
+#define MPI_TOOLBOX_CLEAN_SEEPROM                   (0x00000002)
+#define MPI_TOOLBOX_CLEAN_FLASH                     (0x00000004)
+
+
+/**************************************************************************
**/
+/* Toolbox Memory Move request
*/
+/**************************************************************************
**/
+
+typedef struct _MSG_TOOLBOX_MEM_MOVE_REQUEST
+{
+    U8                      Tool;                       /* 00h */
+    U8                      Reserved;                   /* 01h */
+    U8                      ChainOffset;                /* 02h */
+    U8                      Function;                   /* 03h */
+    U16                     Reserved1;                  /* 04h */
+    U8                      Reserved2;                  /* 06h */
+    U8                      MsgFlags;                   /* 07h */
+    U32                     MsgContext;                 /* 08h */
+    SGE_SIMPLE_UNION        SGL;                        /* 0Ch */
+} MSG_TOOLBOX_MEM_MOVE_REQUEST, MPI_POINTER
PTR_MSG_TOOLBOX_MEM_MOVE_REQUEST,
+  ToolboxMemMoveRequest_t, MPI_POINTER pToolboxMemMoveRequest_t;
+
+
+/**************************************************************************
**/
+/* Toolbox Diagnostic Data Upload request
*/
+/**************************************************************************
**/
+
+typedef struct _MSG_TOOLBOX_DIAG_DATA_UPLOAD_REQUEST
+{
+    U8                      Tool;                       /* 00h */
+    U8                      Reserved;                   /* 01h */
+    U8                      ChainOffset;                /* 02h */
+    U8                      Function;                   /* 03h */
+    U16                     Reserved1;                  /* 04h */
+    U8                      Reserved2;                  /* 06h */
+    U8                      MsgFlags;                   /* 07h */
+    U32                     MsgContext;                 /* 08h */
+    U32                     Flags;                      /* 0Ch */
+    U32                     Reserved3;                  /* 10h */
+    SGE_SIMPLE_UNION        SGL;                        /* 14h */
+} MSG_TOOLBOX_DIAG_DATA_UPLOAD_REQUEST, MPI_POINTER
PTR_MSG_TOOLBOX_DIAG_DATA_UPLOAD_REQUEST,
+  ToolboxDiagDataUploadRequest_t, MPI_POINTER
pToolboxDiagDataUploadRequest_t;
+
+typedef struct _DIAG_DATA_UPLOAD_HEADER
+{
+    U32                     DiagDataLength;             /* 00h */
+    U8                      FormatCode;                 /* 04h */
+    U8                      Reserved;                   /* 05h */
+    U16                     Reserved1;                  /* 06h */
+} DIAG_DATA_UPLOAD_HEADER, MPI_POINTER PTR_DIAG_DATA_UPLOAD_HEADER,
+  DiagDataUploadHeader_t, MPI_POINTER pDiagDataUploadHeader_t;
+
+#define MPI_TB_DIAG_FORMAT_SCSI_PRINTF_1            (0x01)
+#define MPI_TB_DIAG_FORMAT_SCSI_2                   (0x02)
+#define MPI_TB_DIAG_FORMAT_SCSI_3                   (0x03)
+#define MPI_TB_DIAG_FORMAT_FC_TRACE_1               (0x04)
+
+
+#endif
+
+
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/mptbase.c
linux-2.4.23-pre8/drivers/message/fusion/mptbase.c
--- linux-2.4.23-pre8-reference/drivers/message/fusion/mptbase.c
2003-08-25 05:44:42.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/mptbase.c	2003-10-23
12:36:21.000000000 -0600
@@ -47,7 +47,7 @@
  *  Copyright (c) 1999-2002 LSI Logic Corporation
  *  Originally By: Steven J. Ralston
  *  (mailto:sjralston1@netscape.net)
- *  (mailto:lstephens@lsil.com)
+ *  (mailto:mpt_linux_developer@lsil.com)
  *
  *  $Id: mptbase.c,v 1.130 2003/05/07 14:08:30 pdelaney Exp $
  */
@@ -211,6 +211,7 @@
 static int	mpt_readScsiDevicePageHeaders(MPT_ADAPTER *ioc, int
portnum);
 static int	mpt_findImVolumes(MPT_ADAPTER *ioc);
 static void 	mpt_read_ioc_pg_1(MPT_ADAPTER *ioc);
+static void 	mpt_read_ioc_pg_4(MPT_ADAPTER *ioc);
 static void	mpt_timer_expired(unsigned long data);
 static int	SendEventNotification(MPT_ADAPTER *ioc, u8 EvSwitch);
 static int	SendEventAck(MPT_ADAPTER *ioc, EventNotificationReply_t
*evnp);
@@ -319,14 +320,14 @@
 	MPT_FRAME_HDR	*mf;
 	MPT_FRAME_HDR	*mr;
 	u32		 pa;
-	int		 req_idx = -1;
+	int		 req_idx;
 	int		 cb_idx;
 	int		 type;
 	int		 freeme;
-	int		 count = 0;
 
 	ioc = bus_id;
 
+#ifdef MPT_DEBUG_IRQ
 	/*
 	 * Verify ioc pointer is ok
 	 */
@@ -341,6 +342,7 @@
 			return;
 		}
 	}
+#endif
 
 	/*
 	 *  Drain the reply FIFO!
@@ -493,17 +495,7 @@
 			spin_unlock_irqrestore(&ioc->FreeQlock, flags);
 		}
 
-		count++;
-		dirqprintk((MYIOC_s_INFO_FMT "ISR processed frame #%d\n",
ioc->name, count));
 		mb();
-
-		if (count >= MPT_MAX_REPLIES_PER_ISR) {
-			dirqprintk((MYIOC_s_INFO_FMT "ISR processed %d
replies.",
-					ioc->name, count));
-			dirqprintk((" Giving this ISR a break!\n"));
-			return;
-		}
-
 	}	/* drain reply FIFO */
 }
 
@@ -1285,7 +1277,11 @@
 	if (pci_enable_device(pdev))
 		return r;
 
-	if (!pci_set_dma_mask(pdev, mask)) {
+	/* For some kernels, broken kernel limits memory allocation for
target mode
+	 * driver. Shirron. Fixed in 2.4.20-8
+	 * if ((sizeof(dma_addr_t) == sizeof(u64)) &&
(!pci_set_dma_mask(pdev, mask))) {
+	 */
+	if ((!pci_set_dma_mask(pdev, mask))) {
 		dprintk((KERN_INFO MYNAM ": 64 BIT PCI BUS DMA ADDRESSING
SUPPORTED\n"));
 	} else {
 		if (pci_set_dma_mask(pdev, (u64) 0xffffffff)) {
@@ -1300,10 +1296,10 @@
 		printk(KERN_ERR MYNAM ": ERROR - Insufficient memory to add
adapter!\n");
 		return -ENOMEM;
 	}
-	memset(ioc, 0, sizeof(*ioc));
+	memset(ioc, 0, sizeof(MPT_ADAPTER));
 	ioc->alloc_total = sizeof(MPT_ADAPTER);
 	ioc->req_sz = MPT_DEFAULT_FRAME_SIZE;		/* avoid div by
zero! */
-	ioc->reply_sz = ioc->req_sz;
+	ioc->reply_sz = MPT_REPLY_FRAME_SIZE;
 
 	ioc->pcidev = pdev;
 	ioc->diagPending = 0;
@@ -1764,6 +1760,8 @@
 			/* Check, and possibly reset, the coalescing value
 			 */
 			mpt_read_ioc_pg_1(ioc);
+
+			mpt_read_ioc_pg_4(ioc);
 		}
 
 		GetIoUnitPage2(ioc);
@@ -1950,6 +1948,15 @@
 			kfree(this->spi_data.pIocPg3);
 			this->spi_data.pIocPg3 = NULL;
 		}
+
+		if (freeup && this->spi_data.pIocPg4 != NULL) {
+			sz = this->spi_data.IocPg4Sz;
+			pci_free_consistent(this->pcidev, sz, 
+				this->spi_data.pIocPg4,
+				this->spi_data.IocPg4_dma);
+			this->spi_data.pIocPg4 = NULL;
+			this->alloc_total -= sz;
+		}
 	}
 }
 
@@ -2346,7 +2353,7 @@
 			 */
 			ioc->req_sz = MIN(MPT_DEFAULT_FRAME_SIZE,
facts->RequestFrameSize * 4);
 			ioc->req_depth = MIN(MPT_MAX_REQ_DEPTH,
facts->GlobalCredits);
-			ioc->reply_sz = ioc->req_sz;
+			ioc->reply_sz = MPT_REPLY_FRAME_SIZE;
 			ioc->reply_depth = MIN(MPT_DEFAULT_REPLY_DEPTH,
facts->ReplyQueueDepth);
 
 			dprintk((MYIOC_s_INFO_FMT "reply_sz=%3d,
reply_depth=%4d\n",
@@ -4424,6 +4431,8 @@
 				/* Save the Port Page 2 data
 				 * (reformat into a 32bit quantity)
 				 */
+				data = le32_to_cpu(pPP2->PortFlags) &
MPI_SCSIPORTPAGE2_PORT_FLAGS_DV_MASK;
+				ioc->spi_data.PortFlags = data;
 				for (ii=0; ii < MPT_MAX_SCSI_DEVICES; ii++)
{
 					pdevice = &pPP2->DeviceSettings[ii];
 					data =
(le16_to_cpu(pdevice->DeviceFlags) << 16) |
@@ -4660,6 +4669,57 @@
 }
 
 static void
+mpt_read_ioc_pg_4(MPT_ADAPTER *ioc)
+{
+	IOCPage4_t		*pIoc4;
+	CONFIGPARMS		 cfg;
+	ConfigPageHeader_t	 header;
+	dma_addr_t		 ioc4_dma;
+	int			 iocpage4sz;
+
+	/* Read and save IOC Page 4
+	 */
+	header.PageVersion = 0;
+	header.PageLength = 0;
+	header.PageNumber = 4;
+	header.PageType = MPI_CONFIG_PAGETYPE_IOC;
+	cfg.hdr = &header;
+	cfg.physAddr = -1;
+	cfg.pageAddr = 0;
+	cfg.action = MPI_CONFIG_ACTION_PAGE_HEADER;
+	cfg.dir = 0;
+	cfg.timeout = 0;
+	if (mpt_config(ioc, &cfg) != 0)
+		return;
+
+	if (header.PageLength == 0)
+		return;
+
+	if ( (pIoc4 = ioc->spi_data.pIocPg4) == NULL ) {
+		iocpage4sz = (header.PageLength + 4) * 4; /* Allow 4
additional SEP's */
+		pIoc4 = pci_alloc_consistent(ioc->pcidev, iocpage4sz,
&ioc4_dma);
+		if (!pIoc4)
+			return;
+	} else {
+		ioc4_dma = ioc->spi_data.IocPg4_dma;
+		iocpage4sz = ioc->spi_data.IocPg4Sz;
+	}
+
+	/* Read the Page into dma memory.
+	 */
+	cfg.physAddr = ioc4_dma;
+	cfg.action = MPI_CONFIG_ACTION_PAGE_READ_CURRENT;
+	if (mpt_config(ioc, &cfg) == 0) {
+		ioc->spi_data.pIocPg4 = (IOCPage4_t *) pIoc4;
+		ioc->spi_data.IocPg4_dma = ioc4_dma;
+		ioc->spi_data.IocPg4Sz = iocpage4sz;
+	} else {
+		pci_free_consistent(ioc->pcidev, iocpage4sz, pIoc4,
ioc4_dma);
+		ioc->spi_data.pIocPg4 = NULL;
+	}
+}
+
+static void
 mpt_read_ioc_pg_1(MPT_ADAPTER *ioc)
 {
 	IOCPage1_t		*pIoc1 = NULL;
@@ -5428,7 +5488,7 @@
 	int		 rc;
 	unsigned long	 flags;
 
-	dprintk((MYIOC_s_INFO_FMT "HardResetHandler Entered!\n",
ioc->name));
+	dtmprintk((MYIOC_s_INFO_FMT "HardResetHandler Entered!\n",
ioc->name));
 #ifdef MFCNT
 	printk(MYIOC_s_INFO_FMT "HardResetHandler Entered!\n", ioc->name);
 	printk("MF count 0x%x !\n", ioc->mfcnt);
@@ -5460,11 +5520,11 @@
 
 		for (ii=MPT_MAX_PROTOCOL_DRIVERS-1; ii; ii--) {
 			if (MptResetHandlers[ii]) {
-				dprintk((MYIOC_s_INFO_FMT "Calling IOC
reset_setup handler #%d\n",
+				dtmprintk((MYIOC_s_INFO_FMT "Calling IOC
reset_setup handler #%d\n",
 						ioc->name, ii));
 				r += (*(MptResetHandlers[ii]))(ioc,
MPT_IOC_SETUP_RESET);
 				if (ioc->alt_ioc) {
-					dprintk((MYIOC_s_INFO_FMT "Calling
alt-%s setup reset handler #%d\n",
+					dtmprintk((MYIOC_s_INFO_FMT "Calling
alt-%s setup reset handler #%d\n",
 							ioc->name,
ioc->alt_ioc->name, ii));
 					r +=
(*(MptResetHandlers[ii]))(ioc->alt_ioc, MPT_IOC_SETUP_RESET);
 				}
@@ -5486,7 +5546,7 @@
 		ioc->alt_ioc->diagPending = 0;
 	spin_unlock_irqrestore(&ioc->diagLock, flags);
 
-	dprintk((MYIOC_s_INFO_FMT "HardResetHandler rc = %d!\n", ioc->name,
rc));
+	dtmprintk((MYIOC_s_INFO_FMT "HardResetHandler rc = %d!\n",
ioc->name, rc));
 
 	return rc;
 }
@@ -6021,7 +6081,7 @@
 		this->active = 0;
 
 		pdev = (struct pci_dev *)this->pcidev;
-		mptscsih_sync_irq(pdev->irq);
+		mpt_sync_irq(pdev->irq);
 
 		/* Clear any lingering interrupt */
 		CHIPREG_WRITE32(&this->chip->IntStatus, 0);
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/mptbase.h
linux-2.4.23-pre8/drivers/message/fusion/mptbase.h
--- linux-2.4.23-pre8-reference/drivers/message/fusion/mptbase.h
2003-08-25 05:44:42.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/mptbase.h	2003-10-23
12:36:21.000000000 -0600
@@ -11,7 +11,7 @@
  *  Copyright (c) 1999-2002 LSI Logic Corporation
  *  Originally By: Steven J. Ralston
  *  (mailto:sjralston1@netscape.net)
- *  (mailto:lstephens@lsil.com)
+ *  (mailto:mpt_linux_developer@lsil.com)
  *
  *  $Id: mptbase.h,v 1.149 2003/05/07 14:08:31 pdelaney Exp $
  */
@@ -77,11 +77,11 @@
 #endif
 
 #ifndef COPYRIGHT
-#define COPYRIGHT	"Copyright (c) 1999-2002 " MODULEAUTHOR
+#define COPYRIGHT	"Copyright (c) 1999-2003 " MODULEAUTHOR
 #endif
 
-#define MPT_LINUX_VERSION_COMMON	"2.05.05+"
-#define MPT_LINUX_PACKAGE_NAME		"@(#)mptlinux-2.05.05+"
+#define MPT_LINUX_VERSION_COMMON	"2.05.10"
+#define MPT_LINUX_PACKAGE_NAME		"@(#)mptlinux-2.05.10"
 #define WHAT_MAGIC_STRING		"@" "(" "#" ")"
 
 #define show_mptmod_ver(s,ver)  \
@@ -127,6 +127,8 @@
 #define  MPT_MAX_FRAME_SIZE		128
 #define  MPT_DEFAULT_FRAME_SIZE		128
 
+#define  MPT_REPLY_FRAME_SIZE		0x40  /* Must be a multiple of 8 */
+
 #define  MPT_SG_REQ_128_SCALE		1
 #define  MPT_SG_REQ_96_SCALE		2
 #define  MPT_SG_REQ_64_SCALE		4
@@ -245,6 +247,7 @@
 		MPIHeader_t		hdr;
 		SCSIIORequest_t		scsireq;
 		SCSIIOReply_t		sreply;
+		ConfigReply_t		configreply;
 		MPIDefaultReply_t	reply;
 		MPT_FRAME_TRACKER	frame;
 	} u;
@@ -400,7 +403,7 @@
 	u32			 num_luns;
 //--- LUN split here?
 	u32			 luns;		/* Max LUNs is 32 */
-	u8			 inq_data[SCSI_STD_INQUIRY_BYTES];	/*
36 */
+	u8			 inq_data[8];
 	u8			 pad0[4];
 	u8			 inq00_data[20];
 	u8			 pad1[4];
@@ -430,6 +433,7 @@
 #define MPT_TARGET_FLAGS_VALID_INQUIRY	0x02
 #define MPT_TARGET_FLAGS_Q_YES		0x08
 #define MPT_TARGET_FLAGS_VALID_56	0x10
+#define MPT_TARGET_FLAGS_SAF_TE_ISSUED	0x20
 #endif
 
 #define MPT_TARGET_NO_NEGO_WIDE		0x01
@@ -529,8 +533,12 @@
 /* #define MPT_SCSICFG_BLK_NEGO		0x10	   WriteSDP1 with
WDTR and SDTR disabled */
 
 typedef	struct _ScsiCfgData {
+	u32		 PortFlags;
 	int		*nvram;			/* table of device NVRAM
values */
 	IOCPage3_t	*pIocPg3;		/* table of physical disks
*/
+	IOCPage4_t	*pIocPg4;		/* SEP devices addressing */
+	dma_addr_t	 IocPg4_dma;		/* Phys Addr of IOCPage4
data */
+	int		 IocPg4Sz;		/* IOCPage4 size */
 	u8		 dvStatus[MPT_MAX_SCSI_DEVICES];
 	int		 isRaid;		/* bit field, 1 if RAID */
 	u8		 minSyncFactor;		/* 0xFF if async */
@@ -544,7 +552,8 @@
 	u8		 dvScheduled;		/* 1 if scheduled */
 	u8		 forceDv;		/* 1 to force DV scheduling
*/
 	u8		 noQas;			/* Disable QAS for this
adapter */
-	u8		 rsvd[2];
+	u8		 Saf_Te;		/* 1 to force all Processors
as SAF-TE if Inquiry data length is too short to check for SAF-TE */
+	u8		 rsvd[1];
 } ScsiCfgData;
 
 typedef struct _fw_image {
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/mptctl.c
linux-2.4.23-pre8/drivers/message/fusion/mptctl.c
--- linux-2.4.23-pre8-reference/drivers/message/fusion/mptctl.c	2003-08-25
05:44:42.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/mptctl.c	2003-10-23
12:36:21.000000000 -0600
@@ -32,7 +32,7 @@
  *  Copyright (c) 1999-2002 LSI Logic Corporation
  *  Originally By: Steven J. Ralston, Noah Romer
  *  (mailto:sjralston1@netscape.net)
- *  (mailto:lstephens@lsil.com)
+ *  (mailto:mpt_linux_developer@lsil.com)
  *
  *  $Id: mptctl.c,v 1.66 2003/05/07 14:08:32 pdelaney Exp $
  */
@@ -1329,6 +1329,7 @@
 	/* Set the Version Strings.
 	 */
 	strncpy (karg.driverVersion, MPT_LINUX_PACKAGE_NAME,
MPT_IOCTL_VERSION_LENGTH);
+	karg.driverVersion[MPT_IOCTL_VERSION_LENGTH-1]='\0';
 
 	karg.busChangeEvent = 0;
 	karg.hostId = ioc->pfacts[port].PortSCSIID;
@@ -1529,7 +1530,9 @@
 	karg.chip_type = ioc->chip_type;
 #endif
 	strncpy (karg.name, ioc->name, MPT_MAX_NAME);
+	karg.name[MPT_MAX_NAME-1]='\0';
 	strncpy (karg.product, ioc->prod_name, MPT_PRODUCT_LENGTH);
+	karg.product[MPT_PRODUCT_LENGTH-1]='\0';
 
 	/* Copy the data from kernel memory to user memory
 	 */
@@ -1950,6 +1953,8 @@
 			 */
 			if (karg.maxSenseBytes > MPT_SENSE_BUFFER_SIZE)
 				pScsiReq->SenseBufferLength =
MPT_SENSE_BUFFER_SIZE;
+			else
+				pScsiReq->SenseBufferLength =
karg.maxSenseBytes;
 
 			pScsiReq->SenseBufferLowAddr =
 				cpu_to_le32(ioc->sense_buf_low_dma
@@ -2011,6 +2016,8 @@
 			 */
 			if (karg.maxSenseBytes > MPT_SENSE_BUFFER_SIZE)
 				pScsiReq->SenseBufferLength =
MPT_SENSE_BUFFER_SIZE;
+			else
+				pScsiReq->SenseBufferLength =
karg.maxSenseBytes;
 
 			pScsiReq->SenseBufferLowAddr =
 				cpu_to_le32(ioc->sense_buf_low_dma
@@ -2471,8 +2478,10 @@
 				cfg.physAddr = buf_dma;
 				if (mpt_config(ioc, &cfg) == 0) {
 					ManufacturingPage0_t *pdata =
(ManufacturingPage0_t *) pbuf;
-					if (strlen(pdata->BoardTracerNumber)
> 1)
+					if (strlen(pdata->BoardTracerNumber)
> 1) {
 						strncpy(karg.serial_number,
pdata->BoardTracerNumber, 24);
+
karg.serial_number[24-1]='\0';
+					}
 				}
 				pci_free_consistent(ioc->pcidev,
hdr.PageLength * 4, pbuf, buf_dma);
 				pbuf = NULL;
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/mptctl.h
linux-2.4.23-pre8/drivers/message/fusion/mptctl.h
--- linux-2.4.23-pre8-reference/drivers/message/fusion/mptctl.h	2003-08-25
05:44:42.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/mptctl.h	2003-10-23
12:36:21.000000000 -0600
@@ -18,7 +18,7 @@
  *  Copyright (c) 1999-2002 LSI Logic Corporation
  *  Originally By: Steven J. Ralston
  *  (mailto:sjralston1@netscape.net)
- *  (mailto:lstephens@lsil.com)
+ *  (mailto:mpt_linux_developer@lsil.com)
  *
  *  $Id: mptctl.h,v 1.14 2003/03/18 22:49:51 pdelaney Exp $
  */
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/mptscsih.c
linux-2.4.23-pre8/drivers/message/fusion/mptscsih.c
--- linux-2.4.23-pre8-reference/drivers/message/fusion/mptscsih.c
2003-08-25 05:44:42.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/mptscsih.c	2003-10-23
12:36:21.000000000 -0600
@@ -24,7 +24,7 @@
  *  Copyright (c) 1999-2002 LSI Logic Corporation
  *  Original author: Steven J. Ralston
  *  (mailto:sjralston1@netscape.net)
- *  (mailto:lstephens@lsil.com)
+ *  (mailto:mpt_linux_developer@lsil.com)
  *
  *  $Id: mptscsih.c,v 1.1.2.4 2003/05/07 14:08:34 pdelaney Exp $
  */
@@ -180,12 +180,13 @@
 static int	mptscsih_ioc_reset(MPT_ADAPTER *ioc, int post_reset);
 static int	mptscsih_event_process(MPT_ADAPTER *ioc,
EventNotificationReply_t *pEvReply);
 
-static VirtDevice	*mptscsih_initTarget(MPT_SCSI_HOST *hd, int bus_id,
int target_id, u8 lun, char *data, int dlen);
+static void	mptscsih_initTarget(MPT_SCSI_HOST *hd, int bus_id, int
target_id, u8 lun, char *data, int dlen);
 void		mptscsih_setTargetNegoParms(MPT_SCSI_HOST *hd, VirtDevice
*target, char byte56);
 static void	mptscsih_set_dvflags(MPT_SCSI_HOST *hd, SCSIIORequest_t
*pReq);
 static void	mptscsih_setDevicePage1Flags (u8 width, u8 factor, u8
offset, int *requestedPtr, int *configurationPtr, u8 flags);
 static void	mptscsih_no_negotiate(MPT_SCSI_HOST *hd, int target_id);
 static int	mptscsih_writeSDP1(MPT_SCSI_HOST *hd, int portnum, int
target, int flags);
+static int	mptscsih_writeIOCPage4(MPT_SCSI_HOST *hd, int target_id, int
bus);
 static int	mptscsih_scandv_complete(MPT_ADAPTER *ioc, MPT_FRAME_HDR
*mf, MPT_FRAME_HDR *r);
 static void	mptscsih_timer_expired(unsigned long data);
 static void	mptscsih_taskmgmt_timeout(unsigned long data);
@@ -508,10 +509,12 @@
 	 */
 	sges_left = SCpnt->use_sg;
 	if (SCpnt->use_sg) {
-		sges_left = pci_map_sg(hd->ioc->pcidev,
+		if ( (sges_left = pci_map_sg(hd->ioc->pcidev,
 			       (struct scatterlist *) SCpnt->request_buffer,
 			       SCpnt->use_sg,
-
scsi_to_pci_dma_dir(SCpnt->sc_data_direction));
+
scsi_to_pci_dma_dir(SCpnt->sc_data_direction)))
+			== 0 )
+				return FAILED;
 	} else if (SCpnt->request_bufflen) {
 		dma_addr_t	 buf_dma_addr;
 		scPrivate	*my_priv;
@@ -730,13 +733,6 @@
 
 	hd = (MPT_SCSI_HOST *) ioc->sh->hostdata;
 
-	if ((mf == NULL) ||
-	    (mf >= MPT_INDEX_2_MFPTR(ioc, ioc->req_depth))) {
-		printk(MYIOC_s_ERR_FMT "%s req frame ptr! (=%p)!\n",
-				ioc->name, mf?"BAD":"NULL", (void *) mf);
-		return 0;
-	}
-
 	req_idx = le16_to_cpu(mf->u.frame.hwhdr.msgctxu.fld.req_idx);
 	sc = hd->ScsiLookup[req_idx];
 	if (sc == NULL) {
@@ -878,7 +874,6 @@
 				mptscsih_no_negotiate(hd, sc->target);
 			break;
 
-		case MPI_IOCSTATUS_SCSI_RESIDUAL_MISMATCH:	/* 0x0049 */
 		case MPI_IOCSTATUS_SCSI_DATA_UNDERRUN:		/* 0x0045 */
 			/*
 			 *  YIKES!  I just discovered that SCSI IO which
@@ -1036,6 +1031,7 @@
 		case MPI_IOCSTATUS_INVALID_STATE:		/* 0x0008 */
 		case MPI_IOCSTATUS_SCSI_DATA_OVERRUN:		/* 0x0044 */
 		case MPI_IOCSTATUS_SCSI_IO_DATA_ERROR:		/* 0x0046 */
+		case MPI_IOCSTATUS_SCSI_RESIDUAL_MISMATCH:	/* 0x0049 */
 		case MPI_IOCSTATUS_SCSI_TASK_MGMT_FAILED:	/* 0x004A */
 		default:
 			/*
@@ -1678,8 +1674,8 @@
 		}
 
 		if (!ioc_cap) {
-			printk(MYIOC_s_WARN_FMT "Skipping because SCSI
Initiator mode is NOT enabled!\n",
-					this->name);
+			printk(MYIOC_s_WARN_FMT "Skipping this=%p because
SCSI Initiator mode is NOT enabled!\n",
+					this->name, this);
 			continue;
 		}
 
@@ -1909,6 +1905,8 @@
 				if (hd->ioc->spi_data.minSyncFactor ==
MPT_ASYNC)
 					hd->ioc->spi_data.maxSyncOffset = 0;
 
+				hd->ioc->spi_data.Saf_Te =
driver_setup.saf_te;
+
 				hd->negoNvram = 0;
 #ifdef MPTSCSIH_DISABLE_DOMAIN_VALIDATION
 				hd->negoNvram = MPT_SCSICFG_USE_NVRAM;
@@ -1926,10 +1924,11 @@
 				}
 
 				ddvprintk((MYIOC_s_INFO_FMT
-					"dv %x width %x factor %x \n",
+					"dv %x width %x factor %x saf_te
%x\n",
 					hd->ioc->name, driver_setup.dv,
 					driver_setup.max_width,
-					driver_setup.min_sync_fac));
+					driver_setup.min_sync_fac,
+					driver_setup.saf_te));
 			}
 
 			mpt_scsi_hosts++;
@@ -3088,7 +3087,6 @@
 		search_doneQ_for_cmd(hd, SCpnt);
 
 		SCpnt->result = DID_RESET << 16;
-		SCpnt->scsi_done(SCpnt);
 		nehprintk((KERN_WARNING MYNAM ": %s: mptscsih_abort: "
 			   "Command not in the active list! (sc=%p)\n",
 			   hd->ioc->name, SCpnt));
@@ -3345,7 +3343,6 @@
 	if ((hd = (MPT_SCSI_HOST *) SCpnt->host->hostdata) == NULL) {
 		printk(KERN_WARNING "  WARNING - OldAbort, NULL hostdata
ptr!!\n");
 		SCpnt->result = DID_ERROR << 16;
-		SCpnt->scsi_done(SCpnt);
 		return SCSI_ABORT_NOT_RUNNING;
 	}
 
@@ -3359,18 +3356,19 @@
 		 */
 		search_doneQ_for_cmd(hd, SCpnt);
 
-		SCpnt->result = DID_RESET << 16;
-		SCpnt->scsi_done(SCpnt);
+		SCpnt->result = DID_ABORT << 16;
 		return SCSI_ABORT_SUCCESS;
 	} else {
 		/* If this command is pended, then timeout/hang occurred
 		 * during DV. Force bus reset by posting command to F/W
 		 * and then following up with the reset request.
 		 */
+#ifndef MPTSCSIH_DBG_TIMEOUT
 		if ((mf = mptscsih_search_pendingQ(hd, scpnt_idx)) != NULL)
{
 			mptscsih_put_msgframe(ScsiDoneCtx, hd->ioc->id, mf);
 			post_pendingQ_commands(hd);
 		}
+#endif
 	}
 
 	/*
@@ -3476,8 +3474,7 @@
 	printk(KERN_WARNING "  IOs outstanding = %d\n",
atomic_read(&queue_depth));
 
 	if ((hd = (MPT_SCSI_HOST *) SCpnt->host->hostdata) == NULL) {
-		SCpnt->result = DID_RESET << 16;
-		SCpnt->scsi_done(SCpnt);
+		SCpnt->result = DID_ERROR << 16;
 		return SCSI_RESET_SUCCESS;
 	}
 
@@ -3492,17 +3489,18 @@
 		search_doneQ_for_cmd(hd, SCpnt);
 
 		SCpnt->result = DID_RESET << 16;
-		SCpnt->scsi_done(SCpnt);
 		return SCSI_RESET_SUCCESS;
 	} else {
 		/* If this command is pended, then timeout/hang occurred
 		 * during DV. Force bus reset by posting command to F/W
 		 * and then following up with the reset request.
 		 */
+#ifndef MPTSCSIH_DBG_TIMEOUT
 		if ((mf = mptscsih_search_pendingQ(hd, scpnt_idx)) != NULL)
{
 			mptscsih_put_msgframe(ScsiDoneCtx, hd->ioc->id, mf);
 			post_pendingQ_commands(hd);
 		}
+#endif
 	}
 
 	/*
@@ -3628,8 +3626,8 @@
 
 #ifdef MPTSCSIH_DBG_TIMEOUT
 				if (ioc->timeout_hard == 1) {
-					mptscsih_TMHandler(hd, 
-
MPI_SCSITASKMGMT_TASKTYPE_RESET_BUS, 
+					mptscsih_TMHandler(hd,
+
MPI_SCSITASKMGMT_TASKTYPE_RESET_BUS,
 						0, 0, 0, 0, CAN_SLEEP);
 
 				}
@@ -3727,6 +3725,9 @@
 				mpt_free_msg_frame(ScsiTaskCtx, hd->ioc->id,
mf);
 				mf = NULL;
 
+#ifndef MPTSCSIH_DBG_TIMEOUT
+				post_pendingQ_commands(hd);
+#endif
 				if (mptscsih_TMHandler(hd, task_type,
SCpnt->channel,
 						      SCpnt->target,
SCpnt->lun,
 						       ctx2abort, CAN_SLEEP)
< 0) {
@@ -3962,10 +3963,10 @@
 			}
 
 			if (pTarget != NULL) {
-				printk(MYIOC_s_INFO_FMT
+				dprintk((MYIOC_s_INFO_FMT
 					 "scsi%d: Id=%d Lun=%d: Queue
depth=%d\n",
-					 hd->ioc->name, sh->host_no,
-					 device->id, device->lun,
device->queue_depth);
+					 hd->ioc->name, 
+					 device->id, device->lun,
device->queue_depth));
 
 				dprintk((MYIOC_s_INFO_FMT
 					 "Id = %d, sync factor = %x\n",
@@ -4971,13 +4972,11 @@
  *	Allocate and initialize memory for this target.
  *	Save inquiry data.
  *
- *	Returns pointer to VirtDevice structure.
  */
-static VirtDevice *
+static void 
 mptscsih_initTarget(MPT_SCSI_HOST *hd, int bus_id, int target_id, u8 lun,
char *data, int dlen)
 {
 	VirtDevice	*vdev;
-	int		 sz;
 
 	dprintk((MYIOC_s_INFO_FMT "initTarget (%d,%d,%d) called, hd=%p\n",
 			hd->ioc->name, bus_id, target_id, lun, hd));
@@ -4986,6 +4985,7 @@
 		if ((vdev = kmalloc(sizeof(VirtDevice), GFP_ATOMIC)) ==
NULL) {
 			printk(MYIOC_s_ERR_FMT "initTarget kmalloc(%d)
FAILED!\n",
 					hd->ioc->name,
(int)sizeof(VirtDevice));
+			return;
 		} else {
 			memset(vdev, 0, sizeof(VirtDevice));
 			rwlock_init(&vdev->VdevLock);
@@ -5004,24 +5004,44 @@
 	}
 
 	vdev->raidVolume = 0;
-	if (vdev && hd->is_spi) {
+	if (hd->is_spi) {
 		if (hd->ioc->spi_data.isRaid & (1 << target_id)) {
 			vdev->raidVolume = 1;
 			ddvtprintk((KERN_INFO "RAID Volume @ id %d\n",
target_id));
 		}
 	}
 
-	if (vdev && data) {
-		if ((!(vdev->tflags & MPT_TARGET_FLAGS_VALID_INQUIRY)) ||
-		((dlen > 56) && (!(vdev->tflags &
MPT_TARGET_FLAGS_VALID_56)))) {
-
-			/* Copy the inquiry data  - if we haven't yet.
-			*/
-			sz = MIN(dlen, SCSI_STD_INQUIRY_BYTES);
+	if (!(vdev->tflags & MPT_TARGET_FLAGS_VALID_INQUIRY)) {
+		/* Copy the inquiry data  - if we haven't yet.
+		*/
+
+		memcpy (vdev->inq_data, data, 8);
 
-			memcpy (vdev->inq_data, data, sz);
+		if ( (data[0] == SCSI_TYPE_PROC) && 
+			!(vdev->tflags & MPT_TARGET_FLAGS_SAF_TE_ISSUED )) {
+			if ( dlen > 49 ) {
+				vdev->tflags |=
MPT_TARGET_FLAGS_VALID_INQUIRY;
+				if ( data[44] == 'S' && 
+				     data[45] == 'A' && 
+				     data[46] == 'F' && 
+				     data[47] == '-' && 
+				     data[48] == 'T' && 
+				     data[49] == 'E' ) {
+					vdev->tflags |=
MPT_TARGET_FLAGS_SAF_TE_ISSUED;
+					mptscsih_writeIOCPage4(hd,
target_id, bus_id);
+				}
+			} else {
+				/* Treat all Processors as SAF-TE if 
+				 * command line option is set */
+				if ( hd->ioc->spi_data.Saf_Te ) {
+					vdev->tflags |=
MPT_TARGET_FLAGS_SAF_TE_ISSUED;
+					mptscsih_writeIOCPage4(hd,
target_id, bus_id);
+				}
+			}
+		} else 
 			vdev->tflags |= MPT_TARGET_FLAGS_VALID_INQUIRY;
 
+		if ((dlen > 56) && (!(vdev->tflags &
MPT_TARGET_FLAGS_VALID_56))) {
 			/* Update the target capabilities
 			 */
 			if (dlen > 56) {
@@ -5038,17 +5058,16 @@
 					pSpi->dvStatus[target_id] |=
MPT_SCSICFG_NEED_DV;
 			}
 		}
-
-		/* Is LUN supported? If so, upper 3 bits will be 0
-		 * in first byte of inquiry data.
-		 */
-		if ((*data & 0xe0) == 0)
-			vdev->luns |= (1 << lun);
 	}
 
+	/* Is LUN supported? If so, upper 3 bits will be 0
+	 * in first byte of inquiry data.
+	 */
+	if ((*data & 0xe0) == 0)
+		vdev->luns |= (1 << lun);
 
 	dprintk((KERN_INFO "  target = %p\n", vdev));
-	return vdev;
+	return;
 }
 
 
/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=*/
@@ -5063,13 +5082,13 @@
 	int  id = (int) target->target_id;
 	int  nvram;
 	char canQ = 0;
+	VirtDevice	*vdev;
+	int ii;
 	u8 width = MPT_NARROW;
 	u8 factor = MPT_ASYNC;
 	u8 offset = 0;
 	u8 version, nfactor;
-	u8 noQas = 0;
-
-	ddvtprintk((KERN_INFO "set Target: (id %d) byte56 0x%x\n", id,
byte56));
+	u8 noQas = 1;
 
 	if (!hd->is_spi) {
 		if (target->tflags & MPT_TARGET_FLAGS_VALID_INQUIRY) {
@@ -5079,19 +5098,16 @@
 		return;
 	}
 
+	target->negoFlags = pspi_data->noQas;
+
 	/* noQas == 0 => device supports QAS. Need byte 56 of Inq to
determine
 	 * support. If available, default QAS to off and allow enabling.
 	 * If not available, default QAS to on, turn off for non-disks.
 	 */
-	if (target->tflags & MPT_TARGET_FLAGS_VALID_56)
-		noQas = 1;
 
 	/* Set flags based on Inquiry data
 	 */
 	if (target->tflags & MPT_TARGET_FLAGS_VALID_INQUIRY) {
-		if ((target->inq_data[0] & 0x1F) != 0x00)
-			noQas = 1;
-
 		version = target->inq_data[2] & 0x07;
 		if (version < 2) {
 			width = 0;
@@ -5111,6 +5127,7 @@
 					factor = MPT_ULTRA160;
 				else
 					factor = MPT_ULTRA320;
+				offset = pspi_data->maxSyncOffset;
 
 				/* If RAID, never disable QAS
 				 * else if non RAID, do not disable
@@ -5120,8 +5137,6 @@
 				 */
 				if ((target->raidVolume == 1) || ((byte56 &
0x02) != 0))
 					noQas = 0;
-
-				offset = pspi_data->maxSyncOffset;
 			} else {
 				factor = MPT_ASYNC;
 				offset = 0;
@@ -5180,35 +5195,31 @@
 
 		/* Disable unused features.
 		 */
-		target->negoFlags = pspi_data->noQas;
 		if (!width)
 			target->negoFlags |= MPT_TARGET_NO_NEGO_WIDE;
 
 		if (!offset)
 			target->negoFlags |= MPT_TARGET_NO_NEGO_SYNC;
 
-		if (noQas)
-			target->negoFlags |= MPT_TARGET_NO_NEGO_QAS;
-
 		/* GEM, processor WORKAROUND
 		 */
-		if (((target->inq_data[0] & 0x1F) == 0x03) ||
((target->inq_data[0] & 0x1F) > 0x08)){
+		if (((target->inq_data[0] & 0x1F) == 0x03) ||
((target->inq_data[0] & 0x1F) > 0x08)) {
 			target->negoFlags |= (MPT_TARGET_NO_NEGO_WIDE |
MPT_TARGET_NO_NEGO_SYNC);
 			pspi_data->dvStatus[id] |= MPT_SCSICFG_BLK_NEGO;
-		}
-
-		/* Disable QAS if mixed configuration case
-		 */
-		if ((noQas) && (!pspi_data->noQas) && ((target->inq_data[0]
& 0x1F) != 0x03)){
-			VirtDevice	*vdev;
-			int ii;
-
-			ddvtprintk((KERN_INFO "Disabling QAS!\n"));
-			pspi_data->noQas = MPT_TARGET_NO_NEGO_QAS;
-			for (ii = 0; ii < id; ii++) {
-				vdev = hd->Targets[id];
-				if (vdev != NULL)
-					vdev->negoFlags |=
MPT_TARGET_NO_NEGO_QAS;
+		} else {
+			if (noQas && (pspi_data->noQas == 0)) {
+				pspi_data->noQas |= MPT_TARGET_NO_NEGO_QAS;
+				target->negoFlags |= MPT_TARGET_NO_NEGO_QAS;
+
+				/* Disable QAS in a mixed configuration case
+		 		*/
+
+//				ddvtprintk((KERN_INFO "Disabling QAS!\n"));
+				for (ii = 0; ii < id; ii++) {
+					if ( (vdev = hd->Targets[ii]) ) {
+						vdev->negoFlags |=
MPT_TARGET_NO_NEGO_QAS;
+					}	
+				}
 			}
 		}
 	}
@@ -5515,6 +5526,86 @@
 }
 
 
/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=*/
+/*	mptscsih_writeIOCPage4  - write IOC Page 4
+ *	@hd: Pointer to a SCSI Host Structure
+ *	@target_id: write IOC Page4 for this ID & Bus
+ *
+ *	Return: -EAGAIN if unable to obtain a Message Frame
+ *		or 0 if success.
+ *
+ *	Remark: We do not wait for a return, write pages sequentially.
+ */
+static int
+mptscsih_writeIOCPage4(MPT_SCSI_HOST *hd, int target_id, int bus)
+{
+	MPT_ADAPTER		*ioc = hd->ioc;
+	Config_t		*pReq;
+	IOCPage4_t		*IOCPage4Ptr;
+	MPT_FRAME_HDR		*mf;
+	dma_addr_t		 dataDma;
+	u16			 req_idx;
+	u32			 frameOffset;
+	u32			 flagsLength;
+	int			 ii;
+
+	/* Get a MF for this command.
+	 */
+	if ((mf = mpt_get_msg_frame(ScsiDoneCtx, ioc->id)) == NULL) {
+		dprintk((MYIOC_s_WARN_FMT "writeIOCPage4 : no msg
frames!\n",
+					ioc->name));
+		return -EAGAIN;
+	}
+
+	ddvprintk((MYIOC_s_INFO_FMT "writeIOCPage4 (mf=%p, id=%d)\n",
+		ioc->name, mf, target_id));
+
+	/* Set the request and the data pointers.
+	 * Place data at end of MF.
+	 */
+	pReq = (Config_t *)mf;
+
+	req_idx = le16_to_cpu(mf->u.frame.hwhdr.msgctxu.fld.req_idx);
+	frameOffset = ioc->req_sz - sizeof(IOCPage4_t);
+
+	/* Complete the request frame (same for all requests).
+	 */
+	pReq->Action = MPI_CONFIG_ACTION_PAGE_WRITE_CURRENT;
+	pReq->Reserved = 0;
+	pReq->ChainOffset = 0;
+	pReq->Function = MPI_FUNCTION_CONFIG;
+	pReq->Reserved1[0] = 0;
+	pReq->Reserved1[1] = 0;
+	pReq->Reserved1[2] = 0;
+	pReq->MsgFlags = 0;
+	for (ii=0; ii < 8; ii++) {
+		pReq->Reserved2[ii] = 0;
+	}
+
+       	IOCPage4Ptr = ioc->spi_data.pIocPg4;
+       	dataDma = ioc->spi_data.IocPg4_dma;
+       	ii = IOCPage4Ptr->ActiveSEP++;
+       	IOCPage4Ptr->SEP[ii].SEPTargetID = target_id;
+       	IOCPage4Ptr->SEP[ii].SEPBus = bus;
+       	pReq->Header = IOCPage4Ptr->Header;
+	pReq->PageAddress = cpu_to_le32(target_id | (bus << 8 ));
+
+	/* Add a SGE to the config request.
+	 */
+	flagsLength = MPT_SGE_FLAGS_SSIMPLE_WRITE | 
+		(IOCPage4Ptr->Header.PageLength + ii) * 4;
+
+	mpt_add_sge((char *)&pReq->PageBufferSGE, flagsLength, dataDma);
+
+	dsprintk((MYIOC_s_INFO_FMT
+		"writeIOCPage4: pgaddr 0x%x\n",
+			ioc->name, (target_id | (bus<<8))));
+
+	mptscsih_put_msgframe(ScsiDoneCtx, ioc->id, mf);
+
+	return 0;
+}
+
+/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-=*/
 /*	mptscsih_taskmgmt_timeout - Call back for timeout on a
  *	task management request.
  *	@data: Pointer to MPT_SCSI_HOST recast as an unsigned long
@@ -6653,7 +6744,8 @@
 			if (nfactor < pspi_data->minSyncFactor )
 				nfactor = pspi_data->minSyncFactor;
 	
-			if (!(pspi_data->nvram[id] &
MPT_NVRAM_ID_SCAN_ENABLE)) {
+			if (!(pspi_data->nvram[id] &
MPT_NVRAM_ID_SCAN_ENABLE) ||
+				(pspi_data->PortFlags ==
MPI_SCSIPORTPAGE2_PORT_FLAGS_OFF_DV) ) {
 	
 				ddvprintk((MYIOC_s_NOTE_FMT "DV Skipped:
bus, id, lun (%d, %d, %d)\n",
 					ioc->name, bus, id, lun));
@@ -6921,6 +7013,9 @@
 	if (inq0 != 0)
 		goto target_done;
 
+	if ( ioc->spi_data.PortFlags ==
MPI_SCSIPORTPAGE2_PORT_FLAGS_BASIC_DV_ONLY )
+		goto target_done;
+
 	/* Start the Enhanced Test.
 	 * 0) issue TUR to clear out check conditions
 	 * 1) read capacity of echo (regular) buffer
@@ -7762,9 +7857,9 @@
 /* Commandline Parsing routines and defines.
  *
  * insmod format:
- *	insmod mptscsih mptscsih="width:1 dv:n factor:0x09"
+ *	insmod mptscsih mptscsih="width:1 dv:n factor:0x09 saf-te:1"
  *  boot format:
- *	mptscsih=width:1,dv:n,factor:0x8
+ *	mptscsih=width:1,dv:n,factor:0x8,saf-te:1
  *
  */
 #ifdef MODULE
@@ -7777,11 +7872,13 @@
 	"dv:"
 	"width:"
 	"factor:"
-       ;	/* DONNOT REMOVE THIS ';' */
+	"saf-te:"
+       ;	/* DO NOT REMOVE THIS ';' */
 
 #define OPT_DV			1
 #define OPT_MAX_WIDTH		2
 #define OPT_MIN_SYNC_FACTOR	3
+#define OPT_SAF_TE		4
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 static int
@@ -7838,6 +7935,10 @@
 			driver_setup.min_sync_fac = val;
 			break;
 
+		case OPT_SAF_TE:
+			driver_setup.saf_te = val;
+			break;
+
 		default:
 			printk("mptscsih_setup: unexpected boot option
'%.*s' ignored\n", (int)(pc-cur+1), cur);
 			break;
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/mptscsih.h
linux-2.4.23-pre8/drivers/message/fusion/mptscsih.h
--- linux-2.4.23-pre8-reference/drivers/message/fusion/mptscsih.h
2003-08-25 05:44:42.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/mptscsih.h	2003-10-23
12:36:21.000000000 -0600
@@ -18,7 +18,7 @@
  *  Copyright (c) 1999-2002 LSI Logic Corporation
  *  Originally By: Steven J. Ralston
  *  (mailto:sjralston1@netscape.net)
- *  (mailto:lstephens@lsil.com)
+ *  (mailto:mpt_linux_developer@lsil.com)
  *
  *  $Id: mptscsih.h,v 1.1.2.2 2003/05/07 14:08:35 pdelaney Exp $
  */
@@ -116,12 +116,14 @@
 #define MPTSCSIH_DOMAIN_VALIDATION      1
 #define MPTSCSIH_MAX_WIDTH              1
 #define MPTSCSIH_MIN_SYNC               0x08
+#define MPTSCSIH_SAF_TE                 0
 
 struct mptscsih_driver_setup
 {
         u8      dv;
         u8      max_width;
         u8      min_sync_fac;
+        u8      saf_te;
 };
 
 
@@ -130,6 +132,7 @@
         MPTSCSIH_DOMAIN_VALIDATION,             \
         MPTSCSIH_MAX_WIDTH,                     \
         MPTSCSIH_MIN_SYNC,                      \
+        MPTSCSIH_SAF_TE,                        \
 }
 
 
diff -uarN linux-2.4.23-pre8-reference/drivers/message/fusion/scsi3.h
linux-2.4.23-pre8/drivers/message/fusion/scsi3.h
--- linux-2.4.23-pre8-reference/drivers/message/fusion/scsi3.h	2003-08-25
05:44:42.000000000 -0600
+++ linux-2.4.23-pre8/drivers/message/fusion/scsi3.h	2003-10-23
12:36:21.000000000 -0600
@@ -7,7 +7,7 @@
  *  Copyright (c) 1996-2002 Steven J. Ralston
  *  Written By: Steven J. Ralston (19960517)
  *  (mailto:sjralston1@netscape.net)
- *  (mailto:lstephens@lsil.com)
+ *  (mailto:mpt_linux_developer@lsil.com)
  *
  *  $Id: scsi3.h,v 1.9 2002/02/27 18:45:02 sralston Exp $
  */


