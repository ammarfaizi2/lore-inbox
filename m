Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVAHJPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVAHJPU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVAHJMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:12:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:52101 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261879AbVAHFsY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:24 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632602446@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:40 -0800
Message-Id: <11051632601876@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.13, 2004/12/20 15:43:59-08:00, greg@kroah.com

USB: convert the idVendor, idProduct, bcdDevice and bcdUSB fields to __le16

These fields are in the struct usb_device_descriptor, and now we keep the 
native (on-the-wire mode) format of these fields.  Any driver using these
fields needs to convert it to cpu endian before using them.

All USB drivers in the kernel tree have been fixed up to work properly with
this change.  All out-of-the USB kernel drivers are on their own...

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/watchdog/pcwd_usb.c                  |    6 --
 drivers/isdn/hisax/hfc_usb.c                      |    7 +--
 drivers/isdn/hisax/st5481_init.c                  |    3 -
 drivers/media/dvb/dibusb/dvb-dibusb.c             |   12 ++---
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    6 +-
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    8 +--
 drivers/net/irda/irda-usb.c                       |    4 -
 drivers/net/irda/stir4200.c                       |    4 -
 drivers/usb/atm/speedtch.c                        |   11 ++---
 drivers/usb/class/audio.c                         |    3 -
 drivers/usb/class/usb-midi.c                      |   26 ++++++------
 drivers/usb/class/usb-midi.h                      |    4 -
 drivers/usb/class/usblp.c                         |   19 ++++----
 drivers/usb/core/devices.c                        |   10 +++-
 drivers/usb/core/hcd.c                            |   16 +++----
 drivers/usb/core/hub.c                            |    2 
 drivers/usb/core/message.c                        |    7 ---
 drivers/usb/core/otg_whitelist.h                  |   16 +++----
 drivers/usb/core/sysfs.c                          |   26 +++++++++---
 drivers/usb/core/usb.c                            |   22 +++++-----
 drivers/usb/host/hc_crisv10.c                     |    8 +--
 drivers/usb/image/microtek.c                      |    4 -
 drivers/usb/input/aiptek.c                        |    6 +-
 drivers/usb/input/ati_remote.c                    |   17 ++-----
 drivers/usb/input/hid-core.c                      |    8 ++-
 drivers/usb/input/hid-ff.c                        |    4 -
 drivers/usb/input/hid-input.c                     |    6 +-
 drivers/usb/input/hid-lgff.c                      |    4 -
 drivers/usb/input/hiddev.c                        |    6 +-
 drivers/usb/input/kbtab.c                         |    6 +-
 drivers/usb/input/mtouchusb.c                     |    6 +-
 drivers/usb/input/powermate.c                     |   13 +++---
 drivers/usb/input/touchkitusb.c                   |    6 +-
 drivers/usb/input/usbkbd.c                        |    6 +-
 drivers/usb/input/usbmouse.c                      |    6 +-
 drivers/usb/input/wacom.c                         |    6 +-
 drivers/usb/input/xpad.c                          |   10 ++--
 drivers/usb/media/dabusb.c                        |    9 ++--
 drivers/usb/media/ibmcam.c                        |   21 ++-------
 drivers/usb/media/konicawc.c                      |    8 +--
 drivers/usb/media/ov511.c                         |    6 +-
 drivers/usb/media/se401.c                         |   22 +++++-----
 drivers/usb/media/sn9c102_core.c                  |    4 -
 drivers/usb/media/sn9c102_tas5110c1b.c            |    6 +-
 drivers/usb/media/sn9c102_tas5130d1b.c            |    4 -
 drivers/usb/media/stv680.c                        |    3 -
 drivers/usb/media/ultracam.c                      |    8 ---
 drivers/usb/media/vicam.c                         |    6 --
 drivers/usb/media/w9968cf.c                       |    8 +--
 drivers/usb/misc/auerswald.c                      |    9 +---
 drivers/usb/misc/emi26.c                          |    8 +--
 drivers/usb/misc/emi62.c                          |    6 --
 drivers/usb/misc/legousbtower.c                   |    7 ---
 drivers/usb/misc/usblcd.c                         |   15 ++++---
 drivers/usb/misc/usbtest.c                        |   10 ++--
 drivers/usb/misc/uss720.c                         |    3 -
 drivers/usb/net/catc.c                            |    5 +-
 drivers/usb/net/kaweth.c                          |    8 +--
 drivers/usb/serial/belkin_sa.c                    |    4 -
 drivers/usb/serial/io_edgeport.c                  |    4 -
 drivers/usb/serial/io_ti.c                        |    4 -
 drivers/usb/serial/keyspan.c                      |   12 ++---
 drivers/usb/serial/keyspan_pda.c                  |    6 +-
 drivers/usb/serial/kobil_sct.c                    |    2 
 drivers/usb/serial/mct_u232.c                     |    9 ++--
 drivers/usb/serial/ti_usb_3410_5052.c             |    5 +-
 drivers/usb/serial/usb-serial.c                   |   14 +++---
 drivers/usb/serial/usb-serial.h                   |    4 -
 drivers/usb/serial/visor.c                        |    4 -
 drivers/usb/storage/scsiglue.c                    |    2 
 drivers/usb/storage/transport.c                   |    2 
 drivers/usb/storage/usb.c                         |   20 +++++----
 include/linux/usb_ch9.h                           |   10 ++--
 sound/usb/usbaudio.c                              |   47 ++++++++++++----------
 sound/usb/usbmidi.c                               |    6 +-
 sound/usb/usbmixer.c                              |    6 +-
 sound/usb/usx2y/usX2Yhwdep.c                      |    4 -
 sound/usb/usx2y/usbusx2y.c                        |   11 ++---
 sound/usb/usx2y/usbusx2yaudio.c                   |    4 -
 79 files changed, 343 insertions(+), 347 deletions(-)


diff -Nru a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
--- a/drivers/char/watchdog/pcwd_usb.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/char/watchdog/pcwd_usb.c	2005-01-07 15:42:28 -08:00
@@ -571,12 +571,6 @@
 	char fw_ver_str[20];
 	unsigned char option_switches, dummy;
 
