Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWACLas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWACLas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 06:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWACLas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 06:30:48 -0500
Received: from mail.suse.de ([195.135.220.2]:62389 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751373AbWACLar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 06:30:47 -0500
Date: Tue, 3 Jan 2006 12:30:45 +0100
From: Jan Blunck <jblunck@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Eliminate __attribute__ ((packed)) warnings for gcc-4.1
Message-ID: <20060103113045.GB24131@hasse.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since version 4.1 the gcc is warning about ignored attributes. This patch is
using the equivalent attribute on the struct instead of on each of the
structure or union members.

GCC Manual:
  "Specifying Attributes of Types

   packed
    This attribute, attached to struct or union type definition, specifies
    that
    each member of the structure or union is placed to minimize the memory
    required. When attached to an enum definition, it indicates that the
    smallest integral type should be used.

    Specifying this attribute for struct and union types is equivalent to
    specifying the packed attribute on each of the structure or union
    members."

Signed-off-by: Jan Blunck <jblunck@suse.de>

--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eliminate-packed-warnings-2.diff"

 drivers/isdn/hisax/hisax.h          |   20 ++---
 drivers/isdn/hisax/hisax_fcpcipnp.h |   18 ++---
 drivers/net/3c527.h                 |   50 +++++++-------
 drivers/net/irda/vlsi_ir.h          |    4 -
 drivers/net/wan/sdla.c              |    6 -
 include/asm-i386/mpspec_def.h       |    4 -
 include/linux/atalk.h               |   18 ++---
 include/linux/cycx_x25.h            |   66 +++++++++---------
 include/linux/if_frad.h             |   12 +--
 include/linux/isdnif.h              |   70 ++++++++++----------
 include/linux/ncp.h                 |  126 ++++++++++++++++++------------------
 include/linux/sdla.h                |   64 +++++++++---------
 include/linux/wavefront.h           |   34 ++++-----
 include/net/dn_dev.h                |   80 +++++++++++-----------
 include/net/dn_nsp.h                |   74 ++++++++++-----------
 include/sound/wavefront.h           |   34 ++++-----
 16 files changed, 340 insertions(+), 340 deletions(-)

Index: linux-2.6/include/asm-i386/mpspec_def.h
===================================================================
--- linux-2.6.orig/include/asm-i386/mpspec_def.h
+++ linux-2.6/include/asm-i386/mpspec_def.h
@@ -75,8 +75,8 @@ struct mpc_config_bus
 {
 	unsigned char mpc_type;
 	unsigned char mpc_busid;
-	unsigned char mpc_bustype[6] __attribute((packed));
-};
+	unsigned char mpc_bustype[6];
+} __attribute((packed));
 
 /* List of Bus Type string values, Intel MP Spec. */
 #define BUSTYPE_EISA	"EISA"
Index: linux-2.6/include/linux/if_frad.h
===================================================================
--- linux-2.6.orig/include/linux/if_frad.h
+++ linux-2.6/include/linux/if_frad.h
@@ -131,17 +131,17 @@ struct frad_conf 
 /* these are the fields of an RFC 1490 header */
 struct frhdr
 {
-   unsigned char  control	__attribute__((packed));
+   unsigned char  control;
 
    /* for IP packets, this can be the NLPID */
-   unsigned char  pad		__attribute__((packed)); 
+   unsigned char  pad;
 
-   unsigned char  NLPID		__attribute__((packed));
-   unsigned char  OUI[3]	__attribute__((packed));
-   unsigned short PID		__attribute__((packed));
+   unsigned char  NLPID;
+   unsigned char  OUI[3];
+   unsigned short PID;
 
 #define IP_NLPID pad 
-};
+} __attribute__((packed));
 
 /* see RFC 1490 for the definition of the following */
 #define FRAD_I_UI		0x03
