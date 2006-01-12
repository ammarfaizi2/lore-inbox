Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWALRka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWALRka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWALRka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:40:30 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:62176 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S932481AbWALRkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:40:25 -0500
From: Duncan Sands <baldrick@free.fr>
To: usbatm@lists.infradead.org
Subject: Re: [PATCH 01/13] USBATM: trivial modifications
Date: Thu, 12 Jan 2006 18:40:22 +0100
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200601121729.52596.baldrick@free.fr> <200601121743.30013.baldrick@free.fr>
In-Reply-To: <200601121743.30013.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HSpxDmpW5jZGc+W"
Message-Id: <200601121840.23702.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_HSpxDmpW5jZGc+W
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry, it wasn't a -p1 patch (I should really automate this).

Signed-off-by:	Duncan Sands <baldrick@free.fr>

--Boundary-00=_HSpxDmpW5jZGc+W
Content-Type: text/x-diff;
  charset="iso-8859-6";
  name="trivial"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="trivial"

diff -x '*.orig' -x '*.base' -u -r Linux/drivers/usb/atm.orig/cxacru.c Linux/drivers/usb/atm/cxacru.c
--- Linux/drivers/usb/atm.orig/cxacru.c	2006-01-12 18:27:56.000000000 +0100
+++ Linux/drivers/usb/atm/cxacru.c	2006-01-12 18:25:54.000000000 +0100
@@ -352,7 +352,6 @@
 		struct atm_dev *atm_dev)
 {
 	struct cxacru_data *instance = usbatm_instance->driver_data;
-	struct device *dev = &usbatm_instance->usb_intf->dev;
 	/*
 	struct atm_dev *atm_dev = usbatm_instance->atm_dev;
 	*/
@@ -364,14 +363,14 @@
 	ret = cxacru_cm(instance, CM_REQUEST_CARD_GET_MAC_ADDRESS, NULL, 0,
 			atm_dev->esi, sizeof(atm_dev->esi));
 	if (ret < 0) {
-		dev_err(dev, "cxacru_atm_start: CARD_GET_MAC_ADDRESS returned %d\n", ret);
+		atm_err(usbatm_instance, "cxacru_atm_start: CARD_GET_MAC_ADDRESS returned %d\n", ret);
 		return ret;
 	}
 
 	/* start ADSL */
 	ret = cxacru_cm(instance, CM_REQUEST_CHIP_ADSL_LINE_START, NULL, 0, NULL, 0);
 	if (ret < 0) {
-		dev_err(dev, "cxacru_atm_start: CHIP_ADSL_LINE_START returned %d\n", ret);
+		atm_err(usbatm_instance, "cxacru_atm_start: CHIP_ADSL_LINE_START returned %d\n", ret);
 		return ret;
 	}
 
@@ -383,13 +382,13 @@
 static void cxacru_poll_status(struct cxacru_data *instance)
 {
 	u32 buf[CXINF_MAX] = {};
-	struct device *dev = &instance->usbatm->usb_intf->dev;
-	struct atm_dev *atm_dev = instance->usbatm->atm_dev;
+	struct usbatm_data *usbatm = instance->usbatm;
+	struct atm_dev *atm_dev = usbatm->atm_dev;
 	int ret;
 
 	ret = cxacru_cm_get_array(instance, CM_REQUEST_CARD_INFO_GET, buf, CXINF_MAX);
 	if (ret < 0) {
-		dev_warn(dev, "poll status: error %d\n", ret);
+		atm_warn(usbatm, "poll status: error %d\n", ret);
 		goto reschedule;
 	}
 
@@ -400,50 +399,50 @@
 	switch (instance->line_status) {
 	case 0:
 		atm_dev->signal = ATM_PHY_SIG_LOST;
-		dev_info(dev, "ADSL line: down\n");
+		atm_info(usbatm, "ADSL line: down\n");
 		break;
 
 	case 1:
 		atm_dev->signal = ATM_PHY_SIG_LOST;
-		dev_info(dev, "ADSL line: attemtping to activate\n");
+		atm_info(usbatm, "ADSL line: attempting to activate\n");
 		break;
 
 	case 2:
 		atm_dev->signal = ATM_PHY_SIG_LOST;
-		dev_info(dev, "ADSL line: training\n");
+		atm_info(usbatm, "ADSL line: training\n");
 		break;
 
 	case 3:
 		atm_dev->signal = ATM_PHY_SIG_LOST;
-		dev_info(dev, "ADSL line: channel analysis\n");
+		atm_info(usbatm, "ADSL line: channel analysis\n");
 		break;
 
 	case 4:
 		atm_dev->signal = ATM_PHY_SIG_LOST;
-		dev_info(dev, "ADSL line: exchange\n");
+		atm_info(usbatm, "ADSL line: exchange\n");
 		break;
 
 	case 5:
 		atm_dev->link_rate = buf[CXINF_DOWNSTREAM_RATE] * 1000 / 424;
 		atm_dev->signal = ATM_PHY_SIG_FOUND;
 
-		dev_info(dev, "ADSL line: up (%d kb/s down | %d kb/s up)\n",
+		atm_info(usbatm, "ADSL line: up (%d kb/s down | %d kb/s up)\n",
 		     buf[CXINF_DOWNSTREAM_RATE], buf[CXINF_UPSTREAM_RATE]);
 		break;
 
 	case 6:
 		atm_dev->signal = ATM_PHY_SIG_LOST;
-		dev_info(dev, "ADSL line: waiting\n");
+		atm_info(usbatm, "ADSL line: waiting\n");
 		break;
 
 	case 7:
 		atm_dev->signal = ATM_PHY_SIG_LOST;
-		dev_info(dev, "ADSL line: initializing\n");
+		atm_info(usbatm, "ADSL line: initializing\n");
 		break;
 
 	default:
 		atm_dev->signal = ATM_PHY_SIG_UNKNOWN;
-		dev_info(dev, "Unknown line state %02x\n", instance->line_status);
+		atm_info(usbatm, "Unknown line state %02x\n", instance->line_status);
 		break;
 	}
 reschedule:
@@ -504,8 +503,8 @@
 {
 	int ret;
 	int off;
-	struct usb_device *usb_dev = instance->usbatm->usb_dev;
-	struct device *dev = &instance->usbatm->usb_intf->dev;
+	struct usbatm_data *usbatm = instance->usbatm;
+	struct usb_device *usb_dev = usbatm->usb_dev;
 	u16 signature[] = { usb_dev->descriptor.idVendor, usb_dev->descriptor.idProduct };
 	u32 val;
 
@@ -515,7 +514,7 @@
 	val = cpu_to_le32(instance->modem_type->pll_f_clk);
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, PLLFCLK_ADDR, (u8 *) &val, 4);
 	if (ret) {
-		dev_err(dev, "FirmwarePllFClkValue failed: %d\n", ret);
+		usb_err(usbatm, "FirmwarePllFClkValue failed: %d\n", ret);
 		return;
 	}
 
@@ -523,7 +522,7 @@
 	val = cpu_to_le32(instance->modem_type->pll_b_clk);
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, PLLBCLK_ADDR, (u8 *) &val, 4);
 	if (ret) {
-		dev_err(dev, "FirmwarePllBClkValue failed: %d\n", ret);
+		usb_err(usbatm, "FirmwarePllBClkValue failed: %d\n", ret);
 		return;
 	}
 
@@ -531,14 +530,14 @@
 	val = cpu_to_le32(SDRAM_ENA);
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, SDRAMEN_ADDR, (u8 *) &val, 4);
 	if (ret) {
-		dev_err(dev, "Enable SDRAM failed: %d\n", ret);
+		usb_err(usbatm, "Enable SDRAM failed: %d\n", ret);
 		return;
 	}
 
 	/* Firmware */
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, FW_ADDR, fw->data, fw->size);
 	if (ret) {
-		dev_err(dev, "Firmware upload failed: %d\n", ret);
+		usb_err(usbatm, "Firmware upload failed: %d\n", ret);
 		return;
 	}
 
