Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUDTP6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUDTP6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 11:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUDTP6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 11:58:49 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:58789 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263134AbUDTP6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 11:58:10 -0400
Date: Tue, 20 Apr 2004 17:58:07 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Martin Mares <mj@ucw.cz>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] pciutils/linux: Support for the HyperTransport capability
Message-ID: <Pine.LNX.4.55.0404201720290.28193@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 Here's a patch for initial support for the HyperTransport capability for
pciutils.  I've developed full dumping code for the sub-capabilities I was
able to test (plus for the Revision ID one, for it being so trivial) with
my hardware.  Others are reported by their names only, without any details
-- for a few of them it's probably most we can do anyway.

 The changes for lib/header.h are probably applicable to <linux/pci.h> as 
well -- they apply cleanly to 2.4, but require a manual intervention for 
2.6 due to context changes.  I'll rediff if this patch is accepted for 
Linux.

 Here's some output from lspci for the devices I have:

00:01.0 Host bridge: Broadcom Corporation SiByte BCM1125H/1250 System-on-a-Chip HyperTransport (rev 02)
	!!! Invalid class 0600 for header type 01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
	I/O behind bridge: 00001000-00000fff
	Memory behind bridge: 00100000-000fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide- Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 0.17
		Link Frequency: 400MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP- CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-

01:01.0 PCI bridge: Alpha Processor Inc AP1011 HyperTransport-PCI Bridge [Sturgeon] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 08
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00001000-00000fff
	Memory behind bridge: 00100000-000fffff
	Prefetchable memory behind bridge: 0000000000100000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B+
	Capabilities: [40] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=1 UnitCnt=1 MastHost- DefDir- DUL-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail- Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 0.17
		Link Frequency 0: 200MHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE+ EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00

 The devices predate the initial published spec revision, which is 1.02,
so certain bits seem to be set incorrectly, e.g. the Link Frequency
Capability, which reports no supported frequencies, not even the mandatory
200MHz.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

pciutils-2.1.11-ht.patch
diff -up --recursive --new-file pciutils-2.1.11.macro/lib/header.h pciutils-2.1.11/lib/header.h
--- pciutils-2.1.11.macro/lib/header.h	2002-12-26 20:24:50.000000000 +0000
+++ pciutils-2.1.11/lib/header.h	2004-04-20 15:45:56.000000000 +0000
@@ -186,6 +186,7 @@
 #define  PCI_CAP_ID_MSI		0x05	/* Message Signalled Interrupts */
 #define  PCI_CAP_ID_CHSWP	0x06	/* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX        0x07    /* PCI-X */
+#define  PCI_CAP_ID_HT          0x08    /* HyperTransport */
 #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
 #define PCI_CAP_FLAGS		2	/* Capability defined flags (16 bits) */
 #define PCI_CAP_SIZEOF		4
@@ -318,6 +319,350 @@
 #define PCI_PCIX_BRIDGE_STR_COMMITMENT_LIMIT                   0xffff0000
 #define PCI_PCIX_BRIDGE_SIZEOF 12
 