Index: linux-2.6/include/linux/isdnif.h
===================================================================
--- linux-2.6.orig/include/linux/isdnif.h
+++ linux-2.6/include/linux/isdnif.h
@@ -282,43 +282,43 @@ typedef struct setup_parm {
 
 typedef struct T30_s {
 	/* session parameters */
-	__u8 resolution		__attribute__ ((packed));
-	__u8 rate		__attribute__ ((packed));
-	__u8 width		__attribute__ ((packed));
-	__u8 length		__attribute__ ((packed));
-	__u8 compression	__attribute__ ((packed));
-	__u8 ecm		__attribute__ ((packed));
-	__u8 binary		__attribute__ ((packed));
-	__u8 scantime		__attribute__ ((packed));
-	__u8 id[FAXIDLEN]	__attribute__ ((packed));
+	__u8 resolution;
+	__u8 rate		;
+	__u8 width		;
+	__u8 length		;
+	__u8 compression	;
+	__u8 ecm		;
+	__u8 binary		;
+	__u8 scantime		;
+	__u8 id[FAXIDLEN]	;
 	/* additional parameters */
-	__u8 phase		__attribute__ ((packed));
-	__u8 direction		__attribute__ ((packed));
-	__u8 code		__attribute__ ((packed));
-	__u8 badlin		__attribute__ ((packed));
-	__u8 badmul		__attribute__ ((packed));
-	__u8 bor		__attribute__ ((packed));
-	__u8 fet		__attribute__ ((packed));
-	__u8 pollid[FAXIDLEN]	__attribute__ ((packed));
-	__u8 cq			__attribute__ ((packed));
-	__u8 cr			__attribute__ ((packed));
-	__u8 ctcrty		__attribute__ ((packed));
-	__u8 minsp		__attribute__ ((packed));
-	__u8 phcto		__attribute__ ((packed));
-	__u8 rel		__attribute__ ((packed));
-	__u8 nbc		__attribute__ ((packed));
+	__u8 phase;
+	__u8 direction;
+	__u8 code;
+	__u8 badlin;
+	__u8 badmul;
+	__u8 bor;
+	__u8 fet;
+	__u8 pollid[FAXIDLEN];
+	__u8 cq;
+	__u8 cr;
+	__u8 ctcrty;
+	__u8 minsp;
+	__u8 phcto;
+	__u8 rel;
+	__u8 nbc;
 	/* remote station parameters */
-	__u8 r_resolution	__attribute__ ((packed));
-	__u8 r_rate		__attribute__ ((packed));
-	__u8 r_width		__attribute__ ((packed));
-	__u8 r_length		__attribute__ ((packed));
-	__u8 r_compression	__attribute__ ((packed));
-	__u8 r_ecm		__attribute__ ((packed));
-	__u8 r_binary		__attribute__ ((packed));
-	__u8 r_scantime		__attribute__ ((packed));
-	__u8 r_id[FAXIDLEN]	__attribute__ ((packed));
-	__u8 r_code		__attribute__ ((packed));
-} T30_s;
+	__u8 r_resolution;
+	__u8 r_rate;
+	__u8 r_width;
+	__u8 r_length;
+	__u8 r_compression;
+	__u8 r_ecm;
+	__u8 r_binary;
+	__u8 r_scantime;
+	__u8 r_id[FAXIDLEN];
+	__u8 r_code;
+} __attribute__((packed)) T30_s;
 
 #define ISDN_TTY_FAX_CONN_IN	0
 #define ISDN_TTY_FAX_CONN_OUT	1
Index: linux-2.6/include/linux/ncp.h
===================================================================
--- linux-2.6.orig/include/linux/ncp.h
+++ linux-2.6/include/linux/ncp.h
@@ -20,29 +20,29 @@
 #define NCP_DEALLOC_SLOT_REQUEST (0x5555)
 
 struct ncp_request_header {
-	__u16 type __attribute__((packed));
-	__u8 sequence __attribute__((packed));
-	__u8 conn_low __attribute__((packed));
-	__u8 task __attribute__((packed));
-	__u8 conn_high __attribute__((packed));
-	__u8 function __attribute__((packed));
-	__u8 data[0] __attribute__((packed));
-};
+	__u16 type;
+	__u8 sequence;
+	__u8 conn_low;
+	__u8 task;
+	__u8 conn_high;
+	__u8 function;
+	__u8 data[0];
+} __attribute__((packed));
 
 #define NCP_REPLY                (0x3333)
 #define NCP_WATCHDOG		 (0x3E3E)
 #define NCP_POSITIVE_ACK         (0x9999)
 
 struct ncp_reply_header {
-	__u16 type __attribute__((packed));
-	__u8 sequence __attribute__((packed));
-	__u8 conn_low __attribute__((packed));
-	__u8 task __attribute__((packed));
-	__u8 conn_high __attribute__((packed));
-	__u8 completion_code __attribute__((packed));
-	__u8 connection_state __attribute__((packed));
-	__u8 data[0] __attribute__((packed));
-};
+	__u16 type;
+	__u8 sequence;
+	__u8 conn_low;
+	__u8 task;
+	__u8 conn_high;
+	__u8 completion_code;
+	__u8 connection_state;
+	__u8 data[0];
+} __attribute__((packed));
 
 #define NCP_VOLNAME_LEN (16)
 #define NCP_NUMBER_OF_VOLUMES (256)
