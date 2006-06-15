Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWFOL05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWFOL05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWFOL05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:26:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40124 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030232AbWFOL04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:26:56 -0400
Date: Thu, 15 Jun 2006 12:26:55 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] kill open-coded offsetof in cm4000_cs.c ZERO_DEV()
Message-ID: <20060615112655.GM27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... to make sure that it doesn't break again when a field changes (see
"[PATCH] pcmcia: fix zeroing of cm4000_cs.c data" for recent example).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/char/pcmcia/cm4000_cs.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

e9defe1ea51dd92069e68d3b32ac55ca73b06b53
diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index eab5394..31c8a21 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -149,12 +149,7 @@ struct cm4000_dev {
 #define	ZERO_DEV(dev)  						\
 	memset(&dev->atr_csum,0,				\
 		sizeof(struct cm4000_dev) - 			\
-		/*link*/ sizeof(struct pcmcia_device *) - 	\
-		/*node*/ sizeof(dev_node_t) - 			\
-		/*atr*/ MAX_ATR*sizeof(char) - 			\
-		/*rbuf*/ 512*sizeof(char) - 			\
-		/*sbuf*/ 512*sizeof(char) - 			\
-		/*queue*/ 4*sizeof(wait_queue_head_t))
+		offsetof(struct cm4000_dev, atr_csum))
 
 static struct pcmcia_device *dev_table[CM4000_MAX_DEV];
 static struct class *cmm_class;
-- 
1.3.GIT

