Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129219AbQKXLBz>; Fri, 24 Nov 2000 06:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129280AbQKXLBp>; Fri, 24 Nov 2000 06:01:45 -0500
Received: from [209.249.10.20] ([209.249.10.20]:11176 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S129219AbQKXLB3>; Fri, 24 Nov 2000 06:01:29 -0500
Date: Fri, 24 Nov 2000 02:31:28 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch: MODULE_DEVICE_TABLE's for all remaining PCI drivers in linux-2.4.0-test11
Message-ID: <20001124023128.A569@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>Date: Wed, 22 Nov 2000 13:02:24 +0000
>From: Tim Waugh <twaugh@redhat.com>
>
>Hurray!  Someday we'll have pci_device_id tables for all PCI devices..

	That someday is today.

	A complete patch covering all of the new PCI MODULE_DEVICE_TABLE's
is FTPable from
ftp://ftp.yggdrasil.com/pub/dist/device_control/kernel/pci_id_tables-2.4.0-test11.patch.gz.
I have also attached a subset of that patch below covering all of the
drivers that were not covered in my previous posts to linux-kernel
(which covered block, char, net, and scsi).

	With these changes, it will be possible to simplify linux
distributions a bit, in terms of installation, maintenance,
and internal structure.  This is potentially important for Linux
adoption, especially among users who are not linux-kernel people.
By having complete coverage, we also make it much more likely that
any new drivers that are developed by adapting an existing driver
(and almost all are) will be likely to include appropriate
MODULE_DEVICE_TABLE's as well.  Indeed, this mechanism is more
important to externally provided drivers, since depmod will automatically
pick up their device ID information after they are deposited in the
/lib/modules/<version> tree and depmod is run.  Finally, these changes
also eliminate a small step in porting these drivers to the new PCI
interface.  This may help motivate device driver authors to attempt
that after 2.4.0.

	In the past, I have offered to include the patch that
I submitted for pciutils that adds the "pcimodules" program, that
uses /lib/modules/<version>/modules.pcimap and /proc/bus/usb to
generate a list of modules applicable to the current hardware.
Since it has been a while, and I have not seen a new pciutils release,
I have placed that patch in
ftp://ftp.yggdrasil.com/pub/dist/device_control/pcimodules/pcimodules-pciutils-2.1.8.diff.gz
I would encourage people to give it a whirl (please see its manual page
for an example of how to integrate it into a boot script).


Notes about the patch:

	This is not a "final" release.  I imagine I have made mistakes,
and I am interested in corrections.

	There are a few files that I have deliberately skipped:

	drivers/net/de4x5.c - This driver wants to look at every
			      ethernet PCI device and determine
			      compability by reading the eeprom,
			      plus tulip.c handles the same devices.

	drivers/radio/radio-maestro.c - I don't understand why this
				driver exists.  Why does it have to
				speak to maestro hardware directly?
				Shouldn't there be some generic sound
				interface for it to use?  Anyhow, the
				only PCI ID's that it seems to select
				for are those indicating a maestro sound
				card, and I assume most maestro users
				will not want to load this module.
				I also do not know if the maestro
				sound system is useable if this driver
				is loaded.

	drivers/scsi/eata_pio.c - eati_dma.c supports the same devices.
			      Is there some PCI-based circumstance when
			      it would be better to use eata_pio?

	drivers/sound/maestro.c	- I have submitted a port of this
				  to the new PCI interface and do not
				  to collide with it.

	drivers/sound/cs46xx.c - Likewise, I understand there is a port of
				 this to the new PCI interface and I
				 do not to collide with it.

	drivers/usb/{usb-,}uhci.c -  I have sent patches porting
				these drivers to the new PCI interface,
				and do not want to collide with them.

	Although the patch I have attached below covers only
the drivers for which I have not posted patches previously,
the complete patch covering all of the PCI MODULE_DEVICE_TABLE's added
is FTPable from
ftp://ftp.yggdrasil.com/pub/dist/device_control/kernel/pci_id_tables-2.4.0-test11.patch.gz.

	With the exception of ohci1394.c, the only "-" lines in these
patches exist to ensure that <linux/module.h> is always included, so
the MODULE_DEVICE_TABLE macro is defined.

	In the special case of ohci1394.c, I was able to avoid having
a complex vendor_id/device_id table by changing the driver instead to
just look for the appropriate PCI device class (there is one specifically
for IEEE1394 OHCI controllers).  Many thanks to Sebastien Rogeaux for
letting me know that this was OK and verifying that the resulting drivers
works!

	Anyhow, here is the patch for the drivers that I had not covered
in my previous posts.  This includes atm, ieee1394, isdn, media/video,
video, and one driver in telephony.  The larger pci_device_id tables
now use a macro to make the table more readable, as suggested by
Keith Owens and refined a bit by Jeff Garzik.  Since this addresses
the reduncancy and readability issue with large tables, all of these
new tables use named initializers (by the way, I did not invent that
practice for pci_device_id tables; I think it originated in usb/usb-ohci.c
by David Brownell).  Again, the complete patch covering all of the
MODULE_DEVICE_TABLE changes is FTPable from
ftp://ftp.yggdrasil.com/pub/dist/device_control/kernel/pci_id_tables-2.4.0-test11.patch.gz.

--
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="diffs.new"

--- linux-2.4.0-test11/include/linux/pci_ids.h	Wed Nov  8 17:15:13 2000
+++ linux/include/linux/pci_ids.h	Thu Nov 23 19:40:26 2000
@@ -119,6 +119,9 @@
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
 
+#define PCI_VENDOR_ID_ASUSCOM		0x0675
+#define PCI_DEVICE_ID_ASUSCOM_TA1	0x1702
+
 #define PCI_VENDOR_ID_COMPAQ		0x0e11
 #define PCI_DEVICE_ID_COMPAQ_TOKENRING	0x0508
 #define PCI_DEVICE_ID_COMPAQ_1280	0x3033
@@ -380,6 +383,10 @@
 #define PCI_DEVICE_ID_OPTI_82C861	0xc861
 #define PCI_DEVICE_ID_OPTI_82C825	0xd568
 
+#define PCI_VENDOR_ID_ELSA		0x1048
+#define PCI_DEVICE_ID_ELSA_MIRCOLINK	0x1000
+#define PCI_DEVICE_ID_ELSA_QS3000	0x3000
+
 #define PCI_VENDOR_ID_SGS		0x104a
 #define PCI_DEVICE_ID_SGS_2000		0x0008
 #define PCI_DEVICE_ID_SGS_1764		0x0009
@@ -470,6 +477,7 @@
 #define PCI_VENDOR_ID_APPLE		0x106b
 #define PCI_DEVICE_ID_APPLE_BANDIT	0x0001
 #define PCI_DEVICE_ID_APPLE_GC		0x0002
+#define PCI_DEVICE_ID_APPLE_PLANB	0x0004
 #define PCI_DEVICE_ID_APPLE_HYDRA	0x000e
 #define PCI_DEVICE_ID_APPLE_UNINORTH	0x0020
 
@@ -561,15 +569,20 @@
 #define PCI_DEVICE_ID_WINBOND_83769	0x0001
 #define PCI_DEVICE_ID_WINBOND_82C105	0x0105
 #define PCI_DEVICE_ID_WINBOND_83C553	0x0565
+#define PCI_DEVICE_ID_WINBOND_6692	0x6692
 
 #define PCI_VENDOR_ID_DATABOOK		0x10b3
 #define PCI_DEVICE_ID_DATABOOK_87144	0xb106
 
 #define PCI_VENDOR_ID_PLX		0x10b5
+#define PCI_DEVICE_ID_SATSAGEM_NICCY	0x1016
+#define PCI_DEVICE_ID_PLX_R685		0x1030
 #define PCI_VENDOR_ID_PLX_ROMULUS	0x106a
 #define PCI_DEVICE_ID_PLX_SPCOM800	0x1076
 #define PCI_DEVICE_ID_PLX_1077		0x1077
 #define PCI_DEVICE_ID_PLX_SPCOM200	0x1103
+#define PCI_DEVICE_ID_PLX_DJINN_ITOO	0x1151
+#define PCI_DEVICE_ID_PLX_R753		0x1152
 #define PCI_DEVICE_ID_PLX_9050		0x9050
 #define PCI_DEVICE_ID_PLX_9060		0x9060
 #define PCI_DEVICE_ID_PLX_9060ES	0x906E
@@ -798,6 +811,11 @@
 #define PCI_DEVICE_ID_PHILIPS_SAA7145	0x7145
 #define PCI_DEVICE_ID_PHILIPS_SAA7146	0x7146
 
+#define PCI_VENDOR_ID_EICON		0x1133
+#define PCI_DEVICE_ID_EICON_DIVA20	0xe002
+#define PCI_DEVICE_ID_EICON_DIVA20_U	0xe004
+#define PCI_DEVICE_ID_EICON_DIVA201	0xe005
+
 #define PCI_VENDOR_ID_CYCLONE		0x113c
 #define PCI_DEVICE_ID_CYCLONE_SDK	0x0001
 
@@ -1328,6 +1346,7 @@
 
 #define PCI_VENDOR_ID_TIGERJET		0xe159
 #define PCI_DEVICE_ID_TIGERJET_300	0x0001
+#define PCI_DEVICE_ID_TIGERJET_100	0x0002
 
 #define PCI_VENDOR_ID_ARK		0xedd8
 #define PCI_DEVICE_ID_ARK_STING		0xa091
--- linux-2.4.0-test11/drivers/atm/ambassador.c	Thu Jul  6 21:37:24 2000
+++ linux/drivers/atm/ambassador.c	Thu Nov 23 21:08:24 2000
@@ -326,6 +326,17 @@
 
 static const unsigned long onegigmask = -1 << 30;
 
+static struct pci_device_id ambassador_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_MADGE,
+	  device: PCI_DEVICE_ID_MADGE_AMBASSADOR,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, ambassador_pci_tbl);
+
 /********** access to adapter **********/
 
 static inline void wr_plain (const amb_dev * dev, size_t addr, u32 data) {
--- linux-2.4.0-test11/drivers/atm/fore200e.c	Mon Oct 16 12:56:50 2000
+++ linux/drivers/atm/fore200e.c	Thu Nov 23 21:03:28 2000
@@ -101,6 +101,17 @@
 MODULE_AUTHOR("Christophe Lizzi - credits to Uwe Dannowski and Heikki Vatiainen");
 MODULE_DESCRIPTION("FORE Systems 200E-series ATM driver - version " FORE200E_VERSION);
 MODULE_SUPPORTED_DEVICE("PCA-200E, SBA-200E");
+
+static struct pci_device_id fore200e_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_FORE,
+	  device: PCI_DEVICE_ID_FORE_PCA200E,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, fore200e_pci_tbl);
 #endif
 
 