@@ -128,37 +128,37 @@ struct nw_nfs_info {
 };
 
 struct nw_info_struct {
-	__u32 spaceAlloc __attribute__((packed));
-	__le32 attributes __attribute__((packed));
-	__u16 flags __attribute__((packed));
-	__le32 dataStreamSize __attribute__((packed));
-	__le32 totalStreamSize __attribute__((packed));
-	__u16 numberOfStreams __attribute__((packed));
-	__le16 creationTime __attribute__((packed));
-	__le16 creationDate __attribute__((packed));
-	__u32 creatorID __attribute__((packed));
-	__le16 modifyTime __attribute__((packed));
-	__le16 modifyDate __attribute__((packed));
-	__u32 modifierID __attribute__((packed));
-	__le16 lastAccessDate __attribute__((packed));
-	__u16 archiveTime __attribute__((packed));
-	__u16 archiveDate __attribute__((packed));
-	__u32 archiverID __attribute__((packed));
-	__u16 inheritedRightsMask __attribute__((packed));
-	__le32 dirEntNum __attribute__((packed));
-	__le32 DosDirNum __attribute__((packed));
-	__u32 volNumber __attribute__((packed));
-	__u32 EADataSize __attribute__((packed));
-	__u32 EAKeyCount __attribute__((packed));
-	__u32 EAKeySize __attribute__((packed));
-	__u32 NSCreator __attribute__((packed));
-	__u8 nameLen __attribute__((packed));
-	__u8 entryName[256] __attribute__((packed));
+	__u32 spaceAlloc;
+	__le32 attributes;
+	__u16 flags;
+	__le32 dataStreamSize;
+	__le32 totalStreamSize;
+	__u16 numberOfStreams;
+	__le16 creationTime;
+	__le16 creationDate;
+	__u32 creatorID;
+	__le16 modifyTime;
+	__le16 modifyDate;
+	__u32 modifierID;
+	__le16 lastAccessDate;
+	__u16 archiveTime;
+	__u16 archiveDate;
+	__u32 archiverID;
+	__u16 inheritedRightsMask;
+	__le32 dirEntNum;
+	__le32 DosDirNum;
+	__u32 volNumber;
+	__u32 EADataSize;
+	__u32 EAKeyCount;
+	__u32 EAKeySize;
+	__u32 NSCreator;
+	__u8 nameLen;
+	__u8 entryName[256];
 	/* libncp may depend on there being nothing after entryName */
 #ifdef __KERNEL__
 	struct nw_nfs_info nfs;
 #endif
-};
+} __attribute__((packed));
 
 /* modify mask - use with MODIFY_DOS_INFO structure */
 #define DM_ATTRIBUTES		  (cpu_to_le32(0x02))
@@ -176,26 +176,26 @@ struct nw_info_struct {
 #define DM_MAXIMUM_SPACE	  (cpu_to_le32(0x2000))
 
 struct nw_modify_dos_info {
-	__le32 attributes __attribute__((packed));
-	__le16 creationDate __attribute__((packed));
-	__le16 creationTime __attribute__((packed));
-	__u32 creatorID __attribute__((packed));
-	__le16 modifyDate __attribute__((packed));
-	__le16 modifyTime __attribute__((packed));
-	__u32 modifierID __attribute__((packed));
-	__u16 archiveDate __attribute__((packed));
-	__u16 archiveTime __attribute__((packed));
-	__u32 archiverID __attribute__((packed));
-	__le16 lastAccessDate __attribute__((packed));
-	__u16 inheritanceGrantMask __attribute__((packed));
-	__u16 inheritanceRevokeMask __attribute__((packed));
-	__u32 maximumSpace __attribute__((packed));
-};
+	__le32 attributes;
+	__le16 creationDate;
+	__le16 creationTime;
+	__u32 creatorID;
+	__le16 modifyDate;
+	__le16 modifyTime;
+	__u32 modifierID;
+	__u16 archiveDate;
+	__u16 archiveTime;
+	__u32 archiverID;
+	__le16 lastAccessDate;
+	__u16 inheritanceGrantMask;
+	__u16 inheritanceRevokeMask;
+	__u32 maximumSpace;
+} __attribute__((packed));
 
 struct nw_search_sequence {
-	__u8 volNumber __attribute__((packed));
-	__u32 dirBase __attribute__((packed));
-	__u32 sequence __attribute__((packed));
-};
+	__u8 volNumber;
+	__u32 dirBase;
+	__u32 sequence;
+} __attribute__((packed));
 
 #endif				/* _LINUX_NCP_H */
