Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWANPVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWANPVS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWANPVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:21:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64518 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751773AbWANPVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:21:15 -0500
Date: Sat, 14 Jan 2006 16:21:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: "John W. Linville" <linville@tuxdriver.com>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/net/wireless/tiacx/: remove code for WIRELESS_EXT < 18
Message-ID: <20060114152114.GM29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WIRELESS_EXT < 18 will never be true in the kernel.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/tiacx/acx_struct.h  |    5 
 drivers/net/wireless/tiacx/common.c      |    4 
 drivers/net/wireless/tiacx/conv.c        |    2 
 drivers/net/wireless/tiacx/ioctl.c       |  436 -----------------------
 drivers/net/wireless/tiacx/pci.c         |    8 
 drivers/net/wireless/tiacx/usb.c         |    6 
 drivers/net/wireless/tiacx/wlan.c        |    2 
 drivers/net/wireless/tiacx/wlan_compat.h |   10 
 8 files changed, 1 insertion(+), 472 deletions(-)

WIRELESS_EXT < 18 will never be true in the kernel.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/tiacx/acx_struct.h  |    5 
 drivers/net/wireless/tiacx/common.c      |    4 
 drivers/net/wireless/tiacx/conv.c        |    2 
 drivers/net/wireless/tiacx/ioctl.c       |  436 -----------------------
 drivers/net/wireless/tiacx/pci.c         |    8 
 drivers/net/wireless/tiacx/usb.c         |    6 
 drivers/net/wireless/tiacx/wlan.c        |    2 
 drivers/net/wireless/tiacx/wlan_compat.h |   10 
 8 files changed, 1 insertion(+), 472 deletions(-)

--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/acx_struct.h.old	2005-12-03 02:58:36.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/acx_struct.h	2005-12-03 02:59:36.000000000 +0100
@@ -1053,9 +1053,8 @@
 						 * the struct net_device. */
 	/*** Device statistics ***/
 	struct net_device_stats	stats;		/* net device statistics */
-#ifdef WIRELESS_EXT
 	struct iw_statistics	wstats;		/* wireless statistics */
-#endif
+
 	/*** Power managment ***/
 	struct pm_dev		*pm;		/* PM crap */
 
@@ -1103,9 +1102,7 @@
 	u8		scan_rate;
 	u16		scan_duration;
 	u16		scan_probe_delay;
-#if WIRELESS_EXT > 15
 	struct iw_spy_data	spy_data;	/* FIXME: needs to be implemented! */
-#endif
 
 	/*** Wireless network settings ***/
 	/* copy of the device address (ifconfig hw ether) that we actually use
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/common.c.old	2005-12-03 02:59:47.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/common.c	2005-12-03 03:00:04.000000000 +0100
@@ -46,9 +46,7 @@
 #include <linux/wireless.h>
 #include <linux/pm.h>
 #include <linux/vmalloc.h>
-#if WIRELESS_EXT >= 13
 #include <net/iw_handler.h>
-#endif /* WE >= 13 */
 
 #include "acx.h"
 
@@ -2707,7 +2705,6 @@
 	acxlog(L_ASSOC, "%s(%d):%s\n",
 	       __func__, new_status, acx_get_status_name(new_status));
 
-#if WIRELESS_EXT > 13 /* wireless_send_event() and SIOCGIWSCAN */
 	/* wireless_send_event never sleeps */
 	if (ACX_STATUS_4_ASSOCIATED == new_status) {
 		union iwreq_data wrqu;
@@ -2729,7 +2726,6 @@
 		wrqu.ap_addr.sa_family = ARPHRD_ETHER;
 		wireless_send_event(priv->netdev, SIOCGIWAP, &wrqu, NULL);
 	}
-#endif
 
 	priv->status = new_status;
 
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/conv.c.old	2005-12-03 03:00:17.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/conv.c	2005-12-03 03:00:26.000000000 +0100
@@ -36,9 +36,7 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <linux/wireless.h>
-#if WIRELESS_EXT >= 13
 #include <net/iw_handler.h>
