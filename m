Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVANS6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVANS6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVANS5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:57:38 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:24739 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261385AbVANSzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:55:39 -0500
Date: Fri, 14 Jan 2005 19:55:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 5/8] s390: remove irq_exit from iucv.
Message-ID: <20050114185538.GE6789@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/8] s390: remove irq_exit from iucv.

From: Ursula Braun-Krahl <braunu@de.ibm.com>

Remove the irq_exit call on error path in iucv_irq_handler.
irq_exit is done in do_extint().

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/iucv.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-patched/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	2004-12-24 22:33:52.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/iucv.c	2005-01-14 19:45:19.000000000 +0100
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.41 2004/08/11 14:54:14 geraldsc Exp $
+ * $Id: iucv.c,v 1.42 2005/01/07 10:49:54 braunu Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.41 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.42 $
  *
  */
 
@@ -355,7 +355,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.41 $";
+	char vbuf[] = "$Revision: 1.42 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -2285,7 +2285,6 @@
 	irqdata = kmalloc(sizeof(iucv_irqdata), GFP_ATOMIC);
 	if (!irqdata) {
 		printk(KERN_WARNING "%s: out of memory\n", __FUNCTION__);
-		irq_exit();
 		return;
 	}
 