+/* HyperTransport */
+#define PCI_HT_CMD		2	/* Command Register */
+#define  PCI_HT_CMD_TYP_HI	0xe000	/* Capability Type high part */
+#define  PCI_HT_CMD_TYP_HI_PRI	0x0000	/* Slave or Primary Interface */
+#define  PCI_HT_CMD_TYP_HI_SEC	0x2000	/* Host or Secondary Interface */
+#define  PCI_HT_CMD_TYP		0xf800	/* Capability Type */
+#define  PCI_HT_CMD_TYP_SW	0x4000	/* Switch */
+#define  PCI_HT_CMD_TYP_IDC	0x8000	/* Interrupt Discovery and Configuration */
+#define  PCI_HT_CMD_TYP_RID	0x8800	/* Revision ID */
+#define  PCI_HT_CMD_TYP_UIDC	0x9000	/* UnitID Clumping */
+#define  PCI_HT_CMD_TYP_ECSA	0x9800	/* Extended Configuration Space Access */
+#define  PCI_HT_CMD_TYP_AM	0xa000	/* Address Mapping */
+#define  PCI_HT_CMD_TYP_MSIM	0xa800	/* MSI Mapping */
+#define  PCI_HT_CMD_TYP_DR	0xb000	/* DirectRoute */
+#define  PCI_HT_CMD_TYP_VCS	0xb800	/* VCSet */
+#define  PCI_HT_CMD_TYP_RM	0xc000	/* Retry Mode */
+#define  PCI_HT_CMD_TYP_X86	0xc800	/* X86 (reserved) */
+
+					/* Link Control Register */
+#define  PCI_HT_LCTR_CFLE	0x0002	/* CRC Flood Enable */
+#define  PCI_HT_LCTR_CST	0x0004	/* CRC Start Test */
+#define  PCI_HT_LCTR_CFE	0x0008	/* CRC Force Error */
+#define  PCI_HT_LCTR_LKFAIL	0x0010	/* Link Failure */
+#define  PCI_HT_LCTR_INIT	0x0020	/* Initialization Complete */
+#define  PCI_HT_LCTR_EOC	0x0040	/* End of Chain */
+#define  PCI_HT_LCTR_TXO	0x0080	/* Transmitter Off */
+#define  PCI_HT_LCTR_CRCERR	0x0f00	/* CRC Error */
+#define  PCI_HT_LCTR_ISOCEN	0x1000	/* Isochronous Flow Control Enable */
+#define  PCI_HT_LCTR_LSEN	0x2000	/* LDTSTOP# Tristate Enable */
+#define  PCI_HT_LCTR_EXTCTL	0x4000	/* Extended CTL Time */
+#define  PCI_HT_LCTR_64B	0x8000	/* 64-bit Addressing Enable */
+
+					/* Link Configuration Register */
+#define  PCI_HT_LCNF_MLWI	0x0007	/* Max Link Width In */
+#define  PCI_HT_LCNF_LW_8B	0x0	/* Link Width 8 bits */
+#define  PCI_HT_LCNF_LW_16B	0x1	/* Link Width 16 bits */
+#define  PCI_HT_LCNF_LW_32B	0x3	/* Link Width 32 bits */
+#define  PCI_HT_LCNF_LW_2B	0x4	/* Link Width 2 bits */
+#define  PCI_HT_LCNF_LW_4B	0x5	/* Link Width 4 bits */
+#define  PCI_HT_LCNF_LW_NC	0x7	/* Link physically not connected */
+#define  PCI_HT_LCNF_DFI	0x0008	/* Doubleword Flow Control In */
+#define  PCI_HT_LCNF_MLWO	0x0070	/* Max Link Width Out */
+#define  PCI_HT_LCNF_DFO	0x0080	/* Doubleword Flow Control Out */
+#define  PCI_HT_LCNF_LWI	0x0700	/* Link Width In */
+#define  PCI_HT_LCNF_DFIE	0x0800	/* Doubleword Flow Control In Enable */
+#define  PCI_HT_LCNF_LWO	0x7000	/* Link Width Out */
+#define  PCI_HT_LCNF_DFOE	0x8000	/* Doubleword Flow Control Out Enable */
+
+					/* Revision ID Register */
+#define  PCI_HT_RID_MIN		0x1f	/* Minor Revision */
+#define  PCI_HT_RID_MAJ		0xe0	/* Major Revision */
+
+					/* Link Frequency/Error Register */
+#define  PCI_HT_LFRER_FREQ	0x0f	/* Transmitter Clock Frequency */
+#define  PCI_HT_LFRER_200	0x00	/* 200MHz */
+#define  PCI_HT_LFRER_300	0x01	/* 300MHz */
+#define  PCI_HT_LFRER_400	0x02	/* 400MHz */
+#define  PCI_HT_LFRER_500	0x03	/* 500MHz */
+#define  PCI_HT_LFRER_600	0x04	/* 600MHz */
+#define  PCI_HT_LFRER_800	0x05	/* 800MHz */
+#define  PCI_HT_LFRER_1000	0x06	/* 1.0GHz */
+#define  PCI_HT_LFRER_1200	0x07	/* 1.2GHz */
+#define  PCI_HT_LFRER_1400	0x08	/* 1.4GHz */
+#define  PCI_HT_LFRER_1600	0x09	/* 1.6GHz */
+#define  PCI_HT_LFRER_VEND	0x0f	/* Vendor-Specific */
+#define  PCI_HT_LFRER_ERR	0xf0	/* Link Error */
+#define  PCI_HT_LFRER_PROT	0x10	/* Protocol Error */
+#define  PCI_HT_LFRER_OV	0x20	/* Overflow Error */
+#define  PCI_HT_LFRER_EOC	0x40	/* End of Chain Error */
+#define  PCI_HT_LFRER_CTLT	0x80	/* CTL Timeout */
+
+					/* Link Frequency Capability Register */
+#define  PCI_HT_LFCAP_200	0x0001	/* 200MHz */
+#define  PCI_HT_LFCAP_300	0x0002	/* 300MHz */
+#define  PCI_HT_LFCAP_400	0x0004	/* 400MHz */
+#define  PCI_HT_LFCAP_500	0x0008	/* 500MHz */
+#define  PCI_HT_LFCAP_600	0x0010	/* 600MHz */
+#define  PCI_HT_LFCAP_800	0x0020	/* 800MHz */
+#define  PCI_HT_LFCAP_1000	0x0040	/* 1.0GHz */
+#define  PCI_HT_LFCAP_1200	0x0080	/* 1.2GHz */
+#define  PCI_HT_LFCAP_1400	0x0100	/* 1.4GHz */
+#define  PCI_HT_LFCAP_1600	0x0200	/* 1.6GHz */
+#define  PCI_HT_LFCAP_VEND	0x8000	/* Vendor-Specific */
+
+					/* Feature Register */
+#define  PCI_HT_FTR_ISOCFC	0x0001	/* Isochronous Flow Control Mode */
+#define  PCI_HT_FTR_LDTSTOP	0x0002	/* LDTSTOP# Supported */
+#define  PCI_HT_FTR_CRCTM	0x0004	/* CRC Test Mode */
+#define  PCI_HT_FTR_ECTLT	0x0008	/* Extended CTL Time Required */
+#define  PCI_HT_FTR_64BA	0x0010	/* 64-bit Addressing */
+#define  PCI_HT_FTR_UIDRD	0x0020	/* UnitID Reorder Disable */
+
+					/* Error Handling Register */
+#define  PCI_HT_EH_PFLE		0x0001	/* Protocol Error Flood Enable */
+#define  PCI_HT_EH_OFLE		0x0002	/* Overflow Error Flood Enable */
+#define  PCI_HT_EH_PFE		0x0004	/* Protocol Error Fatal Enable */
+#define  PCI_HT_EH_OFE		0x0008	/* Overflow Error Fatal Enable */
+#define  PCI_HT_EH_EOCFE	0x0010	/* End of Chain Error Fatal Enable */
+#define  PCI_HT_EH_RFE		0x0020	/* Response Error Fatal Enable */
+#define  PCI_HT_EH_CRCFE	0x0040	/* CRC Error Fatal Enable */
+#define  PCI_HT_EH_SERRFE	0x0080	/* System Error Fatal Enable (B */
+#define  PCI_HT_EH_CF		0x0100	/* Chain Fail */
+#define  PCI_HT_EH_RE		0x0200	/* Response Error */
+#define  PCI_HT_EH_PNFE		0x0400	/* Protocol Error Nonfatal Enable */
+#define  PCI_HT_EH_ONFE		0x0800	/* Overflow Error Nonfatal Enable */
+#define  PCI_HT_EH_EOCNFE	0x1000	/* End of Chain Error Nonfatal Enable */
+#define  PCI_HT_EH_RNFE		0x2000	/* Response Error Nonfatal Enable */
+#define  PCI_HT_EH_CRCNFE	0x4000	/* CRC Error Nonfatal Enable */
+#define  PCI_HT_EH_SERRNFE	0x8000	/* System Error Nonfatal Enable */
+
+/* HyperTransport: Slave or Primary Interface */
+#define PCI_HT_PRI_CMD		2	/* Command Register */
+#define  PCI_HT_PRI_CMD_BUID	0x001f	/* Base UnitID */
+#define  PCI_HT_PRI_CMD_UC	0x03e0	/* Unit Count */
+#define  PCI_HT_PRI_CMD_MH	0x0400	/* Master Host */
+#define  PCI_HT_PRI_CMD_DD	0x0800	/* Default Direction */
+#define  PCI_HT_PRI_CMD_DUL	0x1000	/* Drop on Uninitialized Link */
+
+#define PCI_HT_PRI_LCTR0	4	/* Link Control 0 Register */
+#define PCI_HT_PRI_LCNF0	6	/* Link Config 0 Register */
+#define PCI_HT_PRI_LCTR1	8	/* Link Control 1 Register */
+#define PCI_HT_PRI_LCNF1	10	/* Link Config 1 Register */
+#define PCI_HT_PRI_RID		12	/* Revision ID Register */
+#define PCI_HT_PRI_LFRER0	13	/* Link Frequency/Error 0 Register */
+#define PCI_HT_PRI_LFCAP0	14	/* Link Frequency Capability 0 Register */
+#define PCI_HT_PRI_FTR		16	/* Feature Register */
+#define PCI_HT_PRI_LFRER1	17	/* Link Frequency/Error 1 Register */
+#define PCI_HT_PRI_LFCAP1	18	/* Link Frequency Capability 1 Register */
+#define PCI_HT_PRI_ES		20	/* Enumeration Scratchpad Register */
+#define PCI_HT_PRI_EH		22	/* Error Handling Register */
+#define PCI_HT_PRI_MBU		24	/* Memory Base Upper Register */
+#define PCI_HT_PRI_MLU		25	/* Memory Limit Upper Register */
+#define PCI_HT_PRI_BN		26	/* Bus Number Register */
+#define PCI_HT_PRI_SIZEOF	28
+
+/* HyperTransport: Host or Secondary Interface */
+#define PCI_HT_SEC_CMD		2	/* Command Register */
+#define  PCI_HT_SEC_CMD_WR	0x0001	/* Warm Reset */
+#define  PCI_HT_SEC_CMD_DE	0x0002	/* Double-Ended */
+#define  PCI_HT_SEC_CMD_DN	0x0076	/* Device Number */
+#define  PCI_HT_SEC_CMD_CS	0x0080	/* Chain Side */
+#define  PCI_HT_SEC_CMD_HH	0x0100	/* Host Hide */
+#define  PCI_HT_SEC_CMD_AS	0x0400	/* Act as Slave */
+#define  PCI_HT_SEC_CMD_HIECE	0x0800	/* Host Inbound End of Chain Error */
+#define  PCI_HT_SEC_CMD_DUL	0x1000	/* Drop on Uninitialized Link */
+
+#define PCI_HT_SEC_LCTR		4	/* Link Control Register */
+#define PCI_HT_SEC_LCNF		6	/* Link Config Register */
+#define PCI_HT_SEC_RID		8	/* Revision ID Register */
+#define PCI_HT_SEC_LFRER	9	/* Link Frequency/Error Register */
+#define PCI_HT_SEC_LFCAP	10	/* Link Frequency Capability Register */
+#define PCI_HT_SEC_FTR		12	/* Feature Register */
+#define  PCI_HT_SEC_FTR_EXTRS	0x0100	/* Extended Register Set */
+#define  PCI_HT_SEC_FTR_UCNFE	0x0200	/* Upstream Configuration Enable */
+#define PCI_HT_SEC_ES		16	/* Enumeration Scratchpad Register */
+#define PCI_HT_SEC_EH		18	/* Error Handling Register */
+#define PCI_HT_SEC_MBU		20	/* Memory Base Upper Register */
+#define PCI_HT_SEC_MLU		21	/* Memory Limit Upper Register */
+#define PCI_HT_SEC_SIZEOF	24
+
+/* HyperTransport: Switch */
+#define PCI_HT_SW_CMD		2	/* Switch Command Register */
+#define  PCI_HT_SW_CMD_VIBERR	0x0080	/* VIB Error */
+#define  PCI_HT_SW_CMD_VIBFL	0x0100	/* VIB Flood */
+#define  PCI_HT_SW_CMD_VIBFT	0x0200	/* VIB Fatal */
+#define  PCI_HT_SW_CMD_VIBNFT	0x0400	/* VIB Nonfatal */
+#define PCI_HT_SW_PMASK		4	/* Partition Mask Register */
+#define PCI_HT_SW_SWINF		8	/* Switch Info Register */
+#define  PCI_HT_SW_SWINF_DP	0x0000001f /* Default Port */
+#define  PCI_HT_SW_SWINF_EN	0x00000020 /* Enable Decode */
+#define  PCI_HT_SW_SWINF_CR	0x00000040 /* Cold Reset */
+#define  PCI_HT_SW_SWINF_PCIDX	0x00000f00 /* Performance Counter Index */
+#define  PCI_HT_SW_SWINF_BLRIDX	0x0003f000 /* Base/Limit Range Index */
+#define  PCI_HT_SW_SWINF_SBIDX	0x00002000 /* Secondary Base Range Index */
+#define  PCI_HT_SW_SWINF_HP	0x00040000 /* Hot Plug */
+#define  PCI_HT_SW_SWINF_HIDE	0x00080000 /* Hide Port */
+#define PCI_HT_SW_PCD		12	/* Performance Counter Data Register */
+#define PCI_HT_SW_BLRD		16	/* Base/Limit Range Data Register */
+#define PCI_HT_SW_SBD		20	/* Secondary Base Data Register */
+#define PCI_HT_SW_SIZEOF	24
+
+					/* Counter indices */
+#define  PCI_HT_SW_PC_PCR	0x0	/* Posted Command Receive */
+#define  PCI_HT_SW_PC_NPCR	0x1	/* Nonposted Command Receive */
+#define  PCI_HT_SW_PC_RCR	0x2	/* Response Command Receive */
+#define  PCI_HT_SW_PC_PDWR	0x3	/* Posted DW Receive */
+#define  PCI_HT_SW_PC_NPDWR	0x4	/* Nonposted DW Receive */
+#define  PCI_HT_SW_PC_RDWR	0x5	/* Response DW Receive */
+#define  PCI_HT_SW_PC_PCT	0x6	/* Posted Command Transmit */
+#define  PCI_HT_SW_PC_NPCT	0x7	/* Nonposted Command Transmit */
+#define  PCI_HT_SW_PC_RCT	0x8	/* Response Command Transmit */
+#define  PCI_HT_SW_PC_PDWT	0x9	/* Posted DW Transmit */
+#define  PCI_HT_SW_PC_NPDWT	0xa	/* Nonposted DW Transmit */
+#define  PCI_HT_SW_PC_RDWT	0xb	/* Response DW Transmit */
+
+					/* Base/Limit Range indices */
+#define  PCI_HT_SW_BLR_BASE0_LO	0x0	/* Base 0[31:1], Enable */
+#define  PCI_HT_SW_BLR_BASE0_HI	0x1	/* Base 0 Upper */
+#define  PCI_HT_SW_BLR_LIM0_LO	0x2	/* Limit 0 Lower */
+#define  PCI_HT_SW_BLR_LIM0_HI	0x3	/* Limit 0 Upper */
+
+					/* Secondary Base indices */
+#define  PCI_HT_SW_SB_LO	0x0	/* Secondary Base[31:1], Enable */
+#define  PCI_HT_SW_S0_HI	0x1	/* Secondary Base Upper */
+
+/* HyperTransport: Interrupt Discovery and Configuration */
+#define PCI_HT_IDC_IDX		2	/* Index Register */
+#define PCI_HT_IDC_DATA		4	/* Data Register */
+#define PCI_HT_IDC_SIZEOF	8
+
+					/* Register indices */
+#define  PCI_HT_IDC_IDX_LINT	0x01	/* Last Interrupt Register */
+#define   PCI_HT_IDC_LINT	0x00ff0000 /* Last interrupt definition */
+#define  PCI_HT_IDC_IDX_IDR	0x10	/* Interrupt Definition Registers */
+					/* Low part (at index) */
+#define   PCI_HT_IDC_IDR_MASK	0x10000001 /* Mask */
+#define   PCI_HT_IDC_IDR_POL	0x10000002 /* Polarity */
+#define   PCI_HT_IDC_IDR_II_2	0x1000001c /* IntrInfo[4:2]: Message Type */
+#define   PCI_HT_IDC_IDR_II_5	0x10000020 /* IntrInfo[5]: Request EOI */
+#define   PCI_HT_IDC_IDR_II_6	0x00ffffc0 /* IntrInfo[23:6] */
+#define   PCI_HT_IDC_IDR_II_24	0xff000000 /* IntrInfo[31:24] */
+					/* High part (at index + 1) */
+#define   PCI_HT_IDC_IDR_II_32	0x00ffffff /* IntrInfo[55:32] */
+#define   PCI_HT_IDC_IDR_PASSPW	0x40000000 /* PassPW setting for messages */
+#define   PCI_HT_IDC_IDR_WEOI	0x80000000 /* Waiting for EOI */
+
+/* HyperTransport: Revision ID */
+#define PCI_HT_RID_RID		2	/* Revision Register */
+#define PCI_HT_RID_SIZEOF	4
+
+/* HyperTransport: UnitID Clumping */
+#define PCI_HT_UIDC_CS		4	/* Clumping Support Register */
+#define PCI_HT_UIDC_CE		8	/* Clumping Enable Register */
+#define PCI_HT_UIDC_SIZEOF	12
+
+/* HyperTransport: Extended Configuration Space Access */
+#define PCI_HT_ECSA_ADDR	4	/* Configuration Address Register */
+#define  PCI_HT_ECSA_ADDR_REG	0x00000ffc /* Register */
+#define  PCI_HT_ECSA_ADDR_FUN	0x00007000 /* Function */
+#define  PCI_HT_ECSA_ADDR_DEV	0x000f1000 /* Device */
+#define  PCI_HT_ECSA_ADDR_BUS	0x0ff00000 /* Bus Number */
+#define  PCI_HT_ECSA_ADDR_TYPE	0x10000000 /* Access Type */
+#define PCI_HT_ECSA_DATA	8	/* Configuration Data Register */
+#define PCI_HT_ECSA_SIZEOF	12
+
+/* HyperTransport: Address Mapping */
+#define PCI_HT_AM_CMD		2	/* Command Register */
+#define  PCI_HT_AM_CMD_NDMA	0x000f	/* Number of DMA Mappings */
+#define  PCI_HT_AM_CMD_IOSIZ	0x01f0	/* I/O Size */
+#define  PCI_HT_AM_CMD_MT	0x0600	/* Map Type */
+#define  PCI_HT_AM_CMD_MT_40B	0x0000	/* 40-bit */
+#define  PCI_HT_AM_CMD_MT_64B	0x0200	/* 64-bit */
+
+					/* Window Control Register bits */
+#define  PCI_HT_AM_SBW_CTR_COMP	0x1	/* Compat */
+#define  PCI_HT_AM_SBW_CTR_NCOH	0x2	/* NonCoherent */
+#define  PCI_HT_AM_SBW_CTR_ISOC	0x4	/* Isochronous */
+#define  PCI_HT_AM_SBW_CTR_EN	0x8	/* Enable */
+
+/* HyperTransport: 40-bit Address Mapping */
+#define PCI_HT_AM40_SBNPW	4	/* Secondary Bus Non-Prefetchable Window Register */
+#define  PCI_HT_AM40_SBW_BASE	0x000fffff /* Window Base */
+#define  PCI_HT_AM40_SBW_CTR	0xf0000000 /* Window Control */
+#define PCI_HT_AM40_SBPW	8	/* Secondary Bus Prefetchable Window Register */
+#define PCI_HT_AM40_DMA_PBASE0	12	/* DMA Window Primary Base 0 Register */
+#define PCI_HT_AM40_DMA_CTR0	15	/* DMA Window Control 0 Register */
+#define  PCI_HT_AM40_DMA_CTR_CTR 0xf0	/* Window Control */
+#define PCI_HT_AM40_DMA_SLIM0	16	/* DMA Window Secondary Limit 0 Register */
+#define PCI_HT_AM40_DMA_SBASE0	18	/* DMA Window Secondary Base 0 Register */
+#define PCI_HT_AM40_SIZEOF	12	/* size is variable: 12 + 8 * NDMA */
+
+/* HyperTransport: 64-bit Address Mapping */
+#define PCI_HT_AM64_IDX		4	/* Index Register */
+#define PCI_HT_AM64_DATA_LO	8	/* Data Lower Register */
+#define PCI_HT_AM64_DATA_HI	12	/* Data Upper Register */
+#define PCI_HT_AM64_SIZEOF	16
+
+					/* Register indices */
+#define  PCI_HT_AM64_IDX_SBNPW	0x00	/* Secondary Bus Non-Prefetchable Window Register */
+#define   PCI_HT_AM64_W_BASE_LO	0xfff00000 /* Window Base Lower */
+#define   PCI_HT_AM64_W_CTR	0x0000000f /* Window Control */
+#define  PCI_HT_AM64_IDX_SBPW	0x01	/* Secondary Bus Prefetchable Window Register */
+#define   PCI_HT_AM64_IDX_PBNPW	0x02	/* Primary Bus Non-Prefetchable Window Register */
+#define   PCI_HT_AM64_IDX_DMAPB0 0x04	/* DMA Window Primary Base 0 Register */
+#define   PCI_HT_AM64_IDX_DMASB0 0x05	/* DMA Window Secondary Base 0 Register */
+#define   PCI_HT_AM64_IDX_DMASL0 0x06	/* DMA Window Secondary Limit 0 Register */
+
+/* HyperTransport: MSI Mapping */
+#define PCI_HT_MSIM_CMD		2	/* Command Register */
+#define  PCI_HT_MSIM_CMD_EN	0x0001	/* Mapping Active */
+#define  PCI_HT_MSIM_CMD_FIXD	0x0002	/* MSI Mapping Address Fixed */
+#define PCI_HT_MSIM_ADDR_LO	4	/* MSI Mapping Address Lower Register */
+#define PCI_HT_MSIM_ADDR_HI	8	/* MSI Mapping Address Upper Register */
+#define PCI_HT_MSIM_SIZEOF	12
+
+/* HyperTransport: DirectRoute */
+#define PCI_HT_DR_CMD		2	/* Command Register */
+#define  PCI_HT_DR_CMD_NDRS	0x000f	/* Number of DirectRoute Spaces */
+#define  PCI_HT_DR_CMD_IDX	0x01f0	/* Index */
+#define PCI_HT_DR_EN		4	/* Enable Vector Register */
+#define PCI_HT_DR_DATA		8	/* Data Register */
+#define PCI_HT_DR_SIZEOF	12
+
+					/* Register indices */
+#define  PCI_HT_DR_IDX_BASE_LO	0x00	/* DirectRoute Base Lower Register */
+#define   PCI_HT_DR_OTNRD	0x00000001 /* Opposite to Normal Request Direction */
+#define   PCI_HT_DR_BL_LO	0xffffff00 /* Base/Limit Lower */
+#define  PCI_HT_DR_IDX_BASE_HI	0x01	/* DirectRoute Base Upper Register */
+#define  PCI_HT_DR_IDX_LIMIT_LO	0x02	/* DirectRoute Limit Lower Register */
+#define  PCI_HT_DR_IDX_LIMIT_HI	0x03	/* DirectRoute Limit Upper Register */
+
+/* HyperTransport: VCSet */
+#define PCI_HT_VCS_SUP		4	/* VCSets Supported Register */
+#define PCI_HT_VCS_L1EN		5	/* Link 1 VCSets Enabled Register */
+#define PCI_HT_VCS_L0EN		6	/* Link 0 VCSets Enabled Register */
+#define PCI_HT_VCS_SBD		8	/* Stream Bucket Depth Register */
+#define PCI_HT_VCS_SINT		9	/* Stream Interval Register */
+#define PCI_HT_VCS_SSUP		10	/* Number of Streaming VCs Supported Register */
+#define  PCI_HT_VCS_SSUP_0	0x00	/* Streaming VC 0 */
+#define  PCI_HT_VCS_SSUP_3	0x01	/* Streaming VCs 0-3 */
+#define  PCI_HT_VCS_SSUP_15	0x02	/* Streaming VCs 0-15 */
+#define PCI_HT_VCS_NFCBD	12	/* Non-FC Bucket Depth Register */
+#define PCI_HT_VCS_NFCINT	13	/* Non-FC Bucket Interval Register */
+#define PCI_HT_VCS_SIZEOF	16
+
+/* HyperTransport: Retry Mode */
+#define PCI_HT_RM_CTR0		4	/* Control 0 Register */
+#define  PCI_HT_RM_CTR_LRETEN	0x01	/* Link Retry Enable */
+#define  PCI_HT_RM_CTR_FSER	0x02	/* Force Single Error */
+#define  PCI_HT_RM_CTR_ROLNEN	0x04	/* Rollover Nonfatal Enable */
+#define  PCI_HT_RM_CTR_FSS	0x08	/* Force Single Stomp */
+#define  PCI_HT_RM_CTR_RETNEN	0x10	/* Retry Nonfatal Enable */
+#define  PCI_HT_RM_CTR_RETFEN	0x20	/* Retry Fatal Enable */
+#define  PCI_HT_RM_CTR_AA	0xc0	/* Allowed Attempts */
+#define PCI_HT_RM_STS0		5	/* Status 0 Register */
+#define  PCI_HT_RM_STS_RETSNT	0x01	/* Retry Sent */
+#define  PCI_HT_RM_STS_CNTROL	0x02	/* Count Rollover */
+#define  PCI_HT_RM_STS_SRCV	0x04	/* Stomp Received */
+#define PCI_HT_RM_CTR1		6	/* Control 1 Register */
+#define PCI_HT_RM_STS1		7	/* Status 1 Register */
+#define PCI_HT_RM_CNT0		8	/* Retry Count 0 Register */
+#define PCI_HT_RM_CNT1		10	/* Retry Count 1 Register */
+#define PCI_HT_RM_SIZEOF	12
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
diff -up --recursive --new-file pciutils-2.1.11.macro/lspci.c pciutils-2.1.11/lspci.c
--- pciutils-2.1.11.macro/lspci.c	2002-12-26 20:24:50.000000000 +0000
+++ pciutils-2.1.11/lspci.c	2004-04-19 00:42:36.000000000 +0000
@@ -554,6 +554,406 @@ show_pcix(struct device *d, int where)
 }
 
 static void
