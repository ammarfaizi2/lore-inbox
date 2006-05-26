Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWEZUIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWEZUIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 16:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWEZUIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 16:08:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17061 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751415AbWEZUIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 16:08:42 -0400
Date: Fri, 26 May 2006 22:07:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: pe1rxq@amsat.org, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org
Subject: usb wifi: zd1201 cleanups
Message-ID: <20060526200748.GA29517@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am trying to get zd1201 to work on ARM. It works okay on i386, but
not on ARM -- I get no results from iwlist wlan0 scan. Anyway, here
are some cleanups.

Line of ~280 characters, full of whitespace really got me. Please
apply,

---

Cleanup coding style and other small stuff in zd1201. No real code
changes.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/usb/net/zd1201.c b/drivers/usb/net/zd1201.c
index 9b1e4ed..aef02c4 100644
--- a/drivers/usb/net/zd1201.c
+++ b/drivers/usb/net/zd1201.c
@@ -33,7 +33,7 @@ static struct usb_device_id zd1201_table
 	{}
 };
 
-static int ap = 0;	/* Are we an AP or a normal station? */
+static int ap;	/* Are we an AP or a normal station? */
 
 #define ZD1201_VERSION	"0.15"
 
@@ -49,7 +49,7 @@ MODULE_DEVICE_TABLE(usb, zd1201_table);
 static int zd1201_fw_upload(struct usb_device *dev, int apfw)
 {
 	const struct firmware *fw_entry;
-	char* data;
+	char *data;
 	unsigned long len;
 	int err;
 	unsigned char ret;
@@ -65,7 +65,7 @@ static int zd1201_fw_upload(struct usb_d
 	if (err) {
 		dev_err(&dev->dev, "Failed to load %s firmware file!\n", fwfile);
 		dev_err(&dev->dev, "Make sure the hotplug firmware loader is installed.\n");
-		dev_err(&dev->dev, "Goto http://linux-lc100020.sourceforge.net for more info\n");
+		dev_err(&dev->dev, "Goto http://linux-lc100020.sourceforge.net for more info.\n");
 		return err;
 	}
 
@@ -94,12 +94,12 @@ static int zd1201_fw_upload(struct usb_d
 	    USB_DIR_OUT | 0x40, 0, 0, NULL, 0, ZD1201_FW_TIMEOUT);
 	if (err < 0)
 		goto exit;
-                                                                                                                                                                
+
 	err = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), 0x4,
 	    USB_DIR_IN | 0x40, 0,0, &ret, sizeof(ret), ZD1201_FW_TIMEOUT);
 	if (err < 0)
 		goto exit;
-                                                                                                                                                                                                                                                                                        
+
 	if (ret & 0x80) {
 		err = -EIO;
 		goto exit;
@@ -166,13 +166,13 @@ static int zd1201_docmd(struct zd1201 *z
 		return -ENOMEM;
 	}
 	usb_fill_bulk_urb(urb, zd->usb, usb_sndbulkpipe(zd->usb, zd->endp_out2),
-	     command, 16, zd1201_usbfree, zd);
+			  command, 16, zd1201_usbfree, zd);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
 	if (ret) {
 		kfree(command);
 		usb_free_urb(urb);
 	}
-	
+
 	return ret;
 }
 