-	/* See if the device offered us matches what we can accept */
-	if ((udev->descriptor.idVendor != USB_PCWD_VENDOR_ID) ||
-	    (udev->descriptor.idProduct != USB_PCWD_PRODUCT_ID)) {
-		return -ENODEV;
-	}
-
 	cards_found++;
 	if (cards_found > 1) {
 		printk(KERN_ERR PFX "This driver only supports 1 device\n");
diff -Nru a/drivers/isdn/hisax/hfc_usb.c b/drivers/isdn/hisax/hfc_usb.c
--- a/drivers/isdn/hisax/hfc_usb.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/isdn/hisax/hfc_usb.c	2005-01-07 15:42:28 -08:00
@@ -1360,9 +1360,10 @@
 //	usb_show_device_descriptor(&dev->descriptor);
 //	usb_show_interface_descriptor(&iface->desc);
 	vend_idx=0xffff;
-	for(i=0;vdata[i].vendor;i++)
-	{
-		if(dev->descriptor.idVendor==vdata[i].vendor && dev->descriptor.idProduct==vdata[i].prod_id) vend_idx=i;
+	for(i=0;vdata[i].vendor;i++) {
+		if (le16_to_cpu(dev->descriptor.idVendor) == vdata[i].vendor && 
+		    le16_to_cpu(dev->descriptor.idProduct) == vdata[i].prod_id)
+			vend_idx = i;
 	}
 	
 
diff -Nru a/drivers/isdn/hisax/st5481_init.c b/drivers/isdn/hisax/st5481_init.c
--- a/drivers/isdn/hisax/st5481_init.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/isdn/hisax/st5481_init.c	2005-01-07 15:42:28 -08:00
@@ -67,7 +67,8 @@
 	int retval, i;
 
 	printk(KERN_INFO "st541: found adapter VendorId %04x, ProductId %04x, LEDs %d\n",
-	     dev->descriptor.idVendor, dev->descriptor.idProduct,
+	     le16_to_cpu(dev->descriptor.idVendor),
+	     le16_to_cpu(dev->descriptor.idProduct),
 	     number_of_leds);
 
 	adapter = kmalloc(sizeof(struct st5481_adapter), GFP_KERNEL);
diff -Nru a/drivers/media/dvb/dibusb/dvb-dibusb.c b/drivers/media/dvb/dibusb/dvb-dibusb.c
--- a/drivers/media/dvb/dibusb/dvb-dibusb.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/media/dvb/dibusb/dvb-dibusb.c	2005-01-07 15:42:28 -08:00
@@ -602,8 +602,8 @@
 
 	if (dib->fe == NULL) {
 		printk("dvb-dibusb: A frontend driver was not found for device %04x/%04x\n",
-		       dib->udev->descriptor.idVendor,
-		       dib->udev->descriptor.idProduct);
+		       le16_to_cpu(dib->udev->descriptor.idVendor),
+		       le16_to_cpu(dib->udev->descriptor.idProduct));
 	} else {
 		if (dvb_register_frontend(dib->adapter, dib->fe)) {
 			printk("dvb-dibusb: Frontend registration failed!\n");
@@ -917,11 +917,11 @@
 	int ret = -ENOMEM,i,cold=0;
 
 	for (i = 0; i < DIBUSB_SUPPORTED_DEVICES; i++)
-		if (dibusb_devices[i].cold_product_id == udev->descriptor.idProduct ||
-			dibusb_devices[i].warm_product_id == udev->descriptor.idProduct) {
+		if (dibusb_devices[i].cold_product_id == le16_to_cpu(udev->descriptor.idProduct) ||
+			dibusb_devices[i].warm_product_id == le16_to_cpu(udev->descriptor.idProduct)) {
 			dibdev = &dibusb_devices[i];
 
-			cold = dibdev->cold_product_id == udev->descriptor.idProduct;
+			cold = dibdev->cold_product_id == le16_to_cpu(udev->descriptor.idProduct);
 
 			if (cold)
 				info("found a '%s' in cold state, will try to load a firmware",dibdev->name);
@@ -931,7 +931,7 @@
 
 	if (dibdev == NULL) {
 		err("something went very wrong, "
-				"unknown product ID: %.4x",udev->descriptor.idProduct);
+				"unknown product ID: %.4x",le16_to_cpu(udev->descriptor.idProduct));
 		return -ENODEV;
 	}
 
diff -Nru a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-01-07 15:42:28 -08:00
@@ -1348,7 +1348,7 @@
 
 static void frontend_init(struct ttusb* ttusb)
 {
-	switch(ttusb->dev->descriptor.idProduct) {
+	switch(le16_to_cpu(ttusb->dev->descriptor.idProduct)) {
 	case 0x1003: // Hauppauge/TT Nova-USB-S budget (stv0299/ALPS BSRU6(tsa5059)
 		// try the ALPS BSRU6 first
 		ttusb->fe = stv0299_attach(&alps_bsru6_config, &ttusb->i2c_adap);
@@ -1381,8 +1381,8 @@
 
 	if (ttusb->fe == NULL) {
 		printk("dvb-ttusb-budget: A frontend driver was not found for device %04x/%04x\n",
-		       ttusb->dev->descriptor.idVendor,
-		       ttusb->dev->descriptor.idProduct);
+		       le16_to_cpu(ttusb->dev->descriptor.idVendor),
+		       le16_to_cpu(ttusb->dev->descriptor.idProduct));
 	} else {
 		if (dvb_register_frontend(ttusb->adapter, ttusb->fe)) {
 			printk("dvb-ttusb-budget: Frontend registration failed!\n");
diff -Nru a/drivers/media/dvb/ttusb-dec/ttusb_dec.c b/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- a/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-01-07 15:42:28 -08:00
@@ -1447,7 +1447,7 @@
 
 	memset(dec, 0, sizeof(struct ttusb_dec));
 
-	switch (id->idProduct) {
+	switch (le16_to_cpu(id->idProduct)) {
 		case 0x1006:
 		ttusb_dec_set_model(dec, TTUSB_DEC3000S);
 			break;
@@ -1471,7 +1471,7 @@
 	ttusb_dec_init_dvb(dec);
 
 	dec->adapter->priv = dec;
-	switch (id->idProduct) {
+	switch (le16_to_cpu(id->idProduct)) {
 	case 0x1006:
 		dec->fe = ttusbdecfe_dvbs_attach(&fe_config);
 		break;
@@ -1484,8 +1484,8 @@
 
 	if (dec->fe == NULL) {
 		printk("dvb-ttusb-dec: A frontend driver was not found for device %04x/%04x\n",
-		       dec->udev->descriptor.idVendor,
-		       dec->udev->descriptor.idProduct);
+		       le16_to_cpu(dec->udev->descriptor.idVendor),
+		       le16_to_cpu(dec->udev->descriptor.idProduct));
 	} else {
 		if (dvb_register_frontend(dec->adapter, dec->fe)) {
 			printk("budget-ci: Frontend registration failed!\n");
diff -Nru a/drivers/net/irda/irda-usb.c b/drivers/net/irda/irda-usb.c
--- a/drivers/net/irda/irda-usb.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/net/irda/irda-usb.c	2005-01-07 15:42:28 -08:00
@@ -1360,8 +1360,8 @@
 	 * Jean II */
 
 	MESSAGE("IRDA-USB found at address %d, Vendor: %x, Product: %x\n",
-		dev->devnum, dev->descriptor.idVendor,
-		dev->descriptor.idProduct);
+		dev->devnum, le16_to_cpu(dev->descriptor.idVendor),
+		le16_to_cpu(dev->descriptor.idProduct));
 
 	net = alloc_irdadev(sizeof(*self));
 	if (!net) 
diff -Nru a/drivers/net/irda/stir4200.c b/drivers/net/irda/stir4200.c
--- a/drivers/net/irda/stir4200.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/net/irda/stir4200.c	2005-01-07 15:42:28 -08:00
@@ -1072,8 +1072,8 @@
 
 	printk(KERN_INFO "SigmaTel STIr4200 IRDA/USB found at address %d, "
 		"Vendor: %x, Product: %x\n",
-	       dev->devnum, dev->descriptor.idVendor,
-	       dev->descriptor.idProduct);
+	       dev->devnum, le16_to_cpu(dev->descriptor.idVendor),
+	       le16_to_cpu(dev->descriptor.idProduct));
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&stir->qos);
diff -Nru a/drivers/usb/atm/speedtch.c b/drivers/usb/atm/speedtch.c
--- a/drivers/usb/atm/speedtch.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/atm/speedtch.c	2005-01-07 15:42:28 -08:00
@@ -594,7 +594,7 @@
 				  const struct firmware **fw_p)
 {
 	char buf[24];
-	const u16 bcdDevice = instance->u.usb_dev->descriptor.bcdDevice;
+	const u16 bcdDevice = le16_to_cpu(instance->u.usb_dev->descriptor.bcdDevice);
 	const u8 major_revision = bcdDevice >> 8;
 	const u8 minor_revision = bcdDevice & 0xff;
 
@@ -737,11 +737,12 @@
 	int ret, i;
 	char buf7[SIZE_7];
 
-	dbg("speedtch_usb_probe: trying device with vendor=0x%x, product=0x%x, ifnum %d", dev->descriptor.idVendor, dev->descriptor.idProduct, ifnum);
+	dbg("speedtch_usb_probe: trying device with vendor=0x%x, product=0x%x, ifnum %d",
+	    le16_to_cpu(dev->descriptor.idVendor),
+	    le16_to_cpu(dev->descriptor.idProduct), ifnum);
 
-	if ((dev->descriptor.bDeviceClass != USB_CLASS_VENDOR_SPEC) ||
-	    (dev->descriptor.idVendor != SPEEDTOUCH_VENDORID) ||
-	    (dev->descriptor.idProduct != SPEEDTOUCH_PRODUCTID) || (ifnum != 1))
+	if ((dev->descriptor.bDeviceClass != USB_CLASS_VENDOR_SPEC) || 
+	    (ifnum != 1))
 		return -ENODEV;
 
 	dbg("speedtch_usb_probe: device accepted");
diff -Nru a/drivers/usb/class/audio.c b/drivers/usb/class/audio.c
--- a/drivers/usb/class/audio.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/class/audio.c	2005-01-07 15:42:28 -08:00
@@ -2971,7 +2971,8 @@
 			}
 			format = (fmt[5] == 2) ? (AFMT_U16_LE | AFMT_U8) : (AFMT_S16_LE | AFMT_S8);
 			/* Dallas DS4201 workaround */
-			if (dev->descriptor.idVendor == 0x04fa && dev->descriptor.idProduct == 0x4201)
+			if (le16_to_cpu(dev->descriptor.idVendor) == 0x04fa && 
+			    le16_to_cpu(dev->descriptor.idProduct) == 0x4201)
 				format = (AFMT_S16_LE | AFMT_S8);
 			fmt = find_csinterface_descriptor(buffer, buflen, NULL, FORMAT_TYPE, asifout, i);
 			if (!fmt) {
diff -Nru a/drivers/usb/class/usb-midi.c b/drivers/usb/class/usb-midi.c
--- a/drivers/usb/class/usb-midi.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/class/usb-midi.c	2005-01-07 15:42:28 -08:00
@@ -1306,8 +1306,8 @@
 		return NULL;
 	}
 	u->deviceName = NULL;
-	u->idVendor = d->descriptor.idVendor;
-	u->idProduct = d->descriptor.idProduct;
+	u->idVendor = le16_to_cpu(d->descriptor.idVendor);
+	u->idProduct = le16_to_cpu(d->descriptor.idProduct);
 	u->interface = ifnum;
 	u->altSetting = altSetting;
 	u->in[0].endpoint = -1;
@@ -1661,11 +1661,11 @@
 		} 
 		/* Failsafe */
 		if ( !u->deviceName[0] ) {
-			if ( d->descriptor.idVendor == USB_VENDOR_ID_ROLAND ) {
+			if (le16_to_cpu(d->descriptor.idVendor) == USB_VENDOR_ID_ROLAND ) {
 				strcpy(u->deviceName, "Unknown Roland");
-			} else if ( d->descriptor.idVendor == USB_VENDOR_ID_STEINBERG  ) {
+			} else if (le16_to_cpu(d->descriptor.idVendor) == USB_VENDOR_ID_STEINBERG  ) {
 				strcpy(u->deviceName, "Unknown Steinberg");
-			} else if ( d->descriptor.idVendor == USB_VENDOR_ID_YAMAHA ) {
+			} else if (le16_to_cpu(d->descriptor.idVendor) == USB_VENDOR_ID_YAMAHA ) {
 				strcpy(u->deviceName, "Unknown Yamaha");
 			} else {
 				strcpy(u->deviceName, "Unknown");
@@ -1782,7 +1782,7 @@
 	int alts=-1;
 	int ret;
 
-	if (d->descriptor.idVendor != USB_VENDOR_ID_YAMAHA) {
+	if (le16_to_cpu(d->descriptor.idVendor) != USB_VENDOR_ID_YAMAHA) {
 		return -EINVAL;
 	}
 
@@ -1799,7 +1799,8 @@
 	}
 
 	printk(KERN_INFO "usb-midi: Found YAMAHA USB-MIDI device on dev %04x:%04x, iface %d\n",
-	       d->descriptor.idVendor, d->descriptor.idProduct, ifnum);
+	       le16_to_cpu(d->descriptor.idVendor),
+	       le16_to_cpu(d->descriptor.idProduct), ifnum);
 
 	i = d->actconfig - d->config;
 	buffer = d->rawdescriptors[i];
@@ -1833,8 +1834,8 @@
 	for ( i=0; i<VENDOR_SPECIFIC_USB_MIDI_DEVICES ; i++ ) {
 		u=&(usb_midi_devices[i]);
     
-		if ( d->descriptor.idVendor != u->idVendor ||
-		     d->descriptor.idProduct != u->idProduct ||
+		if ( le16_to_cpu(d->descriptor.idVendor) != u->idVendor ||
+		     le16_to_cpu(d->descriptor.idProduct) != u->idProduct ||
 		     ifnum != u->interface )
 			continue;
 
@@ -1875,7 +1876,8 @@
 	}
 
 	printk(KERN_INFO "usb-midi: Found MIDISTREAMING on dev %04x:%04x, iface %d\n",
-	       d->descriptor.idVendor, d->descriptor.idProduct, ifnum);
+	       le16_to_cpu(d->descriptor.idVendor), 
+	       le16_to_cpu(d->descriptor.idProduct), ifnum);
 
 
 	/* From USB Spec v2.0, Section 9.5.
@@ -1915,8 +1917,8 @@
 {
 	struct usb_midi_device u;
 
-	if ( d->descriptor.idVendor != uvendor ||
-	     d->descriptor.idProduct != uproduct ||
+	if ( le16_to_cpu(d->descriptor.idVendor) != uvendor ||
+	     le16_to_cpu(d->descriptor.idProduct) != uproduct ||
 	     ifnum != uinterface ) {
 		return -EINVAL;
 	}
diff -Nru a/drivers/usb/class/usb-midi.h b/drivers/usb/class/usb-midi.h
--- a/drivers/usb/class/usb-midi.h	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/class/usb-midi.h	2005-01-07 15:42:28 -08:00
@@ -63,8 +63,8 @@
 struct usb_midi_device {
 	char  *deviceName;
 
-	int    idVendor;
-	int    idProduct;
+	u16    idVendor;
+	u16    idProduct;
 	int    interface;
 	int    altSetting; /* -1: auto detect */
 
diff -Nru a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
--- a/drivers/usb/class/usblp.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/class/usblp.c	2005-01-07 15:42:28 -08:00
@@ -527,7 +527,7 @@
 
 			case IOCNR_HP_SET_CHANNEL:
 				if (_IOC_DIR(cmd) != _IOC_WRITE ||
-				    usblp->dev->descriptor.idVendor != 0x03F0 ||
+				    le16_to_cpu(usblp->dev->descriptor.idVendor) != 0x03F0 ||
 				    usblp->quirks & USBLP_QUIRK_BIDIR) {
 					retval = -EINVAL;
 					goto done;
@@ -574,8 +574,8 @@
 					goto done;
 				}
 
-				twoints[0] = usblp->dev->descriptor.idVendor;
-				twoints[1] = usblp->dev->descriptor.idProduct;
+				twoints[0] = le16_to_cpu(usblp->dev->descriptor.idVendor);
+				twoints[1] = le16_to_cpu(usblp->dev->descriptor.idProduct);
 				if (copy_to_user((void __user *)arg,
 						(unsigned char *)twoints,
 						sizeof(twoints))) {
@@ -910,15 +910,15 @@
 
 	/* Lookup quirks for this printer. */
 	usblp->quirks = usblp_quirks(
-		dev->descriptor.idVendor,
-		dev->descriptor.idProduct);
+		le16_to_cpu(dev->descriptor.idVendor),
+		le16_to_cpu(dev->descriptor.idProduct));
 
 	/* Analyze and pick initial alternate settings and endpoints. */
 	protocol = usblp_select_alts(usblp);
 	if (protocol < 0) {
 		dbg("incompatible printer-class device 0x%4.4X/0x%4.4X",
-			dev->descriptor.idVendor,
-			dev->descriptor.idProduct);
+			le16_to_cpu(dev->descriptor.idVendor),
+			le16_to_cpu(dev->descriptor.idProduct));
 		goto abort;
 	}
 
@@ -938,8 +938,9 @@
 		usblp->minor, usblp->bidir ? "Bi" : "Uni", dev->devnum,
 		usblp->ifnum,
 		usblp->protocol[usblp->current_protocol].alt_setting,
-		usblp->current_protocol, usblp->dev->descriptor.idVendor,
-		usblp->dev->descriptor.idProduct);
+		usblp->current_protocol,
+		le16_to_cpu(usblp->dev->descriptor.idVendor),
+		le16_to_cpu(usblp->dev->descriptor.idProduct));
 
 	usb_set_intfdata (intf, usblp);
 
diff -Nru a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
--- a/drivers/usb/core/devices.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/core/devices.c	2005-01-07 15:42:28 -08:00
@@ -335,10 +335,13 @@
  */
 static char *usb_dump_device_descriptor(char *start, char *end, const struct usb_device_descriptor *desc)
 {
+	u16 bcdUSB = le16_to_cpu(desc->bcdUSB);
+	u16 bcdDevice = le16_to_cpu(desc->bcdDevice);
+
 	if (start > end)
 		return start;
 	start += sprintf (start, format_device1,
-			  desc->bcdUSB >> 8, desc->bcdUSB & 0xff,
+			  bcdUSB >> 8, bcdUSB & 0xff,
 			  desc->bDeviceClass,
 			  class_decode (desc->bDeviceClass),
 			  desc->bDeviceSubClass,
@@ -348,8 +351,9 @@
 	if (start > end)
 		return start;
 	start += sprintf(start, format_device2,
-			 desc->idVendor, desc->idProduct,
-			 desc->bcdDevice >> 8, desc->bcdDevice & 0xff);
+			 le16_to_cpu(desc->idVendor),
+			 le16_to_cpu(desc->idProduct),
+			 bcdDevice >> 8, bcdDevice & 0xff);
 	return start;
 }
 
diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/core/hcd.c	2005-01-07 15:42:28 -08:00
@@ -120,16 +120,16 @@
 static const u8 usb2_rh_dev_descriptor [18] = {
 	0x12,       /*  __u8  bLength; */
 	0x01,       /*  __u8  bDescriptorType; Device */
-	0x00, 0x02, /*  __u16 bcdUSB; v2.0 */
+	0x00, 0x02, /*  __le16 bcdUSB; v2.0 */
 
 	0x09,	    /*  __u8  bDeviceClass; HUB_CLASSCODE */
 	0x00,	    /*  __u8  bDeviceSubClass; */
 	0x01,       /*  __u8  bDeviceProtocol; [ usb 2.0 single TT ]*/
 	0x08,       /*  __u8  bMaxPacketSize0; 8 Bytes */
 
-	0x00, 0x00, /*  __u16 idVendor; */
- 	0x00, 0x00, /*  __u16 idProduct; */
-	KERNEL_VER, KERNEL_REL, /*  __u16 bcdDevice */
+	0x00, 0x00, /*  __le16 idVendor; */
+ 	0x00, 0x00, /*  __le16 idProduct; */
+	KERNEL_VER, KERNEL_REL, /*  __le16 bcdDevice */
 
 	0x03,       /*  __u8  iManufacturer; */
 	0x02,       /*  __u8  iProduct; */
@@ -143,16 +143,16 @@
 static const u8 usb11_rh_dev_descriptor [18] = {
 	0x12,       /*  __u8  bLength; */
 	0x01,       /*  __u8  bDescriptorType; Device */
-	0x10, 0x01, /*  __u16 bcdUSB; v1.1 */
+	0x10, 0x01, /*  __le16 bcdUSB; v1.1 */
 
 	0x09,	    /*  __u8  bDeviceClass; HUB_CLASSCODE */
 	0x00,	    /*  __u8  bDeviceSubClass; */
 	0x00,       /*  __u8  bDeviceProtocol; [ low/full speeds only ] */
 	0x08,       /*  __u8  bMaxPacketSize0; 8 Bytes */
 
-	0x00, 0x00, /*  __u16 idVendor; */
- 	0x00, 0x00, /*  __u16 idProduct; */
-	KERNEL_VER, KERNEL_REL, /*  __u16 bcdDevice */
+	0x00, 0x00, /*  __le16 idVendor; */
+ 	0x00, 0x00, /*  __le16 idProduct; */
+	KERNEL_VER, KERNEL_REL, /*  __le16 bcdDevice */
 
 	0x03,       /*  __u8  iManufacturer; */
 	0x02,       /*  __u8  iProduct; */
diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/core/hub.c	2005-01-07 15:42:28 -08:00
@@ -2494,7 +2494,7 @@
 		}
  
 		/* check for devices running slower than they could */
-		if (udev->descriptor.bcdUSB >= 0x0200
+		if (le16_to_cpu(udev->descriptor.bcdUSB) >= 0x0200
 				&& udev->speed == USB_SPEED_FULL
 				&& highspeed_hubs != 0)
 			check_highspeed (hub, udev, port1);
diff -Nru a/drivers/usb/core/message.c b/drivers/usb/core/message.c
--- a/drivers/usb/core/message.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/core/message.c	2005-01-07 15:42:28 -08:00
@@ -796,13 +796,8 @@
 		return -ENOMEM;
 
 	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, desc, size);
-	if (ret >= 0) {
-		le16_to_cpus(&desc->bcdUSB);
-		le16_to_cpus(&desc->idVendor);
-		le16_to_cpus(&desc->idProduct);
-		le16_to_cpus(&desc->bcdDevice);
+	if (ret >= 0) 
 		memcpy(&dev->descriptor, desc, size);
-	}
 	kfree(desc);
 	return ret;
 }
diff -Nru a/drivers/usb/core/otg_whitelist.h b/drivers/usb/core/otg_whitelist.h
--- a/drivers/usb/core/otg_whitelist.h	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/core/otg_whitelist.h	2005-01-07 15:42:28 -08:00
@@ -55,8 +55,8 @@
 		return 1;
 
 	/* HNP test device is _never_ targeted (see OTG spec 6.6.6) */
-	if (dev->descriptor.idVendor == 0x1a0a
-			&& dev->descriptor.idProduct == 0xbadd)
+	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x1a0a && 
+	     le16_to_cpu(dev->descriptor.idProduct) == 0xbadd))
 		return 0;
 
 	/* NOTE: can't use usb_match_id() since interface caches
@@ -64,21 +64,21 @@
 	 */
 	for (id = whitelist_table; id->match_flags; id++) {
 		if ((id->match_flags & USB_DEVICE_ID_MATCH_VENDOR) &&
-		    id->idVendor != dev->descriptor.idVendor)
+		    id->idVendor != le16_to_cpu(dev->descriptor.idVendor))
 			continue;
 
 		if ((id->match_flags & USB_DEVICE_ID_MATCH_PRODUCT) &&
-		    id->idProduct != dev->descriptor.idProduct)
+		    id->idProduct != le16_to_cpu(dev->descriptor.idProduct))
 			continue;
 
 		/* No need to test id->bcdDevice_lo != 0, since 0 is never
 		   greater than any unsigned number. */
 		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_LO) &&
-		    (id->bcdDevice_lo > dev->descriptor.bcdDevice))
+		    (id->bcdDevice_lo > le16_to_cpu(dev->descriptor.bcdDevice)))
 			continue;
 
 		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_HI) &&