@@ -546,7 +545,7 @@
 	if (instance->modem_type->boot_rom_patch) {
 		ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, BR_ADDR, bp->data, bp->size);
 		if (ret) {
-			dev_err(dev, "Boot ROM patching failed: %d\n", ret);
+			usb_err(usbatm, "Boot ROM patching failed: %d\n", ret);
 			return;
 		}
 	}
@@ -554,7 +553,7 @@
 	/* Signature */
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, SIG_ADDR, (u8 *) signature, 4);
 	if (ret) {
-		dev_err(dev, "Signature storing failed: %d\n", ret);
+		usb_err(usbatm, "Signature storing failed: %d\n", ret);
 		return;
 	}
 
@@ -566,7 +565,7 @@
 		ret = cxacru_fw(usb_dev, FW_GOTO_MEM, 0x0, 0x0, FW_ADDR, NULL, 0);
 	}
 	if (ret) {
-		dev_err(dev, "Passing control to firmware failed: %d\n", ret);
+		usb_err(usbatm, "Passing control to firmware failed: %d\n", ret);
 		return;
 	}
 
@@ -580,7 +579,7 @@
 
 	ret = cxacru_cm(instance, CM_REQUEST_CARD_GET_STATUS, NULL, 0, NULL, 0);
 	if (ret < 0) {
-		dev_err(dev, "modem failed to initialize: %d\n", ret);
+		usb_err(usbatm, "modem failed to initialize: %d\n", ret);
 		return;
 	}
 
@@ -597,7 +596,7 @@
 			ret = cxacru_cm(instance, CM_REQUEST_CARD_DATA_SET,
 					(u8 *) buf, len, NULL, 0);
 			if (ret < 0) {
-				dev_err(dev, "load config data failed: %d\n", ret);
+				usb_err(usbatm, "load config data failed: %d\n", ret);
 				return;
 			}
 		}
@@ -608,18 +607,19 @@
 static int cxacru_find_firmware(struct cxacru_data *instance,
 				char* phase, const struct firmware **fw_p)
 {
-	struct device *dev = &instance->usbatm->usb_intf->dev;
+	struct usbatm_data *usbatm = instance->usbatm;
+	struct device *dev = &usbatm->usb_intf->dev;
 	char buf[16];
 
 	sprintf(buf, "cxacru-%s.bin", phase);
 	dbg("cxacru_find_firmware: looking for %s", buf);
 
 	if (request_firmware(fw_p, buf, dev)) {
-		dev_dbg(dev, "no stage %s firmware found\n", phase);
+		usb_dbg(usbatm, "no stage %s firmware found\n", phase);
 		return -ENOENT;
 	}
 
-	dev_info(dev, "found firmware %s\n", buf);
+	usb_info(usbatm, "found firmware %s\n", buf);
 
 	return 0;
 }