@@ -316,7 +316,7 @@ static void zd1201_usbrx(struct urb *urb
 		fc = le16_to_cpu(*(__le16 *)&data[datalen-16]);
 		seq = le16_to_cpu(*(__le16 *)&data[datalen-24]);
 
-		if(zd->monitor) {
+		if (zd->monitor) {
 			if (datalen < 24)
 				goto resubmit;
 			if (!(skb = dev_alloc_skb(datalen+24)))
@@ -364,7 +364,7 @@ static void zd1201_usbrx(struct urb *urb
 				goto resubmit;
 			}
 			hlist_for_each_entry(frag, node, &zd->fraglist, fnode)
-				if(frag->seq == (seq&IEEE80211_SCTL_SEQ))
+				if (frag->seq == (seq&IEEE80211_SCTL_SEQ))
 					break;
 			if (!frag)
 				goto resubmit;
@@ -376,7 +376,6 @@ static void zd1201_usbrx(struct urb *urb
 				goto resubmit;
 			hlist_del_init(&frag->fnode);
 			kfree(frag);
-			/* Fallthrough */
 		} else {
 			if (datalen<14)
 				goto resubmit;
@@ -422,7 +421,7 @@ static int zd1201_getconfig(struct zd120
 	int rid_fid;
 	int length;
 	unsigned char *pdata;
-	
+
 	zd->rxdatas = 0;
 	err = zd1201_docmd(zd, ZD1201_CMDCODE_ACCESS, rid, 0, 0);
 	if (err)
@@ -471,11 +470,11 @@ static int zd1201_getconfig(struct zd120
 	length = zd->rxlen;
 
 	do {
-		int  actual_length;
+		int actual_length;
 
 		actual_length = (length > 64) ? 64 : length;
 
-		if(pdata[0] != 0x3) {
+		if (pdata[0] != 0x3) {
 			dev_dbg(&zd->usb->dev, "Rx Resource packet type error: %02X\n",
 			    pdata[0]);
 			return -EINVAL;
@@ -487,11 +486,10 @@ static int zd1201_getconfig(struct zd120
 		}
 
 		/* Skip the 4 bytes header (RID length and RID) */
-		if(i == 0) {
+		if (i == 0) {
 			pdata += 8;
 			actual_length -= 8;
-		}
-		else {
+		} else {
 			pdata += 4;
 			actual_length -= 4;
 		}
@@ -620,7 +618,7 @@ static int zd1201_drvr_start(struct zd12
 	short max;
 	__le16 zdmax;
 	unsigned char *buffer;
-	
+
 	buffer = kzalloc(ZD1201_RXSIZE, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
@@ -632,7 +630,7 @@ static int zd1201_drvr_start(struct zd12
 	err = usb_submit_urb(zd->rx_urb, GFP_KERNEL);
 	if (err)
 		goto err_buffer;
-	
+
 	err = zd1201_docmd(zd, ZD1201_CMDCODE_INIT, 0, 0, 0);
 	if (err)
 		goto err_urb;
@@ -684,7 +682,7 @@ static int zd1201_enable(struct zd1201 *
 static int zd1201_disable(struct zd1201 *zd)
 {
 	int err;
-	
+
 	if (!zd->mac_enabled)
 		return 0;
 	if (zd->monitor) {
@@ -764,7 +762,6 @@ static int zd1201_net_open(struct net_de
 static int zd1201_net_stop(struct net_device *dev)
 {
 	netif_stop_queue(dev);
-	
 	return 0;
 }
 
@@ -915,7 +912,6 @@ static int zd1201_get_name(struct net_de
     struct iw_request_info *info, char *name, char *extra)
 {
 	strcpy(name, "IEEE 802.11b");
-
 	return 0;
 }
 
@@ -1013,11 +1009,10 @@ static int zd1201_set_mode(struct net_de
 			if (err)
 				return err;
 	}
-	zd->monitor=monitor;
+	zd->monitor = monitor;
 	/* If monitor mode is set we don't actually turn it on here since it
 	 * is done during mac reset anyway (see zd1201_mac_enable).
 	 */
-
 	zd1201_mac_reset(zd);
 
 	return 0;
@@ -1117,7 +1112,7 @@ static int zd1201_get_wap(struct net_dev
 		zd->iwstats.qual.updated = 2;
 	}
 
-	return zd1201_getconfig(zd,ZD1201_RID_CURRENTBSSID,ap_addr->sa_data,6);
+	return zd1201_getconfig(zd, ZD1201_RID_CURRENTBSSID, ap_addr->sa_data, 6);
 }
 
 static int zd1201_set_scan(struct net_device *dev,
@@ -1275,7 +1270,7 @@ static int zd1201_set_rate(struct net_de
 	if (!rrq->fixed) { /* Also enable all lower bitrates */
 		rate |= rate-1;
 	}
-	
+
 	err = zd1201_setconfig16(zd, ZD1201_RID_TXRATECNTL, rate);
 	if (err)
 		return err;
@@ -1486,7 +1481,7 @@ static int zd1201_get_encode(struct net_
 		return -EINVAL;
 
 	erq->flags |= i+1;
-	
+
 	erq->length = zd->encode_keylen[i];
 	memcpy(key, zd->encode_keys[i], erq->length);
 
@@ -1529,11 +1524,7 @@ static int zd1201_set_power(struct net_d
 		return -EINVAL;
 	}
 out:
-	err = zd1201_setconfig16(zd, ZD1201_RID_CNFPMENABLED, enabled);
-	if (err)
-		return err;
-
-	return 0;
+	return zd1201_setconfig16(zd, ZD1201_RID_CNFPMENABLED, enabled);
 }
 
 static int zd1201_get_power(struct net_device *dev,
@@ -1627,15 +1618,11 @@ static int zd1201_set_hostauth(struct ne
     struct iw_request_info *info, struct iw_param *rrq, char *extra)
 {
 	struct zd1201 *zd = (struct zd1201 *)dev->priv;
-	int err;
 
 	if (!zd->ap)
 		return -EOPNOTSUPP;
 
-	err = zd1201_setconfig16(zd, ZD1201_RID_CNFHOSTAUTH, rrq->value);
-	if (err)
-		return err;
-	return 0;
+	return zd1201_setconfig16(zd, ZD1201_RID_CNFHOSTAUTH, rrq->value);
 }
 
 static int zd1201_get_hostauth(struct net_device *dev,
@@ -1744,7 +1731,7 @@ static int zd1201_probe(struct usb_inter
 {
 	struct zd1201 *zd;
 	struct usb_device *usb;
-	int i, err;
+	int err;
 	short porttype;
 	char buf[IW_ESSID_MAX_SIZE+2];
 
@@ -1773,9 +1760,7 @@ static int zd1201_probe(struct usb_inter
 	if (!zd->rx_urb || !zd->tx_urb)
 		goto err_zd;
 
-	for(i = 0; i<100; i++)
-		udelay(1000);
-
+	mdelay(100);
 	err = zd1201_drvr_start(zd);
 	if (err)
 		goto err_zd;
@@ -1833,7 +1818,7 @@ static int zd1201_probe(struct usb_inter
 		goto err_net;
 	dev_info(&usb->dev, "%s: ZD1201 USB Wireless interface\n",
 	    zd->dev->name);
-	
+
 	usb_set_intfdata(interface, zd);
 	return 0;
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