+format_ht_link_width(char width, char *buf)
+{
+  switch (width) {
+  case PCI_HT_LCNF_LW_2B:
+    strcpy(buf, "2bit");
+    break;
+  case PCI_HT_LCNF_LW_4B:
+    strcpy(buf, "4bit");
+    break;
+  case PCI_HT_LCNF_LW_8B:
+    strcpy(buf, "8bit");
+    break;
+  case PCI_HT_LCNF_LW_16B:
+    strcpy(buf, "16bit");
+    break;
+  case PCI_HT_LCNF_LW_32B:
+    strcpy(buf, "32bit");
+    break;
+  case PCI_HT_LCNF_LW_NC:
+    strcpy(buf, "N/C");
+    break;
+  default:
+    sprintf(buf, "[%u]", width);
+    break;
+  }
+}
+
+static void
+format_ht_link_freq(char freq, char *buf)
+{
+  switch (freq) {
+  case PCI_HT_LFRER_200:
+    strcpy(buf, "200MHz");
+    break;
+  case PCI_HT_LFRER_300:
+    strcpy(buf, "300MHz");
+    break;
+  case PCI_HT_LFRER_400:
+    strcpy(buf, "400MHz");
+    break;
+  case PCI_HT_LFRER_500:
+    strcpy(buf, "500MHz");
+    break;
+  case PCI_HT_LFRER_600:
+    strcpy(buf, "600MHz");
+    break;
+  case PCI_HT_LFRER_800:
+    strcpy(buf, "800MHz");
+    break;
+  case PCI_HT_LFRER_1000:
+    strcpy(buf, "1.0GHz");
+    break;
+  case PCI_HT_LFRER_1200:
+    strcpy(buf, "1.2GHz");
+    break;
+  case PCI_HT_LFRER_1400:
+    strcpy(buf, "1.4GHz");
+    break;
+  case PCI_HT_LFRER_1600:
+    strcpy(buf, "1.6GHz");
+    break;
+  case PCI_HT_LFRER_VEND:
+    strcpy(buf, "Vend");
+    break;
+  default:
+    sprintf(buf, "[%x]", freq);
+    break;
+  }
+}
+
+static void
+show_ht_pri(struct device *d, int where, int cmd)
+{
+  char mlwi[8], mlwo[8], lwi[8], lwo[8], freq[8];
+  u16 lctr0, lcnf0, lctr1, lcnf1, eh;
+  u8 rid, lfrer0, lfcap0, ftr, lfrer1, lfcap1, mbu, mlu, bn;
+
+  printf("HyperTransport: Slave or Primary Interface\n");
+  if (verbose < 2)
+    return;
+
+  printf("\t\tCommand: BaseUnitID=%u UnitCnt=%u MastHost%c DefDir%c DUL%c\n",
+	 (cmd & PCI_HT_PRI_CMD_BUID),
+	 (cmd & PCI_HT_PRI_CMD_UC) >> 5,
+	 FLAG(cmd, PCI_HT_PRI_CMD_MH),
+	 FLAG(cmd, PCI_HT_PRI_CMD_DD),
+	 FLAG(cmd, PCI_HT_PRI_CMD_DUL));
+  config_fetch(d, where + PCI_HT_PRI_LCTR0,
+	       PCI_HT_PRI_SIZEOF - PCI_HT_PRI_LCTR0);
+  lctr0 = get_conf_word(d, where + PCI_HT_PRI_LCTR0);
+  printf("\t\tLink Control 0: CFlE%c CST%c CFE%c <LkFail%c Init%c EOC%c TXO%c <CRCErr=%x IsocEn%c LSEn%c ExtCTL%c 64b%c\n",
+	 FLAG(lctr0, PCI_HT_LCTR_CFLE),
+	 FLAG(lctr0, PCI_HT_LCTR_CST),
+	 FLAG(lctr0, PCI_HT_LCTR_CFE),
+	 FLAG(lctr0, PCI_HT_LCTR_LKFAIL),
+	 FLAG(lctr0, PCI_HT_LCTR_INIT),
+	 FLAG(lctr0, PCI_HT_LCTR_EOC),
+	 FLAG(lctr0, PCI_HT_LCTR_TXO),
+	 (lctr0 & PCI_HT_LCTR_CRCERR) >> 8,
+	 FLAG(lctr0, PCI_HT_LCTR_ISOCEN),
+	 FLAG(lctr0, PCI_HT_LCTR_LSEN),
+	 FLAG(lctr0, PCI_HT_LCTR_EXTCTL),
+	 FLAG(lctr0, PCI_HT_LCTR_64B));
+  lcnf0 = get_conf_word(d, where + PCI_HT_PRI_LCNF0);
+  format_ht_link_width((lcnf0 & PCI_HT_LCNF_MLWI), mlwi);
+  format_ht_link_width((lcnf0 & PCI_HT_LCNF_MLWO) >> 4, mlwo);
+  format_ht_link_width((lcnf0 & PCI_HT_LCNF_LWI) >> 8, lwi);
+  format_ht_link_width((lcnf0 & PCI_HT_LCNF_LWO) >> 12, lwo);
+  printf("\t\tLink Config 0: MLWI=%s DwFcIn%c MLWO=%s DwFcOut%c LWI=%s DwFcInEn%c LWO=%s DwFcOutEn%c\n",
+	 mlwi,
+	 FLAG(lcnf0, PCI_HT_LCNF_DFI),
+	 mlwo,
+	 FLAG(lcnf0, PCI_HT_LCNF_DFO),
+	 lwi,
+	 FLAG(lcnf0, PCI_HT_LCNF_DFIE),
+	 lwo,
+	 FLAG(lcnf0, PCI_HT_LCNF_DFOE));
+  lctr1 = get_conf_word(d, where + PCI_HT_PRI_LCTR1);
+  printf("\t\tLink Control 1: CFlE%c CST%c CFE%c <LkFail%c Init%c EOC%c TXO%c <CRCErr=%x IsocEn%c LSEn%c ExtCTL%c 64b%c\n",
+	 FLAG(lctr1, PCI_HT_LCTR_CFLE),
+	 FLAG(lctr1, PCI_HT_LCTR_CST),
+	 FLAG(lctr1, PCI_HT_LCTR_CFE),
+	 FLAG(lctr1, PCI_HT_LCTR_LKFAIL),
+	 FLAG(lctr1, PCI_HT_LCTR_INIT),
+	 FLAG(lctr1, PCI_HT_LCTR_EOC),
+	 FLAG(lctr1, PCI_HT_LCTR_TXO),
+	 (lctr1 & PCI_HT_LCTR_CRCERR) >> 8,
+	 FLAG(lctr1, PCI_HT_LCTR_ISOCEN),
+	 FLAG(lctr1, PCI_HT_LCTR_LSEN),
+	 FLAG(lctr1, PCI_HT_LCTR_EXTCTL),
+	 FLAG(lctr1, PCI_HT_LCTR_64B));
+  lcnf1 = get_conf_word(d, where + PCI_HT_PRI_LCNF1);
+  format_ht_link_width((lcnf1 & PCI_HT_LCNF_MLWI), mlwi);
+  format_ht_link_width((lcnf1 & PCI_HT_LCNF_MLWO) >> 4, mlwo);
+  format_ht_link_width((lcnf1 & PCI_HT_LCNF_LWI) >> 8, lwi);
+  format_ht_link_width((lcnf1 & PCI_HT_LCNF_LWO) >> 12, lwo);
+  printf("\t\tLink Config 1: MLWI=%s DwFcIn%c MLWO=%s DwFcOut%c LWI=%s DwFcInEn%c LWO=%s DwFcOutEn%c\n",
+	 mlwi,
+	 FLAG(lcnf1, PCI_HT_LCNF_DFI),
+	 mlwo,
+	 FLAG(lcnf1, PCI_HT_LCNF_DFO),
+	 lwi,
+	 FLAG(lcnf1, PCI_HT_LCNF_DFIE),
+	 lwo,
+	 FLAG(lcnf1, PCI_HT_LCNF_DFOE));
+  rid = get_conf_byte(d, where + PCI_HT_PRI_RID);
+  printf("\t\tRevision ID: %u.%02u\n",
+	 (rid & PCI_HT_RID_MAJ) >> 5,
+	 (rid & PCI_HT_RID_MIN));
+  lfrer0 = get_conf_byte(d, where + PCI_HT_PRI_LFRER0);
+  format_ht_link_freq(lfrer0 & PCI_HT_LFRER_FREQ, freq);
+  printf("\t\tLink Frequency 0: %s\n", freq);
+  printf("\t\tLink Error 0: <Prot%c <Ovfl%c <EOC%c CTLTm%c\n",
+	 FLAG(lfrer0, PCI_HT_LFRER_PROT),
+	 FLAG(lfrer0, PCI_HT_LFRER_OV),
+	 FLAG(lfrer0, PCI_HT_LFRER_EOC),
+	 FLAG(lfrer0, PCI_HT_LFRER_CTLT));
+  lfcap0 = get_conf_byte(d, where + PCI_HT_PRI_LFCAP0);
+  printf("\t\tLink Frequency Capability 0: 200MHz%c 300MHz%c 400MHz%c 500MHz%c 600MHz%c 800MHz%c 1.0GHz%c 1.2GHz%c 1.4GHz%c 1.6GHz%c Vend%c\n",
+	 FLAG(lfcap0, PCI_HT_LFCAP_200),
+	 FLAG(lfcap0, PCI_HT_LFCAP_300),
+	 FLAG(lfcap0, PCI_HT_LFCAP_400),
+	 FLAG(lfcap0, PCI_HT_LFCAP_500),
+	 FLAG(lfcap0, PCI_HT_LFCAP_600),
+	 FLAG(lfcap0, PCI_HT_LFCAP_800),
+	 FLAG(lfcap0, PCI_HT_LFCAP_1000),
+	 FLAG(lfcap0, PCI_HT_LFCAP_1200),
+	 FLAG(lfcap0, PCI_HT_LFCAP_1400),
+	 FLAG(lfcap0, PCI_HT_LFCAP_1600),
+	 FLAG(lfcap0, PCI_HT_LFCAP_VEND));
+  ftr = get_conf_byte(d, where + PCI_HT_PRI_FTR);
+  printf("\t\tFeature Capability: IsocFC%c LDTSTOP%c CRCTM%c ECTLT%c 64bA%c UIDRD%c\n",
+	 FLAG(ftr, PCI_HT_FTR_ISOCFC),
+	 FLAG(ftr, PCI_HT_FTR_LDTSTOP),
+	 FLAG(ftr, PCI_HT_FTR_CRCTM),
+	 FLAG(ftr, PCI_HT_FTR_ECTLT),
+	 FLAG(ftr, PCI_HT_FTR_64BA),
+	 FLAG(ftr, PCI_HT_FTR_UIDRD));
+  lfrer1 = get_conf_byte(d, where + PCI_HT_PRI_LFRER1);
+  format_ht_link_freq(lfrer1 & PCI_HT_LFRER_FREQ, freq);
+  printf("\t\tLink Frequency 1: %s\n", freq);
+  printf("\t\tLink Error 1: <Prot%c <Ovfl%c <EOC%c CTLTm%c\n",
+	 FLAG(lfrer1, PCI_HT_LFRER_PROT),
+	 FLAG(lfrer1, PCI_HT_LFRER_OV),
+	 FLAG(lfrer1, PCI_HT_LFRER_EOC),
+	 FLAG(lfrer1, PCI_HT_LFRER_CTLT));
+  lfcap1 = get_conf_byte(d, where + PCI_HT_PRI_LFCAP1);
+  printf("\t\tLink Frequency Capability 1: 200MHz%c 300MHz%c 400MHz%c 500MHz%c 600MHz%c 800MHz%c 1.0GHz%c 1.2GHz%c 1.4GHz%c 1.6GHz%c Vend%c\n",
+	 FLAG(lfcap1, PCI_HT_LFCAP_200),
+	 FLAG(lfcap1, PCI_HT_LFCAP_300),
+	 FLAG(lfcap1, PCI_HT_LFCAP_400),
+	 FLAG(lfcap1, PCI_HT_LFCAP_500),
+	 FLAG(lfcap1, PCI_HT_LFCAP_600),
+	 FLAG(lfcap1, PCI_HT_LFCAP_800),
+	 FLAG(lfcap1, PCI_HT_LFCAP_1000),
+	 FLAG(lfcap1, PCI_HT_LFCAP_1200),
+	 FLAG(lfcap1, PCI_HT_LFCAP_1400),
+	 FLAG(lfcap1, PCI_HT_LFCAP_1600),
+	 FLAG(lfcap1, PCI_HT_LFCAP_VEND));
+  eh = get_conf_word(d, where + PCI_HT_PRI_EH);
+  printf("\t\tError Handling: PFlE%c OFlE%c PFE%c OFE%c EOCFE%c RFE%c CRCFE%c SERRFE%c CF%c RE%c PNFE%c ONFE%c EOCNFE%c RNFE%c CRCNFE%c SERRNFE%c\n",
+	 FLAG(eh, PCI_HT_EH_PFLE),
+	 FLAG(eh, PCI_HT_EH_OFLE),
+	 FLAG(eh, PCI_HT_EH_PFE),
+	 FLAG(eh, PCI_HT_EH_OFE),
+	 FLAG(eh, PCI_HT_EH_EOCFE),
+	 FLAG(eh, PCI_HT_EH_RFE),
+	 FLAG(eh, PCI_HT_EH_CRCFE),
+	 FLAG(eh, PCI_HT_EH_SERRFE),
+	 FLAG(eh, PCI_HT_EH_CF),
+	 FLAG(eh, PCI_HT_EH_RE),
+	 FLAG(eh, PCI_HT_EH_PNFE),
+	 FLAG(eh, PCI_HT_EH_ONFE),
+	 FLAG(eh, PCI_HT_EH_EOCNFE),
+	 FLAG(eh, PCI_HT_EH_RNFE),
+	 FLAG(eh, PCI_HT_EH_CRCNFE),
+	 FLAG(eh, PCI_HT_EH_SERRNFE));
+  mbu = get_conf_byte(d, where + PCI_HT_PRI_MBU);
+  mlu = get_conf_byte(d, where + PCI_HT_PRI_MLU);
+  printf("\t\tPrefetchable memory behind bridge Upper: %02x-%02x\n", mbu, mlu);
+  bn = get_conf_byte(d, where + PCI_HT_PRI_BN);
+  printf("\t\tBus Number: %02x\n", bn);
+}
+
+static void
+show_ht_sec(struct device *d, int where, int cmd)
+{
+  char mlwi[8], mlwo[8], lwi[8], lwo[8], freq[8];
+  u16 lctr, lcnf, ftr, eh;
+  u8 rid, lfrer, lfcap, mbu, mlu;
+
+  printf("HyperTransport: Host or Secondary Interface\n");
+  if (verbose < 2)
+    return;
+
+  printf("\t\tCommand: WarmRst%c DblEnd%c DevNum=%u ChainSide%c HostHide%c Slave%c <EOCErr%c DUL%c\n",
+	 FLAG(cmd, PCI_HT_SEC_CMD_WR),
+	 FLAG(cmd, PCI_HT_SEC_CMD_DE),
+	 (cmd & PCI_HT_SEC_CMD_DN) >> 2,
+	 FLAG(cmd, PCI_HT_SEC_CMD_CS),
+	 FLAG(cmd, PCI_HT_SEC_CMD_HH),
+	 FLAG(cmd, PCI_HT_SEC_CMD_AS),
+	 FLAG(cmd, PCI_HT_SEC_CMD_HIECE),
+	 FLAG(cmd, PCI_HT_SEC_CMD_DUL));
+  config_fetch(d, where + PCI_HT_SEC_LCTR,
+	       PCI_HT_SEC_SIZEOF - PCI_HT_SEC_LCTR);
+  lctr = get_conf_word(d, where + PCI_HT_SEC_LCTR);
+  printf("\t\tLink Control: CFlE%c CST%c CFE%c <LkFail%c Init%c EOC%c TXO%c <CRCErr=%x IsocEn%c LSEn%c ExtCTL%c 64b%c\n",
+	 FLAG(lctr, PCI_HT_LCTR_CFLE),
+	 FLAG(lctr, PCI_HT_LCTR_CST),
+	 FLAG(lctr, PCI_HT_LCTR_CFE),
+	 FLAG(lctr, PCI_HT_LCTR_LKFAIL),
+	 FLAG(lctr, PCI_HT_LCTR_INIT),
+	 FLAG(lctr, PCI_HT_LCTR_EOC),
+	 FLAG(lctr, PCI_HT_LCTR_TXO),
+	 (lctr & PCI_HT_LCTR_CRCERR) >> 8,
+	 FLAG(lctr, PCI_HT_LCTR_ISOCEN),
+	 FLAG(lctr, PCI_HT_LCTR_LSEN),
+	 FLAG(lctr, PCI_HT_LCTR_EXTCTL),
+	 FLAG(lctr, PCI_HT_LCTR_64B));
+  lcnf = get_conf_word(d, where + PCI_HT_SEC_LCNF);
+  format_ht_link_width((lcnf & PCI_HT_LCNF_MLWI), mlwi);
+  format_ht_link_width((lcnf & PCI_HT_LCNF_MLWO) >> 4, mlwo);
+  format_ht_link_width((lcnf & PCI_HT_LCNF_LWI) >> 8, lwi);
+  format_ht_link_width((lcnf & PCI_HT_LCNF_LWO) >> 12, lwo);
+  printf("\t\tLink Config: MLWI=%s DwFcIn%c MLWO=%s DwFcOut%c LWI=%s DwFcInEn%c LWO=%s DwFcOutEn%c\n",
+	 mlwi,
+	 FLAG(lcnf, PCI_HT_LCNF_DFI),
+	 mlwo,
+	 FLAG(lcnf, PCI_HT_LCNF_DFO),
+	 lwi,
+	 FLAG(lcnf, PCI_HT_LCNF_DFIE),
+	 lwo,
+	 FLAG(lcnf, PCI_HT_LCNF_DFOE));
+  rid = get_conf_byte(d, where + PCI_HT_SEC_RID);
+  printf("\t\tRevision ID: %u.%02u\n",
+	 (rid & PCI_HT_RID_MAJ) >> 5,
+	 (rid & PCI_HT_RID_MIN));
+  lfrer = get_conf_byte(d, where + PCI_HT_SEC_LFRER);
+  format_ht_link_freq(lfrer & PCI_HT_LFRER_FREQ, freq);
+  printf("\t\tLink Frequency: %s\n", freq);
+  printf("\t\tLink Error: <Prot%c <Ovfl%c <EOC%c CTLTm%c\n",
+	 FLAG(lfrer, PCI_HT_LFRER_PROT),
+	 FLAG(lfrer, PCI_HT_LFRER_OV),
+	 FLAG(lfrer, PCI_HT_LFRER_EOC),
+	 FLAG(lfrer, PCI_HT_LFRER_CTLT));
+  lfcap = get_conf_byte(d, where + PCI_HT_SEC_LFCAP);
+  printf("\t\tLink Frequency Capability: 200MHz%c 300MHz%c 400MHz%c 500MHz%c 600MHz%c 800MHz%c 1.0GHz%c 1.2GHz%c 1.4GHz%c 1.6GHz%c Vend%c\n",
+	 FLAG(lfcap, PCI_HT_LFCAP_200),
+	 FLAG(lfcap, PCI_HT_LFCAP_300),
+	 FLAG(lfcap, PCI_HT_LFCAP_400),
+	 FLAG(lfcap, PCI_HT_LFCAP_500),
+	 FLAG(lfcap, PCI_HT_LFCAP_600),
+	 FLAG(lfcap, PCI_HT_LFCAP_800),
+	 FLAG(lfcap, PCI_HT_LFCAP_1000),
+	 FLAG(lfcap, PCI_HT_LFCAP_1200),
+	 FLAG(lfcap, PCI_HT_LFCAP_1400),
+	 FLAG(lfcap, PCI_HT_LFCAP_1600),
+	 FLAG(lfcap, PCI_HT_LFCAP_VEND));
+  ftr = get_conf_word(d, where + PCI_HT_SEC_FTR);
+  printf("\t\tFeature Capability: IsocFC%c LDTSTOP%c CRCTM%c ECTLT%c 64bA%c UIDRD%c ExtRS%c UCnfE%c\n",
+	 FLAG(ftr, PCI_HT_FTR_ISOCFC),
+	 FLAG(ftr, PCI_HT_FTR_LDTSTOP),
+	 FLAG(ftr, PCI_HT_FTR_CRCTM),
+	 FLAG(ftr, PCI_HT_FTR_ECTLT),
+	 FLAG(ftr, PCI_HT_FTR_64BA),
+	 FLAG(ftr, PCI_HT_FTR_UIDRD),
+	 FLAG(ftr, PCI_HT_SEC_FTR_EXTRS),
+	 FLAG(ftr, PCI_HT_SEC_FTR_UCNFE));
+  if ((ftr & PCI_HT_SEC_FTR_EXTRS) != 0) {
+    eh = get_conf_word(d, where + PCI_HT_SEC_EH);
+    printf("\t\tError Handling: PFlE%c OFlE%c PFE%c OFE%c EOCFE%c RFE%c CRCFE%c SERRFE%c CF%c RE%c PNFE%c ONFE%c EOCNFE%c RNFE%c CRCNFE%c SERRNFE%c\n",
+	   FLAG(eh, PCI_HT_EH_PFLE),
+	   FLAG(eh, PCI_HT_EH_OFLE),
+	   FLAG(eh, PCI_HT_EH_PFE),
+	   FLAG(eh, PCI_HT_EH_OFE),
+	   FLAG(eh, PCI_HT_EH_EOCFE),
+	   FLAG(eh, PCI_HT_EH_RFE),
+	   FLAG(eh, PCI_HT_EH_CRCFE),
+	   FLAG(eh, PCI_HT_EH_SERRFE),
+	   FLAG(eh, PCI_HT_EH_CF),
+	   FLAG(eh, PCI_HT_EH_RE),
+	   FLAG(eh, PCI_HT_EH_PNFE),
+	   FLAG(eh, PCI_HT_EH_ONFE),
+	   FLAG(eh, PCI_HT_EH_EOCNFE),
+	   FLAG(eh, PCI_HT_EH_RNFE),
+	   FLAG(eh, PCI_HT_EH_CRCNFE),
+	   FLAG(eh, PCI_HT_EH_SERRNFE));
+    mbu = get_conf_byte(d, where + PCI_HT_SEC_MBU);
+    mlu = get_conf_byte(d, where + PCI_HT_SEC_MLU);
+    printf("\t\tPrefetchable memory behind bridge Upper: %02x-%02x\n", mbu, mlu);
+  }
+}
+
+static void
+show_ht_rid(struct device *d, int where, int rid)
+{
+  printf("HyperTransport: Revision ID: %u.%02u\n",
+	 (rid & PCI_HT_RID_MAJ) >> 5,
+	 (rid & PCI_HT_RID_MIN));
+}
+
+static void
+show_ht(struct device *d, int where, int cmd)
+{
+  int type, htyp;
+
+  type = cmd & PCI_HT_CMD_TYP;
+  htyp = cmd & PCI_HT_CMD_TYP_HI;
+  switch (htyp) {
+  case PCI_HT_CMD_TYP_HI_PRI:
+    show_ht_pri(d, where, cmd);
+    break;
+  case PCI_HT_CMD_TYP_HI_SEC:
+    show_ht_sec(d, where, cmd);
+    break;
+  default:
+    switch (type) {
+    case PCI_HT_CMD_TYP_SW:
+      printf("HyperTransport: Switch\n");
+      break;
+    case PCI_HT_CMD_TYP_IDC:
+      printf("HyperTransport: Interrupt Discovery and Configuration\n");
+      break;
+    case PCI_HT_CMD_TYP_RID:
+      show_ht_rid(d, where, cmd);
+      break;
+    case PCI_HT_CMD_TYP_UIDC:
+      printf("HyperTransport: UnitID Clumping\n");
+      break;
+    case PCI_HT_CMD_TYP_ECSA:
+      printf("HyperTransport: Extended Configuration Space Access\n");
+      break;
+    case PCI_HT_CMD_TYP_AM:
+      printf("HyperTransport: Address Mapping\n");
+      break;
+    case PCI_HT_CMD_TYP_MSIM:
+      printf("HyperTransport: MSI Mapping\n");
+      break;
+    case PCI_HT_CMD_TYP_DR:
+      printf("HyperTransport: DirectRoute\n");
+      break;
+    case PCI_HT_CMD_TYP_VCS:
+      printf("HyperTransport: VCSet\n");
+      break;
+    case PCI_HT_CMD_TYP_RM:
+      printf("HyperTransport: Retry Mode\n");
+      break;
+    case PCI_HT_CMD_TYP_X86:
+      printf("HyperTransport: X86 (reserved)\n");
+      break;
+    default:
+      printf("HyperTransport: #%02x\n", type >> 11);
+      break;
+    }
+    break;
+  }
+}
+
+static void
 show_rom(struct device *d)
 {
   struct pci_dev *p = d->dev;
@@ -658,6 +1058,9 @@ show_caps(struct device *d)
 	    case PCI_CAP_ID_PCIX:
 	      show_pcix(d, where);
 	      break;
+	    case PCI_CAP_ID_HT:
+	      show_ht(d, where, cap);
+	      break;
 	    default:
 	      printf("#%02x [%04x]\n", id, cap);
 	    }