--- linux-2.4.0-test11/drivers/atm/horizon.c	Thu Jul  6 21:37:24 2000
+++ linux/drivers/atm/horizon.c	Thu Nov 23 21:00:48 2000
@@ -352,6 +352,19 @@
   
 */
 
+#if LINUX_VERSION_CODE >= 0x020400
+static struct pci_device_id horizon_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_MADGE,
+	  device: PCI_DEVICE_ID_MADGE_HORIZON,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, horizon_pci_tbl);
+#endif
+
 /********** globals **********/
 
 static hrz_dev * hrz_devs = NULL;
--- linux-2.4.0-test11/drivers/atm/iphase.c	Sun Aug  6 22:20:09 2000
+++ linux/drivers/atm/iphase.c	Thu Nov 23 20:56:34 2000
@@ -90,6 +90,17 @@
             |IF_IADBG_ABR | IF_IADBG_EVENT*/ 0; 
 
 #ifdef MODULE
+static struct pci_device_id iphase_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_IPHASE,
+	  device: PCI_DEVICE_ID_IPHASE_5575,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, iphase_pci_tbl);
+
 MODULE_PARM(IA_TX_BUF, "i");
 MODULE_PARM(IA_TX_BUF_SZ, "i");
 MODULE_PARM(IA_RX_BUF, "i");
