Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUEXIs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUEXIs4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUEXIra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:47:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:42143 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264165AbUEXId6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:33:58 -0400
Date: Mon, 24 May 2004 04:33:22 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 9/14 linux-2.6.7-rc1] prism54: Fix prism54.org bug 77; strengthened oid transaction
Message-ID: <20040524083322.GJ3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibhTSt8h7StI2D+z"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibhTSt8h7StI2D+z
Content-Type: multipart/mixed; boundary="lh55S0yADJsuIVGW"
Content-Disposition: inline


--lh55S0yADJsuIVGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


2004-04-09      Aurelien Alleaume <slts@free.fr>

* oid_mgt.c, isl_ioctl.c : Cleanups. Bug #77. Minor stuffs.

* islpci_mgt.c (islpci_mgt_transaction) : enforce serialization=20
  in oid transaction. lindent.sh.

* islpci_mgt.c (islpci_mgt_transaction) : Strengthened oid transaction.

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--lh55S0yADJsuIVGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="09-fix-bug-77-enforce-serialization.patch"
Content-Transfer-Encoding: quoted-printable

2004-04-09	Aurelien Alleaume <slts@free.fr>

	* oid_mgt.c, isl_ioctl.c : Cleanups. Bug #77. Minor stuffs.=20

	* islpci_mgt.c (islpci_mgt_transaction) : enforce serialization in oid
	transaction. lindent.sh.=20
=09
	* islpci_mgt.c (islpci_mgt_transaction) : Strengthened oid transaction.

Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v
retrieving revision 1.150
retrieving revision 1.151
diff -u -r1.150 -r1.151
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	22 Mar 2004 11=
:21:22 -0000	1.150
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	9 Apr 2004 11:=
42:25 -0000	1.151
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.150 2004/03/22 1=
1:21:22 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.151 2004/04/09 1=
1:42:25 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *            (C) 2003,2004 Aurelien Alleaume <slts@free.fr>
@@ -204,7 +204,7 @@
=20
 /* Noise floor.
  * I'm not sure if the unit is dBm.
- * Note : If we are not connected, this value seems to be irrevelant. */
+ * Note : If we are not connected, this value seems to be irrelevant. */
=20
 	mgt_get_request(priv, DOT11_OID_NOISEFLOOR, 0, NULL, &r);
 	priv->local_iwstatistics.qual.noise =3D r.u;
@@ -216,8 +216,7 @@
 	data =3D r.ptr;
=20
 	/* copy this MAC to the bss */
-	for (j =3D 0; j < 6; j++)
-		bss.address[j] =3D data[j];
+	memcpy(bss.address, data, 6);
 	kfree(data);
=20
 	/* now ask for the corresponding bss */
@@ -505,7 +504,7 @@
 		return 0;
=20
 	/* Request the device for the supported frequencies
-	 * not really revelant since some devices will report the 5 GHz band
+	 * not really relevant since some devices will report the 5 GHz band
 	 * frequencies even if they don't support them.
 	 */
 	rvalue =3D
@@ -515,21 +514,12 @@
 	range->num_channels =3D freq->nr;
 	range->num_frequency =3D freq->nr;
=20
-	/* Frequencies are not listed in the right order. The reordering is proba=
bly
-	 * firmware dependant and thus should work for everyone.
-	 */
 	m =3D min(IW_MAX_FREQUENCIES, (int) freq->nr);
-	for (i =3D 0; i < m - 12; i++) {
-		range->freq[i].m =3D freq->mhz[12 + i];
-		range->freq[i].e =3D 6;
-		range->freq[i].i =3D i + 1;
-	}
-	for (i =3D m - 12; i < m; i++) {
-		range->freq[i].m =3D freq->mhz[i - m + 12];
+	for (i =3D 0; i < m; i++) {
+		range->freq[i].m =3D freq->mhz[i];
 		range->freq[i].e =3D 6;
-		range->freq[i].i =3D i + 23;
+		range->freq[i].i =3D channel_of_freq(freq->mhz[i]);
 	}
-
 	kfree(freq);
=20
 	rvalue |=3D mgt_get_request(priv, DOT11_OID_SUPPORTEDRATES, 0, NULL, &r);
@@ -1967,60 +1957,6 @@
 }
=20
 int
