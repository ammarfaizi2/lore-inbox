Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932763AbWHOAkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbWHOAkt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWHOAkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:40:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56327 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932762AbWHOAks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:40:48 -0400
Date: Tue, 15 Aug 2006 02:40:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: proski@gnu.org, hermes@gibson.dropbear.id.au
Cc: orinoco-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, linville@tuxdriver.com, jgarzik@pobox.com
Subject: [2.6 patch] orinoco.h: "extern inline" -> "static __always_inline"
Message-ID: <20060815004046.GC3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" generates a warning with -Wmissing-prototypes and I'm 
currently working on getting the kernel cleaned up for adding this to 
the CFLAGS since it will help us to avoid a nasty class of runtime 
errors.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/orinoco.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.18-rc4-mm1/drivers/net/wireless/orinoco.h.old	2006-08-13 23:14:05.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/net/wireless/orinoco.h	2006-08-13 23:14:39.000000000 +0200
@@ -138,8 +138,8 @@
  * SPARC, due to its weird semantics for save/restore flags. extern
  * inline should prevent the kernel from linking or module from
  * loading if they are not inlined. */
-extern inline int orinoco_lock(struct orinoco_private *priv,
-			       unsigned long *flags)
+static __always_inline int orinoco_lock(struct orinoco_private *priv,
+					unsigned long *flags)
 {
 	spin_lock_irqsave(&priv->lock, *flags);
 	if (priv->hw_unavailable) {
@@ -151,8 +151,8 @@
 	return 0;
 }
 
-extern inline void orinoco_unlock(struct orinoco_private *priv,
-				  unsigned long *flags)
+static __always_inline void orinoco_unlock(struct orinoco_private *priv,
+					   unsigned long *flags)
 {
 	spin_unlock_irqrestore(&priv->lock, *flags);
 }

