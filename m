Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbVIITmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbVIITmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbVIITlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:41:20 -0400
Received: from magic.adaptec.com ([216.52.22.17]:64454 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030388AbVIITkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:40:33 -0400
Message-ID: <4321E52B.5000200@adaptec.com>
Date: Fri, 09 Sep 2005 15:40:27 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 6/14] sas-class: sas_dump.c Debug/dumping utility
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:40:32.0132 (UTC) FILETIME=[570F5C40:01C5B576]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/drivers/scsi/sas-class/sas_dump.c linux-2.6.13/drivers/scsi/sas-class/sas_dump.c
--- linux-2.6.13-orig/drivers/scsi/sas-class/sas_dump.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/drivers/scsi/sas-class/sas_dump.c	2005-09-09 11:14:29.000000000 -0400
@@ -0,0 +1,77 @@
+/*
+ * Serial Attached SCSI (SAS) Dump/Debugging routines
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * $Id: //depot/sas-class/sas_dump.c#4 $
+ */
+
+#include "sas_dump.h"
+
+#ifdef SAS_DEBUG
+
+static const char *sas_hae_str[] = {
+	[0] = "HAE_RESET",
+};
+
+static const char *sas_porte_str[] = {
+	[0] = "PORTE_BYTES_DMAED",
+	[1] = "PORTE_BROADCAST_RCVD",
+	[2] = "PORTE_LINK_RESET_ERR",
+	[3] = "PORTE_TIMER_EVENT",
+	[4] = "PORTE_HARD_RESET",
+};
+
+static const char *sas_phye_str[] = {
+	[0] = "PHYE_LOSS_OF_SIGNAL",
+	[1] = "PHYE_OOB_DONE",
+	[2] = "PHYE_OOB_ERROR",
+	[3] = "PHYE_SPINUP_HOLD",
+};
+
+void sas_dprint_porte(int phyid, enum port_event pe)
+{
+	SAS_DPRINTK("phy%d: port event: %s\n", phyid, sas_porte_str[pe]);
+}
+void sas_dprint_phye(int phyid, enum phy_event pe)
+{
+	SAS_DPRINTK("phy%d: phy event: %s\n", phyid, sas_phye_str[pe]);
+}
+
+void sas_dprint_hae(struct sas_ha_struct *sas_ha, enum ha_event he)
+{
+	SAS_DPRINTK("ha %s: %s event\n", pci_name(sas_ha->pcidev),
+		    sas_hae_str[he]);
+}
+
+void sas_dump_port(struct sas_port *port)
+{
+	SAS_DPRINTK("port%d: class:0x%x\n", port->id, port->class);
+	SAS_DPRINTK("port%d: sas_addr:%llx\n", port->id,
+		    SAS_ADDR(port->sas_addr));
+	SAS_DPRINTK("port%d: attached_sas_addr:%llx\n", port->id,
+		    SAS_ADDR(port->attached_sas_addr));
+	SAS_DPRINTK("port%d: iproto:0x%x\n", port->id, port->iproto);
+	SAS_DPRINTK("port%d: tproto:0x%x\n", port->id, port->tproto);
+	SAS_DPRINTK("port%d: oob_mode:0x%x\n", port->id, port->oob_mode);
+	SAS_DPRINTK("port%d: num_phys:%d\n", port->id, port->num_phys);
+}
+
+#endif /* SAS_DEBUG */


