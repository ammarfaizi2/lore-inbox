Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVENJ7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVENJ7o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 05:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVENJ7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 05:59:37 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:37838 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262727AbVENJcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 05:32:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=pJ7Du1yqmOqD0bg5P7GdbE0UVY9sFJ1130QkwWQcMrkQDiJQ1axwM4AikmyFVahTHqGf2S9bUX8S1zUjIVLZT7QMPK2LgEJWKXhxZac6stQr07d8iWSt3p5cVLfWwX+tW08e3NaXII1El33wkdHbSogs3SxzvTAyrMQ+KwCD/nQ=
Message-ID: <25381867050514023264995e15@mail.gmail.com>
Date: Sat, 14 May 2005 05:32:50 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4 10/12] drivers/s390/scsi/zfcp_sysfs_adapter.c - drivers/usb/input/aiptek.c: (dynamic sysfs callbacks) update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1447_32855453.1116063170875"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1447_32855453.1116063170875
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_1447_32855453.1116063170875
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.6.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.6.diff.diffstat.txt"

 s390/scsi/zfcp_sysfs_adapter.c   |   10 ++---
 s390/scsi/zfcp_sysfs_port.c      |   10 ++---
 s390/scsi/zfcp_sysfs_unit.c      |    6 +--
 scsi/53c700.c                    |    2 -
 scsi/arm/eesox.c                 |    4 +-
 scsi/arm/powertec.c              |    4 +-
 scsi/ipr.c                       |    2 -
 scsi/megaraid/megaraid_mbox.c    |    4 +-
 scsi/scsi_sysfs.c                |   28 +++++++-------
 sh/superhyway/superhyway-sysfs.c |    2 -
 usb/core/sysfs.c                 |   24 ++++++------
 usb/gadget/dummy_hcd.c           |    4 +-
 usb/gadget/file_storage.c        |    8 ++--
 usb/gadget/net2280.c             |    6 +--
 usb/gadget/pxa2xx_udc.c          |    2 -
 usb/input/aiptek.c               |   78 +++++++++++++++++++--------------------
 16 files changed, 97 insertions(+), 97 deletions(-)

------=_Part_1447_32855453.1116063170875
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.6.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.6.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_sysfs_adapter.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/scsi/zfcp_sysfs_adapter.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_sysfs_adapter.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/scsi/zfcp_sysfs_adapter.c	2005-05-11 00:33:16.000000000 -0400
@@ -51,7 +51,7 @@ static const char fc_topologies[5][25] =
  */
 #define ZFCP_DEFINE_ADAPTER_ATTR(_name, _format, _value)                      \
 static ssize_t zfcp_sysfs_adapter_##_name##_show(struct device *dev,          \
