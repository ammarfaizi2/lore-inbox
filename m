Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264773AbTBTXSh>; Thu, 20 Feb 2003 18:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264777AbTBTXSh>; Thu, 20 Feb 2003 18:18:37 -0500
Received: from jsl.com ([66.92.44.10]:57740 "EHLO jsl.com")
	by vger.kernel.org with ESMTP id <S264773AbTBTXSc>;
	Thu, 20 Feb 2003 18:18:32 -0500
From: System Administrator <root@jsl.com>
Message-Id: <200302202328.h1KNSaj26209@jsl.com>
Subject: Keyspan USB/Serial Drivers for 2.4.20/2.4.21-pre4
To: linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2003 15:28:35 -0800 (PST)
Reply-To: kernel1@jsl.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

 I'm not sure why, but the current kernel source tree doesn't support some
of the Keyspan USB/Serial adapter products (49WLC and MPR).  There is code
at: http://www.keyspan.com/support/linux/files/currentversion/rev2003jan31/
but it only works with 2.4.18 or 2.4.19.  Keyspan seems to think the code
is current and they didn't want my patches.  Here they are for posterity.

Note: I did not include the firmware header files in the patch.  They can
be obtained at the URL above.

Best regards,

Jeffrey S. Laing
kernel1@jsl.com

--- linux-2.4.21-pre4.orig/drivers/usb/serial/Config.in	Thu Feb 20 14:27:33 2003
+++ linux/drivers/usb/serial/Config.in	Tue Feb 18 18:02:28 2003
@@ -6,36 +6,37 @@
 
 dep_tristate 'USB Serial Converter support' CONFIG_USB_SERIAL $CONFIG_USB
 if [ "$CONFIG_USB_SERIAL" != "n" ]; then
-   dep_bool '  USB Serial Converter verbose debug' CONFIG_USB_SERIAL_DEBUG $CONFIG_USB_SERIAL
+   dep_mbool '  USB Serial Converter verbose debug' CONFIG_USB_SERIAL_DEBUG $CONFIG_USB_SERIAL
    dep_mbool '  USB Generic Serial Driver' CONFIG_USB_SERIAL_GENERIC $CONFIG_USB_SERIAL
-   dep_tristate '  USB Belkin and Peracom Single Port Serial Driver' CONFIG_USB_SERIAL_BELKIN $CONFIG_USB_SERIAL
-   dep_tristate '  USB ConnectTech WhiteHEAT Serial Driver' CONFIG_USB_SERIAL_WHITEHEAT $CONFIG_USB_SERIAL
+   dep_tristate '  USB Belkin and Peracom Single Port Serial Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_BELKIN $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
+   dep_tristate '  USB ConnectTech WhiteHEAT Serial Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_WHITEHEAT $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
    dep_tristate '  USB Digi International AccelePort USB Serial Driver' CONFIG_USB_SERIAL_DIGI_ACCELEPORT $CONFIG_USB_SERIAL
-   dep_tristate '  USB Empeg empeg-car Mark I/II Driver' CONFIG_USB_SERIAL_EMPEG $CONFIG_USB_SERIAL
-   dep_tristate '  USB FTDI Single Port Serial Driver' CONFIG_USB_SERIAL_FTDI_SIO $CONFIG_USB_SERIAL
+   dep_tristate '  USB Empeg empeg-car Mark I/II Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_EMPEG $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
+   dep_tristate '  USB FTDI Single Port Serial Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_FTDI_SIO $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
    dep_tristate '  USB Handspring Visor / Palm m50x / Sony Clie Driver' CONFIG_USB_SERIAL_VISOR $CONFIG_USB_SERIAL
-   dep_tristate '  USB Compaq iPAQ / HP Jornada / Casio EM500 Driver' CONFIG_USB_SERIAL_IPAQ $CONFIG_USB_SERIAL
+   dep_tristate '  USB Compaq iPAQ Driver' CONFIG_USB_SERIAL_IPAQ $CONFIG_USB_SERIAL
    dep_tristate '  USB IR Dongle Serial Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_IR $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
-   dep_tristate '  USB Inside Out Edgeport Serial Driver' CONFIG_USB_SERIAL_EDGEPORT $CONFIG_USB_SERIAL
-   dep_tristate '  USB Inside Out Edgeport Serial Driver (TI devices)' CONFIG_USB_SERIAL_EDGEPORT_TI $CONFIG_USB_SERIAL
+   dep_tristate '  USB Inside Out Edgeport Serial Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_EDGEPORT $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
    dep_tristate '  USB Keyspan PDA Single Port Serial Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_KEYSPAN_PDA $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