--- linux-2.4.0-test11/drivers/atm/nicstar.c	Tue Nov 14 13:16:33 2000
+++ linux/drivers/atm/nicstar.c	Thu Nov 23 21:04:28 2000
@@ -274,6 +274,16 @@
 static char *mac[NS_MAX_CARDS];
 MODULE_PARM(mac, "1-" __MODULE_STRING(NS_MAX_CARDS) "s");
 
+static struct pci_device_id nicstar_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_IDT,
+	  device: PCI_DEVICE_ID_IDT_IDT77201,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, nicstar_pci_tbl);
 
 /* Functions*******************************************************************/
 
--- linux-2.4.0-test11/drivers/atm/zatm.c	Tue Jul 18 14:55:01 2000
+++ linux/drivers/atm/zatm.c	Thu Nov 23 21:23:51 2000
@@ -132,6 +132,24 @@
 
 #define MBX_SIZE(i) (mbx_entries[i]*mbx_esize[i])
 
+static struct pci_device_id zatm_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_ZEITNET,
+	  device: PCI_DEVICE_ID_ZEITNET_1221,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_ZEITNET,
+	  device: PCI_DEVICE_ID_ZEITNET_1225,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, zatm_pci_tbl);
+
+
 
 /*-------------------------------- utilities --------------------------------*/
 
