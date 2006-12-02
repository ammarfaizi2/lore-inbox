Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423688AbWLBLjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423688AbWLBLjd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423692AbWLBLjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:39:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:23918 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423688AbWLBLjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:39:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=A1io+cnK293XahVWavpwW2EfJo7P1AjFBPf6e99R5PF7llzWdLzb/7ytAoK3pF4AtLv27gelvCqCtpcHmHLSbHAflK19DDW9bCNYDJSb28t+howLweiaBp5B1hT8F+hsqoFBZnxKFKCVzo+8i9OILj60xnuUeiAup5QyLwI9xJw=
Subject: [PATCH 2.6.19] prism54: replace kmalloc+memset with kzalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: prism54-private@prism54.org, trivial@kernel.org
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:35:20 +0200
Message-Id: <1165059320.4523.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/drivers/net/wireless/prism54/isl_ioctl.c linux-2.6.19-rc5_kzalloc/drivers/net/wireless/prism54/isl_ioctl.c
--- linux-2.6.19-rc5_orig/drivers/net/wireless/prism54/isl_ioctl.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/drivers/net/wireless/prism54/isl_ioctl.c	2006-11-11 22:44:04.000000000 +0200
@@ -2141,11 +2141,9 @@ prism54_wpa_bss_ie_add(islpci_private *p
 					 struct islpci_bss_wpa_ie, list);
 			list_del(&bss->list);
 		} else {
-			bss = kmalloc(sizeof (*bss), GFP_ATOMIC);
-			if (bss != NULL) {
+			bss = kzalloc(sizeof (*bss), GFP_ATOMIC);
+			if (bss != NULL)
 				priv->num_bss_wpa++;
-				memset(bss, 0, sizeof (*bss));
-			}
 		}
 		if (bss != NULL) {
 			memcpy(bss->bssid, bssid, ETH_ALEN);
@@ -2685,11 +2683,10 @@ prism2_ioctl_set_generic_element(struct 
                return -EINVAL;
 
        alen = sizeof(*attach) + len;
-       attach = kmalloc(alen, GFP_KERNEL);
+       attach = kzalloc(alen, GFP_KERNEL);
        if (attach == NULL)
                return -ENOMEM;
 
-       memset(attach, 0, alen);
 #define WLAN_FC_TYPE_MGMT 0
 #define WLAN_FC_STYPE_ASSOC_REQ 0
 #define WLAN_FC_STYPE_REASSOC_REQ 2
diff -rubp linux-2.6.19-rc5_orig/drivers/net/wireless/prism54/oid_mgt.c linux-2.6.19-rc5_kzalloc/drivers/net/wireless/prism54/oid_mgt.c
--- linux-2.6.19-rc5_orig/drivers/net/wireless/prism54/oid_mgt.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/drivers/net/wireless/prism54/oid_mgt.c	2006-11-11 22:44:04.000000000 +0200
@@ -235,12 +235,10 @@ mgt_init(islpci_private *priv)
 {
 	int i;
 
-	priv->mib = kmalloc(OID_NUM_LAST * sizeof (void *), GFP_KERNEL);
+	priv->mib = kcalloc(OID_NUM_LAST, sizeof (void *), GFP_KERNEL);
 	if (!priv->mib)
 		return -ENOMEM;
 
-	memset(priv->mib, 0, OID_NUM_LAST * sizeof (void *));
-
 	/* Alloc the cache */
 	for (i = 0; i < OID_NUM_LAST; i++) {
 		if (isl_oid[i].flags & OID_FLAG_CACHED) {



