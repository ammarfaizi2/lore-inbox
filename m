Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVDTCSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVDTCSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 22:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVDTCSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 22:18:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50450 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261271AbVDTCPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 22:15:30 -0400
Date: Wed, 20 Apr 2005 04:15:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mlindner@syskonnect.de, rroesler@syskonnect.de
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [2.6 patch] drivers/net/sk98lin/: possible cleanups
Message-ID: <20050420021526.GB5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global functions static
- remove unused code

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/sk98lin/h/skaddr.h   |   48 ---
 drivers/net/sk98lin/h/skcsum.h   |    6 
 drivers/net/sk98lin/h/skdrv2nd.h |    1 
 drivers/net/sk98lin/h/skgeinit.h |   56 ---
 drivers/net/sk98lin/h/skgepnmi.h |    4 
 drivers/net/sk98lin/h/skgesirq.h |    1 
 drivers/net/sk98lin/h/ski2c.h    |    3 
 drivers/net/sk98lin/h/skvpd.h    |   15 -
 drivers/net/sk98lin/skaddr.c     |   35 +-
 drivers/net/sk98lin/skcsum.c     |  252 ----------------
 drivers/net/sk98lin/skgeinit.c   |  148 ---------
 drivers/net/sk98lin/skgemib.c    |    7 
 drivers/net/sk98lin/skgepnmi.c   |  153 ----------
 drivers/net/sk98lin/skgesirq.c   |   24 -
 drivers/net/sk98lin/ski2c.c      |    6 
 drivers/net/sk98lin/sklm80.c     |   72 ----
 drivers/net/sk98lin/skrlmt.c     |    1 
 drivers/net/sk98lin/skvpd.c      |  108 -------
 drivers/net/sk98lin/skxmac2.c    |  461 -------------------------------
 19 files changed, 40 insertions(+), 1361 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skaddr.h.old	2005-04-19 23:34:34.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skaddr.h	2005-04-19 23:42:57.000000000 +0200
@@ -236,18 +236,6 @@
 	SK_U32	PortNumber,
 	int	Flags);
 
-extern	int	SkAddrXmacMcClear(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	SK_U32	PortNumber,
-	int	Flags);
-
-extern	int	SkAddrGmacMcClear(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	SK_U32	PortNumber,
-	int	Flags);
-
 extern	int	SkAddrMcAdd(
 	SK_AC		*pAC,
 	SK_IOC		IoC,
@@ -255,35 +243,11 @@
 	SK_MAC_ADDR	*pMc,
 	int		Flags);
 
-extern	int	SkAddrXmacMcAdd(
-	SK_AC		*pAC,
-	SK_IOC		IoC,
-	SK_U32		PortNumber,
-	SK_MAC_ADDR	*pMc,
-	int		Flags);
-
-extern	int	SkAddrGmacMcAdd(
-	SK_AC		*pAC,
-	SK_IOC		IoC,
-	SK_U32		PortNumber,
-	SK_MAC_ADDR	*pMc,
-	int		Flags);
-
 extern	int	SkAddrMcUpdate(
 	SK_AC	*pAC,
 	SK_IOC	IoC,
 	SK_U32	PortNumber);
 
-extern	int	SkAddrXmacMcUpdate(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	SK_U32	PortNumber);
-
-extern	int	SkAddrGmacMcUpdate(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	SK_U32	PortNumber);
-
 extern	int	SkAddrOverride(
 	SK_AC		*pAC,
 	SK_IOC		IoC,
@@ -297,18 +261,6 @@
 	SK_U32	PortNumber,
 	int	NewPromMode);
 