-#endif
 
 #include "acx.h"
 
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/pci.c.old	2005-12-03 03:02:16.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/pci.c	2005-12-03 03:02:30.000000000 +0100
@@ -45,9 +45,7 @@
 #include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/wireless.h>
-#if WIRELESS_EXT >= 13
 #include <net/iw_handler.h>
-#endif
 #include <linux/netdevice.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
@@ -1820,11 +1818,7 @@
 	dev->hard_start_xmit = &acx_i_start_xmit;
 	dev->get_stats = &acx_e_get_stats;
 	dev->get_wireless_stats = &acx_e_get_wireless_stats;
-#if WIRELESS_EXT >= 13
 	dev->wireless_handlers = (struct iw_handler_def *)&acx_ioctl_handler_def;
-#else
-	dev->do_ioctl = &acx_e_ioctl_old;
-#endif
 	dev->set_multicast_list = &acxpci_i_set_multicast_list;
 	dev->tx_timeout = &acxpci_i_tx_timeout;
 	dev->change_mtu = &acx_e_change_mtu;
@@ -3842,7 +3836,6 @@
 		r100 = txdesc->u.r1.rate;
 		r111 = txdesc->u.r2.rate111;
 
-#if WIRELESS_EXT > 13 /* wireless_send_event() and IWEVTXDROP are WE13 */
 		/* need to check for certain error conditions before we
 		 * clean the descriptor: we still need valid descr data here */
 		if (unlikely(0x30 & error)) {
@@ -3857,7 +3850,6 @@
 			MAC_COPY(wrqu.addr.sa_data, hdr->a1);
 			wireless_send_event(priv->netdev, IWEVTXDROP, &wrqu, NULL);
 		}
-#endif
 		/* ...and free the desc */
 		txdesc->error = 0;
 		txdesc->ack_failures = 0;
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/wlan.c.old	2005-12-03 03:02:58.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/wlan.c	2005-12-03 03:03:02.000000000 +0100
@@ -43,9 +43,7 @@
 #include <linux/types.h>
 #include <linux/if_arp.h>
 #include <linux/wireless.h>
-#if WIRELESS_EXT >= 13
 #include <net/iw_handler.h>
-#endif
 
 #include "acx.h"
 
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/wlan_compat.h.old	2005-12-03 03:03:11.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/tiacx/wlan_compat.h	2005-12-03 03:03:19.000000000 +0100
@@ -228,15 +228,6 @@
  typedef struct net_device netdevice_t;
 #endif
 
-#ifdef WIRELESS_EXT
-#if (WIRELESS_EXT < 13)
-struct iw_request_info {
-	__u16 cmd;		/* Wireless Extension command */
-	__u16 flags;		/* More to come ;-) */
-};
-#endif
-#endif
-
 /* Interrupt handler backwards compatibility stuff */
 #ifndef IRQ_NONE
 #define IRQ_NONE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--- linux-2.6.15-mm3-full/drivers/net/wireless/tiacx/ioctl.c.old	2006-01-14 15:56:54.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/net/wireless/tiacx/ioctl.c	2006-01-14 15:59:12.000000000 +0100
@@ -39,9 +39,7 @@
 
 #include <linux/if_arp.h>
 #include <linux/wireless.h>
-#if WIRELESS_EXT >= 13
 #include <net/iw_handler.h>
-#endif /* WE >= 13 */
 
 #include "acx.h"
 
@@ -330,11 +328,9 @@
 	case IW_MODE_AUTO:
 		priv->mode = ACX_MODE_OFF;
 		break;
-#if WIRELESS_EXT > 14
 	case IW_MODE_MONITOR:
 		priv->mode = ACX_MODE_MONITOR;
 		break;
-#endif /* WIRELESS_EXT > 14 */
 	case IW_MODE_ADHOC:
 		priv->mode = ACX_MODE_0_ADHOC;
 		break;
@@ -382,10 +378,8 @@
 	switch (priv->mode) {
 	case ACX_MODE_OFF:
 		*uwrq = IW_MODE_AUTO; break;
-#if WIRELESS_EXT > 14
 	case ACX_MODE_MONITOR:
 		*uwrq = IW_MODE_MONITOR; break;
-#endif /* WIRELESS_EXT > 14 */
 	case ACX_MODE_0_ADHOC:
 		*uwrq = IW_MODE_ADHOC; break;
 	case ACX_MODE_2_STA:
@@ -617,7 +611,6 @@
 }
 
 