@@ -627,20 +627,19 @@
 static int cxacru_heavy_init(struct usbatm_data *usbatm_instance,
 			     struct usb_interface *usb_intf)
 {
-	struct device *dev = &usbatm_instance->usb_intf->dev;
 	const struct firmware *fw, *bp, *cf;
 	struct cxacru_data *instance = usbatm_instance->driver_data;
 
 	int ret = cxacru_find_firmware(instance, "fw", &fw);
 	if (ret) {
-		dev_warn(dev, "firmware (cxacru-fw.bin) unavailable (hotplug misconfiguration?)\n");
+		usb_warn(usbatm_instance, "firmware (cxacru-fw.bin) unavailable (system misconfigured?)\n");
 		return ret;
 	}
 
 	if (instance->modem_type->boot_rom_patch) {
 		ret = cxacru_find_firmware(instance, "bp", &bp);
 		if (ret) {
-			dev_warn(dev, "boot ROM patch (cxacru-bp.bin) unavailable (hotplug misconfiguration?)\n");
+			usb_warn(usbatm_instance, "boot ROM patch (cxacru-bp.bin) unavailable (system misconfigured?)\n");
 			release_firmware(fw);
 			return ret;
 		}
@@ -787,12 +786,12 @@
 	{ /* V = Conexant			P = ADSL modem (Hasbani project)	*/
 		USB_DEVICE(0x0572, 0xcb00),	.driver_info = (unsigned long) &cxacru_cb00
 	},
-	{ /* V = Conexant             P = ADSL modem (Well PTI-800 */
-		USB_DEVICE(0x0572, 0xcb02),	.driver_info = (unsigned long) &cxacru_cb00
-	},
 	{ /* V = Conexant			P = ADSL modem				*/
 		USB_DEVICE(0x0572, 0xcb01),	.driver_info = (unsigned long) &cxacru_cb00
 	},
+	{ /* V = Conexant			P = ADSL modem (Well PTI-800) */
+		USB_DEVICE(0x0572, 0xcb02),	.driver_info = (unsigned long) &cxacru_cb00
+	},
 	{ /* V = Conexant			P = ADSL modem				*/
 		USB_DEVICE(0x0572, 0xcb06),	.driver_info = (unsigned long) &cxacru_cb00
 	},
diff -x '*.orig' -x '*.base' -u -r Linux/drivers/usb/atm.orig/speedtch.c Linux/drivers/usb/atm/speedtch.c
--- Linux/drivers/usb/atm.orig/speedtch.c	2006-01-12 18:27:56.000000000 +0100
+++ Linux/drivers/usb/atm/speedtch.c	2006-01-12 18:25:54.000000000 +0100
@@ -205,7 +205,7 @@
 				   buffer, 0x200, &actual_length, 2000);
 
 		if (ret < 0 && ret != -ETIMEDOUT)
-			usb_dbg(usbatm, "%s: read BLOCK0 from modem failed (%d)!\n", __func__, ret);
+			usb_warn(usbatm, "%s: read BLOCK0 from modem failed (%d)!\n", __func__, ret);
 		else
 			usb_dbg(usbatm, "%s: BLOCK0 downloaded (%d bytes)\n", __func__, ret);
 	}
@@ -219,7 +219,7 @@
 				   buffer, thislen, &actual_length, DATA_TIMEOUT);
 
 		if (ret < 0) {
-			usb_dbg(usbatm, "%s: write BLOCK1 to modem failed (%d)!\n", __func__, ret);
+			usb_err(usbatm, "%s: write BLOCK1 to modem failed (%d)!\n", __func__, ret);
 			goto out_free;
 		}
 		usb_dbg(usbatm, "%s: BLOCK1 uploaded (%zu bytes)\n", __func__, fw1->size);
@@ -232,7 +232,7 @@
 			   buffer, 0x200, &actual_length, DATA_TIMEOUT);
 
 	if (ret < 0) {
-		usb_dbg(usbatm, "%s: read BLOCK2 from modem failed (%d)!\n", __func__, ret);
+		usb_err(usbatm, "%s: read BLOCK2 from modem failed (%d)!\n", __func__, ret);
 		goto out_free;
 	}
 	usb_dbg(usbatm, "%s: BLOCK2 downloaded (%d bytes)\n", __func__, actual_length);
@@ -246,7 +246,7 @@
 				   buffer, thislen, &actual_length, DATA_TIMEOUT);
 
 		if (ret < 0) {
-			usb_dbg(usbatm, "%s: write BLOCK3 to modem failed (%d)!\n", __func__, ret);
+			usb_err(usbatm, "%s: write BLOCK3 to modem failed (%d)!\n", __func__, ret);
 			goto out_free;
 		}
 	}
@@ -259,7 +259,7 @@
 			   buffer, 0x200, &actual_length, DATA_TIMEOUT);
 
 	if (ret < 0) {
-		usb_dbg(usbatm, "%s: read BLOCK4 from modem failed (%d)!\n", __func__, ret);
+		usb_err(usbatm, "%s: read BLOCK4 from modem failed (%d)!\n", __func__, ret);
 		goto out_free;
 	}
 
@@ -285,8 +285,8 @@
 	return ret;
 }
 
