Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWJESXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWJESXh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWJESXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:23:36 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:7639 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S1750833AbWJESW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:22:56 -0400
From: Misha Tomushev <misha@fabric7.com>
Reply-To: misha@fabric7.com
Organization: Fabric7 Systems
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 3/10] VIOC: New Network Device Driver
Date: Thu, 5 Oct 2006 10:59:36 -0700
User-Agent: KMail/1.5.1
Cc: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051059.36647.misha@fabric7.com>
X-OriginalArrivalTime: 05 Oct 2006 18:22:42.0547 (UTC) FILETIME=[3F497C30:01C6E8AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding VIOC device driver. Out-of-band provisioning protocol support code.

Signed-off-by: Misha Tomushev  <misha@fabric7.com>

diff -uprN linux-2.6.17/drivers/net/vioc/f7/spp.h 
linux-2.6.17.vioc/drivers/net/vioc/f7/spp.h
--- linux-2.6.17/drivers/net/vioc/f7/spp.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.vioc/drivers/net/vioc/f7/spp.h	2006-09-06 16:22:59.000000000 
-0700
@@ -0,0 +1,68 @@
+/*
+ * Fabric7 Systems Virtual IO Controller Driver
+ * Copyright (C) 2003-2005 Fabric7 Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * http://www.fabric7.com/
+ *
+ * Maintainers:
+ *    driver-support@fabric7.com
+ *
+ *
+ */
+#ifndef _SPP_H_
+#define _SPP_H_
+
+#include "vnic_hw_registers.h"
+
+#define SPP_MODULE     VIOC_BMC
+
+#define SPP_CMD_REG_BANK       15
+#define SPP_SIM_PMM_BANK       14
+#define        SPP_PMM_BMC_BANK        13
+
+/* communications COMMAND REGISTERS */
+#define SPP_SIM_PMM_CMDREG     GETRELADDR(SPP_MODULE, SPP_CMD_REG_BANK, 
VREG_BMC_REG_R1)
+#define VIOCCP_SPP_SIM_PMM_CMDREG              \
+                       VIOCCP_GETRELADDR(SPP_MODULE, SPP_CMD_REG_BANK, 
VREG_BMC_REG_R1)
+#define SPP_PMM_SIM_CMDREG     GETRELADDR(SPP_MODULE, SPP_CMD_REG_BANK, 
VREG_BMC_REG_R2)
+#define VIOCCP_SPP_PMM_SIM_CMDREG              \
+                       VIOCCP_GETRELADDR(SPP_MODULE, SPP_CMD_REG_BANK, 
VREG_BMC_REG_R2)
+#define SPP_PMM_BMC_HB_CMDREG  GETRELADDR(SPP_MODULE, SPP_CMD_REG_BANK, 
VREG_BMC_REG_R3)
+#define SPP_PMM_BMC_SIG_CMDREG GETRELADDR(SPP_MODULE, SPP_CMD_REG_BANK, 
VREG_BMC_REG_R4)
+#define SPP_PMM_BMC_CMDREG     GETRELADDR(SPP_MODULE, SPP_CMD_REG_BANK, 
VREG_BMC_REG_R5)
+
+#define SPP_BANK_ADDR(bank) GETRELADDR(SPP_MODULE, bank, VREG_BMC_REG_R0)
+
+#define SPP_SIM_PMM_DATA GETRELADDR(SPP_MODULE, SPP_SIM_PMM_BANK, 
VREG_BMC_REG_R0)
+#define VIOCCP_SPP_SIM_PMM_DATA                        \
+                       VIOCCP_GETRELADDR(SPP_MODULE, SPP_SIM_PMM_BANK, 
VREG_BMC_REG_R0)
+
+/* PMM-BMC Sensor register bits */
+#define SPP_PMM_BMC_HB_SENREG  GETRELADDR(SPP_MODULE, 0, VREG_BMC_SENSOR0)
+#define SPP_PMM_BMC_CTL_SENREG GETRELADDR(SPP_MODULE, 0, VREG_BMC_SENSOR1)
+#define SPP_PMM_BMC_SENREG     GETRELADDR(SPP_MODULE, 0, VREG_BMC_SENSOR2)
+
+/* BMC Interrupt number used to alert PMM that message has been sent */
+#define SPP_SIM_PMM_INTR       1
+#define SPP_BANK_REGS          32
+
+
+#define SPP_OK                 0
+#define SPP_CHKSUM_ERR 1
+#endif /* _SPP_H_ */
+
diff -uprN linux-2.6.17/drivers/net/vioc/f7/spp_msgdata.h 
linux-2.6.17.vioc/drivers/net/vioc/f7/spp_msgdata.h
--- linux-2.6.17/drivers/net/vioc/f7/spp_msgdata.h	1969-12-31 
16:00:00.000000000 -0800
+++ linux-2.6.17.vioc/drivers/net/vioc/f7/spp_msgdata.h	2006-09-06 
16:22:59.000000000 -0700
@@ -0,0 +1,54 @@
+/*
+ * Fabric7 Systems Virtual IO Controller Driver
+ * Copyright (C) 2003-2005 Fabric7 Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * http://www.fabric7.com/
+ *
+ * Maintainers:
+ *    driver-support@fabric7.com
+ *
+ *
+ */
+#ifndef _SPPMSGDATA_H_
+#define _SPPMSGDATA_H_
+
+#include "spp.h"
+
+/* KEYs For SPP_FACILITY_VNIC */
+#define SPP_KEY_VNIC_CTL       1
+#define SPP_KEY_SET_PROV       2
+
+/* Data Register Offset for VIOC ID parameter */
+#define SPP_VIOC_ID_IDX        0
+#define SPP_VIOC_ID_OFFSET GETRELADDR(SPP_MODULE, SPP_SIM_PMM_BANK, 
(VREG_BMC_REG_R0 + (SPP_VIOC_ID_IDX << 2)))
+#define VIOCCP_SPP_VIOC_ID_OFFSET VIOCCP_GETRELADDR(SPP_MODULE, 
SPP_SIM_PMM_BANK, (VREG_BMC_REG_R0 + (SPP_VIOC_ID_IDX << 2)))
+
+/* KEYs for  SPP_FACILITY_SYS  */
+#define SPP_KEY_REQUEST_SIGNAL 1
+
+/* Data Register Offset for RESET_TYPE parameter */
+#define SPP_UOS_RESET_TYPE_IDX 0
+#define SPP_UOS_RESET_TYPE_OFFSET GETRELADDR(SPP_MODULE, SPP_SIM_PMM_BANK, 
(VREG_BMC_REG_R0 + (SPP_UOS_RESET_TYPE_IDX << 2)))
+#define VIOCCP_SPP_UOS_RESET_TYPE_OFFSET VIOCCP_GETRELADDR(SPP_MODULE, 
SPP_SIM_PMM_BANK, (VREG_BMC_REG_R0 + (SPP_UOS_RESET_TYPE_IDX << 2)))
+
+#define SPP_RESET_TYPE_REBOOT  1
+#define SPP_RESET_TYPE_SHUTDOWN        2
+
+#endif /* _SPPMSGDATA_H_ */
+
+
diff -uprN linux-2.6.17/drivers/net/vioc/f7/sppapi.h 
linux-2.6.17.vioc/drivers/net/vioc/f7/sppapi.h
--- linux-2.6.17/drivers/net/vioc/f7/sppapi.h	1969-12-31 16:00:00.000000000 
-0800
+++ linux-2.6.17.vioc/drivers/net/vioc/f7/sppapi.h	2006-09-06 
16:22:59.000000000 -0700
@@ -0,0 +1,240 @@
+/*
+ * Fabric7 Systems Virtual IO Controller Driver
+ * Copyright (C) 2003-2005 Fabric7 Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * http://www.fabric7.com/
+ *
+ * Maintainers:
+ *    driver-support@fabric7.com
+ *
+ *
+ */
+#ifndef _SPPAPI_H_
+#define _SPPAPI_H_
+
+/*
+ * COMMAND REGISTER is encoded as follows:
+ * |-------------|-------------|--------|-----|----|------------|---------|
+ * | chksum:     | unique id:  | spare: | RC: | D: | facility:  | key:    |
+ * | 31 30 29 28 | 27 26 25 24 | 23 22  | 21  | 20 | 19 18 17 16| 15 - 0  |
+ * |-------------|-------------|--------|-----|----|------------|---------|
+ */
+
+#define SPP_KEY_MASK           0x0000ffff
+#define SPP_KEY_SHIFT  0
+#define SPP_KEY_MASK_SHIFTED   (SPP_KEY_MASK >> SPP_KEY_SHIFT)
+#define SPP_FACILITY_MASK      0x000f0000
+#define SPP_FACILITY_SHIFT     16
+#define SPP_FACILITY_MASK_SHIFTED      (SPP_FACILITY_MASK >> 
SPP_FACILITY_SHIFT)
+#define SPP_D_MASK                     0x00100000
+#define SPP_D_SHIFT                    20
+#define SPP_D_MASK_SHIFTED     (SPP_D_MASK >> SPP_D_SHIFT)
+#define SPP_RC_MASK                    0x00200000
+#define SPP_RC_SHIFT           21
+#define SPP_RC_MASK_SHIFTED    (SPP_RC_MASK >> SPP_RC_SHIFT)
+#define SPP_UNIQID_MASK                0x0f000000
+#define SPP_UNIQID_SHIFT       24
+#define SPP_UNIQID_MASK_SHIFTED        (SPP_UNIQID_MASK >> SPP_UNIQID_SHIFT)
+#define SPP_CHKSUM_MASK                0xf0000000
+#define SPP_CHKSUM_SHIFT       28
+#define SPP_CHKSUM_MASK_SHIFTED        (SPP_CHKSUM_MASK >> SPP_CHKSUM_SHIFT)
+
+#define SPP_GET_KEY(m)                         \
+    ((m & SPP_KEY_MASK) >> SPP_KEY_SHIFT)
+
+#define SPP_GET_FACILITY(m)                            \
+    ((m & SPP_FACILITY_MASK) >> SPP_FACILITY_SHIFT)
+
+#define SPP_GET_D(m)                                   \
+    ((m & SPP_D_MASK) >> SPP_D_SHIFT)
+
+#define SPP_GET_RC(m)                                  \
+    ((m & SPP_D_MASK) >> SPP_D_SHIFT)
+
+#define SPP_GET_UNIQID(m)                                      \
+    ((m & SPP_UNIQID_MASK) >> SPP_UNIQID_SHIFT)
+
+#define SPP_GET_CHKSUM(m)                                      \
+    ((m & SPP_CHKSUM_MASK) >> SPP_CHKSUM_SHIFT)
+
+#define SPP_SET_KEY(m, key) do { \
+    m = ((m & ~SPP_KEY_MASK) | ((key << SPP_KEY_SHIFT) & SPP_KEY_MASK)) ; \
+} while (0)
+
+#define SPP_SET_FACILITY(m, facility) do { \
+    m = ((m & ~SPP_FACILITY_MASK) | ((facility << SPP_FACILITY_SHIFT) & 
SPP_FACILITY_MASK)) ; \
+} while (0)
+
+#define SPP_MBOX_FREE          0
+#define SPP_MBOX_OCCUPIED      1
+
+#define SPP_MBOX_EMPTY(m) (SPP_GET_D(m) == SPP_MBOX_FREE)
+#define SPP_MBOX_FULL(m) (SPP_GET_D(m) == SPP_MBOX_OCCUPIED)
+
+#define SPP_SET_D(m, D) do { \
+    m = ((m & ~SPP_D_MASK) | ((D << SPP_D_SHIFT) & SPP_D_MASK)) ; \
+} while (0)
+
+#define        SPP_CMD_OK              0
+#define SPP_CMD_FAIL   1
+
+#define SPP_SET_RC(m, rc) do { \
+    m = ((m & ~SPP_RC_MASK) | ((rc << SPP_RC_SHIFT) & SPP_RC_MASK)) ; \
+} while (0)
+
+#define SPP_SET_UNIQID(m, uniqid) do { \
+    m = ((m & ~SPP_UNIQID_MASK) | ((uniqid << SPP_UNIQID_SHIFT) & 
SPP_UNIQID_MASK)) ; \
+} while (0)
+
+
+#define SPP_SET_CHKSUM(m, chksum) do { \
+    m = ((m & ~SPP_CHKSUM_MASK) | ((chksum << SPP_CHKSUM_SHIFT) & 
SPP_CHKSUM_MASK)) ; \
+} while (0)
+
+
+static inline u32 spp_calc_u32_4bit_chksum(u32 w, int n)
+{
+       int len;
+       int nibbles = (n > 8) ? 8:n;
+       u32 cs = 0;
+
+       for (len = 0; len < nibbles; len++) {
+               w = (w >> len);
+               cs += w  & SPP_CHKSUM_MASK_SHIFTED;
+       }
+
+       while (cs >> 4)
+               cs = (cs & SPP_CHKSUM_MASK_SHIFTED) + (cs >> 4);
+
+       return (~cs);
+}
+
+static inline u32 spp_calc_u32_chksum(u32 w)
+{
+       return (spp_calc_u32_4bit_chksum(w, 7));
+}
+
+static inline u32
+spp_validate_u32_chksum(u32 w)
+{
+       return (spp_calc_u32_4bit_chksum(w, 8) & SPP_CHKSUM_MASK_SHIFTED);
+}
+
+static inline u32
+spp_mbox_build_cmd(u32 key, u32 facility, u32 uniqid)
+{
+       u32     m = 0;
+       u32 cs;
+
+       SPP_SET_KEY(m, key);
+       SPP_SET_FACILITY(m, facility);
+       SPP_SET_UNIQID(m, uniqid);
+       SPP_SET_D(m, SPP_MBOX_OCCUPIED);
+       cs = spp_calc_u32_4bit_chksum(m, 7);
+       cs = (cs)?cs:~cs;
+       SPP_SET_CHKSUM(m, cs);
+
+       return (m);
+}
+
+static inline u32
+spp_build_key_facility(u32 key, u32 facility)
+{
+       u32     m = 0;
+
+       SPP_SET_KEY(m, key);
+       SPP_SET_FACILITY(m, facility);
+
+       return (m);
+}
+
+
+static inline u32
+spp_mbox_build_reply(u32 cmd, int success)
+{
+       u32 reply = cmd;
+       u32 cs;
+
+       SPP_SET_D(reply, SPP_MBOX_FREE);
+       if (success == SPP_CMD_OK)
+               SPP_SET_RC(reply, SPP_CMD_OK);
+       else
+               SPP_SET_RC(reply, SPP_CMD_FAIL);
+
+       cs = spp_calc_u32_4bit_chksum(reply, 7);
+       cs = (cs)?cs:~cs;
+       SPP_SET_CHKSUM(reply, cs);
+
+       return (reply);
+}
+
+static inline int
+spp_mbox_empty(u32 m)
+{
+       return SPP_MBOX_EMPTY(m);
+}
+
+static inline int
+spp_mbox_full(u32 m)
+{
+       return SPP_MBOX_FULL(m);
+}
+
+/*
+ * SPP Facilities 0 - 15
+ */
+
+#define SPP_FACILITY_VNIC      0       /* VNIC Provisioning */
+#define SPP_FACILITY_SYS       1       /* UOS Control */
+#define SPP_FACILITY_ISCSI_VNIC        2       /* iSCSI Initiator 
Provisioning */
+
+
+/*
+ * spp_msg_register() is use to install a callback - cb_fn() function, that 
would
+ * be invoked once the message with specific handle has beed received.
+ * The unique "handle" that associates the callback with the messages is
+ * key_facility parameter.
+ * Typically the endpoints (sender on SIM and receiver on PMM) would agree on
+ * the  "handle" that consists of FACILITY (4 bits) and KEY (16 bits).
+ * The inlude spp_build_key_facility(key, facility) builds such handle.
+ * The parameters of callback:
+ * cb_nf(u32 cmd, void *data_buf, int data_buf_size, u32 timestamp), are
+ * cmd - an actual command value that was sent by SIM
+ * data_buf - pointer to up to 128 bytes (32 u32s) of message data from SIM
+ * data_buf_size - actual number of bytes in the message
+ * timestamp - a relative time/sequence number indicating when message,
+ * that caused the callback, was received.
+ *
+ * IMPORTANT: If the message was already waiting, at the time of 
spp_msg_register()
+ * call, the cb_fn() will be invoked in the context of spp_msg_register().
+ *
+ */
+extern int spp_msg_register(u32 key_facility, void (*cb_fn)(u32, void *, int, 
u32));
+
+/*
+ * spp_msg_unregirster() will remove the callback function, so that
+ * the imcoming messages with the key_facility handle will basically be
+ * overwriting command and data buffers.
+ */
+
+extern void spp_msg_unregister(u32 key_facility);
+
+extern int read_spp_regbank32(int vioc, int bank, char *buffer);
+
+#endif /* _SPPAPI_H_ */
+
diff -uprN linux-2.6.17/drivers/net/vioc/khash.h 
linux-2.6.17.vioc/drivers/net/vioc/khash.h
--- linux-2.6.17/drivers/net/vioc/khash.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.vioc/drivers/net/vioc/khash.h	2006-09-06 16:22:59.000000000 
-0700
@@ -0,0 +1,63 @@
+/*
+ * Fabric7 Systems Virtual IO Controller Driver
+ * Copyright (C) 2003-2005 Fabric7 Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * http://www.fabric7.com/
+ *
+ * Maintainers:
+ *    driver-support@fabric7.com
+ *
+ *
+ */
+#ifndef __HASHIT__
+#define __HASHIT__
+
+#define CHAIN_H 0U
+#define OADDRESS_H 1U
+#define OVERFLOW_H 2U
+
+#include <linux/stddef.h>
+#include <linux/errno.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+
+struct shash_t;
+
+/* Elem is used both for chain and overflow hash */
+struct hash_elem_t {
+    struct hash_elem_t *next;
+    void *key;
+    void *data;
+       void (*cb_fn)(u32, void *, int, u32);
+       u32      command;
+       u32      timestamp;
+       spinlock_t lock;
+};
+
+
+struct shash_t  *hashT_create(u32, size_t, size_t, u32(*)(unsigned char *, 
unsigned long), int(*)(void *, void *), unsigned int);
+int hashT_delete(struct shash_t * , void *);
+struct hash_elem_t *hashT_lookup(struct shash_t * , void *);
+struct hash_elem_t *hashT_add(struct shash_t *, void *);
+void hashT_destroy(struct shash_t *);
+/* Accesors */
+void **hashT_getkeys(struct shash_t *);
+size_t hashT_tablesize(struct shash_t *);
+size_t hashT_size(struct shash_t *);
+
+#endif

