Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVDRPMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVDRPMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVDRPMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:12:12 -0400
Received: from gsecone.com ([59.144.0.4]:53893 "EHLO gsecone.com")
	by vger.kernel.org with ESMTP id S262096AbVDRPKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:10:34 -0400
Subject: [PATHC][2.4.30] __attribute__ placement
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Global Security One
Date: Mon, 18 Apr 2005 20:37:25 +0530
Message-Id: <1113836845.4217.10.camel@vinay.gsecone.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The variable attributes "packed" and "align" when used with structure
should have the following order:

struct ... {...} __attribute__((packed)) var;

This patch fixes few instances where the variable and attributes are
placed the other way around and had no affect.

Thanks
Vinay 

 arch/ppc/math-emu/double.h     |    4 ++--
 arch/ppc/math-emu/single.h     |    2 +-
 arch/s390x/kernel/ptrace.c     |    8 ++++----
 arch/x86_64/kernel/acpitable.h |    2 +-
 drivers/net/gt96100eth.h       |    4 ++--
 drivers/s390/char/tape3480.h   |    2 +-
 drivers/s390/net/qeth.h        |    4 ++--
 drivers/s390/net/qeth_mpc.h    |    6 +++---
 include/math-emu/double.h      |    4 ++--
 include/math-emu/extended.h    |    2 +-
 include/math-emu/quad.h        |    2 +-
 include/math-emu/single.h      |    2 +-
 12 files changed, 21 insertions(+), 21 deletions(-)
=========================================================================
diff -urN linux-2.4.30/arch/ppc/math-emu/double.h linux-2.4.30-nvk/arch/ppc/math-emu/double.h
--- linux-2.4.30/arch/ppc/math-emu/double.h	2003-06-14 10:09:53.000000000 +0530
+++ linux-2.4.30-nvk/arch/ppc/math-emu/double.h	2005-04-18 19:34:55.000000000 +0530
@@ -44,7 +44,7 @@
     unsigned exp   : _FP_EXPBITS_D;
     unsigned sign  : 1;
 #endif
-  } bits __attribute__((packed));
+  } __attribute__((packed)) bits;
 };
 
 #define FP_DECL_D(X)		_FP_DECL(2,X)
@@ -91,7 +91,7 @@
     unsigned exp  : _FP_EXPBITS_D;
     unsigned sign : 1;
 #endif
-  } bits __attribute__((packed));
+  } __attribute__((packed)) bits;
 };
 
 #define FP_DECL_D(X)		_FP_DECL(1,X)
diff -urN linux-2.4.30/arch/ppc/math-emu/single.h linux-2.4.30-nvk/arch/ppc/math-emu/single.h
--- linux-2.4.30/arch/ppc/math-emu/single.h	2003-06-14 10:09:55.000000000 +0530
+++ linux-2.4.30-nvk/arch/ppc/math-emu/single.h	2005-04-18 19:35:16.000000000 +0530
@@ -33,7 +33,7 @@
     unsigned exp  : _FP_EXPBITS_S;
     unsigned sign : 1;
 #endif
-  } bits __attribute__((packed));
+  } __attribute__((packed)) bits;
 };
 
 #define FP_DECL_S(X)		_FP_DECL(1,X)