-static int speedtch_find_firmware(struct usb_interface *intf, int phase,
-				  const struct firmware **fw_p)
+static int speedtch_find_firmware(struct usbatm_data *usbatm, struct usb_interface *intf,
+				  int phase, const struct firmware **fw_p)
 {
 	struct device *dev = &intf->dev;
 	const u16 bcdDevice = le16_to_cpu(interface_to_usbdev(intf)->descriptor.bcdDevice);
@@ -295,24 +295,24 @@
 	char buf[24];
 
 	sprintf(buf, "speedtch-%d.bin.%x.%02x", phase, major_revision, minor_revision);
-	dev_dbg(dev, "%s: looking for %s\n", __func__, buf);
+	usb_dbg(usbatm, "%s: looking for %s\n", __func__, buf);
 
 	if (request_firmware(fw_p, buf, dev)) {
 		sprintf(buf, "speedtch-%d.bin.%x", phase, major_revision);
-		dev_dbg(dev, "%s: looking for %s\n", __func__, buf);
+		usb_dbg(usbatm, "%s: looking for %s\n", __func__, buf);
 
 		if (request_firmware(fw_p, buf, dev)) {
 			sprintf(buf, "speedtch-%d.bin", phase);
-			dev_dbg(dev, "%s: looking for %s\n", __func__, buf);
+			usb_dbg(usbatm, "%s: looking for %s\n", __func__, buf);
 
 			if (request_firmware(fw_p, buf, dev)) {
-				dev_warn(dev, "no stage %d firmware found!\n", phase);
+				usb_err(usbatm, "%s: no stage %d firmware found!\n", __func__, phase);
 				return -ENOENT;
 			}
 		}
 	}
 
-	dev_info(dev, "found stage %d firmware %s\n", phase, buf);
+	usb_info(usbatm, "found stage %d firmware %s\n", phase, buf);
 
 	return 0;
 }
@@ -323,15 +323,16 @@
 	struct speedtch_instance_data *instance = usbatm->driver_data;
 	int ret;
 
-	if ((ret = speedtch_find_firmware(intf, 1, &fw1)) < 0)
-			return ret;
+	if ((ret = speedtch_find_firmware(usbatm, intf, 1, &fw1)) < 0)
+		return ret;
 
