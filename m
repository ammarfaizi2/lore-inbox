Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132348AbRADBYM>; Wed, 3 Jan 2001 20:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132296AbRADBYB>; Wed, 3 Jan 2001 20:24:01 -0500
Received: from zeus.kernel.org ([209.10.41.242]:15631 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132312AbRADBXn>;
	Wed, 3 Jan 2001 20:23:43 -0500
Date: Wed, 3 Jan 2001 18:09:18 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: fritz@isdn4linux.de, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] isdn_net: release resources on failure
Message-ID: <20010103180917.I4328@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	fritz@isdn4linux.de, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply.

                        - Arnaldo

--- linux-2.4.0-prerelease/drivers/isdn/isdn_net.c	Mon Jan  1 14:42:26 2001
+++ linux-2.4.0-prerelease.acme/drivers/isdn/isdn_net.c	Wed Jan  3 18:02:44 2001
@@ -19,7 +19,10 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
+ * 
+ * Changes:
+ * Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ * - release resources on failure in isdn_net_new - 2001/01/03
  */
 
 #include <linux/config.h>
@@ -2325,6 +2328,7 @@
 	memset(netdev, 0, sizeof(isdn_net_dev));
 	if (!(netdev->local = (isdn_net_local *) kmalloc(sizeof(isdn_net_local), GFP_KERNEL))) {
 		printk(KERN_WARNING "isdn_net: Could not allocate device locals\n");
+		kfree(netdev);
 		return NULL;
 	}
 	memset(netdev->local, 0, sizeof(isdn_net_local));
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