-extern	int	SkAddrXmacPromiscuousChange(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	SK_U32	PortNumber,
-	int	NewPromMode);
-
-extern	int	SkAddrGmacPromiscuousChange(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	SK_U32	PortNumber,
-	int	NewPromMode);	
-
 #ifndef SK_SLIM
 extern	int	SkAddrSwap(
 	SK_AC	*pAC,
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skaddr.c.old	2005-04-19 23:34:50.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skaddr.c	2005-04-20 00:01:12.000000000 +0200
@@ -87,6 +87,21 @@
 static int	Next0[SK_MAX_MACS] = {0};
 #endif	/* DEBUG */
 
+static int SkAddrGmacMcAdd(SK_AC *pAC, SK_IOC IoC, SK_U32 PortNumber,
+			   SK_MAC_ADDR *pMc, int Flags);
+static int SkAddrGmacMcClear(SK_AC *pAC, SK_IOC IoC, SK_U32 PortNumber,
+			     int Flags);
+static int SkAddrGmacMcUpdate(SK_AC *pAC, SK_IOC IoC, SK_U32 PortNumber);
+static int SkAddrGmacPromiscuousChange(SK_AC *pAC, SK_IOC IoC,
+				       SK_U32 PortNumber, int NewPromMode);
+static int SkAddrXmacMcAdd(SK_AC *pAC, SK_IOC IoC, SK_U32 PortNumber,
+			   SK_MAC_ADDR *pMc, int Flags);
+static int SkAddrXmacMcClear(SK_AC *pAC, SK_IOC IoC, SK_U32 PortNumber,
+			     int Flags);
+static int SkAddrXmacMcUpdate(SK_AC *pAC, SK_IOC IoC, SK_U32 PortNumber);
+static int SkAddrXmacPromiscuousChange(SK_AC *pAC, SK_IOC IoC,
+				       SK_U32 PortNumber, int NewPromMode);
+
 /* functions ******************************************************************/
 
 /******************************************************************************
@@ -372,7 +387,7 @@
  *	SK_ADDR_SUCCESS
  *	SK_ADDR_ILLEGAL_PORT
  */
-int	SkAddrXmacMcClear(
+static int	SkAddrXmacMcClear(
 SK_AC	*pAC,		/* adapter context */
 SK_IOC	IoC,		/* I/O context */
 SK_U32	PortNumber,	/* Index of affected port */
@@ -429,7 +444,7 @@
  *	SK_ADDR_SUCCESS
  *	SK_ADDR_ILLEGAL_PORT
  */
-int	SkAddrGmacMcClear(
+static int	SkAddrGmacMcClear(
 SK_AC	*pAC,		/* adapter context */
 SK_IOC	IoC,		/* I/O context */
 SK_U32	PortNumber,	/* Index of affected port */
@@ -519,7 +534,7 @@
  * Returns:
  *	Hash value of multicast address.
  */
-SK_U32 SkXmacMcHash(
+static SK_U32 SkXmacMcHash(
 unsigned char *pMc)	/* Multicast address */
 {
 	SK_U32 Idx;
@@ -557,7 +572,7 @@
  * Returns:
  *	Hash value of multicast address.
  */
-SK_U32 SkGmacMcHash(
+static SK_U32 SkGmacMcHash(
 unsigned char *pMc)	/* Multicast address */
 {
 	SK_U32 Data;
@@ -672,7 +687,7 @@
  *	SK_MC_ILLEGAL_ADDRESS
  *	SK_MC_RLMT_OVERFLOW
  */
-int	SkAddrXmacMcAdd(
+static int	SkAddrXmacMcAdd(
 SK_AC		*pAC,		/* adapter context */
 SK_IOC		IoC,		/* I/O context */
 SK_U32		PortNumber,	/* Port Number */
@@ -778,7 +793,7 @@
  *	SK_MC_FILTERING_INEXACT
  *	SK_MC_ILLEGAL_ADDRESS
  */
-int	SkAddrGmacMcAdd(
+static int	SkAddrGmacMcAdd(
 SK_AC		*pAC,		/* adapter context */
 SK_IOC		IoC,		/* I/O context */
 SK_U32		PortNumber,	/* Port Number */
@@ -937,7 +952,7 @@
  *	SK_MC_FILTERING_INEXACT
  *	SK_ADDR_ILLEGAL_PORT
  */
-int	SkAddrXmacMcUpdate(
+static int	SkAddrXmacMcUpdate(
 SK_AC	*pAC,		/* adapter context */
 SK_IOC	IoC,		/* I/O context */
 SK_U32	PortNumber)	/* Port Number */
@@ -1082,7 +1097,7 @@
  *	SK_MC_FILTERING_INEXACT
  *	SK_ADDR_ILLEGAL_PORT
  */
-int	SkAddrGmacMcUpdate(
+static int	SkAddrGmacMcUpdate(
 SK_AC	*pAC,		/* adapter context */
 SK_IOC	IoC,		/* I/O context */
 SK_U32	PortNumber)	/* Port Number */
@@ -1468,7 +1483,7 @@
  *	SK_ADDR_SUCCESS
  *	SK_ADDR_ILLEGAL_PORT
  */
-int	SkAddrXmacPromiscuousChange(
+static int	SkAddrXmacPromiscuousChange(
 SK_AC	*pAC,			/* adapter context */
 SK_IOC	IoC,			/* I/O context */
 SK_U32	PortNumber,		/* port whose promiscuous mode changes */
@@ -1585,7 +1600,7 @@
  *	SK_ADDR_SUCCESS
  *	SK_ADDR_ILLEGAL_PORT
  */
-int	SkAddrGmacPromiscuousChange(
+static int	SkAddrGmacPromiscuousChange(
 SK_AC	*pAC,			/* adapter context */
 SK_IOC	IoC,			/* I/O context */
 SK_U32	PortNumber,		/* port whose promiscuous mode changes */
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skcsum.h.old	2005-04-19 23:44:51.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skcsum.h	2005-04-19 23:45:01.000000000 +0200
@@ -203,12 +203,6 @@
 	unsigned	Checksum2,
 	int			NetNumber);
 
-extern void SkCsGetSendInfo(
-	SK_AC				*pAc,
-	void				*pIpHeader,
-	SKCS_PACKET_INFO	*pPacketInfo,
-	int					NetNumber);
-
 extern void SkCsSetReceiveFlags(
 	SK_AC		*pAc,
 	unsigned	ReceiveFlags,
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skcsum.c.old	2005-04-19 23:45:09.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skcsum.c	2005-04-19 23:46:19.000000000 +0200
@@ -136,258 +136,6 @@
 
 /******************************************************************************
  *
- *	SkCsGetSendInfo - get checksum information for a send packet
- *
- * Description:
- *	Get all checksum information necessary to send a TCP or UDP packet. The
- *	function checks the IP header passed to it. If the high-level protocol
- *	is either TCP or UDP the pseudo header checksum is calculated and
- *	returned.
- *
- *	The function returns the total length of the IP header (including any
- *	IP option fields), which is the same as the start offset of the IP data
- *	which in turn is the start offset of the TCP or UDP header.
- *
- *	The function also returns the TCP or UDP pseudo header checksum, which
- *	should be used as the start value for the hardware checksum calculation.
- *	(Note that any actual pseudo header checksum can never calculate to
- *	zero.)
- *
- * Note:
- *	There is a bug in the GENESIS ASIC which may lead to wrong checksums.
- *
- * Arguments:
- *	pAc - A pointer to the adapter context struct.
- *
- *	pIpHeader - Pointer to IP header. Must be at least the IP header *not*
- *	including any option fields, i.e. at least 20 bytes.
- *
- *	Note: This pointer will be used to address 8-, 16-, and 32-bit
- *	variables with the respective alignment offsets relative to the pointer.
- *	Thus, the pointer should point to a 32-bit aligned address. If the
- *	target system cannot address 32-bit variables on non 32-bit aligned
- *	addresses, then the pointer *must* point to a 32-bit aligned address.
- *
- *	pPacketInfo - A pointer to the packet information structure for this
- *	packet. Before calling this SkCsGetSendInfo(), the following field must
- *	be initialized:
- *
- *		ProtocolFlags - Initialize with any combination of
- *		SKCS_PROTO_XXX bit flags. SkCsGetSendInfo() will only work on
- *		the protocols specified here. Any protocol(s) not specified
- *		here will be ignored.
- *
- *		Note: Only one checksum can be calculated in hardware. Thus, if
- *		SKCS_PROTO_IP is specified in the 'ProtocolFlags',
- *		SkCsGetSendInfo() must calculate the IP header checksum in
- *		software. It might be a better idea to have the calling
- *		protocol stack calculate the IP header checksum.
- *
- * Returns: N/A
- *	On return, the following fields in 'pPacketInfo' may or may not have
- *	been filled with information, depending on the protocol(s) found in the
- *	packet:
- *
- *	ProtocolFlags - Returns the SKCS_PROTO_XXX bit flags of the protocol(s)
- *	that were both requested by the caller and actually found in the packet.
- *	Protocol(s) not specified by the caller and/or not found in the packet
- *	will have their respective SKCS_PROTO_XXX bit flags reset.
- *
- *	Note: For IP fragments, TCP and UDP packet information is ignored.
- *
- *	IpHeaderLength - The total length in bytes of the complete IP header
- *	including any option fields is returned here. This is the start offset
- *	of the IP data, i.e. the TCP or UDP header if present.
- *
- *	IpHeaderChecksum - If IP has been specified in the 'ProtocolFlags', the
- *	16-bit Internet Checksum of the IP header is returned here. This value
- *	is to be stored into the packet's 'IP Header Checksum' field.
- *
- *	PseudoHeaderChecksum - If this is a TCP or UDP packet and if TCP or UDP
- *	has been specified in the 'ProtocolFlags', the 16-bit Internet Checksum
- *	of the TCP or UDP pseudo header is returned here.
- */
-void SkCsGetSendInfo(
-SK_AC				*pAc,			/* Adapter context struct. */
-void				*pIpHeader,		/* IP header. */
-SKCS_PACKET_INFO	*pPacketInfo,	/* Packet information struct. */
-int					NetNumber)		/* Net number */
-{
-	/* Internet Header Version found in IP header. */
-	unsigned InternetHeaderVersion;
-
-	/* Length of the IP header as found in IP header. */
-	unsigned IpHeaderLength;
-
-	/* Bit field specifiying the desired/found protocols. */
-	unsigned ProtocolFlags;
-
-	/* Next level protocol identifier found in IP header. */
-	unsigned NextLevelProtocol;
-
-	/* Length of IP data portion. */
-	unsigned IpDataLength;
-
-	/* TCP/UDP pseudo header checksum. */
-	unsigned long PseudoHeaderChecksum;
-
-	/* Pointer to next level protocol statistics structure. */
-	SKCS_PROTO_STATS *NextLevelProtoStats;
-
-	/* Temporary variable. */
-	unsigned Tmp;
-
-	Tmp = *(SK_U8 *)
-		SKCS_IDX(pIpHeader, SKCS_OFS_IP_HEADER_VERSION_AND_LENGTH);
-
-	/* Get the Internet Header Version (IHV). */
-	/* Note: The IHV is stored in the upper four bits. */
-
-	InternetHeaderVersion = Tmp >> 4;
-
-	/* Check the Internet Header Version. */
-	/* Note: We currently only support IP version 4. */
-
-	if (InternetHeaderVersion != 4) {	/* IPv4? */
-		SK_DBG_MSG(pAc, SK_DBGMOD_CSUM, SK_DBGCAT_ERR | SK_DBGCAT_TX,
-			("Tx: Unknown Internet Header Version %u.\n",
-			InternetHeaderVersion));
-		pPacketInfo->ProtocolFlags = 0;
-		pAc->Csum.ProtoStats[NetNumber][SKCS_PROTO_STATS_IP].TxUnableCts++;
-		return;
-	}
-
-	/* Get the IP header length (IHL). */
-	/*
-	 * Note: The IHL is stored in the lower four bits as the number of
-	 * 4-byte words.
-	 */
-
-	IpHeaderLength = (Tmp & 0xf) * 4;
-	pPacketInfo->IpHeaderLength = IpHeaderLength;
-
-	/* Check the IP header length. */
-
-	/* 04-Aug-1998 sw - Really check the IHL? Necessary? */
-
-	if (IpHeaderLength < 5*4) {
-		SK_DBG_MSG(pAc, SK_DBGMOD_CSUM, SK_DBGCAT_ERR | SK_DBGCAT_TX,
-			("Tx: Invalid IP Header Length %u.\n", IpHeaderLength));
-		pPacketInfo->ProtocolFlags = 0;
-		pAc->Csum.ProtoStats[NetNumber][SKCS_PROTO_STATS_IP].TxUnableCts++;
-		return;
-	}
-
-	/* This is an IPv4 frame with a header of valid length. */
-
-	pAc->Csum.ProtoStats[NetNumber][SKCS_PROTO_STATS_IP].TxOkCts++;
-
-	/* Check if we should calculate the IP header checksum. */
-
-	ProtocolFlags = pPacketInfo->ProtocolFlags;
-
-	if (ProtocolFlags & SKCS_PROTO_IP) {
-		pPacketInfo->IpHeaderChecksum =
-			SkCsCalculateChecksum(pIpHeader, IpHeaderLength);
-	}
-
-	/* Get the next level protocol identifier. */
-
-	NextLevelProtocol =
-		*(SK_U8 *) SKCS_IDX(pIpHeader, SKCS_OFS_IP_NEXT_LEVEL_PROTOCOL);
-
-	/*
-	 * Check if this is a TCP or UDP frame and if we should calculate the
-	 * TCP/UDP pseudo header checksum.
-	 *
-	 * Also clear all protocol bit flags of protocols not present in the
-	 * frame.
-	 */
-
-	if ((ProtocolFlags & SKCS_PROTO_TCP) != 0 &&
-		NextLevelProtocol == SKCS_PROTO_ID_TCP) {
-		/* TCP/IP frame. */
-		ProtocolFlags &= SKCS_PROTO_TCP | SKCS_PROTO_IP;
-		NextLevelProtoStats =
-			&pAc->Csum.ProtoStats[NetNumber][SKCS_PROTO_STATS_TCP];
-	}
-	else if ((ProtocolFlags & SKCS_PROTO_UDP) != 0 &&
-		NextLevelProtocol == SKCS_PROTO_ID_UDP) {
-		/* UDP/IP frame. */
-		ProtocolFlags &= SKCS_PROTO_UDP | SKCS_PROTO_IP;
-		NextLevelProtoStats =
-			&pAc->Csum.ProtoStats[NetNumber][SKCS_PROTO_STATS_UDP];
-	}
-	else {
-		/*
-		 * Either not a TCP or UDP frame and/or TCP/UDP processing not
-		 * specified.
-		 */
-		pPacketInfo->ProtocolFlags = ProtocolFlags & SKCS_PROTO_IP;
-		return;
-	}
-
-	/* Check if this is an IP fragment. */
-
-	/*
-	 * Note: An IP fragment has a non-zero "Fragment Offset" field and/or
-	 * the "More Fragments" bit set. Thus, if both the "Fragment Offset"
-	 * and the "More Fragments" are zero, it is *not* a fragment. We can
-	 * easily check both at the same time since they are in the same 16-bit
-	 * word.
-	 */
-
-	if ((*(SK_U16 *)
-		SKCS_IDX(pIpHeader, SKCS_OFS_IP_FLAGS_AND_FRAGMENT_OFFSET) &
-		~SKCS_IP_DONT_FRAGMENT) != 0) {
-		/* IP fragment; ignore all other protocols. */
-		pPacketInfo->ProtocolFlags = ProtocolFlags & SKCS_PROTO_IP;
-		NextLevelProtoStats->TxUnableCts++;
-		return;
-	}
-
-	/*
-	 * Calculate the TCP/UDP pseudo header checksum.
-	 */
-
-	/* Get total length of IP header and data. */
-
-	IpDataLength =
-		*(SK_U16 *) SKCS_IDX(pIpHeader, SKCS_OFS_IP_TOTAL_LENGTH);
-
-	/* Get length of IP data portion. */
-
-	IpDataLength = SKCS_NTOH16(IpDataLength) - IpHeaderLength;
-
-	/* Calculate the sum of all pseudo header fields (16-bit). */
-
-	PseudoHeaderChecksum =
-		(unsigned long) *(SK_U16 *) SKCS_IDX(pIpHeader,
-			SKCS_OFS_IP_SOURCE_ADDRESS + 0) +
-		(unsigned long) *(SK_U16 *) SKCS_IDX(pIpHeader,
-			SKCS_OFS_IP_SOURCE_ADDRESS + 2) +
-		(unsigned long) *(SK_U16 *) SKCS_IDX(pIpHeader,
-			SKCS_OFS_IP_DESTINATION_ADDRESS + 0) +
-		(unsigned long) *(SK_U16 *) SKCS_IDX(pIpHeader,
-			SKCS_OFS_IP_DESTINATION_ADDRESS + 2) +
-		(unsigned long) SKCS_HTON16(NextLevelProtocol) +
-		(unsigned long) SKCS_HTON16(IpDataLength);
-	
-	/* Add-in any carries. */
-
-	SKCS_OC_ADD(PseudoHeaderChecksum, PseudoHeaderChecksum, 0);
-
-	/* Add-in any new carry. */
-
-	SKCS_OC_ADD(pPacketInfo->PseudoHeaderChecksum, PseudoHeaderChecksum, 0);
-
-	pPacketInfo->ProtocolFlags = ProtocolFlags;
-	NextLevelProtoStats->TxOkCts++;	/* Success. */
-}	/* SkCsGetSendInfo */
-
-
-/******************************************************************************
- *
  *	SkCsGetReceiveInfo - verify checksum information for a received packet
  *
  * Description:
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skgeinit.h.old	2005-04-19 23:46:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skgeinit.h	2005-04-20 00:22:36.000000000 +0200
@@ -464,12 +464,6 @@
 /*
  * public functions in skgeinit.c
  */
-extern void	SkGePollRxD(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	int		Port,
-	SK_BOOL	PollRxD);
-
 extern void	SkGePollTxD(
 	SK_AC	*pAC,
 	SK_IOC	IoC,
@@ -522,10 +516,6 @@
 	int		Led,
 	int		Mode);
 
-extern void	SkGeInitRamIface(
-	SK_AC	*pAC,
-	SK_IOC	IoC);
-
 extern int	SkGeInitAssignRamToQueues(
 	SK_AC	*pAC,
 	int		ActivePort,
@@ -549,11 +539,6 @@
 	SK_IOC	IoC,
 	int		Port);
 
-extern void	SkMacClearRst(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	int		Port);
-
 extern void	SkXmInitMac(
 	SK_AC	*pAC,
 	SK_IOC	IoC,
@@ -580,11 +565,6 @@
 	SK_IOC	IoC,
 	int		Port);
 
-extern void	SkMacFlushRxFifo(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	int		Port);
-
 extern void	SkMacIrq(
 	SK_AC	*pAC,
 	SK_IOC	IoC,
@@ -601,12 +581,6 @@
 	int		Port,
 	SK_U16	IStatus);
 
-extern void  SkMacSetRxTxEn(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	int		Port,
-	int		Para);
-
 extern int  SkMacRxTxEnable(
 	SK_AC	*pAC,
 	SK_IOC	IoC,
@@ -659,16 +633,6 @@
 	int		StartNum,
 	int		StopNum);
 
-extern void	SkXmInitDupMd(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	int		Port);
-
-extern void	SkXmInitPauseMd(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	int		Port);
-
 extern void	SkXmAutoNegLipaXmac(
 	SK_AC	*pAC,
 	SK_IOC	IoC,
@@ -729,17 +693,6 @@
 	int		Port,
 	SK_BOOL	StartTest);
 
-extern int SkGmEnterLowPowerMode(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	int		Port,
-	SK_U8	Mode);
-
-extern int SkGmLeaveLowPowerMode(
-	SK_AC	*pAC,
-	SK_IOC	IoC,
-	int		Port);
-
 #ifdef SK_DIAG
 extern void	SkGePhyRead(
 	SK_AC	*pAC,
@@ -782,7 +735,6 @@
 /*
  * public functions in skgeinit.c
  */
-extern void	SkGePollRxD();
 extern void	SkGePollTxD();
 extern void	SkGeYellowLED();
 extern int	SkGeCfgSync();
@@ -792,7 +744,6 @@
 extern void	SkGeDeInit();
 extern int	SkGeInitPort();
 extern void	SkGeXmitLED();
-extern void	SkGeInitRamIface();
 extern int	SkGeInitAssignRamToQueues();
 
 /*
@@ -801,18 +752,15 @@
 extern void SkMacRxTxDisable();
 extern void	SkMacSoftRst();
 extern void	SkMacHardRst();
-extern void	SkMacClearRst();
 extern void SkMacInitPhy();
 extern int  SkMacRxTxEnable();
 extern void SkMacPromiscMode();
 extern void SkMacHashing();
 extern void SkMacIrqDisable();
 extern void	SkMacFlushTxFifo();
-extern void	SkMacFlushRxFifo();
 extern void	SkMacIrq();
 extern int	SkMacAutoNegDone();
 extern void	SkMacAutoNegLipaPhy();
-extern void SkMacSetRxTxEn();
 extern void	SkXmInitMac();
 extern void	SkXmPhyRead();
 extern void	SkXmPhyWrite();
@@ -820,8 +768,6 @@
 extern void	SkGmPhyRead();
 extern void	SkGmPhyWrite();
 extern void	SkXmClrExactAddr();
-extern void	SkXmInitDupMd();
-extern void	SkXmInitPauseMd();
 extern void	SkXmAutoNegLipaXmac();
 extern int	SkXmUpdateStats();
 extern int	SkGmUpdateStats();
@@ -832,8 +778,6 @@
 extern int	SkXmOverflowStatus();
 extern int	SkGmOverflowStatus();
 extern int	SkGmCableDiagStatus();
-extern int	SkGmEnterLowPowerMode();
-extern int	SkGmLeaveLowPowerMode();
 
 #ifdef SK_DIAG
 extern void	SkGePhyRead();
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skgeinit.c.old	2005-04-19 23:47:17.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skgeinit.c	2005-04-20 00:20:01.000000000 +0200
@@ -59,34 +59,6 @@
 
 /******************************************************************************
  *
- *	SkGePollRxD() - Enable / Disable Descriptor Polling of RxD Ring
- *
- * Description:
- *	Enable or disable the descriptor polling of the receive descriptor
- *	ring (RxD) for port 'Port'.
- *	The new configuration is *not* saved over any SkGeStopPort() and
- *	SkGeInitPort() calls.
- *
- * Returns:
- *	nothing
- */
-void SkGePollRxD(
-SK_AC	*pAC,		/* adapter context */
-SK_IOC	IoC,		/* IO context */
-int		Port,		/* Port Index (MAC_1 + n) */
-SK_BOOL PollRxD)	/* SK_TRUE (enable pol.), SK_FALSE (disable pol.) */
-{
-	SK_GEPORT *pPrt;
-
-	pPrt = &pAC->GIni.GP[Port];
-
-	SK_OUT32(IoC, Q_ADDR(pPrt->PRxQOff, Q_CSR), (PollRxD) ?
-		CSR_ENA_POL : CSR_DIS_POL);
-}	/* SkGePollRxD */
-
-
-/******************************************************************************
- *
  *	SkGePollTxD() - Enable / Disable Descriptor Polling of TxD Rings
  *
  * Description:
@@ -952,7 +924,7 @@
  * Returns:
  *	nothing
  */
-void SkGeInitRamIface(
+static void SkGeInitRamIface(
 SK_AC	*pAC,		/* adapter context */
 SK_IOC	IoC)		/* IO context */
 {
@@ -1409,83 +1381,6 @@
 
 }	/* SkGeInit0*/
 
-#ifdef SK_PCI_RESET
-
-/******************************************************************************
- *
- *	SkGePciReset() - Reset PCI interface
- *
- * Description:
- *	o Read PCI configuration.
- *	o Change power state to 3.
- *	o Change power state to 0.
- *	o Restore PCI configuration.
- *
- * Returns:
- *	0:	Success.
- *	1:	Power state could not be changed to 3.
- */
-static int SkGePciReset(
-SK_AC	*pAC,		/* adapter context */
-SK_IOC	IoC)		/* IO context */
-{
-	int		i;
-	SK_U16	PmCtlSts;
-	SK_U32	Bp1;
-	SK_U32	Bp2;
-	SK_U16	PciCmd;
-	SK_U8	Cls;
-	SK_U8	Lat;
-	SK_U8	ConfigSpace[PCI_CFG_SIZE];
-
-	/*
-	 * Note: Switching to D3 state is like a software reset.
-	 *		 Switching from D3 to D0 is a hardware reset.
-	 *		 We have to save and restore the configuration space.
-	 */
-	for (i = 0; i < PCI_CFG_SIZE; i++) {
-		SkPciReadCfgDWord(pAC, i*4, &ConfigSpace[i]);
-	}
-
-	/* We know the RAM Interface Arbiter is enabled. */
-	SkPciWriteCfgWord(pAC, PCI_PM_CTL_STS, PCI_PM_STATE_D3);
-	SkPciReadCfgWord(pAC, PCI_PM_CTL_STS, &PmCtlSts);
-	
-	if ((PmCtlSts & PCI_PM_STATE_MSK) != PCI_PM_STATE_D3) {
-		return(1);
-	}
-
-	/* Return to D0 state. */
-	SkPciWriteCfgWord(pAC, PCI_PM_CTL_STS, PCI_PM_STATE_D0);
-
-	/* Check for D0 state. */
-	SkPciReadCfgWord(pAC, PCI_PM_CTL_STS, &PmCtlSts);
-	
-	if ((PmCtlSts & PCI_PM_STATE_MSK) != PCI_PM_STATE_D0) {
-		return(1);
-	}
-
-	/* Check PCI Config Registers. */
-	SkPciReadCfgWord(pAC, PCI_COMMAND, &PciCmd);
-	SkPciReadCfgByte(pAC, PCI_CACHE_LSZ, &Cls);
-	SkPciReadCfgDWord(pAC, PCI_BASE_1ST, &Bp1);
-	SkPciReadCfgDWord(pAC, PCI_BASE_2ND, &Bp2);
-	SkPciReadCfgByte(pAC, PCI_LAT_TIM, &Lat);
-	
-	if (PciCmd != 0 || Cls != (SK_U8)0 || Lat != (SK_U8)0 ||
-		(Bp1 & 0xfffffff0L) != 0 || Bp2 != 1) {
-		return(1);
-	}
-
-	/* Restore PCI Config Space. */
-	for (i = 0; i < PCI_CFG_SIZE; i++) {
-		SkPciWriteCfgDWord(pAC, i*4, ConfigSpace[i]);
-	}
-
-	return(0);
-}	/* SkGePciReset */
-
-#endif /* SK_PCI_RESET */
 
 /******************************************************************************
  *
@@ -1524,10 +1419,6 @@
 	/* save CLK_RUN bits (YUKON-Lite) */
 	SK_IN16(IoC, B0_CTST, &CtrlStat);
 
-#ifdef SK_PCI_RESET
-	(void)SkGePciReset(pAC, IoC);
-#endif /* SK_PCI_RESET */
-
 	/* do the SW-reset */
 	SK_OUT8(IoC, B0_CTST, CS_RST_SET);
 
@@ -1991,11 +1882,6 @@
 	int	i;
 	SK_U16	Word;
 
-#ifdef SK_PHY_LP_MODE
-	SK_U8	Byte;
-	SK_U16	PmCtlSts;
-#endif /* SK_PHY_LP_MODE */
-
 #if (!defined(SK_SLIM) && !defined(VCPU))
 	/* ensure I2C is ready */
 	SkI2cWaitIrq(pAC, IoC);
@@ -2010,38 +1896,6 @@
 		}
 	}
 
-#ifdef SK_PHY_LP_MODE
-    /*
-	 * for power saving purposes within mobile environments
-	 * we set the PHY to coma mode and switch to D3 power state.
-	 */
-	if (pAC->GIni.GIYukonLite &&
-		pAC->GIni.GIChipRev == CHIP_REV_YU_LITE_A3) {
-
-		/* for all ports switch PHY to coma mode */
-		for (i = 0; i < pAC->GIni.GIMacsFound; i++) {
-			
-			SkGmEnterLowPowerMode(pAC, IoC, i, PHY_PM_DEEP_SLEEP);
-		}
-
-		if (pAC->GIni.GIVauxAvail) {
-			/* switch power to VAUX */
-			Byte = PC_VAUX_ENA | PC_VCC_ENA | PC_VAUX_ON | PC_VCC_OFF;
-
-			SK_OUT8(IoC, B0_POWER_CTRL, Byte);
-		}
-		
-		/* switch to D3 state */
-		SK_IN16(IoC, PCI_C(PCI_PM_CTL_STS), &PmCtlSts);
-
-		PmCtlSts |= PCI_PM_STATE_D3;
-
-		SK_OUT8(IoC, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-
-		SK_OUT16(IoC, PCI_C(PCI_PM_CTL_STS), PmCtlSts);
-	}
-#endif /* SK_PHY_LP_MODE */
-
 	/* Reset all bits in the PCI STATUS register */
 	/*
 	 * Note: PCI Cfg cycles cannot be used, because they are not
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skgepnmi.h.old	2005-04-19 23:48:35.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skgepnmi.h	2005-04-20 00:16:53.000000000 +0200
@@ -946,10 +946,6 @@
  * Function prototypes
  */
 extern int SkPnmiInit(SK_AC *pAC, SK_IOC IoC, int Level);
-extern int SkPnmiGetVar(SK_AC *pAC, SK_IOC IoC, SK_U32 Id, void* pBuf,
-	unsigned int* pLen, SK_U32 Instance, SK_U32 NetIndex);
-extern int SkPnmiPreSetVar(SK_AC *pAC, SK_IOC IoC, SK_U32 Id,
-	void* pBuf, unsigned int *pLen, SK_U32 Instance, SK_U32 NetIndex);
 extern int SkPnmiSetVar(SK_AC *pAC, SK_IOC IoC, SK_U32 Id, void* pBuf,
 	unsigned int *pLen, SK_U32 Instance, SK_U32 NetIndex);
 extern int SkPnmiGetStruct(SK_AC *pAC, SK_IOC IoC, void* pBuf,
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skgepnmi.c.old	2005-04-19 23:48:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skgepnmi.c	2005-04-20 00:20:49.000000000 +0200
@@ -56,10 +56,6 @@
  * Public Function prototypes
  */
 int SkPnmiInit(SK_AC *pAC, SK_IOC IoC, int level);
-int SkPnmiGetVar(SK_AC *pAC, SK_IOC IoC, SK_U32 Id, void *pBuf,
-	unsigned int *pLen, SK_U32 Instance, SK_U32 NetIndex);
-int SkPnmiPreSetVar(SK_AC *pAC, SK_IOC IoC, SK_U32 Id, void *pBuf,
-	unsigned int *pLen, SK_U32 Instance, SK_U32 NetIndex);
 int SkPnmiSetVar(SK_AC *pAC, SK_IOC IoC, SK_U32 Id, void *pBuf,
 	unsigned int *pLen, SK_U32 Instance, SK_U32 NetIndex);
 int SkPnmiGetStruct(SK_AC *pAC, SK_IOC IoC, void *pBuf,
@@ -587,7 +583,7 @@
  *                           exist (e.g. port instance 3 on a two port
  *	                         adapter.
  */
-int SkPnmiGetVar(
+static int SkPnmiGetVar(
 SK_AC *pAC,		/* Pointer to adapter context */
 SK_IOC IoC,		/* IO context handle */
 SK_U32 Id,		/* Object ID that is to be processed */
@@ -629,7 +625,7 @@
  *                           exist (e.g. port instance 3 on a two port
  *	                         adapter.
  */
-int SkPnmiPreSetVar(
+static int SkPnmiPreSetVar(
 SK_AC *pAC,		/* Pointer to adapter context */
 SK_IOC IoC,		/* IO context handle */
 SK_U32 Id,		/* Object ID that is to be processed */
@@ -5062,9 +5058,6 @@
 		case OID_SKGE_SPEED_CAP:
 		case OID_SKGE_SPEED_MODE:
 		case OID_SKGE_SPEED_STATUS:
-#ifdef SK_PHY_LP_MODE
-		case OID_SKGE_PHY_LP_MODE:
-#endif
 			if (*pLen < (Limit - LogPortIndex) * sizeof(SK_U8)) {
 
 				*pLen = (Limit - LogPortIndex) * sizeof(SK_U8);
@@ -5140,28 +5133,6 @@
 				Offset += sizeof(SK_U32);
 				break;
 
-#ifdef SK_PHY_LP_MODE
-			case OID_SKGE_PHY_LP_MODE:
-				if (!pAC->Pnmi.DualNetActiveFlag) { /* SingleNetMode */
-					if (LogPortIndex == 0) {
-						continue;
-					}
-					else {
-						/* Get value for physical ports */
-						PhysPortIndex = SK_PNMI_PORT_LOG2PHYS(pAC, LogPortIndex);
-						Val8 = (SK_U8) pAC->GIni.GP[PhysPortIndex].PPhyPowerState;
-						*pBufPtr = Val8;
-					}
-				}
-				else { /* DualNetMode */
-					
-					Val8 = (SK_U8) pAC->GIni.GP[PhysPortIndex].PPhyPowerState;
-					*pBufPtr = Val8;
-				}
-				Offset += sizeof(SK_U8);
-				break;
-#endif
-
 			case OID_SKGE_LINK_CAP:
 				if (!pAC->Pnmi.DualNetActiveFlag) { /* SingleNetMode */
 					if (LogPortIndex == 0) {
@@ -5478,16 +5449,6 @@
 		}
 		break;
 
-#ifdef SK_PHY_LP_MODE
-	case OID_SKGE_PHY_LP_MODE:
-		if (*pLen < Limit - LogPortIndex) {
-
-			*pLen = Limit - LogPortIndex;
-			return (SK_PNMI_ERR_TOO_SHORT);
-		}
-		break;
-#endif
-
 	case OID_SKGE_MTU:
 		if (*pLen < sizeof(SK_U32)) {
 
@@ -5845,116 +5806,6 @@
 			Offset += sizeof(SK_U32);
 			break;
 		
-#ifdef SK_PHY_LP_MODE
-		case OID_SKGE_PHY_LP_MODE:
-			/* The preset ends here */
-			if (Action == SK_PNMI_PRESET) {
-
-				return (SK_PNMI_ERR_OK);
-			}
-
-			if (!pAC->Pnmi.DualNetActiveFlag) { /* SingleNetMode */
-				if (LogPortIndex == 0) {
-					Offset = 0;
-					continue;
-				}
-				else {
-					/* Set value for physical ports */
-					PhysPortIndex = SK_PNMI_PORT_LOG2PHYS(pAC, LogPortIndex);
-
-					switch (*(pBuf + Offset)) {
-						case 0:
-							/* If LowPowerMode is active, we can leave it. */
-							if (pAC->GIni.GP[PhysPortIndex].PPhyPowerState) {
-
-								Val32 = SkGmLeaveLowPowerMode(pAC, IoC, PhysPortIndex);
-								
-								if (pAC->GIni.GP[PhysPortIndex].PPhyPowerState < 3)	{
-									
-									SkDrvInitAdapter(pAC);
-								}
-								break;
-							}
-							else {
-								*pLen = 0;
-								return (SK_PNMI_ERR_GENERAL);
-							}
-						case 1:
-						case 2:
-						case 3:
-						case 4:
-							/* If no LowPowerMode is active, we can enter it. */
-							if (!pAC->GIni.GP[PhysPortIndex].PPhyPowerState) {
-
-								if ((*(pBuf + Offset)) < 3)	{
-								
-									SkDrvDeInitAdapter(pAC);
-								}
-
-								Val32 = SkGmEnterLowPowerMode(pAC, IoC, PhysPortIndex, *pBuf);
-								break;
-							}
-							else {
-								*pLen = 0;
-								return (SK_PNMI_ERR_GENERAL);
-							}
-						default:
-							*pLen = 0;
-							return (SK_PNMI_ERR_BAD_VALUE);
-					}
-				}
-			}
-			else { /* DualNetMode */
-				
-				switch (*(pBuf + Offset)) {
-					case 0:
-						/* If we are in a LowPowerMode, we can leave it. */
-						if (pAC->GIni.GP[PhysPortIndex].PPhyPowerState) {
-
-							Val32 = SkGmLeaveLowPowerMode(pAC, IoC, PhysPortIndex);
-							
-							if (pAC->GIni.GP[PhysPortIndex].PPhyPowerState < 3)	{
-
-								SkDrvInitAdapter(pAC);
-							}
-							break;
-						}
-						else {
-							*pLen = 0;
-							return (SK_PNMI_ERR_GENERAL);
-						}
-					
-					case 1:
-					case 2:
-					case 3:
-					case 4:
-						/* If we are not already in LowPowerMode, we can enter it. */
-						if (!pAC->GIni.GP[PhysPortIndex].PPhyPowerState) {
-
-							if ((*(pBuf + Offset)) < 3)	{
-
-								SkDrvDeInitAdapter(pAC);
-							}
-							else {
-
-								Val32 = SkGmEnterLowPowerMode(pAC, IoC, PhysPortIndex, *pBuf);
-							}
-							break;
-						}
-						else {
-							*pLen = 0;
-							return (SK_PNMI_ERR_GENERAL);
-						}
-					
-					default:
-						*pLen = 0;
-						return (SK_PNMI_ERR_BAD_VALUE);
-				}
-			}
-			Offset += sizeof(SK_U8);
-			break;
-#endif
-
 		default:
             SK_DBG_MSG(pAC, SK_DBGMOD_PNMI, SK_DBGCAT_ERR,
                 ("MacPrivateConf: Unknown OID should be handled before set"));
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skgesirq.h.old	2005-04-19 23:49:20.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skgesirq.h	2005-04-19 23:49:26.000000000 +0200
@@ -105,7 +105,6 @@
 
 extern void SkGeSirqIsr(SK_AC *pAC, SK_IOC IoC, SK_U32 Istatus);
 extern int  SkGeSirqEvent(SK_AC *pAC, SK_IOC IoC, SK_U32 Event, SK_EVPARA Para);
-extern void SkHWLinkUp(SK_AC *pAC, SK_IOC IoC, int Port);
 extern void SkHWLinkDown(SK_AC *pAC, SK_IOC IoC, int Port);
 
 #endif	/* _INC_SKGESIRQ_H_ */
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skgesirq.c.old	2005-04-19 23:49:36.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skgesirq.c	2005-04-20 00:16:42.000000000 +0200
@@ -265,7 +265,7 @@
  *
  * Returns: N/A
  */
-void SkHWLinkUp(
+static void SkHWLinkUp(
 SK_AC	*pAC,	/* adapter context */
 SK_IOC	IoC,	/* IO context */
 int		Port)	/* Port Index (MAC_1 + n) */
@@ -612,14 +612,6 @@
 				 * we ignore those
 				 */
 				pPrt->HalfDupTimerActive = SK_TRUE;
-#ifdef XXX
-				Len = sizeof(SK_U64);
-				SkPnmiGetVar(pAC, IoC, OID_SKGE_STAT_TX_OCTETS, (char *)&Octets,
-					&Len, (SK_U32)SK_PNMI_PORT_PHYS2INST(pAC, 0),
-					pAC->Rlmt.Port[0].Net->NetNumber);
-				
-				pPrt->LastOctets = Octets;
-#endif /* XXX */
 				/* Snap statistic counters */
 				(void)SkXmUpdateStats(pAC, IoC, 0);
 
@@ -653,14 +645,6 @@
 				 pPrt->PLinkModeStatus == SK_LMODE_STAT_AUTOHALF) &&
 				!pPrt->HalfDupTimerActive) {
 				pPrt->HalfDupTimerActive = SK_TRUE;
-#ifdef XXX
-				Len = sizeof(SK_U64);
-				SkPnmiGetVar(pAC, IoC, OID_SKGE_STAT_TX_OCTETS, (char *)&Octets,
-					&Len, (SK_U32)SK_PNMI_PORT_PHYS2INST(pAC, 1),
-					pAC->Rlmt.Port[1].Net->NetNumber);
-				
-				pPrt->LastOctets = Octets;
-#endif /* XXX */
 				/* Snap statistic counters */
 				(void)SkXmUpdateStats(pAC, IoC, 1);
 
@@ -2085,12 +2069,6 @@
 			pPrt->HalfDupTimerActive = SK_FALSE;
 			if (pPrt->PLinkModeStatus == SK_LMODE_STAT_HALF ||
 				pPrt->PLinkModeStatus == SK_LMODE_STAT_AUTOHALF) {
-#ifdef XXX
-				Len = sizeof(SK_U64);
-				SkPnmiGetVar(pAC, IoC, OID_SKGE_STAT_TX_OCTETS, (char *)&Octets,
-					&Len, (SK_U32)SK_PNMI_PORT_PHYS2INST(pAC, Port),
-					pAC->Rlmt.Port[Port].Net->NetNumber);
-#endif /* XXX */
 				/* Snap statistic counters */
 				(void)SkXmUpdateStats(pAC, IoC, Port);
 
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/ski2c.h.old	2005-04-19 23:49:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/ski2c.h	2005-04-19 23:50:39.000000000 +0200
@@ -162,9 +162,6 @@
 } SK_I2C;
 
 extern int SkI2cInit(SK_AC *pAC, SK_IOC IoC, int Level);
-extern int SkI2cWrite(SK_AC *pAC, SK_IOC IoC, SK_U32 Data, int Dev, int Size,
-					   int Reg, int Burst);
-extern int SkI2cReadSensor(SK_AC *pAC, SK_IOC IoC, SK_SENSOR *pSen);
 #ifdef SK_DIAG
 extern	SK_U32 SkI2cRead(SK_AC *pAC, SK_IOC IoC, int Dev, int Size, int Reg,
 						 int Burst);
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/ski2c.c.old	2005-04-19 23:50:12.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/ski2c.c	2005-04-20 00:19:10.000000000 +0200
@@ -396,7 +396,7 @@
  *			1:	error,	 transfer does not complete, I2C transfer
  *						 killed, wait loop terminated.
  */
-int	SkI2cWait(
+static int	SkI2cWait(
 SK_AC	*pAC,	/* Adapter Context */
 SK_IOC	IoC,	/* I/O Context */
 int		Event)	/* complete event to wait for (I2C_READ or I2C_WRITE) */
@@ -481,7 +481,7 @@
  * returns	0:	success
  *			1:	error
  */
-int SkI2cWrite(
+static int SkI2cWrite(
 SK_AC	*pAC,		/* Adapter Context */
 SK_IOC	IoC,		/* I/O Context */
 SK_U32	I2cData,	/* I2C Data to write */
@@ -538,7 +538,7 @@
  *		1 if the read is completed
  *		0 if the read must be continued (I2C Bus still allocated)
  */
-int	SkI2cReadSensor(
+static int	SkI2cReadSensor(
 SK_AC		*pAC,	/* Adapter Context */
 SK_IOC		IoC,	/* I/O Context */
 SK_SENSOR	*pSen)	/* Sensor to be read */
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skrlmt.c.old	2005-04-19 23:50:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skrlmt.c	2005-04-19 23:51:05.000000000 +0200
@@ -282,7 +282,6 @@
 
 SK_MAC_ADDR	SkRlmtMcAddr =	{{0x01,  0x00,  0x5A,  0x52,  0x4C,  0x4D}};
 SK_MAC_ADDR	BridgeMcAddr =	{{0x01,  0x80,  0xC2,  0x00,  0x00,  0x00}};
-SK_MAC_ADDR	BcAddr = 		{{0xFF,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF}};
 
 /* local variables ************************************************************/
 
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skvpd.h.old	2005-04-19 23:51:20.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skvpd.h	2005-04-20 00:28:16.000000000 +0200
@@ -191,14 +191,6 @@
 	int			addr);
 #endif	/* SKDIAG */
 
-extern int	VpdSetupPara(
-	SK_AC		*pAC,
-	const char	*key,
-	const char	*buf,
-	int			len,
-	int			type,
-	int			op);
-
 extern SK_VPD_STATUS	*VpdStat(
 	SK_AC		*pAC,
 	SK_IOC		IoC);
@@ -235,11 +227,6 @@
 	SK_AC		*pAC,
 	SK_IOC		IoC);
 
-extern void	VpdErrLog(
-	SK_AC		*pAC,
-	SK_IOC		IoC,
-	char		*msg);
-
 #ifdef	SKDIAG
 extern int	VpdReadBlock(
 	SK_AC		*pAC,
@@ -257,7 +244,6 @@
 #endif	/* SKDIAG */
 #else	/* SK_KR_PROTO */
 extern SK_U32	VpdReadDWord();
-extern int	VpdSetupPara();
 extern SK_VPD_STATUS	*VpdStat();
 extern int	VpdKeys();
 extern int	VpdRead();
@@ -265,7 +251,6 @@
 extern int	VpdWrite();
 extern int	VpdDelete();
 extern int	VpdUpdate();
-extern void	VpdErrLog();
 #endif	/* SK_KR_PROTO */
 
 #endif	/* __INC_SKVPD_H_ */
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skvpd.c.old	2005-04-19 23:51:35.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skvpd.c	2005-04-20 00:11:20.000000000 +0200
@@ -132,65 +132,6 @@
 
 #endif	/* SKDIAG */
 
-#if 0
-
-/*
-	Write the dword 'data' at address 'addr' into the VPD EEPROM, and
-	verify that the data is written.
-
- Needed Time:
-
-.				MIN		MAX
-. -------------------------------------------------------------------
-. write				1.8 ms		3.6 ms
-. internal write cyles		0.7 ms		7.0 ms
-. -------------------------------------------------------------------
-. over all program time	 	2.5 ms		10.6 ms
-. read				1.3 ms		2.6 ms
-. -------------------------------------------------------------------
-. over all 			3.8 ms		13.2 ms
-.
-
-
- Returns	0:	success
-			1:	error,	I2C transfer does not terminate
-			2:	error,	data verify error
-
- */
-static int VpdWriteDWord(
-SK_AC	*pAC,	/* pAC pointer */
-SK_IOC	IoC,	/* IO Context */
-int		addr,	/* VPD address */
-SK_U32	data)	/* VPD data to write */
-{
-	/* start VPD write */
-	/* Don't swap here, it's a data stream of bytes */
-	SK_DBG_MSG(pAC, SK_DBGMOD_VPD, SK_DBGCAT_CTRL,
-		("VPD write dword at addr 0x%x, data = 0x%x\n",addr,data));
-	VPD_OUT32(pAC, IoC, PCI_VPD_DAT_REG, (SK_U32)data);
-	/* But do it here */
-	addr |= VPD_WRITE;
-
-	VPD_OUT16(pAC, IoC, PCI_VPD_ADR_REG, (SK_U16)(addr | VPD_WRITE));
-
-	/* this may take up to 10,6 ms */
-	if (VpdWait(pAC, IoC, VPD_WRITE)) {
-		SK_DBG_MSG(pAC, SK_DBGMOD_VPD, SK_DBGCAT_ERR,
-			("Write Timed Out\n"));
-		return(1);
-	};
-
-	/* verify data */
-	if (VpdReadDWord(pAC, IoC, addr) != data) {
-		SK_DBG_MSG(pAC, SK_DBGMOD_VPD, SK_DBGCAT_ERR | SK_DBGCAT_FATAL,
-			("Data Verify Error\n"));
-		return(2);
-	}
-	return(0);
-}	/* VpdWriteDWord */
-
-#endif	/* 0 */
-
 /*
  *	Read one Stream of 'len' bytes of VPD data, starting at 'addr' from
  *	or to the I2C EEPROM.
@@ -728,7 +669,7 @@
  *		6:	fatal VPD error
  *
  */
-int	VpdSetupPara(
+static int	VpdSetupPara(
 SK_AC	*pAC,		/* common data base */
 const char	*key,	/* keyword to insert */
 const char	*buf,	/* buffer with the keyword value */
@@ -1148,50 +1089,3 @@
 	return(0);
 }
 
-
-
-/*
- *	Read the contents of the VPD EEPROM and copy it to the VPD buffer
- *	if not already done. If the keyword "VF" is not present it will be
- *	created and the error log message will be stored to this keyword.
- *	If "VF" is not present the error log message will be stored to the
- *	keyword "VL". "VL" will created or overwritten if "VF" is present.
- *	The VPD read/write area is saved to the VPD EEPROM.
- *
- * returns nothing, errors will be ignored.
- */
-void VpdErrLog(
-SK_AC	*pAC,	/* common data base */
-SK_IOC	IoC,	/* IO Context */
-char	*msg)	/* error log message */
-{
-	SK_VPD_PARA *v, vf;	/* VF */
-	int len;
-
-	SK_DBG_MSG(pAC, SK_DBGMOD_VPD, SK_DBGCAT_TX,
-		("VPD error log msg %s\n", msg));
-	if ((pAC->vpd.v.vpd_status & VPD_VALID) == 0) {
-		if (VpdInit(pAC, IoC) != 0) {
-			SK_DBG_MSG(pAC, SK_DBGMOD_VPD, SK_DBGCAT_ERR,
-				("VPD init error\n"));
-			return;
-		}
-	}
-
-	len = strlen(msg);
-	if (len > VPD_MAX_LEN) {
-		/* cut it */
-		len = VPD_MAX_LEN;
-	}
-	if ((v = vpd_find_para(pAC, VPD_VF, &vf)) != NULL) {
-		SK_DBG_MSG(pAC, SK_DBGMOD_VPD, SK_DBGCAT_TX, ("overwrite VL\n"));
-		(void)VpdSetupPara(pAC, VPD_VL, msg, len, VPD_RW_KEY, OWR_KEY);
-	}
-	else {
-		SK_DBG_MSG(pAC, SK_DBGMOD_VPD, SK_DBGCAT_TX, ("write VF\n"));
-		(void)VpdSetupPara(pAC, VPD_VF, msg, len, VPD_RW_KEY, ADD_KEY);
-	}
-
-	(void)VpdUpdate(pAC, IoC);
-}
-
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skxmac2.c.old	2005-04-19 23:52:29.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skxmac2.c	2005-04-20 00:25:17.000000000 +0200
@@ -41,13 +41,13 @@
 #endif
 
 #ifdef GENESIS
-BCOM_HACK BcomRegA1Hack[] = {
+static BCOM_HACK BcomRegA1Hack[] = {
  { 0x18, 0x0c20 }, { 0x17, 0x0012 }, { 0x15, 0x1104 }, { 0x17, 0x0013 },
  { 0x15, 0x0404 }, { 0x17, 0x8006 }, { 0x15, 0x0132 }, { 0x17, 0x8006 },
  { 0x15, 0x0232 }, { 0x17, 0x800D }, { 0x15, 0x000F }, { 0x18, 0x0420 },
  { 0, 0 }
 };
-BCOM_HACK BcomRegC0Hack[] = {
+static BCOM_HACK BcomRegC0Hack[] = {
  { 0x18, 0x0c20 }, { 0x17, 0x0012 }, { 0x15, 0x1204 }, { 0x17, 0x0013 },
  { 0x15, 0x0A04 }, { 0x18, 0x0420 },
  { 0, 0 }
@@ -790,7 +790,7 @@
  * Returns:
  *	nothing
  */
-void SkMacFlushRxFifo(
+static void SkMacFlushRxFifo(
 SK_AC	*pAC,	/* adapter context */
 SK_IOC	IoC,	/* IO context */
 int		Port)	/* Port Index (MAC_1 + n) */
@@ -1231,38 +1231,6 @@
 }	/* SkMacHardRst */
 
 
-/******************************************************************************
- *
- *	SkMacClearRst() - Clear the MAC reset
- *
- * Description:	calls a clear MAC reset routine dep. on board type
- *
- * Returns:
- *	nothing
- */
-void SkMacClearRst(
-SK_AC	*pAC,	/* adapter context */
-SK_IOC	IoC,	/* IO context */
-int		Port)	/* Port Index (MAC_1 + n) */
-{
-	
-#ifdef GENESIS
-	if (pAC->GIni.GIGenesis) {
-		
-		SkXmClearRst(pAC, IoC, Port);
-	}
-#endif /* GENESIS */
-	
-#ifdef YUKON
-	if (pAC->GIni.GIYukon) {
-		
-		SkGmClearRst(pAC, IoC, Port);
-	}
-#endif /* YUKON */
-
-}	/* SkMacClearRst */
-
-
 #ifdef GENESIS
 /******************************************************************************
  *
@@ -1713,7 +1681,7 @@
  * Returns:
  *	nothing
  */
-void SkXmInitDupMd(
+static void SkXmInitDupMd(
 SK_AC	*pAC,		/* adapter context */
 SK_IOC	IoC,		/* IO context */
 int		Port)		/* Port Index (MAC_1 + n) */
@@ -1761,7 +1729,7 @@
  * Returns:
  *	nothing
  */
-void SkXmInitPauseMd(
+static void SkXmInitPauseMd(
 SK_AC	*pAC,		/* adapter context */
 SK_IOC	IoC,		/* IO context */
 int		Port)		/* Port Index (MAC_1 + n) */
@@ -2076,283 +2044,7 @@
 }	/* SkXmInitPhyBcom */
 #endif /* GENESIS */
 
-
 #ifdef YUKON
-#ifndef SK_SLIM
-/******************************************************************************
- *
- *	SkGmEnterLowPowerMode()
- *
- * Description:	
- *	This function sets the Marvell Alaska PHY to the low power mode
- *	given by parameter mode.
- *	The following low power modes are available:
- *		
- *		- Coma Mode (Deep Sleep):
- *			Power consumption: ~15 - 30 mW
- *			The PHY cannot wake up on its own.
- *
- *		- IEEE 22.2.4.1.5 compatible power down mode
- *			Power consumption: ~240 mW
- *			The PHY cannot wake up on its own.
- *
- *		- energy detect mode
- *			Power consumption: ~160 mW
- *			The PHY can wake up on its own by detecting activity
- *			on the CAT 5 cable.
- *
- *		- energy detect plus mode
- *			Power consumption: ~150 mW
- *			The PHY can wake up on its own by detecting activity
- *			on the CAT 5 cable.
- *			Connected devices can be woken up by sending normal link
- *			pulses every one second.
- *
- * Note:
- *
- * Returns:
- *		0: ok
- *		1: error
- */
-int SkGmEnterLowPowerMode(
-SK_AC	*pAC,		/* adapter context */
-SK_IOC	IoC,		/* IO context */
-int		Port,		/* Port Index (e.g. MAC_1) */
-SK_U8	Mode)		/* low power mode */
-{
-	SK_U16	Word;
-	SK_U32	DWord;
-	SK_U8	LastMode;
-	int		Ret = 0;
-
-	if (pAC->GIni.GIYukonLite &&
-	    pAC->GIni.GIChipRev == CHIP_REV_YU_LITE_A3) {
-
-		/* save current power mode */
-		LastMode = pAC->GIni.GP[Port].PPhyPowerState;
-		pAC->GIni.GP[Port].PPhyPowerState = Mode;
-
-		switch (Mode) {
-			/* coma mode (deep sleep) */
-			case PHY_PM_DEEP_SLEEP:
-				/* setup General Purpose Control Register */
-				GM_OUT16(IoC, 0, GM_GP_CTRL, GM_GPCR_FL_PASS |
-					GM_GPCR_SPEED_100 | GM_GPCR_AU_ALL_DIS);
-
-				/* apply COMA mode workaround */
-				SkGmPhyWrite(pAC, IoC, Port, 29, 0x001f);
-				SkGmPhyWrite(pAC, IoC, Port, 30, 0xfff3);
-
-				SK_IN32(IoC, PCI_C(PCI_OUR_REG_1), &DWord);
-
-				SK_OUT8(IoC, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-				
-				/* Set PHY to Coma Mode */
-				SK_OUT32(IoC, PCI_C(PCI_OUR_REG_1), DWord | PCI_PHY_COMA);
-				
-				SK_OUT8(IoC, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
-
-			break;
-			
-			/* IEEE 22.2.4.1.5 compatible power down mode */
-			case PHY_PM_IEEE_POWER_DOWN:
-				/*
-				 * - disable MAC 125 MHz clock
-				 * - allow MAC power down
-				 */
-				SkGmPhyRead(pAC, IoC, Port, PHY_MARV_PHY_CTRL, &Word);
-				Word |= PHY_M_PC_DIS_125CLK;
-				Word &=	~PHY_M_PC_MAC_POW_UP;
-				SkGmPhyWrite(pAC, IoC, Port, PHY_MARV_PHY_CTRL, Word);
-
-				/*
-				 * register changes must be followed by a software
-				 * reset to take effect
-				 */
-				SkGmPhyRead(pAC, IoC, Port, PHY_MARV_CTRL, &Word);
-				Word |= PHY_CT_RESET;
-				SkGmPhyWrite(pAC, IoC, Port, PHY_MARV_CTRL, Word);
-
-				/* switch IEEE compatible power down mode on */
-				SkGmPhyRead(pAC, IoC, Port, PHY_MARV_CTRL, &Word);
-				Word |= PHY_CT_PDOWN;
-				SkGmPhyWrite(pAC, IoC, Port, PHY_MARV_CTRL, Word);
-			break;
-
-			/* energy detect and energy detect plus mode */
-			case PHY_PM_ENERGY_DETECT:
-			case PHY_PM_ENERGY_DETECT_PLUS:
-				/*
-				 * - disable MAC 125 MHz clock
-				 */
-				SkGmPhyRead(pAC, IoC, Port, PHY_MARV_PHY_CTRL, &Word);
-				Word |= PHY_M_PC_DIS_125CLK;
-				SkGmPhyWrite(pAC, IoC, Port, PHY_MARV_PHY_CTRL, Word);
-				
-				/* activate energy detect mode 1 */
-				SkGmPhyRead(pAC, IoC, Port, PHY_MARV_PHY_CTRL, &Word);
-
-				/* energy detect mode */
-				if (Mode == PHY_PM_ENERGY_DETECT) {
-					Word |= PHY_M_PC_EN_DET;
-				}
-				/* energy detect plus mode */
-				else {
-					Word |= PHY_M_PC_EN_DET_PLUS;
-				}
-
-				SkGmPhyWrite(pAC, IoC, Port, PHY_MARV_PHY_CTRL, Word);
-
-				/*
-				 * reinitialize the PHY to force a software reset
-				 * which is necessary after the register settings
-				 * for the energy detect modes.
-				 * Furthermore reinitialisation prevents that the
-				 * PHY is running out of a stable state.
-				 */
-				SkGmInitPhyMarv(pAC, IoC, Port, SK_FALSE);
-			break;
-
-			/* don't change current power mode */
-			default:
-				pAC->GIni.GP[Port].PPhyPowerState = LastMode;
-				Ret = 1;
-			break;
-		}
-	}
-	/* low power modes are not supported by this chip */
-	else {
-		Ret = 1;
-	}
-
-	return(Ret);
-
-}	/* SkGmEnterLowPowerMode */
-
-/******************************************************************************
- *
- *	SkGmLeaveLowPowerMode()
- *
- * Description:	
- *	Leave the current low power mode and switch to normal mode
- *
- * Note:
- *
- * Returns:
- *		0:	ok
- *		1:	error
- */
-int SkGmLeaveLowPowerMode(
-SK_AC	*pAC,		/* adapter context */
-SK_IOC	IoC,		/* IO context */
-int		Port)		/* Port Index (e.g. MAC_1) */
-{
-	SK_U32	DWord;
-	SK_U16	Word;
-	SK_U8	LastMode;
-	int		Ret = 0;
-
-	if (pAC->GIni.GIYukonLite &&
-		pAC->GIni.GIChipRev == CHIP_REV_YU_LITE_A3) {
-
-		/* save current power mode */
-		LastMode = pAC->GIni.GP[Port].PPhyPowerState;
-		pAC->GIni.GP[Port].PPhyPowerState = PHY_PM_OPERATIONAL_MODE;
-
-		switch (LastMode) {
-			/* coma mode (deep sleep) */
-			case PHY_PM_DEEP_SLEEP:
-				SK_IN32(IoC, PCI_C(PCI_OUR_REG_1), &DWord);
-
-				SK_OUT8(IoC, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-				
-				/* Release PHY from Coma Mode */
-				SK_OUT32(IoC, PCI_C(PCI_OUR_REG_1), DWord & ~PCI_PHY_COMA);
-				
-				SK_OUT8(IoC, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
-				
-				SK_IN32(IoC, B2_GP_IO, &DWord);
-
-				/* set to output */
-				DWord |= (GP_DIR_9 | GP_IO_9);
-
-				/* set PHY reset */
-				SK_OUT32(IoC, B2_GP_IO, DWord);
-
-				DWord &= ~GP_IO_9; /* clear PHY reset (active high) */
-
-				/* clear PHY reset */
-				SK_OUT32(IoC, B2_GP_IO, DWord);
-			break;
-			
-			/* IEEE 22.2.4.1.5 compatible power down mode */
-			case PHY_PM_IEEE_POWER_DOWN:
-				/*
-				 * - enable MAC 125 MHz clock
-				 * - set MAC power up
-				 */
-				SkGmPhyRead(pAC, IoC, Port, PHY_MARV_PHY_CTRL, &Word);
-				Word &= ~PHY_M_PC_DIS_125CLK;
-				Word |=	PHY_M_PC_MAC_POW_UP;
-				SkGmPhyWrite(pAC, IoC, Port, PHY_MARV_PHY_CTRL, Word);
-
-				/*
-				 * register changes must be followed by a software
-				 * reset to take effect
-				 */
-				SkGmPhyRead(pAC, IoC, Port, PHY_MARV_CTRL, &Word);
-				Word |= PHY_CT_RESET;
-				SkGmPhyWrite(pAC, IoC, Port, PHY_MARV_CTRL, Word);
-
-				/* switch IEEE compatible power down mode off */
-				SkGmPhyRead(pAC, IoC, Port, PHY_MARV_CTRL, &Word);
-				Word &= ~PHY_CT_PDOWN;
-				SkGmPhyWrite(pAC, IoC, Port, PHY_MARV_CTRL, Word);
-			break;
-
-			/* energy detect and energy detect plus mode */
-			case PHY_PM_ENERGY_DETECT:
-			case PHY_PM_ENERGY_DETECT_PLUS:
-				/*
-				 * - enable MAC 125 MHz clock
-				 */
-				SkGmPhyRead(pAC, IoC, Port, PHY_MARV_PHY_CTRL, &Word);
-				Word &= ~PHY_M_PC_DIS_125CLK;
-				SkGmPhyWrite(pAC, IoC, Port, PHY_MARV_PHY_CTRL, Word);
-				
-				/* disable energy detect mode */
-				SkGmPhyRead(pAC, IoC, Port, PHY_MARV_PHY_CTRL, &Word);
-				Word &= ~PHY_M_PC_EN_DET_MSK;
-				SkGmPhyWrite(pAC, IoC, Port, PHY_MARV_PHY_CTRL, Word);
-
-				/*
-				 * reinitialize the PHY to force a software reset
-				 * which is necessary after the register settings
-				 * for the energy detect modes.
-				 * Furthermore reinitialisation prevents that the
-				 * PHY is running out of a stable state.
-				 */
-				SkGmInitPhyMarv(pAC, IoC, Port, SK_FALSE);
-			break;
-
-			/* don't change current power mode */
-			default:
-				pAC->GIni.GP[Port].PPhyPowerState = LastMode;
-				Ret = 1;
-			break;
-		}
-	}
-	/* low power modes are not supported by this chip */
-	else {
-		Ret = 1;
-	}
-
-	return(Ret);
-
-}	/* SkGmLeaveLowPowerMode */
-#endif /* !SK_SLIM */
-
-
 /******************************************************************************
  *
  *	SkGmInitPhyMarv() - Initialize the Marvell Phy registers
@@ -3420,145 +3112,6 @@
 }	/* SkMacAutoNegDone */
 
 
-#ifdef GENESIS
-/******************************************************************************
- *
- *	SkXmSetRxTxEn() - Special Set Rx/Tx Enable and some features in XMAC
- *
- * Description:
- *  sets MAC or PHY LoopBack and Duplex Mode in the MMU Command Reg.
- *  enables Rx/Tx
- *
- * Returns: N/A
- */
-static void SkXmSetRxTxEn(
-SK_AC	*pAC,		/* Adapter Context */
-SK_IOC	IoC,		/* IO context */
-int		Port,		/* Port Index (MAC_1 + n) */
-int		Para)		/* Parameter to set: MAC or PHY LoopBack, Duplex Mode */
-{
-	SK_U16	Word;
-
-	XM_IN16(IoC, Port, XM_MMU_CMD, &Word);
-
-	switch (Para & (SK_MAC_LOOPB_ON | SK_MAC_LOOPB_OFF)) {
-	case SK_MAC_LOOPB_ON:
-		Word |= XM_MMU_MAC_LB;
-		break;
-	case SK_MAC_LOOPB_OFF:
-		Word &= ~XM_MMU_MAC_LB;
-		break;
-	}
-
-	switch (Para & (SK_PHY_LOOPB_ON | SK_PHY_LOOPB_OFF)) {
-	case SK_PHY_LOOPB_ON:
-		Word |= XM_MMU_GMII_LOOP;
-		break;
-	case SK_PHY_LOOPB_OFF:
-		Word &= ~XM_MMU_GMII_LOOP;
-		break;
-	}
-	
-	switch (Para & (SK_PHY_FULLD_ON | SK_PHY_FULLD_OFF)) {
-	case SK_PHY_FULLD_ON:
-		Word |= XM_MMU_GMII_FD;
-		break;
-	case SK_PHY_FULLD_OFF:
-		Word &= ~XM_MMU_GMII_FD;
-		break;
-	}
-	
-	XM_OUT16(IoC, Port, XM_MMU_CMD, Word | XM_MMU_ENA_RX | XM_MMU_ENA_TX);
-
-	/* dummy read to ensure writing */
-	XM_IN16(IoC, Port, XM_MMU_CMD, &Word);
-
-}	/* SkXmSetRxTxEn */
-#endif /* GENESIS */
-
-
-#ifdef YUKON
-/******************************************************************************
- *
- *	SkGmSetRxTxEn() - Special Set Rx/Tx Enable and some features in GMAC
- *
- * Description:
- *  sets MAC LoopBack and Duplex Mode in the General Purpose Control Reg.
- *  enables Rx/Tx
- *
- * Returns: N/A
- */
-static void SkGmSetRxTxEn(
-SK_AC	*pAC,		/* Adapter Context */
-SK_IOC	IoC,		/* IO context */
-int		Port,		/* Port Index (MAC_1 + n) */
-int		Para)		/* Parameter to set: MAC LoopBack, Duplex Mode */
-{
-	SK_U16	Ctrl;
-	
-	GM_IN16(IoC, Port, GM_GP_CTRL, &Ctrl);
-
-	switch (Para & (SK_MAC_LOOPB_ON | SK_MAC_LOOPB_OFF)) {
-	case SK_MAC_LOOPB_ON:
-		Ctrl |= GM_GPCR_LOOP_ENA;
-		break;
-	case SK_MAC_LOOPB_OFF:
-		Ctrl &= ~GM_GPCR_LOOP_ENA;
-		break;
-	}
-
-	switch (Para & (SK_PHY_FULLD_ON | SK_PHY_FULLD_OFF)) {
-	case SK_PHY_FULLD_ON:
-		Ctrl |= GM_GPCR_DUP_FULL;
-		break;
-	case SK_PHY_FULLD_OFF:
-		Ctrl &= ~GM_GPCR_DUP_FULL;
-		break;
-	}
-	
-    GM_OUT16(IoC, Port, GM_GP_CTRL, (SK_U16)(Ctrl | GM_GPCR_RX_ENA |
-		GM_GPCR_TX_ENA));
-
-	/* dummy read to ensure writing */
-	GM_IN16(IoC, Port, GM_GP_CTRL, &Ctrl);
-
-}	/* SkGmSetRxTxEn */
-#endif /* YUKON */
-
-
-#ifndef SK_SLIM
-/******************************************************************************
- *
- *	SkMacSetRxTxEn() - Special Set Rx/Tx Enable and parameters
- *
- * Description:	calls the Special Set Rx/Tx Enable routines dep. on board type
- *
- * Returns: N/A
- */
-void SkMacSetRxTxEn(
-SK_AC	*pAC,		/* Adapter Context */
-SK_IOC	IoC,		/* IO context */
-int		Port,		/* Port Index (MAC_1 + n) */
-int		Para)
-{
-#ifdef GENESIS
-	if (pAC->GIni.GIGenesis) {
-		
-		SkXmSetRxTxEn(pAC, IoC, Port, Para);
-	}
-#endif /* GENESIS */
-	
-#ifdef YUKON
-	if (pAC->GIni.GIYukon) {
-		
-		SkGmSetRxTxEn(pAC, IoC, Port, Para);
-	}
-#endif /* YUKON */
-
-}	/* SkMacSetRxTxEn */
-#endif /* !SK_SLIM */
-
-
 /******************************************************************************
  *
  *	SkMacRxTxEnable() - Enable Rx/Tx activity if port is up
@@ -3976,7 +3529,7 @@
  * Returns:
  *	nothing
  */
-void SkXmIrq(
+static void SkXmIrq(
 SK_AC	*pAC,		/* adapter context */
 SK_IOC	IoC,		/* IO context */
 int		Port)		/* Port Index (MAC_1 + n) */
@@ -4112,7 +3665,7 @@
  * Returns:
  *	nothing
  */
-void SkGmIrq(
+static void SkGmIrq(
 SK_AC	*pAC,		/* adapter context */
 SK_IOC	IoC,		/* IO context */
 int		Port)		/* Port Index (MAC_1 + n) */
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skdrv2nd.h.old	2005-04-20 00:12:04.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/h/skdrv2nd.h	2005-04-20 00:12:10.000000000 +0200
@@ -60,7 +60,6 @@
 extern int		SkPciReadCfgDWord(SK_AC*, int, SK_U32*);
 extern int		SkPciReadCfgWord(SK_AC*, int, SK_U16*);
 extern int		SkPciReadCfgByte(SK_AC*, int, SK_U8*);
-extern int		SkPciWriteCfgDWord(SK_AC*, int, SK_U32);
 extern int		SkPciWriteCfgWord(SK_AC*, int, SK_U16);
 extern int		SkPciWriteCfgByte(SK_AC*, int, SK_U8);
 extern int		SkDrvEvent(SK_AC*, SK_IOC IoC, SK_U32, SK_EVPARA);
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/sklm80.c.old	2005-04-20 00:17:33.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/sklm80.c	2005-04-20 00:18:15.000000000 +0200
@@ -34,79 +34,7 @@
 #include "h/lm80.h"
 #include "h/skdrv2nd.h"		/* Adapter Control- and Driver specific Def. */
 
-#ifdef	SK_DIAG
-#define	BREAK_OR_WAIT(pAC,IoC,Event)	SkI2cWait(pAC,IoC,Event)
-#else	/* nSK_DIAG */
 #define	BREAK_OR_WAIT(pAC,IoC,Event)	break
-#endif	/* nSK_DIAG */
-
-#ifdef	SK_DIAG
-/*
- * read the register 'Reg' from the device 'Dev'
- *
- * return 	read error	-1
- *		success		the read value
- */
-int	SkLm80RcvReg(
-SK_IOC	IoC,		/* Adapter Context */
-int		Dev,		/* I2C device address */
-int		Reg)		/* register to read */
-{
-	int	Val = 0;
-	int	TempExt;
-
-	/* Signal device number */
-	if (SkI2cSndDev(IoC, Dev, I2C_WRITE)) {
-		return(-1);
-	}
-
-	if (SkI2cSndByte(IoC, Reg)) {
-		return(-1);
-	}
-
-	/* repeat start */
-	if (SkI2cSndDev(IoC, Dev, I2C_READ)) {
-		return(-1);
-	}
-
-	switch (Reg) {
-	case LM80_TEMP_IN:
-		Val = (int)SkI2cRcvByte(IoC, 1);
-
-		/* First: correct the value: it might be negative */
-		if ((Val & 0x80) != 0) {
-			/* Value is negative */
-			Val = Val - 256;
-		}
-		Val = Val * SK_LM80_TEMP_LSB;
-		SkI2cStop(IoC);
-		
-		TempExt = (int)SkLm80RcvReg(IoC, LM80_ADDR, LM80_TEMP_CTRL);
-		
-		if (Val > 0) {
-			Val += ((TempExt >> 7) * SK_LM80_TEMPEXT_LSB);
-		}
-		else {
-			Val -= ((TempExt >> 7) * SK_LM80_TEMPEXT_LSB);
-		}
-		return(Val);
-		break;
-	case LM80_VT0_IN:
-	case LM80_VT1_IN:
-	case LM80_VT2_IN:
-	case LM80_VT3_IN:
-		Val = (int)SkI2cRcvByte(IoC, 1) * SK_LM80_VT_LSB;
-		break;
-	
-	default:
-		Val = (int)SkI2cRcvByte(IoC, 1);
-		break;
-	}
-
-	SkI2cStop(IoC);
-	return(Val);
-}
-#endif	/* SK_DIAG */
 
 /*
  * read a sensors value (LM80 specific)
--- linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skgemib.c.old	2005-04-20 00:20:11.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/sk98lin/skgemib.c	2005-04-20 00:20:17.000000000 +0200
@@ -871,13 +871,6 @@
 		sizeof(SK_PNMI_CONF),
 		SK_PNMI_OFF(Conf) + SK_PNMI_CNF_OFF(ConfPhyType),
 		SK_PNMI_RO, MacPrivateConf, 0},
-#ifdef SK_PHY_LP_MODE
-		{OID_SKGE_PHY_LP_MODE,
-		SK_PNMI_MAC_ENTRIES,
-		sizeof(SK_PNMI_CONF),
-		SK_PNMI_OFF(Conf) + SK_PNMI_CNF_OFF(ConfPhyMode),
-		SK_PNMI_RW, MacPrivateConf, 0},
-#endif	
 	{OID_SKGE_LINK_CAP,
 		SK_PNMI_MAC_ENTRIES,
 		sizeof(SK_PNMI_CONF),

