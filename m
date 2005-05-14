Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVENJ4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVENJ4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 05:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVENJ4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 05:56:08 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:53832 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262728AbVENJcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 05:32:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=ne++Gu4MC2pBZQd9tPy6ujMP2lWEtEYJQcEpNibMof6uPjrhciCvckpaACX5jVZV0dbBuz7wdpK08CA2tjoZ8enveG5huJ77KcxJRtn81FwO8HZcPpc4g7OJebawrBsDNEA5c2zpDhd/UEF2JSZBDTYe/oDsKqkTIJ8Edx7cde4=
Message-ID: <2538186705051402321221b43b@mail.gmail.com>
Date: Sat, 14 May 2005 05:32:19 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4 9/12] drivers/cio/device.c - drivers/scsi/zfcp_scsi.c: (dynamic sysfs callbacks) update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1443_10671669.1116063139622"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1443_10671669.1116063139622
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_1443_10671669.1116063139622
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.5.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.5.diff.diffstat.txt"

 cio/device.c     |   14 +++---
 net/claw.c       |   40 ++++++++---------
 net/ctcmain.c    |   18 +++----
 net/lcs.c        |   10 ++--
 net/netiucv.c    |   44 +++++++++----------
 net/qeth_sys.c   |  126 +++++++++++++++++++++++++++----------------------------
 scsi/zfcp_scsi.c |    2 
 7 files changed, 127 insertions(+), 127 deletions(-)



------=_Part_1443_10671669.1116063139622
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.5.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.5.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/cio/device.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/cio/device.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/cio/device.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/cio/device.c	2005-05-11 00:33:15.000000000 -0400
@@ -204,7 +204,7 @@ module_exit(cleanup_ccw_bus_type);
  * TODO: Split chpids and pimpampom up? Where is "in use" in the tree?
  */
 static ssize_t
-chpids_show (struct device * dev, char * buf)
+chpids_show (struct device * dev, char * buf, void *private)
 {
 	struct subchannel *sch = to_subchannel(dev);
 	struct ssd_info *ssd = &sch->ssd_info;
@@ -219,7 +219,7 @@ chpids_show (struct device * dev, char *
 }
 
 static ssize_t
-pimpampom_show (struct device * dev, char * buf)
+pimpampom_show (struct device * dev, char * buf, void *private)
 {
 	struct subchannel *sch = to_subchannel(dev);
 	struct pmcw *pmcw = &sch->schib.pmcw;
@@ -229,7 +229,7 @@ pimpampom_show (struct device * dev, cha
 }
 
 static ssize_t
-devtype_show (struct device *dev, char *buf)
+devtype_show (struct device *dev, char *buf, void *private)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 	struct ccw_device_id *id = &(cdev->id);
@@ -242,7 +242,7 @@ devtype_show (struct device *dev, char *
 }
 
 static ssize_t
-cutype_show (struct device *dev, char *buf)
+cutype_show (struct device *dev, char *buf, void *private)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 	struct ccw_device_id *id = &(cdev->id);
@@ -252,7 +252,7 @@ cutype_show (struct device *dev, char *b
 }
 
 static ssize_t
-online_show (struct device *dev, char *buf)
+online_show (struct device *dev, char *buf, void *private)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 
@@ -350,7 +350,7 @@ ccw_device_set_online(struct ccw_device 
 }
 
 static ssize_t
-online_store (struct device *dev, const char *buf, size_t count)
+online_store (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 	int i, force, ret;
@@ -422,7 +422,7 @@ online_store (struct device *dev, const 
 }
 
 static ssize_t
-available_show (struct device *dev, char *buf)
+available_show (struct device *dev, char *buf, void *private)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 	struct subchannel *sch;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/net/claw.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/net/claw.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/net/claw.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/net/claw.c	2005-05-11 00:33:15.000000000 -0400
@@ -241,21 +241,21 @@ static struct sk_buff *claw_pack_skb(str
 static void dumpit (char *buf, int len);
 #endif
 /* sysfs Functions */
-static ssize_t claw_hname_show(struct device *dev, char *buf);
+static ssize_t claw_hname_show(struct device *dev, char *buf, void *private);
 static ssize_t claw_hname_write(struct device *dev,
-	const char *buf, size_t count);
-static ssize_t claw_adname_show(struct device *dev, char *buf);
+	const char *buf, size_t count, void *private);
+static ssize_t claw_adname_show(struct device *dev, char *buf, void *private);
 static ssize_t claw_adname_write(struct device *dev,
-	const char *buf, size_t count);
-static ssize_t claw_apname_show(struct device *dev, char *buf);
+	const char *buf, size_t count, void *private);
+static ssize_t claw_apname_show(struct device *dev, char *buf, void *private);
 static ssize_t claw_apname_write(struct device *dev,
-	const char *buf, size_t count);
-static ssize_t claw_wbuff_show(struct device *dev, char *buf);
+	const char *buf, size_t count, void *private);
+static ssize_t claw_wbuff_show(struct device *dev, char *buf, void *private);
 static ssize_t claw_wbuff_write(struct device *dev,
-	const char *buf, size_t count);
-static ssize_t claw_rbuff_show(struct device *dev, char *buf);
+	const char *buf, size_t count, void *private);
+static ssize_t claw_rbuff_show(struct device *dev, char *buf, void *private);
 static ssize_t claw_rbuff_write(struct device *dev,
-	const char *buf, size_t count);
+	const char *buf, size_t count, void *private);
 static int claw_add_files(struct device *dev);
 static void claw_remove_files(struct device *dev);
 