-		    (id->bcdDevice_hi < dev->descriptor.bcdDevice))
+		    (id->bcdDevice_hi < le16_to_cpu(dev->descriptor.bcdDevice)))
 			continue;
 
 		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_CLASS) &&
@@ -101,8 +101,8 @@
 
 	/* OTG MESSAGE: report errors here, customize to match your product */
 	dev_err(&dev->dev, "device v%04x p%04x is not supported\n",
-			dev->descriptor.idVendor,
-			dev->descriptor.idProduct);
+		le16_to_cpu(dev->descriptor.idVendor),
+		le16_to_cpu(dev->descriptor.idProduct));
 #ifdef	CONFIG_USB_OTG_WHITELIST
 	return 0;
 #else
diff -Nru a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
--- a/drivers/usb/core/sysfs.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/core/sysfs.c	2005-01-07 15:42:28 -08:00
@@ -149,10 +149,11 @@
 show_version (struct device *dev, char *buf)
 {
 	struct usb_device *udev;
+	u16 bcdUSB;
 
-	udev = to_usb_device (dev);
-	return sprintf (buf, "%2x.%02x\n", udev->descriptor.bcdUSB >> 8, 
-			udev->descriptor.bcdUSB & 0xff);
+	udev = to_usb_device(dev);
+	bcdUSB = le16_to_cpu(udev->descriptor.bcdUSB);
+	return sprintf(buf, "%2x.%02x\n", bcdUSB >> 8, bcdUSB & 0xff);
 }
 static DEVICE_ATTR(version, S_IRUGO, show_version, NULL);
 
@@ -167,6 +168,22 @@
 static DEVICE_ATTR(maxchild, S_IRUGO, show_maxchild, NULL);
 
 /* Descriptor fields */
+#define usb_descriptor_attr_le16(field, format_string)			\
+static ssize_t								\
+show_##field (struct device *dev, char *buf)				\
+{									\
+	struct usb_device *udev;					\
+									\
+	udev = to_usb_device (dev);					\
+	return sprintf (buf, format_string, 				\
+			le16_to_cpu(udev->descriptor.field));		\
+}									\
+static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
+
+usb_descriptor_attr_le16(idVendor, "%04x\n")
+usb_descriptor_attr_le16(idProduct, "%04x\n")
+usb_descriptor_attr_le16(bcdDevice, "%04x\n")
+
 #define usb_descriptor_attr(field, format_string)			\
 static ssize_t								\
 show_##field (struct device *dev, char *buf)				\
@@ -178,9 +195,6 @@
 }									\
 static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
 
-usb_descriptor_attr (idVendor, "%04x\n")
-usb_descriptor_attr (idProduct, "%04x\n")
-usb_descriptor_attr (bcdDevice, "%04x\n")
 usb_descriptor_attr (bDeviceClass, "%02x\n")
 usb_descriptor_attr (bDeviceSubClass, "%02x\n")
 usb_descriptor_attr (bDeviceProtocol, "%02x\n")
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/core/usb.c	2005-01-07 15:42:28 -08:00
@@ -423,21 +423,21 @@
 	       id->driver_info; id++) {
 
 		if ((id->match_flags & USB_DEVICE_ID_MATCH_VENDOR) &&
-		    id->idVendor != dev->descriptor.idVendor)
+		    id->idVendor != le16_to_cpu(dev->descriptor.idVendor))
 			continue;
 
 		if ((id->match_flags & USB_DEVICE_ID_MATCH_PRODUCT) &&
-		    id->idProduct != dev->descriptor.idProduct)
+		    id->idProduct != le16_to_cpu(dev->descriptor.idProduct))
 			continue;
 
 		/* No need to test id->bcdDevice_lo != 0, since 0 is never
 		   greater than any unsigned number. */
 		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_LO) &&
-		    (id->bcdDevice_lo > dev->descriptor.bcdDevice))
+		    (id->bcdDevice_lo > le16_to_cpu(dev->descriptor.bcdDevice)))
 			continue;
 
 		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_HI) &&
-		    (id->bcdDevice_hi < dev->descriptor.bcdDevice))
+		    (id->bcdDevice_hi < le16_to_cpu(dev->descriptor.bcdDevice)))
 			continue;
 
 		if ((id->match_flags & USB_DEVICE_ID_MATCH_DEV_CLASS) &&
@@ -588,9 +588,9 @@
 	if (add_hotplug_env_var(envp, num_envp, &i,
 				buffer, buffer_size, &length,
 				"PRODUCT=%x/%x/%x",
-				usb_dev->descriptor.idVendor,
-				usb_dev->descriptor.idProduct,
-				usb_dev->descriptor.bcdDevice))
+				le16_to_cpu(usb_dev->descriptor.idVendor),
+				le16_to_cpu(usb_dev->descriptor.idProduct),
+				le16_to_cpu(usb_dev->descriptor.bcdDevice)))
 		return -ENOMEM;
 
 	/* class-based driver binding models */
@@ -959,12 +959,12 @@
 	int child;
 
 	dev_dbg(&dev->dev, "check for vendor %04x, product %04x ...\n",
-	    dev->descriptor.idVendor,
-	    dev->descriptor.idProduct);
+	    le16_to_cpu(dev->descriptor.idVendor),
+	    le16_to_cpu(dev->descriptor.idProduct));
 
 	/* see if this device matches */
-	if ((dev->descriptor.idVendor == vendor_id) &&
-	    (dev->descriptor.idProduct == product_id)) {
+	if ((vendor_id == le16_to_cpu(dev->descriptor.idVendor)) &&
+	    (product_id == le16_to_cpu(dev->descriptor.idProduct))) {
 		dev_dbg (&dev->dev, "matched this device!\n");
 		ret_dev = usb_get_dev(dev);
 		goto exit;
diff -Nru a/drivers/usb/host/hc_crisv10.c b/drivers/usb/host/hc_crisv10.c
--- a/drivers/usb/host/hc_crisv10.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/host/hc_crisv10.c	2005-01-07 15:42:28 -08:00
@@ -113,17 +113,17 @@
 {
 	0x12,  /*  __u8  bLength; */
 	0x01,  /*  __u8  bDescriptorType; Device */
-	0x00,  /*  __u16 bcdUSB; v1.0 */
+	0x00,  /*  __le16 bcdUSB; v1.0 */
 	0x01,
 	0x09,  /*  __u8  bDeviceClass; HUB_CLASSCODE */
 	0x00,  /*  __u8  bDeviceSubClass; */
 	0x00,  /*  __u8  bDeviceProtocol; */
 	0x08,  /*  __u8  bMaxPacketSize0; 8 Bytes */
-	0x00,  /*  __u16 idVendor; */
+	0x00,  /*  __le16 idVendor; */
 	0x00,
-	0x00,  /*  __u16 idProduct; */
+	0x00,  /*  __le16 idProduct; */
 	0x00,
-	0x00,  /*  __u16 bcdDevice; */
+	0x00,  /*  __le16 bcdDevice; */
 	0x00,
 	0x00,  /*  __u8  iManufacturer; */
 	0x02,  /*  __u8  iProduct; */
diff -Nru a/drivers/usb/image/microtek.c b/drivers/usb/image/microtek.c
--- a/drivers/usb/image/microtek.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/image/microtek.c	2005-01-07 15:42:28 -08:00
@@ -715,8 +715,8 @@
 	MTS_DEBUG( "usb-device descriptor at %x\n", (int)dev );
 
 	MTS_DEBUG( "product id = 0x%x, vendor id = 0x%x\n",
-		   (int)dev->descriptor.idProduct,
-		   (int)dev->descriptor.idVendor );
+		   le16_to_cpu(dev->descriptor.idProduct),
+		   le16_to_cpu(dev->descriptor.idVendor) );
 
 	MTS_DEBUG_GOT_HERE();
 
diff -Nru a/drivers/usb/input/aiptek.c b/drivers/usb/input/aiptek.c
--- a/drivers/usb/input/aiptek.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/aiptek.c	2005-01-07 15:42:28 -08:00
@@ -2137,9 +2137,9 @@
 	aiptek->inputdev.name = "Aiptek";
 	aiptek->inputdev.phys = aiptek->features.usbPath;
 	aiptek->inputdev.id.bustype = BUS_USB;
-	aiptek->inputdev.id.vendor = usbdev->descriptor.idVendor;
-	aiptek->inputdev.id.product = usbdev->descriptor.idProduct;
-	aiptek->inputdev.id.version = usbdev->descriptor.bcdDevice;
+	aiptek->inputdev.id.vendor = le16_to_cpu(usbdev->descriptor.idVendor);
+	aiptek->inputdev.id.product = le16_to_cpu(usbdev->descriptor.idProduct);
+	aiptek->inputdev.id.version = le16_to_cpu(usbdev->descriptor.bcdDevice);
 
 	aiptek->usbdev = usbdev;
 	aiptek->ifnum = intf->altsetting[0].desc.bInterfaceNumber;
diff -Nru a/drivers/usb/input/ati_remote.c b/drivers/usb/input/ati_remote.c
--- a/drivers/usb/input/ati_remote.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/ati_remote.c	2005-01-07 15:42:28 -08:00
@@ -672,9 +672,9 @@
 	idev->phys = ati_remote->phys;
 	
 	idev->id.bustype = BUS_USB;		
-	idev->id.vendor = ati_remote->udev->descriptor.idVendor;
-	idev->id.product = ati_remote->udev->descriptor.idProduct;
-	idev->id.version = ati_remote->udev->descriptor.bcdDevice;
+	idev->id.vendor = le16_to_cpu(ati_remote->udev->descriptor.idVendor);
+	idev->id.product = le16_to_cpu(ati_remote->udev->descriptor.idProduct);
+	idev->id.version = le16_to_cpu(ati_remote->udev->descriptor.bcdDevice);
 }
 
 static int ati_remote_initialize(struct ati_remote *ati_remote)
@@ -729,13 +729,6 @@
 	char path[64];
 	char *buf = NULL;
 
-	/* See if the offered device matches what we can accept */
-	if ((udev->descriptor.idVendor != ATI_REMOTE_VENDOR_ID) ||
-		( (udev->descriptor.idProduct != ATI_REMOTE_PRODUCT_ID) &&
-		  (udev->descriptor.idProduct != LOLA_REMOTE_PRODUCT_ID) &&
-		  (udev->descriptor.idProduct != MEDION_REMOTE_PRODUCT_ID) ))
-		return -ENODEV;
-
 	/* Allocate and clear an ati_remote struct */
 	if (!(ati_remote = kmalloc(sizeof (struct ati_remote), GFP_KERNEL)))
 		return -ENOMEM;
@@ -803,8 +796,8 @@
 
 	if (!strlen(ati_remote->name))
 		sprintf(ati_remote->name, DRIVER_DESC "(%04x,%04x)",
-			ati_remote->udev->descriptor.idVendor, 
-			ati_remote->udev->descriptor.idProduct);
+			le16_to_cpu(ati_remote->udev->descriptor.idVendor), 
+			le16_to_cpu(ati_remote->udev->descriptor.idProduct));
 
 	/* Device Hardware Initialization - fills in ati_remote->idev from udev. */
 	retval = ati_remote_initialize(ati_remote);
diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/hid-core.c	2005-01-07 15:42:28 -08:00
@@ -1599,8 +1599,8 @@
 	int n;
 
 	for (n = 0; hid_blacklist[n].idVendor; n++)
-		if ((hid_blacklist[n].idVendor == dev->descriptor.idVendor) &&
-			(hid_blacklist[n].idProduct == dev->descriptor.idProduct))
+		if ((hid_blacklist[n].idVendor == le16_to_cpu(dev->descriptor.idVendor)) &&
+			(hid_blacklist[n].idProduct == le16_to_cpu(dev->descriptor.idProduct)))
 				quirks = hid_blacklist[n].quirks;
 
 	if (quirks & HID_QUIRK_IGNORE)
