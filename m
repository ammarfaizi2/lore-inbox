Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVDTK4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVDTK4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 06:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVDTK4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 06:56:44 -0400
Received: from gsecone.com ([59.144.0.4]:34951 "EHLO gsecone.com")
	by vger.kernel.org with ESMTP id S261426AbVDTK4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 06:56:36 -0400
Subject: Re: [PATCH][2.4.30] __attribute__ placement
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: marcelo.tosatti@cyclades.com
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1113836845.4217.10.camel@vinay.gsecone.com>
References: <1113836845.4217.10.camel@vinay.gsecone.com>
Content-Type: text/plain
Organization: Global Security One
Date: Wed, 20 Apr 2005 16:23:48 +0530
Message-Id: <1113994428.10792.39.camel@vinay.gsecone.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Realised few things are not ok with my earlier patch. The __attribute__
((packed)) problem exists only with typedefed structs. The correct
syntax is

typedef struct ... { .... } __attribute__((packed)) newtype;

Please find the updated patch. Hope I got it right this time.

Thanks
Vinay

 arch/s390x/kernel/ptrace.c  |    6 +++---
 drivers/net/gt96100eth.h    |    4 ++--
 drivers/s390/net/qeth.h     |    4 ++--
 drivers/s390/net/qeth_mpc.h |    6 +++---
 4 files changed, 10 insertions(+), 10 deletions(-)

==============================================================================
diff -urN linux-2.4.30/arch/s390x/kernel/ptrace.c linux-2.4.30-nvk/arch/s390x/kernel/ptrace.c
--- linux-2.4.30/arch/s390x/kernel/ptrace.c	2003-06-14 10:05:28.000000000 +0530
+++ linux-2.4.30-nvk/arch/s390x/kernel/ptrace.c	2005-04-20 15:29:35.000000000 +0530
@@ -146,14 +146,14 @@
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
@@ -177,7 +177,7 @@
 	union {
 		per_lowcore_words32 words;
 	} lowcore; 
-} per_struct32 __attribute__((packed));
+} __attribute__((packed)) per_struct32;
 
 struct user_regs_struct32
 {
diff -urN linux-2.4.30/drivers/net/gt96100eth.h linux-2.4.30-nvk/drivers/net/gt96100eth.h
--- linux-2.4.30/drivers/net/gt96100eth.h	2003-06-14 10:03:16.000000000 +0530
+++ linux-2.4.30-nvk/drivers/net/gt96100eth.h	2005-04-20 15:34:14.000000000 +0530
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
diff -urN linux-2.4.30/drivers/s390/net/qeth.h linux-2.4.30-nvk/drivers/s390/net/qeth.h
--- linux-2.4.30/drivers/s390/net/qeth.h	2004-12-04 17:45:26.000000000 +0530
+++ linux-2.4.30-nvk/drivers/s390/net/qeth.h	2005-04-20 15:31:52.000000000 +0530
@@ -760,14 +760,14 @@
 typedef struct qeth_ringbuffer_t {
 	qdio_buffer_t buffer[QDIO_MAX_BUFFERS_PER_Q];
 	qeth_ringbuffer_element_t ringbuf_element[QDIO_MAX_BUFFERS_PER_Q];
-} qeth_ringbuffer_t __attribute__ ((packed,aligned(PAGE_SIZE)));
+} __attribute__((packed)) qeth_ringbuffer_t __attribute__ ((aligned(PAGE_SIZE)));
 
 typedef struct qeth_dma_stuff_t {
 	unsigned char *sendbuf;
 	unsigned char *recbuf;
 	ccw1_t read_ccw;
 	ccw1_t write_ccw;
-} qeth_dma_stuff_t __attribute__ ((packed,aligned(PAGE_SIZE)));
+} __attribute__((packed)) qeth_dma_stuff_t __attribute__ ((aligned(PAGE_SIZE)));
 
 typedef struct qeth_perf_stats_t {
 	unsigned int skbs_rec;
diff -urN linux-2.4.30/drivers/s390/net/qeth_mpc.h linux-2.4.30-nvk/drivers/s390/net/qeth_mpc.h
--- linux-2.4.30/drivers/s390/net/qeth_mpc.h	2004-12-04 17:45:26.000000000 +0530
+++ linux-2.4.30-nvk/drivers/s390/net/qeth_mpc.h	2005-04-20 15:33:16.000000000 +0530
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
 
 
 

==============================================================================

On Mon, 2005-04-18 at 20:37 +0530, Vinay K Nallamothu wrote:
> Hi,
> 
> The variable attributes "packed" and "align" when used with structure
> should have the following order:
> 
> struct ... {...} __attribute__((packed)) var;
> 
> This patch fixes few instances where the variable and attributes are
> placed the other way around and had no affect.

-- 
Views expressed in this mail are those of the individual sender and 
do not bind Gsec1 Limited. or its subsidiary, unless the sender has done
so expressly with due authority of Gsec1.
_________________________________________________________________________