Index: linux-2.6/drivers/isdn/hisax/hisax.h
===================================================================
--- linux-2.6.orig/drivers/isdn/hisax/hisax.h
+++ linux-2.6/drivers/isdn/hisax/hisax.h
@@ -396,17 +396,17 @@ struct isar_hw {
 
 struct hdlc_stat_reg {
 #ifdef __BIG_ENDIAN
-	u_char fill __attribute__((packed));
-	u_char mode __attribute__((packed));
-	u_char xml  __attribute__((packed));
-	u_char cmd  __attribute__((packed));
-#else
-	u_char cmd  __attribute__((packed));
-	u_char xml  __attribute__((packed));
-	u_char mode __attribute__((packed));
-	u_char fill __attribute__((packed));
+	u_char fill;
+	u_char mode;
+	u_char xml;
+	u_char cmd;
+#else
+	u_char cmd;
+	u_char xml;
+	u_char mode;
+	u_char fill;
 #endif
-};
+} __attribute__((packed));
 
 struct hdlc_hw {
 	union {
Index: linux-2.6/drivers/isdn/hisax/hisax_fcpcipnp.h
===================================================================
--- linux-2.6.orig/drivers/isdn/hisax/hisax_fcpcipnp.h
+++ linux-2.6/drivers/isdn/hisax/hisax_fcpcipnp.h
@@ -12,17 +12,17 @@ enum {
 
 struct hdlc_stat_reg {
 #ifdef __BIG_ENDIAN
-	u_char fill __attribute__((packed));
-	u_char mode __attribute__((packed));
-	u_char xml  __attribute__((packed));
-	u_char cmd  __attribute__((packed));
+	u_char fill;
+	u_char mode;
+	u_char xml;
+	u_char cmd;
 #else
-	u_char cmd  __attribute__((packed));
-	u_char xml  __attribute__((packed));
-	u_char mode __attribute__((packed));
-	u_char fill __attribute__((packed));
+	u_char cmd;
+	u_char xml;
+	u_char mode;
+	u_char fill;
 #endif
-};
+} __attribute__((packed));
 
 struct fritz_bcs {
 	struct hisax_b_if b_if;
Index: linux-2.6/drivers/net/3c527.h
===================================================================
--- linux-2.6.orig/drivers/net/3c527.h
+++ linux-2.6/drivers/net/3c527.h
@@ -32,43 +32,43 @@
 
 struct mc32_mailbox
 {
-	u16	mbox __attribute((packed));
-	u16	data[1] __attribute((packed));
-};
+	u16	mbox;
+	u16	data[1];
+} __attribute((packed));
 
 struct skb_header
 {
-	u8	status __attribute((packed));
-	u8	control __attribute((packed));
-	u16	next __attribute((packed));	/* Do not change! */
-	u16	length __attribute((packed));
-	u32	data __attribute((packed));
-};
+	u8	status;
+	u8	control;
+	u16	next;	/* Do not change! */
+	u16	length;
+	u32	data;
+} __attribute((packed));
 
 struct mc32_stats
 {
 	/* RX Errors */
-	u32     rx_crc_errors       __attribute((packed)); 	
-	u32     rx_alignment_errors  __attribute((packed)); 	
-	u32     rx_overrun_errors    __attribute((packed));
-	u32     rx_tooshort_errors  __attribute((packed));
-	u32     rx_toolong_errors   __attribute((packed));
-	u32     rx_outofresource_errors  __attribute((packed)); 
+	u32     rx_crc_errors;
+	u32     rx_alignment_errors;
+	u32     rx_overrun_errors;
+	u32     rx_tooshort_errors;
+	u32     rx_toolong_errors;
+	u32     rx_outofresource_errors;
 
-	u32     rx_discarded   __attribute((packed));  /* via card pattern match filter */ 
+	u32     rx_discarded;  /* via card pattern match filter */
 
 	/* TX Errors */
-	u32     tx_max_collisions __attribute((packed)); 
-	u32     tx_carrier_errors __attribute((packed)); 
-	u32     tx_underrun_errors __attribute((packed)); 
-	u32     tx_cts_errors     __attribute((packed)); 
-	u32     tx_timeout_errors __attribute((packed)) ;
+	u32     tx_max_collisions;
+	u32     tx_carrier_errors;
+	u32     tx_underrun_errors;
+	u32     tx_cts_errors;
+	u32     tx_timeout_errors;
 	
 	/* various cruft */
-	u32     dataA[6] __attribute((packed));   
-        u16	dataB[5] __attribute((packed));   
-  	u32     dataC[14] __attribute((packed)); 	
-};
+	u32     dataA[6];
+        u16	dataB[5];
+  	u32     dataC[14];
+} __attribute((packed));
 
 #define STATUS_MASK	0x0F
 #define COMPLETED	(1<<7)
Index: linux-2.6/drivers/net/irda/vlsi_ir.h
===================================================================
--- linux-2.6.orig/drivers/net/irda/vlsi_ir.h
+++ linux-2.6/drivers/net/irda/vlsi_ir.h
@@ -577,8 +577,8 @@ struct ring_descr_hw {
 		struct {
 			u8		addr_res[3];
 			volatile u8	status;		/* descriptor status */
-		} rd_s __attribute__((packed));
-	} rd_u __attribute((packed));
+		} __attribute__((packed)) rd_s;
+	} __attribute((packed)) rd_u;
 } __attribute__ ((packed));
 
 #define rd_addr		rd_u.addr
