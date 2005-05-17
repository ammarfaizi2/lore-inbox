Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVEQK4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVEQK4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 06:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVEQK4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 06:56:55 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:52844 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261382AbVEQKnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 06:43:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=XHmuD3iN1YIIk3jR1cgmBm1ogNKvjOxLS/HKq7pQ/1b4LY9zStFmDU0WWusHJGvQh934tJC16eeFJG5uBYAo/YuPEd/BImmOkPrPRZChjFS+q5QhQkAnUMb70e4IrNTXoTXCnif1DFAy6NXVTmA+Mm35Xxiw+HkhVUuIkCzIpM0=
Message-ID: <25381867050517034323b6451@mail.gmail.com>
Date: Tue, 17 May 2005 06:43:37 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: [PATCH 2.6.12-rc4 11/15] drivers/s390/net/qeth_sys.c - drivers/usb/gadget/pxa2xx_udc.c: update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_288_11694303.1116326617355"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_288_11694303.1116326617355
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_288_11694303.1116326617355
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.6.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.6.diff.diffstat.txt"

 s390/net/qeth_sys.c              |  126 +++++++++++++++++++--------------------
 s390/scsi/zfcp_scsi.c            |    2 
 s390/scsi/zfcp_sysfs_adapter.c   |   10 +--
 s390/scsi/zfcp_sysfs_port.c      |   10 +--
 s390/scsi/zfcp_sysfs_unit.c      |    6 -
 scsi/53c700.c                    |    2 
 scsi/arm/eesox.c                 |    4 -
 scsi/arm/powertec.c              |    4 -
 scsi/ipr.c                       |    2 
 scsi/megaraid/megaraid_mbox.c    |    4 -
 scsi/scsi_sysfs.c                |   28 ++++----
 sh/superhyway/superhyway-sysfs.c |    2 
 usb/core/sysfs.c                 |   24 +++----
 usb/gadget/dummy_hcd.c           |    4 -
 usb/gadget/file_storage.c        |    8 +-
 usb/gadget/net2280.c             |    6 -
 usb/gadget/pxa2xx_udc.c          |    2 
 17 files changed, 122 insertions(+), 122 deletions(-)


------=_Part_288_11694303.1116326617355
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.6.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.6.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/net/qeth_sys.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/net/qeth_sys.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/net/qeth_sys.c	2005-05-16 20:35:52.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/net/qeth_sys.c	2005-05-16 23:45:53.000000000 -0400
@@ -30,7 +30,7 @@ const char *VERSION_QETH_SYS_C = "$Revis
 //low/high watermark
 
 static ssize_t
