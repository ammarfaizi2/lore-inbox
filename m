Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVFTLip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFTLip (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 07:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVFTLio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 07:38:44 -0400
Received: from smtp06.auna.com ([62.81.186.16]:7097 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261206AbVFTLgn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 07:36:43 -0400
Date: Mon, 20 Jun 2005 11:36:41 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: [PATCH] bttv fix [was: 2.6.12-mm1]
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel Lista <linux-kernel@vger.kernel.org>
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org> (from akpm@osdl.org on
	Mon Jun 20 08:30:29 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119267401l.17554l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Mon, 20 Jun 2005 13:36:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.20, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/
> 
> 
> - Someone broke /proc/device-tree on ppc64.  It's being looked into.
> 
> - Nothing particularly special here - various fixes and updates.
> 

And a small breakage ;).
struct bttv defined after usage. Fix below:

--- linux-2.6.12-jam1/drivers/media/video/bttvp.h.orig	2005-06-20 10:00:24.000000000 +0200
+++ linux-2.6.12-jam1/drivers/media/video/bttvp.h	2005-06-20 10:00:59.000000000 +0200
@@ -226,11 +226,6 @@
 #define dprintk  if (bttv_debug >= 1) printk
 #define d2printk if (bttv_debug >= 2) printk
 
-/* our devices */
-#define BTTV_MAX 16
-extern unsigned int bttv_num;
-extern struct bttv bttvs[BTTV_MAX];
-
 #define BTTV_MAX_FBUF   0x208000
 #define VBIBUF_SIZE     (2048*VBI_MAXLINES*2)
 #define BTTV_TIMEOUT    (HZ/2) /* 0.5 seconds */
@@ -377,6 +372,11 @@
 	struct bttv_fh init;
 };
 
+/* our devices */
+#define BTTV_MAX 16
+extern unsigned int bttv_num;
+extern struct bttv bttvs[BTTV_MAX];
+
 /* private ioctls */
 #define BTTV_VERSION            _IOR('v' , BASE_VIDIOCPRIVATE+6, int)
 #define BTTV_VBISIZE            _IOR('v' , BASE_VIDIOCPRIVATE+8, int)


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam1 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


