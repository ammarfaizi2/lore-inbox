Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpKgHaHa/0SaDQniH+lqpybHdCg==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 06:11:22 +0000
Message-ID: <02ba01c415a4$a8075850$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
From: "Dmitry Torokhov" <dtor_core@ameritech.net>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@osdl.org>
Subject: Re: [PATCH 3/3] Convert tsdev to use module_param
Date: Mon, 29 Mar 2004 16:44:01 +0100
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
References: <200401030350.43437.dtor_core@ameritech.net> <200401050101.20789.dtor_core@ameritech.net> <200401050102.49892.dtor_core@ameritech.net>
In-Reply-To: <200401050102.49892.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:44:01.0234 (UTC) FILETIME=[A81A6B20:01C415A4]

===================================================================


ChangeSet@1.1582, 2004-01-05 00:36:03-05:00, dtor_core@ameritech.net
  Input: convert tsdev to the new way of handling parameters
         and document them in kernel-parameters.txt


 Documentation/kernel-parameters.txt |    6 +++++-
 drivers/input/tsdev.c               |   23 +++++++++++++----------
 2 files changed, 18 insertions(+), 11 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Mon Jan  5 00:46:48 2004
+++ b/Documentation/kernel-parameters.txt	Mon Jan  5 00:46:48 2004
@@ -37,7 +37,7 @@
 	MCA	MCA bus support is enabled.
 	MDA	MDA console support is enabled.
 	MOUSE	Appropriate mouse support is enabled.
-	MTD	MTD support is nebaled.
+	MTD	MTD support is enabled.
 	NET	Appropriate network support is enabled.
 	NFS	Appropriate NFS support is enabled.
 	OSS	OSS sound support is enabled.
@@ -57,6 +57,7 @@
 	SMP	The kernel is an SMP kernel.
 	SPARC	Sparc architecture is enabled.
 	SWSUSP	Software suspension is enabled.
+	TS	Appropriate touchscreen support is enabled.
 	USB	USB support is enabled.
 	V4L	Video For Linux support is enabled.
 	VGA	The VGA console has been enabled.
@@ -1135,6 +1136,9 @@
 	trix=		[HW,OSS] MediaTrix AudioTrix Pro
 			Format: <io>,<irq>,<dma>,<dma2>,<sb_io>,<sb_irq>,<sb_dma>,<mpu_io>,<mpu_irq>
  
+	tsdev.xres	[TS] Horizontal screen resolution.
+	tsdev.yres	[TS] Vertical screen resolution.
+
 	u14-34f=	[HW,SCSI] UltraStor 14F/34F SCSI host adapter
 			See header of drivers/scsi/u14-34f.c.
 
diff -Nru a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c	Mon Jan  5 00:46:48 2004
+++ b/drivers/input/tsdev.c	Mon Jan  5 00:46:48 2004
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/major.h>
@@ -51,6 +52,18 @@
 #define CONFIG_INPUT_TSDEV_SCREEN_Y	320
 #endif
 
+MODULE_AUTHOR("James Simmons <jsimmons@transvirtual.com>");
+MODULE_DESCRIPTION("Input driver to touchscreen converter");
+MODULE_LICENSE("GPL");
+
+static int xres = CONFIG_INPUT_TSDEV_SCREEN_X;
+module_param(xres, uint, 0);
+MODULE_PARM_DESC(xres, "Horizontal screen resolution");
+
+static int yres = CONFIG_INPUT_TSDEV_SCREEN_Y;
+module_param(yres, uint, 0);
+MODULE_PARM_DESC(yres, "Vertical screen resolution");
+
 struct tsdev {
 	int exist;
 	int open;
@@ -82,9 +95,6 @@
 
 static struct tsdev *tsdev_table[TSDEV_MINORS];
 
-static int xres = CONFIG_INPUT_TSDEV_SCREEN_X;
-static int yres = CONFIG_INPUT_TSDEV_SCREEN_Y;
-
 static int tsdev_fasync(int fd, struct file *file, int on)
 {
 	struct tsdev_list *list = file->private_data;
@@ -394,10 +404,3 @@
 
 module_init(tsdev_init);
 module_exit(tsdev_exit);
-
-MODULE_AUTHOR("James Simmons <jsimmons@transvirtual.com>");
-MODULE_DESCRIPTION("Input driver to touchscreen converter");
-MODULE_PARM(xres, "i");
-MODULE_PARM_DESC(xres, "Horizontal screen resolution");
-MODULE_PARM(yres, "i");
-MODULE_PARM_DESC(yres, "Vertical screen resolution");