--- linux-2.4.0-test11/drivers/ide/ide-pci.c	Tue Nov  7 11:02:24 2000
+++ linux/drivers/ide/ide-pci.c	Wed Nov 22 05:22:26 2000
@@ -13,6 +13,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/timer.h>
@@ -382,6 +383,19 @@
 	{DEVID_SLC90E66,"SLC90E66",	PCI_SLC90E66,	ATA66_SLC90E66,	INIT_SLC90E66,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
         {DEVID_OSB4,    "ServerWorks OSB4",     PCI_OSB4,       ATA66_OSB4,     INIT_OSB4,      NULL,   {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,       0 },
 	{IDE_PCI_DEVID_NULL, "PCI_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}}, 	ON_BOARD,	0 }};
+
+static struct pci_device_id ide_pci_tbl[] __initdata = {
+  {
+	vendor: PCI_ANY_ID,
+	device: PCI_ANY_ID,
+	subvendor: PCI_ANY_ID,
+	subdevice: PCI_ANY_ID,
+	class: PCI_CLASS_STORAGE_IDE << 8,
+	class_mask: 0xffff00,
+  },
+  { }				/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, ide_pci_tbl);
 
 /*
  * This allows offboard ide-pci cards the enable a BIOS, verify interrupt
--- linux-2.4.0-test11/drivers/ieee1394/aic5800.c	Wed Oct 11 16:49:47 2000
+++ linux/drivers/ieee1394/aic5800.c	Thu Nov 23 20:38:17 2000
@@ -29,6 +29,7 @@
 #include <linux/fs.h>
 #include <linux/poll.h>
 #include <linux/delay.h>
+#include <linux/init.h>
 #include <asm/byteorder.h>
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -56,6 +57,18 @@
 static void remove_card(struct aic5800 *aic);
 static int init_driver(void);
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+static struct pci_device_id aic5800_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_ADAPTEC,
+	  device: PCI_DEVICE_ID_ADAPTEC_5800,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, aic5800_pci_tbl);
+#endif
 
 /*****************************************************************
  * Auxiliary functions needed to read the EEPROM
--- linux-2.4.0-test11/drivers/ieee1394/ohci1394.c	Sun Oct  1 19:53:07 2000
+++ linux/drivers/ieee1394/ohci1394.c	Thu Nov 23 21:11:01 2000
@@ -85,6 +85,7 @@
 #include <linux/types.h>
 #include <linux/wrapper.h>
 #include <linux/vmalloc.h>
+#include <linux/init.h>
 
 #include "ieee1394.h"
 #include "ieee1394_types.h"
@@ -121,20 +122,23 @@
 	    remove_card(ohci); \
 	      return 1;
 
-int supported_chips[][2] = {
-	{ PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_OHCI1394_LV22 },
-	{ PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_OHCI1394_LV23 },
-	{ PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_OHCI1394_LV26 },
-	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_OHCI1394 },
-	{ PCI_VENDOR_ID_SONY, PCI_DEVICE_ID_SONY_CXD3222 },
-	{ PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_UPD72862 },
-	{ PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_UPD72870 },
-	{ PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_UPD72871 },
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_FW },
-	{ PCI_VENDOR_ID_AL, PCI_DEVICE_ID_ALI_OHCI1394_M5251 },
-	{ PCI_VENDOR_ID_LUCENT, PCI_DEVICE_ID_LUCENT_FW323 },
-	{ -1, -1 }
+#define PCI_CLASS_FIREWIRE_OHCI     ((PCI_CLASS_SERIAL_FIREWIRE << 8) | 0x10)
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+static struct pci_device_id ohci1394_pci_tbl[] __initdata = {
+  {
+    class: 		PCI_CLASS_FIREWIRE_OHCI,
+	class_mask: 	0x00ffffff,
+	vendor:		PCI_ANY_ID,
+	device:		PCI_ANY_ID,
+	subvendor:	PCI_ANY_ID,
+	subdevice:	PCI_ANY_ID,
+  },
+ { 0, },
 };
+MODULE_DEVICE_TABLE(pci, ohci1394_pci_tbl);
+#endif
+
 
 static struct ti_ohci cards[MAX_OHCI1394_CARDS];
 static int num_of_cards = 0;
@@ -2147,7 +2151,6 @@
 {
 	struct pci_dev *dev = NULL;
 	int success = 0;
-	int i;
 
 	if (num_of_cards) {
 		PRINT_G(KERN_DEBUG, __PRETTY_FUNCTION__ " called again");
@@ -2156,13 +2159,9 @@
 
 	PRINT_G(KERN_INFO, "looking for Ohci1394 cards");
 
-	for (i = 0; supported_chips[i][0] != -1; i++) {
-		while ((dev = pci_find_device(supported_chips[i][0],
-					      supported_chips[i][1], dev)) 
-		       != NULL) {
-			if (add_card(dev) == 0) {
-				success = 1;
-			}
+	while ((dev = pci_find_class(PCI_CLASS_FIREWIRE_OHCI, dev)) != NULL ) {
+		if (add_card(dev) == 0) {
+			success = 1;
 		}
 	}
 
--- linux-2.4.0-test11/drivers/ieee1394/pcilynx.c	Sun Oct  1 19:53:07 2000
+++ linux/drivers/ieee1394/pcilynx.c	Thu Nov 23 21:32:00 2000
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include <linux/fs.h>
 #include <linux/poll.h>
+#include <linux/init.h>
 #include <asm/byteorder.h>
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -59,6 +60,17 @@
 
 static struct ti_lynx cards[MAX_PCILYNX_CARDS];
 static int num_of_cards = 0;
+
+static struct pci_device_id pcilynx_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_TI,
+	  device: PCI_DEVICE_ID_TI_PCILYNX,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, pcilynx_pci_tbl);
 
 
 /*
--- linux-2.4.0-test11/drivers/isdn/avmb1/b1pci.c	Fri Nov 17 11:16:21 2000
+++ linux/drivers/isdn/avmb1/b1pci.c	Thu Nov 23 03:43:18 2000
@@ -93,6 +93,7 @@
 #include <linux/ioport.h>
 #include <linux/pci.h>
 #include <linux/capi.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include "capicmd.h"
 #include "capiutil.h"
@@ -113,6 +114,16 @@
 
 /* ------------------------------------------------------------- */
 
+static struct pci_device_id b1pci_pci_tbl[] __initdata = {
+  {
+    vendor: PCI_VENDOR_ID_AVM,
+    device: PCI_DEVICE_ID_AVM_B1,
+    subvendor: PCI_ANY_ID,
+    subdevice: PCI_ANY_ID,
+  },
+  { }				/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, b1pci_pci_tbl);
 MODULE_AUTHOR("Carsten Paeth <calle@calle.in-berlin.de>");
 
 /* ------------------------------------------------------------- */
--- linux-2.4.0-test11/drivers/isdn/avmb1/c4.c	Fri Nov 17 11:16:21 2000
+++ linux/drivers/isdn/avmb1/c4.c	Thu Nov 23 19:58:22 2000
@@ -83,6 +83,7 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <linux/netdevice.h>
+#include <linux/init.h>
 #include "capicmd.h"
 #include "capiutil.h"
 #include "capilli.h"
@@ -118,6 +119,17 @@
 MODULE_AUTHOR("Carsten Paeth <calle@calle.in-berlin.de>");
 
 MODULE_PARM(suppress_pollack, "0-1i");
+
+static struct pci_device_id c4_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_DEC,
+	  device: PCI_DEVICE_ID_DEC_21285,
+	  subvendor: PCI_VENDOR_ID_AVM,
+	  subdevice: PCI_DEVICE_ID_AVM_C4,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, c4_pci_tbl);
 
 /* ------------------------------------------------------------- */
 
--- linux-2.4.0-test11/drivers/isdn/avmb1/t1pci.c	Fri Nov 17 11:16:21 2000
+++ linux/drivers/isdn/avmb1/t1pci.c	Thu Nov 23 03:43:25 2000
@@ -62,6 +62,7 @@
 #include <linux/ioport.h>
 #include <linux/pci.h>
 #include <linux/capi.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include "capicmd.h"
 #include "capiutil.h"
@@ -85,6 +86,16 @@
 
 /* ------------------------------------------------------------- */
 
+static struct pci_device_id b1pci_pci_tbl[] __initdata = {
+  {
+    vendor: PCI_VENDOR_ID_AVM,
+    device: PCI_DEVICE_ID_AVM_T1,
+    subvendor: PCI_ANY_ID,
+    subdevice: PCI_ANY_ID,
+  },
+  { }				/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, b1pci_pci_tbl);
 MODULE_AUTHOR("Carsten Paeth <calle@calle.in-berlin.de>");
 
 /* ------------------------------------------------------------- */
--- linux-2.4.0-test11/drivers/isdn/hisax/config.c	Fri Nov 17 11:16:21 2000
+++ linux/drivers/isdn/hisax/config.c	Thu Nov 23 19:51:48 2000
@@ -16,6 +16,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/tqueue.h>
 #include <linux/interrupt.h>
+#include <linux/pci.h>
 #define HISAX_STATUS_BUFSIZE 4096
 #define INCLUDE_INLINE_FUNCS
 
@@ -1688,3 +1689,65 @@
 	nrcards++;
 	return (ret);
 }
+
+static struct pci_device_id hisax_pci_tbl[] __initdata = {
+#ifdef CONFIG_HISAX_FRTIZPCI
+  {PCI_VENDOR_ID_AVM, PCI_DEVICE_ID_AVM_FRITZ, PCI_ANY_ID, PCI_ANY_ID},
+#endif
+#ifdef CONFIG_HISAX_DIEHLDIVA
+  {PCI_VENDOR_ID_EICON, PCI_DEVICE_ID_EICON_DIVA20, PCI_ANY_ID, PCI_ANY_ID},
+  {PCI_VENDOR_ID_EICON, PCI_DEVICE_ID_EICON_DIVA20_U, PCI_ANY_ID, PCI_ANY_ID},
+  {PCI_VENDOR_ID_EICON, PCI_DEVICE_ID_EICON_DIVA201, PCI_ANY_ID, PCI_ANY_ID},
+#endif
+#ifdef CONFIG_HISAX_ELSA
+  {PCI_VENDOR_ID_ELSA, PCI_DEVICE_ID_ELSA_MIRCOLINK, PCI_ANY_ID, PCI_ANY_ID},
+  {PCI_VENDOR_ID_ELSA, PCI_DEVICE_ID_ELSA_MIRCOLINK, PCI_ANY_ID, PCI_ANY_ID},
+#endif
+#ifdef CONFIG_HISAX_GAZEL
+  {PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_R685, PCI_ANY_ID, PCI_ANY_ID},
+  {PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_R753, PCI_ANY_ID, PCI_ANY_ID},
+  {PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_DJINN_ITOO, PCI_ANY_ID, PCI_ANY_ID},
+#endif
+#ifdef CONFIG_HISAX_QUADRO
+  {PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050, PCI_ANY_ID, PCI_ANY_ID},
+#endif
+#ifdef CONFIG_HISAX_NICCY
+  {PCI_VENDOR_ID_SATSAGEM,PCI_DEVICE_ID_SATSAGEM_NICCY, PCI_ANY_ID,PCI_ANY_ID},
+#endif
+#ifdef CONFIG_HISAX_SEDLBAUER
+  {PCI_VENDOR_ID_TIGERJET, PCI_DEVICE_ID_TIGERJET_100, PCI_ANY_ID,PCI_ANY_ID},
+#endif
+#if defined(CONFIG_HISAX_NETJET) || defined(CONFIG_HISAX_NETJET_U)
+  {PCI_VENDOR_ID_TIGERJET, PCI_DEVICE_ID_TIGERJET_300, PCI_ANY_ID,PCI_ANY_ID},
+#endif
+#if defined(CONFIG_HISAX_TELESPCI) || defined(CONFIG_HISAX_SCT_QUADRO)
+  {PCI_VENDOR_ID_ZORAN, PCI_DEVICE_ID_ZORAN_36120, PCI_ANY_ID,PCI_ANY_ID},
+#endif
+#ifdef CONFIG_HISAX_W6692
+  {PCI_VENDOR_ID_ASUSCOM, PCI_DEVICE_ID_ASUSCOM_TA1, PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_WINBOND2, PCI_DEVICE_ID_WINBOND_6692, PCI_ANY_ID,PCI_ANY_ID},
+#endif
+#ifdef CONFIG_HISAX_HFC_PCI
+  {0x1397, 0x2BD0, PCI_ANY_ID, PCI_ANY_ID},
+  {0x1397, 0xB000, PCI_ANY_ID, PCI_ANY_ID},
+  {0x1397, 0xB006, PCI_ANY_ID, PCI_ANY_ID},
+  {0x1397, 0xB007, PCI_ANY_ID, PCI_ANY_ID},
+  {0x1397, 0xB008, PCI_ANY_ID, PCI_ANY_ID},
+  {0x1397, 0xB009, PCI_ANY_ID, PCI_ANY_ID},
+  {0x1397, 0xB00A, PCI_ANY_ID, PCI_ANY_ID},
+  {0x1397, 0xB00B, PCI_ANY_ID, PCI_ANY_ID},
+  {0x1397, 0xB00C, PCI_ANY_ID, PCI_ANY_ID},
+  {0x1043, 0x0675, PCI_ANY_ID, PCI_ANY_ID},
+  {0x0871, 0xFFA2, PCI_ANY_ID, PCI_ANY_ID},
+  {0x0871, 0xFFA1, PCI_ANY_ID, PCI_ANY_ID},
+  {0x1051, 0x0100, PCI_ANY_ID, PCI_ANY_ID},
+  {0x1397, 0xB100, PCI_ANY_ID, PCI_ANY_ID},
+  {0x15B0, 0x2BD0, PCI_ANY_ID, PCI_ANY_ID},
+  {0x114F, 0x0070, PCI_ANY_ID, PCI_ANY_ID},
+  {0x114F, 0x0071, PCI_ANY_ID, PCI_ANY_ID},
+  {0x114F, 0x0072, PCI_ANY_ID, PCI_ANY_ID},
+  {0x114F, 0x0073, PCI_ANY_ID, PCI_ANY_ID},
+#endif
+  { }				/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, hisax_pci_tbl);
--- linux-2.4.0-test11/drivers/isdn/hysdn/hysdn_init.c	Fri Nov 17 11:16:20 2000
+++ linux/drivers/isdn/hysdn/hysdn_init.c	Thu Nov 23 03:54:25 2000
@@ -28,6 +28,7 @@
 #include <linux/vmalloc.h>
 #include <linux/malloc.h>
 #include <linux/pci.h>
+#include <linux/init.h>
 
 #include "hysdn_defs.h"
 
@@ -60,6 +61,15 @@
 		0, 0
 	}			/* terminating entry */
 };