@@ -4149,7 +4149,7 @@ claw_remove_device(struct ccwgroup_devic
  * sysfs attributes
  */
 static ssize_t
-claw_hname_show(struct device *dev, char *buf)
+claw_hname_show(struct device *dev, char *buf, void *private)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4162,7 +4162,7 @@ claw_hname_show(struct device *dev, char
 }
 
 static ssize_t
-claw_hname_write(struct device *dev, const char *buf, size_t count)
+claw_hname_write(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4186,7 +4186,7 @@ claw_hname_write(struct device *dev, con
 static DEVICE_ATTR(host_name, 0644, claw_hname_show, claw_hname_write);
 
 static ssize_t
-claw_adname_show(struct device *dev, char *buf)
+claw_adname_show(struct device *dev, char *buf, void *private)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4199,7 +4199,7 @@ claw_adname_show(struct device *dev, cha
 }
 
 static ssize_t
-claw_adname_write(struct device *dev, const char *buf, size_t count)
+claw_adname_write(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4223,7 +4223,7 @@ claw_adname_write(struct device *dev, co
 static DEVICE_ATTR(adapter_name, 0644, claw_adname_show, claw_adname_write);
 
 static ssize_t
-claw_apname_show(struct device *dev, char *buf)
+claw_apname_show(struct device *dev, char *buf, void *private)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4237,7 +4237,7 @@ claw_apname_show(struct device *dev, cha
 }
 
 static ssize_t
-claw_apname_write(struct device *dev, const char *buf, size_t count)
+claw_apname_write(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4271,7 +4271,7 @@ claw_apname_write(struct device *dev, co
 static DEVICE_ATTR(api_type, 0644, claw_apname_show, claw_apname_write);
 
 static ssize_t
-claw_wbuff_show(struct device *dev, char *buf)
+claw_wbuff_show(struct device *dev, char *buf, void *private)
 {
 	struct claw_privbk *priv;
 	struct claw_env * p_env;
@@ -4284,7 +4284,7 @@ claw_wbuff_show(struct device *dev, char
 }
 
 static ssize_t
-claw_wbuff_write(struct device *dev, const char *buf, size_t count)
+claw_wbuff_write(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4312,7 +4312,7 @@ claw_wbuff_write(struct device *dev, con
 static DEVICE_ATTR(write_buffer, 0644, claw_wbuff_show, claw_wbuff_write);
 
 static ssize_t
-claw_rbuff_show(struct device *dev, char *buf)
+claw_rbuff_show(struct device *dev, char *buf, void *private)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4325,7 +4325,7 @@ claw_rbuff_show(struct device *dev, char
 }
 
 static ssize_t
-claw_rbuff_write(struct device *dev, const char *buf, size_t count)
+claw_rbuff_write(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct claw_privbk *priv;
 	struct claw_env *p_env;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/net/ctcmain.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/net/ctcmain.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/net/ctcmain.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/net/ctcmain.c	2005-05-11 00:33:15.000000000 -0400
@@ -2698,7 +2698,7 @@ ctc_stats(struct net_device * dev)
  * sysfs attributes
  */
 static ssize_t
-buffer_show(struct device *dev, char *buf)
+buffer_show(struct device *dev, char *buf, void *private)
 {
 	struct ctc_priv *priv;
 
@@ -2710,7 +2710,7 @@ buffer_show(struct device *dev, char *bu
 }
 
 static ssize_t
-buffer_write(struct device *dev, const char *buf, size_t count)
+buffer_write(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct ctc_priv *priv;
 	struct net_device *ndev;
@@ -2746,7 +2746,7 @@ buffer_write(struct device *dev, const c
 }
 
 static ssize_t
-loglevel_show(struct device *dev, char *buf)
+loglevel_show(struct device *dev, char *buf, void *private)
 {
 	struct ctc_priv *priv;
 
@@ -2757,7 +2757,7 @@ loglevel_show(struct device *dev, char *
 }
 
 static ssize_t
-loglevel_write(struct device *dev, const char *buf, size_t count)
+loglevel_write(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct ctc_priv *priv;
 	int ll1;
@@ -2814,7 +2814,7 @@ ctc_print_statistics(struct ctc_priv *pr
 }
 
 static ssize_t
-stats_show(struct device *dev, char *buf)
+stats_show(struct device *dev, char *buf, void *private)
 {
 	struct ctc_priv *priv = dev->driver_data;
 	if (!priv)
@@ -2824,7 +2824,7 @@ stats_show(struct device *dev, char *buf
 }
 
 static ssize_t
-stats_write(struct device *dev, const char *buf, size_t count)
+stats_write(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct ctc_priv *priv = dev->driver_data;
 	if (!priv)
@@ -2946,7 +2946,7 @@ ctc_init_netdevice(struct net_device * d
 }
 
 static ssize_t
-ctc_proto_show(struct device *dev, char *buf)
+ctc_proto_show(struct device *dev, char *buf, void *private)
 {
 	struct ctc_priv *priv;
 
@@ -2958,7 +2958,7 @@ ctc_proto_show(struct device *dev, char 
 }
 
 static ssize_t
-ctc_proto_store(struct device *dev, const char *buf, size_t count)
+ctc_proto_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct ctc_priv *priv;
 	int value;
@@ -2980,7 +2980,7 @@ ctc_proto_store(struct device *dev, cons
 static DEVICE_ATTR(protocol, 0644, ctc_proto_show, ctc_proto_store);
 
 static ssize_t
-ctc_type_show(struct device *dev, char *buf)
+ctc_type_show(struct device *dev, char *buf, void *private)
 {
 	struct ccwgroup_device *cgdev;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/net/lcs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/net/lcs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/net/lcs.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/net/lcs.c	2005-05-11 00:33:15.000000000 -0400
@@ -1992,7 +1992,7 @@ lcs_open_device(struct net_device *dev)
  * show function for portno called by cat or similar things
  */
 static ssize_t
-lcs_portno_show (struct device *dev, char *buf)
+lcs_portno_show (struct device *dev, char *buf, void *private)
 {
         struct lcs_card *card;
 
@@ -2008,7 +2008,7 @@ lcs_portno_show (struct device *dev, cha
  * store the value which is piped to file portno
  */
 static ssize_t
-lcs_portno_store (struct device *dev, const char *buf, size_t count)
+lcs_portno_store (struct device *dev, const char *buf, size_t count, void *private)
 {
         struct lcs_card *card;
         int value;
@@ -2029,7 +2029,7 @@ lcs_portno_store (struct device *dev, co
 static DEVICE_ATTR(portno, 0644, lcs_portno_show, lcs_portno_store);
 
 static ssize_t
-lcs_type_show(struct device *dev, char *buf)
+lcs_type_show(struct device *dev, char *buf, void *private)
 {
 	struct ccwgroup_device *cgdev;
 
@@ -2043,7 +2043,7 @@ lcs_type_show(struct device *dev, char *
 static DEVICE_ATTR(type, 0444, lcs_type_show, NULL);
 
 static ssize_t
-lcs_timeout_show(struct device *dev, char *buf)
+lcs_timeout_show(struct device *dev, char *buf, void *private)
 {
 	struct lcs_card *card;
 
@@ -2053,7 +2053,7 @@ lcs_timeout_show(struct device *dev, cha
 }
 
 static ssize_t
-lcs_timeout_store (struct device *dev, const char *buf, size_t count)
+lcs_timeout_store (struct device *dev, const char *buf, size_t count, void *private)
 {
         struct lcs_card *card;
         int value;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/net/netiucv.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/net/netiucv.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/net/netiucv.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/net/netiucv.c	2005-05-11 00:33:15.000000000 -0400
@@ -1356,7 +1356,7 @@ netiucv_change_mtu (struct net_device * 
  *****************************************************************************/
 
 static ssize_t
-user_show (struct device *dev, char *buf)
+user_show (struct device *dev, char *buf, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1365,7 +1365,7 @@ user_show (struct device *dev, char *buf
 }
 
 static ssize_t
-user_write (struct device *dev, const char *buf, size_t count)
+user_write (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	struct net_device *ndev = priv->conn->netdev;
@@ -1422,7 +1422,7 @@ user_write (struct device *dev, const ch
 static DEVICE_ATTR(user, 0644, user_show, user_write);
 
 static ssize_t
-buffer_show (struct device *dev, char *buf)
+buffer_show (struct device *dev, char *buf, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1431,7 +1431,7 @@ buffer_show (struct device *dev, char *b
 }
 
 static ssize_t
-buffer_write (struct device *dev, const char *buf, size_t count)
+buffer_write (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	struct net_device *ndev = priv->conn->netdev;
@@ -1486,7 +1486,7 @@ buffer_write (struct device *dev, const 
 static DEVICE_ATTR(buffer, 0644, buffer_show, buffer_write);
 
 static ssize_t
-dev_fsm_show (struct device *dev, char *buf)
+dev_fsm_show (struct device *dev, char *buf, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1497,7 +1497,7 @@ dev_fsm_show (struct device *dev, char *
 static DEVICE_ATTR(device_fsm_state, 0444, dev_fsm_show, NULL);
 
 static ssize_t
-conn_fsm_show (struct device *dev, char *buf)
+conn_fsm_show (struct device *dev, char *buf, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1508,7 +1508,7 @@ conn_fsm_show (struct device *dev, char 
 static DEVICE_ATTR(connection_fsm_state, 0444, conn_fsm_show, NULL);
 
 static ssize_t
-maxmulti_show (struct device *dev, char *buf)
+maxmulti_show (struct device *dev, char *buf, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1517,7 +1517,7 @@ maxmulti_show (struct device *dev, char 
 }
 
 static ssize_t
-maxmulti_write (struct device *dev, const char *buf, size_t count)
+maxmulti_write (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1529,7 +1529,7 @@ maxmulti_write (struct device *dev, cons
 static DEVICE_ATTR(max_tx_buffer_used, 0644, maxmulti_show, maxmulti_write);
 
 static ssize_t
-maxcq_show (struct device *dev, char *buf)
+maxcq_show (struct device *dev, char *buf, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1538,7 +1538,7 @@ maxcq_show (struct device *dev, char *bu
 }
 
 static ssize_t
-maxcq_write (struct device *dev, const char *buf, size_t count)
+maxcq_write (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
@@ -1550,7 +1550,7 @@ maxcq_write (struct device *dev, const c
 static DEVICE_ATTR(max_chained_skbs, 0644, maxcq_show, maxcq_write);
 
 static ssize_t
-sdoio_show (struct device *dev, char *buf)
+sdoio_show (struct device *dev, char *buf, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1559,7 +1559,7 @@ sdoio_show (struct device *dev, char *bu
 }
 
 static ssize_t
-sdoio_write (struct device *dev, const char *buf, size_t count)
+sdoio_write (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
@@ -1571,7 +1571,7 @@ sdoio_write (struct device *dev, const c
 static DEVICE_ATTR(tx_single_write_ops, 0644, sdoio_show, sdoio_write);
 
 static ssize_t
-mdoio_show (struct device *dev, char *buf)
+mdoio_show (struct device *dev, char *buf, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1580,7 +1580,7 @@ mdoio_show (struct device *dev, char *bu
 }
 
 static ssize_t
-mdoio_write (struct device *dev, const char *buf, size_t count)
+mdoio_write (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
@@ -1592,7 +1592,7 @@ mdoio_write (struct device *dev, const c
 static DEVICE_ATTR(tx_multi_write_ops, 0644, mdoio_show, mdoio_write);
 
 static ssize_t
-txlen_show (struct device *dev, char *buf)
+txlen_show (struct device *dev, char *buf, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1601,7 +1601,7 @@ txlen_show (struct device *dev, char *bu
 }
 
 static ssize_t
-txlen_write (struct device *dev, const char *buf, size_t count)
+txlen_write (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
@@ -1613,7 +1613,7 @@ txlen_write (struct device *dev, const c
 static DEVICE_ATTR(netto_bytes, 0644, txlen_show, txlen_write);
 
 static ssize_t
-txtime_show (struct device *dev, char *buf)
+txtime_show (struct device *dev, char *buf, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1622,7 +1622,7 @@ txtime_show (struct device *dev, char *b
 }
 
 static ssize_t
-txtime_write (struct device *dev, const char *buf, size_t count)
+txtime_write (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
@@ -1634,7 +1634,7 @@ txtime_write (struct device *dev, const 
 static DEVICE_ATTR(max_tx_io_time, 0644, txtime_show, txtime_write);
 
 static ssize_t
-txpend_show (struct device *dev, char *buf)
+txpend_show (struct device *dev, char *buf, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1643,7 +1643,7 @@ txpend_show (struct device *dev, char *b
 }
 
 static ssize_t
-txpend_write (struct device *dev, const char *buf, size_t count)
+txpend_write (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1655,7 +1655,7 @@ txpend_write (struct device *dev, const 
 static DEVICE_ATTR(tx_pending, 0644, txpend_show, txpend_write);
 
 static ssize_t
-txmpnd_show (struct device *dev, char *buf)
+txmpnd_show (struct device *dev, char *buf, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1664,7 +1664,7 @@ txmpnd_show (struct device *dev, char *b
 }
 
 static ssize_t
-txmpnd_write (struct device *dev, const char *buf, size_t count)
+txmpnd_write (struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/net/qeth_sys.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/net/qeth_sys.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/net/qeth_sys.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/net/qeth_sys.c	2005-05-11 00:33:15.000000000 -0400
@@ -30,7 +30,7 @@ const char *VERSION_QETH_SYS_C = "$Revis
 //low/high watermark
 
 static ssize_t
-qeth_dev_state_show(struct device *dev, char *buf)
+qeth_dev_state_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	if (!card)
@@ -58,7 +58,7 @@ qeth_dev_state_show(struct device *dev, 
 static DEVICE_ATTR(state, 0444, qeth_dev_state_show, NULL);
 
 static ssize_t
-qeth_dev_chpid_show(struct device *dev, char *buf)
+qeth_dev_chpid_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	if (!card)
@@ -70,7 +70,7 @@ qeth_dev_chpid_show(struct device *dev, 
 static DEVICE_ATTR(chpid, 0444, qeth_dev_chpid_show, NULL);
 
 static ssize_t
-qeth_dev_if_name_show(struct device *dev, char *buf)
+qeth_dev_if_name_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	if (!card)
@@ -81,7 +81,7 @@ qeth_dev_if_name_show(struct device *dev
 static DEVICE_ATTR(if_name, 0444, qeth_dev_if_name_show, NULL);
 
 static ssize_t
-qeth_dev_card_type_show(struct device *dev, char *buf)
+qeth_dev_card_type_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	if (!card)
@@ -93,7 +93,7 @@ qeth_dev_card_type_show(struct device *d
 static DEVICE_ATTR(card_type, 0444, qeth_dev_card_type_show, NULL);
 
 static ssize_t
-qeth_dev_portno_show(struct device *dev, char *buf)
+qeth_dev_portno_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	if (!card)
@@ -103,7 +103,7 @@ qeth_dev_portno_show(struct device *dev,
 }
 
 static ssize_t
-qeth_dev_portno_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_portno_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -129,7 +129,7 @@ qeth_dev_portno_store(struct device *dev
 static DEVICE_ATTR(portno, 0644, qeth_dev_portno_show, qeth_dev_portno_store);
 
 static ssize_t
-qeth_dev_portname_show(struct device *dev, char *buf)
+qeth_dev_portname_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char portname[9] = {0, };
@@ -146,7 +146,7 @@ qeth_dev_portname_show(struct device *de
 }
 
 static ssize_t
-qeth_dev_portname_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_portname_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -177,7 +177,7 @@ static DEVICE_ATTR(portname, 0644, qeth_
 		qeth_dev_portname_store);
 
 static ssize_t
-qeth_dev_checksum_show(struct device *dev, char *buf)
+qeth_dev_checksum_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -188,7 +188,7 @@ qeth_dev_checksum_show(struct device *de
 }
 
 static ssize_t
-qeth_dev_checksum_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_checksum_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -218,7 +218,7 @@ static DEVICE_ATTR(checksumming, 0644, q
 		qeth_dev_checksum_store);
 
 static ssize_t
-qeth_dev_prioqing_show(struct device *dev, char *buf)
+qeth_dev_prioqing_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -237,7 +237,7 @@ qeth_dev_prioqing_show(struct device *de
 }
 
 static ssize_t
-qeth_dev_prioqing_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_prioqing_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -290,7 +290,7 @@ static DEVICE_ATTR(priority_queueing, 06
 		qeth_dev_prioqing_store);
 
 static ssize_t
-qeth_dev_bufcnt_show(struct device *dev, char *buf)
+qeth_dev_bufcnt_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -301,7 +301,7 @@ qeth_dev_bufcnt_show(struct device *dev,
 }
 
 static ssize_t
-qeth_dev_bufcnt_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_bufcnt_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -360,7 +360,7 @@ qeth_dev_route_show(struct qeth_card *ca
 }
 
 static ssize_t
-qeth_dev_route4_show(struct device *dev, char *buf)
+qeth_dev_route4_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -410,7 +410,7 @@ qeth_dev_route_store(struct qeth_card *c
 }
 
 static ssize_t
-qeth_dev_route4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_route4_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -425,7 +425,7 @@ static DEVICE_ATTR(route4, 0644, qeth_de
 
 #ifdef CONFIG_QETH_IPV6
 static ssize_t
-qeth_dev_route6_show(struct device *dev, char *buf)
+qeth_dev_route6_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -439,7 +439,7 @@ qeth_dev_route6_show(struct device *dev,
 }
 
 static ssize_t
-qeth_dev_route6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_route6_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -461,7 +461,7 @@ static DEVICE_ATTR(route6, 0644, qeth_de
 #endif
 
 static ssize_t
-qeth_dev_add_hhlen_show(struct device *dev, char *buf)
+qeth_dev_add_hhlen_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -472,7 +472,7 @@ qeth_dev_add_hhlen_show(struct device *d
 }
 
 static ssize_t
-qeth_dev_add_hhlen_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_add_hhlen_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -499,7 +499,7 @@ static DEVICE_ATTR(add_hhlen, 0644, qeth
 		   qeth_dev_add_hhlen_store);
 
 static ssize_t
-qeth_dev_fake_ll_show(struct device *dev, char *buf)
+qeth_dev_fake_ll_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -510,7 +510,7 @@ qeth_dev_fake_ll_show(struct device *dev
 }
 
 static ssize_t
-qeth_dev_fake_ll_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_fake_ll_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -536,7 +536,7 @@ static DEVICE_ATTR(fake_ll, 0644, qeth_d
 		   qeth_dev_fake_ll_store);
 
 static ssize_t
-qeth_dev_fake_broadcast_show(struct device *dev, char *buf)
+qeth_dev_fake_broadcast_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -547,7 +547,7 @@ qeth_dev_fake_broadcast_show(struct devi
 }
 
 static ssize_t
-qeth_dev_fake_broadcast_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_fake_broadcast_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -574,7 +574,7 @@ static DEVICE_ATTR(fake_broadcast, 0644,
 		   qeth_dev_fake_broadcast_store);
 
 static ssize_t
-qeth_dev_recover_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_recover_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -596,7 +596,7 @@ qeth_dev_recover_store(struct device *de
 static DEVICE_ATTR(recover, 0200, NULL, qeth_dev_recover_store);
 
 static ssize_t
-qeth_dev_broadcast_mode_show(struct device *dev, char *buf)
+qeth_dev_broadcast_mode_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -613,7 +613,7 @@ qeth_dev_broadcast_mode_show(struct devi
 }
 
 static ssize_t
-qeth_dev_broadcast_mode_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_broadcast_mode_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -651,7 +651,7 @@ static DEVICE_ATTR(broadcast_mode, 0644,
 		   qeth_dev_broadcast_mode_store);
 
 static ssize_t
-qeth_dev_canonical_macaddr_show(struct device *dev, char *buf)
+qeth_dev_canonical_macaddr_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -668,7 +668,7 @@ qeth_dev_canonical_macaddr_show(struct d
 
 static ssize_t
 qeth_dev_canonical_macaddr_store(struct device *dev, const char *buf,
-				  size_t count)
+				  size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -703,7 +703,7 @@ static DEVICE_ATTR(canonical_macaddr, 06
 		   qeth_dev_canonical_macaddr_store);
 
 static ssize_t
-qeth_dev_layer2_show(struct device *dev, char *buf)
+qeth_dev_layer2_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -714,7 +714,7 @@ qeth_dev_layer2_show(struct device *dev,
 }
 
 static ssize_t
-qeth_dev_layer2_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_layer2_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -742,7 +742,7 @@ static DEVICE_ATTR(layer2, 0644, qeth_de
 		   qeth_dev_layer2_store);
 
 static ssize_t
-qeth_dev_large_send_show(struct device *dev, char *buf)
+qeth_dev_large_send_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -762,7 +762,7 @@ qeth_dev_large_send_show(struct device *
 }
 
 static ssize_t
-qeth_dev_large_send_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_large_send_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	enum qeth_large_send_types type;
@@ -832,7 +832,7 @@ qeth_dev_blkt_store(struct qeth_card *ca
 }
 
 static ssize_t
-qeth_dev_blkt_total_show(struct device *dev, char *buf)
+qeth_dev_blkt_total_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -841,7 +841,7 @@ qeth_dev_blkt_total_show(struct device *
 
 
 static ssize_t
-qeth_dev_blkt_total_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_blkt_total_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -855,7 +855,7 @@ static DEVICE_ATTR(total, 0644, qeth_dev
 		   qeth_dev_blkt_total_store);
 
 static ssize_t
-qeth_dev_blkt_inter_show(struct device *dev, char *buf)
+qeth_dev_blkt_inter_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -864,7 +864,7 @@ qeth_dev_blkt_inter_show(struct device *
 
 
 static ssize_t
-qeth_dev_blkt_inter_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_blkt_inter_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -876,7 +876,7 @@ static DEVICE_ATTR(inter, 0644, qeth_dev
 		   qeth_dev_blkt_inter_store);
 
 static ssize_t
-qeth_dev_blkt_inter_jumbo_show(struct device *dev, char *buf)
+qeth_dev_blkt_inter_jumbo_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -886,7 +886,7 @@ qeth_dev_blkt_inter_jumbo_show(struct de
 
 
 static ssize_t
-qeth_dev_blkt_inter_jumbo_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_blkt_inter_jumbo_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -956,7 +956,7 @@ qeth_check_layer2(struct qeth_card *card
 
 
 static ssize_t
-qeth_dev_ipato_enable_show(struct device *dev, char *buf)
+qeth_dev_ipato_enable_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -969,7 +969,7 @@ qeth_dev_ipato_enable_show(struct device
 }
 
 static ssize_t
-qeth_dev_ipato_enable_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_enable_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -1004,7 +1004,7 @@ static QETH_DEVICE_ATTR(ipato_enable, en
 			qeth_dev_ipato_enable_store);
 
 static ssize_t
-qeth_dev_ipato_invert4_show(struct device *dev, char *buf)
+qeth_dev_ipato_invert4_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1018,7 +1018,7 @@ qeth_dev_ipato_invert4_show(struct devic
 }
 
 static ssize_t
-qeth_dev_ipato_invert4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_invert4_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -1084,7 +1084,7 @@ qeth_dev_ipato_add_show(char *buf, struc
 }
 
 static ssize_t
-qeth_dev_ipato_add4_show(struct device *dev, char *buf)
+qeth_dev_ipato_add4_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1153,7 +1153,7 @@ qeth_dev_ipato_add_store(const char *buf
 }
 
 static ssize_t
-qeth_dev_ipato_add4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_add4_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1186,7 +1186,7 @@ qeth_dev_ipato_del_store(const char *buf
 }
 
 static ssize_t
-qeth_dev_ipato_del4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_del4_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1201,7 +1201,7 @@ static QETH_DEVICE_ATTR(ipato_del4, del4
 
 #ifdef CONFIG_QETH_IPV6
 static ssize_t
-qeth_dev_ipato_invert6_show(struct device *dev, char *buf)
+qeth_dev_ipato_invert6_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1215,7 +1215,7 @@ qeth_dev_ipato_invert6_show(struct devic
 }
 
 static ssize_t
-qeth_dev_ipato_invert6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_invert6_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
@@ -1247,7 +1247,7 @@ static QETH_DEVICE_ATTR(ipato_invert6, i
 
 
 static ssize_t
-qeth_dev_ipato_add6_show(struct device *dev, char *buf)
+qeth_dev_ipato_add6_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1258,7 +1258,7 @@ qeth_dev_ipato_add6_show(struct device *
 }
 
 static ssize_t
-qeth_dev_ipato_add6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_add6_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1273,7 +1273,7 @@ static QETH_DEVICE_ATTR(ipato_add6, add6
 			qeth_dev_ipato_add6_store);
 
 static ssize_t
-qeth_dev_ipato_del6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_ipato_del6_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1341,7 +1341,7 @@ qeth_dev_vipa_add_show(char *buf, struct
 }
 
 static ssize_t
-qeth_dev_vipa_add4_show(struct device *dev, char *buf)
+qeth_dev_vipa_add4_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1381,7 +1381,7 @@ qeth_dev_vipa_add_store(const char *buf,
 }
 
 static ssize_t
-qeth_dev_vipa_add4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_vipa_add4_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1413,7 +1413,7 @@ qeth_dev_vipa_del_store(const char *buf,
 }
 
 static ssize_t
-qeth_dev_vipa_del4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_vipa_del4_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1428,7 +1428,7 @@ static QETH_DEVICE_ATTR(vipa_del4, del4,
 
 #ifdef CONFIG_QETH_IPV6
 static ssize_t
-qeth_dev_vipa_add6_show(struct device *dev, char *buf)
+qeth_dev_vipa_add6_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1439,7 +1439,7 @@ qeth_dev_vipa_add6_show(struct device *d
 }
 
 static ssize_t
-qeth_dev_vipa_add6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_vipa_add6_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1454,7 +1454,7 @@ static QETH_DEVICE_ATTR(vipa_add6, add6,
 			qeth_dev_vipa_add6_store);
 
 static ssize_t
-qeth_dev_vipa_del6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_vipa_del6_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1522,7 +1522,7 @@ qeth_dev_rxip_add_show(char *buf, struct
 }
 
 static ssize_t
-qeth_dev_rxip_add4_show(struct device *dev, char *buf)
+qeth_dev_rxip_add4_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1562,7 +1562,7 @@ qeth_dev_rxip_add_store(const char *buf,
 }
 
 static ssize_t
-qeth_dev_rxip_add4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_rxip_add4_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1594,7 +1594,7 @@ qeth_dev_rxip_del_store(const char *buf,
 }
 
 static ssize_t
-qeth_dev_rxip_del4_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_rxip_del4_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1609,7 +1609,7 @@ static QETH_DEVICE_ATTR(rxip_del4, del4,
 
 #ifdef CONFIG_QETH_IPV6
 static ssize_t
-qeth_dev_rxip_add6_show(struct device *dev, char *buf)
+qeth_dev_rxip_add6_show(struct device *dev, char *buf, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1620,7 +1620,7 @@ qeth_dev_rxip_add6_show(struct device *d
 }
 
 static ssize_t
-qeth_dev_rxip_add6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_rxip_add6_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
@@ -1635,7 +1635,7 @@ static QETH_DEVICE_ATTR(rxip_add6, add6,
 			qeth_dev_rxip_add6_store);
 
 static ssize_t
-qeth_dev_rxip_del6_store(struct device *dev, const char *buf, size_t count)
+qeth_dev_rxip_del6_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct qeth_card *card = dev->driver_data;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_scsi.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/scsi/zfcp_scsi.c	2005-05-11 00:28:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/s390/scsi/zfcp_scsi.c	2005-05-11 00:33:16.000000000 -0400
@@ -923,7 +923,7 @@ struct fc_function_template zfcp_transpo
  */
 #define ZFCP_DEFINE_SCSI_ATTR(_name, _format, _value)                    \
 static ssize_t zfcp_sysfs_scsi_##_name##_show(struct device *dev,        \
-                                              char *buf)                 \
+                                              char *buf, void *private)                 \
 {                                                                        \
         struct scsi_device *sdev;                                        \
         struct zfcp_unit *unit;                                          \



------=_Part_1443_10671669.1116063139622--