-   dep_tristate '  USB Keyspan USA-xxx Serial Driver' CONFIG_USB_SERIAL_KEYSPAN $CONFIG_USB_SERIAL
+   dep_tristate '  USB Keyspan USA-xxx Serial Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_KEYSPAN $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
    if [ "$CONFIG_USB_SERIAL_KEYSPAN" != "n" ]; then
-      bool '    USB Keyspan USA-28 Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA28
-      bool '    USB Keyspan USA-28X Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA28X
-      bool '    USB Keyspan USA-28XA Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA28XA
-      bool '    USB Keyspan USA-28XB Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA28XB
-      bool '    USB Keyspan USA-19 Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA19
-      bool '    USB Keyspan USA-18X Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA18X
-      bool '    USB Keyspan USA-19W Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA19W
-      bool '    USB Keyspan USA-19QW Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA19QW
-      bool '    USB Keyspan USA-19QI Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA19QI
-      bool '    USB Keyspan USA-49W Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA49W
+      bool '    USB Keyspan USA-28 Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA28 $CONFIG_USB_SERIAL_KEYSPAN
+      bool '    USB Keyspan USA-28X Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA28X $CONFIG_USB_SERIAL_KEYSPAN
+      bool '    USB Keyspan USA-28XA Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA28XA $CONFIG_USB_SERIAL_KEYSPAN
+      bool '    USB Keyspan USA-28XB Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA28XB $CONFIG_USB_SERIAL_KEYSPAN
+      bool '    USB Keyspan USA-19 Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA19 $CONFIG_USB_SERIAL_KEYSPAN
+      bool '    USB Keyspan USA-19QI Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA19QI $CONFIG_USB_SERIAL_KEYSPAN
+      bool '    USB Keyspan USA-18X Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA18X $CONFIG_USB_SERIAL_KEYSPAN
+      bool '    USB Keyspan USA-19W Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA19W $CONFIG_USB_SERIAL_KEYSPAN
+      bool '    USB Keyspan USA-19QW Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA19QW $CONFIG_USB_SERIAL_KEYSPAN
+      bool '    USB Keyspan MPR Firmware' CONFIG_USB_SERIAL_KEYSPAN_MPR $CONFIG_USB_SERIAL_KEYSPAN
+      bool '    USB Keyspan USA-49W Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA49W $CONFIG_USB_SERIAL_KEYSPAN
+      bool '    USB Keyspan USA-49WLC Firmware' CONFIG_USB_SERIAL_KEYSPAN_USA49WLC $CONFIG_USB_SERIAL_KEYSPAN
    fi
-   dep_tristate '  USB MCT Single Port Serial Driver' CONFIG_USB_SERIAL_MCT_U232 $CONFIG_USB_SERIAL
-   dep_tristate '  USB KL5KUSB105 (Palmconnect) Driver' CONFIG_USB_SERIAL_KLSI $CONFIG_USB_SERIAL
+   dep_tristate '  USB MCT Single Port Serial Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_MCT_U232 $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
+   dep_tristate '  USB KL5KUSB105 (Palmconnect) Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_KLSI $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
    dep_tristate '  USB KOBIL chipcard reader (EXPERIMENTAL)' CONFIG_USB_SERIAL_KOBIL_SCT $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
-   dep_tristate '  USB Prolific 2303 Single Port Serial Driver' CONFIG_USB_SERIAL_PL2303 $CONFIG_USB_SERIAL
+   dep_tristate '  USB Prolific 2303 Single Port Serial Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_PL2303 $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
    dep_tristate '  USB REINER SCT cyberJack pinpad/e-com chipcard reader (EXPERIMENTAL)' CONFIG_USB_SERIAL_CYBERJACK $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
    dep_tristate '  USB Xircom / Entregra Single Port Serial Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_XIRCOM $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
    dep_tristate '  USB ZyXEL omni.net LCD Plus Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_OMNINET $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
--- linux-2.4.21-pre4.orig/drivers/usb/serial/keyspan.c	Thu Feb 20 14:27:33 2003
+++ linux/drivers/usb/serial/keyspan.c	Thu Feb 20 14:42:49 2003
@@ -28,6 +28,22 @@
 
   Change History
 