diff -uprN linux-2.6.17/drivers/net/vioc/spp.c 
linux-2.6.17.vioc/drivers/net/vioc/spp.c
--- linux-2.6.17/drivers/net/vioc/spp.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.vioc/drivers/net/vioc/spp.c	2006-10-04 10:16:15.000000000 
-0700
@@ -0,0 +1,624 @@
+/*
+ * Fabric7 Systems Virtual IO Controller Driver
+ * Copyright (C) 2003-2005 Fabric7 Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * http://www.fabric7.com/
+ *
+ * Maintainers:
+ *    driver-support@fabric7.com
+ *
+ *
+ */
+#include <linux/module.h>
+#include "f7/vnic_hw_registers.h"
+#include "f7/spp.h"
+#include "f7/sppapi.h"
+
+#include "vioc_vnic.h"
+#include "vioc_api.h"
+#include "khash.h"
+
+#define FACILITY_CNT   16
+
+#define mix(a,b,c) \
+{ \
+  a -= b; a -= c; a ^= (c >> 13); \
+  b -= c; b -= a; b ^= (a << 8); \
+  c -= a; c -= b; c ^= (b >> 13); \
+  a -= b; a -= c; a ^= (c >> 12);  \
+  b -= c; b -= a; b ^= (a << 16); \
+  c -= a; c -= b; c ^= (b >> 5); \
+  a -= b; a -= c; a ^= (c >> 3);  \
+  b -= c; b -= a; b ^= (a << 10); \
+  c -= a; c -= b; c ^= (b >> 15); \
+}
+
+
+struct shash_t {
+	/* Common fields for all hash tables types */
+	size_t tsize;		/* Table size */
+	size_t ksize;		/* Key size is fixed at creation time */
+	size_t dsize;		/* Data size is fixed at creation time */
+	size_t nelems;		/* Number of elements in the hash table */
+	struct hash_ops *h_ops;
+	 u32(*hash_fn) (unsigned char *, unsigned long);
+	void (*copy_fn) (void *, int, void *);
+	int (*compare_fn) (void *, void *);
+	struct hash_elem_t **chtable;	/* Data for the collision */
+};
+
+struct hash_ops {
+	int (*delete) (struct shash_t *, void *);
+	struct hash_elem_t *(*lookup) (struct shash_t *, void *);
+	void (*destroy) (struct shash_t *);
+	struct hash_elem_t *(*add) (struct shash_t *, void *);
+	void **(*getkeys) (struct shash_t *);
+};
+
+struct facility {
+	struct shash_t *hashT;
+	spinlock_t lock;
+};
+
+static u32 hash_func(unsigned char *k, unsigned long length)
+{
+	unsigned long a, b, c, len;
+
+	/* Set up the internal state */
+	len = length;
+	a = b = c = 0x9e3779b9;	/* the golden ratio; an arbitrary value */
+
+	/* Handle most of the key */
+	while (len >= 12) {
+		a += (k[0] + ((unsigned long)k[1] << 8) +
+		      ((unsigned long)k[2] << 16) +
+		      ((unsigned long)k[3] << 24));
+		b += (k[4] + ((unsigned long)k[5] << 8) +
+		      ((unsigned long)k[6] << 16) +
+		      ((unsigned long)k[7] << 24));
+		c += (k[8] + ((unsigned long)k[9] << 8) +
+		      ((unsigned long)k[10] << 16) +
+		      ((unsigned long)k[11] << 24));
+		mix(a, b, c);
+		k += 12;
+		len -= 12;
+	}
+
+	/* Handle the last 11 bytes */
+	c += length;
+	switch (len) {		/* all the case statements fall through */
+	case 11:
+		c += ((unsigned long)k[10] << 24);
+	case 10:
+		c += ((unsigned long)k[9] << 16);
+	case 9:
+		c += ((unsigned long)k[8] << 8);
+		/* the first byte of c is reserved for the length */
+	case 8:
+		b += ((unsigned long)k[7] << 24);
+	case 7:
+		b += ((unsigned long)k[6] << 16);
+	case 6:
+		b += ((unsigned long)k[5] << 8);
+	case 5:
+		b += k[4];
+	case 4:
+		a += ((unsigned long)k[3] << 24);
+	case 3:
+		a += ((unsigned long)k[2] << 16);
+	case 2:
+		a += ((unsigned long)k[1] << 8);
+	case 1:
+		a += k[0];
+	}
+	mix(a, b, c);
+
+	return c;
+}
+
+static u32 gethash(struct shash_t *htable, void *key)
+{
+	size_t len;
+
+	len = htable->ksize;
+
+	/* Hash the key and get the meaningful bits for our table */
+	return ((htable->hash_fn(key, len)) & (htable->tsize - 1));
+}
+
+/* Data associated to this key MUST be freed by the caller */
+static int ch_delete(struct shash_t *htable, void *key)
+{
+	u32 idx;
+	struct hash_elem_t *cursor;	/* Cursor for the linked list */
+	struct hash_elem_t *tmp;	/* Pointer to the element to be deleted */
+
+	idx = gethash(htable, key);
+
+	if (!htable->chtable[idx])
+		return -1;
+
+	/* Delete asked element */
+	/* Element to delete is the first in the chain */
+	if (htable->compare_fn(htable->chtable[idx]->key, key) == 0) {
+		tmp = htable->chtable[idx];
+		htable->chtable[idx] = tmp->next;
+		vfree(tmp);
+		htable->nelems--;
+		return 0;
+	}
+	/* Search thru the chain for the element */
+	else {
+		cursor = htable->chtable[idx];
+		while (cursor->next != NULL) {
+			if (htable->compare_fn(cursor->next->key, key) == 0) {
+				tmp = cursor->next;
+				cursor->next = tmp->next;
+				vfree(tmp);
+				htable->nelems--;
+				return 0;
+			}
+			cursor = cursor->next;
+		}
+	}
+
+	return -1;
+}
+
+static void ch_destroy(struct shash_t *htable)
+{
+	u32 idx;
+	struct hash_elem_t *cursor;
+
+	for (idx = 0; idx < htable->tsize; idx++) {
+		cursor = htable->chtable[idx];
+
+		while (cursor != NULL) {
+			struct hash_elem_t *tmp_cursor = cursor;
+
+			cursor = cursor->next;
+			vfree(tmp_cursor);
+		}
+	}
+	vfree(htable->chtable);
+}
+
+/* Return a NULL terminated string of pointers to all hash table keys */
+static void **ch_getkeys(struct shash_t *htable)
+{
+	u32 idx;
+	struct hash_elem_t *cursor;
+	void **keys;
+	u32 kidx;
+
+	keys = vmalloc((htable->nelems + 1) * sizeof(void *));
+	if (!keys) {
+		return NULL;
+	}
+	keys[htable->nelems] = NULL;
+	kidx = 0;
+
+	for (idx = 0; idx < htable->tsize; idx++) {
+
+		cursor = htable->chtable[idx];
+		while (cursor != NULL) {
+			printk(KERN_INFO "Element %d in bucket %d, key %p value %px\n",
+			       kidx, idx, cursor->key, cursor->data);
+			keys[kidx] = cursor->key;
+			kidx++;
+
+			cursor = cursor->next;
+		}
+	}
+
+	return keys;
+}
+
+/* Accesors 
******************************************************************/
+inline size_t hashT_tablesize(struct shash_t * htable)
+{
+	return htable->tsize;
+}
+
+inline size_t hashT_size(struct shash_t * htable)
+{
+	return htable->nelems;
+}
+
+static struct hash_elem_t *ch_lookup(struct shash_t *htable, void *key)
+{
+	u32 idx;
+	struct hash_elem_t *cursor;
+
+	idx = gethash(htable, key);
+
+	cursor = htable->chtable[idx];
+
+	/* Search thru the chain for the asked key */
+	while (cursor != NULL) {
+		if (htable->compare_fn(cursor->key, key) == 0)
+			return cursor;
+		cursor = cursor->next;
+	}
+
+	return NULL;
+}
+
+static struct hash_elem_t *ch_add(struct shash_t *htable, void *key)
+{
+	u32 idx;
+	struct hash_elem_t *cursor;
+	struct hash_elem_t *oneelem;
+
+	idx = gethash(htable, key);
+
+	cursor = htable->chtable[idx];
+
+	/* Search thru the chain for the asked key */
+	while (cursor != NULL) {
+		if (htable->compare_fn(cursor->key, key) == 0)
+			break;
+		cursor = cursor->next;
+	}
+
+	if (!cursor) {
+		/* cursor == NULL, means, that no element with this key was found,
+		 * need to insert one
+		 */
+		oneelem =
+		    (struct hash_elem_t *)vmalloc(sizeof(struct hash_elem_t) +
+						  htable->ksize +
+						  htable->dsize);
+		if (!oneelem)
+			return (struct hash_elem_t *)NULL;
+		memset((void *)oneelem, 0,
+		       sizeof(struct hash_elem_t) + htable->ksize +
+		       htable->dsize);
+
+		oneelem->command = 0;
+		oneelem->key = (void *)((char *)oneelem + sizeof(struct hash_elem_t));
+		oneelem->data = (void *)((char *)oneelem->key + htable->ksize);
+		memcpy((void *)oneelem->key, (void *)key, htable->ksize);
+
+		oneelem->next = NULL;
+
+		if (htable->chtable[idx] == NULL)
+			/* No collision ;), first element in this bucket */
+			htable->chtable[idx] = oneelem;
+		else {
+			/* Collision, insert at the end of the chain */
+			cursor = htable->chtable[idx];
+			while (cursor->next != NULL)
+				cursor = cursor->next;
+
+			/* Insert element at the end of the chain */
+			cursor->next = oneelem;
+		}
+
+		htable->nelems++;
+		spin_lock_init(&oneelem->lock);
+	} else {
+		/* Found element with the key */
+		oneelem = cursor;
+	}
+
+	return oneelem;
+}
+
+static int key_compare(void *key_in, void *key_out)
+{
+	if ((u16) * ((u16 *) key_in) == (u16) * ((u16 *) key_out))
+		return 0;
+	else
+		return 1;
+}
+
+struct hash_ops ch_ops = {
+	.delete = ch_delete,
+	.lookup = ch_lookup,
+	.destroy = ch_destroy,
+	.getkeys = ch_getkeys,
+	.add = ch_add
+};
+
+struct facility fTable[FACILITY_CNT];
+
+int spp_init(void)
+{
+	int i;
+
+	for (i = 0; i < FACILITY_CNT; i++) {
+		fTable[i].hashT = NULL;
+		spin_lock_init(&fTable[i].lock);
+	}
+
+	spp_vnic_init();
+
+	return 0;
+}
+
+void spp_terminate(void)
+{
+	int i;
+
+	spp_vnic_exit();
+
+	for (i = 0; i < FACILITY_CNT; i++) {
+		if (fTable[i].hashT) {
+			spin_lock(&fTable[i].lock);
+			hashT_destroy(fTable[i].hashT);
+			fTable[i].hashT = NULL;
+			spin_unlock(&fTable[i].lock);
+		}
+	}
+}
+
+void spp_msg_from_sim(int vioc_idx)
+{
+	struct vioc_device *viocdev = vioc_viocdev(vioc_idx);
+	u32 command_reg, pmm_reply;
+	u32 key, facility, uniqid;
+	u32 *data_p;
+	struct hash_elem_t *elem;
+	int i;
+
+	vioc_reg_rd(viocdev->ba.virt, SPP_SIM_PMM_CMDREG, &command_reg);
+
+	if (spp_mbox_empty(command_reg)) {
+		return;
+	}
+
+	/* Validate checksum */
+	if (spp_validate_u32_chksum(command_reg) != 0) {
+		return;
+	}
+
+	/* Build reply message to SIM */
+	pmm_reply = spp_mbox_build_reply(command_reg, SPP_CMD_OK);
+
+	key = SPP_GET_KEY(command_reg);
+	facility = SPP_GET_FACILITY(command_reg);
+	uniqid = SPP_GET_UNIQID(command_reg);
+
+	/* Check-and-create hash table */
+	spin_lock(&fTable[facility].lock);
+
+	if (fTable[facility].hashT == NULL) {
+		fTable[facility].hashT =
+		    hashT_create(1024, 2, 128, NULL, key_compare, 0);
+		if (fTable[facility].hashT == NULL) {
+			goto error_exit;
+		}
+	}
+
+	/* Add the hash table element */
+	elem = hashT_add(fTable[facility].hashT, (void *)&key);
+	if (!elem) {
+		goto error_exit;
+	}
+	spin_unlock(&fTable[facility].lock);
+
+	/* Copy data from SPP Registers to the key buffer */
+	spin_lock(&elem->lock);
+
+	/* Copy data from SPP Register Bank */
+	for (i = 0, data_p = (u32 *) elem->data; i < SPP_BANK_REGS;
+	     i++, (u32 *) data_p++) {
+		vioc_reg_rd(viocdev->ba.virt, SPP_SIM_PMM_DATA + (i << 2), (u32 *) data_p);
+	}
+
+	elem->command = command_reg;
+	elem->timestamp++;
+	elem->timestamp = (elem->timestamp & 0x0fffffff) | (vioc_idx << 28);
+
+	spin_unlock(&elem->lock);
+
+	vioc_reg_wr(pmm_reply, viocdev->ba.virt, SPP_SIM_PMM_CMDREG);
+	viocdev->last_msg_to_sim = pmm_reply;
+
+	/* If there was registered callback, execute it */
+	if (elem->cb_fn) {
+		spin_lock(&elem->lock);
+		if (spp_validate_u32_chksum(elem->command) == 0) {
+			/* If there is a valid message waiting, call callback */
+			elem->cb_fn(elem->command,
+				    elem->data, 128, elem->timestamp);
+			elem->command = 0;
+		}
+		spin_unlock(&elem->lock);
+	}
+	return;
+
+      error_exit:
+	spin_unlock(&fTable[facility].lock);
+	pmm_reply = spp_mbox_build_reply(command_reg, SPP_CMD_FAIL);
+	vioc_reg_wr(pmm_reply, viocdev->ba.virt, SPP_SIM_PMM_CMDREG);
+	return;
+
+}
+
+int spp_msg_register(u32 key_facility, void (*cb_fn) (u32, void *, int, u32))
+{
+	u32 facility = SPP_GET_FACILITY(key_facility);
+	u32 key = SPP_GET_KEY(key_facility);
+	struct hash_elem_t *elem;
+
+	/* Check-and-create hash table */
+	spin_lock(&fTable[facility].lock);
+
+	if (fTable[facility].hashT == NULL) {
+		fTable[facility].hashT =
+		    hashT_create(1024, 2, 128, NULL, key_compare, 0);
+		if (fTable[facility].hashT == NULL) {
+			goto error_exit;
+		}
+	}
+
+	/* Add the hash table element */
+	elem = hashT_add(fTable[facility].hashT, (void *)&key);
+	if (!elem) {
+		goto error_exit;
+	}
+	spin_unlock(&fTable[facility].lock);
+
+	spin_lock(&elem->lock);
+	elem->cb_fn = cb_fn;
+	if (spp_validate_u32_chksum(elem->command) == 0) {
+		/* If there is a valid message waiting, call callback */
+		elem->cb_fn(elem->command, elem->data, 128, elem->timestamp);
+		elem->command = 0;
+	}
+	spin_unlock(&elem->lock);
+	return SPP_CMD_OK;
+
+      error_exit:
+	spin_unlock(&fTable[facility].lock);
+	return SPP_CMD_FAIL;
+}
+
+void spp_msg_unregister(u32 key_facility)
+{
+	u32 key = SPP_GET_KEY(key_facility);
+	u32 facility = SPP_GET_FACILITY(key_facility);
+	struct hash_elem_t *elem;
+
+	if (fTable[facility].hashT == NULL)
+		return;
+
+	elem = hashT_lookup(fTable[facility].hashT, (void *)&key);
+	if (!elem)
+		return;
+
+	spin_lock(&elem->lock);
+	elem->cb_fn = NULL;
+	spin_unlock(&elem->lock);
+}
+
+
+int read_spp_regbank32(int vioc_idx, int bank, char *buffer)
+{
+	struct vioc_device *viocdev = vioc_viocdev(vioc_idx);
+	int i;
+	u32 *data_p;
+	u32 reg;
+
+	if (!viocdev)
+		return 0;
+
+	/* Copy data from SPP Register Bank */
+	for (i = 0, data_p = (u32 *) buffer; i < SPP_BANK_REGS;
+	     i++, (u32 *) data_p++) {
+		reg = SPP_BANK_ADDR(bank) + (i << 2);
+		vioc_reg_rd(viocdev->ba.virt, reg, (u32 *) data_p);
+	}
+
+	return i;
+}
+
+struct shash_t *hashT_create(u32 sizehint, 
+							size_t keybuf_size,
+			     			size_t databuf_size, 
+							u32(*hfunc) (unsigned char *,
+							unsigned long),
+							int (*cfunc) (void *, void *), 
+							unsigned int flags)
+{
+	struct shash_t *htable;
+	u32 size = 0;		/* Table size */
+	int i = 1;
+
+	/* Take the size hint and round it to the next higher power of two */
+	while (size < sizehint) {
+		size = 1 << i++;
+		if (size == 0) {
+			size = 1 << (i - 2);
+			break;
+		}
+	}
+
+	if (cfunc == NULL)
+		return NULL;
+
+	/* Create hash table */
+	htable = vmalloc(sizeof(struct shash_t) + keybuf_size + databuf_size);
+	if (!htable)
+		return NULL;
+
+	/* And create structs for hash table */
+
+	htable->h_ops = &ch_ops;
+	htable->chtable = vmalloc(size * (sizeof(struct hash_elem_t)
+						   	+ keybuf_size 
+							+ databuf_size));
+	if (!htable->chtable) {
+		vfree(htable);
+		return NULL;
+	}
+
+	memset(htable->chtable, '\0',
+	       size * (sizeof(struct hash_elem_t) + keybuf_size + databuf_size));
+
+	/* Initialize hash table common fields */
+	htable->tsize = size;
+	htable->ksize = keybuf_size;
+	htable->dsize = databuf_size;
+	htable->nelems = 0;
+
+	if (hfunc)
+		htable->hash_fn = hfunc;
+	else
+		htable->hash_fn = hash_func;
+
+	htable->compare_fn = cfunc;
+
+	return htable;
+}
+
+int hashT_delete(struct shash_t *htable, void *key)
+{
+	return htable->h_ops->delete(htable, key);
+}
+
+struct hash_elem_t *hashT_add(struct shash_t *htable, void *key)
+{
+	return htable->h_ops->add(htable, key);
+}
+
+struct hash_elem_t *hashT_lookup(struct shash_t *htable, void *key)
+{
+	return htable->h_ops->lookup(htable, key);
+}
+
+void hashT_destroy(struct shash_t *htable)
+{
+
+	htable->h_ops->destroy(htable);
+
+	vfree(htable);
+}
+
+void **hashT_getkeys(struct shash_t *htable)
+{
+	return htable->h_ops->getkeys(htable);
+}
+
+#ifdef EXPORT_SYMTAB
+EXPORT_SYMBOL(spp_msg_register);
+EXPORT_SYMBOL(spp_msg_unregister);
+EXPORT_SYMBOL(read_spp_regbank32);
+#endif
diff -uprN linux-2.6.17/drivers/net/vioc/spp_vnic.c 
linux-2.6.17.vioc/drivers/net/vioc/spp_vnic.c
--- linux-2.6.17/drivers/net/vioc/spp_vnic.c	1969-12-31 16:00:00.000000000 
-0800
+++ linux-2.6.17.vioc/drivers/net/vioc/spp_vnic.c	2006-10-04 
10:18:35.000000000 -0700
@@ -0,0 +1,131 @@
+/*
+ * Fabric7 Systems Virtual IO Controller Driver
+ * Copyright (C) 2003-2005 Fabric7 Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * http://www.fabric7.com/
+ *
+ * Maintainers:
+ *    driver-support@fabric7.com
+ *
+ *
+ */
+#include <stdarg.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include "vioc_vnic.h"
+#include "vioc_api.h"
+#include "f7/sppapi.h"
+#include "f7/spp_msgdata.h"
+#include "f7/vnic_hw_registers.h"
+
+
+#define VIOC_ID_FROM_STAMP(stamp)      ((stamp >> 28) & 0xf)
+
+static u32 relative_time;
+
+static void spp_vnic_cb(u32 cmd, void *msg_buf, int buf_size, u32 viocstamp)
+{
+	u32 param, param2;
+	int viocdev_idx;
+	u32 timestamp = viocstamp & 0x0fffffff;
+	int vioc_id = VIOC_ID_FROM_STAMP(viocstamp);
+
+	relative_time = timestamp;
+
+	viocdev_idx = ((int *)msg_buf)[SPP_VIOC_ID_IDX];
+	if (viocdev_idx != vioc_id) {
+		printk(KERN_ERR "%s: MSG to VIOC=%d, but param VIOC=%d\n",
+		       __FUNCTION__, vioc_id, viocdev_idx);
+	}
+	param = vioc_rrd(viocdev_idx, VIOC_BMC, 0, VREG_BMC_VNIC_EN);
+	param2 = vioc_rrd(viocdev_idx, VIOC_BMC, 0, VREG_BMC_PORT_EN);
+#ifdef VNIC_UNREGISTER_PATCH
+	vioc_vnic_prov(viocdev_idx, param, param2, 1);
+#else
+	vioc_vnic_prov(viocdev_idx, param, param2, 0);
+#endif
+}
+
+static void spp_sys_cb(u32 cmd, void *msg_buf, int buf_size, u32 viocstamp)
+{
+	u32 reset_type;
+	u32 timestamp = viocstamp & 0x0fffffff;
+
+	relative_time = timestamp;
+
+	reset_type = ((u32 *) msg_buf)[SPP_UOS_RESET_TYPE_IDX];
+	if (vioc_handle_reset_request(reset_type) < 0) {
+		/* Invalid reset type ..ignore the message */
+		printk(KERN_ERR "Invalid reset request %d\n", reset_type);
+	}
+}
+static void spp_prov_cb(u32 cmd, void *msg_buf, int buf_size, u32 viocstamp)
+{
+	u32 timestamp = viocstamp & 0x0fffffff;
+
+	relative_time = timestamp;
+}
+
+struct kf_handler {
+	u32 key;
+	u32 facility;
+	void (*cb) (u32, void *, int, u32);
+};
+
+static
+struct kf_handler local_cb[] = {
+	{SPP_KEY_VNIC_CTL, SPP_FACILITY_VNIC, spp_vnic_cb},
+	{SPP_KEY_REQUEST_SIGNAL, SPP_FACILITY_SYS, spp_sys_cb},
+	{SPP_KEY_SET_PROV, SPP_FACILITY_VNIC, spp_prov_cb},
+	{0, 0, NULL}
+};
+
+int spp_vnic_init(void)
+{
+	u32 key_facility = 0;
+	int i;
+
+	for (i = 0; local_cb[i].cb; i++) {
+
+		SPP_SET_KEY(key_facility, local_cb[i].key);
+		SPP_SET_FACILITY(key_facility, local_cb[i].facility);
+
+		spp_msg_register(key_facility, local_cb[i].cb);
+	}
+	return 0;
+}
+
+void spp_vnic_exit(void)
+{
+	u32 key_facility = 0;
+	int i;
+
+	for (i = 0; local_cb[i].cb; i++) {
+
+		SPP_SET_KEY(key_facility, local_cb[i].key);
+		SPP_SET_FACILITY(key_facility, local_cb[i].facility);
+
+		spp_msg_unregister(key_facility);
+	}
+	return;
+}
+
diff -uprN linux-2.6.17/drivers/net/vioc/vioc_spp.c 
linux-2.6.17.vioc/drivers/net/vioc/vioc_spp.c
--- linux-2.6.17/drivers/net/vioc/vioc_spp.c	1969-12-31 16:00:00.000000000 
-0800
+++ linux-2.6.17.vioc/drivers/net/vioc/vioc_spp.c	2006-10-04 
10:39:45.000000000 -0700
@@ -0,0 +1,388 @@
+/*
+ * Fabric7 Systems Virtual IO Controller Driver
+ * Copyright (C) 2003-2005 Fabric7 Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * http://www.fabric7.com/
+ *
+ * Maintainers:
+ *    driver-support@fabric7.com
+ *
+ *
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/if_vlan.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/reboot.h>
+#include <linux/kallsyms.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+#include <net/genetlink.h>
+
+#include "f7/vnic_hw_registers.h"
+#include "f7/vnic_defs.h"
+#include "f7/spp_msgdata.h"
+#include "vioc_vnic.h"
+#include "vioc_api.h"
+
+/* Register definitions for communication between VIOC and BMC */
+
+#define SPP_VIOC_MODULE        VIOC_BMC
+
+#define SPP_BMC_VNIC   14
+#define SPP_SIM_VNIC   15
+
+/* PMM-BMC communications messages */
+#define SPP_BMC_RST_RQ         0x01
+#define SPP_BMC_TUN_MSG                0x02
+#define SPP_BMC_HB                     0x01
+
+/* PMM-BMC Sensor register bits */
+#define SPP_HB_SENSOR_REG      GETRELADDR(SPP_VIOC_MODULE, 0, 
VREG_BMC_SENSOR0)
+#define SPP_SHUTDWN_SENSOR_REG GETRELADDR(SPP_VIOC_MODULE, 0, 
VREG_BMC_SENSOR1)
+#define SPP_PANIC_SENSOR_REG   GETRELADDR(SPP_VIOC_MODULE, 0, 
VREG_BMC_SENSOR2)
+#define SPP_RST_SENSOR_REG     GETRELADDR(SPP_VIOC_MODULE, 0, 
VREG_BMC_SENSOR3)
+
+/* PMM-BMC communications registers */
+#define SPP_BMC_HB_REG         GETRELADDR(SPP_VIOC_MODULE, SPP_BMC_VNIC, 
VREG_BMC_REG_R31)
+#define SPP_BMC_CMD_REG                GETRELADDR(SPP_VIOC_MODULE, 
SPP_BMC_VNIC, VREG_BMC_REG_R30)
+
+static DECLARE_MUTEX(vnic_prov_sem);
+
+static inline void vnic_prov_get_sema(void)
+{
+	down(&vnic_prov_sem);
+}
+
+static inline void vnic_prov_put_sema(void)
+{
+	up(&vnic_prov_sem);
+}
+
+/* VIOC must be write-locked */
+static int vioc_vnic_enable(int vioc_id, int vnic_id)
+{
+	struct vioc_device *viocdev = vioc_viocdev(vioc_id);
+	struct net_device *netdev;
+	int rc = E_VIOCOK;
+
+	netdev = viocdev->vnic_netdev[vnic_id];
+	if (netdev == NULL) {
+		netdev = vioc_alloc_vnicdev(viocdev, vnic_id);
+		if (netdev == NULL) {
+			rc = -ENOMEM;
+			goto vioc_vnic_enable_exit;
+		} else {
+			viocdev->vnic_netdev[vnic_id] = netdev;
+
+			if ((rc = register_netdev(netdev))) {
+				free_netdev(netdev);
+				viocdev->vnic_netdev[vnic_id] = NULL;
+				goto vioc_vnic_enable_exit;
+			}
+		}
+	}
+
+	viocdev->vnics_map |= (1 << vnic_id);
+
+	rc = vioc_vnic_resources_set(vioc_id, vnic_id);
+
+      vioc_vnic_enable_exit:
+
+	return rc;
+}
+
+/* VIOC must be write-locked */
+static int vioc_vnic_disable(int vioc_id, int vnic_id, int unreg_flag)
+{
+	struct vioc_device *viocdev = vioc_viocdev(vioc_id);
+
+	/* Remove VNIC from the map BEFORE releasing resources */
+	viocdev->vnics_map &= ~(1 << vnic_id);
+
+	if (unreg_flag) {
+		/* Unregister netdev */
+		if (viocdev->vnic_netdev[vnic_id]) {
+			unregister_netdev(viocdev->vnic_netdev[vnic_id]);
+			dev_err(&viocdev->pdev->dev, "%s: %s\n", __FUNCTION__,
+			       (viocdev->vnic_netdev[vnic_id])->name);
+			free_netdev(viocdev->vnic_netdev[vnic_id]);
+			viocdev->vnic_netdev[vnic_id] = NULL;
+		} else
+			BUG_ON(viocdev->vnic_netdev[vnic_id] == NULL);
+	}
+
+	return E_VIOCOK;
+}
+
+void vioc_vnic_prov(int vioc_id, u32 vnic_en, u32 port_en, int free_flag)
+{
+	u32 change_map;
+	u32 up_map;
+	u32 down_map;
+	int vnic_id;
+	int rc = E_VIOCOK;
+	struct vioc_device *viocdev = vioc_viocdev(vioc_id);
+
+	change_map = vnic_en ^ viocdev->vnics_map;
+	up_map = vnic_en & change_map;
+	down_map = viocdev->vnics_map & change_map;
+
+	/* Enable from 0 to max */
+	for (vnic_id = 0; vnic_id < VIOC_MAX_VNICS; vnic_id++) {
+		if (up_map & (1 << vnic_id)) {
+			rc = vioc_vnic_enable(vioc_id, vnic_id);
+			if (rc) {
+				dev_err(&viocdev->pdev->dev, "%s: Enable VNIC %d FAILED\n",
+				       __FUNCTION__, vnic_id);
+			}
+		}
+	}
+
+	/* Disable from max to 0 */
+	for (vnic_id = VIOC_MAX_VNICS - 1; vnic_id >= 0; vnic_id--) {
+		if (down_map & (1 << vnic_id)) {
+			rc = vioc_vnic_disable(vioc_id, vnic_id, free_flag);
+			if (rc) {
+				dev_err(&viocdev->pdev->dev, "%s: Disable VNIC %d FAILED\n",
+				       __FUNCTION__, vnic_id);
+			}
+		}
+	}
+
+	/*
+	 * Now, after all VNIC enable-disable changes are in place,
+	 * viocdev->vnics_map contains the current state of VNIC map.
+	 * Use only ENABLED VNICs to process PORT_EN register, aka
+	 * LINK state register.
+	 */
+	for (vnic_id = VIOC_MAX_VNICS - 1; vnic_id >= 0; vnic_id--) {
+		if (viocdev->vnics_map & (1 << vnic_id)) {
+			struct net_device *netdev =
+			    viocdev->vnic_netdev[vnic_id];
+			if (port_en & (1 << vnic_id)) {
+				/* PORT ENABLED - LINK UP */
+				if (!netif_carrier_ok(netdev)) {
+					netif_carrier_on(netdev);
+					netif_wake_queue(netdev);
+					dev_err(&viocdev->pdev->dev, "idx %d, %s: Link UP\n",
+					       vioc_id, netdev->name);
+				}
+			} else {
+				/* PORT DISABLED - LINK DOWN */
+				if (netif_carrier_ok(netdev)) {
+					netif_stop_queue(netdev);
+					netif_carrier_off(netdev);
+					dev_err(&viocdev->pdev->dev,
+					       "idx %d, %s: Link DOWN\n",
+					       vioc_id, netdev->name);
+				}
+			}
+		}
+	}
+}
+
+/*
+ * Called from interrupt or task context
+ */
+void vioc_bmc_interrupt(void *input_param)
+{
+	int vioc_id = VIOC_IRQ_PARAM_VIOC_ID(input_param);
+	int rc = 0;
+	u32 intr_source_map, intr_source;
+	struct vioc_device *viocdev = vioc_viocdev(vioc_id);
+
+	if (viocdev->vioc_state != VIOC_STATE_UP) {
+		dev_err(&viocdev->pdev->dev, "VIOC %d is not UP yet\n",
+		       viocdev->viocdev_idx);
+		return;
+	}
+
+	/* Get the Interrupt Source Register */
+	intr_source_map = vioc_rrd(viocdev->viocdev_idx, VIOC_BMC, 0,
+				   VREG_BMC_INTRSTATUS);
+
+	vnic_prov_get_sema();
+
+	/*
+	 * Clear all pending interrupt bits, we will service all interrupts
+	 * based on the copy of 0x144 register in intr_source.
+	 */
+	rc = vioc_rwr(viocdev->viocdev_idx, VIOC_BMC, 0,
+		      VREG_BMC_INTRSTATUS, intr_source_map);
+	if (rc) {
+		dev_err(&viocdev->pdev->dev, "%s: vioc_rwr() -> %d\n", __FUNCTION__, rc);
+		goto vioc_bmc_interrupt_exit;
+	}
+
+	for (intr_source = VIOC_BMC_INTR0; intr_source_map; intr_source <<= 1) {
+		switch (intr_source_map & intr_source) {
+		case VIOC_BMC_INTR0:
+			dev_err(&viocdev->pdev->dev,
+			       "*** OLD SPP commands (BMC intr %08x) are no longer supported\n",
+			       intr_source_map);
+			break;
+		case VIOC_BMC_INTR1:
+			spp_msg_from_sim(viocdev->viocdev_idx);
+			break;
+
+		default:
+			break;
+		}
+		intr_source_map &= ~intr_source;
+	}
+
+      vioc_bmc_interrupt_exit:
+
+	vnic_prov_put_sema();
+
+	return;
+
+}
+
+/* SPP Messages originated by VIOC driver */
+void vioc_hb_to_bmc(int vioc_id)
+{
+	struct vioc_device *viocdev = vioc_viocdev(0);
+
+	if (!viocdev)
+		return;
+
+	/* Signal BMC that command was written by setting bit 0 of
+	 * SENSOR Register */
+	vioc_reg_wr(1, viocdev->ba.virt, SPP_HB_SENSOR_REG);
+}
+
+void vioc_reset_rq_to_bmc(int vioc_id, u32 command)
+{
+	struct vioc_device *viocdev = vioc_viocdev(0);
+
+	if (!viocdev)
+		return;
+
+	switch (command) {
+	case SYS_RESTART:
+		vioc_reg_wr(1, viocdev->ba.virt, SPP_RST_SENSOR_REG);
+		break;
+	case SYS_HALT:
+	case SYS_POWER_OFF:
+		vioc_reg_wr(1, viocdev->ba.virt, SPP_SHUTDWN_SENSOR_REG);
+		break;
+	default:
+		dev_err(&viocdev->pdev->dev, "%s: Received invalid command %d\n",
+		       __FUNCTION__, command);
+	}
+}
+
+/*-------------------------------------------------------------------*/
+
+/* Shutdown/Reboot handler definitions */
+static int vioc_shutdown_notify(struct notifier_block *thisblock,
+				unsigned long code, void *unused);
+
+static struct notifier_block vioc_shutdown_notifier = {
+	.notifier_call = vioc_shutdown_notify
+};
+
+void vioc_os_reset_notifier_init(void)
+{
+	/* We want to know get a callback when the system is going down */
+	if (register_reboot_notifier(&vioc_shutdown_notifier)) {
+		printk(KERN_ERR "%s: register_reboot_notifier() returned error\n",
+		       __FUNCTION__);
+	}
+}
+
+void vioc_os_reset_notifier_exit(void)
+{
+	if (unregister_reboot_notifier(&vioc_shutdown_notifier)) {
+		printk (KERN_ERR "%s: unregister_reboot_notifier() returned error\n",
+		     __FUNCTION__);
+	}
+}
+
+ /*
+  * vioc_shutdown_notify - Called when the OS is going down.
+  */
+static int vioc_shutdown_notify(struct notifier_block *thisblock,
+				unsigned long code, void *unused)
+{
+	vioc_reset_rq_to_bmc(0, code);
+	printk(KERN_ERR "%s: sent %s UOS state to BMC\n",
+			__FUNCTION__,
+			((code == SYS_RESTART) ? "REBOOT" :
+			((code == SYS_HALT) ? "HALT" :
+		 	((code == SYS_POWER_OFF) ? "POWER_OFF" : "Unknown"))));
+
+	return 0;
+}
+
+/*
+ * FUNCTION: vioc_handle_reset_request
+ * INPUT: Reset type : Shutdown, Reboot, Poweroff
+ * OUTPUT: Returns 0 on Success -EINVAL on failure
+ *
+ */
+int vioc_handle_reset_request(int reset_type)
+{
+	struct sk_buff *msg = NULL;
+	void *hdr;
+
+	printk(KERN_ERR "%s: received reset request %d via SPP\n",
+	       __FUNCTION__, reset_type);
+
+	/* Disable VIOC interrupts */
+	// vioc_irq_exit();
+
+	msg = nlmsg_new(NLMSG_GOODSIZE);
+	if (msg == NULL) {
+		printk(KERN_ERR "%s: nlmsg_new() FAILS\n", __FUNCTION__);
+		return (-ENOBUFS);
+	}
+
+	hdr = nlmsg_put(msg, 0, 0, 0, 0, 0);
+
+	if (reset_type == SPP_RESET_TYPE_REBOOT)
+		nla_put_string(msg, reset_type, "Reboot");
+	else
+		nla_put_string(msg, reset_type, "Shutdown");
+
+	nlmsg_end(msg, hdr);
+
+	return nlmsg_multicast(genl_sock, msg, 0, VIOC_LISTEN_GROUP);
+}


-- 
Misha Tomushev
misha@fabric7.com