-prism54_set_maxframeburst(struct net_device *ndev, struct iw_request_info =
*info,
-			  __u32 * uwrq, char *extra)
-{
-	islpci_private *priv =3D netdev_priv(ndev);
-	u32 max_burst;
-
-	max_burst =3D (*uwrq) ? *uwrq : CARD_DEFAULT_MAXFRAMEBURST;
-	mgt_set_request(priv, DOT11_OID_MAXFRAMEBURST, 0, &max_burst);
-
-	return -EINPROGRESS;	/* Call commit handler */
-}
-
-int
-prism54_get_maxframeburst(struct net_device *ndev, struct iw_request_info =
*info,
-			  __u32 * uwrq, char *extra)
-{
-	islpci_private *priv =3D netdev_priv(ndev);
-	union oid_res_t r;
-	int rvalue;
-
-	rvalue =3D mgt_get_request(priv, DOT11_OID_MAXFRAMEBURST, 0, NULL, &r);
-	*uwrq =3D r.u;
-
-	return rvalue;
-}
-
-int
-prism54_set_profile(struct net_device *ndev, struct iw_request_info *info,
-		    __u32 * uwrq, char *extra)
-{
-	islpci_private *priv =3D netdev_priv(ndev);
-	u32 profile;
-
-	profile =3D (*uwrq) ? *uwrq : CARD_DEFAULT_PROFILE;
-	mgt_set_request(priv, DOT11_OID_PROFILES, 0, &profile);
-
-	return -EINPROGRESS;	/* Call commit handler */
-}
-
-int
-prism54_get_profile(struct net_device *ndev, struct iw_request_info *info,
-		    __u32 * uwrq, char *extra)
-{
-	islpci_private *priv =3D netdev_priv(ndev);
-	union oid_res_t r;
-	int rvalue;
-
-	rvalue =3D mgt_get_request(priv, DOT11_OID_PROFILES, 0, NULL, &r);
-	*uwrq =3D r.u;
-
-	return rvalue;
-}
-
-int
 prism54_debug_oid(struct net_device *ndev, struct iw_request_info *info,
 		  __u32 * uwrq, char *extra)
 {
@@ -2099,7 +2035,7 @@
 		}
 	}
=20
-	return ret;
+	return (ret ? ret : -EINPROGRESS);
 }
=20
 static int
@@ -2205,16 +2141,16 @@
 #define PRISM54_GET_PRISMHDR	SIOCIWFIRSTPRIV+23
 #define PRISM54_SET_PRISMHDR	SIOCIWFIRSTPRIV+24
=20
-#define IWPRIV_SET_U32(n,x)	{ n, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1=
, 0, "set_"x }
-#define IWPRIV_SET_SSID(n,x)	{ n, IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED |=
 1, 0, "set_"x }
-#define IWPRIV_SET_ADDR(n,x)	{ n, IW_PRIV_TYPE_ADDR | IW_PRIV_SIZE_FIXED |=
 1, 0, "set_"x }
-#define IWPRIV_GET(n,x)	{ n, 0, IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED | P=
RIV_STR_SIZE, "get_"x }
+#define IWPRIV_SET_U32(n,x)	{ n, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1=
, 0, "s_"x }
+#define IWPRIV_SET_SSID(n,x)	{ n, IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED |=
 1, 0, "s_"x }
+#define IWPRIV_SET_ADDR(n,x)	{ n, IW_PRIV_TYPE_ADDR | IW_PRIV_SIZE_FIXED |=
 1, 0, "s_"x }
+#define IWPRIV_GET(n,x)	{ n, 0, IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED | P=
RIV_STR_SIZE, "g_"x }
=20
 #define IWPRIV_U32(n,x)		IWPRIV_SET_U32(n,x), IWPRIV_GET(n,x)
 #define IWPRIV_SSID(n,x)	IWPRIV_SET_SSID(n,x), IWPRIV_GET(n,x)
 #define IWPRIV_ADDR(n,x)	IWPRIV_SET_ADDR(n,x), IWPRIV_GET(n,x)
