Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbULTXyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbULTXyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbULTXyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:54:44 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:58342 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261700AbULTXjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:39:22 -0500
Date: Mon, 20 Dec 2004 15:39:04 -0800
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] convert struct usb_device_descriptor to native endian
Message-ID: <20041220233904.GA21870@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed last week, (see
http://article.gmane.org/gmane.linux.kernel/262089 for the thread) I've
committed the following patch to the USB bk trees.  

Consider this a "heads up" for any USB drivers that are outside of the
main kernel tree (and if there are any, why not submit them for
inclusion?)

thanks,

greg k-h

-----------

USB: convert the idVendor, idProduct, bcdDevice and bcdUSB fields to __le16
   
These fields are in the struct usb_device_descriptor, and now we keep
the native (on-the-wire mode) format of these fields.  Any driver using
these fields needs to convert it to cpu endian before using them.
	   
All USB drivers in the kernel tree have been fixed up to work properly
with this change.  All out-of-the USB kernel drivers are on their own...
	         
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


--- 1.5/drivers/char/watchdog/pcwd_usb.c	2004-08-09 20:17:59 -07:00
+++ edited/drivers/char/watchdog/pcwd_usb.c	2004-12-17 17:15:30 -08:00
@@ -571,12 +571,6 @@ static int usb_pcwd_probe(struct usb_int
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
===== drivers/isdn/hisax/hfc_usb.c 1.7 vs edited =====
--- 1.7/drivers/isdn/hisax/hfc_usb.c	2004-07-18 04:46:12 -07:00
+++ edited/drivers/isdn/hisax/hfc_usb.c	2004-12-20 10:21:13 -08:00
@@ -1360,9 +1360,10 @@ static int hfc_usb_probe(struct usb_inte
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
 	
 
===== drivers/isdn/hisax/st5481_init.c 1.15 vs edited =====
--- 1.15/drivers/isdn/hisax/st5481_init.c	2004-04-15 09:22:24 -07:00
+++ edited/drivers/isdn/hisax/st5481_init.c	2004-12-20 10:21:40 -08:00
@@ -67,7 +67,8 @@ static int probe_st5481(struct usb_inter
 	int retval, i;
 
 	printk(KERN_INFO "st541: found adapter VendorId %04x, ProductId %04x, LEDs %d\n",
-	     dev->descriptor.idVendor, dev->descriptor.idProduct,
+	     le16_to_cpu(dev->descriptor.idVendor),
+	     le16_to_cpu(dev->descriptor.idProduct),
 	     number_of_leds);
 
 	adapter = kmalloc(sizeof(struct st5481_adapter), GFP_KERNEL);
===== drivers/media/dvb/dibusb/dvb-dibusb.c 1.4 vs edited =====
--- 1.4/drivers/media/dvb/dibusb/dvb-dibusb.c	2004-12-14 08:47:28 -08:00
+++ edited/drivers/media/dvb/dibusb/dvb-dibusb.c	2004-12-17 17:18:21 -08:00
@@ -602,8 +602,8 @@ static void frontend_init(struct usb_dib
 
 	if (dib->fe == NULL) {
 		printk("dvb-dibusb: A frontend driver was not found for device %04x/%04x\n",
-		       dib->udev->descriptor.idVendor,
-		       dib->udev->descriptor.idProduct);
+		       le16_to_cpu(dib->udev->descriptor.idVendor),
+		       le16_to_cpu(dib->udev->descriptor.idProduct));
 	} else {
 		if (dvb_register_frontend(dib->adapter, dib->fe)) {
 			printk("dvb-dibusb: Frontend registration failed!\n");
@@ -917,11 +917,11 @@ static int dibusb_probe(struct usb_inter
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
@@ -931,7 +931,7 @@ static int dibusb_probe(struct usb_inter
 
 	if (dibdev == NULL) {
 		err("something went very wrong, "
-				"unknown product ID: %.4x",udev->descriptor.idProduct);
+				"unknown product ID: %.4x",le16_to_cpu(udev->descriptor.idProduct));
 		return -ENODEV;
 	}
 
===== drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c 1.18 vs edited =====
--- 1.18/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-12-14 08:51:06 -08:00
+++ edited/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-12-17 17:17:19 -08:00
@@ -1348,7 +1348,7 @@ static struct tda8083_config ttusb_novas
 
 static void frontend_init(struct ttusb* ttusb)
 {
-	switch(ttusb->dev->descriptor.idProduct) {
+	switch(le16_to_cpu(ttusb->dev->descriptor.idProduct)) {
 	case 0x1003: // Hauppauge/TT Nova-USB-S budget (stv0299/ALPS BSRU6(tsa5059)
 		// try the ALPS BSRU6 first
 		ttusb->fe = stv0299_attach(&alps_bsru6_config, &ttusb->i2c_adap);
@@ -1381,8 +1381,8 @@ static void frontend_init(struct ttusb* 
 
 	if (ttusb->fe == NULL) {
 		printk("dvb-ttusb-budget: A frontend driver was not found for device %04x/%04x\n",
-		       ttusb->dev->descriptor.idVendor,
-		       ttusb->dev->descriptor.idProduct);
+		       le16_to_cpu(ttusb->dev->descriptor.idVendor),
+		       le16_to_cpu(ttusb->dev->descriptor.idProduct));
 	} else {
 		if (dvb_register_frontend(ttusb->adapter, ttusb->fe)) {
 			printk("dvb-ttusb-budget: Frontend registration failed!\n");
===== drivers/media/dvb/ttusb-dec/ttusb_dec.c 1.20 vs edited =====
--- 1.20/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-12-10 09:08:27 -08:00
+++ edited/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-12-17 17:17:38 -08:00
@@ -1447,7 +1447,7 @@ static int ttusb_dec_probe(struct usb_in
 
 	memset(dec, 0, sizeof(struct ttusb_dec));
 
-	switch (id->idProduct) {
+	switch (le16_to_cpu(id->idProduct)) {
 		case 0x1006:
 		ttusb_dec_set_model(dec, TTUSB_DEC3000S);
 			break;
@@ -1471,7 +1471,7 @@ static int ttusb_dec_probe(struct usb_in
 	ttusb_dec_init_dvb(dec);
 
 	dec->adapter->priv = dec;
-	switch (id->idProduct) {
+	switch (le16_to_cpu(id->idProduct)) {
 	case 0x1006:
 		dec->fe = ttusbdecfe_dvbs_attach(&fe_config);
 		break;
@@ -1484,8 +1484,8 @@ static int ttusb_dec_probe(struct usb_in
 
 	if (dec->fe == NULL) {
 		printk("dvb-ttusb-dec: A frontend driver was not found for device %04x/%04x\n",
-		       dec->udev->descriptor.idVendor,
-		       dec->udev->descriptor.idProduct);
+		       le16_to_cpu(dec->udev->descriptor.idVendor),
+		       le16_to_cpu(dec->udev->descriptor.idProduct));
 	} else {
 		if (dvb_register_frontend(dec->adapter, dec->fe)) {
 			printk("budget-ci: Frontend registration failed!\n");
===== drivers/net/irda/irda-usb.c 1.52 vs edited =====
--- 1.52/drivers/net/irda/irda-usb.c	2004-12-10 09:08:28 -08:00
+++ edited/drivers/net/irda/irda-usb.c	2004-12-17 17:05:03 -08:00
@@ -1360,8 +1360,8 @@ static int irda_usb_probe(struct usb_int
 	 * Jean II */
 
 	MESSAGE("IRDA-USB found at address %d, Vendor: %x, Product: %x\n",
-		dev->devnum, dev->descriptor.idVendor,
-		dev->descriptor.idProduct);
+		dev->devnum, le16_to_cpu(dev->descriptor.idVendor),
+		le16_to_cpu(dev->descriptor.idProduct));
 
 	net = alloc_irdadev(sizeof(*self));
 	if (!net) 
===== drivers/net/irda/stir4200.c 1.13 vs edited =====
--- 1.13/drivers/net/irda/stir4200.c	2004-12-10 09:08:28 -08:00
+++ edited/drivers/net/irda/stir4200.c	2004-12-17 17:05:27 -08:00
@@ -1072,8 +1072,8 @@ static int stir_probe(struct usb_interfa
 
 	printk(KERN_INFO "SigmaTel STIr4200 IRDA/USB found at address %d, "
 		"Vendor: %x, Product: %x\n",
-	       dev->devnum, dev->descriptor.idVendor,
-	       dev->descriptor.idProduct);
+	       dev->devnum, le16_to_cpu(dev->descriptor.idVendor),
+	       le16_to_cpu(dev->descriptor.idProduct));
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&stir->qos);
===== drivers/usb/atm/speedtch.c 1.2 vs edited =====
--- 1.2/drivers/usb/atm/speedtch.c	2004-10-18 13:36:19 -07:00
+++ edited/drivers/usb/atm/speedtch.c	2004-12-17 16:26:51 -08:00
@@ -594,7 +594,7 @@ static int speedtch_find_firmware(struct
 				  const struct firmware **fw_p)
 {
 	char buf[24];
-	const u16 bcdDevice = instance->u.usb_dev->descriptor.bcdDevice;
+	const u16 bcdDevice = le16_to_cpu(instance->u.usb_dev->descriptor.bcdDevice);
 	const u8 major_revision = bcdDevice >> 8;
 	const u8 minor_revision = bcdDevice & 0xff;
 
@@ -737,11 +737,12 @@ static int speedtch_usb_probe(struct usb
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
===== drivers/usb/class/audio.c 1.88 vs edited =====
--- 1.88/drivers/usb/class/audio.c	2004-11-01 10:59:18 -08:00
+++ edited/drivers/usb/class/audio.c	2004-12-17 16:18:28 -08:00
@@ -2971,7 +2971,8 @@ static void usb_audio_parsestreaming(str
 			}
 			format = (fmt[5] == 2) ? (AFMT_U16_LE | AFMT_U8) : (AFMT_S16_LE | AFMT_S8);
 			/* Dallas DS4201 workaround */
-			if (dev->descriptor.idVendor == 0x04fa && dev->descriptor.idProduct == 0x4201)
+			if (le16_to_cpu(dev->descriptor.idVendor) == 0x04fa && 
+			    le16_to_cpu(dev->descriptor.idProduct) == 0x4201)
 				format = (AFMT_S16_LE | AFMT_S8);
 			fmt = find_csinterface_descriptor(buffer, buflen, NULL, FORMAT_TYPE, asifout, i);
 			if (!fmt) {
===== drivers/usb/class/usb-midi.c 1.54 vs edited =====
--- 1.54/drivers/usb/class/usb-midi.c	2004-10-20 09:38:07 -07:00
+++ edited/drivers/usb/class/usb-midi.c	2004-12-17 16:22:46 -08:00
@@ -1306,8 +1306,8 @@ static struct usb_midi_device *parse_des
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
@@ -1661,11 +1661,11 @@ static int alloc_usb_midi_device( struct
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
@@ -1782,7 +1782,7 @@ static int detect_yamaha_device( struct 
 	int alts=-1;
 	int ret;
 
-	if (d->descriptor.idVendor != USB_VENDOR_ID_YAMAHA) {
+	if (le16_to_cpu(d->descriptor.idVendor) != USB_VENDOR_ID_YAMAHA) {
 		return -EINVAL;
 	}
 
@@ -1799,7 +1799,8 @@ static int detect_yamaha_device( struct 
 	}
 
 	printk(KERN_INFO "usb-midi: Found YAMAHA USB-MIDI device on dev %04x:%04x, iface %d\n",
-	       d->descriptor.idVendor, d->descriptor.idProduct, ifnum);
+	       le16_to_cpu(d->descriptor.idVendor),
+	       le16_to_cpu(d->descriptor.idProduct), ifnum);
 
 	i = d->actconfig - d->config;
 	buffer = d->rawdescriptors[i];
@@ -1833,8 +1834,8 @@ static int detect_vendor_specific_device
 	for ( i=0; i<VENDOR_SPECIFIC_USB_MIDI_DEVICES ; i++ ) {
 		u=&(usb_midi_devices[i]);
     
-		if ( d->descriptor.idVendor != u->idVendor ||
-		     d->descriptor.idProduct != u->idProduct ||
+		if ( le16_to_cpu(d->descriptor.idVendor) != u->idVendor ||
+		     le16_to_cpu(d->descriptor.idProduct) != u->idProduct ||
 		     ifnum != u->interface )
 			continue;
 
@@ -1875,7 +1876,8 @@ static int detect_midi_subclass(struct u
 	}
 
 	printk(KERN_INFO "usb-midi: Found MIDISTREAMING on dev %04x:%04x, iface %d\n",
-	       d->descriptor.idVendor, d->descriptor.idProduct, ifnum);
+	       le16_to_cpu(d->descriptor.idVendor), 
+	       le16_to_cpu(d->descriptor.idProduct), ifnum);
 
 
 	/* From USB Spec v2.0, Section 9.5.
@@ -1915,8 +1917,8 @@ static int detect_by_hand(struct usb_dev
 {
 	struct usb_midi_device u;
 
-	if ( d->descriptor.idVendor != uvendor ||
-	     d->descriptor.idProduct != uproduct ||
+	if ( le16_to_cpu(d->descriptor.idVendor) != uvendor ||
+	     le16_to_cpu(d->descriptor.idProduct) != uproduct ||
 	     ifnum != uinterface ) {
 		return -EINVAL;
 	}
===== drivers/usb/class/usb-midi.h 1.9 vs edited =====
--- 1.9/drivers/usb/class/usb-midi.h	2003-12-30 10:25:12 -08:00
+++ edited/drivers/usb/class/usb-midi.h	2004-12-17 16:20:47 -08:00
@@ -63,8 +63,8 @@ struct usb_midi_endpoint {
 struct usb_midi_device {
 	char  *deviceName;
 
-	int    idVendor;
-	int    idProduct;
+	u16    idVendor;
+	u16    idProduct;
 	int    interface;
 	int    altSetting; /* -1: auto detect */
 
===== drivers/usb/class/usblp.c 1.114 vs edited =====
--- 1.114/drivers/usb/class/usblp.c	2004-11-01 10:59:18 -08:00
+++ edited/drivers/usb/class/usblp.c	2004-12-17 16:24:39 -08:00
@@ -527,7 +527,7 @@ static int usblp_ioctl(struct inode *ino
 
 			case IOCNR_HP_SET_CHANNEL:
 				if (_IOC_DIR(cmd) != _IOC_WRITE ||
-				    usblp->dev->descriptor.idVendor != 0x03F0 ||
+				    le16_to_cpu(usblp->dev->descriptor.idVendor) != 0x03F0 ||
 				    usblp->quirks & USBLP_QUIRK_BIDIR) {
 					retval = -EINVAL;
 					goto done;
@@ -574,8 +574,8 @@ static int usblp_ioctl(struct inode *ino
 					goto done;
 				}
 
-				twoints[0] = usblp->dev->descriptor.idVendor;
-				twoints[1] = usblp->dev->descriptor.idProduct;
+				twoints[0] = le16_to_cpu(usblp->dev->descriptor.idVendor);
+				twoints[1] = le16_to_cpu(usblp->dev->descriptor.idProduct);
 				if (copy_to_user((void __user *)arg,
 						(unsigned char *)twoints,
 						sizeof(twoints))) {
@@ -910,15 +910,15 @@ static int usblp_probe(struct usb_interf
 
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
 
@@ -938,8 +938,9 @@ static int usblp_probe(struct usb_interf
 		usblp->minor, usblp->bidir ? "Bi" : "Uni", dev->devnum,
 		usblp->ifnum,
 		usblp->protocol[usblp->current_protocol].alt_setting,
-		usblp->current_protocol, usblp->dev->descriptor.idVendor,
-		usblp->dev->descriptor.idProduct);
+		usblp->current_protocol,
+		le16_to_cpu(usblp->dev->descriptor.idVendor),
+		le16_to_cpu(usblp->dev->descriptor.idProduct));
 
 	usb_set_intfdata (intf, usblp);
 
===== drivers/usb/core/devices.c 1.46 vs edited =====
--- 1.46/drivers/usb/core/devices.c	2004-10-20 09:38:07 -07:00
+++ edited/drivers/usb/core/devices.c	2004-12-17 16:13:41 -08:00
@@ -335,10 +335,13 @@ static char *usb_dump_config (
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
@@ -348,8 +351,9 @@ static char *usb_dump_device_descriptor(
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
 
===== drivers/usb/core/hcd.c 1.172 vs edited =====
--- 1.172/drivers/usb/core/hcd.c	2004-11-27 19:12:58 -08:00
+++ edited/drivers/usb/core/hcd.c	2004-12-20 13:40:04 -08:00
@@ -120,16 +120,16 @@ DECLARE_WAIT_QUEUE_HEAD(usb_kill_urb_que
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
@@ -143,16 +143,16 @@ static const u8 usb2_rh_dev_descriptor [
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
===== drivers/usb/core/hub.c 1.215 vs edited =====
--- 1.215/drivers/usb/core/hub.c	2004-11-27 15:14:57 -08:00
+++ edited/drivers/usb/core/hub.c	2004-12-17 16:13:41 -08:00
@@ -2468,7 +2468,7 @@ static void hub_port_connect_change(stru
 		}
  
 		/* check for devices running slower than they could */
-		if (udev->descriptor.bcdUSB >= 0x0200
+		if (le16_to_cpu(udev->descriptor.bcdUSB) >= 0x0200
 				&& udev->speed == USB_SPEED_FULL
 				&& highspeed_hubs != 0)
 			check_highspeed (hub, udev, port);
===== drivers/usb/core/message.c 1.123 vs edited =====
--- 1.123/drivers/usb/core/message.c	2004-11-28 01:49:39 -08:00
+++ edited/drivers/usb/core/message.c	2004-12-20 10:00:38 -08:00
@@ -796,13 +796,8 @@ int usb_get_device_descriptor(struct usb
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
===== drivers/usb/core/otg_whitelist.h 1.1 vs edited =====
--- 1.1/drivers/usb/core/otg_whitelist.h	2004-09-13 09:05:49 -07:00
+++ edited/drivers/usb/core/otg_whitelist.h	2004-12-20 10:28:38 -08:00
@@ -55,8 +55,8 @@ static int is_targeted(struct usb_device
 		return 1;
 
 	/* HNP test device is _never_ targeted (see OTG spec 6.6.6) */
-	if (dev->descriptor.idVendor == 0x1a0a
-			&& dev->descriptor.idProduct == 0xbadd)
+	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x1a0a && 
+	     le16_to_cpu(dev->descriptor.idProduct) == 0xbadd))
 		return 0;
 
 	/* NOTE: can't use usb_match_id() since interface caches
@@ -64,21 +64,21 @@ static int is_targeted(struct usb_device
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
@@ -101,8 +101,8 @@ static int is_targeted(struct usb_device
 
 	/* OTG MESSAGE: report errors here, customize to match your product */
 	dev_err(&dev->dev, "device v%04x p%04x is not supported\n",
-			dev->descriptor.idVendor,
-			dev->descriptor.idProduct);
+		le16_to_cpu(dev->descriptor.idVendor),
+		le16_to_cpu(dev->descriptor.idProduct));
 #ifdef	CONFIG_USB_OTG_WHITELIST
 	return 0;
 #else
===== drivers/usb/core/sysfs.c 1.29 vs edited =====
--- 1.29/drivers/usb/core/sysfs.c	2004-10-20 09:38:07 -07:00
+++ edited/drivers/usb/core/sysfs.c	2004-12-17 16:13:41 -08:00
@@ -149,10 +149,11 @@ static ssize_t
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
 
@@ -167,6 +168,22 @@ show_maxchild (struct device *dev, char 
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
@@ -178,9 +195,6 @@ show_##field (struct device *dev, char *
 }									\
 static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
 
-usb_descriptor_attr (idVendor, "%04x\n")
-usb_descriptor_attr (idProduct, "%04x\n")
-usb_descriptor_attr (bcdDevice, "%04x\n")
 usb_descriptor_attr (bDeviceClass, "%02x\n")
 usb_descriptor_attr (bDeviceSubClass, "%02x\n")
 usb_descriptor_attr (bDeviceProtocol, "%02x\n")
===== drivers/usb/core/usb.c 1.307 vs edited =====
--- 1.307/drivers/usb/core/usb.c	2004-11-28 03:03:48 -08:00
+++ edited/drivers/usb/core/usb.c	2004-12-17 16:13:41 -08:00
@@ -423,21 +423,21 @@ usb_match_id(struct usb_interface *inter
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
@@ -588,9 +588,9 @@ static int usb_hotplug (struct device *d
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
@@ -959,12 +959,12 @@ static struct usb_device *match_device(s
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
===== drivers/usb/host/hc_crisv10.c 1.4 vs edited =====
--- 1.4/drivers/usb/host/hc_crisv10.c	2004-11-27 15:14:57 -08:00
+++ edited/drivers/usb/host/hc_crisv10.c	2004-12-20 13:41:02 -08:00
@@ -113,17 +113,17 @@ static __u8 root_hub_dev_des[] =
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
===== drivers/usb/image/microtek.c 1.50 vs edited =====
--- 1.50/drivers/usb/image/microtek.c	2004-10-20 09:38:10 -07:00
+++ edited/drivers/usb/image/microtek.c	2004-12-20 10:49:19 -08:00
@@ -715,8 +715,8 @@ static int mts_usb_probe(struct usb_inte
 	MTS_DEBUG( "usb-device descriptor at %x\n", (int)dev );
 
 	MTS_DEBUG( "product id = 0x%x, vendor id = 0x%x\n",
-		   (int)dev->descriptor.idProduct,
-		   (int)dev->descriptor.idVendor );
+		   le16_to_cpu(dev->descriptor.idProduct),
+		   le16_to_cpu(dev->descriptor.idVendor) );
 
 	MTS_DEBUG_GOT_HERE();
 
===== drivers/usb/input/aiptek.c 1.47 vs edited =====
--- 1.47/drivers/usb/input/aiptek.c	2004-10-20 09:38:10 -07:00
+++ edited/drivers/usb/input/aiptek.c	2004-12-17 16:28:03 -08:00
@@ -2137,9 +2137,9 @@ aiptek_probe(struct usb_interface *intf,
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
===== drivers/usb/input/ati_remote.c 1.11 vs edited =====
--- 1.11/drivers/usb/input/ati_remote.c	2004-12-01 09:39:00 -08:00
+++ edited/drivers/usb/input/ati_remote.c	2004-12-17 16:30:44 -08:00
@@ -672,9 +672,9 @@ static void ati_remote_input_init(struct
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
@@ -729,13 +729,6 @@ static int ati_remote_probe(struct usb_i
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
@@ -803,8 +796,8 @@ static int ati_remote_probe(struct usb_i
 
 	if (!strlen(ati_remote->name))
 		sprintf(ati_remote->name, DRIVER_DESC "(%04x,%04x)",
-			ati_remote->udev->descriptor.idVendor, 
-			ati_remote->udev->descriptor.idProduct);
+			le16_to_cpu(ati_remote->udev->descriptor.idVendor), 
+			le16_to_cpu(ati_remote->udev->descriptor.idProduct));
 
 	/* Device Hardware Initialization - fills in ati_remote->idev from udev. */
 	retval = ati_remote_initialize(ati_remote);
===== drivers/usb/input/hid-core.c 1.137 vs edited =====
--- 1.137/drivers/usb/input/hid-core.c	2004-12-01 09:39:01 -08:00
+++ edited/drivers/usb/input/hid-core.c	2004-12-17 16:30:24 -08:00
@@ -1599,8 +1599,8 @@ static struct hid_device *usb_hid_config
 	int n;
 
 	for (n = 0; hid_blacklist[n].idVendor; n++)
-		if ((hid_blacklist[n].idVendor == dev->descriptor.idVendor) &&
-			(hid_blacklist[n].idProduct == dev->descriptor.idProduct))
+		if ((hid_blacklist[n].idVendor == le16_to_cpu(dev->descriptor.idVendor)) &&
+			(hid_blacklist[n].idProduct == le16_to_cpu(dev->descriptor.idProduct)))
 				quirks = hid_blacklist[n].quirks;
 
 	if (quirks & HID_QUIRK_IGNORE)
@@ -1724,7 +1724,9 @@ static struct hid_device *usb_hid_config
 	} else if (usb_string(dev, dev->descriptor.iProduct, buf, 128) > 0) {
 			snprintf(hid->name, 128, "%s", buf);
 	} else
-		snprintf(hid->name, 128, "%04x:%04x", dev->descriptor.idVendor, dev->descriptor.idProduct);
+		snprintf(hid->name, 128, "%04x:%04x", 
+			 le16_to_cpu(dev->descriptor.idVendor),
+			 le16_to_cpu(dev->descriptor.idProduct));
 
 	usb_make_path(dev, buf, 64);
 	snprintf(hid->phys, 64, "%s/input%d", buf,
===== drivers/usb/input/hid-ff.c 1.8 vs edited =====
--- 1.8/drivers/usb/input/hid-ff.c	2004-03-17 11:16:49 -08:00
+++ edited/drivers/usb/input/hid-ff.c	2004-12-17 16:33:05 -08:00
@@ -82,8 +82,8 @@ int hid_ff_init(struct hid_device* hid)
 {
 	struct hid_ff_initializer *init;
 
-	init = hid_get_ff_init(hid->dev->descriptor.idVendor,
-			       hid->dev->descriptor.idProduct);
+	init = hid_get_ff_init(le16_to_cpu(hid->dev->descriptor.idVendor),
+			       le16_to_cpu(hid->dev->descriptor.idProduct));
 
 	if (!init) {
 		dbg("hid_ff_init could not find initializer");
===== drivers/usb/input/hid-input.c 1.29 vs edited =====
--- 1.29/drivers/usb/input/hid-input.c	2004-03-17 11:16:49 -08:00
+++ edited/drivers/usb/input/hid-input.c	2004-12-17 16:32:07 -08:00
@@ -593,9 +593,9 @@ int hidinput_connect(struct hid_device *
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
 
===== drivers/usb/input/hid-lgff.c 1.9 vs edited =====
--- 1.9/drivers/usb/input/hid-lgff.c	2004-01-25 20:11:02 -08:00
+++ edited/drivers/usb/input/hid-lgff.c	2004-12-17 16:32:38 -08:00
@@ -251,8 +251,8 @@ static void hid_lgff_input_init(struct h
 {
 	struct device_type* dev = devices;
 	signed short* ff;
-	u16 idVendor = hid->dev->descriptor.idVendor;
-	u16 idProduct = hid->dev->descriptor.idProduct;
+	u16 idVendor = le16_to_cpu(hid->dev->descriptor.idVendor);
+	u16 idProduct = le16_to_cpu(hid->dev->descriptor.idProduct);
 	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
 
 	while (dev->idVendor && (idVendor != dev->idVendor || idProduct != dev->idProduct))
===== drivers/usb/input/hiddev.c 1.75 vs edited =====
--- 1.75/drivers/usb/input/hiddev.c	2004-09-29 23:09:24 -07:00
+++ edited/drivers/usb/input/hiddev.c	2004-12-17 16:31:31 -08:00
@@ -423,9 +423,9 @@ static int hiddev_ioctl(struct inode *in
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
===== drivers/usb/input/kbtab.c 1.23 vs edited =====
--- 1.23/drivers/usb/input/kbtab.c	2004-10-20 09:38:10 -07:00
+++ edited/drivers/usb/input/kbtab.c	2004-12-17 16:33:29 -08:00
@@ -175,9 +175,9 @@ static int kbtab_probe(struct usb_interf
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
 
===== drivers/usb/input/mtouchusb.c 1.6 vs edited =====
--- 1.6/drivers/usb/input/mtouchusb.c	2004-10-20 09:38:10 -07:00
+++ edited/drivers/usb/input/mtouchusb.c	2004-12-17 16:34:43 -08:00
@@ -223,9 +223,9 @@ static int mtouchusb_probe(struct usb_in
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
===== drivers/usb/input/powermate.c 1.37 vs edited =====
--- 1.37/drivers/usb/input/powermate.c	2004-11-05 10:06:32 -08:00
+++ edited/drivers/usb/input/powermate.c	2004-12-17 16:35:54 -08:00
@@ -375,12 +375,13 @@ static int powermate_probe(struct usb_in
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
@@ -389,9 +390,9 @@ static int powermate_probe(struct usb_in
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
 
===== drivers/usb/input/touchkitusb.c 1.5 vs edited =====
--- 1.5/drivers/usb/input/touchkitusb.c	2004-12-01 09:39:01 -08:00
+++ edited/drivers/usb/input/touchkitusb.c	2004-12-17 16:34:22 -08:00
@@ -211,9 +211,9 @@ static int touchkit_probe(struct usb_int
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
===== drivers/usb/input/usbkbd.c 1.59 vs edited =====
--- 1.59/drivers/usb/input/usbkbd.c	2004-10-20 09:38:11 -07:00
+++ edited/drivers/usb/input/usbkbd.c	2004-12-20 10:50:42 -08:00
@@ -296,9 +296,9 @@ static int usb_kbd_probe(struct usb_inte
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
===== drivers/usb/input/usbmouse.c 1.52 vs edited =====
--- 1.52/drivers/usb/input/usbmouse.c	2004-10-20 09:38:11 -07:00
+++ edited/drivers/usb/input/usbmouse.c	2004-12-20 10:51:13 -08:00
@@ -180,9 +180,9 @@ static int usb_mouse_probe(struct usb_in
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
===== drivers/usb/input/wacom.c 1.51 vs edited =====
--- 1.51/drivers/usb/input/wacom.c	2004-10-20 09:38:11 -07:00
+++ edited/drivers/usb/input/wacom.c	2004-12-17 16:36:29 -08:00
@@ -692,9 +692,9 @@ static int wacom_probe(struct usb_interf
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
 
===== drivers/usb/input/xpad.c 1.33 vs edited =====
--- 1.33/drivers/usb/input/xpad.c	2004-10-20 09:38:11 -07:00
+++ edited/drivers/usb/input/xpad.c	2004-12-17 16:37:27 -08:00
@@ -226,8 +226,8 @@ static int xpad_probe(struct usb_interfa
 	int i;
 	
 	for (i = 0; xpad_device[i].idVendor; i++) {
-		if ((udev->descriptor.idVendor == xpad_device[i].idVendor) &&
-		    (udev->descriptor.idProduct == xpad_device[i].idProduct))
+		if ((le16_to_cpu(udev->descriptor.idVendor) == xpad_device[i].idVendor) &&
+		    (le16_to_cpu(udev->descriptor.idProduct) == xpad_device[i].idProduct))
 			break;
 	}
 	
@@ -264,9 +264,9 @@ static int xpad_probe(struct usb_interfa
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
===== drivers/usb/media/dabusb.c 1.64 vs edited =====
--- 1.64/drivers/usb/media/dabusb.c	2004-11-01 10:59:20 -08:00
+++ edited/drivers/usb/media/dabusb.c	2004-12-17 16:39:18 -08:00
@@ -724,13 +724,16 @@ static int dabusb_probe (struct usb_inte
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
 
 
@@ -746,7 +749,7 @@ static int dabusb_probe (struct usb_inte
 		err("reset_configuration failed");
 		goto reject;
 	}
-	if (usbdev->descriptor.idProduct == 0x2131) {
+	if (le16_to_cpu(usbdev->descriptor.idProduct) == 0x2131) {
 		dabusb_loadmem (s, NULL);
 		goto reject;
 	}
===== drivers/usb/media/ibmcam.c 1.29 vs edited =====
--- 1.29/drivers/usb/media/ibmcam.c	2004-08-24 07:55:42 -07:00
+++ edited/drivers/usb/media/ibmcam.c	2004-12-17 16:41:35 -08:00
@@ -3659,17 +3659,8 @@ static int ibmcam_probe(struct usb_inter
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
@@ -3678,8 +3669,8 @@ static int ibmcam_probe(struct usb_inter
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
@@ -3691,14 +3682,14 @@ static int ibmcam_probe(struct usb_inter
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
@@ -3714,7 +3705,7 @@ static int ibmcam_probe(struct usb_inter
 			break;
 		}
 		info("%s USB camera found (model %d, rev. 0x%04x)",
-		     brand, model, dev->descriptor.bcdDevice);
+		     brand, model, le16_to_cpu(dev->descriptor.bcdDevice));
 	} while (0);
 
 	/* Validate found interface: must have one ISO endpoint */
===== drivers/usb/media/konicawc.c 1.47 vs edited =====
--- 1.47/drivers/usb/media/konicawc.c	2004-10-20 09:38:11 -07:00
+++ edited/drivers/usb/media/konicawc.c	2004-12-17 16:48:45 -08:00
@@ -732,7 +732,7 @@ static int konicawc_probe(struct usb_int
 	if (dev->descriptor.bNumConfigurations != 1)
 		return -ENODEV;
 
-	info("Konica Webcam (rev. 0x%04x)", dev->descriptor.bcdDevice);
+	info("Konica Webcam (rev. 0x%04x)", le16_to_cpu(dev->descriptor.bcdDevice));
 	RESTRICT_TO_RANGE(speed, 0, MAX_SPEED);
 
 	/* Validate found interface: must have one ISO endpoint */
@@ -846,9 +846,9 @@ static int konicawc_probe(struct usb_int
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
===== drivers/usb/media/ov511.c 1.78 vs edited =====
--- 1.78/drivers/usb/media/ov511.c	2004-11-01 11:11:47 -08:00
+++ edited/drivers/usb/media/ov511.c	2004-12-17 16:43:13 -08:00
@@ -5825,7 +5825,7 @@ ov51x_probe(struct usb_interface *intf, 
 	ov->auto_gain = autogain;
 	ov->auto_exp = autoexp;
 
-	switch (dev->descriptor.idProduct) {
+	switch (le16_to_cpu(dev->descriptor.idProduct)) {
 	case PROD_OV511:
 		ov->bridge = BRG_OV511;
 		ov->bclass = BCL_OV511;
@@ -5843,13 +5843,13 @@ ov51x_probe(struct usb_interface *intf, 
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
 
===== drivers/usb/media/se401.c 1.65 vs edited =====
--- 1.65/drivers/usb/media/se401.c	2004-11-01 11:11:47 -08:00
+++ edited/drivers/usb/media/se401.c	2004-12-17 16:44:30 -08:00
@@ -1315,20 +1315,20 @@ static int se401_probe(struct usb_interf
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
@@ -1354,7 +1354,7 @@ static int se401_probe(struct usb_interf
         se401->iface = interface->bInterfaceNumber;
         se401->camera_name = camera_name;
 
-	info("firmware version: %02x", dev->descriptor.bcdDevice & 255);
+	info("firmware version: %02x", le16_to_cpu(dev->descriptor.bcdDevice) & 255);
 
         if (se401_init(se401, button)) {
 		kfree(se401);
===== drivers/usb/media/sn9c102_core.c 1.14 vs edited =====
--- 1.14/drivers/usb/media/sn9c102_core.c	2004-12-05 15:06:37 -08:00
+++ edited/drivers/usb/media/sn9c102_core.c	2004-12-17 16:45:11 -08:00
@@ -2496,8 +2496,8 @@ sn9c102_usb_probe(struct usb_interface* 
 
 	n = sizeof(sn9c102_id_table)/sizeof(sn9c102_id_table[0]);
 	for (i = 0; i < n-1; i++)
-		if (udev->descriptor.idVendor==sn9c102_id_table[i].idVendor &&
-		    udev->descriptor.idProduct==sn9c102_id_table[i].idProduct)
+		if (le16_to_cpu(udev->descriptor.idVendor) == sn9c102_id_table[i].idVendor &&
+		    le16_to_cpu(udev->descriptor.idProduct) == sn9c102_id_table[i].idProduct)
 			break;
 	if (i == n-1)
 		return -ENODEV;
===== drivers/usb/media/sn9c102_tas5110c1b.c 1.11 vs edited =====
--- 1.11/drivers/usb/media/sn9c102_tas5110c1b.c	2004-12-05 15:07:14 -08:00
+++ edited/drivers/usb/media/sn9c102_tas5110c1b.c	2004-12-17 16:46:21 -08:00
@@ -165,9 +165,9 @@ int sn9c102_probe_tas5110c1b(struct sn9c
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
===== drivers/usb/media/sn9c102_tas5130d1b.c 1.11 vs edited =====
--- 1.11/drivers/usb/media/sn9c102_tas5130d1b.c	2004-12-05 15:07:14 -08:00
+++ edited/drivers/usb/media/sn9c102_tas5130d1b.c	2004-12-17 16:45:48 -08:00
@@ -180,8 +180,8 @@ int sn9c102_probe_tas5130d1b(struct sn9c
 	sn9c102_attach_sensor(cam, &tas5130d1b);
 
 	/* Sensor detection is based on USB pid/vid */
-	if (tas5130d1b.usbdev->descriptor.idProduct != 0x6025 &&
-	    tas5130d1b.usbdev->descriptor.idProduct != 0x60aa)
+	if (le16_to_cpu(tas5130d1b.usbdev->descriptor.idProduct) != 0x6025 &&
+	    le16_to_cpu(tas5130d1b.usbdev->descriptor.idProduct) != 0x60aa)
 		return -ENODEV;
 
 	return 0;
===== drivers/usb/media/stv680.c 1.66 vs edited =====
--- 1.66/drivers/usb/media/stv680.c	2004-11-05 10:06:32 -08:00
+++ edited/drivers/usb/media/stv680.c	2004-12-17 16:46:56 -08:00
@@ -1371,7 +1371,8 @@ static int stv680_probe (struct usb_inte
 
 	interface = &intf->altsetting[0];
 	/* Is it a STV680? */
-	if ((dev->descriptor.idVendor == USB_PENCAM_VENDOR_ID) && (dev->descriptor.idProduct == USB_PENCAM_PRODUCT_ID)) {
+	if ((le16_to_cpu(dev->descriptor.idVendor) == USB_PENCAM_VENDOR_ID) &&
+	    (le16_to_cpu(dev->descriptor.idProduct) == USB_PENCAM_PRODUCT_ID)) {
 		camera_name = "STV0680";
 		PDEBUG (0, "STV(i): STV0680 camera found.");
 	} else {
===== drivers/usb/media/ultracam.c 1.25 vs edited =====
--- 1.25/drivers/usb/media/ultracam.c	2004-08-24 07:55:44 -07:00
+++ edited/drivers/usb/media/ultracam.c	2004-12-17 16:42:19 -08:00
@@ -524,12 +524,8 @@ static int ultracam_probe(struct usb_int
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
===== drivers/usb/media/vicam.c 1.71 vs edited =====
--- 1.71/drivers/usb/media/vicam.c	2004-11-01 11:11:48 -08:00
+++ edited/drivers/usb/media/vicam.c	2004-12-17 16:47:20 -08:00
@@ -1281,12 +1281,6 @@ vicam_probe( struct usb_interface *intf,
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
===== drivers/usb/media/w9968cf.c 1.17 vs edited =====
--- 1.17/drivers/usb/media/w9968cf.c	2004-11-01 11:11:48 -08:00
+++ edited/drivers/usb/media/w9968cf.c	2004-12-17 16:47:54 -08:00
@@ -3516,11 +3516,11 @@ w9968cf_usb_probe(struct usb_interface* 
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
===== drivers/usb/misc/auerswald.c 1.75 vs edited =====
--- 1.75/drivers/usb/misc/auerswald.c	2004-11-27 15:14:57 -08:00
+++ edited/drivers/usb/misc/auerswald.c	2004-12-20 10:55:44 -08:00
@@ -1931,11 +1931,8 @@ static int auerswald_probe (struct usb_i
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
@@ -1969,7 +1966,7 @@ static int auerswald_probe (struct usb_i
 	cp->dtindex = intf->minor;
 
 	/* Get the usb version of the device */
-	cp->version = cp->usbdev->descriptor.bcdDevice;
+	cp->version = le16_to_cpu(cp->usbdev->descriptor.bcdDevice);
 	dbg ("Version is %X", cp->version);
 
 	/* allow some time to settle the device */
===== drivers/usb/misc/emi26.c 1.19 vs edited =====
--- 1.19/drivers/usb/misc/emi26.c	2004-05-30 08:02:06 -07:00
+++ edited/drivers/usb/misc/emi26.c	2004-12-17 16:13:41 -08:00
@@ -213,11 +213,9 @@ static int emi26_probe(struct usb_interf
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
===== drivers/usb/misc/emi62.c 1.4 vs edited =====
--- 1.4/drivers/usb/misc/emi62.c	2004-05-30 08:02:06 -07:00
+++ edited/drivers/usb/misc/emi62.c	2004-12-17 16:13:41 -08:00
@@ -255,10 +255,8 @@ static int emi62_probe(struct usb_interf
 
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
===== drivers/usb/misc/legousbtower.c 1.15 vs edited =====
--- 1.15/drivers/usb/misc/legousbtower.c	2004-10-20 09:38:12 -07:00
+++ edited/drivers/usb/misc/legousbtower.c	2004-12-17 16:13:41 -08:00
@@ -859,13 +859,6 @@ static int tower_probe (struct usb_inter
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
===== drivers/usb/misc/usblcd.c 1.21 vs edited =====
--- 1.21/drivers/usb/misc/usblcd.c	2003-09-03 08:47:19 -07:00
+++ edited/drivers/usb/misc/usblcd.c	2004-12-17 16:13:41 -08:00
@@ -74,7 +74,7 @@ ioctl_lcd(struct inode *inode, struct fi
 	  unsigned long arg)
 {
 	struct lcd_usb_data *lcd = &lcd_instance;
-	int i;
+	u16 bcdDevice;
 	char buf[30];
 
 	/* Sanity check to make sure lcd is connected, powered, etc */
@@ -85,9 +85,12 @@ ioctl_lcd(struct inode *inode, struct fi
 
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
@@ -258,7 +261,7 @@ static int probe_lcd(struct usb_interfac
 	int i;
 	int retval;
 
-	if (dev->descriptor.idProduct != 0x0001  ) {
+	if (le16_to_cpu(dev->descriptor.idProduct) != 0x0001) {
 		warn(KERN_INFO "USBLCD model not supported.");
 		return -ENODEV;
 	}
@@ -268,7 +271,7 @@ static int probe_lcd(struct usb_interfac
 		return -ENODEV;
 	}
 
-	i = dev->descriptor.bcdDevice;
+	i = le16_to_cpu(dev->descriptor.bcdDevice);
 
 	info("USBLCD Version %1d%1d.%1d%1d found at address %d",
 		(i & 0xF000)>>12,(i & 0xF00)>>8,(i & 0xF0)>>4,(i & 0xF),
===== drivers/usb/misc/usbtest.c 1.60 vs edited =====
--- 1.60/drivers/usb/misc/usbtest.c	2004-11-27 15:14:58 -08:00
+++ edited/drivers/usb/misc/usbtest.c	2004-12-17 16:17:06 -08:00
@@ -636,7 +636,7 @@ static int ch9_postconfig (struct usbtes
 	}
 
 	/* and sometimes [9.2.6.6] speed dependent descriptors */
-	if (udev->descriptor.bcdUSB == 0x0200) {	/* pre-swapped */
+	if (le16_to_cpu(udev->descriptor.bcdUSB) == 0x0200) {
 		struct usb_qualifier_descriptor		*d = NULL;
 
 		/* device qualifier [9.6.2] */
@@ -1842,13 +1842,13 @@ usbtest_probe (struct usb_interface *int
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
 
===== drivers/usb/misc/uss720.c 1.26 vs edited =====
--- 1.26/drivers/usb/misc/uss720.c	2004-10-20 09:38:12 -07:00
+++ edited/drivers/usb/misc/uss720.c	2004-12-17 16:13:41 -08:00
@@ -544,7 +544,8 @@ static int uss720_probe(struct usb_inter
 	int i;
 
 	printk(KERN_DEBUG "uss720: probe: vendor id 0x%x, device id 0x%x\n",
-	       usbdev->descriptor.idVendor, usbdev->descriptor.idProduct);
+	       le16_to_cpu(usbdev->descriptor.idVendor),
+	       le16_to_cpu(usbdev->descriptor.idProduct));
 
 	/* our known interfaces have 3 alternate settings */
 	if (intf->num_altsetting != 3)
===== drivers/usb/net/catc.c 1.58 vs edited =====
--- 1.58/drivers/usb/net/catc.c	2004-11-05 10:06:32 -08:00
+++ edited/drivers/usb/net/catc.c	2004-12-17 16:52:30 -08:00
@@ -800,8 +800,9 @@ static int catc_probe(struct usb_interfa
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
===== drivers/usb/net/kaweth.c 1.103 vs edited =====
--- 1.103/drivers/usb/net/kaweth.c	2004-11-01 10:59:20 -08:00
+++ edited/drivers/usb/net/kaweth.c	2004-12-20 10:56:20 -08:00
@@ -903,9 +903,9 @@ static int kaweth_probe(
 
 	kaweth_dbg("Kawasaki Device Probe (Device number:%d): 0x%4.4x:0x%4.4x:0x%4.4x",
 		 dev->devnum,
-		 (int)dev->descriptor.idVendor,
-		 (int)dev->descriptor.idProduct,
-		 (int)dev->descriptor.bcdDevice);
+		 le16_to_cpu(dev->descriptor.idVendor),
+		 le16_to_cpu(dev->descriptor.idProduct),
+		 le16_to_cpu(dev->descriptor.bcdDevice));
 
 	kaweth_dbg("Device at %p", dev);
 
@@ -933,7 +933,7 @@ static int kaweth_probe(
 	 * downloaded. Don't try to do it again, or we'll hang the device.
 	 */
 
-	if (dev->descriptor.bcdDevice >> 8) {
+	if (le16_to_cpu(dev->descriptor.bcdDevice) >> 8) {
 		kaweth_info("Firmware present in device.");
 	} else {
 		/* Download the firmware */
===== drivers/usb/serial/belkin_sa.c 1.66 vs edited =====
--- 1.66/drivers/usb/serial/belkin_sa.c	2004-11-01 10:59:20 -08:00
+++ edited/drivers/usb/serial/belkin_sa.c	2004-12-17 16:13:41 -08:00
@@ -181,8 +181,8 @@ static int belkin_sa_startup (struct usb
 	priv->last_lsr = 0;
 	priv->last_msr = 0;
 	/* see comments at top of file */
-	priv->bad_flow_control = (dev->descriptor.bcdDevice <= 0x0206) ? 1 : 0;
-	info("bcdDevice: %04x, bfc: %d", dev->descriptor.bcdDevice, priv->bad_flow_control);
+	priv->bad_flow_control = (le16_to_cpu(dev->descriptor.bcdDevice) <= 0x0206) ? 1 : 0;
+	info("bcdDevice: %04x, bfc: %d", le16_to_cpu(dev->descriptor.bcdDevice), priv->bad_flow_control);
 
 	init_waitqueue_head(&serial->port[0]->write_wait);
 	usb_set_serial_port_data(serial->port[0], priv);
===== drivers/usb/serial/io_edgeport.c 1.86 vs edited =====
--- 1.86/drivers/usb/serial/io_edgeport.c	2004-12-01 09:39:03 -08:00
+++ edited/drivers/usb/serial/io_edgeport.c	2004-12-17 16:13:41 -08:00
@@ -659,7 +659,7 @@ static void get_product_info(struct edge
 
 	memset (product_info, 0, sizeof(struct edgeport_product_info));
 
-	product_info->ProductId		= (__u16)(edge_serial->serial->dev->descriptor.idProduct & ~ION_DEVICE_ID_80251_NETCHIP);
+	product_info->ProductId		= (__u16)(le16_to_cpu(edge_serial->serial->dev->descriptor.idProduct) & ~ION_DEVICE_ID_80251_NETCHIP);
 	product_info->NumPorts		= edge_serial->manuf_descriptor.NumPorts;
 	product_info->ProdInfoVer	= 0;
 
@@ -675,7 +675,7 @@ static void get_product_info(struct edge
 	memcpy(product_info->ManufactureDescDate, edge_serial->manuf_descriptor.DescDate, sizeof(edge_serial->manuf_descriptor.DescDate));
 
 	// check if this is 2nd generation hardware
-	if (edge_serial->serial->dev->descriptor.idProduct & ION_DEVICE_ID_80251_NETCHIP) {
+	if (le16_to_cpu(edge_serial->serial->dev->descriptor.idProduct) & ION_DEVICE_ID_80251_NETCHIP) {
 		product_info->FirmwareMajorVersion	= OperationalCodeImageVersion_GEN2.MajorVersion;
 		product_info->FirmwareMinorVersion	= OperationalCodeImageVersion_GEN2.MinorVersion;
 		product_info->FirmwareBuildNumber	= cpu_to_le16(OperationalCodeImageVersion_GEN2.BuildNumber);
===== drivers/usb/serial/io_ti.c 1.65 vs edited =====
--- 1.65/drivers/usb/serial/io_ti.c	2004-11-15 09:27:17 -08:00
+++ edited/drivers/usb/serial/io_ti.c	2004-12-17 16:13:41 -08:00
@@ -1342,9 +1342,9 @@ static int TIDownloadFirmware (struct ed
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
===== drivers/usb/serial/keyspan.c 1.73 vs edited =====
--- 1.73/drivers/usb/serial/keyspan.c	2004-10-22 09:32:03 -07:00
+++ edited/drivers/usb/serial/keyspan.c	2004-12-17 17:19:01 -08:00
@@ -1174,16 +1174,16 @@ static int keyspan_fake_startup (struct 
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
@@ -2248,10 +2248,10 @@ static int keyspan_startup (struct usb_s
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
 
===== drivers/usb/serial/keyspan_pda.c 1.60 vs edited =====
--- 1.60/drivers/usb/serial/keyspan_pda.c	2004-10-22 09:32:04 -07:00
+++ edited/drivers/usb/serial/keyspan_pda.c	2004-12-17 16:13:42 -08:00
@@ -713,12 +713,12 @@ static int keyspan_pda_fake_startup (str
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
===== drivers/usb/serial/kobil_sct.c 1.42 vs edited =====
--- 1.42/drivers/usb/serial/kobil_sct.c	2004-10-22 09:32:05 -07:00
+++ edited/drivers/usb/serial/kobil_sct.c	2004-12-17 16:13:42 -08:00
@@ -155,7 +155,7 @@ static int kobil_startup (struct usb_ser
 
 	priv->filled = 0;
 	priv->cur_pos = 0;
-	priv->device_type = serial->product;
+	priv->device_type = le16_to_cpu(serial->dev->descriptor.idProduct);
 	priv->line_state = 0;
 
 	switch (priv->device_type){
===== drivers/usb/serial/mct_u232.c 1.66 vs edited =====
--- 1.66/drivers/usb/serial/mct_u232.c	2004-11-27 15:49:19 -08:00
+++ edited/drivers/usb/serial/mct_u232.c	2004-12-17 16:13:42 -08:00
@@ -173,9 +173,10 @@ struct mct_u232_private {
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
@@ -403,7 +404,7 @@ static int  mct_u232_open (struct usb_se
 	 * it seems to be able to accept only 16 bytes (and that's what
 	 * SniffUSB says too...)
 	 */
-	if (serial->dev->descriptor.idProduct == MCT_U232_SITECOM_PID)
+	if (le16_to_cpu(serial->dev->descriptor.idProduct) == MCT_U232_SITECOM_PID)
 		port->bulk_out_size = 16;
 
 	/* Do a defined restart: the normal serial device seems to 
===== drivers/usb/serial/ti_usb_3410_5052.c 1.2 vs edited =====
--- 1.2/drivers/usb/serial/ti_usb_3410_5052.c	2004-12-15 14:10:31 -08:00
+++ edited/drivers/usb/serial/ti_usb_3410_5052.c	2004-12-17 16:13:42 -08:00
@@ -407,7 +407,10 @@ static int ti_startup(struct usb_serial 
 	int i;
 
 
-	dbg("%s - product 0x%4X, num configurations %d, configuration value %d", __FUNCTION__, dev->descriptor.idProduct, dev->descriptor.bNumConfigurations, dev->actconfig->desc.bConfigurationValue);
+	dbg("%s - product 0x%4X, num configurations %d, configuration value %d",
+	    __FUNCTION__, le16_to_cpu(dev->descriptor.idProduct),
+	    dev->descriptor.bNumConfigurations,
+	    dev->actconfig->desc.bConfigurationValue);
 
 	/* create device structure */
 	tdev = kmalloc(sizeof(struct ti_device), GFP_KERNEL);
===== drivers/usb/serial/usb-serial.c 1.167 vs edited =====
--- 1.167/drivers/usb/serial/usb-serial.c	2004-11-30 18:23:16 -08:00
+++ edited/drivers/usb/serial/usb-serial.c	2004-12-17 16:13:42 -08:00
@@ -721,7 +721,9 @@ static int serial_read_proc (char *page,
 		if (serial->type->owner)
 			length += sprintf (page+length, " module:%s", module_name(serial->type->owner));
 		length += sprintf (page+length, " name:\"%s\"", serial->type->name);
-		length += sprintf (page+length, " vendor:%04x product:%04x", serial->vendor, serial->product);
+		length += sprintf (page+length, " vendor:%04x product:%04x", 
+				   le16_to_cpu(serial->dev->descriptor.idVendor), 
+				   le16_to_cpu(serial->dev->descriptor.idProduct));
 		length += sprintf (page+length, " num_ports:%d", serial->num_ports);
 		length += sprintf (page+length, " port:%d", i - serial->minor + 1);
 
@@ -834,8 +836,6 @@ static struct usb_serial * create_serial
 	serial->dev = usb_get_dev(dev);
 	serial->type = type;
 	serial->interface = interface;
-	serial->vendor = dev->descriptor.idVendor;
-	serial->product = dev->descriptor.idProduct;
 	kref_init(&serial->kref);
 
 	return serial;
@@ -959,10 +959,10 @@ int usb_serial_probe(struct usb_interfac
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
===== drivers/usb/serial/usb-serial.h 1.63 vs edited =====
--- 1.63/drivers/usb/serial/usb-serial.h	2004-11-05 10:06:32 -08:00
+++ edited/drivers/usb/serial/usb-serial.h	2004-12-17 16:13:42 -08:00
@@ -148,8 +148,6 @@ static inline void usb_set_serial_port_d
  * @num_interrupt_out: number of interrupt out endpoints we have
  * @num_bulk_in: number of bulk in endpoints we have
  * @num_bulk_out: number of bulk out endpoints we have
- * @vendor: vendor id of this device
- * @product: product id of this device
  * @port: array of struct usb_serial_port structures for the different ports.
  * @private: place to put any driver specific information that is needed.  The
  *	usb-serial driver is required to manage this data, the usb-serial core
@@ -167,8 +165,6 @@ struct usb_serial {
 	char				num_interrupt_out;
 	char				num_bulk_in;
 	char				num_bulk_out;
-	__u16				vendor;
-	__u16				product;
 	struct usb_serial_port *	port[MAX_NUM_PORTS];
 	struct kref			kref;
 	void *				private;
===== drivers/usb/serial/visor.c 1.127 vs edited =====
--- 1.127/drivers/usb/serial/visor.c	2004-12-01 09:39:04 -08:00
+++ edited/drivers/usb/serial/visor.c	2004-12-17 16:13:42 -08:00
@@ -926,8 +926,8 @@ static int treo_attach (struct usb_seria
 
 	/* Only do this endpoint hack for the Handspring devices with
 	 * interrupt in endpoints, which for now are the Treo devices. */
-	if (!((serial->dev->descriptor.idVendor == HANDSPRING_VENDOR_ID) ||
-	      (serial->dev->descriptor.idVendor == KYOCERA_VENDOR_ID)) ||
+	if (!((le16_to_cpu(serial->dev->descriptor.idVendor) == HANDSPRING_VENDOR_ID) ||
+	      (le16_to_cpu(serial->dev->descriptor.idVendor) == KYOCERA_VENDOR_ID)) ||
 	    (serial->num_interrupt_in == 0))
 		goto generic_startup;
 
===== drivers/usb/storage/scsiglue.c 1.90 vs edited =====
--- 1.90/drivers/usb/storage/scsiglue.c	2004-11-22 10:42:02 -08:00
+++ edited/drivers/usb/storage/scsiglue.c	2004-12-17 16:13:42 -08:00
@@ -118,7 +118,7 @@ static int slave_configure(struct scsi_d
 	 * works okay and that's what Windows does.  But we'll be
 	 * conservative; people can always use the sysfs interface to
 	 * increase max_sectors. */
-	if (us->pusb_dev->descriptor.idVendor == USB_VENDOR_ID_GENESYS &&
+	if (le16_to_cpu(us->pusb_dev->descriptor.idVendor) == USB_VENDOR_ID_GENESYS &&
 			sdev->request_queue->max_sectors > 64)
 		blk_queue_max_sectors(sdev->request_queue, 64);
 
===== drivers/usb/storage/transport.c 1.155 vs edited =====
--- 1.155/drivers/usb/storage/transport.c	2004-12-15 13:25:40 -08:00
+++ edited/drivers/usb/storage/transport.c	2004-12-17 16:13:42 -08:00
@@ -994,7 +994,7 @@ int usb_stor_Bulk_transport(struct scsi_
 	/* Genesys Logic interface chips need a 100us delay between the
 	 * command phase and the data phase.  Some devices need a little
 	 * more than that, probably because of clock rate inaccuracies. */
-	if (us->pusb_dev->descriptor.idVendor == USB_VENDOR_ID_GENESYS)
+	if (le16_to_cpu(us->pusb_dev->descriptor.idVendor) == USB_VENDOR_ID_GENESYS)
 		udelay(110);
 
 	if (transfer_length) {
===== drivers/usb/storage/usb.c 1.130 vs edited =====
--- 1.130/drivers/usb/storage/usb.c	2004-11-22 10:42:02 -08:00
+++ edited/drivers/usb/storage/usb.c	2004-12-20 10:56:59 -08:00
@@ -263,16 +263,17 @@ void fill_inquiry_response(struct us_dat
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
@@ -436,9 +437,9 @@ static int associate_dev(struct us_data 
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
@@ -507,8 +508,9 @@ static void get_device_info(struct us_da
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
===== include/linux/usb_ch9.h 1.8 vs edited =====
--- 1.8/include/linux/usb_ch9.h	2004-10-11 10:52:12 -07:00
+++ edited/include/linux/usb_ch9.h	2004-12-20 11:15:49 -08:00
@@ -156,14 +156,14 @@ struct usb_device_descriptor {
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
@@ -297,7 +297,7 @@ struct usb_qualifier_descriptor {
 	__u8  bLength;
 	__u8  bDescriptorType;
 
-	__u16 bcdUSB;
+	__le16 bcdUSB;
 	__u8  bDeviceClass;
 	__u8  bDeviceSubClass;
 	__u8  bDeviceProtocol;
===== sound/usb/usbaudio.c 1.38 vs edited =====
--- 1.38/sound/usb/usbaudio.c	2004-11-01 10:59:24 -08:00
+++ edited/sound/usb/usbaudio.c	2004-12-20 10:11:59 -08:00
@@ -2176,13 +2176,13 @@ static int add_audio_endpoint(snd_usb_au
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
@@ -2246,7 +2246,8 @@ static int parse_audio_format_i_type(str
 		break;
 	case USB_AUDIO_FORMAT_PCM8:
 		/* Dallas DS4201 workaround */
-		if (dev->descriptor.idVendor == 0x04fa && dev->descriptor.idProduct == 0x4201)
+		if (le16_to_cpu(dev->descriptor.idVendor) == 0x04fa &&
+		    le16_to_cpu(dev->descriptor.idProduct) == 0x4201)
 			pcm_format = SNDRV_PCM_FORMAT_S8;
 		else
 			pcm_format = SNDRV_PCM_FORMAT_U8;
@@ -2414,7 +2415,8 @@ static int parse_audio_format(struct usb
 	/* extigy apparently supports sample rates other than 48k
 	 * but not in ordinary way.  so we enable only 48k atm.
 	 */
-	if (dev->descriptor.idVendor == 0x041e && dev->descriptor.idProduct == 0x3000) {
+	if (le16_to_cpu(dev->descriptor.idVendor) == 0x041e && 
+	    le16_to_cpu(dev->descriptor.idProduct) == 0x3000) {
 		if (fmt[3] == USB_FORMAT_TYPE_I &&
 		    stream == SNDRV_PCM_STREAM_PLAYBACK &&
 		    fp->rates != SNDRV_PCM_RATE_48000)
@@ -2517,8 +2519,8 @@ static int parse_audio_endpoints(snd_usb
 		/* some quirks for attributes here */
 
 		/* workaround for AudioTrak Optoplay */
-		if (dev->descriptor.idVendor == 0x0a92 &&
-		    dev->descriptor.idProduct == 0x0053) {
+		if (le16_to_cpu(dev->descriptor.idVendor) == 0x0a92 &&
+		    le16_to_cpu(dev->descriptor.idProduct) == 0x0053) {
 			/* Optoplay sets the sample rate attribute although
 			 * it seems not supporting it in fact.
 			 */
@@ -2526,8 +2528,8 @@ static int parse_audio_endpoints(snd_usb
 		}
 
 		/* workaround for M-Audio Audiophile USB */
-		if (dev->descriptor.idVendor == 0x0763 &&
-		    dev->descriptor.idProduct == 0x2003) {
+		if (le16_to_cpu(dev->descriptor.idVendor) == 0x0763 &&
+		    le16_to_cpu(dev->descriptor.idProduct) == 0x2003) {
 			/* doesn't set the sample rate attribute, but supports it */
 			fp->attributes |= EP_CS_ATTR_SAMPLE_RATE;
 		}
@@ -2536,11 +2538,11 @@ static int parse_audio_endpoints(snd_usb
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
@@ -2788,7 +2790,7 @@ static int create_ua700_ua25_quirk(snd_u
 			.type = QUIRK_MIDI_FIXED_ENDPOINT,
 			.data = &ua25_ep
 		};
-		if (chip->dev->descriptor.idProduct == 0x002b)
+		if (le16_to_cpu(chip->dev->descriptor.idProduct) == 0x002b)
 			return snd_usb_create_midi_interface(chip, iface,
 							     &ua700_quirk);
 		else
@@ -3000,7 +3002,9 @@ static void proc_audio_usbid_read(snd_in
 {
 	snd_usb_audio_t *chip = entry->private_data;
 	if (! chip->shutdown)
-		snd_iprintf(buffer, "%04x:%04x\n", chip->dev->descriptor.idVendor, chip->dev->descriptor.idProduct);
+		snd_iprintf(buffer, "%04x:%04x\n", 
+			    le16_to_cpu(chip->dev->descriptor.idVendor),
+			    le16_to_cpu(chip->dev->descriptor.idProduct));
 }
 
 static void snd_usb_audio_create_proc(snd_usb_audio_t *chip)
@@ -3081,7 +3085,8 @@ static int snd_usb_audio_create(struct u
 
 	strcpy(card->driver, "USB-Audio");
 	sprintf(component, "USB%04x:%04x",
-		dev->descriptor.idVendor, dev->descriptor.idProduct);
+		le16_to_cpu(dev->descriptor.idVendor),
+		le16_to_cpu(dev->descriptor.idProduct));
 	snd_component_add(card, component);
 
 	/* retrieve the device string as shortname */
@@ -3093,7 +3098,8 @@ static int snd_usb_audio_create(struct u
       			       card->shortname, sizeof(card->shortname)) <= 0) {
 			/* no name available from anywhere, so use ID */
 			sprintf(card->shortname, "USB Device %#04x:%#04x",
-				dev->descriptor.idVendor, dev->descriptor.idProduct);
+				le16_to_cpu(dev->descriptor.idVendor),
+				le16_to_cpu(dev->descriptor.idProduct));
 		}
 	}
 
@@ -3160,7 +3166,8 @@ static void *snd_usb_audio_probe(struct 
 
 	/* SB Extigy needs special boot-up sequence */
 	/* if more models come, this will go to the quirk list. */
-	if (dev->descriptor.idVendor == 0x041e && dev->descriptor.idProduct == 0x3000) {
+	if (le16_to_cpu(dev->descriptor.idVendor) == 0x041e && 
+	    le16_to_cpu(dev->descriptor.idProduct) == 0x3000) {
 		if (snd_usb_extigy_boot_quirk(dev, intf) < 0)
 			goto __err_val;
 		config = dev->actconfig;
@@ -3194,8 +3201,8 @@ static void *snd_usb_audio_probe(struct 
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
===== sound/usb/usbmidi.c 1.21 vs edited =====
--- 1.21/sound/usb/usbmidi.c	2004-11-01 10:59:25 -08:00
+++ edited/sound/usb/usbmidi.c	2004-12-20 10:13:39 -08:00
@@ -521,7 +521,7 @@ static struct usb_endpoint_descriptor* s
 	struct usb_host_interface *hostif;
 	struct usb_interface_descriptor* intfd;
 
-	if (umidi->chip->dev->descriptor.idVendor != 0x0582)
+	if (le16_to_cpu(umidi->chip->dev->descriptor.idVendor) != 0x0582)
 		return NULL;
 	intf = umidi->iface;
 	if (!intf || intf->num_altsetting != 2)
@@ -839,8 +839,8 @@ static void snd_usbmidi_init_substream(s
 
 	/* TODO: read port name from jack descriptor */
 	name_format = "%s MIDI %d";
-	vendor = umidi->chip->dev->descriptor.idVendor;
-	product = umidi->chip->dev->descriptor.idProduct;
+	vendor = le16_to_cpu(umidi->chip->dev->descriptor.idVendor);
+	product = le16_to_cpu(umidi->chip->dev->descriptor.idProduct);
 	for (i = 0; i < ARRAY_SIZE(snd_usbmidi_port_names); ++i) {
 		if (snd_usbmidi_port_names[i].vendor == vendor &&
 		    snd_usbmidi_port_names[i].product == product &&
===== sound/usb/usbmixer.c 1.17 vs edited =====
--- 1.17/sound/usb/usbmixer.c	2004-09-13 09:46:54 -07:00
+++ edited/sound/usb/usbmixer.c	2004-12-20 10:12:50 -08:00
@@ -1490,12 +1490,12 @@ int snd_usb_create_mixer(snd_usb_audio_t
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
===== sound/usb/usx2y/usX2Yhwdep.c 1.1 vs edited =====
--- 1.1/sound/usb/usx2y/usX2Yhwdep.c	2004-09-13 09:05:51 -07:00
+++ edited/sound/usb/usx2y/usX2Yhwdep.c	2004-12-20 10:16:21 -08:00
@@ -133,7 +133,7 @@ static int snd_usX2Y_hwdep_dsp_status(sn
 	};
 	int id = -1;
 
-	switch (((usX2Ydev_t*)hw->private_data)->chip.dev->descriptor.idProduct) {
+	switch (le16_to_cpu(((usX2Ydev_t*)hw->private_data)->chip.dev->descriptor.idProduct)) {
 	case USB_ID_US122:
 		id = USX2Y_TYPE_122;
 		break;
@@ -185,7 +185,7 @@ static int usX2Y_create_usbmidi(snd_card
 	};
 	struct usb_device *dev = usX2Y(card)->chip.dev;
 	struct usb_interface *iface = usb_ifnum_to_if(dev, 0);
-	snd_usb_audio_quirk_t *quirk = dev->descriptor.idProduct == USB_ID_US428 ? &quirk_2 : &quirk_1;
+	snd_usb_audio_quirk_t *quirk = le16_to_cpu(dev->descriptor.idProduct) == USB_ID_US428 ? &quirk_2 : &quirk_1;
 
 	snd_printdd("usX2Y_create_usbmidi \n");
 	return snd_usb_create_midi_interface(&usX2Y(card)->chip, iface, quirk);
===== sound/usb/usx2y/usbusx2y.c 1.3 vs edited =====
--- 1.3/sound/usb/usx2y/usbusx2y.c	2004-11-01 10:38:11 -08:00
+++ edited/sound/usb/usx2y/usbusx2y.c	2004-12-20 10:14:58 -08:00
@@ -331,7 +331,8 @@ static snd_card_t* usX2Y_create_card(str
 	sprintf(card->shortname, "TASCAM "NAME_ALLCAPS"");
 	sprintf(card->longname, "%s (%x:%x if %d at %03d/%03d)",
 		card->shortname, 
-		device->descriptor.idVendor, device->descriptor.idProduct,
+		le16_to_cpu(device->descriptor.idVendor),
+		le16_to_cpu(device->descriptor.idProduct),
 		0,//us428(card)->usbmidi.ifnum,
 		usX2Y(card)->chip.dev->bus->busnum, usX2Y(card)->chip.dev->devnum
 		);
@@ -344,10 +345,10 @@ static void* usX2Y_usb_probe(struct usb_
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
===== sound/usb/usx2y/usbusx2yaudio.c 1.3 vs edited =====
--- 1.3/sound/usb/usx2y/usbusx2yaudio.c	2004-11-27 15:14:58 -08:00
+++ edited/sound/usb/usx2y/usbusx2yaudio.c	2004-12-20 10:15:33 -08:00
@@ -1023,10 +1023,10 @@ int usX2Y_audio_create(snd_card_t* card)
 
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