@@ -1724,7 +1724,9 @@
 	} else if (usb_string(dev, dev->descriptor.iProduct, buf, 128) > 0) {
 			snprintf(hid->name, 128, "%s", buf);
 	} else
-		snprintf(hid->name, 128, "%04x:%04x", dev->descriptor.idVendor, dev->descriptor.idProduct);
+		snprintf(hid->name, 128, "%04x:%04x", 
+			 le16_to_cpu(dev->descriptor.idVendor),
+			 le16_to_cpu(dev->descriptor.idProduct));
 
 	usb_make_path(dev, buf, 64);
 	snprintf(hid->phys, 64, "%s/input%d", buf,
diff -Nru a/drivers/usb/input/hid-ff.c b/drivers/usb/input/hid-ff.c
--- a/drivers/usb/input/hid-ff.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/hid-ff.c	2005-01-07 15:42:28 -08:00
@@ -82,8 +82,8 @@
 {
 	struct hid_ff_initializer *init;
 
-	init = hid_get_ff_init(hid->dev->descriptor.idVendor,
-			       hid->dev->descriptor.idProduct);
+	init = hid_get_ff_init(le16_to_cpu(hid->dev->descriptor.idVendor),
+			       le16_to_cpu(hid->dev->descriptor.idProduct));
 
 	if (!init) {
 		dbg("hid_ff_init could not find initializer");
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/hid-input.c	2005-01-07 15:42:28 -08:00
@@ -593,9 +593,9 @@
 				hidinput->input.phys = hid->phys;
 				hidinput->input.uniq = hid->uniq;
 				hidinput->input.id.bustype = BUS_USB;
-				hidinput->input.id.vendor = dev->descriptor.idVendor;
-				hidinput->input.id.product = dev->descriptor.idProduct;
-				hidinput->input.id.version = dev->descriptor.bcdDevice;
+				hidinput->input.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
+				hidinput->input.id.product = le16_to_cpu(dev->descriptor.idProduct);
+				hidinput->input.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
 				hidinput->input.dev = &hid->intf->dev;
 			}
 
diff -Nru a/drivers/usb/input/hid-lgff.c b/drivers/usb/input/hid-lgff.c
--- a/drivers/usb/input/hid-lgff.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/hid-lgff.c	2005-01-07 15:42:28 -08:00
@@ -251,8 +251,8 @@
 {
 	struct device_type* dev = devices;
 	signed short* ff;
-	u16 idVendor = hid->dev->descriptor.idVendor;
-	u16 idProduct = hid->dev->descriptor.idProduct;
+	u16 idVendor = le16_to_cpu(hid->dev->descriptor.idVendor);
+	u16 idProduct = le16_to_cpu(hid->dev->descriptor.idProduct);
 	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
 
 	while (dev->idVendor && (idVendor != dev->idVendor || idProduct != dev->idProduct))
diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/hiddev.c	2005-01-07 15:42:28 -08:00
@@ -423,9 +423,9 @@
 		dinfo.busnum = dev->bus->busnum;
 		dinfo.devnum = dev->devnum;
 		dinfo.ifnum = hid->ifnum;
-		dinfo.vendor = dev->descriptor.idVendor;
-		dinfo.product = dev->descriptor.idProduct;
-		dinfo.version = dev->descriptor.bcdDevice;
+		dinfo.vendor = le16_to_cpu(dev->descriptor.idVendor);
+		dinfo.product = le16_to_cpu(dev->descriptor.idProduct);
+		dinfo.version = le16_to_cpu(dev->descriptor.bcdDevice);
 		dinfo.num_applications = hid->maxapplication;
 		if (copy_to_user(user_arg, &dinfo, sizeof(dinfo)))
 			return -EFAULT;
diff -Nru a/drivers/usb/input/kbtab.c b/drivers/usb/input/kbtab.c
--- a/drivers/usb/input/kbtab.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/kbtab.c	2005-01-07 15:42:28 -08:00
@@ -175,9 +175,9 @@
 	kbtab->dev.name = "KB Gear Tablet";
 	kbtab->dev.phys = kbtab->phys;
 	kbtab->dev.id.bustype = BUS_USB;
-	kbtab->dev.id.vendor = dev->descriptor.idVendor;
-	kbtab->dev.id.product = dev->descriptor.idProduct;
-	kbtab->dev.id.version = dev->descriptor.bcdDevice;
+	kbtab->dev.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
+	kbtab->dev.id.product = le16_to_cpu(dev->descriptor.idProduct);
+	kbtab->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
 	kbtab->dev.dev = &intf->dev;
 	kbtab->usbdev = dev;
 
diff -Nru a/drivers/usb/input/mtouchusb.c b/drivers/usb/input/mtouchusb.c
--- a/drivers/usb/input/mtouchusb.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/mtouchusb.c	2005-01-07 15:42:28 -08:00
@@ -223,9 +223,9 @@
         mtouch->input.name = mtouch->name;
         mtouch->input.phys = mtouch->phys;
         mtouch->input.id.bustype = BUS_USB;
-        mtouch->input.id.vendor = udev->descriptor.idVendor;
-        mtouch->input.id.product = udev->descriptor.idProduct;
-        mtouch->input.id.version = udev->descriptor.bcdDevice;
+        mtouch->input.id.vendor = le16_to_cpu(udev->descriptor.idVendor);
+        mtouch->input.id.product = le16_to_cpu(udev->descriptor.idProduct);
+        mtouch->input.id.version = le16_to_cpu(udev->descriptor.bcdDevice);
         mtouch->input.dev = &intf->dev;
 
         mtouch->input.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
diff -Nru a/drivers/usb/input/powermate.c b/drivers/usb/input/powermate.c
--- a/drivers/usb/input/powermate.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/powermate.c	2005-01-07 15:42:28 -08:00
@@ -375,12 +375,13 @@
 		return -EIO; /* failure */
 	}
 
-	switch (udev->descriptor.idProduct) {
+	switch (le16_to_cpu(udev->descriptor.idProduct)) {
 	case POWERMATE_PRODUCT_NEW: pm->input.name = pm_name_powermate; break;
 	case POWERMATE_PRODUCT_OLD: pm->input.name = pm_name_soundknob; break;
 	default: 
-	  pm->input.name = pm_name_soundknob;
-	  printk(KERN_WARNING "powermate: unknown product id %04x\n", udev->descriptor.idProduct);
+		pm->input.name = pm_name_soundknob;
+		printk(KERN_WARNING "powermate: unknown product id %04x\n",
+		       le16_to_cpu(udev->descriptor.idProduct));
 	}
 
 	pm->input.private = pm;
@@ -389,9 +390,9 @@
 	pm->input.relbit[LONG(REL_DIAL)] = BIT(REL_DIAL);
 	pm->input.mscbit[LONG(MSC_PULSELED)] = BIT(MSC_PULSELED);
 	pm->input.id.bustype = BUS_USB;
-	pm->input.id.vendor = udev->descriptor.idVendor;
-	pm->input.id.product = udev->descriptor.idProduct;
-	pm->input.id.version = udev->descriptor.bcdDevice;
+	pm->input.id.vendor = le16_to_cpu(udev->descriptor.idVendor);
+	pm->input.id.product = le16_to_cpu(udev->descriptor.idProduct);
+	pm->input.id.version = le16_to_cpu(udev->descriptor.bcdDevice);
 	pm->input.event = powermate_input_event;
 	pm->input.dev = &intf->dev;
 
diff -Nru a/drivers/usb/input/touchkitusb.c b/drivers/usb/input/touchkitusb.c
--- a/drivers/usb/input/touchkitusb.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/touchkitusb.c	2005-01-07 15:42:28 -08:00
@@ -211,9 +211,9 @@
 	touchkit->input.name = touchkit->name;
 	touchkit->input.phys = touchkit->phys;
 	touchkit->input.id.bustype = BUS_USB;
-	touchkit->input.id.vendor = udev->descriptor.idVendor;
-	touchkit->input.id.product = udev->descriptor.idProduct;
-	touchkit->input.id.version = udev->descriptor.bcdDevice;
+	touchkit->input.id.vendor = le16_to_cpu(udev->descriptor.idVendor);
+	touchkit->input.id.product = le16_to_cpu(udev->descriptor.idProduct);
+	touchkit->input.id.version = le16_to_cpu(udev->descriptor.bcdDevice);
 	touchkit->input.dev = &intf->dev;
 
 	touchkit->input.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
diff -Nru a/drivers/usb/input/usbkbd.c b/drivers/usb/input/usbkbd.c
--- a/drivers/usb/input/usbkbd.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/usbkbd.c	2005-01-07 15:42:28 -08:00
@@ -296,9 +296,9 @@
 	kbd->dev.name = kbd->name;
 	kbd->dev.phys = kbd->phys;	
 	kbd->dev.id.bustype = BUS_USB;
-	kbd->dev.id.vendor = dev->descriptor.idVendor;
-	kbd->dev.id.product = dev->descriptor.idProduct;
-	kbd->dev.id.version = dev->descriptor.bcdDevice;
+	kbd->dev.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
+	kbd->dev.id.product = le16_to_cpu(dev->descriptor.idProduct);
+	kbd->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
 	kbd->dev.dev = &iface->dev;
 
 	if (!(buf = kmalloc(63, GFP_KERNEL))) {
diff -Nru a/drivers/usb/input/usbmouse.c b/drivers/usb/input/usbmouse.c
--- a/drivers/usb/input/usbmouse.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/usbmouse.c	2005-01-07 15:42:28 -08:00
@@ -180,9 +180,9 @@
 	mouse->dev.name = mouse->name;
 	mouse->dev.phys = mouse->phys;
 	mouse->dev.id.bustype = BUS_USB;
-	mouse->dev.id.vendor = dev->descriptor.idVendor;
-	mouse->dev.id.product = dev->descriptor.idProduct;
-	mouse->dev.id.version = dev->descriptor.bcdDevice;
+	mouse->dev.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
+	mouse->dev.id.product = le16_to_cpu(dev->descriptor.idProduct);
+	mouse->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
 	mouse->dev.dev = &intf->dev;
 
 	if (!(buf = kmalloc(63, GFP_KERNEL))) {
diff -Nru a/drivers/usb/input/wacom.c b/drivers/usb/input/wacom.c
--- a/drivers/usb/input/wacom.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/wacom.c	2005-01-07 15:42:28 -08:00
@@ -692,9 +692,9 @@
 	wacom->dev.name = wacom->features->name;
 	wacom->dev.phys = wacom->phys;
 	wacom->dev.id.bustype = BUS_USB;
-	wacom->dev.id.vendor = dev->descriptor.idVendor;
-	wacom->dev.id.product = dev->descriptor.idProduct;
-	wacom->dev.id.version = dev->descriptor.bcdDevice;
+	wacom->dev.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
+	wacom->dev.id.product = le16_to_cpu(dev->descriptor.idProduct);
+	wacom->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
 	wacom->dev.dev = &intf->dev;
 	wacom->usbdev = dev;
 
diff -Nru a/drivers/usb/input/xpad.c b/drivers/usb/input/xpad.c
--- a/drivers/usb/input/xpad.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/input/xpad.c	2005-01-07 15:42:28 -08:00
@@ -226,8 +226,8 @@
 	int i;
 	
 	for (i = 0; xpad_device[i].idVendor; i++) {
-		if ((udev->descriptor.idVendor == xpad_device[i].idVendor) &&
-		    (udev->descriptor.idProduct == xpad_device[i].idProduct))
+		if ((le16_to_cpu(udev->descriptor.idVendor) == xpad_device[i].idVendor) &&
+		    (le16_to_cpu(udev->descriptor.idProduct) == xpad_device[i].idProduct))
 			break;
 	}
 	
@@ -264,9 +264,9 @@
 	xpad->udev = udev;
 	
 	xpad->dev.id.bustype = BUS_USB;
-	xpad->dev.id.vendor = udev->descriptor.idVendor;
-	xpad->dev.id.product = udev->descriptor.idProduct;
-	xpad->dev.id.version = udev->descriptor.bcdDevice;
+	xpad->dev.id.vendor = le16_to_cpu(udev->descriptor.idVendor);
+	xpad->dev.id.product = le16_to_cpu(udev->descriptor.idProduct);
+	xpad->dev.id.version = le16_to_cpu(udev->descriptor.bcdDevice);
 	xpad->dev.dev = &intf->dev;
 	xpad->dev.private = xpad;
 	xpad->dev.name = xpad_device[i].name;
diff -Nru a/drivers/usb/media/dabusb.c b/drivers/usb/media/dabusb.c
--- a/drivers/usb/media/dabusb.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/media/dabusb.c	2005-01-07 15:42:28 -08:00
@@ -724,13 +724,16 @@
 	pdabusb_t s;
 
 	dbg("dabusb: probe: vendor id 0x%x, device id 0x%x ifnum:%d",
-	  usbdev->descriptor.idVendor, usbdev->descriptor.idProduct, intf->altsetting->desc.bInterfaceNumber);
+	    le16_to_cpu(usbdev->descriptor.idVendor),
+	    le16_to_cpu(usbdev->descriptor.idProduct),
+	    intf->altsetting->desc.bInterfaceNumber);
 
 	/* We don't handle multiple configurations */
 	if (usbdev->descriptor.bNumConfigurations != 1)
 		return -ENODEV;
 
-	if (intf->altsetting->desc.bInterfaceNumber != _DABUSB_IF && usbdev->descriptor.idProduct == 0x9999)
+	if (intf->altsetting->desc.bInterfaceNumber != _DABUSB_IF &&
+	    le16_to_cpu(usbdev->descriptor.idProduct) == 0x9999)
 		return -ENODEV;
 
 
@@ -746,7 +749,7 @@
 		err("reset_configuration failed");
 		goto reject;
 	}
-	if (usbdev->descriptor.idProduct == 0x2131) {
+	if (le16_to_cpu(usbdev->descriptor.idProduct) == 0x2131) {
 		dabusb_loadmem (s, NULL);
 		goto reject;
 	}
diff -Nru a/drivers/usb/media/ibmcam.c b/drivers/usb/media/ibmcam.c
--- a/drivers/usb/media/ibmcam.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/media/ibmcam.c	2005-01-07 15:42:28 -08:00
@@ -3659,17 +3659,8 @@
 	if (dev->descriptor.bNumConfigurations != 1)
 		return -ENODEV;
 
-	/* Is it an IBM camera? */
-	if (dev->descriptor.idVendor != IBMCAM_VENDOR_ID)
-		return -ENODEV;
-	if ((dev->descriptor.idProduct != IBMCAM_PRODUCT_ID) &&
-	    (dev->descriptor.idProduct != VEO_800C_PRODUCT_ID) &&
-	    (dev->descriptor.idProduct != VEO_800D_PRODUCT_ID) &&
-	    (dev->descriptor.idProduct != NETCAM_PRODUCT_ID))
-		return -ENODEV;
-
 	/* Check the version/revision */
-	switch (dev->descriptor.bcdDevice) {
+	switch (le16_to_cpu(dev->descriptor.bcdDevice)) {
 	case 0x0002:
 		if (ifnum != 2)
 			return -ENODEV;
@@ -3678,8 +3669,8 @@
 	case 0x030A:
 		if (ifnum != 0)
 			return -ENODEV;
-		if ((dev->descriptor.idProduct == NETCAM_PRODUCT_ID) ||
-		    (dev->descriptor.idProduct == VEO_800D_PRODUCT_ID))
+		if ((le16_to_cpu(dev->descriptor.idProduct) == NETCAM_PRODUCT_ID) ||
+		    (le16_to_cpu(dev->descriptor.idProduct) == VEO_800D_PRODUCT_ID))
 			model = IBMCAM_MODEL_4;
 		else
 			model = IBMCAM_MODEL_2;
@@ -3691,14 +3682,14 @@
 		break;
 	default:
 		err("IBM camera with revision 0x%04x is not supported.",
-			dev->descriptor.bcdDevice);
+			le16_to_cpu(dev->descriptor.bcdDevice));
 		return -ENODEV;
 	}
 
 	/* Print detailed info on what we found so far */
 	do {
 		char *brand = NULL;
-		switch (dev->descriptor.idProduct) {
+		switch (le16_to_cpu(dev->descriptor.idProduct)) {
 		case NETCAM_PRODUCT_ID:
 			brand = "IBM NetCamera";
 			break;
@@ -3714,7 +3705,7 @@
 			break;
 		}
 		info("%s USB camera found (model %d, rev. 0x%04x)",
-		     brand, model, dev->descriptor.bcdDevice);
+		     brand, model, le16_to_cpu(dev->descriptor.bcdDevice));
 	} while (0);
 
 	/* Validate found interface: must have one ISO endpoint */
diff -Nru a/drivers/usb/media/konicawc.c b/drivers/usb/media/konicawc.c
--- a/drivers/usb/media/konicawc.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/media/konicawc.c	2005-01-07 15:42:28 -08:00
@@ -732,7 +732,7 @@
 	if (dev->descriptor.bNumConfigurations != 1)
 		return -ENODEV;
 
-	info("Konica Webcam (rev. 0x%04x)", dev->descriptor.bcdDevice);
+	info("Konica Webcam (rev. 0x%04x)", le16_to_cpu(dev->descriptor.bcdDevice));
 	RESTRICT_TO_RANGE(speed, 0, MAX_SPEED);
 
 	/* Validate found interface: must have one ISO endpoint */
@@ -846,9 +846,9 @@
 		cam->input.evbit[0] = BIT(EV_KEY);
 		cam->input.keybit[LONG(BTN_0)] = BIT(BTN_0);
 		cam->input.id.bustype = BUS_USB;
-		cam->input.id.vendor = dev->descriptor.idVendor;
-		cam->input.id.product = dev->descriptor.idProduct;
-		cam->input.id.version = dev->descriptor.bcdDevice;
+		cam->input.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
+		cam->input.id.product = le16_to_cpu(dev->descriptor.idProduct);
+		cam->input.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
 		input_register_device(&cam->input);
 		
 		usb_make_path(dev, cam->input_physname, 56);
diff -Nru a/drivers/usb/media/ov511.c b/drivers/usb/media/ov511.c
--- a/drivers/usb/media/ov511.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/media/ov511.c	2005-01-07 15:42:28 -08:00
@@ -5825,7 +5825,7 @@
 	ov->auto_gain = autogain;
 	ov->auto_exp = autoexp;
 
-	switch (dev->descriptor.idProduct) {
+	switch (le16_to_cpu(dev->descriptor.idProduct)) {
 	case PROD_OV511:
 		ov->bridge = BRG_OV511;
 		ov->bclass = BCL_OV511;
@@ -5843,13 +5843,13 @@
 		ov->bclass = BCL_OV518;
 		break;
 	case PROD_ME2CAM:
-		if (dev->descriptor.idVendor != VEND_MATTEL)
+		if (le16_to_cpu(dev->descriptor.idVendor) != VEND_MATTEL)
 			goto error;
 		ov->bridge = BRG_OV511PLUS;
 		ov->bclass = BCL_OV511;
 		break;
 	default:
-		err("Unknown product ID 0x%04x", dev->descriptor.idProduct);
+		err("Unknown product ID 0x%04x", le16_to_cpu(dev->descriptor.idProduct));
 		goto error;
 	}
 
diff -Nru a/drivers/usb/media/se401.c b/drivers/usb/media/se401.c
--- a/drivers/usb/media/se401.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/media/se401.c	2005-01-07 15:42:28 -08:00
@@ -1315,20 +1315,20 @@
         interface = &intf->cur_altsetting->desc;
 
         /* Is it an se401? */
-        if (dev->descriptor.idVendor == 0x03e8 &&
-            dev->descriptor.idProduct == 0x0004) {
+        if (le16_to_cpu(dev->descriptor.idVendor) == 0x03e8 &&
+            le16_to_cpu(dev->descriptor.idProduct) == 0x0004) {
                 camera_name="Endpoints/Aox SE401";
-        } else if (dev->descriptor.idVendor == 0x0471 &&
-            dev->descriptor.idProduct == 0x030b) {
+        } else if (le16_to_cpu(dev->descriptor.idVendor) == 0x0471 &&
+            le16_to_cpu(dev->descriptor.idProduct) == 0x030b) {
                 camera_name="Philips PCVC665K";
-        } else if (dev->descriptor.idVendor == 0x047d &&
-	    dev->descriptor.idProduct == 0x5001) {
+        } else if (le16_to_cpu(dev->descriptor.idVendor) == 0x047d &&
+	    le16_to_cpu(dev->descriptor.idProduct) == 0x5001) {
 		camera_name="Kensington VideoCAM 67014";
-        } else if (dev->descriptor.idVendor == 0x047d &&
-	    dev->descriptor.idProduct == 0x5002) {
+        } else if (le16_to_cpu(dev->descriptor.idVendor) == 0x047d &&
+	    le16_to_cpu(dev->descriptor.idProduct) == 0x5002) {
 		camera_name="Kensington VideoCAM 6701(5/7)";
-        } else if (dev->descriptor.idVendor == 0x047d &&
-	    dev->descriptor.idProduct == 0x5003) {
+        } else if (le16_to_cpu(dev->descriptor.idVendor) == 0x047d &&
+	    le16_to_cpu(dev->descriptor.idProduct) == 0x5003) {
 		camera_name="Kensington VideoCAM 67016";
 		button=0;
 	} else
@@ -1354,7 +1354,7 @@
         se401->iface = interface->bInterfaceNumber;
         se401->camera_name = camera_name;
 
-	info("firmware version: %02x", dev->descriptor.bcdDevice & 255);
+	info("firmware version: %02x", le16_to_cpu(dev->descriptor.bcdDevice) & 255);
 
         if (se401_init(se401, button)) {
 		kfree(se401);
diff -Nru a/drivers/usb/media/sn9c102_core.c b/drivers/usb/media/sn9c102_core.c
--- a/drivers/usb/media/sn9c102_core.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/media/sn9c102_core.c	2005-01-07 15:42:28 -08:00
@@ -2496,8 +2496,8 @@
 
 	n = sizeof(sn9c102_id_table)/sizeof(sn9c102_id_table[0]);
 	for (i = 0; i < n-1; i++)
-		if (udev->descriptor.idVendor==sn9c102_id_table[i].idVendor &&
-		    udev->descriptor.idProduct==sn9c102_id_table[i].idProduct)
+		if (le16_to_cpu(udev->descriptor.idVendor) == sn9c102_id_table[i].idVendor &&
+		    le16_to_cpu(udev->descriptor.idProduct) == sn9c102_id_table[i].idProduct)
 			break;
 	if (i == n-1)
 		return -ENODEV;
diff -Nru a/drivers/usb/media/sn9c102_tas5110c1b.c b/drivers/usb/media/sn9c102_tas5110c1b.c
--- a/drivers/usb/media/sn9c102_tas5110c1b.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/media/sn9c102_tas5110c1b.c	2005-01-07 15:42:28 -08:00
@@ -165,9 +165,9 @@
 	sn9c102_attach_sensor(cam, &tas5110c1b);
 
 	/* Sensor detection is based on USB pid/vid */
-	if (tas5110c1b.usbdev->descriptor.idProduct != 0x6001 &&
-	    tas5110c1b.usbdev->descriptor.idProduct != 0x6005 &&
-	    tas5110c1b.usbdev->descriptor.idProduct != 0x60ab)
+	if (le16_to_cpu(tas5110c1b.usbdev->descriptor.idProduct) != 0x6001 &&
+	    le16_to_cpu(tas5110c1b.usbdev->descriptor.idProduct) != 0x6005 &&
+	    le16_to_cpu(tas5110c1b.usbdev->descriptor.idProduct) != 0x60ab)
 		return -ENODEV;
 
 	return 0;
diff -Nru a/drivers/usb/media/sn9c102_tas5130d1b.c b/drivers/usb/media/sn9c102_tas5130d1b.c
--- a/drivers/usb/media/sn9c102_tas5130d1b.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/media/sn9c102_tas5130d1b.c	2005-01-07 15:42:28 -08:00
@@ -180,8 +180,8 @@
 	sn9c102_attach_sensor(cam, &tas5130d1b);
 
 	/* Sensor detection is based on USB pid/vid */
-	if (tas5130d1b.usbdev->descriptor.idProduct != 0x6025 &&
-	    tas5130d1b.usbdev->descriptor.idProduct != 0x60aa)
+	if (le16_to_cpu(tas5130d1b.usbdev->descriptor.idProduct) != 0x6025 &&
+	    le16_to_cpu(tas5130d1b.usbdev->descriptor.idProduct) != 0x60aa)
 		return -ENODEV;
 
 	return 0;
diff -Nru a/drivers/usb/media/stv680.c b/drivers/usb/media/stv680.c
--- a/drivers/usb/media/stv680.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/media/stv680.c	2005-01-07 15:42:28 -08:00
@@ -1371,7 +1371,8 @@
 
 	interface = &intf->altsetting[0];
 	/* Is it a STV680? */
-	if ((dev->descriptor.idVendor == USB_PENCAM_VENDOR_ID) && (dev->descriptor.idProduct == USB_PENCAM_PRODUCT_ID)) {
+	if ((le16_to_cpu(dev->descriptor.idVendor) == USB_PENCAM_VENDOR_ID) &&
+	    (le16_to_cpu(dev->descriptor.idProduct) == USB_PENCAM_PRODUCT_ID)) {
 		camera_name = "STV0680";
 		PDEBUG (0, "STV(i): STV0680 camera found.");
 	} else {
diff -Nru a/drivers/usb/media/ultracam.c b/drivers/usb/media/ultracam.c
--- a/drivers/usb/media/ultracam.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/media/ultracam.c	2005-01-07 15:42:28 -08:00
@@ -524,12 +524,8 @@
 	if (dev->descriptor.bNumConfigurations != 1)
 		return -ENODEV;
 
-	/* Is it an IBM camera? */
-	if ((dev->descriptor.idVendor != ULTRACAM_VENDOR_ID) ||
-	    (dev->descriptor.idProduct != ULTRACAM_PRODUCT_ID))
-		return -ENODEV;
-
-	info("IBM Ultra camera found (rev. 0x%04x)", dev->descriptor.bcdDevice);
+	info("IBM Ultra camera found (rev. 0x%04x)",
+		le16_to_cpu(dev->descriptor.bcdDevice));
 
 	/* Validate found interface: must have one ISO endpoint */
 	nas = intf->num_altsetting;
diff -Nru a/drivers/usb/media/vicam.c b/drivers/usb/media/vicam.c
--- a/drivers/usb/media/vicam.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/media/vicam.c	2005-01-07 15:42:28 -08:00
@@ -1281,12 +1281,6 @@
 	const struct usb_endpoint_descriptor *endpoint;
 	struct vicam_camera *cam;
 	
-	/* See if the device offered us matches what we can accept */
-	if ((dev->descriptor.idVendor != USB_VICAM_VENDOR_ID) ||
-	    (dev->descriptor.idProduct != USB_VICAM_PRODUCT_ID)) {
-		return -ENODEV;
-	}
-
 	printk(KERN_INFO "ViCam based webcam connected\n");
 
 	interface = intf->cur_altsetting;
diff -Nru a/drivers/usb/media/w9968cf.c b/drivers/usb/media/w9968cf.c
--- a/drivers/usb/media/w9968cf.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/media/w9968cf.c	2005-01-07 15:42:28 -08:00
@@ -3516,11 +3516,11 @@
 	u8 sc = 0; /* number of simultaneous cameras */
 	static unsigned short dev_nr = 0; /* we are handling device number n */
 
-	if (udev->descriptor.idVendor  == winbond_id_table[0].idVendor &&
-	    udev->descriptor.idProduct == winbond_id_table[0].idProduct)
+	if (le16_to_cpu(udev->descriptor.idVendor)  == winbond_id_table[0].idVendor &&
+	    le16_to_cpu(udev->descriptor.idProduct) == winbond_id_table[0].idProduct)
 		mod_id = W9968CF_MOD_CLVBWGP; /* see camlist[] table */
-	else if (udev->descriptor.idVendor  == winbond_id_table[1].idVendor &&
-	         udev->descriptor.idProduct == winbond_id_table[1].idProduct)
+	else if (le16_to_cpu(udev->descriptor.idVendor)  == winbond_id_table[1].idVendor &&
+	         le16_to_cpu(udev->descriptor.idProduct) == winbond_id_table[1].idProduct)
 		mod_id = W9968CF_MOD_GENERIC; /* see camlist[] table */
 	else
 		return -ENODEV;
diff -Nru a/drivers/usb/misc/auerswald.c b/drivers/usb/misc/auerswald.c
--- a/drivers/usb/misc/auerswald.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/misc/auerswald.c	2005-01-07 15:42:28 -08:00
@@ -1931,11 +1931,8 @@
 	int ret;
 
 	dbg ("probe: vendor id 0x%x, device id 0x%x",
-	     usbdev->descriptor.idVendor, usbdev->descriptor.idProduct);
-
-	/* See if the device offered us matches that we can accept */
-	if (usbdev->descriptor.idVendor != ID_AUERSWALD)
-		return -ENODEV;
+	     le16_to_cpu(usbdev->descriptor.idVendor),
+	     le16_to_cpu(usbdev->descriptor.idProduct));
 
         /* we use only the first -and only- interface */
         if (intf->altsetting->desc.bInterfaceNumber != 0)
@@ -1969,7 +1966,7 @@
 	cp->dtindex = intf->minor;
 
 	/* Get the usb version of the device */
-	cp->version = cp->usbdev->descriptor.bcdDevice;
+	cp->version = le16_to_cpu(cp->usbdev->descriptor.bcdDevice);
 	dbg ("Version is %X", cp->version);
 
 	/* allow some time to settle the device */
diff -Nru a/drivers/usb/misc/emi26.c b/drivers/usb/misc/emi26.c
--- a/drivers/usb/misc/emi26.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/misc/emi26.c	2005-01-07 15:42:28 -08:00
@@ -213,11 +213,9 @@
 	struct usb_device *dev = interface_to_usbdev(intf);
 
 	info("%s start", __FUNCTION__); 
-	
-	if((dev->descriptor.idVendor == EMI26_VENDOR_ID) && (dev->descriptor.idProduct == EMI26_PRODUCT_ID)) {
-		emi26_load_firmware(dev);
-	}
-	
+
+	emi26_load_firmware(dev);
+
 	/* do not return the driver context, let real audio driver do that */
 	return -EIO;
 }
diff -Nru a/drivers/usb/misc/emi62.c b/drivers/usb/misc/emi62.c
--- a/drivers/usb/misc/emi62.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/misc/emi62.c	2005-01-07 15:42:28 -08:00
@@ -255,10 +255,8 @@
 
 	info("%s start", __FUNCTION__); 
 
-	if((dev->descriptor.idVendor == EMI62_VENDOR_ID) && (dev->descriptor.idProduct == EMI62_PRODUCT_ID)) {
-		emi62_load_firmware(dev);
-	}
-	
+	emi62_load_firmware(dev);
+
 	/* do not return the driver context, let real audio driver do that */
 	return -EIO;
 }
diff -Nru a/drivers/usb/misc/legousbtower.c b/drivers/usb/misc/legousbtower.c
--- a/drivers/usb/misc/legousbtower.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/misc/legousbtower.c	2005-01-07 15:42:28 -08:00
@@ -859,13 +859,6 @@
 		info ("udev is NULL.");
 	}
 
-	/* See if the device offered us matches what we can accept */
-	if ((udev->descriptor.idVendor != LEGO_USB_TOWER_VENDOR_ID) ||
-	    (udev->descriptor.idProduct != LEGO_USB_TOWER_PRODUCT_ID)) {
-		return -ENODEV;
-	}
-
-
 	/* allocate memory for our device state and intialize it */
 
 	dev = kmalloc (sizeof(struct lego_usb_tower), GFP_KERNEL);
diff -Nru a/drivers/usb/misc/usblcd.c b/drivers/usb/misc/usblcd.c
--- a/drivers/usb/misc/usblcd.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/misc/usblcd.c	2005-01-07 15:42:28 -08:00
@@ -74,7 +74,7 @@
 	  unsigned long arg)
 {
 	struct lcd_usb_data *lcd = &lcd_instance;
-	int i;
+	u16 bcdDevice;
 	char buf[30];
 
 	/* Sanity check to make sure lcd is connected, powered, etc */
@@ -85,9 +85,12 @@
 
 	switch (cmd) {
 	case IOCTL_GET_HARD_VERSION:
-		i = (lcd->lcd_dev)->descriptor.bcdDevice;
-		sprintf(buf,"%1d%1d.%1d%1d",(i & 0xF000)>>12,(i & 0xF00)>>8,
-			(i & 0xF0)>>4,(i & 0xF));
+		bcdDevice = le16_to_cpu((lcd->lcd_dev)->descriptor.bcdDevice);
+		sprintf(buf,"%1d%1d.%1d%1d",
+			(bcdDevice & 0xF000)>>12,
+			(bcdDevice & 0xF00)>>8,
+			(bcdDevice & 0xF0)>>4,
+			(bcdDevice & 0xF));
 		if (copy_to_user((void __user *)arg,buf,strlen(buf))!=0)
 			return -EFAULT;
 		break;
@@ -258,7 +261,7 @@
 	int i;
 	int retval;
 
-	if (dev->descriptor.idProduct != 0x0001  ) {
+	if (le16_to_cpu(dev->descriptor.idProduct) != 0x0001) {
 		warn(KERN_INFO "USBLCD model not supported.");
 		return -ENODEV;
 	}
@@ -268,7 +271,7 @@
 		return -ENODEV;
 	}
 
-	i = dev->descriptor.bcdDevice;
+	i = le16_to_cpu(dev->descriptor.bcdDevice);
 
 	info("USBLCD Version %1d%1d.%1d%1d found at address %d",
 		(i & 0xF000)>>12,(i & 0xF00)>>8,(i & 0xF0)>>4,(i & 0xF),
diff -Nru a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
--- a/drivers/usb/misc/usbtest.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/misc/usbtest.c	2005-01-07 15:42:28 -08:00
@@ -636,7 +636,7 @@
 	}
 
 	/* and sometimes [9.2.6.6] speed dependent descriptors */
-	if (udev->descriptor.bcdUSB == 0x0200) {	/* pre-swapped */
+	if (le16_to_cpu(udev->descriptor.bcdUSB) == 0x0200) {
 		struct usb_qualifier_descriptor		*d = NULL;
 
 		/* device qualifier [9.6.2] */
@@ -1842,13 +1842,13 @@
 	/* specify devices by module parameters? */
 	if (id->match_flags == 0) {
 		/* vendor match required, product match optional */
-		if (!vendor || udev->descriptor.idVendor != (u16)vendor)
+		if (!vendor || le16_to_cpu(udev->descriptor.idVendor) != (u16)vendor)
 			return -ENODEV;
-		if (product && udev->descriptor.idProduct != (u16)product)
+		if (product && le16_to_cpu(udev->descriptor.idProduct) != (u16)product)
 			return -ENODEV;
 		dbg ("matched module params, vend=0x%04x prod=0x%04x",
-				udev->descriptor.idVendor,
-				udev->descriptor.idProduct);
+				le16_to_cpu(udev->descriptor.idVendor),
+				le16_to_cpu(udev->descriptor.idProduct));
 	}
 #endif
 
diff -Nru a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
--- a/drivers/usb/misc/uss720.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/misc/uss720.c	2005-01-07 15:42:28 -08:00
@@ -544,7 +544,8 @@
 	int i;
 
 	printk(KERN_DEBUG "uss720: probe: vendor id 0x%x, device id 0x%x\n",
-	       usbdev->descriptor.idVendor, usbdev->descriptor.idProduct);
+	       le16_to_cpu(usbdev->descriptor.idVendor),
+	       le16_to_cpu(usbdev->descriptor.idProduct));
 
 	/* our known interfaces have 3 alternate settings */
 	if (intf->num_altsetting != 3)
diff -Nru a/drivers/usb/net/catc.c b/drivers/usb/net/catc.c
--- a/drivers/usb/net/catc.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/net/catc.c	2005-01-07 15:42:28 -08:00
@@ -800,8 +800,9 @@
 	}
 
 	/* The F5U011 has the same vendor/product as the netmate but a device version of 0x130 */
-	if (usbdev->descriptor.idVendor == 0x0423 && usbdev->descriptor.idProduct == 0xa &&
-	   catc->usbdev->descriptor.bcdDevice == 0x0130	) {
+	if (le16_to_cpu(usbdev->descriptor.idVendor) == 0x0423 && 
+	    le16_to_cpu(usbdev->descriptor.idProduct) == 0xa &&
+	    le16_to_cpu(catc->usbdev->descriptor.bcdDevice) == 0x0130) {
 		dbg("Testing for f5u011");
 		catc->is_f5u011 = 1;		
 		atomic_set(&catc->recq_sz, 0);
diff -Nru a/drivers/usb/net/kaweth.c b/drivers/usb/net/kaweth.c
--- a/drivers/usb/net/kaweth.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/net/kaweth.c	2005-01-07 15:42:28 -08:00
@@ -903,9 +903,9 @@
 
 	kaweth_dbg("Kawasaki Device Probe (Device number:%d): 0x%4.4x:0x%4.4x:0x%4.4x",
 		 dev->devnum,
-		 (int)dev->descriptor.idVendor,
-		 (int)dev->descriptor.idProduct,
-		 (int)dev->descriptor.bcdDevice);
+		 le16_to_cpu(dev->descriptor.idVendor),
+		 le16_to_cpu(dev->descriptor.idProduct),
+		 le16_to_cpu(dev->descriptor.bcdDevice));
 
 	kaweth_dbg("Device at %p", dev);
 
@@ -933,7 +933,7 @@
 	 * downloaded. Don't try to do it again, or we'll hang the device.
 	 */
 
-	if (dev->descriptor.bcdDevice >> 8) {
+	if (le16_to_cpu(dev->descriptor.bcdDevice) >> 8) {
 		kaweth_info("Firmware present in device.");
 	} else {
 		/* Download the firmware */
diff -Nru a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
--- a/drivers/usb/serial/belkin_sa.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/serial/belkin_sa.c	2005-01-07 15:42:28 -08:00
@@ -181,8 +181,8 @@
 	priv->last_lsr = 0;
 	priv->last_msr = 0;
 	/* see comments at top of file */
-	priv->bad_flow_control = (dev->descriptor.bcdDevice <= 0x0206) ? 1 : 0;
-	info("bcdDevice: %04x, bfc: %d", dev->descriptor.bcdDevice, priv->bad_flow_control);
+	priv->bad_flow_control = (le16_to_cpu(dev->descriptor.bcdDevice) <= 0x0206) ? 1 : 0;
+	info("bcdDevice: %04x, bfc: %d", le16_to_cpu(dev->descriptor.bcdDevice), priv->bad_flow_control);
 
 	init_waitqueue_head(&serial->port[0]->write_wait);
 	usb_set_serial_port_data(serial->port[0], priv);
diff -Nru a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
--- a/drivers/usb/serial/io_edgeport.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/serial/io_edgeport.c	2005-01-07 15:42:28 -08:00
@@ -659,7 +659,7 @@
 
 	memset (product_info, 0, sizeof(struct edgeport_product_info));
 
-	product_info->ProductId		= (__u16)(edge_serial->serial->dev->descriptor.idProduct & ~ION_DEVICE_ID_80251_NETCHIP);
+	product_info->ProductId		= (__u16)(le16_to_cpu(edge_serial->serial->dev->descriptor.idProduct) & ~ION_DEVICE_ID_80251_NETCHIP);
 	product_info->NumPorts		= edge_serial->manuf_descriptor.NumPorts;
 	product_info->ProdInfoVer	= 0;
 
@@ -675,7 +675,7 @@
 	memcpy(product_info->ManufactureDescDate, edge_serial->manuf_descriptor.DescDate, sizeof(edge_serial->manuf_descriptor.DescDate));
 
 	// check if this is 2nd generation hardware
-	if (edge_serial->serial->dev->descriptor.idProduct & ION_DEVICE_ID_80251_NETCHIP) {
+	if (le16_to_cpu(edge_serial->serial->dev->descriptor.idProduct) & ION_DEVICE_ID_80251_NETCHIP) {
 		product_info->FirmwareMajorVersion	= OperationalCodeImageVersion_GEN2.MajorVersion;
 		product_info->FirmwareMinorVersion	= OperationalCodeImageVersion_GEN2.MinorVersion;
 		product_info->FirmwareBuildNumber	= cpu_to_le16(OperationalCodeImageVersion_GEN2.BuildNumber);
diff -Nru a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
--- a/drivers/usb/serial/io_ti.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/serial/io_ti.c	2005-01-07 15:42:28 -08:00
@@ -1342,9 +1342,9 @@
 	if (status)
 		return status;
 
-	if (serial->serial->dev->descriptor.idVendor != USB_VENDOR_ID_ION) {
+	if (le16_to_cpu(serial->serial->dev->descriptor.idVendor) != USB_VENDOR_ID_ION) {
 		dbg ("%s - VID = 0x%x", __FUNCTION__,
-		     serial->serial->dev->descriptor.idVendor);
+		     le16_to_cpu(serial->serial->dev->descriptor.idVendor));
 		serial->TI_I2C_Type = DTK_ADDR_SPACE_I2C_TYPE_II;
 		goto StayInBootMode;
 	}
diff -Nru a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
--- a/drivers/usb/serial/keyspan.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/serial/keyspan.c	2005-01-07 15:42:28 -08:00
@@ -1174,16 +1174,16 @@
 	char				*fw_name;
 
 	dbg("Keyspan startup version %04x product %04x",
-	    serial->dev->descriptor.bcdDevice,
-	    serial->dev->descriptor.idProduct); 
+	    le16_to_cpu(serial->dev->descriptor.bcdDevice),
+	    le16_to_cpu(serial->dev->descriptor.idProduct));
 	
-	if ((serial->dev->descriptor.bcdDevice & 0x8000) != 0x8000) {
+	if ((le16_to_cpu(serial->dev->descriptor.bcdDevice) & 0x8000) != 0x8000) {
 		dbg("Firmware already loaded.  Quitting.");
 		return(1);
 	}
 
 		/* Select firmware image on the basis of idProduct */
-	switch (serial->dev->descriptor.idProduct) {
+	switch (le16_to_cpu(serial->dev->descriptor.idProduct)) {
 	case keyspan_usa28_pre_product_id:
 		record = &keyspan_usa28_firmware[0];
 		fw_name = "USA28";
@@ -2248,10 +2248,10 @@
 	dbg("%s", __FUNCTION__);
 
 	for (i = 0; (d_details = keyspan_devices[i]) != NULL; ++i)
-		if (d_details->product_id == serial->dev->descriptor.idProduct)
+		if (d_details->product_id == le16_to_cpu(serial->dev->descriptor.idProduct))
 			break;
 	if (d_details == NULL) {
-		dev_err(&serial->dev->dev, "%s - unknown product id %x\n", __FUNCTION__, serial->dev->descriptor.idProduct);
+		dev_err(&serial->dev->dev, "%s - unknown product id %x\n", __FUNCTION__, le16_to_cpu(serial->dev->descriptor.idProduct));
 		return 1;
 	}
 
diff -Nru a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
--- a/drivers/usb/serial/keyspan_pda.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/serial/keyspan_pda.c	2005-01-07 15:42:28 -08:00
@@ -713,12 +713,12 @@
 	response = ezusb_set_reset(serial, 1);
 
 #ifdef KEYSPAN
-	if (serial->dev->descriptor.idVendor == KEYSPAN_VENDOR_ID)
+	if (le16_to_cpu(serial->dev->descriptor.idVendor) == KEYSPAN_VENDOR_ID)
 		record = &keyspan_pda_firmware[0];
 #endif
 #ifdef XIRCOM
-	if ((serial->dev->descriptor.idVendor == XIRCOM_VENDOR_ID) ||
-	    (serial->dev->descriptor.idVendor == ENTREGRA_VENDOR_ID))
+	if ((le16_to_cpu(serial->dev->descriptor.idVendor) == XIRCOM_VENDOR_ID) ||
+	    (le16_to_cpu(serial->dev->descriptor.idVendor) == ENTREGRA_VENDOR_ID))
 		record = &xircom_pgs_firmware[0];
 #endif
 	if (record == NULL) {
diff -Nru a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
--- a/drivers/usb/serial/kobil_sct.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/serial/kobil_sct.c	2005-01-07 15:42:28 -08:00
@@ -155,7 +155,7 @@
 
 	priv->filled = 0;
 	priv->cur_pos = 0;
-	priv->device_type = serial->product;
+	priv->device_type = le16_to_cpu(serial->dev->descriptor.idProduct);
 	priv->line_state = 0;
 
 	switch (priv->device_type){
diff -Nru a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
--- a/drivers/usb/serial/mct_u232.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/serial/mct_u232.c	2005-01-07 15:42:28 -08:00
@@ -173,9 +173,10 @@
  * we do not know how to support. We ignore them for the moment.
  * XXX Rate-limit the error message, it's user triggerable.
  */
-static int mct_u232_calculate_baud_rate(struct usb_serial *serial, int value) {
-	if (serial->dev->descriptor.idProduct == MCT_U232_SITECOM_PID
-	  || serial->dev->descriptor.idProduct == MCT_U232_BELKIN_F5U109_PID) {
+static int mct_u232_calculate_baud_rate(struct usb_serial *serial, int value)
+{
+	if (le16_to_cpu(serial->dev->descriptor.idProduct) == MCT_U232_SITECOM_PID
+	  || le16_to_cpu(serial->dev->descriptor.idProduct) == MCT_U232_BELKIN_F5U109_PID) {
 		switch (value) {
 		case    B300: return 0x01;
 		case    B600: return 0x02; /* this one not tested */
@@ -403,7 +404,7 @@
 	 * it seems to be able to accept only 16 bytes (and that's what
 	 * SniffUSB says too...)
 	 */
-	if (serial->dev->descriptor.idProduct == MCT_U232_SITECOM_PID)
+	if (le16_to_cpu(serial->dev->descriptor.idProduct) == MCT_U232_SITECOM_PID)
 		port->bulk_out_size = 16;
 
 	/* Do a defined restart: the normal serial device seems to 
diff -Nru a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
--- a/drivers/usb/serial/ti_usb_3410_5052.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/serial/ti_usb_3410_5052.c	2005-01-07 15:42:28 -08:00
@@ -407,7 +407,10 @@
 	int i;
 
 
-	dbg("%s - product 0x%4X, num configurations %d, configuration value %d", __FUNCTION__, dev->descriptor.idProduct, dev->descriptor.bNumConfigurations, dev->actconfig->desc.bConfigurationValue);
+	dbg("%s - product 0x%4X, num configurations %d, configuration value %d",
+	    __FUNCTION__, le16_to_cpu(dev->descriptor.idProduct),
+	    dev->descriptor.bNumConfigurations,
+	    dev->actconfig->desc.bConfigurationValue);
 
 	/* create device structure */
 	tdev = kmalloc(sizeof(struct ti_device), GFP_KERNEL);
diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/serial/usb-serial.c	2005-01-07 15:42:28 -08:00
@@ -721,7 +721,9 @@
 		if (serial->type->owner)
 			length += sprintf (page+length, " module:%s", module_name(serial->type->owner));
 		length += sprintf (page+length, " name:\"%s\"", serial->type->name);
-		length += sprintf (page+length, " vendor:%04x product:%04x", serial->vendor, serial->product);
+		length += sprintf (page+length, " vendor:%04x product:%04x", 
+				   le16_to_cpu(serial->dev->descriptor.idVendor), 
+				   le16_to_cpu(serial->dev->descriptor.idProduct));
 		length += sprintf (page+length, " num_ports:%d", serial->num_ports);
 		length += sprintf (page+length, " port:%d", i - serial->minor + 1);
 
@@ -834,8 +836,6 @@
 	serial->dev = usb_get_dev(dev);
 	serial->type = type;
 	serial->interface = interface;
-	serial->vendor = dev->descriptor.idVendor;
-	serial->product = dev->descriptor.idProduct;
 	kref_init(&serial->kref);
 
 	return serial;
@@ -959,10 +959,10 @@
 #if defined(CONFIG_USB_SERIAL_PL2303) || defined(CONFIG_USB_SERIAL_PL2303_MODULE)
 	/* BEGIN HORRIBLE HACK FOR PL2303 */ 
 	/* this is needed due to the looney way its endpoints are set up */
-	if (((dev->descriptor.idVendor == PL2303_VENDOR_ID) &&
-	     (dev->descriptor.idProduct == PL2303_PRODUCT_ID)) ||
-	    ((dev->descriptor.idVendor == ATEN_VENDOR_ID) &&
-	     (dev->descriptor.idProduct == ATEN_PRODUCT_ID))) {
+	if (((le16_to_cpu(dev->descriptor.idVendor) == PL2303_VENDOR_ID) &&
+	     (le16_to_cpu(dev->descriptor.idProduct) == PL2303_PRODUCT_ID)) ||
+	    ((le16_to_cpu(dev->descriptor.idVendor) == ATEN_VENDOR_ID) &&
+	     (le16_to_cpu(dev->descriptor.idProduct) == ATEN_PRODUCT_ID))) {
 		if (interface != dev->actconfig->interface[0]) {
 			/* check out the endpoints of the other interface*/
 			iface_desc = dev->actconfig->interface[0]->cur_altsetting;
diff -Nru a/drivers/usb/serial/usb-serial.h b/drivers/usb/serial/usb-serial.h
--- a/drivers/usb/serial/usb-serial.h	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/serial/usb-serial.h	2005-01-07 15:42:28 -08:00
@@ -148,8 +148,6 @@
  * @num_interrupt_out: number of interrupt out endpoints we have
  * @num_bulk_in: number of bulk in endpoints we have
  * @num_bulk_out: number of bulk out endpoints we have
- * @vendor: vendor id of this device
- * @product: product id of this device
  * @port: array of struct usb_serial_port structures for the different ports.
  * @private: place to put any driver specific information that is needed.  The
  *	usb-serial driver is required to manage this data, the usb-serial core
@@ -167,8 +165,6 @@
 	char				num_interrupt_out;
 	char				num_bulk_in;
 	char				num_bulk_out;
-	__u16				vendor;
-	__u16				product;
 	struct usb_serial_port *	port[MAX_NUM_PORTS];
 	struct kref			kref;
 	void *				private;
diff -Nru a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
--- a/drivers/usb/serial/visor.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/serial/visor.c	2005-01-07 15:42:28 -08:00
@@ -926,8 +926,8 @@
 
 	/* Only do this endpoint hack for the Handspring devices with
 	 * interrupt in endpoints, which for now are the Treo devices. */
-	if (!((serial->dev->descriptor.idVendor == HANDSPRING_VENDOR_ID) ||
-	      (serial->dev->descriptor.idVendor == KYOCERA_VENDOR_ID)) ||
+	if (!((le16_to_cpu(serial->dev->descriptor.idVendor) == HANDSPRING_VENDOR_ID) ||
+	      (le16_to_cpu(serial->dev->descriptor.idVendor) == KYOCERA_VENDOR_ID)) ||
 	    (serial->num_interrupt_in == 0))
 		goto generic_startup;
 
diff -Nru a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
--- a/drivers/usb/storage/scsiglue.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/storage/scsiglue.c	2005-01-07 15:42:28 -08:00
@@ -118,7 +118,7 @@
 	 * works okay and that's what Windows does.  But we'll be
 	 * conservative; people can always use the sysfs interface to
 	 * increase max_sectors. */
-	if (us->pusb_dev->descriptor.idVendor == USB_VENDOR_ID_GENESYS &&
+	if (le16_to_cpu(us->pusb_dev->descriptor.idVendor) == USB_VENDOR_ID_GENESYS &&
 			sdev->request_queue->max_sectors > 64)
 		blk_queue_max_sectors(sdev->request_queue, 64);
 
diff -Nru a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
--- a/drivers/usb/storage/transport.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/storage/transport.c	2005-01-07 15:42:28 -08:00
@@ -994,7 +994,7 @@
 	/* Genesys Logic interface chips need a 100us delay between the
 	 * command phase and the data phase.  Some devices need a little
 	 * more than that, probably because of clock rate inaccuracies. */
-	if (us->pusb_dev->descriptor.idVendor == USB_VENDOR_ID_GENESYS)
+	if (le16_to_cpu(us->pusb_dev->descriptor.idVendor) == USB_VENDOR_ID_GENESYS)
 		udelay(110);
 
 	if (transfer_length) {
diff -Nru a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
--- a/drivers/usb/storage/usb.c	2005-01-07 15:42:28 -08:00
+++ b/drivers/usb/storage/usb.c	2005-01-07 15:42:28 -08:00
@@ -263,16 +263,17 @@
 			      available from the device."). */
 		memset(data+8,0,28);
 	} else {
+		u16 bcdDevice = le16_to_cpu(us->pusb_dev->descriptor.bcdDevice);
 		memcpy(data+8, us->unusual_dev->vendorName, 
 			strlen(us->unusual_dev->vendorName) > 8 ? 8 :
 			strlen(us->unusual_dev->vendorName));
 		memcpy(data+16, us->unusual_dev->productName, 
 			strlen(us->unusual_dev->productName) > 16 ? 16 :
 			strlen(us->unusual_dev->productName));
-		data[32] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>12) & 0x0F);
-		data[33] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>8) & 0x0F);
-		data[34] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>4) & 0x0F);
-		data[35] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice) & 0x0F);
+		data[32] = 0x30 + ((bcdDevice>>12) & 0x0F);
+		data[33] = 0x30 + ((bcdDevice>>8) & 0x0F);
+		data[34] = 0x30 + ((bcdDevice>>4) & 0x0F);
+		data[35] = 0x30 + ((bcdDevice) & 0x0F);
 	}
 
 	usb_stor_set_xfer_buf(data, data_len, us->srb);
@@ -436,9 +437,9 @@
 	us->pusb_intf = intf;
 	us->ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 	US_DEBUGP("Vendor: 0x%04x, Product: 0x%04x, Revision: 0x%04x\n",
-			us->pusb_dev->descriptor.idVendor,
-			us->pusb_dev->descriptor.idProduct,
-			us->pusb_dev->descriptor.bcdDevice);
+			le16_to_cpu(us->pusb_dev->descriptor.idVendor),
+			le16_to_cpu(us->pusb_dev->descriptor.idProduct),
+			le16_to_cpu(us->pusb_dev->descriptor.bcdDevice));
 	US_DEBUGP("Interface Subclass: 0x%02x, Protocol: 0x%02x\n",
 			intf->cur_altsetting->desc.bInterfaceSubClass,
 			intf->cur_altsetting->desc.bInterfaceProtocol);
@@ -507,8 +508,9 @@
 				" has %s in unusual_devs.h\n"
 				"   Please send a copy of this message to "
 				"<linux-usb-devel@lists.sourceforge.net>\n",
-				ddesc->idVendor, ddesc->idProduct,
-				ddesc->bcdDevice,
+				le16_to_cpu(ddesc->idVendor),
+				le16_to_cpu(ddesc->idProduct),
+				le16_to_cpu(ddesc->bcdDevice),
 				idesc->bInterfaceSubClass,
 				idesc->bInterfaceProtocol,
 				msgs[msg]);
diff -Nru a/include/linux/usb_ch9.h b/include/linux/usb_ch9.h
--- a/include/linux/usb_ch9.h	2005-01-07 15:42:28 -08:00
+++ b/include/linux/usb_ch9.h	2005-01-07 15:42:28 -08:00
@@ -156,14 +156,14 @@
 	__u8  bLength;
 	__u8  bDescriptorType;
 
-	__u16 bcdUSB;
+	__le16 bcdUSB;
 	__u8  bDeviceClass;
 	__u8  bDeviceSubClass;
 	__u8  bDeviceProtocol;
 	__u8  bMaxPacketSize0;
-	__u16 idVendor;
-	__u16 idProduct;
-	__u16 bcdDevice;
+	__le16 idVendor;
+	__le16 idProduct;
+	__le16 bcdDevice;
 	__u8  iManufacturer;
 	__u8  iProduct;
 	__u8  iSerialNumber;
@@ -297,7 +297,7 @@
 	__u8  bLength;
 	__u8  bDescriptorType;
 
-	__u16 bcdUSB;
+	__le16 bcdUSB;
 	__u8  bDeviceClass;
 	__u8  bDeviceSubClass;
 	__u8  bDeviceProtocol;
diff -Nru a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
--- a/sound/usb/usbaudio.c	2005-01-07 15:42:28 -08:00
+++ b/sound/usb/usbaudio.c	2005-01-07 15:42:28 -08:00
@@ -2176,13 +2176,13 @@
 static int is_big_endian_format(struct usb_device *dev, struct audioformat *fp)
 {
 	/* M-Audio */
-	if (dev->descriptor.idVendor == 0x0763) {
+	if (le16_to_cpu(dev->descriptor.idVendor) == 0x0763) {
 		/* Quattro: captured data only */
-		if (dev->descriptor.idProduct == 0x2001 &&
+		if (le16_to_cpu(dev->descriptor.idProduct) == 0x2001 &&
 		    fp->endpoint & USB_DIR_IN)
 			return 1;
 		/* Audiophile USB */
-		if (dev->descriptor.idProduct == 0x2003)
+		if (le16_to_cpu(dev->descriptor.idProduct) == 0x2003)
 			return 1;
 	}
 	return 0;
@@ -2246,7 +2246,8 @@
 		break;
 	case USB_AUDIO_FORMAT_PCM8:
 		/* Dallas DS4201 workaround */
-		if (dev->descriptor.idVendor == 0x04fa && dev->descriptor.idProduct == 0x4201)
+		if (le16_to_cpu(dev->descriptor.idVendor) == 0x04fa &&
+		    le16_to_cpu(dev->descriptor.idProduct) == 0x4201)
 			pcm_format = SNDRV_PCM_FORMAT_S8;
 		else
 			pcm_format = SNDRV_PCM_FORMAT_U8;
@@ -2414,7 +2415,8 @@
 	/* extigy apparently supports sample rates other than 48k
 	 * but not in ordinary way.  so we enable only 48k atm.
 	 */
-	if (dev->descriptor.idVendor == 0x041e && dev->descriptor.idProduct == 0x3000) {
+	if (le16_to_cpu(dev->descriptor.idVendor) == 0x041e && 
+	    le16_to_cpu(dev->descriptor.idProduct) == 0x3000) {
 		if (fmt[3] == USB_FORMAT_TYPE_I &&
 		    stream == SNDRV_PCM_STREAM_PLAYBACK &&
 		    fp->rates != SNDRV_PCM_RATE_48000)
@@ -2517,8 +2519,8 @@
 		/* some quirks for attributes here */
 
 		/* workaround for AudioTrak Optoplay */
-		if (dev->descriptor.idVendor == 0x0a92 &&
-		    dev->descriptor.idProduct == 0x0053) {
+		if (le16_to_cpu(dev->descriptor.idVendor) == 0x0a92 &&
+		    le16_to_cpu(dev->descriptor.idProduct) == 0x0053) {
 			/* Optoplay sets the sample rate attribute although
 			 * it seems not supporting it in fact.
 			 */
@@ -2526,8 +2528,8 @@
 		}
 
 		/* workaround for M-Audio Audiophile USB */
-		if (dev->descriptor.idVendor == 0x0763 &&
-		    dev->descriptor.idProduct == 0x2003) {
+		if (le16_to_cpu(dev->descriptor.idVendor) == 0x0763 &&
+		    le16_to_cpu(dev->descriptor.idProduct) == 0x2003) {
 			/* doesn't set the sample rate attribute, but supports it */
 			fp->attributes |= EP_CS_ATTR_SAMPLE_RATE;
 		}
@@ -2536,11 +2538,11 @@
 		 * plantronics headset and Griffin iMic have set adaptive-in
 		 * although it's really not...
 		 */
-		if ((dev->descriptor.idVendor == 0x047f &&
-		     dev->descriptor.idProduct == 0x0ca1) ||
+		if ((le16_to_cpu(dev->descriptor.idVendor) == 0x047f &&
+		     le16_to_cpu(dev->descriptor.idProduct) == 0x0ca1) ||
 		    /* Griffin iMic (note that there is an older model 77d:223) */
-		    (dev->descriptor.idVendor == 0x077d &&
-		     dev->descriptor.idProduct == 0x07af)) {
+		    (le16_to_cpu(dev->descriptor.idVendor) == 0x077d &&
+		     le16_to_cpu(dev->descriptor.idProduct) == 0x07af)) {
 			fp->ep_attr &= ~EP_ATTR_MASK;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 				fp->ep_attr |= EP_ATTR_ADAPTIVE;
@@ -2788,7 +2790,7 @@
 			.type = QUIRK_MIDI_FIXED_ENDPOINT,
 			.data = &ua25_ep
 		};
-		if (chip->dev->descriptor.idProduct == 0x002b)
+		if (le16_to_cpu(chip->dev->descriptor.idProduct) == 0x002b)
 			return snd_usb_create_midi_interface(chip, iface,
 							     &ua700_quirk);
 		else
@@ -3000,7 +3002,9 @@
 {
 	snd_usb_audio_t *chip = entry->private_data;
 	if (! chip->shutdown)
-		snd_iprintf(buffer, "%04x:%04x\n", chip->dev->descriptor.idVendor, chip->dev->descriptor.idProduct);
+		snd_iprintf(buffer, "%04x:%04x\n", 
+			    le16_to_cpu(chip->dev->descriptor.idVendor),
+			    le16_to_cpu(chip->dev->descriptor.idProduct));
 }
 
 static void snd_usb_audio_create_proc(snd_usb_audio_t *chip)
@@ -3081,7 +3085,8 @@
 
 	strcpy(card->driver, "USB-Audio");
 	sprintf(component, "USB%04x:%04x",
-		dev->descriptor.idVendor, dev->descriptor.idProduct);
+		le16_to_cpu(dev->descriptor.idVendor),
+		le16_to_cpu(dev->descriptor.idProduct));
 	snd_component_add(card, component);
 
 	/* retrieve the device string as shortname */
@@ -3093,7 +3098,8 @@
       			       card->shortname, sizeof(card->shortname)) <= 0) {
 			/* no name available from anywhere, so use ID */
 			sprintf(card->shortname, "USB Device %#04x:%#04x",
-				dev->descriptor.idVendor, dev->descriptor.idProduct);
+				le16_to_cpu(dev->descriptor.idVendor),
+				le16_to_cpu(dev->descriptor.idProduct));
 		}
 	}
 
@@ -3160,7 +3166,8 @@
 
 	/* SB Extigy needs special boot-up sequence */
 	/* if more models come, this will go to the quirk list. */
-	if (dev->descriptor.idVendor == 0x041e && dev->descriptor.idProduct == 0x3000) {
+	if (le16_to_cpu(dev->descriptor.idVendor) == 0x041e && 
+	    le16_to_cpu(dev->descriptor.idProduct) == 0x3000) {
 		if (snd_usb_extigy_boot_quirk(dev, intf) < 0)
 			goto __err_val;
 		config = dev->actconfig;
@@ -3194,8 +3201,8 @@
 		}
 		for (i = 0; i < SNDRV_CARDS; i++)
 			if (enable[i] && ! usb_chip[i] &&
-			    (vid[i] == -1 || vid[i] == dev->descriptor.idVendor) &&
-			    (pid[i] == -1 || pid[i] == dev->descriptor.idProduct)) {
+			    (vid[i] == -1 || vid[i] == le16_to_cpu(dev->descriptor.idVendor)) &&
+			    (pid[i] == -1 || pid[i] == le16_to_cpu(dev->descriptor.idProduct))) {
 				if (snd_usb_audio_create(dev, i, quirk, &chip) < 0) {
 					goto __error;
 				}
diff -Nru a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
--- a/sound/usb/usbmidi.c	2005-01-07 15:42:28 -08:00
+++ b/sound/usb/usbmidi.c	2005-01-07 15:42:28 -08:00
@@ -521,7 +521,7 @@
 	struct usb_host_interface *hostif;
 	struct usb_interface_descriptor* intfd;
 
-	if (umidi->chip->dev->descriptor.idVendor != 0x0582)
+	if (le16_to_cpu(umidi->chip->dev->descriptor.idVendor) != 0x0582)
 		return NULL;
 	intf = umidi->iface;
 	if (!intf || intf->num_altsetting != 2)
@@ -839,8 +839,8 @@
 
 	/* TODO: read port name from jack descriptor */
 	name_format = "%s MIDI %d";
-	vendor = umidi->chip->dev->descriptor.idVendor;
-	product = umidi->chip->dev->descriptor.idProduct;
+	vendor = le16_to_cpu(umidi->chip->dev->descriptor.idVendor);
+	product = le16_to_cpu(umidi->chip->dev->descriptor.idProduct);
 	for (i = 0; i < ARRAY_SIZE(snd_usbmidi_port_names); ++i) {
 		if (snd_usbmidi_port_names[i].vendor == vendor &&
 		    snd_usbmidi_port_names[i].product == product &&
diff -Nru a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
--- a/sound/usb/usbmixer.c	2005-01-07 15:42:28 -08:00
+++ b/sound/usb/usbmixer.c	2005-01-07 15:42:28 -08:00
@@ -1490,12 +1490,12 @@
 	state.buffer = hostif->extra;
 	state.buflen = hostif->extralen;
 	state.ctrlif = ctrlif;
-	state.vendor = dev->idVendor;
-	state.product = dev->idProduct;
+	state.vendor = le16_to_cpu(dev->idVendor);
+	state.product = le16_to_cpu(dev->idProduct);
 
 	/* check the mapping table */
 	for (map = usbmix_ctl_maps; map->vendor; map++) {
-		if (map->vendor == dev->idVendor && map->product == dev->idProduct) {
+		if (map->vendor == le16_to_cpu(dev->idVendor) && map->product == le16_to_cpu(dev->idProduct)) {
 			state.map = map->map;
 			chip->ignore_ctl_error = map->ignore_ctl_error;
 			break;
diff -Nru a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
--- a/sound/usb/usx2y/usX2Yhwdep.c	2005-01-07 15:42:28 -08:00
+++ b/sound/usb/usx2y/usX2Yhwdep.c	2005-01-07 15:42:28 -08:00
@@ -133,7 +133,7 @@
 	};
 	int id = -1;
 
-	switch (((usX2Ydev_t*)hw->private_data)->chip.dev->descriptor.idProduct) {
+	switch (le16_to_cpu(((usX2Ydev_t*)hw->private_data)->chip.dev->descriptor.idProduct)) {
 	case USB_ID_US122:
 		id = USX2Y_TYPE_122;
 		break;
@@ -185,7 +185,7 @@
 	};
 	struct usb_device *dev = usX2Y(card)->chip.dev;
 	struct usb_interface *iface = usb_ifnum_to_if(dev, 0);
-	snd_usb_audio_quirk_t *quirk = dev->descriptor.idProduct == USB_ID_US428 ? &quirk_2 : &quirk_1;
+	snd_usb_audio_quirk_t *quirk = le16_to_cpu(dev->descriptor.idProduct) == USB_ID_US428 ? &quirk_2 : &quirk_1;
 
 	snd_printdd("usX2Y_create_usbmidi \n");
 	return snd_usb_create_midi_interface(&usX2Y(card)->chip, iface, quirk);
diff -Nru a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
--- a/sound/usb/usx2y/usbusx2y.c	2005-01-07 15:42:28 -08:00
+++ b/sound/usb/usx2y/usbusx2y.c	2005-01-07 15:42:28 -08:00
@@ -331,7 +331,8 @@
 	sprintf(card->shortname, "TASCAM "NAME_ALLCAPS"");
 	sprintf(card->longname, "%s (%x:%x if %d at %03d/%03d)",
 		card->shortname, 
-		device->descriptor.idVendor, device->descriptor.idProduct,
+		le16_to_cpu(device->descriptor.idVendor),
+		le16_to_cpu(device->descriptor.idProduct),
 		0,//us428(card)->usbmidi.ifnum,
 		usX2Y(card)->chip.dev->bus->busnum, usX2Y(card)->chip.dev->devnum
 		);
@@ -344,10 +345,10 @@
 {
 	int		err;
 	snd_card_t*	card;
-	if (device->descriptor.idVendor != 0x1604 ||
-	    (device->descriptor.idProduct != USB_ID_US122 &&
-	     device->descriptor.idProduct != USB_ID_US224 &&
-	     device->descriptor.idProduct != USB_ID_US428) ||
+	if (le16_to_cpu(device->descriptor.idVendor) != 0x1604 ||
+	    (le16_to_cpu(device->descriptor.idProduct) != USB_ID_US122 &&
+	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US224 &&
+	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US428) ||
 	    !(card = usX2Y_create_card(device)))
 		return NULL;
 	if ((err = usX2Y_hwdep_new(card, device)) < 0  ||
diff -Nru a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
--- a/sound/usb/usx2y/usbusx2yaudio.c	2005-01-07 15:42:28 -08:00
+++ b/sound/usb/usx2y/usbusx2yaudio.c	2005-01-07 15:42:28 -08:00
@@ -1023,10 +1023,10 @@
 
 	if (0 > (err = usX2Y_audio_stream_new(card, 0xA, 0x8)))
 		return err;
-	if (usX2Y(card)->chip.dev->descriptor.idProduct == USB_ID_US428)
+	if (le16_to_cpu(usX2Y(card)->chip.dev->descriptor.idProduct) == USB_ID_US428)
 	     if (0 > (err = usX2Y_audio_stream_new(card, 0, 0xA)))
 		     return err;
-	if (usX2Y(card)->chip.dev->descriptor.idProduct != USB_ID_US122)
+	if (le16_to_cpu(usX2Y(card)->chip.dev->descriptor.idProduct) != USB_ID_US122)
 		err = usX2Y_rate_set(usX2Y(card), 44100);	// Lets us428 recognize output-volume settings, disturbs us122.
 	return err;
 }