diff -urN linux-2.4.30/arch/s390x/kernel/ptrace.c linux-2.4.30-nvk/arch/s390x/kernel/ptrace.c
--- linux-2.4.30/arch/s390x/kernel/ptrace.c	2003-06-14 10:05:28.000000000 +0530
+++ linux-2.4.30-nvk/arch/s390x/kernel/ptrace.c	2005-04-18 19:37:25.000000000 +0530
@@ -146,20 +146,20 @@
 typedef struct
 {
 	__u32 cr[3];
-} per_cr_words32  __attribute__((packed));
+} __attribute__((packed)) per_cr_words32;
 
 typedef struct
 {
 	__u16          perc_atmid;          /* 0x096 */
 	__u32          address;             /* 0x098 */
 	__u8           access_id;           /* 0x0a1 */
-} per_lowcore_words32  __attribute__((packed));
+} __attribute__((packed)) per_lowcore_words32;
 
 typedef struct
 {
 	union {
 		per_cr_words32   words;
-	} control_regs  __attribute__((packed));
+	} __attribute__((packed)) control_regs;
 	/*
 	 * Use these flags instead of setting em_instruction_fetch
 	 * directly they are used so that single stepping can be
@@ -177,7 +177,7 @@
 	union {
 		per_lowcore_words32 words;
 	} lowcore; 
-} per_struct32 __attribute__((packed));
+} __attribute__((packed)) per_struct32;
 
 struct user_regs_struct32
 {
diff -urN linux-2.4.30/arch/x86_64/kernel/acpitable.h linux-2.4.30-nvk/arch/x86_64/kernel/acpitable.h
--- linux-2.4.30/arch/x86_64/kernel/acpitable.h	2003-06-14 10:05:28.000000000 +0530
+++ linux-2.4.30-nvk/arch/x86_64/kernel/acpitable.h	2005-04-18 19:38:28.000000000 +0530
@@ -118,7 +118,7 @@
 	struct {
 		u32 enabled:1;
 		u32 reserved:31;
-	} flags __attribute__ ((packed));
+	} __attribute__ ((packed)) flags;
 } __attribute__ ((packed));
 
 struct acpi_table_ioapic {
diff -urN linux-2.4.30/drivers/net/gt96100eth.h linux-2.4.30-nvk/drivers/net/gt96100eth.h
--- linux-2.4.30/drivers/net/gt96100eth.h	2003-06-14 10:03:16.000000000 +0530
+++ linux-2.4.30-nvk/drivers/net/gt96100eth.h	2005-04-18 19:44:30.000000000 +0530
@@ -214,7 +214,7 @@
 	u32 cmdstat;
 	u32 next;
 	u32 buff_ptr;
-} gt96100_td_t __attribute__ ((packed));
+} __attribute__ ((packed)) gt96100_td_t;
 
 typedef struct {
 #ifdef DESC_BE
@@ -227,7 +227,7 @@
 	u32 cmdstat;
 	u32 next;
 	u32 buff_ptr;
-} gt96100_rd_t __attribute__ ((packed));
+} __attribute__ ((packed)) gt96100_rd_t;
 
 
 /* Values for the Tx command-status descriptor entry. */
diff -urN linux-2.4.30/drivers/s390/char/tape3480.h linux-2.4.30-nvk/drivers/s390/char/tape3480.h
--- linux-2.4.30/drivers/s390/char/tape3480.h	2003-06-14 10:04:18.000000000 +0530
+++ linux-2.4.30-nvk/drivers/s390/char/tape3480.h	2005-04-18 19:39:22.000000000 +0530
@@ -18,6 +18,6 @@
 
 typedef struct _tape3480_disc_data_t {
     __u8 modeset_byte;
-} tape3480_disc_data_t  __attribute__ ((packed, aligned(8)));
+} __attribute__ ((packed, aligned(8))) tape3480_disc_data_t;
 tape_discipline_t * tape3480_init (int);
 #endif // _TAPE3480_H
diff -urN linux-2.4.30/drivers/s390/net/qeth.h linux-2.4.30-nvk/drivers/s390/net/qeth.h
--- linux-2.4.30/drivers/s390/net/qeth.h	2004-12-04 17:45:26.000000000 +0530
+++ linux-2.4.30-nvk/drivers/s390/net/qeth.h	2005-04-18 19:42:01.000000000 +0530
@@ -760,14 +760,14 @@
 typedef struct qeth_ringbuffer_t {
 	qdio_buffer_t buffer[QDIO_MAX_BUFFERS_PER_Q];
 	qeth_ringbuffer_element_t ringbuf_element[QDIO_MAX_BUFFERS_PER_Q];
-} qeth_ringbuffer_t __attribute__ ((packed,aligned(PAGE_SIZE)));
+} __attribute__ ((packed,aligned(PAGE_SIZE))) qeth_ringbuffer_t;
 
 typedef struct qeth_dma_stuff_t {
 	unsigned char *sendbuf;
 	unsigned char *recbuf;
 	ccw1_t read_ccw;
 	ccw1_t write_ccw;
-} qeth_dma_stuff_t __attribute__ ((packed,aligned(PAGE_SIZE)));
+} __attribute__ ((packed,aligned(PAGE_SIZE))) qeth_dma_stuff_t;
 
 typedef struct qeth_perf_stats_t {
 	unsigned int skbs_rec;
diff -urN linux-2.4.30/drivers/s390/net/qeth_mpc.h linux-2.4.30-nvk/drivers/s390/net/qeth_mpc.h
--- linux-2.4.30/drivers/s390/net/qeth_mpc.h	2004-12-04 17:45:26.000000000 +0530
+++ linux-2.4.30-nvk/drivers/s390/net/qeth_mpc.h	2005-04-18 19:43:20.000000000 +0530
@@ -460,7 +460,7 @@
 			__u8 unique_id[8];
 		} create_destroy_addr;
 	} data;
