Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265641AbRGJUer>; Tue, 10 Jul 2001 16:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267027AbRGJUeh>; Tue, 10 Jul 2001 16:34:37 -0400
Received: from L0173P30.dipool.highway.telekom.at ([62.46.85.158]:36779 "EHLO
	mannix") by vger.kernel.org with ESMTP id <S265641AbRGJUed>;
	Tue, 10 Jul 2001 16:34:33 -0400
Date: Tue, 10 Jul 2001 22:38:51 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: es1370/1371 compilation clash
Message-ID: <20010710223851.A11984@aon.at>
In-Reply-To: <994759043.3b4ad183f0364@extranet.jtrix.com> <20010710222319.A8588@aon.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010710222319.A8588@aon.at>
User-Agent: Mutt/1.3.18i
From: Alexander Griesser <tuxx@aon.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jul 10, 2001 at 10:23:19PM +0200, you wrote:
I'm sorry, there were 2 illegal characters in this patch (whereever they
have come from *stunning*).

This is the "fixed" one ;)
It is also available from:

http://www.tuxx-home.at/kernel-patches/

regards, alexx
-- 
|    .-.    |   CCNAIA Alexander Griesser <tuxx@aon.at>  |   .''`.  |
|    /v\    |  http://www.tuxx-home.at -=- ICQ:63180135  |  : :' :  |
|  /(   )\  |    echo "K..?f{1,2}e[nr]böck" >>~/.score   |  `. `'   |
|   ^^ ^^   |    Linux Version 2.4.6 - Debian Unstable   |    `-    |

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="es137x-2.4.6-ac2.diff"

--- linux/drivers/sound/es1371.c.orig	Tue Jul 10 22:16:15 2001
+++ linux/drivers/sound/es1371.c	Tue Jul 10 22:18:33 2001
@@ -135,7 +135,18 @@
 #include <asm/dma.h>
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
+
+/* ESS1370 and ESS1371 conflict, when both are to be comopiled */
+/* This is a small workaround for this problem                 */
+/*   by Alexander Griesser <tuxx@aon.at>                       */
+#ifdef CONFIG_SOUND_ES1370
+  #define ESS137X_CONFLICT 1
+#endif
+
 #include <linux/gameport.h>
+
+extern void gameport_register_port(struct gameport *gameport);
+extern void gameport_unregister_port(struct gameport *gameport);
 
 /* --------------------------------------------------------------------- */
 
--- linux/include/linux/gameport.h.orig	Tue Jul 10 22:16:19 2001
+++ linux/include/linux/gameport.h	Tue Jul 10 22:21:25 2001
@@ -66,6 +66,8 @@
 	struct gameport_dev *next;
 };
 
+#ifndef ESS137X_CONFLICT
+
 int gameport_open(struct gameport *gameport, struct gameport_dev *dev, int mode);
 void gameport_close(struct gameport *gameport);
 void gameport_rescan(struct gameport *gameport);
@@ -137,5 +139,7 @@
 	current->state = TASK_UNINTERRUPTIBLE;
 	schedule_timeout(1 + ms * HZ / 1000);
 }
+
+#endif
 
 #endif

--k+w/mQv8wyuph6w0--