+
+static struct pci_device_id hysdn_pci_tbl[] __initdata = {
+ {PCI_VENDOR_ID_HYPERCOPE, PCI_DEVICE_ID_PLX, PCI_ANY_ID, PCI_SUB_ID_METRO},
+ {PCI_VENDOR_ID_HYPERCOPE, PCI_DEVICE_ID_PLX, PCI_ANY_ID, PCI_SUB_ID_CHAMP2},
+ {PCI_VENDOR_ID_HYPERCOPE, PCI_DEVICE_ID_PLX, PCI_ANY_ID, PCI_SUB_ID_ERGO},
+ {PCI_VENDOR_ID_HYPERCOPE, PCI_DEVICE_ID_PLX, PCI_ANY_ID, PCI_SUB_ID_OLD_ERGO},
+ { }				/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, hysdn_pci_tbl);
 
 /*********************************************************************/
 /* search_cards searches for available cards in the pci config data. */
--- linux-2.4.0-test11/drivers/media/video/buz.c	Fri Nov 17 17:56:51 2000
+++ linux/drivers/media/video/buz.c	Thu Nov 23 19:57:05 2000
@@ -49,6 +49,7 @@
 #include <linux/wrapper.h>
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
+#include <linux/init.h>
 
 #include <linux/videodev.h>
 