Index: linux-2.6/include/linux/atalk.h
===================================================================
--- linux-2.6.orig/include/linux/atalk.h
+++ linux-2.6/include/linux/atalk.h
@@ -155,15 +155,15 @@ struct elapaarp {
 #define AARP_REQUEST			1
 #define AARP_REPLY			2
 #define AARP_PROBE			3
-	__u8	hw_src[ETH_ALEN]	__attribute__ ((packed));
-	__u8	pa_src_zero		__attribute__ ((packed));
-	__be16	pa_src_net		__attribute__ ((packed));
-	__u8	pa_src_node		__attribute__ ((packed));
-	__u8	hw_dst[ETH_ALEN]	__attribute__ ((packed));
-	__u8	pa_dst_zero		__attribute__ ((packed));
-	__be16	pa_dst_net		__attribute__ ((packed));
-	__u8	pa_dst_node		__attribute__ ((packed));	
-};
+	__u8	hw_src[ETH_ALEN];
+	__u8	pa_src_zero;
+	__be16	pa_src_net;
+	__u8	pa_src_node;
+	__u8	hw_dst[ETH_ALEN];
+	__u8	pa_dst_zero;
+	__be16	pa_dst_net;
+	__u8	pa_dst_node;
+} __attribute__ ((packed));
 
 static __inline__ struct elapaarp *aarp_hdr(struct sk_buff *skb)
 {
Index: linux-2.6/include/linux/cycx_x25.h
===================================================================
--- linux-2.6.orig/include/linux/cycx_x25.h
+++ linux-2.6/include/linux/cycx_x25.h
@@ -38,11 +38,11 @@ extern unsigned int cycx_debug;
 /* Data Structures */
 /* X.25 Command Block. */
 struct cycx_x25_cmd {
-	u16 command PACKED;
-	u16 link    PACKED; /* values: 0 or 1 */
-	u16 len     PACKED; /* values: 0 thru 0x205 (517) */
-	u32 buf     PACKED;
-};
+	u16 command;
+	u16 link;	/* values: 0 or 1 */
+	u16 len;	/* values: 0 thru 0x205 (517) */
+	u32 buf;
+} PACKED;
 
 /* Defines for the 'command' field. */
 #define X25_CONNECT_REQUEST             0x4401
@@ -92,34 +92,34 @@ struct cycx_x25_cmd {
  *	@flags - see dosx25.doc, in portuguese, for details
  */
 struct cycx_x25_config {
-	u8  link	PACKED;
-	u8  speed	PACKED;
-	u8  clock	PACKED;
-	u8  n2		PACKED;
-	u8  n2win	PACKED;
-	u8  n3win	PACKED;
-	u8  nvc		PACKED;
-	u8  pktlen	PACKED;
-	u8  locaddr	PACKED;
-	u8  remaddr	PACKED;
-	u16 t1		PACKED;
-	u16 t2		PACKED;
-	u8  t21		PACKED;
-	u8  npvc	PACKED;
-	u8  t23		PACKED;
-	u8  flags	PACKED;
-};
+	u8  link;
+	u8  speed;
+	u8  clock;
+	u8  n2;
+	u8  n2win;
+	u8  n3win;
+	u8  nvc;
+	u8  pktlen;
+	u8  locaddr;
+	u8  remaddr;
+	u16 t1;
+	u16 t2;
+	u8  t21;
+	u8  npvc;
+	u8  t23;
+	u8  flags;
+} PACKED;
 
 struct cycx_x25_stats {
-	u16 rx_crc_errors	PACKED;
-	u16 rx_over_errors	PACKED;
-	u16 n2_tx_frames 	PACKED;
-	u16 n2_rx_frames 	PACKED;
-	u16 tx_timeouts 	PACKED;
-	u16 rx_timeouts 	PACKED;
-	u16 n3_tx_packets 	PACKED;
-	u16 n3_rx_packets 	PACKED;
-	u16 tx_aborts	 	PACKED;
-	u16 rx_aborts	 	PACKED;
-};
+	u16 rx_crc_errors;
+	u16 rx_over_errors;
+	u16 n2_tx_frames;
+	u16 n2_rx_frames;
+	u16 tx_timeouts;
+	u16 rx_timeouts;
+	u16 n3_tx_packets;
+	u16 n3_rx_packets;
+	u16 tx_aborts;
+	u16 rx_aborts;
+} PACKED;
 #endif	/* _CYCX_X25_H */