-qeth_dev_state_show(struct device *dev, char *buf)
+qeth_dev_state_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 	if (!card)
@@ -58,7 +58,7 @@ qeth_dev_state_show(struct device *dev, 
 static DEVICE_ATTR(state, 0444, qeth_dev_state_show, NULL);
 
 static ssize_t
-qeth_dev_chpid_show(struct device *dev, char *buf)
+qeth_dev_chpid_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 	if (!card)
@@ -70,7 +70,7 @@ qeth_dev_chpid_show(struct device *dev, 
 static DEVICE_ATTR(chpid, 0444, qeth_dev_chpid_show, NULL);
 
 static ssize_t
-qeth_dev_if_name_show(struct device *dev, char *buf)
+qeth_dev_if_name_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 	if (!card)
@@ -81,7 +81,7 @@ qeth_dev_if_name_show(struct device *dev
 static DEVICE_ATTR(if_name, 0444, qeth_dev_if_name_show, NULL);
 
 static ssize_t
-qeth_dev_card_type_show(struct device *dev, char *buf)
+qeth_dev_card_type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 	if (!card)
@@ -93,7 +93,7 @@ qeth_dev_card_type_show(struct device *d
 static DEVICE_ATTR(card_type, 0444, qeth_dev_card_type_show, NULL);
 
 static ssize_t
-qeth_dev_portno_show(struct device *dev, char *buf)
+qeth_dev_portno_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 	if (!card)
@@ -103,7 +103,7 @@ qeth_dev_portno_show(struct device *dev,
 }
 
 static ssize_t
-qeth_dev_portno_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_portno_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -129,7 +129,7 @@ qeth_dev_portno_store(struct device *dev
 static DEVICE_ATTR(portno, 0644, qeth_dev_portno_show, qeth_dev_portno_store);
 
 static ssize_t
-qeth_dev_portname_show(struct device *dev, char *buf)
+qeth_dev_portname_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 	char portname[9] = {0, };
@@ -146,7 +146,7 @@ qeth_dev_portname_show(struct device *de
 }
 
 static ssize_t
-qeth_dev_portname_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_portname_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -177,7 +177,7 @@ static DEVICE_ATTR(portname, 0644, qeth_
 		qeth_dev_portname_store);
 
 static ssize_t
-qeth_dev_checksum_show(struct device *dev, char *buf)
+qeth_dev_checksum_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -188,7 +188,7 @@ qeth_dev_checksum_show(struct device *de
 }
 
 static ssize_t
-qeth_dev_checksum_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_checksum_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -218,7 +218,7 @@ static DEVICE_ATTR(checksumming, 0644, q
 		qeth_dev_checksum_store);
 
 static ssize_t
-qeth_dev_prioqing_show(struct device *dev, char *buf)
+qeth_dev_prioqing_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -237,7 +237,7 @@ qeth_dev_prioqing_show(struct device *de
 }
 
 static ssize_t
-qeth_dev_prioqing_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_prioqing_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -290,7 +290,7 @@ static DEVICE_ATTR(priority_queueing, 06
 		qeth_dev_prioqing_store);
 
 static ssize_t
-qeth_dev_bufcnt_show(struct device *dev, char *buf)
+qeth_dev_bufcnt_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -301,7 +301,7 @@ qeth_dev_bufcnt_show(struct device *dev,
 }
 
 static ssize_t
-qeth_dev_bufcnt_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_bufcnt_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -360,7 +360,7 @@ qeth_dev_route_show(struct qeth_card *ca
 }
 
 static ssize_t
-qeth_dev_route4_show(struct device *dev, char *buf)
+qeth_dev_route4_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -410,7 +410,7 @@ qeth_dev_route_store(struct qeth_card *c
 }
 
 static ssize_t
-qeth_dev_route4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_route4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -425,7 +425,7 @@ static DEVICE_ATTR(route4, 0644, qeth_de
 
 #ifdef CONFIG_QETH_IPV6
 static ssize_t
-qeth_dev_route6_show(struct device *dev, char *buf)
+qeth_dev_route6_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -439,7 +439,7 @@ qeth_dev_route6_show(struct device *dev,
 }
 
 static ssize_t
-qeth_dev_route6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_route6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -461,7 +461,7 @@ static DEVICE_ATTR(route6, 0644, qeth_de
 #endif
 
 static ssize_t
-qeth_dev_add_hhlen_show(struct device *dev, char *buf)
+qeth_dev_add_hhlen_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -472,7 +472,7 @@ qeth_dev_add_hhlen_show(struct device *d
 }
 
 static ssize_t
-qeth_dev_add_hhlen_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_add_hhlen_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -499,7 +499,7 @@ static DEVICE_ATTR(add_hhlen, 0644, qeth
 		   qeth_dev_add_hhlen_store);
 
 static ssize_t
-qeth_dev_fake_ll_show(struct device *dev, char *buf)
+qeth_dev_fake_ll_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -510,7 +510,7 @@ qeth_dev_fake_ll_show(struct device *dev
 }
 
 static ssize_t
-qeth_dev_fake_ll_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_fake_ll_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -536,7 +536,7 @@ static DEVICE_ATTR(fake_ll, 0644, qeth_d
 		   qeth_dev_fake_ll_store);
 
 static ssize_t
-qeth_dev_fake_broadcast_show(struct device *dev, char *buf)
+qeth_dev_fake_broadcast_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -547,7 +547,7 @@ qeth_dev_fake_broadcast_show(struct devi
 }
 
 static ssize_t
-qeth_dev_fake_broadcast_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_fake_broadcast_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -574,7 +574,7 @@ static DEVICE_ATTR(fake_broadcast, 0644,
 		   qeth_dev_fake_broadcast_store);
 
 static ssize_t
-qeth_dev_recover_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_recover_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -596,7 +596,7 @@ qeth_dev_recover_store(struct device *de
 static DEVICE_ATTR(recover, 0200, NULL, qeth_dev_recover_store);
 
 static ssize_t
-qeth_dev_broadcast_mode_show(struct device *dev, char *buf)
+qeth_dev_broadcast_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -613,7 +613,7 @@ qeth_dev_broadcast_mode_show(struct devi
 }
 
 static ssize_t
-qeth_dev_broadcast_mode_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_broadcast_mode_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -651,7 +651,7 @@ static DEVICE_ATTR(broadcast_mode, 0644,
 		   qeth_dev_broadcast_mode_store);
 
 static ssize_t
-qeth_dev_canonical_macaddr_show(struct device *dev, char *buf)
+qeth_dev_canonical_macaddr_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -667,7 +667,7 @@ qeth_dev_canonical_macaddr_show(struct d
 }
 
 static ssize_t
-qeth_dev_canonical_macaddr_store(struct device *dev, const char *buf,
+qeth_dev_canonical_macaddr_store(struct device *dev, struct device_attribute *attr, const char *buf,
 				  size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
@@ -703,7 +703,7 @@ static DEVICE_ATTR(canonical_macaddr, 06
 		   qeth_dev_canonical_macaddr_store);
 
 static ssize_t
-qeth_dev_layer2_show(struct device *dev, char *buf)
+qeth_dev_layer2_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -714,7 +714,7 @@ qeth_dev_layer2_show(struct device *dev,
 }
 
 static ssize_t
-qeth_dev_layer2_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_layer2_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -742,7 +742,7 @@ static DEVICE_ATTR(layer2, 0644, qeth_de
 		   qeth_dev_layer2_store);
 
 static ssize_t
-qeth_dev_large_send_show(struct device *dev, char *buf)
+qeth_dev_large_send_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -762,7 +762,7 @@ qeth_dev_large_send_show(struct device *
 }
 
 static ssize_t
-qeth_dev_large_send_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_large_send_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	enum qeth_large_send_types type;
@@ -832,7 +832,7 @@ qeth_dev_blkt_store(struct qeth_card *ca
 }
 
 static ssize_t
-qeth_dev_blkt_total_show(struct device *dev, char *buf)
+qeth_dev_blkt_total_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -841,7 +841,7 @@ qeth_dev_blkt_total_show(struct device *
 
 
 static ssize_t
-qeth_dev_blkt_total_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_blkt_total_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -855,7 +855,7 @@ static DEVICE_ATTR(total, 0644, qeth_dev
 		   qeth_dev_blkt_total_store);
 
 static ssize_t
-qeth_dev_blkt_inter_show(struct device *dev, char *buf)
+qeth_dev_blkt_inter_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -864,7 +864,7 @@ qeth_dev_blkt_inter_show(struct device *
 
 
 static ssize_t
-qeth_dev_blkt_inter_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_blkt_inter_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -876,7 +876,7 @@ static DEVICE_ATTR(inter, 0644, qeth_dev
 		   qeth_dev_blkt_inter_store);
 
 static ssize_t
-qeth_dev_blkt_inter_jumbo_show(struct device *dev, char *buf)
+qeth_dev_blkt_inter_jumbo_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -886,7 +886,7 @@ qeth_dev_blkt_inter_jumbo_show(struct de
 
 
 static ssize_t
-qeth_dev_blkt_inter_jumbo_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_blkt_inter_jumbo_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -956,7 +956,7 @@ qeth_check_layer2(struct qeth_card *card
 
 
 static ssize_t
-qeth_dev_ipato_enable_show(struct device *dev, char *buf)
+qeth_dev_ipato_enable_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -969,7 +969,7 @@ qeth_dev_ipato_enable_show(struct device
 }
 
 static ssize_t
-qeth_dev_ipato_enable_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_enable_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -1004,7 +1004,7 @@ static QETH_DEVICE_ATTR(ipato_enable, en
 			qeth_dev_ipato_enable_store);
 
 static ssize_t
-qeth_dev_ipato_invert4_show(struct device *dev, char *buf)
+qeth_dev_ipato_invert4_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1018,7 +1018,7 @@ qeth_dev_ipato_invert4_show(struct devic
 }
 
 static ssize_t
-qeth_dev_ipato_invert4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_invert4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -1084,7 +1084,7 @@ qeth_dev_ipato_add_show(char *buf, struc
 }
 
 static ssize_t
-qeth_dev_ipato_add4_show(struct device *dev, char *buf)
+qeth_dev_ipato_add4_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1153,7 +1153,7 @@ qeth_dev_ipato_add_store(const char *buf
 }
 
 static ssize_t
-qeth_dev_ipato_add4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_add4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1186,7 +1186,7 @@ qeth_dev_ipato_del_store(const char *buf
 }
 
 static ssize_t
-qeth_dev_ipato_del4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_del4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1201,7 +1201,7 @@ static QETH_DEVICE_ATTR(ipato_del4, del4
 
 #ifdef CONFIG_QETH_IPV6
 static ssize_t
-qeth_dev_ipato_invert6_show(struct device *dev, char *buf)
+qeth_dev_ipato_invert6_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1215,7 +1215,7 @@ qeth_dev_ipato_invert6_show(struct devic
 }
 
 static ssize_t
-qeth_dev_ipato_invert6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_invert6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -1247,7 +1247,7 @@ static QETH_DEVICE_ATTR(ipato_invert6, i
 
 
 static ssize_t
-qeth_dev_ipato_add6_show(struct device *dev, char *buf)
+qeth_dev_ipato_add6_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1258,7 +1258,7 @@ qeth_dev_ipato_add6_show(struct device *
 }
 
 static ssize_t
-qeth_dev_ipato_add6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_add6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1273,7 +1273,7 @@ static QETH_DEVICE_ATTR(ipato_add6, add6
 			qeth_dev_ipato_add6_store);
 
 static ssize_t
-qeth_dev_ipato_del6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_del6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1341,7 +1341,7 @@ qeth_dev_vipa_add_show(char *buf, struct
 }
 
 static ssize_t
-qeth_dev_vipa_add4_show(struct device *dev, char *buf)
+qeth_dev_vipa_add4_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1381,7 +1381,7 @@ qeth_dev_vipa_add_store(const char *buf,
 }
 
 static ssize_t
-qeth_dev_vipa_add4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_vipa_add4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1413,7 +1413,7 @@ qeth_dev_vipa_del_store(const char *buf,
 }
 
 static ssize_t
-qeth_dev_vipa_del4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_vipa_del4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1428,7 +1428,7 @@ static QETH_DEVICE_ATTR(vipa_del4, del4,
 
 #ifdef CONFIG_QETH_IPV6
 static ssize_t
-qeth_dev_vipa_add6_show(struct device *dev, char *buf)
+qeth_dev_vipa_add6_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1439,7 +1439,7 @@ qeth_dev_vipa_add6_show(struct device *d
 }
 
 static ssize_t
-qeth_dev_vipa_add6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_vipa_add6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1454,7 +1454,7 @@ static QETH_DEVICE_ATTR(vipa_add6, add6,
 			qeth_dev_vipa_add6_store);
 
 static ssize_t
-qeth_dev_vipa_del6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_vipa_del6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1522,7 +1522,7 @@ qeth_dev_rxip_add_show(char *buf, struct
 }
 
 static ssize_t
-qeth_dev_rxip_add4_show(struct device *dev, char *buf)
+qeth_dev_rxip_add4_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1562,7 +1562,7 @@ qeth_dev_rxip_add_store(const char *buf,
 }
 
 static ssize_t
-qeth_dev_rxip_add4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_rxip_add4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1594,7 +1594,7 @@ qeth_dev_rxip_del_store(const char *buf,
 }
 
 static ssize_t
-qeth_dev_rxip_del4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_rxip_del4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1609,7 +1609,7 @@ static QETH_DEVICE_ATTR(rxip_del4, del4,
 
 #ifdef CONFIG_QETH_IPV6
 static ssize_t
-qeth_dev_rxip_add6_show(struct device *dev, char *buf)
+qeth_dev_rxip_add6_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1620,7 +1620,7 @@ qeth_dev_rxip_add6_show(struct device *d
 }
 
 static ssize_t
-qeth_dev_rxip_add6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_rxip_add6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1635,7 +1635,7 @@ static QETH_DEVICE_ATTR(rxip_add6, add6,
 			qeth_dev_rxip_add6_store);
 
 static ssize_t
-qeth_dev_rxip_del6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_rxip_del6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev->driver_data;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_scsi.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_scsi.c	2005-05-16 20:35:52.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/scsi/zfcp_scsi.c	2005-05-16 23:45:53.000000000 -0400
@@ -922,7 +922,7 @@ struct fc_function_template zfcp_transpo
  * Generates attribute for a unit.
  */
 #define ZFCP_DEFINE_SCSI_ATTR(_name, _format, _value)                    \
-static ssize_t zfcp_sysfs_scsi_##_name##_show(struct device *dev,        \
+static ssize_t zfcp_sysfs_scsi_##_name##_show(struct device *dev, struct device_attribute *attr,        \
                                               char *buf)                 \
 {                                                                        \
         struct scsi_device *sdev;                                        \
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_sysfs_adapter.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/scsi/zfcp_sysfs_adapter.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_sysfs_adapter.c	2005-05-16 20:35:52.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/scsi/zfcp_sysfs_adapter.c	2005-05-16 23:45:53.000000000 -0400
@@ -50,7 +50,7 @@ static const char fc_topologies[5][25] =
  * Generates attributes for an adapter.
  */
 #define ZFCP_DEFINE_ADAPTER_ATTR(_name, _format, _value)                      \
-static ssize_t zfcp_sysfs_adapter_##_name##_show(struct device *dev,          \
+static ssize_t zfcp_sysfs_adapter_##_name##_show(struct device *dev, struct device_attribute *attr,          \
 						 char *buf)                   \
 {                                                                             \
 	struct zfcp_adapter *adapter;                                         \
@@ -90,7 +90,7 @@ ZFCP_DEFINE_ADAPTER_ATTR(in_recovery, "%
  * Store function of the "port_add" attribute of an adapter.
  */
 static ssize_t
-zfcp_sysfs_port_add_store(struct device *dev, const char *buf, size_t count)
+zfcp_sysfs_port_add_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	wwn_t wwpn;
 	char *endp;
@@ -135,7 +135,7 @@ static DEVICE_ATTR(port_add, S_IWUSR, NU
  * Store function of the "port_remove" attribute of an adapter.
  */
 static ssize_t
-zfcp_sysfs_port_remove_store(struct device *dev, const char *buf, size_t count)
+zfcp_sysfs_port_remove_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct zfcp_adapter *adapter;
 	struct zfcp_port *port;
@@ -196,7 +196,7 @@ static DEVICE_ATTR(port_remove, S_IWUSR,
  * started for the belonging adapter.
  */
 static ssize_t
-zfcp_sysfs_adapter_failed_store(struct device *dev,
+zfcp_sysfs_adapter_failed_store(struct device *dev, struct device_attribute *attr,
 				const char *buf, size_t count)
 {
 	struct zfcp_adapter *adapter;
@@ -236,7 +236,7 @@ zfcp_sysfs_adapter_failed_store(struct d
  * "0" if adapter is working, otherwise "1".
  */
 static ssize_t
-zfcp_sysfs_adapter_failed_show(struct device *dev, char *buf)
+zfcp_sysfs_adapter_failed_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct zfcp_adapter *adapter;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_sysfs_port.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/scsi/zfcp_sysfs_port.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_sysfs_port.c	2005-05-16 20:35:52.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/scsi/zfcp_sysfs_port.c	2005-05-16 23:45:53.000000000 -0400
@@ -53,7 +53,7 @@ zfcp_sysfs_port_release(struct device *d
  * Generates attributes for a port.
  */
 #define ZFCP_DEFINE_PORT_ATTR(_name, _format, _value)                    \
-static ssize_t zfcp_sysfs_port_##_name##_show(struct device *dev,        \
+static ssize_t zfcp_sysfs_port_##_name##_show(struct device *dev, struct device_attribute *attr,        \
                                               char *buf)                 \
 {                                                                        \
         struct zfcp_port *port;                                          \
@@ -82,7 +82,7 @@ ZFCP_DEFINE_PORT_ATTR(access_denied, "%d
  * Store function of the "unit_add" attribute of a port.
  */
 static ssize_t
-zfcp_sysfs_unit_add_store(struct device *dev, const char *buf, size_t count)
+zfcp_sysfs_unit_add_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	fcp_lun_t fcp_lun;
 	char *endp;
@@ -125,7 +125,7 @@ static DEVICE_ATTR(unit_add, S_IWUSR, NU
  * @count: number of bytes in buffer
  */
 static ssize_t
-zfcp_sysfs_unit_remove_store(struct device *dev, const char *buf, size_t count)
+zfcp_sysfs_unit_remove_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct zfcp_port *port;
 	struct zfcp_unit *unit;
@@ -186,7 +186,7 @@ static DEVICE_ATTR(unit_remove, S_IWUSR,
  * started for the belonging port.
  */
 static ssize_t
-zfcp_sysfs_port_failed_store(struct device *dev, const char *buf, size_t count)
+zfcp_sysfs_port_failed_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct zfcp_port *port;
 	unsigned int val;
@@ -224,7 +224,7 @@ zfcp_sysfs_port_failed_store(struct devi
  * "0" if port is working, otherwise "1".
  */
 static ssize_t
-zfcp_sysfs_port_failed_show(struct device *dev, char *buf)
+zfcp_sysfs_port_failed_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct zfcp_port *port;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_sysfs_unit.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/scsi/zfcp_sysfs_unit.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_sysfs_unit.c	2005-05-16 20:35:52.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/scsi/zfcp_sysfs_unit.c	2005-05-16 23:45:53.000000000 -0400
@@ -53,7 +53,7 @@ zfcp_sysfs_unit_release(struct device *d
  * Generates attribute for a unit.
  */
 #define ZFCP_DEFINE_UNIT_ATTR(_name, _format, _value)                    \
-static ssize_t zfcp_sysfs_unit_##_name##_show(struct device *dev,        \
+static ssize_t zfcp_sysfs_unit_##_name##_show(struct device *dev, struct device_attribute *attr,        \
                                               char *buf)                 \
 {                                                                        \
         struct zfcp_unit *unit;                                          \
@@ -86,7 +86,7 @@ ZFCP_DEFINE_UNIT_ATTR(access_readonly, "
  * started for the belonging unit.
  */
 static ssize_t
-zfcp_sysfs_unit_failed_store(struct device *dev, const char *buf, size_t count)
+zfcp_sysfs_unit_failed_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct zfcp_unit *unit;
 	unsigned int val;
@@ -123,7 +123,7 @@ zfcp_sysfs_unit_failed_store(struct devi
  * "0" if unit is working, otherwise "1".
  */
 static ssize_t
-zfcp_sysfs_unit_failed_show(struct device *dev, char *buf)
+zfcp_sysfs_unit_failed_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct zfcp_unit *unit;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/53c700.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/scsi/53c700.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/53c700.c	2005-05-16 20:35:55.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/scsi/53c700.c	2005-05-16 23:45:53.000000000 -0400
@@ -2125,7 +2125,7 @@ static int NCR_700_change_queue_type(str
 }
 
 static ssize_t
-NCR_700_show_active_tags(struct device *dev, char *buf)
+NCR_700_show_active_tags(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *SDp = to_scsi_device(dev);
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/arm/eesox.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/scsi/arm/eesox.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/arm/eesox.c	2005-05-16 20:35:53.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/scsi/arm/eesox.c	2005-05-16 23:45:53.000000000 -0400
@@ -466,7 +466,7 @@ int eesoxscsi_proc_info(struct Scsi_Host
 	return pos;
 }
 
-static ssize_t eesoxscsi_show_term(struct device *dev, char *buf)
+static ssize_t eesoxscsi_show_term(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	struct Scsi_Host *host = ecard_get_drvdata(ec);
@@ -475,7 +475,7 @@ static ssize_t eesoxscsi_show_term(struc
 	return sprintf(buf, "%d\n", info->control & EESOX_TERM_ENABLE ? 1 : 0);
 }
 
-static ssize_t eesoxscsi_store_term(struct device *dev, const char *buf, size_t len)
+static ssize_t eesoxscsi_store_term(struct device *dev, struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	struct Scsi_Host *host = ecard_get_drvdata(ec);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/arm/powertec.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/scsi/arm/powertec.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/arm/powertec.c	2005-05-16 20:35:53.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/scsi/arm/powertec.c	2005-05-16 23:45:53.000000000 -0400
@@ -269,7 +269,7 @@ int powertecscsi_proc_info(struct Scsi_H
 	return pos;
 }
 
-static ssize_t powertecscsi_show_term(struct device *dev, char *buf)
+static ssize_t powertecscsi_show_term(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	struct Scsi_Host *host = ecard_get_drvdata(ec);
@@ -279,7 +279,7 @@ static ssize_t powertecscsi_show_term(st
 }
 
 static ssize_t
-powertecscsi_store_term(struct device *dev, const char *buf, size_t len)
+powertecscsi_store_term(struct device *dev, struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	struct Scsi_Host *host = ecard_get_drvdata(ec);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/ipr.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/scsi/ipr.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/ipr.c	2005-05-16 20:35:54.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/scsi/ipr.c	2005-05-16 23:45:53.000000000 -0400
@@ -2716,7 +2716,7 @@ static int ipr_change_queue_type(struct 
  * Return value:
  * 	number of bytes printed to buffer
  **/
-static ssize_t ipr_show_adapter_handle(struct device *dev, char *buf)
+static ssize_t ipr_show_adapter_handle(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)sdev->host->hostdata;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/megaraid/megaraid_mbox.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/scsi/megaraid/megaraid_mbox.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/megaraid/megaraid_mbox.c	2005-05-16 20:35:56.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/scsi/megaraid/megaraid_mbox.c	2005-05-16 23:45:53.000000000 -0400
@@ -124,7 +124,7 @@ static irqreturn_t megaraid_isr(int, voi
 static void megaraid_mbox_dpc(unsigned long);
 
 static ssize_t megaraid_sysfs_show_app_hndl(struct class_device *, char *);
-static ssize_t megaraid_sysfs_show_ldnum(struct device *, char *);
+static ssize_t megaraid_sysfs_show_ldnum(struct device *, struct device_attribute *attr, char *);
 
 static int megaraid_cmm_register(adapter_t *);
 static int megaraid_cmm_unregister(adapter_t *);
@@ -4213,7 +4213,7 @@ megaraid_sysfs_show_app_hndl(struct clas
  * @param buf	: buffer to send data to
  */
 static ssize_t
-megaraid_sysfs_show_ldnum(struct device *dev, char *buf)
+megaraid_sysfs_show_ldnum(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 	adapter_t	*adapter = (adapter_t *)SCSIHOST2ADAP(sdev->host);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/scsi_sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/scsi/scsi_sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/scsi_sysfs.c	2005-05-16 20:35:54.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/scsi/scsi_sysfs.c	2005-05-16 23:45:53.000000000 -0400
@@ -230,7 +230,7 @@ void scsi_sysfs_unregister(void)
  */
 #define sdev_show_function(field, format_string)				\
 static ssize_t								\
-sdev_show_##field (struct device *dev, char *buf)				\
+sdev_show_##field (struct device *dev, struct device_attribute *attr, char *buf)				\
 {									\
 	struct scsi_device *sdev;					\
 	sdev = to_scsi_device(dev);					\
@@ -254,7 +254,7 @@ static DEVICE_ATTR(field, S_IRUGO, sdev_
 	sdev_show_function(field, format_string)				\
 									\
 static ssize_t								\
-sdev_store_##field (struct device *dev, const char *buf, size_t count)	\
+sdev_store_##field (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
 {									\
 	struct scsi_device *sdev;					\
 	sdev = to_scsi_device(dev);					\
@@ -274,7 +274,7 @@ static DEVICE_ATTR(field, S_IRUGO | S_IW
 	sdev_show_function(field, "%d\n")					\
 									\
 static ssize_t								\
-sdev_store_##field (struct device *dev, const char *buf, size_t count)	\
+sdev_store_##field (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
 {									\
 	int ret;							\
 	struct scsi_device *sdev;					\
@@ -317,7 +317,7 @@ sdev_rd_attr (model, "%.16s\n");
 sdev_rd_attr (rev, "%.4s\n");
 
 static ssize_t
-sdev_show_timeout (struct device *dev, char *buf)
+sdev_show_timeout (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
@@ -325,7 +325,7 @@ sdev_show_timeout (struct device *dev, c
 }
 
 static ssize_t
-sdev_store_timeout (struct device *dev, const char *buf, size_t count)
+sdev_store_timeout (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct scsi_device *sdev;
 	int timeout;
@@ -337,14 +337,14 @@ sdev_store_timeout (struct device *dev, 
 static DEVICE_ATTR(timeout, S_IRUGO | S_IWUSR, sdev_show_timeout, sdev_store_timeout);
 
 static ssize_t
-store_rescan_field (struct device *dev, const char *buf, size_t count) 
+store_rescan_field (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) 
 {
 	scsi_rescan_device(dev);
 	return count;
 }
 static DEVICE_ATTR(rescan, S_IWUSR, NULL, store_rescan_field);
 
-static ssize_t sdev_store_delete(struct device *dev, const char *buf,
+static ssize_t sdev_store_delete(struct device *dev, struct device_attribute *attr, const char *buf,
 				 size_t count)
 {
 	scsi_remove_device(to_scsi_device(dev));
@@ -353,7 +353,7 @@ static ssize_t sdev_store_delete(struct 
 static DEVICE_ATTR(delete, S_IWUSR, NULL, sdev_store_delete);
 
 static ssize_t
-store_state_field(struct device *dev, const char *buf, size_t count)
+store_state_field(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	int i;
 	struct scsi_device *sdev = to_scsi_device(dev);
@@ -376,7 +376,7 @@ store_state_field(struct device *dev, co
 }
 
 static ssize_t
-show_state_field(struct device *dev, char *buf)
+show_state_field(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 	const char *name = scsi_device_state_name(sdev->sdev_state);
@@ -390,7 +390,7 @@ show_state_field(struct device *dev, cha
 static DEVICE_ATTR(state, S_IRUGO | S_IWUSR, show_state_field, store_state_field);
 
 static ssize_t
-show_queue_type_field(struct device *dev, char *buf)
+show_queue_type_field(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 	const char *name = "none";
@@ -406,7 +406,7 @@ show_queue_type_field(struct device *dev
 static DEVICE_ATTR(queue_type, S_IRUGO, show_queue_type_field, NULL);
 
 static ssize_t
-show_iostat_counterbits(struct device *dev, char *buf)
+show_iostat_counterbits(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, 20, "%d\n", (int)sizeof(atomic_t) * 8);
 }
@@ -415,7 +415,7 @@ static DEVICE_ATTR(iocounterbits, S_IRUG
 
 #define show_sdev_iostat(field)						\
 static ssize_t								\
-show_iostat_##field(struct device *dev, char *buf)			\
+show_iostat_##field(struct device *dev, struct device_attribute *attr, char *buf)			\
 {									\
 	struct scsi_device *sdev = to_scsi_device(dev);			\
 	unsigned long long count = atomic_read(&sdev->field);		\
@@ -449,7 +449,7 @@ static struct device_attribute *scsi_sys
 	NULL
 };
 
-static ssize_t sdev_store_queue_depth_rw(struct device *dev, const char *buf,
+static ssize_t sdev_store_queue_depth_rw(struct device *dev, struct device_attribute *attr, const char *buf,
 					 size_t count)
 {
 	int depth, retval;
@@ -475,7 +475,7 @@ static struct device_attribute sdev_attr
 	__ATTR(queue_depth, S_IRUGO | S_IWUSR, sdev_show_queue_depth,
 	       sdev_store_queue_depth_rw);
 
-static ssize_t sdev_store_queue_type_rw(struct device *dev, const char *buf,
+static ssize_t sdev_store_queue_type_rw(struct device *dev, struct device_attribute *attr, const char *buf,
 					size_t count)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/sh/superhyway/superhyway-sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/sh/superhyway/superhyway-sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/sh/superhyway/superhyway-sysfs.c	2005-05-16 20:35:33.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/sh/superhyway/superhyway-sysfs.c	2005-05-16 23:45:53.000000000 -0400
@@ -15,7 +15,7 @@
 #include <linux/superhyway.h>
 
 #define superhyway_ro_attr(name, fmt, field)				\
-static ssize_t name##_show(struct device *dev, char *buf)		\
+static ssize_t name##_show(struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct superhyway_device *s = to_superhyway_device(dev);	\
 	return sprintf(buf, fmt, s->field);				\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/core/sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/usb/core/sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/core/sysfs.c	2005-05-16 20:35:43.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/usb/core/sysfs.c	2005-05-16 23:45:53.000000000 -0400
@@ -24,7 +24,7 @@
 
 /* Active configuration fields */
 #define usb_actconfig_show(field, multiplier, format_string)		\
-static ssize_t  show_##field (struct device *dev, char *buf)		\
+static ssize_t  show_##field (struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct usb_device *udev;					\
 	struct usb_host_config *actconfig;				\
@@ -46,7 +46,7 @@ usb_actconfig_attr (bNumInterfaces, 1, "
 usb_actconfig_attr (bmAttributes, 1, "%2x\n")
 usb_actconfig_attr (bMaxPower, 2, "%3dmA\n")
 
-static ssize_t show_configuration_string(struct device *dev, char *buf)
+static ssize_t show_configuration_string(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_device *udev;
 	struct usb_host_config *actconfig;
@@ -69,7 +69,7 @@ static DEVICE_ATTR(configuration, S_IRUG
 usb_actconfig_show(bConfigurationValue, 1, "%u\n");
 
 static ssize_t
-set_bConfigurationValue (struct device *dev, const char *buf, size_t count)
+set_bConfigurationValue (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct usb_device	*udev = udev = to_usb_device (dev);
 	int			config, value;
@@ -87,7 +87,7 @@ static DEVICE_ATTR(bConfigurationValue, 
 
 /* String fields */
 #define usb_string_attr(name)						\
-static ssize_t  show_##name(struct device *dev, char *buf)		\
+static ssize_t  show_##name(struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct usb_device *udev;					\
 	int len;							\
@@ -107,7 +107,7 @@ usb_string_attr(manufacturer);
 usb_string_attr(serial);
 
 static ssize_t
-show_speed (struct device *dev, char *buf)
+show_speed (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_device *udev;
 	char *speed;
@@ -133,7 +133,7 @@ show_speed (struct device *dev, char *bu
 static DEVICE_ATTR(speed, S_IRUGO, show_speed, NULL);
 
 static ssize_t
-show_devnum (struct device *dev, char *buf)
+show_devnum (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_device *udev;
 
@@ -143,7 +143,7 @@ show_devnum (struct device *dev, char *b
 static DEVICE_ATTR(devnum, S_IRUGO, show_devnum, NULL);
 
 static ssize_t
-show_version (struct device *dev, char *buf)
+show_version (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_device *udev;
 	u16 bcdUSB;
@@ -155,7 +155,7 @@ show_version (struct device *dev, char *
 static DEVICE_ATTR(version, S_IRUGO, show_version, NULL);
 
 static ssize_t
-show_maxchild (struct device *dev, char *buf)
+show_maxchild (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_device *udev;
 
@@ -167,7 +167,7 @@ static DEVICE_ATTR(maxchild, S_IRUGO, sh
 /* Descriptor fields */
 #define usb_descriptor_attr_le16(field, format_string)			\
 static ssize_t								\
-show_##field (struct device *dev, char *buf)				\
+show_##field (struct device *dev, struct device_attribute *attr, char *buf)				\
 {									\
 	struct usb_device *udev;					\
 									\
@@ -183,7 +183,7 @@ usb_descriptor_attr_le16(bcdDevice, "%04
 
 #define usb_descriptor_attr(field, format_string)			\
 static ssize_t								\
-show_##field (struct device *dev, char *buf)				\
+show_##field (struct device *dev, struct device_attribute *attr, char *buf)				\
 {									\
 	struct usb_device *udev;					\
 									\
@@ -254,7 +254,7 @@ void usb_remove_sysfs_dev_files (struct 
 /* Interface fields */
 #define usb_intf_attr(field, format_string)				\
 static ssize_t								\
-show_##field (struct device *dev, char *buf)				\
+show_##field (struct device *dev, struct device_attribute *attr, char *buf)				\
 {									\
 	struct usb_interface *intf = to_usb_interface (dev);		\
 									\
@@ -269,7 +269,7 @@ usb_intf_attr (bInterfaceClass, "%02x\n"
 usb_intf_attr (bInterfaceSubClass, "%02x\n")
 usb_intf_attr (bInterfaceProtocol, "%02x\n")
 
-static ssize_t show_interface_string(struct device *dev, char *buf)
+static ssize_t show_interface_string(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_interface *intf;
 	struct usb_device *udev;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/dummy_hcd.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/usb/gadget/dummy_hcd.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/dummy_hcd.c	2005-05-16 20:35:44.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/usb/gadget/dummy_hcd.c	2005-05-16 23:45:53.000000000 -0400
@@ -633,7 +633,7 @@ static const struct usb_gadget_ops dummy
 
 /* "function" sysfs attribute */
 static ssize_t
-show_function (struct device *dev, char *buf)
+show_function (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dummy	*dum = gadget_dev_to_dummy (dev);
 
@@ -1600,7 +1600,7 @@ show_urb (char *buf, size_t size, struct
 }
 
 static ssize_t
-show_urbs (struct device *dev, char *buf)
+show_urbs (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_hcd		*hcd = dev_get_drvdata (dev);
 	struct dummy		*dum = hcd_to_dummy (hcd);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/file_storage.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/usb/gadget/file_storage.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/file_storage.c	2005-05-16 20:35:44.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/usb/gadget/file_storage.c	2005-05-16 23:45:53.000000000 -0400
@@ -3554,14 +3554,14 @@ static void close_all_backing_files(stru
 }
 
 
-static ssize_t show_ro(struct device *dev, char *buf)
+static ssize_t show_ro(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lun	*curlun = dev_to_lun(dev);
 
 	return sprintf(buf, "%d\n", curlun->ro);
 }
 
-static ssize_t show_file(struct device *dev, char *buf)
+static ssize_t show_file(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lun	*curlun = dev_to_lun(dev);
 	struct fsg_dev	*fsg = (struct fsg_dev *) dev_get_drvdata(dev);
@@ -3589,7 +3589,7 @@ static ssize_t show_file(struct device *
 }
 
 
-static ssize_t store_ro(struct device *dev, const char *buf, size_t count)
+static ssize_t store_ro(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	ssize_t		rc = count;
 	struct lun	*curlun = dev_to_lun(dev);
@@ -3613,7 +3613,7 @@ static ssize_t store_ro(struct device *d
 	return rc;
 }
 
-static ssize_t store_file(struct device *dev, const char *buf, size_t count)
+static ssize_t store_file(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct lun	*curlun = dev_to_lun(dev);
 	struct fsg_dev	*fsg = (struct fsg_dev *) dev_get_drvdata(dev);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/net2280.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/usb/gadget/net2280.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/net2280.c	2005-05-16 20:35:44.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/usb/gadget/net2280.c	2005-05-16 23:45:53.000000000 -0400
@@ -1469,7 +1469,7 @@ static const struct usb_gadget_ops net22
 
 /* "function" sysfs attribute */
 static ssize_t
-show_function (struct device *_dev, char *buf)
+show_function (struct device *_dev, struct device_attribute *attr, char *buf)
 {
 	struct net2280	*dev = dev_get_drvdata (_dev);
 
@@ -1482,7 +1482,7 @@ show_function (struct device *_dev, char
 static DEVICE_ATTR (function, S_IRUGO, show_function, NULL);
 
 static ssize_t
-show_registers (struct device *_dev, char *buf)
+show_registers (struct device *_dev, struct device_attribute *attr, char *buf)
 {
 	struct net2280		*dev;
 	char			*next;
@@ -1637,7 +1637,7 @@ show_registers (struct device *_dev, cha
 static DEVICE_ATTR (registers, S_IRUGO, show_registers, NULL);
 
 static ssize_t
-show_queues (struct device *_dev, char *buf)
+show_queues (struct device *_dev, struct device_attribute *attr, char *buf)
 {
 	struct net2280		*dev;
 	char			*next;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/pxa2xx_udc.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/usb/gadget/pxa2xx_udc.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/pxa2xx_udc.c	2005-05-16 20:35:44.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/usb/gadget/pxa2xx_udc.c	2005-05-16 23:45:53.000000000 -0400
@@ -1429,7 +1429,7 @@ done:
 
 /* "function" sysfs attribute */
 static ssize_t
-show_function (struct device *_dev, char *buf)
+show_function (struct device *_dev, struct device_attribute *attr, char *buf)
 {
 	struct pxa2xx_udc	*dev = dev_get_drvdata (_dev);
 


------=_Part_288_11694303.1116326617355--