-#if WIRELESS_EXT > 13
 /***********************************************************************
 ** acx_s_scan_add_station
 */
@@ -772,7 +765,6 @@
 	FN_EXIT1(result);
 	return result;
 }
-#endif /* WIRELESS_EXT > 13 */
 
 
 /*----------------------------------------------------------------
@@ -1486,39 +1478,6 @@
 
 
 /***********************************************************************
-** Private functions
-*/
-
-#if WIRELESS_EXT < 13
-/***********************************************************************
-** acx_ioctl_get_iw_priv
-**
-** I added the monitor mode and changed the stuff below
-** to look more like the orinoco driver
-*/
-static int
-acx_ioctl_get_iw_priv(struct iwreq *iwr)
-{
-	int result = -EINVAL;
-
-	if (!iwr->u.data.pointer)
-		return -EINVAL;
-	result = verify_area(VERIFY_WRITE, iwr->u.data.pointer,
-			sizeof(acx_ioctl_private_args));
-	if (result)
-		return result;
-
-	iwr->u.data.length = VEC_SIZE(acx_ioctl_private_args);
-	if (copy_to_user(iwr->u.data.pointer,
-	    acx_ioctl_private_args, sizeof(acx_ioctl_private_args)) != 0)
-		result = -EFAULT;
-
-	return result;
-}
-#endif
-
-
-/***********************************************************************
 ** acx_ioctl_get_nick
 */
 static inline int
@@ -2585,7 +2544,6 @@
 
 /***********************************************************************
 */
-#if WIRELESS_EXT >= 13
 static const iw_handler acx_ioctl_handler[] =
 {
 	(iw_handler) acx_ioctl_commit,		/* SIOCSIWCOMMIT */
@@ -2624,13 +2582,8 @@
 	(iw_handler) acx_ioctl_get_ap,		/* SIOCGIWAP */
 	(iw_handler) NULL,			/* [nothing] */
 	(iw_handler) acx_ioctl_get_aplist,	/* SIOCGIWAPLIST */
-#if WIRELESS_EXT > 13
 	(iw_handler) acx_ioctl_set_scan,	/* SIOCSIWSCAN */
 	(iw_handler) acx_ioctl_get_scan,	/* SIOCGIWSCAN */
-#else /* WE > 13 */
-	(iw_handler) NULL,			/* SIOCSIWSCAN */
-	(iw_handler) NULL,			/* SIOCGIWSCAN */
-#endif /* WE > 13 */
 	(iw_handler) acx_ioctl_set_essid,	/* SIOCSIWESSID */
 	(iw_handler) acx_ioctl_get_essid,	/* SIOCGIWESSID */
 	(iw_handler) acx_ioctl_set_nick,	/* SIOCSIWNICKN */
@@ -2694,392 +2647,3 @@
 	.private_args = (struct iw_priv_args *) acx_ioctl_private_args,
 };
 