Index: linux-2.6/include/linux/sdla.h
===================================================================
--- linux-2.6.orig/include/linux/sdla.h
+++ linux-2.6/include/linux/sdla.h
@@ -293,46 +293,46 @@ void sdla(void *cfg_info, char *dev, str
 #define SDLA_S508_INTEN			0x10
 
 struct sdla_cmd {
-   char  opp_flag		__attribute__((packed));
-   char  cmd			__attribute__((packed));
-   short length			__attribute__((packed));
-   char  retval			__attribute__((packed));
-   short dlci			__attribute__((packed));
-   char  flags			__attribute__((packed));
-   short rxlost_int		__attribute__((packed));
-   long  rxlost_app		__attribute__((packed));
-   char  reserve[2]		__attribute__((packed));
-   char  data[SDLA_MAX_DATA]	__attribute__((packed));	/* transfer data buffer */
-};
+   char  opp_flag;
+   char  cmd;
+   short length;
+   char  retval;
+   short dlci;
+   char  flags;
+   short rxlost_int;
+   long  rxlost_app;
+   char  reserve[2];
+   char  data[SDLA_MAX_DATA];	/* transfer data buffer */
+} __attribute__((packed));
 
 struct intr_info {
-   char  flags		__attribute__((packed));
-   short txlen		__attribute__((packed));
-   char  irq		__attribute__((packed));
-   char  flags2		__attribute__((packed));
-   short timeout	__attribute__((packed));
-};
+   char  flags;
+   short txlen;
+   char  irq;
+   char  flags2;
+   short timeout;
+} __attribute__((packed));
 
 /* found in the 508's control window at RXBUF_INFO */
 struct buf_info {
-   unsigned short rse_num	__attribute__((packed));
-   unsigned long  rse_base	__attribute__((packed));
-   unsigned long  rse_next	__attribute__((packed));
-   unsigned long  buf_base	__attribute__((packed));
-   unsigned short reserved	__attribute__((packed));
-   unsigned long  buf_top	__attribute__((packed));
-};
+   unsigned short rse_num;
+   unsigned long  rse_base;
+   unsigned long  rse_next;
+   unsigned long  buf_base;
+   unsigned short reserved;
+   unsigned long  buf_top;
+} __attribute__((packed));
 
 /* structure pointed to by rse_base in RXBUF_INFO struct */
 struct buf_entry {
-   char  opp_flag	__attribute__((packed));
-   short length		__attribute__((packed));
-   short dlci		__attribute__((packed));
-   char  flags		__attribute__((packed));
-   short timestamp	__attribute__((packed));
-   short reserved[2]	__attribute__((packed));
-   long  buf_addr	__attribute__((packed));
-};
+   char  opp_flag;
+   short length;
+   short dlci;
+   char  flags;
+   short timestamp;
+   short reserved[2];
+   long  buf_addr;
+} __attribute__((packed));
 
 #endif
 
Index: linux-2.6/include/linux/wavefront.h
===================================================================
--- linux-2.6.orig/include/linux/wavefront.h
+++ linux-2.6/include/linux/wavefront.h
@@ -434,22 +434,22 @@ typedef struct wf_multisample {
 } wavefront_multisample;
 
 typedef struct wf_alias {
-    INT16 OriginalSample __attribute__ ((packed));
+    INT16 OriginalSample;
 
-    struct wf_sample_offset sampleStartOffset __attribute__ ((packed));
-    struct wf_sample_offset loopStartOffset __attribute__ ((packed));
-    struct wf_sample_offset sampleEndOffset __attribute__ ((packed));
-    struct wf_sample_offset loopEndOffset __attribute__ ((packed));
-
-    INT16  FrequencyBias __attribute__ ((packed));
-
-    UCHAR8 SampleResolution:2  __attribute__ ((packed));
-    UCHAR8 Unused1:1  __attribute__ ((packed));
-    UCHAR8 Loop:1 __attribute__ ((packed));
-    UCHAR8 Bidirectional:1  __attribute__ ((packed));
-    UCHAR8 Unused2:1 __attribute__ ((packed));
-    UCHAR8 Reverse:1 __attribute__ ((packed));
-    UCHAR8 Unused3:1 __attribute__ ((packed)); 
+    struct wf_sample_offset sampleStartOffset;
+    struct wf_sample_offset loopStartOffset;
+    struct wf_sample_offset sampleEndOffset;
+    struct wf_sample_offset loopEndOffset;
+
+    INT16  FrequencyBias;
+
+    UCHAR8 SampleResolution:2;
+    UCHAR8 Unused1:1;
+    UCHAR8 Loop:1;
+    UCHAR8 Bidirectional:1;
+    UCHAR8 Unused2:1;
+    UCHAR8 Reverse:1;
+    UCHAR8 Unused3:1;
     
     /* This structure is meant to be padded only to 16 bits on their
        original. Of course, whoever wrote their documentation didn't
@@ -460,8 +460,8 @@ typedef struct wf_alias {
        standard 16->32 bit issues.
     */
 
-    UCHAR8 sixteen_bit_padding __attribute__ ((packed));
-} wavefront_alias;
+    UCHAR8 sixteen_bit_padding;
+} __attribute__((packed)) wavefront_alias;
 
 typedef struct wf_drum {
     UCHAR8 PatchNumber;
Index: linux-2.6/include/net/dn_dev.h
===================================================================
--- linux-2.6.orig/include/net/dn_dev.h
+++ linux-2.6/include/net/dn_dev.h
@@ -99,57 +99,57 @@ struct dn_dev {
 
 struct dn_short_packet
 {
-	unsigned char   msgflg          __attribute__((packed));
-        unsigned short  dstnode         __attribute__((packed));
-        unsigned short  srcnode         __attribute__((packed));
-        unsigned char   forward         __attribute__((packed));
-};
+	unsigned char   msgflg;
+        unsigned short  dstnode;
+        unsigned short  srcnode;
+        unsigned char   forward;
+} __attribute__((packed));
 
 struct dn_long_packet
 {
-	unsigned char   msgflg          __attribute__((packed));
-        unsigned char   d_area          __attribute__((packed));
-        unsigned char   d_subarea       __attribute__((packed));
-        unsigned char   d_id[6]         __attribute__((packed));
-        unsigned char   s_area          __attribute__((packed));
-        unsigned char   s_subarea       __attribute__((packed));
-        unsigned char   s_id[6]         __attribute__((packed));
-        unsigned char   nl2             __attribute__((packed));
-        unsigned char   visit_ct        __attribute__((packed));
-        unsigned char   s_class         __attribute__((packed));
-        unsigned char   pt              __attribute__((packed));
-};
+	unsigned char   msgflg;
+        unsigned char   d_area;
+        unsigned char   d_subarea;
+        unsigned char   d_id[6];
+        unsigned char   s_area;
+        unsigned char   s_subarea;
+        unsigned char   s_id[6];
+        unsigned char   nl2;
+        unsigned char   visit_ct;
+        unsigned char   s_class;
+        unsigned char   pt;
+} __attribute__((packed));
 
 /*------------------------- DRP - Routing messages ---------------------*/
 
 struct endnode_hello_message
 {
-	unsigned char   msgflg          __attribute__((packed));
-        unsigned char   tiver[3]        __attribute__((packed));
-        unsigned char   id[6]           __attribute__((packed));
-        unsigned char   iinfo           __attribute__((packed));
-        unsigned short  blksize         __attribute__((packed));
-        unsigned char   area            __attribute__((packed));
-        unsigned char   seed[8]         __attribute__((packed));
-        unsigned char   neighbor[6]     __attribute__((packed));
-        unsigned short  timer           __attribute__((packed));
-        unsigned char   mpd             __attribute__((packed));
-        unsigned char   datalen         __attribute__((packed));
-        unsigned char   data[2]         __attribute__((packed));
-};
+	unsigned char   msgflg;
+        unsigned char   tiver[3];
+        unsigned char   id[6];
+        unsigned char   iinfo;
+        unsigned short  blksize;
+        unsigned char   area;
+        unsigned char   seed[8];
+        unsigned char   neighbor[6];
+        unsigned short  timer;
+        unsigned char   mpd;
+        unsigned char   datalen;
+        unsigned char   data[2];
+} __attribute__((packed));
 
 struct rtnode_hello_message
 {
-	unsigned char   msgflg          __attribute__((packed));
-        unsigned char   tiver[3]        __attribute__((packed));
-        unsigned char   id[6]           __attribute__((packed));
-        unsigned char   iinfo           __attribute__((packed));
-        unsigned short  blksize         __attribute__((packed));
-        unsigned char   priority        __attribute__((packed));
-        unsigned char   area            __attribute__((packed));
-        unsigned short  timer           __attribute__((packed));
-        unsigned char   mpd             __attribute__((packed));
-};
+	unsigned char   msgflg;
+        unsigned char   tiver[3];
+        unsigned char   id[6];
+        unsigned char   iinfo;
+        unsigned short  blksize;
+        unsigned char   priority;
+        unsigned char   area;
+        unsigned short  timer;
+        unsigned char   mpd;
+} __attribute__((packed));
 
 
 extern void dn_dev_init(void);