-} ipa_cmd_t __attribute__ ((packed));
+} __attribute__ ((packed)) ipa_cmd_t;
 
 #define QETH_IOC_MAGIC 0x22
 #define QETH_IOCPROC_REGISTER _IOWR(QETH_IOC_MAGIC, 1, int)
@@ -506,7 +506,7 @@
 			__u8 snmp_data[ARP_DATA_SIZE];
 		} snmp_subcommand;
 	} data;
-} snmp_ipa_setadp_cmd_t __attribute__ ((packed));
+} __attribute__ ((packed)) snmp_ipa_setadp_cmd_t;
 
 typedef struct arp_cmd_t {
 	__u8 command;
@@ -539,7 +539,7 @@
 		} setassparms;
                 snmp_ipa_setadp_cmd_t setadapterparms; 
 	} data;
-} arp_cmd_t __attribute__ ((packed));
+} __attribute__ ((packed)) arp_cmd_t;
 
 
 
diff -urN linux-2.4.30/include/math-emu/double.h linux-2.4.30-nvk/include/math-emu/double.h
--- linux-2.4.30/include/math-emu/double.h	2003-06-14 10:03:05.000000000 +0530
+++ linux-2.4.30-nvk/include/math-emu/double.h	2005-04-18 19:31:20.000000000 +0530
@@ -67,7 +67,7 @@
     unsigned exp   : _FP_EXPBITS_D;
     unsigned sign  : 1;
 #endif
-  } bits __attribute__((packed));
+  } __attribute__((packed)) bits;
 };
 
 #define FP_DECL_D(X)		_FP_DECL(2,X)
@@ -139,7 +139,7 @@
     unsigned exp  : _FP_EXPBITS_D;
     unsigned sign : 1;
 #endif
-  } bits __attribute__((packed));
+  } __attribute__((packed)) bits;
 };
 
 #define FP_DECL_D(X)		_FP_DECL(1,X)
diff -urN linux-2.4.30/include/math-emu/extended.h linux-2.4.30-nvk/include/math-emu/extended.h
--- linux-2.4.30/include/math-emu/extended.h	2003-06-14 10:03:05.000000000 +0530
+++ linux-2.4.30-nvk/include/math-emu/extended.h	2005-04-18 19:30:32.000000000 +0530
@@ -68,7 +68,7 @@
       unsigned exp : _FP_EXPBITS_E;
       unsigned sign : 1;
 #endif /* not bigendian */
-   } bits __attribute__((packed));
+   } __attribute__((packed)) bits;
 };
 
 
diff -urN linux-2.4.30/include/math-emu/quad.h linux-2.4.30-nvk/include/math-emu/quad.h
--- linux-2.4.30/include/math-emu/quad.h	2003-06-14 10:03:05.000000000 +0530
+++ linux-2.4.30-nvk/include/math-emu/quad.h	2005-04-18 19:30:02.000000000 +0530
@@ -72,7 +72,7 @@
       unsigned exp : _FP_EXPBITS_Q;
       unsigned sign : 1;
 #endif /* not bigendian */
-   } bits __attribute__((packed));
+   } __attribute__((packed)) bits;
 };
 
 
diff -urN linux-2.4.30/include/math-emu/single.h linux-2.4.30-nvk/include/math-emu/single.h
--- linux-2.4.30/include/math-emu/single.h	2003-06-14 10:03:05.000000000 +0530
+++ linux-2.4.30-nvk/include/math-emu/single.h	2005-04-18 19:31:51.000000000 +0530
@@ -56,7 +56,7 @@
     unsigned exp  : _FP_EXPBITS_S;
     unsigned sign : 1;
 #endif
-  } bits __attribute__((packed));
+  } __attribute__((packed)) bits;
 };
 
 #define FP_DECL_S(X)		_FP_DECL(1,X)

=========================================================================

-- 
Views expressed in this mail are those of the individual sender and 
do not bind Gsec1 Limited. or its subsidiary, unless the sender has done
so expressly with due authority of Gsec1.
_________________________________________________________________________


