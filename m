Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423685AbWLBLj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423685AbWLBLj0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423688AbWLBLj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:39:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:23918 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423685AbWLBLjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:39:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=kmV/XkbVtmsf5TkOitygOgWh8pnDgGJMlNlB3NUC1g8T9eyHp0xzWwUt5omD9B6K9rOBxeQH8wEwIxP//9PHOv26OORkA/ZeyK6AdJLzBlBLQhqSOvVLCBwHCO4MPcUA8fQ6EIEbc2pv4JGXhEbQg4WOFXgo+plQwW+obwu9X+I=
Subject: [PATCH 2.6.19] hostap: replace kmalloc+memset with kzalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jkmaline@cc.hut.fi, trivial@kernel.org
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:33:40 +0200
Message-Id: <1165059221.4523.36.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_ap.c linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_ap.c
--- linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_ap.c	2006-11-22 20:29:43.000000000 +0200
+++ linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_ap.c	2006-11-25 00:56:52.000000000 +0200
@@ -1099,15 +1099,13 @@ static struct sta_info * ap_add_sta(stru
 {
 	struct sta_info *sta;
 
-	sta = (struct sta_info *)
-		kmalloc(sizeof(struct sta_info), GFP_ATOMIC);
+	sta = kzalloc(sizeof(struct sta_info), GFP_ATOMIC);
 	if (sta == NULL) {
 		PDEBUG(DEBUG_AP, "AP: kmalloc failed\n");
 		return NULL;
 	}
 
 	/* initialize STA info data */
-	memset(sta, 0, sizeof(struct sta_info));
 	sta->local = ap->local;
 	skb_queue_head_init(&sta->tx_buf);
 	memcpy(sta->addr, addr, ETH_ALEN);
diff -rubp linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_cs.c linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_cs.c
--- linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_cs.c	2006-11-22 20:29:43.000000000 +0200
+++ linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_cs.c	2006-11-25 00:55:52.000000000 +0200
@@ -566,12 +566,11 @@ static int prism2_config(struct pcmcia_d
 	PDEBUG(DEBUG_FLOW, "prism2_config()\n");
 
 	parse = kmalloc(sizeof(cisparse_t), GFP_KERNEL);
-	hw_priv = kmalloc(sizeof(*hw_priv), GFP_KERNEL);
+	hw_priv = kzalloc(sizeof(*hw_priv), GFP_KERNEL);
 	if (parse == NULL || hw_priv == NULL) {
 		ret = -ENOMEM;
 		goto failed;
 	}
-	memset(hw_priv, 0, sizeof(*hw_priv));
 
 	tuple.DesiredTuple = CISTPL_CONFIG;
 	tuple.Attributes = 0;
diff -rubp linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_download.c linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_download.c
--- linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_download.c	2006-11-22 20:29:43.000000000 +0200
+++ linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_download.c	2006-11-25 00:55:52.000000000 +0200
@@ -685,14 +685,12 @@ static int prism2_download(local_info_t 
 		goto out;
 	}
 
-	dl = kmalloc(sizeof(*dl) + param->num_areas *
+	dl = kzalloc(sizeof(*dl) + param->num_areas *
 		     sizeof(struct prism2_download_data_area), GFP_KERNEL);
 	if (dl == NULL) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	memset(dl, 0, sizeof(*dl) + param->num_areas *
-	       sizeof(struct prism2_download_data_area));
 	dl->dl_cmd = param->dl_cmd;
 	dl->start_addr = param->start_addr;
 	dl->num_areas = param->num_areas;
diff -rubp linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_hw.c linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_hw.c
--- linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_hw.c	2006-11-22 20:29:43.000000000 +0200
+++ linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_hw.c	2006-11-25 00:58:03.000000000 +0200
@@ -347,14 +347,12 @@ static int hfa384x_cmd(struct net_device
 	if (signal_pending(current))
 		return -EINTR;
 
-	entry = (struct hostap_cmd_queue *)
-		kmalloc(sizeof(*entry), GFP_ATOMIC);
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 	if (entry == NULL) {
 		printk(KERN_DEBUG "%s: hfa384x_cmd - kmalloc failed\n",
 		       dev->name);
 		return -ENOMEM;
 	}
-	memset(entry, 0, sizeof(*entry));
 	atomic_set(&entry->usecnt, 1);
 	entry->type = CMD_SLEEP;
 	entry->cmd = cmd;
@@ -517,14 +515,12 @@ static int hfa384x_cmd_callback(struct n
 		return -1;
 	}
 
-	entry = (struct hostap_cmd_queue *)
-		kmalloc(sizeof(*entry), GFP_ATOMIC);
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 	if (entry == NULL) {
 		printk(KERN_DEBUG "%s: hfa384x_cmd_callback - kmalloc "
 		       "failed\n", dev->name);
 		return -ENOMEM;
 	}
-	memset(entry, 0, sizeof(*entry));
 	atomic_set(&entry->usecnt, 1);
 	entry->type = CMD_CALLBACK;
 	entry->cmd = cmd;
@@ -3015,14 +3011,12 @@ static int prism2_set_tim(struct net_dev
 	iface = netdev_priv(dev);
 	local = iface->local;
 
-	new_entry = (struct set_tim_data *)
-		kmalloc(sizeof(*new_entry), GFP_ATOMIC);
+	new_entry = kzalloc(sizeof(*new_entry), GFP_ATOMIC);
 	if (new_entry == NULL) {
 		printk(KERN_DEBUG "%s: prism2_set_tim: kmalloc failed\n",
 		       local->dev->name);
 		return -ENOMEM;
 	}
-	memset(new_entry, 0, sizeof(*new_entry));
 	new_entry->aid = aid;
 	new_entry->set = set;
 
diff -rubp linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_info.c linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_info.c
--- linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_info.c	2006-11-22 20:29:43.000000000 +0200
+++ linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_info.c	2006-11-25 00:55:52.000000000 +0200
@@ -327,11 +327,10 @@ static void prism2_info_hostscanresults(
 	ptr = (u8 *) pos;
 
 	new_count = left / result_size;
-	results = kmalloc(new_count * sizeof(struct hfa384x_hostscan_result),
+	results = kcalloc(new_count, sizeof(struct hfa384x_hostscan_result),
 			  GFP_ATOMIC);
 	if (results == NULL)
 		return;
-	memset(results, 0, new_count * sizeof(struct hfa384x_hostscan_result));
 
 	for (i = 0; i < new_count; i++) {
 		memcpy(&results[i], ptr, copy_len);
diff -rubp linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_ioctl.c linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_ioctl.c
--- linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_ioctl.c	2006-11-22 20:29:43.000000000 +0200
+++ linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_ioctl.c	2006-11-25 00:59:14.000000000 +0200
@@ -181,12 +181,10 @@ static int prism2_ioctl_siwencode(struct
 		struct ieee80211_crypt_data *new_crypt;
 
 		/* take WEP into use */
-		new_crypt = (struct ieee80211_crypt_data *)
-			kmalloc(sizeof(struct ieee80211_crypt_data),
+		new_crypt = kzalloc(sizeof(struct ieee80211_crypt_data),
 				GFP_KERNEL);
 		if (new_crypt == NULL)
 			return -ENOMEM;
-		memset(new_crypt, 0, sizeof(struct ieee80211_crypt_data));
 		new_crypt->ops = ieee80211_get_crypto_ops("WEP");
 		if (!new_crypt->ops) {
 			request_module("ieee80211_crypt_wep");
@@ -3320,14 +3318,12 @@ static int prism2_ioctl_siwencodeext(str
 
 		prism2_crypt_delayed_deinit(local, crypt);
 
-		new_crypt = (struct ieee80211_crypt_data *)
-			kmalloc(sizeof(struct ieee80211_crypt_data),
+		new_crypt = kzalloc(sizeof(struct ieee80211_crypt_data),
 				GFP_KERNEL);
 		if (new_crypt == NULL) {
 			ret = -ENOMEM;
 			goto done;
 		}
-		memset(new_crypt, 0, sizeof(struct ieee80211_crypt_data));
 		new_crypt->ops = ops;
 		new_crypt->priv = new_crypt->ops->init(i);
 		if (new_crypt->priv == NULL) {
@@ -3538,14 +3534,12 @@ static int prism2_ioctl_set_encryption(l
 
 		prism2_crypt_delayed_deinit(local, crypt);
 
-		new_crypt = (struct ieee80211_crypt_data *)
-			kmalloc(sizeof(struct ieee80211_crypt_data),
+		new_crypt = kzalloc(sizeof(struct ieee80211_crypt_data),
 				GFP_KERNEL);
 		if (new_crypt == NULL) {
 			ret = -ENOMEM;
 			goto done;
 		}
-		memset(new_crypt, 0, sizeof(struct ieee80211_crypt_data));
 		new_crypt->ops = ops;
 		new_crypt->priv = new_crypt->ops->init(param->u.crypt.idx);
 		if (new_crypt->priv == NULL) {
diff -rubp linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_pci.c linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_pci.c
--- linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_pci.c	2006-11-22 20:29:43.000000000 +0200
+++ linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_pci.c	2006-11-25 00:55:52.000000000 +0200
@@ -300,10 +300,9 @@ static int prism2_pci_probe(struct pci_d
 	struct hostap_interface *iface;
 	struct hostap_pci_priv *hw_priv;
 
-	hw_priv = kmalloc(sizeof(*hw_priv), GFP_KERNEL);
+	hw_priv = kzalloc(sizeof(*hw_priv), GFP_KERNEL);
 	if (hw_priv == NULL)
 		return -ENOMEM;
-	memset(hw_priv, 0, sizeof(*hw_priv));
 
 	if (pci_enable_device(pdev))
 		goto err_out_free;
diff -rubp linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_plx.c linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_plx.c
--- linux-2.6.19-rc6_orig/drivers/net/wireless/hostap/hostap_plx.c	2006-11-22 20:29:43.000000000 +0200
+++ linux-2.6.19-rc6/drivers/net/wireless/hostap/hostap_plx.c	2006-11-25 00:55:52.000000000 +0200
@@ -447,10 +447,9 @@ static int prism2_plx_probe(struct pci_d
 	int tmd7160;
 	struct hostap_plx_priv *hw_priv;
 
-	hw_priv = kmalloc(sizeof(*hw_priv), GFP_KERNEL);
+	hw_priv = kzalloc(sizeof(*hw_priv), GFP_KERNEL);
 	if (hw_priv == NULL)
 		return -ENOMEM;
-	memset(hw_priv, 0, sizeof(*hw_priv));
 
 	if (pci_enable_device(pdev))
 		goto err_out_free;