Index: linux-2.6/drivers/net/wan/sdla.c
===================================================================
--- linux-2.6.orig/drivers/net/wan/sdla.c
+++ linux-2.6/drivers/net/wan/sdla.c
@@ -329,9 +329,9 @@ static int sdla_cpuspeed(struct net_devi
 
 struct _dlci_stat 
 {
-	short dlci		__attribute__((packed));
-	char  flags		__attribute__((packed));
-};
+	short dlci;
+	char  flags;
+} __attribute__((packed));
 
 struct _frad_stat 
 {
Index: linux-2.6/include/net/dn_nsp.h
===================================================================
--- linux-2.6.orig/include/net/dn_nsp.h
+++ linux-2.6/include/net/dn_nsp.h
@@ -72,78 +72,78 @@ extern struct sk_buff *dn_alloc_send_skb
 
 struct nsp_data_seg_msg
 {
-	unsigned char   msgflg          __attribute__((packed));
-	unsigned short  dstaddr         __attribute__((packed));
-	unsigned short  srcaddr         __attribute__((packed));
-};
+	unsigned char   msgflg;
+	unsigned short  dstaddr;
+	unsigned short  srcaddr;
+} __attribute__((packed));
 
 struct nsp_data_opt_msg
 {
-	unsigned short  acknum          __attribute__((packed));
-	unsigned short  segnum          __attribute__((packed));
-	unsigned short  lsflgs          __attribute__((packed));
-};
+	unsigned short  acknum;
+	unsigned short  segnum;
+	unsigned short  lsflgs;
+} __attribute__((packed));
 
 struct nsp_data_opt_msg1
 {
-	unsigned short  acknum          __attribute__((packed));
-	unsigned short  segnum          __attribute__((packed));
-};
+	unsigned short  acknum;
+	unsigned short  segnum;
+} __attribute__((packed));
 
 
 /* Acknowledgment Message (data/other data)                             */
 struct nsp_data_ack_msg
 {
-	unsigned char   msgflg          __attribute__((packed));
-	unsigned short  dstaddr         __attribute__((packed));
-	unsigned short  srcaddr         __attribute__((packed));
-	unsigned short  acknum          __attribute__((packed));
-};
+	unsigned char   msgflg;
+	unsigned short  dstaddr;
+	unsigned short  srcaddr;
+	unsigned short  acknum;
+} __attribute__((packed));
 
 /* Connect Acknowledgment Message */
 struct  nsp_conn_ack_msg
 {
-	unsigned char   msgflg          __attribute__((packed));
-	unsigned short  dstaddr         __attribute__((packed));
-};
+	unsigned char   msgflg;
+	unsigned short  dstaddr;
+} __attribute__((packed));
 
 
 /* Connect Initiate/Retransmit Initiate/Connect Confirm */
 struct  nsp_conn_init_msg
 {
-	unsigned char   msgflg          __attribute__((packed));
+	unsigned char   msgflg;
 #define NSP_CI      0x18            /* Connect Initiate     */
 #define NSP_RCI     0x68            /* Retrans. Conn Init   */
-	unsigned short  dstaddr         __attribute__((packed));
-        unsigned short  srcaddr         __attribute__((packed));
-        unsigned char   services        __attribute__((packed));
+	unsigned short  dstaddr;
+        unsigned short  srcaddr;
+        unsigned char   services;
 #define NSP_FC_NONE   0x00            /* Flow Control None    */
 #define NSP_FC_SRC    0x04            /* Seg Req. Count       */
 #define NSP_FC_SCMC   0x08            /* Sess. Control Mess   */
 #define NSP_FC_MASK   0x0c            /* FC type mask         */
-	unsigned char   info            __attribute__((packed));
-        unsigned short  segsize         __attribute__((packed));
-};
+	unsigned char   info;
+        unsigned short  segsize;
+} __attribute__((packed));
 
 /* Disconnect Initiate/Disconnect Confirm */
 struct  nsp_disconn_init_msg
 {
-	unsigned char   msgflg          __attribute__((packed));
-        unsigned short  dstaddr         __attribute__((packed));
-        unsigned short  srcaddr         __attribute__((packed));
-        unsigned short  reason          __attribute__((packed));
-};
+	unsigned char   msgflg;
+        unsigned short  dstaddr;
+        unsigned short  srcaddr;
+        unsigned short  reason;
+} __attribute__((packed));
 
 
 
 struct  srcobj_fmt
 {
-	char            format          __attribute__((packed));
-        unsigned char   task            __attribute__((packed));
-        unsigned short  grpcode         __attribute__((packed));
-        unsigned short  usrcode         __attribute__((packed));
-        char            dlen            __attribute__((packed));
-};
+	char            format;
+        unsigned char   task;
+        unsigned short  grpcode;
+        unsigned short  usrcode;
+        char            dlen;
+} __attribute__((packed));
 
 /*
  * A collection of functions for manipulating the sequence
Index: linux-2.6/include/sound/wavefront.h
===================================================================
--- linux-2.6.orig/include/sound/wavefront.h
+++ linux-2.6/include/sound/wavefront.h
@@ -454,22 +454,22 @@ typedef struct wf_multisample {
 } wavefront_multisample;
 
 typedef struct wf_alias {
-    s16 OriginalSample __attribute__ ((packed));
+    s16 OriginalSample;
 
-    struct wf_sample_offset sampleStartOffset __attribute__ ((packed));
-    struct wf_sample_offset loopStartOffset __attribute__ ((packed));
-    struct wf_sample_offset sampleEndOffset __attribute__ ((packed));
-    struct wf_sample_offset loopEndOffset __attribute__ ((packed));
-
-    s16  FrequencyBias __attribute__ ((packed));
-
-    u8 SampleResolution:2  __attribute__ ((packed));
-    u8 Unused1:1  __attribute__ ((packed));
-    u8 Loop:1 __attribute__ ((packed));
-    u8 Bidirectional:1  __attribute__ ((packed));
-    u8 Unused2:1 __attribute__ ((packed));
-    u8 Reverse:1 __attribute__ ((packed));
-    u8 Unused3:1 __attribute__ ((packed)); 
+    struct wf_sample_offset sampleStartOffset;
+    struct wf_sample_offset loopStartOffset;
+    struct wf_sample_offset sampleEndOffset;
+    struct wf_sample_offset loopEndOffset;
+
+    s16  FrequencyBias;
+
+    u8 SampleResolution:2;
+    u8 Unused1:1;
+    u8 Loop:1;
+    u8 Bidirectional:1;
+    u8 Unused2:1;
+    u8 Reverse:1;
+    u8 Unused3:1;
     
     /* This structure is meant to be padded only to 16 bits on their
        original. Of course, whoever wrote their documentation didn't
@@ -480,8 +480,8 @@ typedef struct wf_alias {
        standard 16->32 bit issues.
     */
 
-    u8 sixteen_bit_padding __attribute__ ((packed));
-} wavefront_alias;
+    u8 sixteen_bit_padding;
+} __attribute__((packed)) wavefront_alias;
 
 typedef struct wf_drum {
     u8 PatchNumber;

--8JPrznbw0YAQ/KXy--