-	if ((ret = speedtch_find_firmware(intf, 2, &fw2)) < 0) {
+	if ((ret = speedtch_find_firmware(usbatm, intf, 2, &fw2)) < 0) {
 		release_firmware(fw1);
 		return ret;
 	}
 
-	ret = speedtch_upload_firmware(instance, fw1, fw2);
+	if ((ret = speedtch_upload_firmware(instance, fw1, fw2)) < 0)
+		usb_err(usbatm, "%s: firmware upload failed (%d)!\n", __func__, ret);
 
 	release_firmware(fw2);
 	release_firmware(fw1);
@@ -428,7 +429,9 @@
 	int down_speed, up_speed, ret;
 	unsigned char status;
 
+#ifdef VERBOSE_DEBUG
 	atm_dbg(usbatm, "%s entered\n", __func__);
+#endif
 
 	ret = speedtch_read_status(instance);
 	if (ret < 0) {
@@ -441,9 +444,9 @@
 
 	status = buf[OFFSET_7];
 
-	atm_dbg(usbatm, "%s: line state %02x\n", __func__, status);
-
 	if ((status != instance->last_status) || !status) {
+		atm_dbg(usbatm, "%s: line state 0x%02x\n", __func__, status);
+
 		switch (status) {
 		case 0:
 			atm_dev->signal = ATM_PHY_SIG_LOST;
@@ -484,7 +487,7 @@
 
 		default:
 			atm_dev->signal = ATM_PHY_SIG_UNKNOWN;
-			atm_info(usbatm, "Unknown line state %02x\n", status);
+			atm_info(usbatm, "unknown line state %02x\n", status);
 			break;
 		}
 
@@ -690,8 +693,10 @@
 
 	usb_dbg(usbatm, "%s entered\n", __func__);
 
+	/* sanity checks */
+
 	if (usb_dev->descriptor.bDeviceClass != USB_CLASS_VENDOR_SPEC) {
-		usb_dbg(usbatm, "%s: wrong device class %d\n", __func__, usb_dev->descriptor.bDeviceClass);
+		usb_err(usbatm, "%s: wrong device class %d\n", __func__, usb_dev->descriptor.bDeviceClass);
 		return -ENODEV;
 	}
 
@@ -704,7 +709,7 @@
 			ret = usb_driver_claim_interface(&speedtch_usb_driver, cur_intf, usbatm);
 
 			if (ret < 0) {
-				usb_dbg(usbatm, "%s: failed to claim interface %d (%d)\n", __func__, i, ret);
+				usb_err(usbatm, "%s: failed to claim interface %2d (%d)!\n", __func__, i, ret);
 				speedtch_release_interfaces(usb_dev, i);
 				return ret;
 			}
@@ -714,7 +719,7 @@
 	instance = kmalloc(sizeof(*instance), GFP_KERNEL);
 
 	if (!instance) {
-		usb_dbg(usbatm, "%s: no memory for instance data!\n", __func__);
+		usb_err(usbatm, "%s: no memory for instance data!\n", __func__);
 		ret = -ENOMEM;
 		goto fail_release;
 	}
@@ -754,8 +759,10 @@
 	usb_dbg(usbatm, "%s: firmware %s loaded\n", __func__, need_heavy_init ? "not" : "already");
 
 	if (*need_heavy_init)
-		if ((ret = usb_reset_device(usb_dev)) < 0)
+		if ((ret = usb_reset_device(usb_dev)) < 0) {
+			usb_err(usbatm, "%s: device reset failed (%d)!\n", __func__, ret);
 			goto fail_free;
+		}
 
         usbatm->driver_data = instance;
 
diff -x '*.orig' -x '*.base' -u -r Linux/drivers/usb/atm.orig/usbatm.c Linux/drivers/usb/atm/usbatm.c
--- Linux/drivers/usb/atm.orig/usbatm.c	2006-01-12 18:27:56.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.c	2006-01-12 18:25:54.000000000 +0100
@@ -166,10 +166,10 @@
 
 /* ATM */
 
-static void usbatm_atm_dev_close(struct atm_dev *dev);
+static void usbatm_atm_dev_close(struct atm_dev *atm_dev);
 static int usbatm_atm_open(struct atm_vcc *vcc);
 static void usbatm_atm_close(struct atm_vcc *vcc);
-static int usbatm_atm_ioctl(struct atm_dev *dev, unsigned int cmd, void __user * arg);
+static int usbatm_atm_ioctl(struct atm_dev *atm_dev, unsigned int cmd, void __user * arg);
 static int usbatm_atm_send(struct atm_vcc *vcc, struct sk_buff *skb);
 static int usbatm_atm_proc_read(struct atm_dev *atm_dev, loff_t * pos, char *page);
 
@@ -234,8 +234,9 @@
 
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
 	if (ret) {
-		atm_dbg(channel->usbatm, "%s: urb 0x%p submission failed (%d)!\n",
-			__func__, urb, ret);
+		if (printk_ratelimit())
+			atm_warn(channel->usbatm, "%s: urb 0x%p submission failed (%d)!\n",
+				__func__, urb, ret);
 
 		/* consider all errors transient and return the buffer back to the queue */
 		urb->status = -EAGAIN;
@@ -269,10 +270,13 @@
 
 	spin_unlock_irqrestore(&channel->lock, flags);
 
-	if (unlikely(urb->status))
+	if (unlikely(urb->status)) {
+		if (printk_ratelimit())
+			atm_warn(channel->usbatm, "%s: urb 0x%p failed (%d)!\n",
+				__func__, urb, urb->status);
 		/* throttle processing in case of an error */
 		mod_timer(&channel->delay, jiffies + msecs_to_jiffies(THROTTLE_MSECS));
-	else
+	} else
 		tasklet_schedule(&channel->tasklet);
 }
 
@@ -284,11 +288,11 @@
 static inline struct usbatm_vcc_data *usbatm_find_vcc(struct usbatm_data *instance,
 						  short vpi, int vci)
 {
-	struct usbatm_vcc_data *vcc;
+	struct usbatm_vcc_data *vcc_data;
 
-	list_for_each_entry(vcc, &instance->vcc_list, list)
-		if ((vcc->vci == vci) && (vcc->vpi == vpi))
-			return vcc;
+	list_for_each_entry(vcc_data, &instance->vcc_list, list)
+		if ((vcc_data->vci == vci) && (vcc_data->vpi == vpi))
+			return vcc_data;
 	return NULL;
 }
 
@@ -317,7 +321,7 @@
 			cached_vcc = usbatm_find_vcc(instance, vpi, vci);
 
 			if (!cached_vcc)
-				atm_dbg(instance, "%s: unknown vpi/vci (%hd/%d)!\n", __func__, vpi, vci);
+				atm_rldbg(instance, "%s: unknown vpi/vci (%hd/%d)!\n", __func__, vpi, vci);
 		}
 
 		if (!cached_vcc)
@@ -327,7 +331,9 @@
 
 		/* OAM F5 end-to-end */
 		if (pti == ATM_PTI_E2EF5) {
-			atm_warn(instance, "%s: OAM not supported (vpi %d, vci %d)!\n", __func__, vpi, vci);
+			if (printk_ratelimit())
+				atm_warn(instance, "%s: OAM not supported (vpi %d, vci %d)!\n",
+					__func__, vpi, vci);
 			atomic_inc(&vcc->stats->rx_err);
 			continue;
 		}
@@ -335,7 +341,7 @@
 		sarb = cached_vcc->sarb;
 
 		if (sarb->tail + ATM_CELL_PAYLOAD > sarb->end) {
-			atm_dbg(instance, "%s: buffer overrun (sarb->len %u, vcc: 0x%p)!\n",
+			atm_rldbg(instance, "%s: buffer overrun (sarb->len %u, vcc: 0x%p)!\n",
 					__func__, sarb->len, vcc);
 			/* discard cells already received */
 			skb_trim(sarb, 0);
@@ -354,7 +360,7 @@
 
 			/* guard against overflow */
 			if (length > ATM_MAX_AAL5_PDU) {
-				atm_dbg(instance, "%s: bogus length %u (vcc: 0x%p)!\n",
+				atm_rldbg(instance, "%s: bogus length %u (vcc: 0x%p)!\n",
 						__func__, length, vcc);
 				atomic_inc(&vcc->stats->rx_err);
 				goto out;
@@ -363,14 +369,14 @@
 			pdu_length = usbatm_pdu_length(length);
 
 			if (sarb->len < pdu_length) {
-				atm_dbg(instance, "%s: bogus pdu_length %u (sarb->len: %u, vcc: 0x%p)!\n",
+				atm_rldbg(instance, "%s: bogus pdu_length %u (sarb->len: %u, vcc: 0x%p)!\n",
 						__func__, pdu_length, sarb->len, vcc);
 				atomic_inc(&vcc->stats->rx_err);
 				goto out;
 			}
 
 			if (crc32_be(~0, sarb->tail - pdu_length, pdu_length) != 0xc704dd7b) {
-				atm_dbg(instance, "%s: packet failed crc check (vcc: 0x%p)!\n",
+				atm_rldbg(instance, "%s: packet failed crc check (vcc: 0x%p)!\n",
 						__func__, vcc);
 				atomic_inc(&vcc->stats->rx_err);
 				goto out;
@@ -379,7 +385,9 @@
 			vdbg("%s: got packet (length: %u, pdu_length: %u, vcc: 0x%p)", __func__, length, pdu_length, vcc);
 
 			if (!(skb = dev_alloc_skb(length))) {
-				atm_dbg(instance, "%s: no memory for skb (length: %u)!\n", __func__, length);
+				if (printk_ratelimit())
+					atm_err(instance, "%s: no memory for skb (length: %u)!\n",
+							__func__, length);
 				atomic_inc(&vcc->stats->rx_drop);
 				goto out;
 			}
@@ -387,7 +395,8 @@
 			vdbg("%s: allocated new sk_buff (skb: 0x%p, skb->truesize: %u)", __func__, skb, skb->truesize);
 
 			if (!atm_charge(vcc, skb->truesize)) {
-				atm_dbg(instance, "%s: failed atm_charge (skb->truesize: %u)!\n", __func__, skb->truesize);
+				atm_rldbg(instance, "%s: failed atm_charge (skb->truesize: %u)!\n",
+						__func__, skb->truesize);
 				dev_kfree_skb(skb);
 				goto out;	/* atm_charge increments rx_drop */
 			}
@@ -600,13 +609,13 @@
 	}
 
 	if (vcc->qos.aal != ATM_AAL5) {
-		atm_dbg(instance, "%s: unsupported ATM type %d!\n", __func__, vcc->qos.aal);
+		atm_rldbg(instance, "%s: unsupported ATM type %d!\n", __func__, vcc->qos.aal);
 		err = -EINVAL;
 		goto fail;
 	}
 
 	if (skb->len > ATM_MAX_AAL5_PDU) {
-		atm_dbg(instance, "%s: packet too long (%d vs %d)!\n",
+		atm_rldbg(instance, "%s: packet too long (%d vs %d)!\n",
 				__func__, skb->len, ATM_MAX_AAL5_PDU);
 		err = -EINVAL;
 		goto fail;
@@ -665,16 +674,16 @@
 **  ATM  **
 **********/
 
-static void usbatm_atm_dev_close(struct atm_dev *dev)
+static void usbatm_atm_dev_close(struct atm_dev *atm_dev)
 {
-	struct usbatm_data *instance = dev->dev_data;
+	struct usbatm_data *instance = atm_dev->dev_data;
 
 	dbg("%s", __func__);
 
 	if (!instance)
 		return;
 
-	dev->dev_data = NULL;
+	atm_dev->dev_data = NULL; /* catch bugs */
 	usbatm_put_instance(instance);	/* taken in usbatm_atm_init */
 }
 
@@ -735,13 +744,18 @@
 	atm_dbg(instance, "%s: vpi %hd, vci %d\n", __func__, vpi, vci);
 
 	/* only support AAL5 */
-	if ((vcc->qos.aal != ATM_AAL5) || (vcc->qos.rxtp.max_sdu < 0)
-	    || (vcc->qos.rxtp.max_sdu > ATM_MAX_AAL5_PDU)) {
-		atm_dbg(instance, "%s: unsupported ATM type %d!\n", __func__, vcc->qos.aal);
+	if ((vcc->qos.aal != ATM_AAL5)) {
+		atm_warn(instance, "%s: unsupported ATM type %d!\n", __func__, vcc->qos.aal);
+		return -EINVAL;
+	}
+
+	/* sanity checks */
+	if ((vcc->qos.rxtp.max_sdu < 0) || (vcc->qos.rxtp.max_sdu > ATM_MAX_AAL5_PDU)) {
+		atm_dbg(instance, "%s: max_sdu %d out of range!\n", __func__, vcc->qos.rxtp.max_sdu);
 		return -EINVAL;
 	}
 
-	down(&instance->serialize);	/* vs self, usbatm_atm_close */
+	down(&instance->serialize);	/* vs self, usbatm_atm_close, usbatm_usb_disconnect */
 
 	if (usbatm_find_vcc(instance, vpi, vci)) {
 		atm_dbg(instance, "%s: %hd/%d already in use!\n", __func__, vpi, vci);
@@ -750,7 +764,7 @@
 	}
 
 	if (!(new = kmalloc(sizeof(struct usbatm_vcc_data), GFP_KERNEL))) {
-		atm_dbg(instance, "%s: no memory for vcc_data!\n", __func__);
+		atm_err(instance, "%s: no memory for vcc_data!\n", __func__);
 		ret = -ENOMEM;
 		goto fail;
 	}
@@ -762,7 +776,7 @@
 
 	new->sarb = alloc_skb(usbatm_pdu_length(vcc->qos.rxtp.max_sdu), GFP_KERNEL);
 	if (!new->sarb) {
-		atm_dbg(instance, "%s: no memory for SAR buffer!\n", __func__);
+		atm_err(instance, "%s: no memory for SAR buffer!\n", __func__);
 		ret = -ENOMEM;
 		goto fail;
 	}
@@ -806,7 +820,7 @@
 
 	usbatm_cancel_send(instance, vcc);
 
-	down(&instance->serialize);	/* vs self, usbatm_atm_open */
+	down(&instance->serialize);	/* vs self, usbatm_atm_open, usbatm_usb_disconnect */
 
 	tasklet_disable(&instance->rx_channel.tasklet);
 	list_del(&vcc_data->list);
@@ -829,7 +843,7 @@
 	atm_dbg(instance, "%s successful\n", __func__);
 }
 
-static int usbatm_atm_ioctl(struct atm_dev *dev, unsigned int cmd,
+static int usbatm_atm_ioctl(struct atm_dev *atm_dev, unsigned int cmd,
 			  void __user * arg)
 {
 	switch (cmd) {
@@ -845,10 +859,13 @@
 	struct atm_dev *atm_dev;
 	int ret, i;
 
-	/* ATM init */
+	/* ATM init.  The ATM initialization scheme suffers from an intrinsic race
+	 * condition: callbacks we register can be executed at once, before we have
+	 * initialized the struct atm_dev.  To protect against this, all callbacks
+	 * abort if atm_dev->dev_data is NULL. */
 	atm_dev = atm_dev_register(instance->driver_name, &usbatm_atm_devops, -1, NULL);
 	if (!atm_dev) {
-		usb_dbg(instance, "%s: failed to register ATM device!\n", __func__);
+		usb_err(instance, "%s: failed to register ATM device!\n", __func__);
 		return -1;
 	}
 
@@ -862,12 +879,13 @@
 	atm_dev->link_rate = 128 * 1000 / 424;
 
 	if (instance->driver->atm_start && ((ret = instance->driver->atm_start(instance, atm_dev)) < 0)) {
-		atm_dbg(instance, "%s: atm_start failed: %d!\n", __func__, ret);
+		atm_err(instance, "%s: atm_start failed: %d!\n", __func__, ret);
 		goto fail;
 	}
 
-	/* ready for ATM callbacks */
 	usbatm_get_instance(instance);	/* dropped in usbatm_atm_dev_close */
+
+	/* ready for ATM callbacks */
 	mb();
 	atm_dev->dev_data = instance;
 
@@ -915,7 +933,7 @@
 	int ret = kernel_thread(usbatm_do_heavy_init, instance, CLONE_KERNEL);
 
 	if (ret < 0) {
-		usb_dbg(instance, "%s: failed to create kernel_thread (%d)!\n", __func__, ret);
+		usb_err(instance, "%s: failed to create kernel_thread (%d)!\n", __func__, ret);
 		return ret;
 	}
 
@@ -953,7 +971,7 @@
 	int i, length;
 	int need_heavy;
 
-	dev_dbg(dev, "%s: trying driver %s with vendor=0x%x, product=0x%x, ifnum %d\n",
+	dev_dbg(dev, "%s: trying driver %s with vendor=%04x, product=%04x, ifnum %2d\n",
 			__func__, driver->driver_name,
 			le16_to_cpu(usb_dev->descriptor.idVendor),
 			le16_to_cpu(usb_dev->descriptor.idProduct),
@@ -962,7 +980,7 @@
 	/* instance init */
 	instance = kzalloc(sizeof(*instance) + sizeof(struct urb *) * (num_rcv_urbs + num_snd_urbs), GFP_KERNEL);
 	if (!instance) {
-		dev_dbg(dev, "%s: no memory for instance data!\n", __func__);
+		dev_err(dev, "%s: no memory for instance data!\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -998,7 +1016,7 @@
  bind:
 	need_heavy = 1;
 	if (driver->bind && (error = driver->bind(instance, intf, id, &need_heavy)) < 0) {
-			dev_dbg(dev, "%s: bind failed: %d!\n", __func__, error);
+			dev_err(dev, "%s: bind failed: %d!\n", __func__, error);
 			goto fail_free;
 	}
 
@@ -1044,7 +1062,7 @@
 
 		urb = usb_alloc_urb(iso_packets, GFP_KERNEL);
 		if (!urb) {
-			dev_dbg(dev, "%s: no memory for urb %d!\n", __func__, i);
+			dev_err(dev, "%s: no memory for urb %d!\n", __func__, i);
 			goto fail_unbind;
 		}
 
@@ -1052,9 +1070,10 @@
 
 		buffer = kmalloc(channel->buf_size, GFP_KERNEL);
 		if (!buffer) {
-			dev_dbg(dev, "%s: no memory for buffer %d!\n", __func__, i);
+			dev_err(dev, "%s: no memory for buffer %d!\n", __func__, i);
 			goto fail_unbind;
 		}
+		/* zero the tx padding to avoid leaking information */
 		memset(buffer, 0, channel->buf_size);
 
 		usb_fill_bulk_urb(urb, instance->usb_dev, channel->endpoint,
diff -x '*.orig' -x '*.base' -u -r Linux/drivers/usb/atm.orig/usbatm.h Linux/drivers/usb/atm/usbatm.h
--- Linux/drivers/usb/atm.orig/usbatm.h	2006-01-12 18:27:56.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.h	2006-01-12 18:25:54.000000000 +0100
@@ -24,22 +24,21 @@
 #ifndef	_USBATM_H_
 #define	_USBATM_H_
 
-#include <linux/config.h>
-
-/*
-#define VERBOSE_DEBUG
-*/
-
 #include <asm/semaphore.h>
 #include <linux/atm.h>
 #include <linux/atmdev.h>
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/stringify.h>
 #include <linux/usb.h>
 
+/*
+#define VERBOSE_DEBUG
+*/
+
 #ifdef DEBUG
 #define UDSL_ASSERT(x)	BUG_ON(!(x))
 #else
@@ -52,8 +51,13 @@
 	dev_info(&(instance)->usb_intf->dev , format , ## arg)
 #define usb_warn(instance, format, arg...)	\
 	dev_warn(&(instance)->usb_intf->dev , format , ## arg)
+#ifdef DEBUG
+#define usb_dbg(instance, format, arg...)	\
+        dev_printk(KERN_DEBUG , &(instance)->usb_intf->dev , format , ## arg)
+#else
 #define usb_dbg(instance, format, arg...)	\
-	dev_dbg(&(instance)->usb_intf->dev , format , ## arg)
+	do {} while (0)
+#endif
 
 /* FIXME: move to dev_* once ATM is driver model aware */
 #define atm_printk(level, instance, format, arg...)	\
@@ -69,9 +73,14 @@
 #ifdef DEBUG
 #define atm_dbg(instance, format, arg...)	\
 	atm_printk(KERN_DEBUG, instance , format , ## arg)
+#define atm_rldbg(instance, format, arg...)	\
+	if (printk_ratelimit())				\
+		atm_printk(KERN_DEBUG, instance , format , ## arg)
 #else
 #define atm_dbg(instance, format, arg...)	\
 	do {} while (0)
+#define atm_rldbg(instance, format, arg...)	\
+	do {} while (0)
 #endif
 
 
@@ -171,7 +180,7 @@
 	struct usbatm_channel tx_channel;
 
 	struct sk_buff_head sndqueue;
-	struct sk_buff *current_skb;			/* being emptied */
+	struct sk_buff *current_skb;	/* being emptied */
 
 	struct urb *urbs[0];
 };
diff -x '*.orig' -x '*.base' -u -r Linux/drivers/usb/atm.orig/xusbatm.c Linux/drivers/usb/atm/xusbatm.c
--- Linux/drivers/usb/atm.orig/xusbatm.c	2006-01-12 18:27:56.000000000 +0100
+++ Linux/drivers/usb/atm/xusbatm.c	2006-01-12 18:25:54.000000000 +0100
@@ -61,7 +61,7 @@
 	return 0;
 }
 
-static int xusbatm_bind(struct usbatm_data *usbatm_instance,
+static int xusbatm_bind(struct usbatm_data *usbatm,
 			struct usb_interface *intf, const struct usb_device_id *id,
 			int *need_heavy_init)
 {
@@ -72,14 +72,14 @@
 	u8 searched_ep = rx_ep_present ? tx_endpoint[drv_ix] : rx_endpoint[drv_ix];
 	int i, ret;
 
-	usb_dbg(usbatm_instance, "%s: binding driver %d: vendor %#x product %#x"
-		" rx: ep %#x padd %d tx: ep %#x padd %d\n",
+	usb_dbg(usbatm, "%s: binding driver %d: vendor %04x product %04x"
+		" rx: ep %02x padd %d tx: ep %02x padd %d\n",
 		__func__, drv_ix, vendor[drv_ix], product[drv_ix],
 		rx_endpoint[drv_ix], rx_padding[drv_ix],
 		tx_endpoint[drv_ix], tx_padding[drv_ix]);
 
 	if (!rx_ep_present && !tx_ep_present) {
-		usb_dbg(usbatm_instance, "%s: intf #%d has neither rx (%#x) nor tx (%#x) endpoint\n",
+		usb_dbg(usbatm, "%s: intf #%d has neither rx (%#x) nor tx (%#x) endpoint\n",
 			__func__, intf->altsetting->desc.bInterfaceNumber,
 			rx_endpoint[drv_ix], tx_endpoint[drv_ix]);
 		return -ENODEV;
@@ -93,25 +93,26 @@
 
 		if (cur_if != intf && usb_intf_has_ep(cur_if, searched_ep)) {
 			ret = usb_driver_claim_interface(&xusbatm_usb_driver,
-							 cur_if, usbatm_instance);
+							 cur_if, usbatm);
 			if (!ret)
-				usb_err(usbatm_instance, "%s: failed to claim interface #%d (%d)\n",
+				usb_err(usbatm, "%s: failed to claim interface #%d (%d)\n",
 					__func__, cur_if->altsetting->desc.bInterfaceNumber, ret);
 			return ret;
 		}
 	}
 
-	usb_err(usbatm_instance, "%s: no interface has endpoint %#x\n",
+	usb_err(usbatm, "%s: no interface has endpoint %#x\n",
 		__func__, searched_ep);
 	return -ENODEV;
 }
 
-static void xusbatm_unbind(struct usbatm_data *usbatm_instance,
+static void xusbatm_unbind(struct usbatm_data *usbatm,
 			   struct usb_interface *intf)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	int i;
-	usb_dbg(usbatm_instance, "%s entered\n", __func__);
+
+	usb_dbg(usbatm, "%s entered\n", __func__);
 
 	for(i = 0; i < usb_dev->actconfig->desc.bNumInterfaces; i++) {
 		struct usb_interface *cur_if = usb_dev->actconfig->interface[i];
@@ -120,10 +121,10 @@
 	}
 }
 
-static int xusbatm_atm_start(struct usbatm_data *usbatm_instance,
+static int xusbatm_atm_start(struct usbatm_data *usbatm,
 			     struct atm_dev *atm_dev)
 {
-	atm_dbg(usbatm_instance, "%s entered\n", __func__);
+	atm_dbg(usbatm, "%s entered\n", __func__);
 
 	/* use random MAC as we've no way to get it from the device */
 	random_ether_addr(atm_dev->esi);

--Boundary-00=_HSpxDmpW5jZGc+W--
