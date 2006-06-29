Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932937AbWF2Vuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932937AbWF2Vuf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932906AbWF2Vu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:50:26 -0400
Received: from mx.pathscale.com ([64.160.42.68]:38799 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932908AbWF2VoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:10 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 31 of 39] IB/ipath - drop the "stats" sysfs attribute group
X-Mercurial-Node: 21378f21e091f6fc81fc64ea23d4664ed950c779
Message-Id: <21378f21e091f6fc81fc.1151617282@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:22 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This attribute group made it into the original driver, but should
not have.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 3ceb73f8bde0 -r 21378f21e091 drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Jun 29 14:33:26 2006 -0700
@@ -84,81 +84,6 @@ static ssize_t show_num_units(struct dev
 	return scnprintf(buf, PAGE_SIZE, "%d\n",
 			 ipath_count_units(NULL, NULL, NULL));
 }
-
-#define DRIVER_STAT(name, attr) \
-	static ssize_t show_stat_##name(struct device_driver *dev, \
-					char *buf) \
-	{ \
-		return scnprintf( \
-			buf, PAGE_SIZE, "%llu\n", \
-			(unsigned long long) ipath_stats.sps_ ##attr); \
-	} \
-	static DRIVER_ATTR(name, S_IRUGO, show_stat_##name, NULL)
-
-DRIVER_STAT(intrs, ints);
-DRIVER_STAT(err_intrs, errints);
-DRIVER_STAT(errs, errs);
-DRIVER_STAT(pkt_errs, pkterrs);
-DRIVER_STAT(crc_errs, crcerrs);
-DRIVER_STAT(hw_errs, hwerrs);
-DRIVER_STAT(ib_link, iblink);
-DRIVER_STAT(port0_pkts, port0pkts);
-DRIVER_STAT(ether_spkts, ether_spkts);
-DRIVER_STAT(ether_rpkts, ether_rpkts);
-DRIVER_STAT(sma_spkts, sma_spkts);
-DRIVER_STAT(sma_rpkts, sma_rpkts);
-DRIVER_STAT(hdrq_full, hdrqfull);
-DRIVER_STAT(etid_full, etidfull);
-DRIVER_STAT(no_piobufs, nopiobufs);
-DRIVER_STAT(ports, ports);
-DRIVER_STAT(pkey0, pkeys[0]);
-DRIVER_STAT(pkey1, pkeys[1]);
-DRIVER_STAT(pkey2, pkeys[2]);
-DRIVER_STAT(pkey3, pkeys[3]);
-
-DRIVER_STAT(nports, nports);
-DRIVER_STAT(null_intr, nullintr);
-DRIVER_STAT(max_pkts_call, maxpkts_call);
-DRIVER_STAT(avg_pkts_call, avgpkts_call);
-DRIVER_STAT(page_locks, pagelocks);
-DRIVER_STAT(page_unlocks, pageunlocks);
-DRIVER_STAT(krdrops, krdrops);
-
-static struct attribute *driver_stat_attributes[] = {
-	&driver_attr_intrs.attr,
-	&driver_attr_err_intrs.attr,
-	&driver_attr_errs.attr,
-	&driver_attr_pkt_errs.attr,
-	&driver_attr_crc_errs.attr,
-	&driver_attr_hw_errs.attr,
-	&driver_attr_ib_link.attr,
-	&driver_attr_port0_pkts.attr,
-	&driver_attr_ether_spkts.attr,
-	&driver_attr_ether_rpkts.attr,
-	&driver_attr_sma_spkts.attr,
-	&driver_attr_sma_rpkts.attr,
-	&driver_attr_hdrq_full.attr,
-	&driver_attr_etid_full.attr,
-	&driver_attr_no_piobufs.attr,
-	&driver_attr_ports.attr,
-	&driver_attr_pkey0.attr,
-	&driver_attr_pkey1.attr,
-	&driver_attr_pkey2.attr,
-	&driver_attr_pkey3.attr,
-	&driver_attr_nports.attr,
-	&driver_attr_null_intr.attr,
-	&driver_attr_max_pkts_call.attr,
-	&driver_attr_avg_pkts_call.attr,
-	&driver_attr_page_locks.attr,
-	&driver_attr_page_unlocks.attr,
-	&driver_attr_krdrops.attr,
-	NULL
-};
-
-static struct attribute_group driver_stat_attr_group = {
-	.name = "stats",
-	.attrs = driver_stat_attributes
-};
 
 static ssize_t show_status(struct device *dev,
 			   struct device_attribute *attr,
@@ -716,20 +641,12 @@ int ipath_driver_create_group(struct dev
 	int ret;
 
 	ret = sysfs_create_group(&drv->kobj, &driver_attr_group);
-	if (ret)
-		goto bail;
-
-	ret = sysfs_create_group(&drv->kobj, &driver_stat_attr_group);
-	if (ret)
-		sysfs_remove_group(&drv->kobj, &driver_attr_group);
-
-bail:
+
 	return ret;
 }
 
 void ipath_driver_remove_group(struct device_driver *drv)
 {
-	sysfs_remove_group(&drv->kobj, &driver_stat_attr_group);
 	sysfs_remove_group(&drv->kobj, &driver_attr_group);
 }
 