+    Wed Feb 19 22:00:00 PST 2003 (Jeffrey S. Laing <keyspan@jsl.com>)
+      Merged the current (1/31/03) Keyspan code with the current (2.4.21-pre4)
+      Linux source tree.  The Linux tree lacked support for the 49WLC and
+      others.  The Keyspan patches didn't work with the current kernel.
+
+    Wed Apr 25 12:00:00 PST 2002 (Keyspan)
+      Started with Hugh Blemings' code dated Jan 17, 2002.  All adapters
+      now supported (including QI and QW).  Modified port open, port
+      close, and send setup() logic to fix various data and endpoint
+      synchronization bugs and device LED status bugs.  Changed keyspan_
+      write_room() to accurately return transmit buffer availability.
+      Changed forwardingLength from 1 to 16 for all adapters.
+
+    Fri Oct 12 16:45:00 EST 2001
+      Preliminary USA-19QI and USA-28 support (both test OK for me, YMMV)
+
     Wed Apr 25 12:00:00 PST 2002 (Keyspan)
       Started with Hugh Blemings' code dated Jan 17, 2002.  All adapters
       now supported (including QI and QW).  Modified port open, port
@@ -71,6 +87,8 @@
     Sat Jul  8 11:11:48 EST 2000 Hugh
       First public release - nothing works except the firmware upload.
       Tested on PPC and x86 architectures, seems to behave...
+
+    2003jan30	LPM	add support for the 49WLC and MPR
 */
 
 
@@ -102,7 +120,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v1.1.3"
+#define DRIVER_VERSION "v1.1.4"
 #define DRIVER_AUTHOR "Hugh Blemings <hugh@misc.nu"
 #define DRIVER_DESC "Keyspan USB to Serial Converter Driver"
 
@@ -188,7 +207,7 @@
 	return 0;
 }
 
-static void __exit keyspan_exit (void)
+void __exit keyspan_exit (void)
 {
 	usb_serial_deregister (&keyspan_pre_device);
 	usb_serial_deregister (&keyspan_1port_device);
@@ -904,6 +922,9 @@
 		/* usb_settoggle(urb->dev, usb_pipeendpoint(urb->pipe), usb_pipeout(urb->pipe), 0); */
 	}
 
+	// if the device is a USA49x, determine whether it is an W or WLC model
+	// and set the baud clock accordingly
+
 	keyspan_send_setup(port, 1);
 	//mdelay(100);
 	keyspan_set_termios(port, NULL);
@@ -1012,6 +1034,11 @@
 		fw_name = "USA19QI";
 		break;
 			     
+	case keyspan_mpr_pre_product_id:
+		record = &keyspan_mpr_firmware[0];
+		fw_name = "MPR";
+		break;
+
 	case keyspan_usa19qw_pre_product_id:
 		record = &keyspan_usa19qw_firmware[0];
 		fw_name = "USA19QI";
@@ -1032,6 +1059,11 @@
 		fw_name = "USA49W";
 		break;
 
+	case keyspan_usa49wlc_pre_product_id:
+		record = &keyspan_usa49wlc_firmware[0];
+		fw_name = "USA49WLC";
+		break;
+
 	default:
 		record = NULL;
 		fw_name = "Unknown";
@@ -1322,7 +1355,7 @@
 		div,	/* divisor */	
 		cnt;	/* inverse of divisor (programmed into 8051) */
 
-	dbg ("%s - %d.", __FUNCTION__, baud_rate);
+	dbg (__FUNCTION__ " %d.\n", baud_rate);
 
 		/* prevent divide by zero */
 	if ((b16 = baud_rate * 16L) == 0)
--- linux-2.4.21-pre4.orig/drivers/usb/serial/keyspan.h	Thu Nov 28 15:53:14 2002
+++ linux/drivers/usb/serial/keyspan.h	Thu Feb 20 15:09:29 2003
@@ -136,6 +133,12 @@
 	static const struct ezusb_hex_record *keyspan_usa19qi_firmware = NULL;
 #endif
 
+#ifdef CONFIG_USB_SERIAL_KEYSPAN_MPR
+        #include "keyspan_mpr_fw.h"
+#else
+	static const struct ezusb_hex_record *keyspan_mpr_firmware = NULL;
+#endif
+
 #ifdef CONFIG_USB_SERIAL_KEYSPAN_USA19QW
 	#include "keyspan_usa19qw_fw.h"
 #else
@@ -160,6 +163,12 @@
 	static const struct ezusb_hex_record *keyspan_usa49w_firmware = NULL;
 #endif
 
