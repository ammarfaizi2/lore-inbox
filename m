Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbVIITmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbVIITmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbVIITmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:42:03 -0400
Received: from magic.adaptec.com ([216.52.22.17]:26567 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030397AbVIITlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:41:44 -0400
Message-ID: <4321E571.8040702@adaptec.com>
Date: Fri, 09 Sep 2005 15:41:37 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 11/14] sas-class: sas_internal.h SAS Layer internal
 header file
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:41:42.0993 (UTC) FILETIME=[814BE410:01C5B576]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/drivers/scsi/sas-class/sas_internal.h linux-2.6.13/drivers/scsi/sas-class/sas_internal.h
--- linux-2.6.13-orig/drivers/scsi/sas-class/sas_internal.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/drivers/scsi/sas-class/sas_internal.h	2005-09-09 11:14:47.000000000 -0400
@@ -0,0 +1,79 @@
+/*
+ * Serial Attached SCSI (SAS) class internal header file
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ *
+ * $Id: //depot/sas-class/sas_internal.h#35 $
+ */
+
+#ifndef _SAS_INTERNAL_H_
+#define _SAS_INTERNAL_H_
+
+#include <scsi/sas/sas_class.h>
+
+#define sas_printk(fmt, ...) printk(KERN_NOTICE "sas: " fmt, ## __VA_ARGS__)
+
+#ifdef SAS_DEBUG
+#define SAS_DPRINTK(fmt, ...) printk(KERN_NOTICE "sas: " fmt, ## __VA_ARGS__)
+#else
+#define SAS_DPRINTK(fmt, ...)
+#endif
+
+int sas_show_class(enum sas_class class, char *buf);
+int sas_show_proto(enum sas_proto proto, char *buf);
+int sas_show_linkrate(enum sas_phy_linkrate linkrate, char *buf);
+int sas_show_oob_mode(enum sas_oob_mode oob_mode, char *buf);
+
+int  sas_register_phys(struct sas_ha_struct *sas_ha);
+void sas_unregister_phys(struct sas_ha_struct *sas_ha);
+
+int  sas_register_ports(struct sas_ha_struct *sas_ha);
+void sas_unregister_ports(struct sas_ha_struct *sas_ha);
+
+int  sas_register_scsi_host(struct sas_ha_struct *sas_ha);
+void sas_unregister_scsi_host(struct sas_ha_struct *sas_ha);
+
+int  sas_start_event_thread(struct sas_ha_struct *sas_ha);
+void sas_kill_event_thread(struct sas_ha_struct *sas_ha);
+
+int  sas_init_queue(struct sas_ha_struct *sas_ha);
+void sas_shutdown_queue(struct sas_ha_struct *sas_ha);
+
+void sas_phye_loss_of_signal(struct sas_phy *phy);
+void sas_phye_oob_done(struct sas_phy *phy);
+void sas_phye_oob_error(struct sas_phy *phy);
+void sas_phye_spinup_hold(struct sas_phy *phy);
+
+void sas_deform_port(struct sas_phy *phy);
+
+void sas_porte_bytes_dmaed(struct sas_phy *phy);
+void sas_porte_broadcast_rcvd(struct sas_phy *phy);
+void sas_porte_link_reset_err(struct sas_phy *phy);
+void sas_porte_timer_event(struct sas_phy *phy);
+void sas_porte_hard_reset(struct sas_phy *phy);
+
+int  sas_reserve_free_id(struct sas_port *port);
+void sas_reserve_scsi_id(struct sas_port *port, int id);
+void sas_release_scsi_id(struct sas_port *port, int id);
+
+void sas_hae_reset(struct sas_ha_struct *sas_ha);
+
+#endif /* _SAS_INTERNAL_H_ */


