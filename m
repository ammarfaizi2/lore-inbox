Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbTH2RRl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbTH2RMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:12:18 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:61375 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261469AbTH2RKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:10:07 -0400
Date: Fri, 29 Aug 2003 19:09:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (4/8): module_param.
Message-ID: <20030829170937.GE1242@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use new-style module_param.

diffstat:
 drivers/s390/block/xpram.c   |    4 +++-
 drivers/s390/char/sclp_cpi.c |    5 +++--
 drivers/s390/net/iucv.c      |    9 +++++----
 drivers/s390/net/qeth.c      |    5 +++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff -urN linux-2.6/drivers/s390/block/xpram.c linux-2.6-s390/drivers/s390/block/xpram.c
--- linux-2.6/drivers/s390/block/xpram.c	Sat Aug 23 01:58:10 2003
+++ linux-2.6-s390/drivers/s390/block/xpram.c	Fri Aug 29 18:55:09 2003
@@ -26,11 +26,13 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/version.h>
 #include <linux/ctype.h>  /* isdigit, isxdigit */
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
 #include <linux/sysdev.h>
@@ -74,7 +76,7 @@
 static int devs = XPRAM_DEVS;
 static unsigned long sizes[XPRAM_MAX_DEVS];
 
-MODULE_PARM(devs,"i");
+module_param(devs, int, 0);
 MODULE_PARM(sizes,"1-" __MODULE_STRING(XPRAM_MAX_DEVS) "i"); 
 
 MODULE_PARM_DESC(devs, "number of devices (\"partitions\"), " \
diff -urN linux-2.6/drivers/s390/char/sclp_cpi.c linux-2.6-s390/drivers/s390/char/sclp_cpi.c
--- linux-2.6/drivers/s390/char/sclp_cpi.c	Sat Aug 23 01:56:22 2003
+++ linux-2.6-s390/drivers/s390/char/sclp_cpi.c	Fri Aug 29 18:55:09 2003
@@ -9,6 +9,7 @@
 #include <linux/version.h>
 #include <linux/kmod.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/timer.h>
 #include <linux/string.h>
@@ -58,12 +59,12 @@
 	"or zSeries hardware");
 
 static char *system_name = NULL;
-MODULE_PARM(system_name, "s");
+module_param(system_name, charp, 0);
 MODULE_PARM_DESC(system_name, "e.g. hostname - max. 8 characters");
 
 static char *sysplex_name = NULL;
 #ifdef ALLOW_SYSPLEX_NAME
-MODULE_PARM(sysplex_name, "s");
+module_param(sysplex_name, charp, 0);
 MODULE_PARM_DESC(sysplex_name, "if applicable - max. 8 characters");
 #endif
 
diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-s390/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	Sat Aug 23 01:51:45 2003
+++ linux-2.6-s390/drivers/s390/net/iucv.c	Fri Aug 29 18:55:09 2003
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.11 2003/04/15 16:45:37 aberg Exp $
+ * $Id: iucv.c,v 1.12 2003/07/31 15:11:13 cohuck Exp $
  *
  * IUCV network driver
  *
@@ -29,11 +29,12 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.11 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.12 $
  *
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/config.h>
 
 #include <linux/spinlock.h>
@@ -283,7 +284,7 @@
 #ifdef DEBUG
 static int debuglevel = 0;
 
-MODULE_PARM(debuglevel, "i");
+module_param(debuglevel, int, 0);
 MODULE_PARM_DESC(debuglevel,
  "Specifies the debug level (0=off ... 3=all)");
 
@@ -332,7 +333,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.11 $";
+	char vbuf[] = "$Revision: 1.12 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
diff -urN linux-2.6/drivers/s390/net/qeth.c linux-2.6-s390/drivers/s390/net/qeth.c
--- linux-2.6/drivers/s390/net/qeth.c	Sat Aug 23 02:03:19 2003
+++ linux-2.6-s390/drivers/s390/net/qeth.c	Fri Aug 29 18:55:09 2003
@@ -106,6 +106,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 
 #include <linux/string.h>
 #include <linux/errno.h>
@@ -160,12 +161,12 @@
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 static int qeth_sparebufs = 0;
-MODULE_PARM(qeth_sparebufs, "i");
+module_param(qeth_sparebufs, int, 0);
 MODULE_PARM_DESC(qeth_sparebufs, "the number of pre-allocated spare buffers "
 		 "reserved for low memory situations");
 
 /****************** MODULE STUFF **********************************/
-#define VERSION_QETH_C "$Revision: 1.126 $"
+#define VERSION_QETH_C "$Revision: 1.139 $"
 static const char *version = "qeth S/390 OSA-Express driver ("
     VERSION_QETH_C "/" VERSION_QETH_H "/" VERSION_QETH_MPC_H
     QETH_VERSION_IPV6 QETH_VERSION_VLAN ")";
