Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263978AbTJFJ2V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbTJFJ2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:28:08 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:10718 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263978AbTJFJ1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:27:41 -0400
Date: Mon, 6 Oct 2003 11:26:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (5/7): iucv driver.
Message-ID: <20031006092656.GA1845@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Add dummy release function to iucv bus.

diffstat:
 drivers/s390/net/iucv.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-s390/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	Sun Sep 28 02:50:09 2003
+++ linux-2.6-s390/drivers/s390/net/iucv.c	Mon Oct  6 10:59:27 2003
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.14 2003/09/23 16:48:17 mschwide Exp $
+ * $Id: iucv.c,v 1.15 2003/10/01 09:25:15 mschwide Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.14 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.15 $
  *
  */
 
@@ -79,6 +79,11 @@
 	return 0;
 }
 
+static void
+iucv_root_release (struct device *dev)
+{
+}
+
 struct bus_type iucv_bus = {
 	.name = "iucv",
 	.match = iucv_bus_match,
@@ -86,6 +91,7 @@
 
 struct device iucv_root = {
 	.bus_id = "iucv",
+	.release = iucv_root_release,
 };
 
 /* General IUCV interrupt structure */
@@ -349,7 +355,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.14 $";
+	char vbuf[] = "$Revision: 1.15 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