-						 char *buf)                   \
+						 char *buf, void *private)                   \
 {                                                                             \
 	struct zfcp_adapter *adapter;                                         \
                                                                               \
@@ -90,7 +90,7 @@ ZFCP_DEFINE_ADAPTER_ATTR(in_recovery, "%
  * Store function of the "port_add" attribute of an adapter.
  */
 static ssize_t
-zfcp_sysfs_port_add_store(struct device *dev, const char *buf, size_t count)
+zfcp_sysfs_port_add_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	wwn_t wwpn;
 	char *endp;
@@ -135,7 +135,7 @@ static DEVICE_ATTR(port_add, S_IWUSR, NU
  * Store function of the "port_remove" attribute of an adapter.
  */
 static ssize_t
-zfcp_sysfs_port_remove_store(struct device *dev, const char *buf, size_t count)
+zfcp_sysfs_port_remove_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct zfcp_adapter *adapter;
 	struct zfcp_port *port;
@@ -197,7 +197,7 @@ static DEVICE_ATTR(port_remove, S_IWUSR,
  */
 static ssize_t
 zfcp_sysfs_adapter_failed_store(struct device *dev,
-				const char *buf, size_t count)
+				const char *buf, size_t count, void *private)
 {
 	struct zfcp_adapter *adapter;
 	unsigned int val;
@@ -236,7 +236,7 @@ zfcp_sysfs_adapter_failed_store(struct d
  * "0" if adapter is working, otherwise "1".
  */
 static ssize_t
-zfcp_sysfs_adapter_failed_show(struct device *dev, char *buf)
+zfcp_sysfs_adapter_failed_show(struct device *dev, char *buf, void *private)
 {
 	struct zfcp_adapter *adapter;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_sysfs_port.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/scsi/zfcp_sysfs_port.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_sysfs_port.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/scsi/zfcp_sysfs_port.c	2005-05-11 00:33:16.000000000 -0400
@@ -54,7 +54,7 @@ zfcp_sysfs_port_release(struct device *d
  */
 #define ZFCP_DEFINE_PORT_ATTR(_name, _format, _value)                    \
 static ssize_t zfcp_sysfs_port_##_name##_show(struct device *dev,        \
-                                              char *buf)                 \
+                                              char *buf, void *private)                 \
 {                                                                        \
         struct zfcp_port *port;                                          \
                                                                          \
@@ -82,7 +82,7 @@ ZFCP_DEFINE_PORT_ATTR(access_denied, "%d
  * Store function of the "unit_add" attribute of a port.
  */
 static ssize_t
-zfcp_sysfs_unit_add_store(struct device *dev, const char *buf, size_t count)
+zfcp_sysfs_unit_add_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	fcp_lun_t fcp_lun;
 	char *endp;
@@ -125,7 +125,7 @@ static DEVICE_ATTR(unit_add, S_IWUSR, NU
  * @count: number of bytes in buffer
  */
 static ssize_t
-zfcp_sysfs_unit_remove_store(struct device *dev, const char *buf, size_t count)
+zfcp_sysfs_unit_remove_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct zfcp_port *port;
 	struct zfcp_unit *unit;
@@ -186,7 +186,7 @@ static DEVICE_ATTR(unit_remove, S_IWUSR,
  * started for the belonging port.
  */
 static ssize_t
-zfcp_sysfs_port_failed_store(struct device *dev, const char *buf, size_t count)
+zfcp_sysfs_port_failed_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct zfcp_port *port;
 	unsigned int val;
@@ -224,7 +224,7 @@ zfcp_sysfs_port_failed_store(struct devi
  * "0" if port is working, otherwise "1".
  */
 static ssize_t
-zfcp_sysfs_port_failed_show(struct device *dev, char *buf)
+zfcp_sysfs_port_failed_show(struct device *dev, char *buf, void *private)
 {
 	struct zfcp_port *port;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_sysfs_unit.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/scsi/zfcp_sysfs_unit.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_sysfs_unit.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/scsi/zfcp_sysfs_unit.c	2005-05-11 00:33:16.000000000 -0400
@@ -54,7 +54,7 @@ zfcp_sysfs_unit_release(struct device *d
  */
 #define ZFCP_DEFINE_UNIT_ATTR(_name, _format, _value)                    \
 static ssize_t zfcp_sysfs_unit_##_name##_show(struct device *dev,        \
-                                              char *buf)                 \
+                                              char *buf, void *private)                 \
 {                                                                        \
         struct zfcp_unit *unit;                                          \
                                                                          \
@@ -86,7 +86,7 @@ ZFCP_DEFINE_UNIT_ATTR(access_readonly, "
  * started for the belonging unit.
  */
 static ssize_t
-zfcp_sysfs_unit_failed_store(struct device *dev, const char *buf, size_t count)
+zfcp_sysfs_unit_failed_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct zfcp_unit *unit;
 	unsigned int val;
@@ -123,7 +123,7 @@ zfcp_sysfs_unit_failed_store(struct devi
  * "0" if unit is working, otherwise "1".
  */
 static ssize_t
-zfcp_sysfs_unit_failed_show(struct device *dev, char *buf)
+zfcp_sysfs_unit_failed_show(struct device *dev, char *buf, void *private)
 {
 	struct zfcp_unit *unit;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/53c700.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/scsi/53c700.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/53c700.c	2005-05-11 00:28:11.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/scsi/53c700.c	2005-05-11 00:33:23.000000000 -0400
@@ -2125,7 +2125,7 @@ static int NCR_700_change_queue_type(str
 }
 
 static ssize_t
-NCR_700_show_active_tags(struct device *dev, char *buf)
+NCR_700_show_active_tags(struct device *dev, char *buf, void *private)
 {
 	struct scsi_device *SDp = to_scsi_device(dev);
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/arm/eesox.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/scsi/arm/eesox.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/arm/eesox.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/scsi/arm/eesox.c	2005-05-11 00:33:17.000000000 -0400
@@ -466,7 +466,7 @@ int eesoxscsi_proc_info(struct Scsi_Host
 	return pos;
 }
 
-static ssize_t eesoxscsi_show_term(struct device *dev, char *buf)
+static ssize_t eesoxscsi_show_term(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	struct Scsi_Host *host = ecard_get_drvdata(ec);
@@ -475,7 +475,7 @@ static ssize_t eesoxscsi_show_term(struc
 	return sprintf(buf, "%d\n", info->control & EESOX_TERM_ENABLE ? 1 : 0);
 }
 
-static ssize_t eesoxscsi_store_term(struct device *dev, const char *buf, size_t len)
+static ssize_t eesoxscsi_store_term(struct device *dev, const char *buf, size_t len, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	struct Scsi_Host *host = ecard_get_drvdata(ec);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/arm/powertec.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/scsi/arm/powertec.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/arm/powertec.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/scsi/arm/powertec.c	2005-05-11 00:33:17.000000000 -0400
@@ -269,7 +269,7 @@ int powertecscsi_proc_info(struct Scsi_H
 	return pos;
 }
 
-static ssize_t powertecscsi_show_term(struct device *dev, char *buf)
+static ssize_t powertecscsi_show_term(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	struct Scsi_Host *host = ecard_get_drvdata(ec);
@@ -279,7 +279,7 @@ static ssize_t powertecscsi_show_term(st
 }
 
 static ssize_t
-powertecscsi_store_term(struct device *dev, const char *buf, size_t len)
+powertecscsi_store_term(struct device *dev, const char *buf, size_t len, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	struct Scsi_Host *host = ecard_get_drvdata(ec);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/ipr.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/scsi/ipr.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/ipr.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/scsi/ipr.c	2005-05-11 00:33:19.000000000 -0400
@@ -2716,7 +2716,7 @@ static int ipr_change_queue_type(struct 
  * Return value:
  * 	number of bytes printed to buffer
  **/
-static ssize_t ipr_show_adapter_handle(struct device *dev, char *buf)
+static ssize_t ipr_show_adapter_handle(struct device *dev, char *buf, void *private)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)sdev->host->hostdata;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/megaraid/megaraid_mbox.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/scsi/megaraid/megaraid_mbox.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/megaraid/megaraid_mbox.c	2005-05-11 00:28:11.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/scsi/megaraid/megaraid_mbox.c	2005-05-11 00:33:24.000000000 -0400
@@ -124,7 +124,7 @@ static irqreturn_t megaraid_isr(int, voi
 static void megaraid_mbox_dpc(unsigned long);
 
 static ssize_t megaraid_sysfs_show_app_hndl(struct class_device *, char *);
-static ssize_t megaraid_sysfs_show_ldnum(struct device *, char *);
+static ssize_t megaraid_sysfs_show_ldnum(struct device *, char *, void *private);
 
 static int megaraid_cmm_register(adapter_t *);
 static int megaraid_cmm_unregister(adapter_t *);
@@ -4213,7 +4213,7 @@ megaraid_sysfs_show_app_hndl(struct clas
  * @param buf	: buffer to send data to
  */
 static ssize_t
-megaraid_sysfs_show_ldnum(struct device *dev, char *buf)
+megaraid_sysfs_show_ldnum(struct device *dev, char *buf, void *private)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 	adapter_t	*adapter = (adapter_t *)SCSIHOST2ADAP(sdev->host);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/scsi_sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/scsi/scsi_sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/scsi/scsi_sysfs.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/scsi/scsi_sysfs.c	2005-05-11 00:33:21.000000000 -0400
@@ -230,7 +230,7 @@ void scsi_sysfs_unregister(void)
  */
 #define sdev_show_function(field, format_string)				\
 static ssize_t								\
-sdev_show_##field (struct device *dev, char *buf)				\
+sdev_show_##field (struct device *dev, char *buf, void *private)				\
 {									\
 	struct scsi_device *sdev;					\
 	sdev = to_scsi_device(dev);					\
@@ -254,7 +254,7 @@ static DEVICE_ATTR(field, S_IRUGO, sdev_
 	sdev_show_function(field, format_string)				\
 									\
 static ssize_t								\
-sdev_store_##field (struct device *dev, const char *buf, size_t count)	\
+sdev_store_##field (struct device *dev, const char *buf, size_t count, void *private)	\
 {									\
 	struct scsi_device *sdev;					\
 	sdev = to_scsi_device(dev);					\
@@ -274,7 +274,7 @@ static DEVICE_ATTR(field, S_IRUGO | S_IW
 	sdev_show_function(field, "%d\n")					\
 									\
 static ssize_t								\
-sdev_store_##field (struct device *dev, const char *buf, size_t count)	\
+sdev_store_##field (struct device *dev, const char *buf, size_t count, void *private)	\
 {									\
 	int ret;							\
 	struct scsi_device *sdev;					\
@@ -317,7 +317,7 @@ sdev_rd_attr (model, "%.16s\n");
 sdev_rd_attr (rev, "%.4s\n");
 
 static ssize_t
-sdev_show_timeout (struct device *dev, char *buf)
+sdev_show_timeout (struct device *dev, char *buf, void *private)
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
@@ -325,7 +325,7 @@ sdev_show_timeout (struct device *dev, c
 }
 
 static ssize_t
-sdev_store_timeout (struct device *dev, const char *buf, size_t count)
+sdev_store_timeout (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct scsi_device *sdev;
 	int timeout;
@@ -337,7 +337,7 @@ sdev_store_timeout (struct device *dev, 
 static DEVICE_ATTR(timeout, S_IRUGO | S_IWUSR, sdev_show_timeout, sdev_store_timeout);
 
 static ssize_t
-store_rescan_field (struct device *dev, const char *buf, size_t count) 
+store_rescan_field (struct device *dev, const char *buf, size_t count, void *private) 
 {
 	scsi_rescan_device(dev);
 	return count;
@@ -345,7 +345,7 @@ store_rescan_field (struct device *dev, 
 static DEVICE_ATTR(rescan, S_IWUSR, NULL, store_rescan_field);
 
 static ssize_t sdev_store_delete(struct device *dev, const char *buf,
-				 size_t count)
+				 size_t count, void *private)
 {
 	scsi_remove_device(to_scsi_device(dev));
 	return count;
@@ -353,7 +353,7 @@ static ssize_t sdev_store_delete(struct 
 static DEVICE_ATTR(delete, S_IWUSR, NULL, sdev_store_delete);
 
 static ssize_t
-store_state_field(struct device *dev, const char *buf, size_t count)
+store_state_field(struct device *dev, const char *buf, size_t count, void *private)
 {
 	int i;
 	struct scsi_device *sdev = to_scsi_device(dev);
@@ -376,7 +376,7 @@ store_state_field(struct device *dev, co
 }
 
 static ssize_t
-show_state_field(struct device *dev, char *buf)
+show_state_field(struct device *dev, char *buf, void *private)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 	const char *name = scsi_device_state_name(sdev->sdev_state);
@@ -390,7 +390,7 @@ show_state_field(struct device *dev, cha
 static DEVICE_ATTR(state, S_IRUGO | S_IWUSR, show_state_field, store_state_field);
 
 static ssize_t
-show_queue_type_field(struct device *dev, char *buf)
+show_queue_type_field(struct device *dev, char *buf, void *private)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 	const char *name = "none";
@@ -406,7 +406,7 @@ show_queue_type_field(struct device *dev
 static DEVICE_ATTR(queue_type, S_IRUGO, show_queue_type_field, NULL);
 
 static ssize_t
-show_iostat_counterbits(struct device *dev, char *buf)
+show_iostat_counterbits(struct device *dev, char *buf, void *private)
 {
 	return snprintf(buf, 20, "%d\n", (int)sizeof(atomic_t) * 8);
 }
@@ -415,7 +415,7 @@ static DEVICE_ATTR(iocounterbits, S_IRUG
 
 #define show_sdev_iostat(field)						\
 static ssize_t								\
-show_iostat_##field(struct device *dev, char *buf)			\
+show_iostat_##field(struct device *dev, char *buf, void *private)			\
 {									\
 	struct scsi_device *sdev = to_scsi_device(dev);			\
 	unsigned long long count = atomic_read(&sdev->field);		\
@@ -450,7 +450,7 @@ static struct device_attribute *scsi_sys
 };
 
 static ssize_t sdev_store_queue_depth_rw(struct device *dev, const char *buf,
-					 size_t count)
+					 size_t count, void *private)
 {
 	int depth, retval;
 	struct scsi_device *sdev = to_scsi_device(dev);
@@ -476,7 +476,7 @@ static struct device_attribute sdev_attr
 	       sdev_store_queue_depth_rw);
 
 static ssize_t sdev_store_queue_type_rw(struct device *dev, const char *buf,
-					size_t count)
+					size_t count, void *private)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct scsi_host_template *sht = sdev->host->hostt;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/sh/superhyway/superhyway-sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/sh/superhyway/superhyway-sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/sh/superhyway/superhyway-sysfs.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/sh/superhyway/superhyway-sysfs.c	2005-05-11 00:32:22.000000000 -0400
@@ -15,7 +15,7 @@
 #include <linux/superhyway.h>
 
 #define superhyway_ro_attr(name, fmt, field)				\
-static ssize_t name##_show(struct device *dev, char *buf)		\
+static ssize_t name##_show(struct device *dev, char *buf, void *private)		\
 {									\
 	struct superhyway_device *s = to_superhyway_device(dev);	\
 	return sprintf(buf, fmt, s->field);				\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/core/sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/core/sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/core/sysfs.c	2005-05-11 00:28:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/core/sysfs.c	2005-05-11 00:32:49.000000000 -0400
@@ -24,7 +24,7 @@
 
 /* Active configuration fields */
 #define usb_actconfig_show(field, multiplier, format_string)		\
-static ssize_t  show_##field (struct device *dev, char *buf)		\
+static ssize_t  show_##field (struct device *dev, char *buf, void *private)		\
 {									\
 	struct usb_device *udev;					\
 	struct usb_host_config *actconfig;				\
@@ -46,7 +46,7 @@ usb_actconfig_attr (bNumInterfaces, 1, "
 usb_actconfig_attr (bmAttributes, 1, "%2x\n")
 usb_actconfig_attr (bMaxPower, 2, "%3dmA\n")
 
-static ssize_t show_configuration_string(struct device *dev, char *buf)
+static ssize_t show_configuration_string(struct device *dev, char *buf, void *private)
 {
 	struct usb_device *udev;
 	struct usb_host_config *actconfig;
@@ -69,7 +69,7 @@ static DEVICE_ATTR(configuration, S_IRUG
 usb_actconfig_show(bConfigurationValue, 1, "%u\n");
 
 static ssize_t
-set_bConfigurationValue (struct device *dev, const char *buf, size_t count)
+set_bConfigurationValue (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct usb_device	*udev = udev = to_usb_device (dev);
 	int			config, value;
@@ -87,7 +87,7 @@ static DEVICE_ATTR(bConfigurationValue, 
 
 /* String fields */
 #define usb_string_attr(name)						\
-static ssize_t  show_##name(struct device *dev, char *buf)		\
+static ssize_t  show_##name(struct device *dev, char *buf, void *private)		\
 {									\
 	struct usb_device *udev;					\
 	int len;							\
@@ -107,7 +107,7 @@ usb_string_attr(manufacturer);
 usb_string_attr(serial);
 
 static ssize_t
-show_speed (struct device *dev, char *buf)
+show_speed (struct device *dev, char *buf, void *private)
 {
 	struct usb_device *udev;
 	char *speed;
@@ -133,7 +133,7 @@ show_speed (struct device *dev, char *bu
 static DEVICE_ATTR(speed, S_IRUGO, show_speed, NULL);
 
 static ssize_t
-show_devnum (struct device *dev, char *buf)
+show_devnum (struct device *dev, char *buf, void *private)
 {
 	struct usb_device *udev;
 
@@ -143,7 +143,7 @@ show_devnum (struct device *dev, char *b
 static DEVICE_ATTR(devnum, S_IRUGO, show_devnum, NULL);
 
 static ssize_t
-show_version (struct device *dev, char *buf)
+show_version (struct device *dev, char *buf, void *private)
 {
 	struct usb_device *udev;
 	u16 bcdUSB;
@@ -155,7 +155,7 @@ show_version (struct device *dev, char *
 static DEVICE_ATTR(version, S_IRUGO, show_version, NULL);
 
 static ssize_t
-show_maxchild (struct device *dev, char *buf)
+show_maxchild (struct device *dev, char *buf, void *private)
 {
 	struct usb_device *udev;
 
@@ -167,7 +167,7 @@ static DEVICE_ATTR(maxchild, S_IRUGO, sh
 /* Descriptor fields */
 #define usb_descriptor_attr_le16(field, format_string)			\
 static ssize_t								\
-show_##field (struct device *dev, char *buf)				\
+show_##field (struct device *dev, char *buf, void *private)				\
 {									\
 	struct usb_device *udev;					\
 									\
@@ -183,7 +183,7 @@ usb_descriptor_attr_le16(bcdDevice, "%04
 
 #define usb_descriptor_attr(field, format_string)			\
 static ssize_t								\
-show_##field (struct device *dev, char *buf)				\
+show_##field (struct device *dev, char *buf, void *private)				\
 {									\
 	struct usb_device *udev;					\
 									\
@@ -254,7 +254,7 @@ void usb_remove_sysfs_dev_files (struct 
 /* Interface fields */
 #define usb_intf_attr(field, format_string)				\
 static ssize_t								\
-show_##field (struct device *dev, char *buf)				\
+show_##field (struct device *dev, char *buf, void *private)				\
 {									\
 	struct usb_interface *intf = to_usb_interface (dev);		\
 									\
@@ -269,7 +269,7 @@ usb_intf_attr (bInterfaceClass, "%02x\n"
 usb_intf_attr (bInterfaceSubClass, "%02x\n")
 usb_intf_attr (bInterfaceProtocol, "%02x\n")
 
-static ssize_t show_interface_string(struct device *dev, char *buf)
+static ssize_t show_interface_string(struct device *dev, char *buf, void *private)
 {
 	struct usb_interface *intf;
 	struct usb_device *udev;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/dummy_hcd.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/gadget/dummy_hcd.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/dummy_hcd.c	2005-05-11 00:28:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/gadget/dummy_hcd.c	2005-05-11 00:32:56.000000000 -0400
@@ -633,7 +633,7 @@ static const struct usb_gadget_ops dummy
 
 /* "function" sysfs attribute */
 static ssize_t
-show_function (struct device *dev, char *buf)
+show_function (struct device *dev, char *buf, void *private)
 {
 	struct dummy	*dum = gadget_dev_to_dummy (dev);
 
@@ -1600,7 +1600,7 @@ show_urb (char *buf, size_t size, struct
 }
 
 static ssize_t
-show_urbs (struct device *dev, char *buf)
+show_urbs (struct device *dev, char *buf, void *private)
 {
 	struct usb_hcd		*hcd = dev_get_drvdata (dev);
 	struct dummy		*dum = hcd_to_dummy (hcd);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/file_storage.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/gadget/file_storage.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/file_storage.c	2005-05-11 00:28:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/gadget/file_storage.c	2005-05-11 00:32:56.000000000 -0400
@@ -3554,14 +3554,14 @@ static void close_all_backing_files(stru
 }
 
 
-static ssize_t show_ro(struct device *dev, char *buf)
+static ssize_t show_ro(struct device *dev, char *buf, void *private)
 {
 	struct lun	*curlun = dev_to_lun(dev);
 
 	return sprintf(buf, "%d\n", curlun->ro);
 }
 
-static ssize_t show_file(struct device *dev, char *buf)
+static ssize_t show_file(struct device *dev, char *buf, void *private)
 {
 	struct lun	*curlun = dev_to_lun(dev);
 	struct fsg_dev	*fsg = (struct fsg_dev *) dev_get_drvdata(dev);
@@ -3589,7 +3589,7 @@ static ssize_t show_file(struct device *
 }
 
 
-static ssize_t store_ro(struct device *dev, const char *buf, size_t count)
+static ssize_t store_ro(struct device *dev, const char *buf, size_t count, void *private)
 {
 	ssize_t		rc = count;
 	struct lun	*curlun = dev_to_lun(dev);
@@ -3613,7 +3613,7 @@ static ssize_t store_ro(struct device *d
 	return rc;
 }
 
-static ssize_t store_file(struct device *dev, const char *buf, size_t count)
+static ssize_t store_file(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct lun	*curlun = dev_to_lun(dev);
 	struct fsg_dev	*fsg = (struct fsg_dev *) dev_get_drvdata(dev);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/net2280.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/gadget/net2280.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/net2280.c	2005-05-11 00:28:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/gadget/net2280.c	2005-05-11 00:32:56.000000000 -0400
@@ -1469,7 +1469,7 @@ static const struct usb_gadget_ops net22
 
 /* "function" sysfs attribute */
 static ssize_t
-show_function (struct device *_dev, char *buf)
+show_function (struct device *_dev, char *buf, void *private)
 {
 	struct net2280	*dev = dev_get_drvdata (_dev);
 
@@ -1482,7 +1482,7 @@ show_function (struct device *_dev, char
 static DEVICE_ATTR (function, S_IRUGO, show_function, NULL);
 
 static ssize_t
-show_registers (struct device *_dev, char *buf)
+show_registers (struct device *_dev, char *buf, void *private)
 {
 	struct net2280		*dev;
 	char			*next;
@@ -1637,7 +1637,7 @@ show_registers (struct device *_dev, cha
 static DEVICE_ATTR (registers, S_IRUGO, show_registers, NULL);
 
 static ssize_t
-show_queues (struct device *_dev, char *buf)
+show_queues (struct device *_dev, char *buf, void *private)
 {
 	struct net2280		*dev;
 	char			*next;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/pxa2xx_udc.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/gadget/pxa2xx_udc.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/gadget/pxa2xx_udc.c	2005-05-11 00:28:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/gadget/pxa2xx_udc.c	2005-05-11 00:32:56.000000000 -0400
@@ -1429,7 +1429,7 @@ done:
 
 /* "function" sysfs attribute */
 static ssize_t
-show_function (struct device *_dev, char *buf)
+show_function (struct device *_dev, char *buf, void *private)
 {
 	struct pxa2xx_udc	*dev = dev_get_drvdata (_dev);
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/input/aiptek.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/input/aiptek.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/input/aiptek.c	2005-05-11 00:28:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/input/aiptek.c	2005-05-11 00:32:53.000000000 -0400
@@ -1025,7 +1025,7 @@ static int aiptek_program_tablet(struct 
 /***********************************************************************
  * support the 'size' file -- display support
  */
-static ssize_t show_tabletSize(struct device *dev, char *buf)
+static ssize_t show_tabletSize(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1048,7 +1048,7 @@ static DEVICE_ATTR(size, S_IRUGO, show_t
 /***********************************************************************
  * support routines for the 'product_id' file
  */
-static ssize_t show_tabletProductId(struct device *dev, char *buf)
+static ssize_t show_tabletProductId(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1064,7 +1064,7 @@ static DEVICE_ATTR(product_id, S_IRUGO, 
 /***********************************************************************
  * support routines for the 'vendor_id' file
  */
-static ssize_t show_tabletVendorId(struct device *dev, char *buf)
+static ssize_t show_tabletVendorId(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1079,7 +1079,7 @@ static DEVICE_ATTR(vendor_id, S_IRUGO, s
 /***********************************************************************
  * support routines for the 'vendor' file
  */
-static ssize_t show_tabletManufacturer(struct device *dev, char *buf)
+static ssize_t show_tabletManufacturer(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	int retval;
@@ -1096,7 +1096,7 @@ static DEVICE_ATTR(vendor, S_IRUGO, show
 /***********************************************************************
  * support routines for the 'product' file
  */
-static ssize_t show_tabletProduct(struct device *dev, char *buf)
+static ssize_t show_tabletProduct(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	int retval;
@@ -1114,7 +1114,7 @@ static DEVICE_ATTR(product, S_IRUGO, sho
  * support routines for the 'pointer_mode' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletPointerMode(struct device *dev, char *buf)
+static ssize_t show_tabletPointerMode(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1143,7 +1143,7 @@ static ssize_t show_tabletPointerMode(st
 }
 
 static ssize_t
-store_tabletPointerMode(struct device *dev, const char *buf, size_t count)
+store_tabletPointerMode(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	if (aiptek == NULL)
@@ -1168,7 +1168,7 @@ static DEVICE_ATTR(pointer_mode,
  * support routines for the 'coordinate_mode' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletCoordinateMode(struct device *dev, char *buf)
+static ssize_t show_tabletCoordinateMode(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1193,7 +1193,7 @@ static ssize_t show_tabletCoordinateMode
 }
 
 static ssize_t
-store_tabletCoordinateMode(struct device *dev, const char *buf, size_t count)
+store_tabletCoordinateMode(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	if (aiptek == NULL)
@@ -1217,7 +1217,7 @@ static DEVICE_ATTR(coordinate_mode,
  * support routines for the 'tool_mode' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletToolMode(struct device *dev, char *buf)
+static ssize_t show_tabletToolMode(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1262,7 +1262,7 @@ static ssize_t show_tabletToolMode(struc
 }
 
 static ssize_t
-store_tabletToolMode(struct device *dev, const char *buf, size_t count)
+store_tabletToolMode(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	if (aiptek == NULL)
@@ -1295,7 +1295,7 @@ static DEVICE_ATTR(tool_mode,
  * support routines for the 'xtilt' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletXtilt(struct device *dev, char *buf)
+static ssize_t show_tabletXtilt(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1311,7 +1311,7 @@ static ssize_t show_tabletXtilt(struct d
 }
 
 static ssize_t
-store_tabletXtilt(struct device *dev, const char *buf, size_t count)
+store_tabletXtilt(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	int x;
@@ -1337,7 +1337,7 @@ static DEVICE_ATTR(xtilt,
  * support routines for the 'ytilt' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletYtilt(struct device *dev, char *buf)
+static ssize_t show_tabletYtilt(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1353,7 +1353,7 @@ static ssize_t show_tabletYtilt(struct d
 }
 
 static ssize_t
-store_tabletYtilt(struct device *dev, const char *buf, size_t count)
+store_tabletYtilt(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	int y;
@@ -1379,7 +1379,7 @@ static DEVICE_ATTR(ytilt,
  * support routines for the 'jitter' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletJitterDelay(struct device *dev, char *buf)
+static ssize_t show_tabletJitterDelay(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1390,7 +1390,7 @@ static ssize_t show_tabletJitterDelay(st
 }
 
 static ssize_t
-store_tabletJitterDelay(struct device *dev, const char *buf, size_t count)
+store_tabletJitterDelay(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1409,7 +1409,7 @@ static DEVICE_ATTR(jitter,
  * support routines for the 'delay' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletProgrammableDelay(struct device *dev, char *buf)
+static ssize_t show_tabletProgrammableDelay(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1421,7 +1421,7 @@ static ssize_t show_tabletProgrammableDe
 }
 
 static ssize_t
-store_tabletProgrammableDelay(struct device *dev, const char *buf, size_t count)
+store_tabletProgrammableDelay(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1440,7 +1440,7 @@ static DEVICE_ATTR(delay,
  * support routines for the 'input_path' file. Note that this file
  * only displays current setting.
  */
-static ssize_t show_tabletInputDevice(struct device *dev, char *buf)
+static ssize_t show_tabletInputDevice(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1457,7 +1457,7 @@ static DEVICE_ATTR(input_path, S_IRUGO, 
  * support routines for the 'event_count' file. Note that this file
  * only displays current setting.
  */
-static ssize_t show_tabletEventsReceived(struct device *dev, char *buf)
+static ssize_t show_tabletEventsReceived(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1473,7 +1473,7 @@ static DEVICE_ATTR(event_count, S_IRUGO,
  * support routines for the 'diagnostic' file. Note that this file
  * only displays current setting.
  */
-static ssize_t show_tabletDiagnosticMessage(struct device *dev, char *buf)
+static ssize_t show_tabletDiagnosticMessage(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *retMsg;
@@ -1515,7 +1515,7 @@ static DEVICE_ATTR(diagnostic, S_IRUGO, 
  * support routines for the 'stylus_upper' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletStylusUpper(struct device *dev, char *buf)
+static ssize_t show_tabletStylusUpper(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1540,7 +1540,7 @@ static ssize_t show_tabletStylusUpper(st
 }
 
 static ssize_t
-store_tabletStylusUpper(struct device *dev, const char *buf, size_t count)
+store_tabletStylusUpper(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1565,7 +1565,7 @@ static DEVICE_ATTR(stylus_upper,
  * support routines for the 'stylus_lower' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletStylusLower(struct device *dev, char *buf)
+static ssize_t show_tabletStylusLower(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1590,7 +1590,7 @@ static ssize_t show_tabletStylusLower(st
 }
 
 static ssize_t
-store_tabletStylusLower(struct device *dev, const char *buf, size_t count)
+store_tabletStylusLower(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1615,7 +1615,7 @@ static DEVICE_ATTR(stylus_lower,
  * support routines for the 'mouse_left' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletMouseLeft(struct device *dev, char *buf)
+static ssize_t show_tabletMouseLeft(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1644,7 +1644,7 @@ static ssize_t show_tabletMouseLeft(stru
 }
 
 static ssize_t
-store_tabletMouseLeft(struct device *dev, const char *buf, size_t count)
+store_tabletMouseLeft(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1669,7 +1669,7 @@ static DEVICE_ATTR(mouse_left,
  * support routines for the 'mouse_middle' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletMouseMiddle(struct device *dev, char *buf)
+static ssize_t show_tabletMouseMiddle(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1698,7 +1698,7 @@ static ssize_t show_tabletMouseMiddle(st
 }
 
 static ssize_t
-store_tabletMouseMiddle(struct device *dev, const char *buf, size_t count)
+store_tabletMouseMiddle(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1725,7 +1725,7 @@ static DEVICE_ATTR(mouse_middle,
  * support routines for the 'mouse_right' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletMouseRight(struct device *dev, char *buf)
+static ssize_t show_tabletMouseRight(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1754,7 +1754,7 @@ static ssize_t show_tabletMouseRight(str
 }
 
 static ssize_t
-store_tabletMouseRight(struct device *dev, const char *buf, size_t count)
+store_tabletMouseRight(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1780,7 +1780,7 @@ static DEVICE_ATTR(mouse_right,
  * support routines for the 'wheel' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletWheel(struct device *dev, char *buf)
+static ssize_t show_tabletWheel(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1796,7 +1796,7 @@ static ssize_t show_tabletWheel(struct d
 }
 
 static ssize_t
-store_tabletWheel(struct device *dev, const char *buf, size_t count)
+store_tabletWheel(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1814,7 +1814,7 @@ static DEVICE_ATTR(wheel,
  * support routines for the 'execute' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletExecute(struct device *dev, char *buf)
+static ssize_t show_tabletExecute(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1829,7 +1829,7 @@ static ssize_t show_tabletExecute(struct
 }
 
 static ssize_t
-store_tabletExecute(struct device *dev, const char *buf, size_t count)
+store_tabletExecute(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1855,7 +1855,7 @@ static DEVICE_ATTR(execute,
  * support routines for the 'odm_code' file. Note that this file
  * only displays current setting.
  */
-static ssize_t show_tabletODMCode(struct device *dev, char *buf)
+static ssize_t show_tabletODMCode(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1871,7 +1871,7 @@ static DEVICE_ATTR(odm_code, S_IRUGO, sh
  * support routines for the 'model_code' file. Note that this file
  * only displays current setting.
  */
-static ssize_t show_tabletModelCode(struct device *dev, char *buf)
+static ssize_t show_tabletModelCode(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1887,7 +1887,7 @@ static DEVICE_ATTR(model_code, S_IRUGO, 
  * support routines for the 'firmware_code' file. Note that this file
  * only displays current setting.
  */
-static ssize_t show_firmwareCode(struct device *dev, char *buf)
+static ssize_t show_firmwareCode(struct device *dev, char *buf, void *private)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 

------=_Part_1447_32855453.1116063170875--