@@ -155,6 +156,17 @@
 MODULE_PARM(v4l_bufsize, "i");
 MODULE_PARM(default_input, "i");
 MODULE_PARM(default_norm, "i");
+
+static struct pci_device_id buz_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_ZORAN,
+	  device: PCI_DEVICE_ID_ZORAN_36057,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, buz_pci_tbl);
 
 /* Anybody who uses more than four? */
 #define BUZ_MAX 4
--- linux-2.4.0-test11/drivers/media/video/planb.c	Fri Nov 17 17:56:51 2000
+++ linux/drivers/media/video/planb.c	Thu Nov 23 19:42:04 2000
@@ -73,6 +73,19 @@
 MODULE_PARM(def_norm, "i");
 MODULE_PARM_DESC(def_norm, "Default startup norm (0=PAL, 1=NTSC, 2=SECAM)");
 
+#if LINUX_VERSION_CODE >= 0x020400
+static struct pci_device_id planb_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_APPLE,
+	  device: PCI_DEVICE_ID_APPLE_PLANB,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, planb_pci_tbl);
+#endif /* LINUX_VERSION_CODE >= 0x020400 */
+
 /* ------------------ PlanB Exported Functions ------------------ */
 static long planb_write(struct video_device *, const char *, unsigned long, int);
 static long planb_read(struct video_device *, char *, unsigned long, int);
--- linux-2.4.0-test11/drivers/media/video/stradis.c	Fri Nov 17 17:56:51 2000
+++ linux/drivers/media/video/stradis.c	Thu Nov 23 19:31:58 2000
@@ -1999,6 +1999,17 @@
 	mmap:		saa_mmap,
 };
 
+static struct pci_device_id saa_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_PHILIPS,
+	  device: PCI_DEVICE_ID_PHILIPS_SAA7146,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, saa_pci_tbl);
+
 static int configure_saa7146(struct pci_dev *dev, int num)
 {
 	int result;
--- linux-2.4.0-test11/drivers/media/video/zr36120.c	Fri Nov 17 17:56:52 2000
+++ linux/drivers/media/video/zr36120.c	Thu Nov 23 23:54:29 2000
@@ -63,6 +63,19 @@
 MODULE_PARM(triton1,"i");
 MODULE_PARM(cardtype,"1-" __MODULE_STRING(ZORAN_MAX) "i");
 
+#if LINUX_VERSION_CODE >= 0x020400
+static struct pci_device_id zoran_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_ZORAN,
+	  device: PCI_DEVICE_ID_ZORAN_36120,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, zoran_pci_tbl);
+#endif
+
 static int zoran_cards;
 static struct zoran zorans[ZORAN_MAX];
 
--- linux-2.4.0-test11/drivers/mtd/pmc551.c	Fri Jul 14 12:21:19 2000
+++ linux/drivers/mtd/pmc551.c	Thu Nov 23 19:25:40 2000
@@ -83,6 +83,19 @@
 #define PCI_BASE_ADDRESS(dev) (dev->base_address[0])
 #endif
 
+#if LINUX_VERSION_CODE >= 0x020400
+static struct pci_device_id pmc551_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_V3_SEMI,
+	  device: PCI_DEVICE_ID_V3_SEMI_V370PDC,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, pmc551_pci_tbl);
+#endif
+
 static struct mtd_info *pmc551list = NULL;
 
 static int pmc551_erase (struct mtd_info *mtd, struct erase_info *instr)
--- linux-2.4.0-test11/drivers/net/tokenring/lanstreamer.c	Tue Jul 18 16:52:35 2000
+++ linux/drivers/net/tokenring/lanstreamer.c	Thu Nov 23 21:37:51 2000
@@ -190,6 +190,17 @@
 #endif
 #endif
 