=20
-/* Note : limited to 128 private ioctls */
+/* Note : limited to 128 private ioctls (wireless tools 26) */
=20
 static const struct iw_priv_args prism54_private_args[] =3D {
 /*{ cmd, set_args, get_args, name } */
@@ -2352,5 +2288,6 @@
 int
 prism54_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 {
+
 	return -EOPNOTSUPP;
 }
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.c,v
retrieving revision 1.43
retrieving revision 1.44
diff -u -r1.43 -r1.44
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.c	20 Mar 2004 1=
6:58:37 -0000	1.43
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.c	9 Apr 2004 11=
:42:25 -0000	1.44
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.c,v 1.43 2004/03/20 1=
6:58:37 mcgrof Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.c,v 1.44 2004/04/09 1=
1:42:25 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright 2004 Jens Maurer <Jens.Maurer@gmx.net>
@@ -63,7 +63,6 @@
     Queue handling for management frames
 **************************************************************************=
****/
=20
- =20
 /*
  * Helper function to create a PIMFOR management frame header.
  */
@@ -86,8 +85,8 @@
 {
 	pimfor_header_t *h =3D data;
=20
-        while ((void *) h < data + len) {
-		if(h->flags & PIMFOR_FLAG_LITTLE_ENDIAN) {
+	while ((void *) h < data + len) {
+		if (h->flags & PIMFOR_FLAG_LITTLE_ENDIAN) {
 			le32_to_cpus(&h->oid);
 			le32_to_cpus(&h->length);
 		} else {
@@ -108,8 +107,8 @@
 islpci_mgmt_rx_fill(struct net_device *ndev)
 {
 	islpci_private *priv =3D netdev_priv(ndev);
-	isl38xx_control_block *cb =3D    /* volatile not needed */
-		(isl38xx_control_block *) priv->control_block;
+	isl38xx_control_block *cb =3D	/* volatile not needed */
+	    (isl38xx_control_block *) priv->control_block;
 	u32 curr =3D le32_to_cpu(cb->driver_curr_frag[ISL38XX_CB_RX_MGMTQ]);
=20
 #if VERBOSE > SHOW_ERROR_MESSAGES
@@ -124,7 +123,8 @@
 		if (buf->mem =3D=3D NULL) {
 			buf->mem =3D kmalloc(MGMT_FRAME_SIZE, GFP_ATOMIC);
 			if (!buf->mem) {
-				printk(KERN_WARNING "Error allocating management frame.\n");
+				printk(KERN_WARNING
+				       "Error allocating management frame.\n");
 				return -ENOMEM;
 			}
 			buf->size =3D MGMT_FRAME_SIZE;
@@ -133,24 +133,24 @@
 			buf->pci_addr =3D pci_map_single(priv->pdev, buf->mem,
 						       MGMT_FRAME_SIZE,
 						       PCI_DMA_FROMDEVICE);
-			if(!buf->pci_addr) {
-				printk(KERN_WARNING "Failed to make memory DMA'able\n.");
+			if (!buf->pci_addr) {
+				printk(KERN_WARNING
+				       "Failed to make memory DMA'able\n.");
 				return -ENOMEM;
 			}
 		}
=20
-                /* be safe: always reset control block information */
+		/* be safe: always reset control block information */
 		frag->size =3D cpu_to_le16(MGMT_FRAME_SIZE);
 		frag->flags =3D 0;
 		frag->address =3D cpu_to_le32(buf->pci_addr);
 		curr++;
=20
-                /* The fragment address in the control block must have
-                 * been written before announcing the frame buffer to
-                 * device */
+		/* The fragment address in the control block must have
+		 * been written before announcing the frame buffer to
+		 * device */
 		wmb();
-		cb->driver_curr_frag[ISL38XX_CB_RX_MGMTQ] =3D
-			cpu_to_le32(curr);
+		cb->driver_curr_frag[ISL38XX_CB_RX_MGMTQ] =3D cpu_to_le32(curr);
 	}
 	return 0;
 }
@@ -168,7 +168,7 @@
 {
 	islpci_private *priv =3D netdev_priv(ndev);
 	isl38xx_control_block *cb =3D
-		(isl38xx_control_block *) priv->control_block;
+	    (isl38xx_control_block *) priv->control_block;
 	void *p;
 	int err =3D -EINVAL;
 	unsigned long flags;
@@ -242,25 +242,25 @@
 	priv->mgmt_tx[index] =3D buf;
 	frag =3D &cb->tx_data_mgmt[index];
 	frag->size =3D cpu_to_le16(frag_len);
-	frag->flags =3D 0;   /* for any other than the last fragment, set to 1 */
+	frag->flags =3D 0;	/* for any other than the last fragment, set to 1 */
 	frag->address =3D cpu_to_le32(buf.pci_addr);
=20
 	/* The fragment address in the control block must have
 	 * been written before announcing the frame buffer to
 	 * device */
 	wmb();
-	cb->driver_curr_frag[ISL38XX_CB_TX_MGMTQ] =3D cpu_to_le32(curr_frag+1);
+	cb->driver_curr_frag[ISL38XX_CB_TX_MGMTQ] =3D cpu_to_le32(curr_frag + 1);
 	spin_unlock_irqrestore(&priv->slock, flags);
=20
 	/* trigger the device */
 	islpci_trigger(priv);
 	return 0;
=20
- error_unlock:
+      error_unlock:
 	spin_unlock_irqrestore(&priv->slock, flags);
- error_free:
+      error_free:
 	kfree(buf.mem);
- error:
+      error:
 	return err;
 }
=20
@@ -274,50 +274,48 @@
 {
 	islpci_private *priv =3D netdev_priv(ndev);
 	isl38xx_control_block *cb =3D
-		(isl38xx_control_block *) priv->control_block;
+	    (isl38xx_control_block *) priv->control_block;
 	u32 curr_frag;
=20
 #if VERBOSE > SHOW_ERROR_MESSAGES
 	DEBUG(SHOW_FUNCTION_CALLS, "islpci_mgt_receive \n");
 #endif
=20
-
-        /* Only once per interrupt, determine fragment range to
-         * process.  This avoids an endless loop (i.e. lockup) if
-         * frames come in faster than we can process them. */
+	/* Only once per interrupt, determine fragment range to
+	 * process.  This avoids an endless loop (i.e. lockup) if
+	 * frames come in faster than we can process them. */
 	curr_frag =3D le32_to_cpu(cb->device_curr_frag[ISL38XX_CB_RX_MGMTQ]);
 	barrier();
=20
-	for ( ; priv->index_mgmt_rx < curr_frag; priv->index_mgmt_rx++) {
+	for (; priv->index_mgmt_rx < curr_frag; priv->index_mgmt_rx++) {
 		pimfor_header_t *header;
 		u32 index =3D priv->index_mgmt_rx % ISL38XX_CB_MGMT_QSIZE;
 		struct islpci_membuf *buf =3D &priv->mgmt_rx[index];
 		u16 frag_len;
 		int size;
 		struct islpci_mgmtframe *frame;
-             =20
-                /* I have no idea (and no documentation) if flags !=3D 0
-                 * is possible.  Drop the frame, reuse the buffer. */
-                if(le16_to_cpu(cb->rx_data_mgmt[index].flags) !=3D 0) {
-                        printk(KERN_WARNING "%s: unknown flags 0x%04x\n",
-                               ndev->name,
-                               le16_to_cpu(cb->rx_data_mgmt[index].flags));
-                        continue;
-                }
+
+		/* I have no idea (and no documentation) if flags !=3D 0
+		 * is possible.  Drop the frame, reuse the buffer. */
+		if (le16_to_cpu(cb->rx_data_mgmt[index].flags) !=3D 0) {
+			printk(KERN_WARNING "%s: unknown flags 0x%04x\n",
+			       ndev->name,
+			       le16_to_cpu(cb->rx_data_mgmt[index].flags));
+			continue;
+		}
=20
 		/* The device only returns the size of the header(s) here. */
 		frag_len =3D le16_to_cpu(cb->rx_data_mgmt[index].size);
=20
 		/*
-                 * We appear to have no way to tell the device the
-                 * size of a receive buffer.  Thus, if this check
-                 * triggers, we likely have kernel heap corruption. */
-                if (frag_len > MGMT_FRAME_SIZE) {
-                        printk(KERN_WARNING "%s: Bogus packet size of %d (=
%#x).\
-n",
-                               ndev->name, frag_len, frag_len);
-                        frag_len =3D MGMT_FRAME_SIZE;
-                }
+		 * We appear to have no way to tell the device the
+		 * size of a receive buffer.  Thus, if this check
+		 * triggers, we likely have kernel heap corruption. */
+		if (frag_len > MGMT_FRAME_SIZE) {
+			printk(KERN_WARNING "%s: Bogus packet size of %d (%#x).\
+n", ndev->name, frag_len, frag_len);
+			frag_len =3D MGMT_FRAME_SIZE;
+		}
=20
 		/* Ensure the results of device DMA are visible to the CPU. */
 		pci_dma_sync_single(priv->pdev, buf->pci_addr,
@@ -339,30 +337,32 @@
 #if VERBOSE > SHOW_ERROR_MESSAGES
 		DEBUG(SHOW_PIMFOR_FRAMES,
 		      "PIMFOR: op %i, oid 0x%08x, device %i, flags 0x%x length 0x%x \n",
-		      header->operation, header->oid, header->device_id,=20
+		      header->operation, header->oid, header->device_id,
 		      header->flags, header->length);
=20
 		/* display the buffer contents for debugging */
 		display_buffer((char *) header, PIMFOR_HEADER_SIZE);
-		display_buffer((char *) header + PIMFOR_HEADER_SIZE, header->length);
+		display_buffer((char *) header + PIMFOR_HEADER_SIZE,
+			       header->length);
 #endif
=20
 		/* nobody sends these */
 		if (header->flags & PIMFOR_FLAG_APPLIC_ORIGIN) {
-			printk(KERN_DEBUG "%s: errant PIMFOR application frame\n",
+			printk(KERN_DEBUG
+			       "%s: errant PIMFOR application frame\n",
 			       ndev->name);
 			continue;
 		}
=20
 		/* Determine frame size, skipping OID_INL_TUNNEL headers. */
 		size =3D PIMFOR_HEADER_SIZE + header->length;
-		frame =3D kmalloc(sizeof(struct islpci_mgmtframe) + size,
+		frame =3D kmalloc(sizeof (struct islpci_mgmtframe) + size,
 				GFP_ATOMIC);
 		if (!frame) {
-			printk(KERN_WARNING "%s: Out of memory, cannot handle oid 0x%08x\n",
-
+			printk(KERN_WARNING
+			       "%s: Out of memory, cannot handle oid 0x%08x\n",
 			       ndev->name, header->oid);
-			continue;       =20
+			continue;
 		}
 		frame->ndev =3D ndev;
 		memcpy(&frame->buf, header, size);
@@ -382,7 +382,7 @@
 			       header->oid, header->device_id, header->flags,
 			       header->length);
 #endif
-                     =20
+
 			/* Create work to handle trap out of interrupt
 			 * context. */
 			INIT_WORK(&frame->ws, prism54_process_trap, frame);
@@ -392,14 +392,13 @@
 			/* Signal the one waiting process that a response
 			 * has been received. */
 			if ((frame =3D xchg(&priv->mgmt_received, frame)) !=3D NULL) {
-				printk(KERN_WARNING "%s: mgmt response not collected\n",
+				printk(KERN_WARNING
+				       "%s: mgmt response not collected\n",
 				       ndev->name);
 				kfree(frame);
 			}
-                             =20
 #if VERBOSE > SHOW_ERROR_MESSAGES
-			DEBUG(SHOW_TRACING,
-			      "Wake up Mgmt Queue\n");
+			DEBUG(SHOW_TRACING, "Wake up Mgmt Queue\n");
 #endif
 			wake_up(&priv->mgmt_wqueue);
 		}
@@ -416,22 +415,22 @@
 islpci_mgt_cleanup_transmit(struct net_device *ndev)
 {
 	islpci_private *priv =3D netdev_priv(ndev);
-	isl38xx_control_block *cb =3D    /* volatile not needed */
-		(isl38xx_control_block *) priv->control_block;
+	isl38xx_control_block *cb =3D	/* volatile not needed */
+	    (isl38xx_control_block *) priv->control_block;
 	u32 curr_frag;
=20
 #if VERBOSE > SHOW_ERROR_MESSAGES
-        DEBUG(SHOW_FUNCTION_CALLS, "islpci_mgt_cleanup_transmit\n");
+	DEBUG(SHOW_FUNCTION_CALLS, "islpci_mgt_cleanup_transmit\n");
 #endif
=20
 	/* Only once per cleanup, determine fragment range to
 	 * process.  This avoids an endless loop (i.e. lockup) if
 	 * the device became confused, incrementing device_curr_frag
 	 * rapidly. */
-	curr_frag =3D le32_to_cpu(cb->device_curr_frag[ISL38XX_CB_TX_MGMTQ]);=20
+	curr_frag =3D le32_to_cpu(cb->device_curr_frag[ISL38XX_CB_TX_MGMTQ]);
 	barrier();
=20
-	for ( ; priv->index_mgmt_tx < curr_frag; priv->index_mgmt_tx++) {
+	for (; priv->index_mgmt_tx < curr_frag; priv->index_mgmt_tx++) {
 		int index =3D priv->index_mgmt_tx % ISL38XX_CB_MGMT_QSIZE;
 		struct islpci_membuf *buf =3D &priv->mgmt_tx[index];
 		pci_unmap_single(priv->pdev, buf->pci_addr, buf->size,
@@ -462,7 +461,7 @@
=20
 	PRISM_DEFWAITQ(priv->mgmt_wqueue, wait);
 	err =3D islpci_mgt_transmit(ndev, operation, oid, senddata, sendlen);
-	if(err)
+	if (err)
 		goto out;
=20
 	err =3D -ETIMEDOUT;
@@ -473,12 +472,22 @@
 		timeleft =3D schedule_timeout(wait_cycle_jiffies);
 		frame =3D xchg(&priv->mgmt_received, NULL);
 		if (frame) {
-			*recvframe =3D frame;
-			err =3D 0;
-			goto out;
+			if (frame->header->oid =3D=3D oid) {
+				*recvframe =3D frame;
+				err =3D 0;
+				goto out;
+			} else {
+				printk(KERN_DEBUG
+				       "%s: expecting oid 0x%x, received 0x%x.\n",
+				       ndev->name, (unsigned int) oid,
+				       frame->header->oid);
+				kfree(frame);
+				frame =3D NULL;
+			}
 		}
-		if(timeleft =3D=3D 0) {
-			printk(KERN_DEBUG "%s: timeout waiting for mgmt response %lu, trigging =
device\n",
+		if (timeleft =3D=3D 0) {
+			printk(KERN_DEBUG
+			       "%s: timeout waiting for mgmt response %lu, trigging device\n",
 			       ndev->name, timeout_left);
 			islpci_trigger(priv);
 		}
@@ -487,10 +496,9 @@
 	printk(KERN_WARNING "%s: timeout waiting for mgmt response\n",
 	       ndev->name);
=20
-	/* TODO: we should reset the device here */    =20
- out:
+	/* TODO: we should reset the device here */
+      out:
 	PRISM_ENDWAITQ(priv->mgmt_wqueue, wait);
 	up(&priv->mgmt_sem);
 	return err;
 }
-
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/oid_mgt.c,v
retrieving revision 1.13
retrieving revision 1.14
diff -u -r1.13 -r1.14
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c	22 Mar 2004 11:2=
1:22 -0000	1.13
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c	9 Apr 2004 11:42=
:25 -0000	1.14
@@ -40,17 +40,13 @@
 	if ((f >=3D 2412) && (f <=3D 2484)) {
 		while ((c < 14) && (f !=3D frequency_list_bg[c]))
 			c++;
-		if (c >=3D 14)
-			return 0;
+		return (c >=3D 14) ? 0 : ++c;
 	} else if ((f >=3D (int) 5170) && (f <=3D (int) 5320)) {
 		while ((c < 12) && (f !=3D frequency_list_a[c]))
 			c++;
-		if (c >=3D 12)
-			return 0;
+		return (c >=3D 12) ? 0 : (c + 37);
 	} else
 		return 0;
-
-	return ++c;
 }
=20
 #define OID_STRUCT(name,oid,s,t) [name] =3D {oid, 0, sizeof(s), t}

--lh55S0yADJsuIVGW--

--ibhTSt8h7StI2D+z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbNSat1JN+IKUl4RAiHLAJ443XOJfDwRCFhUNHEVz512tIMyfgCgj/7B
BIe7NQiKazNPmvtv7k0e7sk=
=BYKF
-----END PGP SIGNATURE-----

--ibhTSt8h7StI2D+z--