-#endif /* WE >= 13 */
-
-
-#if WIRELESS_EXT < 13
-/***********************************************************************
-** Main function
-**
-** acx_e_ioctl_old
-**
-** This is the *OLD* ioctl handler.
-** Make sure to not only place your additions here, but instead mainly
-** in the new one (acx_ioctl_handler[])!
-*/
-int
-acx_e_ioctl_old(netdevice_t *dev, struct ifreq *ifr, int cmd)
-{
-	wlandevice_t *priv = netdev_priv(dev);
-	int result = 0;
-	struct iwreq *iwr = (struct iwreq *)ifr;
-
-	log(L_IOCTL, "%s cmd = 0x%04X\n", __func__, cmd);
-
-	/* This is the way it is done in the orinoco driver.
-	 * Check to see if device is present.
-	 */
-	if (0 == netif_device_present(dev)) {
-		return -ENODEV;
-	}
-
-	switch (cmd) {
-/* WE 13 and higher will use acx_ioctl_handler_def */
-	case SIOCGIWNAME:
-		/* get name == wireless protocol */
-		result = acx_ioctl_get_name(dev, NULL,
-					       (char *)&(iwr->u.name), NULL);
-		break;
-
-	case SIOCSIWNWID: /* pre-802.11, */
-	case SIOCGIWNWID: /* not supported. */
-		result = -EOPNOTSUPP;
-		break;
-
-	case SIOCSIWFREQ:
-		/* set channel/frequency (Hz)
-		   data can be frequency or channel :
-		   0-1000 = channel
-		   > 1000 = frequency in Hz */
-		result = acx_ioctl_set_freq(dev, NULL, &(iwr->u.freq), NULL);
-		break;
-
-	case SIOCGIWFREQ:
-		/* get channel/frequency (Hz) */
-		result = acx_ioctl_get_freq(dev, NULL, &(iwr->u.freq), NULL);
-		break;
-
-	case SIOCSIWMODE:
-		/* set operation mode */
-		result = acx_ioctl_set_mode(dev, NULL, &(iwr->u.mode), NULL);
-		break;
-
-	case SIOCGIWMODE:
-		/* get operation mode */
-		result = acx_ioctl_get_mode(dev, NULL, &(iwr->u.mode), NULL);
-		break;
-
-	case SIOCSIWSENS:
-		/* Set sensitivity */
-		result = acx_ioctl_set_sens(dev, NULL, &(iwr->u.sens), NULL);
-		break;
-
-	case SIOCGIWSENS:
-		/* Get sensitivity */
-		result = acx_ioctl_get_sens(dev, NULL, &(iwr->u.sens), NULL);
-		break;
-
-#if WIRELESS_EXT > 10
-	case SIOCGIWRANGE:
-		/* Get range of parameters */
-		{
-			struct iw_range range;
-			result = acx_ioctl_get_range(dev, NULL,
-					&(iwr->u.data), (char *)&range);
-			if (copy_to_user(iwr->u.data.pointer, &range,
-					 sizeof(struct iw_range)))
-				result = -EFAULT;
-		}
-		break;
-#endif
-
-	case SIOCGIWPRIV:
-		result = acx_ioctl_get_iw_priv(iwr);
-		break;
-
-	/* case SIOCSIWSPY: */
-	/* case SIOCGIWSPY: */
-	/* case SIOCSIWTHRSPY: */
-	/* case SIOCGIWTHRSPY: */
-
-	case SIOCSIWAP:
-		/* set access point by MAC address */
-		result = acx_ioctl_set_ap(dev, NULL, &(iwr->u.ap_addr),
-					     NULL);
-		break;
-
-	case SIOCGIWAP:
-		/* get access point MAC address */
-		result = acx_ioctl_get_ap(dev, NULL, &(iwr->u.ap_addr),
-					     NULL);
-		break;
-
-	case SIOCGIWAPLIST:
-		/* get list of access points in range */
-		result = acx_ioctl_get_aplist(dev, NULL, &(iwr->u.data),
-						 NULL);
-		break;
-
-#if NOT_FINISHED_YET
-	case SIOCSIWSCAN:
-		/* start a station scan */
-		result = acx_ioctl_set_scan(iwr, priv);
-		break;
-
-	case SIOCGIWSCAN:
-		/* get list of stations found during scan */
-		result = acx_ioctl_get_scan(iwr, priv);
-		break;
-#endif
-
-	case SIOCSIWESSID:
-		/* set ESSID (network name) */
-		{
-			char essid[IW_ESSID_MAX_SIZE+1];
-
-			if (iwr->u.essid.length > IW_ESSID_MAX_SIZE)
-			{
-				result = -E2BIG;
-				break;
-			}
-			if (copy_from_user(essid, iwr->u.essid.pointer,
-						iwr->u.essid.length))
-			{
-				result = -EFAULT;
-				break;
-			}
-			result = acx_ioctl_set_essid(dev, NULL,
-					&(iwr->u.essid), essid);
-		}
-		break;
-
-	case SIOCGIWESSID:
-		/* get ESSID */
-		{
-			char essid[IW_ESSID_MAX_SIZE+1];
-			if (iwr->u.essid.pointer)
-				result = acx_ioctl_get_essid(dev, NULL,
-					&(iwr->u.essid), essid);
-			if (copy_to_user(iwr->u.essid.pointer, essid,
-						iwr->u.essid.length))
-				result = -EFAULT;
-		}
-		break;
-
-	case SIOCSIWNICKN:
-		/* set nick */
-		{
-			char nick[IW_ESSID_MAX_SIZE+1];
-
-			if (iwr->u.data.length > IW_ESSID_MAX_SIZE)
-			{
-				result = -E2BIG;
-				break;
-			}
-			if (copy_from_user(nick, iwr->u.data.pointer,
-						iwr->u.data.length))
-			{
-				result = -EFAULT;
-				break;
-			}
-			result = acx_ioctl_set_nick(dev, NULL,
-					&(iwr->u.data), nick);
-		}
-		break;
-
-	case SIOCGIWNICKN:
-		/* get nick */
-		{
-			char nick[IW_ESSID_MAX_SIZE+1];
-			if (iwr->u.data.pointer)
-				result = acx_ioctl_get_nick(dev, NULL,
-						&(iwr->u.data), nick);
-			if (copy_to_user(iwr->u.data.pointer, nick,
-						iwr->u.data.length))
-				result = -EFAULT;
-		}
-		break;
-
-	case SIOCSIWRATE:
-		/* set default bit rate (bps) */
-		result = acx_ioctl_set_rate(dev, NULL, &(iwr->u.bitrate),
-					       NULL);
-		break;
-
-	case SIOCGIWRATE:
-		/* get default bit rate (bps) */
-		result = acx_ioctl_get_rate(dev, NULL, &(iwr->u.bitrate),
-					       NULL);
-		break;
-
-	case  SIOCSIWRTS:
-		/* set RTS threshold value */
-		result = acx_ioctl_set_rts(dev, NULL, &(iwr->u.rts), NULL);
-		break;
-	case  SIOCGIWRTS:
-		/* get RTS threshold value */
-		result = acx_ioctl_get_rts(dev, NULL,  &(iwr->u.rts), NULL);
-		break;
-
-	/* case  SIOCSIWFRAG: */
-	/* case  SIOCGIWFRAG: */
-
-#if WIRELESS_EXT > 9
-	case SIOCGIWTXPOW:
-		/* get tx power */
-		result = acx_ioctl_get_txpow(dev, NULL, &(iwr->u.txpower),
-						NULL);
-		break;
-
-	case SIOCSIWTXPOW:
-		/* set tx power */
-		result = acx_ioctl_set_txpow(dev, NULL, &(iwr->u.txpower),
-						NULL);
-		break;
-#endif
-
-	case SIOCSIWRETRY:
-		result = acx_ioctl_set_retry(dev, NULL, &(iwr->u.retry), NULL);
-		break;
-
-	case SIOCGIWRETRY:
-		result = acx_ioctl_get_retry(dev, NULL, &(iwr->u.retry), NULL);
-		break;
-
-	case SIOCSIWENCODE:
-		{
-			/* set encoding token & mode */
-			u8 key[29];
-			if (iwr->u.encoding.pointer) {
-				if (iwr->u.encoding.length > 29) {
-					result = -E2BIG;
-					break;
-				}
-				if (copy_from_user(key, iwr->u.encoding.pointer,
-						iwr->u.encoding.length)) {
-					result = -EFAULT;
-					break;
-				}
-			}
-			else
-			if (iwr->u.encoding.length) {
-				result = -EINVAL;
-				break;
-			}
-			result = acx_ioctl_set_encode(dev, NULL,
-					&(iwr->u.encoding), key);
-		}
-		break;
-
-	case SIOCGIWENCODE:
-		{
-			/* get encoding token & mode */
-			u8 key[29];
-
-			result = acx_ioctl_get_encode(dev, NULL,
-					&(iwr->u.encoding), key);
-			if (iwr->u.encoding.pointer) {
-				if (copy_to_user(iwr->u.encoding.pointer,
-						key, iwr->u.encoding.length))
-					result = -EFAULT;
-			}
-		}
-		break;
-
-	/******************** iwpriv ioctls below ********************/
-#if ACX_DEBUG
-	case ACX100_IOCTL_DEBUG:
-		acx_ioctl_set_debug(dev, NULL, NULL, iwr->u.name);
-		break;
-#endif
-
-	case ACX100_IOCTL_SET_PLED:
-		acx100_ioctl_set_led_power(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_GET_PLED:
-		acx100_ioctl_get_led_power(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_LIST_DOM:
-		acx_ioctl_list_reg_domain(dev, NULL, NULL, NULL);
-		break;
-
-	case ACX100_IOCTL_SET_DOM:
-		acx_ioctl_set_reg_domain(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_GET_DOM:
-		acx_ioctl_get_reg_domain(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_SET_SCAN_PARAMS:
-		acx_ioctl_set_scan_params(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_GET_SCAN_PARAMS:
-		acx_ioctl_get_scan_params(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_SET_PREAMB:
-		acx_ioctl_set_short_preamble(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_GET_PREAMB:
-		acx_ioctl_get_short_preamble(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_SET_ANT:
-		acx_ioctl_set_antenna(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_GET_ANT:
-		acx_ioctl_get_antenna(dev, NULL, NULL, NULL);
-		break;
-
-	case ACX100_IOCTL_RX_ANT:
-		acx_ioctl_set_rx_antenna(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_TX_ANT:
-		acx_ioctl_set_tx_antenna(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_SET_ED:
-		acx_ioctl_set_ed_threshold(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_SET_CCA:
-		acx_ioctl_set_cca(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_MONITOR:	/* set sniff (monitor) mode */
-		log(L_IOCTL, "%s: IWPRIV monitor\n", dev->name);
-
-		/* can only be done by admin */
-		if (!capable(CAP_NET_ADMIN)) {
-			result = -EPERM;
-			break;
-		}
-		result = acx_ioctl_wlansniff(dev, NULL, NULL, iwr->u.name);
-		break;
-
-	case ACX100_IOCTL_TEST:
-		acx_ioctl_unknown11(dev, NULL, NULL, NULL);
-		break;
-
-	case ACX111_IOCTL_INFO:
-		acx111_ioctl_info(dev, NULL, NULL, NULL);
-		break;
-
-	default:
-		log(L_IOCTL, "wireless ioctl 0x%04X queried "
-				"but not implemented yet\n", cmd);
-		result = -EOPNOTSUPP;
-		break;
-	}
-
-	if ((priv->dev_state_mask & ACX_STATE_IFACE_UP) && priv->set_mask) {
-		acx_sem_lock(priv);
-		acx_s_update_card_settings(priv);
-		acx_sem_unlock(priv);
-	}
-
-	/* older WEs don't have a commit handler,
-	 * so we need to fix return code in this case */
-	if (-EINPROGRESS == result)
-		result = 0;
-
-	return result;
-}
-#endif /* WE < 13 */
--- linux-2.6.15-mm3-full/drivers/net/wireless/tiacx/usb.c.old	2006-01-14 15:57:02.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/net/wireless/tiacx/usb.c	2006-01-14 15:57:31.000000000 +0100
@@ -57,9 +57,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/etherdevice.h>
 #include <linux/wireless.h>
-#if WIRELESS_EXT >= 13
 #include <net/iw_handler.h>
-#endif
 #include <linux/vmalloc.h>
 
 #include "acx.h"
@@ -622,11 +620,7 @@
 	dev->hard_start_xmit = (void *)&acx_i_start_xmit;
 	dev->get_stats = (void *)&acx_e_get_stats;
 	dev->get_wireless_stats = (void *)&acx_e_get_wireless_stats;
-#if WIRELESS_EXT >= 13
 	dev->wireless_handlers = (struct iw_handler_def *)&acx_ioctl_handler_def;
-#else
-	dev->do_ioctl = (void *)&acx_e_ioctl_old;
-#endif
 	dev->set_multicast_list = (void *)&acxusb_i_set_rx_mode;
 #ifdef HAVE_TX_TIMEOUT
 	dev->tx_timeout = &acxusb_i_tx_timeout;