+static struct pci_device_id lanstreamer_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_IBM,
+	  device: PCI_DEVICE_ID_IBM_TR,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, lanstreamer_pci_tbl);
+
 int __init streamer_probe(struct net_device *dev)
 {
 	int cards_found;
--- linux-2.4.0-test11/drivers/net/wan/sdladrv.c	Tue Jun 20 14:14:51 2000
+++ linux/drivers/net/wan/sdladrv.c	Fri Nov 17 19:35:23 2000
@@ -195,6 +195,18 @@
  * Note: All data must be explicitly initialized!!!
  */
 
+static struct pci_device_id sdladrv_pci_tbl[] __initdata = {
+	{
+	  vendor: V3_VENDOR_ID,
+	  device: V3_DEVICE_ID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(pci, sdladrv_pci_tbl);
+
 /* private data */
 static char modname[]	= "sdladrv";
 static char fullname[]	= "SDLA Support Module";
--- linux-2.4.0-test11/drivers/telephony/ixj.c	Wed Nov 15 00:41:03 2000
+++ linux/drivers/telephony/ixj.c	Thu Nov 23 04:01:50 2000
@@ -37,8 +37,8 @@
  *
  ***************************************************************************/
 
-static char ixj_c_rcsid[] = "$Id: ixj.c,v 3.31 2000/04/14 19:24:47 jaugenst Exp $";
-static char ixj_c_revision[] = "$Revision: 3.31 $";
+static char ixj_c_rcsid[] = "$Id$";
+static char ixj_c_revision[] = "$Revision$";
 
 //#define PERFMON_STATS
 #define IXJDEBUG 0
@@ -75,7 +75,7 @@
 #include <pcmcia/ds.h>
 #endif
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
 #include <linux/isapnp.h>
 #endif
 
@@ -90,6 +90,17 @@
 
 MODULE_PARM(ixjdebug, "i");
 
+static struct pci_device_id ixj_pci_tbl[] __initdata = {
+  {
+    vendor: 0x15E2,
+    device: 0x0500,
+    subvendor: PCI_ANY_ID,
+    subdevice: PCI_ANY_ID,
+  },
+  { }				/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, ixj_pci_tbl);
+
 static IXJ ixj[IXJMAX];
 
 static struct timer_list ixj_timer;
@@ -6107,7 +6118,7 @@
 			kfree(ixj[cnt].read_buffer);
 		if (ixj[cnt].write_buffer)
 			kfree(ixj[cnt].write_buffer);
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
 		if (ixj[cnt].dev)
 			ixj[cnt].dev->deactivate(ixj[cnt].dev);
 #endif
@@ -6229,7 +6240,7 @@
 	int i = 0;
 	int cnt = 0;
 	int probe = 0;
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
 	int func = 0x110;
 	struct pci_dev *dev = NULL, *old_dev = NULL;
 #endif
@@ -6247,7 +6258,7 @@
 	register_pcmcia_driver(&dev_info, &ixj_attach, &ixj_detach);
 	probe = 0;
 #else
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
 	while (1) {
 		do {
 			old_dev = dev;
--- linux-2.4.0-test11/drivers/video/aty128fb.c	Sun Sep 17 09:48:04 2000
+++ linux/drivers/video/aty128fb.c	Thu Nov 23 19:17:25 2000
@@ -144,6 +144,28 @@
 	rage_M3
 };
 
+#define PCITBL_ENTRY(dev) { \
+	vendor: PCI_VENDOR_ID_ATI, \
+	device: PCI_DEVICE_ID_ATI_ ## dev, \
+	subvendor: PCI_ANY_ID, \
+	subdevice: PCI_ANY_ID, \
+	class: PCI_BASE_CLASS_DISPLAY << 16, \
+	class_mask: 0xff0000, \
+}
+static struct pci_device_id aty128fb_pci_tbl[] __initdata = {
+	PCITBL_ENTRY( RAGE128_RE ),
+	PCITBL_ENTRY( RAGE128_RF ),
+	PCITBL_ENTRY( RAGE128_RK ),
+	PCITBL_ENTRY( RAGE128_RL ),
+	PCITBL_ENTRY( RAGE128_PF ),
+	PCITBL_ENTRY( RAGE128_PR ),
+	PCITBL_ENTRY( RAGE128_LE ),
+	PCITBL_ENTRY( RAGE128_LF ),
+	{ }			/* Terminating entry */
+};
+#undef PCITBL_ENTRY
+MODULE_DEVICE_TABLE(pci, aty128fb_pci_tbl);
+
 /* supported Rage128 chipsets */
 static const struct aty128_chip_info aty128_pci_probe_list[] __initdata =
 {
--- linux-2.4.0-test11/drivers/video/atyfb.c	Sun Sep 17 09:48:05 2000
+++ linux/drivers/video/atyfb.c	Thu Nov 23 19:13:28 2000
@@ -536,6 +536,49 @@
 #endif
 
 
+#define PCITBL_ENTRY(dev) { \
+	vendor: PCI_VENDOR_ID_ATI, \
+	device: dev, \
+	subvendor: PCI_ANY_ID, \
+	subdevice: PCI_ANY_ID, \
+	class: PCI_BASE_CLASS_DISPLAY << 16, \
+	class_mask: 0xff0000, \
+}
+static struct pci_device_id atyfb_pci_tbl[] __initdata = {
+	PCITBL_ENTRY( 0x4758 ),		/* mach64CT family */
+	PCITBL_ENTRY( 0x4358 ),
+
+	PCITBL_ENTRY( 0x4354 ),		/* mach64CT family */
+	PCITBL_ENTRY( 0x4554 ),
+
+	PCITBL_ENTRY( 0x5654 ),		/* mach64CT family / mach64VT class */
+	PCITBL_ENTRY( 0x5655 ),
+	PCITBL_ENTRY( 0x5656 ),
+
+	PCITBL_ENTRY( 0x4c42 ),/* mach64CT family / mach64GT (3D RAGE) class */
+	PCITBL_ENTRY( 0x4c44 ),
+	PCITBL_ENTRY( 0x4c47 ),
+	PCITBL_ENTRY( 0x4c49 ),
+	PCITBL_ENTRY( 0x4c50 ),
+	PCITBL_ENTRY( 0x4c54 ),
+	PCITBL_ENTRY( 0x4754 ),
+	PCITBL_ENTRY( 0x4755 ),
+	PCITBL_ENTRY( 0x4756 ),
+	PCITBL_ENTRY( 0x4757 ),
+	PCITBL_ENTRY( 0x475a ),
+	PCITBL_ENTRY( 0x4742 ),
+	PCITBL_ENTRY( 0x4744 ),
+	PCITBL_ENTRY( 0x4749 ),
+	PCITBL_ENTRY( 0x4750 ),
+	PCITBL_ENTRY( 0x4751 ),
+	PCITBL_ENTRY( 0x4c4d ),
+	PCITBL_ENTRY( 0x4c4e ),
+
+	{ }			/* Terminating entry */
+};
+#undef PCITBL_ENTRY
+MODULE_DEVICE_TABLE(pci, atyfb_pci_tbl);
+
 static struct aty_features {
     u16 pci_id;
     u16 chip_type;
--- linux-2.4.0-test11/drivers/video/clgenfb.c	Tue Nov  7 10:59:43 2000
+++ linux/drivers/video/clgenfb.c	Thu Nov 23 19:14:45 2000
@@ -262,6 +262,30 @@
 
 
 #ifdef CONFIG_PCI
+
+#define PCITBL_ENTRY(dev) { \
+	vendor: PCI_VENDOR_ID_CIRRUS, \
+	device: PCI_DEVICE_ID_CIRRUS_ ## dev, \
+	subvendor: PCI_ANY_ID, \
+	subdevice: PCI_ANY_ID, \
+	class: PCI_BASE_CLASS_DISPLAY << 16, \
+	class_mask: 0xff0000, \
+}
+static struct pci_device_id cglenfb_pci_tbl[] __initdata = {
+	PCITBL_ENTRY( 5436 ),	
+	PCITBL_ENTRY( 5434_8 ),	
+	PCITBL_ENTRY( 5434_4 ),	
+	PCITBL_ENTRY( 5430 ),	
+	PCITBL_ENTRY( 5480 ),	
+	PCITBL_ENTRY( 5446 ),	
+	PCITBL_ENTRY( 5462 ),	
+	PCITBL_ENTRY( 5464 ),	
+	PCITBL_ENTRY( 5465 ),	
+  { }			/* Terminating entry */
+};
+#undef PCITBL_ENTRY
+MODULE_DEVICE_TABLE(pci, cglenfb_pci_tbl);
+
 /* the list of PCI devices for which we probe, and the
  * order in which we do it */
 static const struct {
--- linux-2.4.0-test11/drivers/video/igafb.c	Wed Jul 26 11:08:41 2000
+++ linux/drivers/video/igafb.c	Thu Nov 23 18:55:18 2000
@@ -65,6 +65,27 @@
 static char igafb_name[16] = "IGA 1682";
 static char fontname[40] __initdata = { 0 };
 
+static struct pci_device_id igafb_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_INTERG,
+	  device: PCI_DEVICE_ID_INTERG_1682
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	  class: PCI_BASE_CLASS_DISPLAY << 16,
+	  class_mask: 0xff0000,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_INTERG,
+	  device: 0x2000,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	  class: PCI_BASE_CLASS_DISPLAY << 16,
+	  class_mask: 0xff0000,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, igafb_pci_tbl);
+
 struct pci_mmap_map {
     unsigned long voff;
     unsigned long poff;
--- linux-2.4.0-test11/drivers/video/imsttfb.c	Fri Aug  4 18:06:34 2000
+++ linux/drivers/video/imsttfb.c	Thu Nov 23 20:27:38 2000
@@ -47,6 +47,47 @@
 #include <video/fbcon-cfb24.h>
 #include <video/fbcon-cfb32.h>
 
+static struct pci_device_id imsttfb_pci_tbl[] __initdata = {
+   /* Apparently, this driver really does want to look at every PCI
+      display device made by IMS, rather than just device ID's
+      0x9128 and 0x9135.  Ryan Nielsen told me, "There is at least
+      one other device ID that is needed, it does not really support
+      0x9135, but it does support another card for which I do not
+      know the id of."  So, for now, we will use the more generic form.
+      Adam J. Richter, 2000 November 23.
+*/
+#if 0
+	{
+	  vendor: PCI_VENDOR_ID_IMS,
+	  device: 0x9128,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	  class: PCI_BASE_CLASS_DISPLAY << 16,
+	  class_mask: 0xff0000,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_IMS,
+	  device: 0x9135,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	  class: PCI_BASE_CLASS_DISPLAY << 16,
+	  class_mask: 0xff0000,
+	},
+#else
+	{
+	  vendor: PCI_VENDOR_ID_IMS,
+	  device: PCI_ANY_ID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	  class: PCI_BASE_CLASS_DISPLAY << 16,
+	  class_mask: 0xff0000,
+	},
+#endif
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, imsttfb_pci_tbl);
+
+
 #ifndef __powerpc__
 #define eieio()		/* Enforce In-order Execution of I/O */
 #endif
--- linux-2.4.0-test11/drivers/video/tdfxfb.c	Mon Jul 24 18:24:26 2000
+++ linux/drivers/video/tdfxfb.c	Thu Nov 23 18:44:08 2000
@@ -2002,6 +2002,26 @@
 	iounmap(fb_info.bufbase_virt);
 }
 
+static struct pci_device_id tdfxfb_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_3DFX,
+	  device: PCI_DEVICE_ID_3DFX_BANSHEE,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	  class: PCI_BASE_CLASS_DISPLAY << 16,
+	  class_mask: 0xff0000,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_3DFX,
+	  device: PCI_DEVICE_ID_3DFX_VOODOO3,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	  class: PCI_BASE_CLASS_DISPLAY << 16,
+	  class_mask: 0xff0000,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, tdfxfb_pci_tbl);
 MODULE_AUTHOR("Hannu Mallat <hmallat@cc.hut.fi>");
 MODULE_DESCRIPTION("3Dfx framebuffer device driver");
 
--- linux-2.4.0-test11/drivers/video/tgafb.c	Tue Nov  7 10:59:43 2000
+++ linux/drivers/video/tgafb.c	Thu Nov 23 19:05:28 2000
@@ -111,6 +111,18 @@
   0x00000001
 };
 
+static struct pci_device_id tgafb_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_DEC,
+	  device: PCI_DEVICE_ID_DEC_TGA,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	  class: PCI_BASE_CLASS_DISPLAY << 16,
+	  class_mask: 0xff0000,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, tgafb_pci_tbl);
 
     /*
      *  Predefined video modes

--PNTmBPCT7hxwcZjr--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
