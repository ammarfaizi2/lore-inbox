Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVAXOFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVAXOFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 09:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVAXOFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 09:05:41 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:14291 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261505AbVAXOFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 09:05:30 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 24 Jan 2005 14:57:17 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: v4l-saa7134-module compile error
Message-ID: <20050124135716.GA23702@bytesex>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124111713.GF3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124111713.GF3515@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 12:17:13PM +0100, Adrian Bunk wrote:
> On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> >...
> > +v4l-saa7134-module.patch
> 
> This patch broke compilation with CONFIG_MODULES=n:
> 
> drivers/media/video/saa7134/saa7134-core.c: In function `pending_call':
> drivers/media/video/saa7134/saa7134-core.c:234: error: `MODULE_STATE_LIVE' undeclared (first use in this function)

The patch below should fix this.

  Gerd

Index: linux-2.6.11-rc2/drivers/media/video/saa7134/saa7134-core.c
===================================================================
--- linux-2.6.11-rc2.orig/drivers/media/video/saa7134/saa7134-core.c	2005-01-24 11:05:45.000000000 +0100
+++ linux-2.6.11-rc2/drivers/media/video/saa7134/saa7134-core.c	2005-01-24 14:54:29.000000000 +0100
@@ -21,6 +21,7 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -225,6 +226,8 @@ static void dump_statusregs(struct saa71
 /* ----------------------------------------------------------- */
 /* delayed request_module                                      */
 
+#ifdef CONFIG_MODULES
+
 static int need_empress;
 static int need_dvb;
 
@@ -265,6 +268,12 @@ static void request_module_depend(char *
 	}
 }
 
+#else
+
+static inline void request_module_depend(char *name, int *flag) {}
+
+#endif /* CONFIG_MODULES */
+
 /* ------------------------------------------------------------------ */
 
 /* nr of (saa7134-)pages for the given buffer size */