+#ifdef CONFIG_USB_SERIAL_KEYSPAN_USA49WLC
+        #include "keyspan_usa49wlc_fw.h"
+#else
+	static const struct ezusb_hex_record *keyspan_usa49wlc_firmware = NULL;
+#endif
+
 /* Values used for baud rate calculation - device specific */
 #define	KEYSPAN_INVALID_BAUD_RATE		(-1)
 #define	KEYSPAN_BAUD_RATE_OK			(0)
@@ -182,6 +191,7 @@
 #define	keyspan_usa18x_pre_product_id		0x0105
 #define	keyspan_usa19_pre_product_id		0x0103
 #define	keyspan_usa19qi_pre_product_id		0x010b
+#define	keyspan_mpr_pre_product_id		0x011b
 #define	keyspan_usa19qw_pre_product_id		0x0118
 #define	keyspan_usa19w_pre_product_id		0x0106
 #define	keyspan_usa28_pre_product_id		0x0101
@@ -189,6 +199,7 @@
 #define	keyspan_usa28xa_pre_product_id		0x0114
 #define	keyspan_usa28xb_pre_product_id		0x0113
 #define	keyspan_usa49w_pre_product_id		0x0109
+#define	keyspan_usa49wlc_pre_product_id		0x011a
 
 /* Product IDs post-renumeration.  Note that the 28x and 28xb
    have the same id's post-renumeration but behave identically
@@ -196,6 +207,7 @@
 #define	keyspan_usa18x_product_id		0x0112
 #define	keyspan_usa19_product_id		0x0107
 #define	keyspan_usa19qi_product_id		0x010c
+#define	keyspan_mpr_product_id			0x011c
 #define	keyspan_usa19qw_product_id		0x0119
 #define	keyspan_usa19w_product_id		0x0108
 #define	keyspan_usa28_product_id		0x010f
@@ -203,6 +215,7 @@
 #define	keyspan_usa28xa_product_id		0x0115
 #define	keyspan_usa28xb_product_id		0x0110
 #define	keyspan_usa49w_product_id		0x010a
+#define	keyspan_usa49wlc_product_id		0x012a
 
 
 struct keyspan_device_details {
@@ -394,6 +407,22 @@
 	baudclk:		KEYSPAN_USA49W_BAUDCLK,
 };
 
+static const struct keyspan_device_details usa49wlc_device_details = {
+	product_id:		keyspan_usa49wlc_product_id,
+	msg_format:		msg_usa49,
+	num_ports:		4,
+	indat_endp_flip:	0,
+	outdat_endp_flip:	0,
+	indat_endpoints:	{0x81, 0x82, 0x83, 0x84},
+	outdat_endpoints:	{0x01, 0x02, 0x03, 0x04},
+	inack_endpoints:	{-1, -1, -1, -1},
+	outcont_endpoints:	{-1, -1, -1, -1},
+	instat_endpoint:	0x87,
+	glocont_endpoint:	0x07,
+	calculate_baud_rate:	keyspan_usa19w_calc_baud,
+	baudclk:		KEYSPAN_USA19W_BAUDCLK,
+};
+
 static const struct keyspan_device_details *keyspan_devices[] = {
 	&usa18x_device_details,
 	&usa19_device_details,
@@ -405,6 +434,7 @@
 	&usa28xa_device_details,
 	/* 28xb not required as it renumerates as a 28x */
 	&usa49w_device_details,
+	&usa49wlc_device_details,
 	NULL,
 };
 
@@ -414,21 +444,25 @@
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19w_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19qi_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19qw_pre_product_id) },
+	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_mpr_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28x_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28xa_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28xb_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa49w_pre_product_id) },
+	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa49wlc_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa18x_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19w_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19qi_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19qw_product_id) },
+	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_mpr_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28x_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28xa_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28xb_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa49w_product_id)},
+	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa49wlc_product_id)},
 	{ } /* Terminating entry */
 };
 
@@ -441,11 +475,13 @@
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19qi_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19qw_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19w_pre_product_id) },
+	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_mpr_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28x_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28xa_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28xb_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa49w_pre_product_id) },
+	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa49wlc_pre_product_id) },
 	{ } /* Terminating entry */
 };
 
@@ -455,6 +491,7 @@
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19qi_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19qw_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19w_product_id) },
+	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_mpr_pre_product_id) },
 	{ } /* Terminating entry */
 };
 
@@ -462,11 +499,13 @@
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28x_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28xa_product_id) },
+	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa28xb_product_id) },
 	{ } /* Terminating entry */
 };
 
 static struct usb_device_id keyspan_4port_ids[] = {
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa49w_product_id) },
+	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa49wlc_product_id)},
 	{ } /* Terminating entry */
 };
 
