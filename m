Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVAYKUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVAYKUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 05:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVAYKUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 05:20:40 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:6365 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261874AbVAYKUc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 05:20:32 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 25 Jan 2005 11:15:09 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: v4l-saa7134-module compile error
Message-ID: <20050125101508.GB1060@bytesex>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124111713.GF3515@stusta.de> <20050124135716.GA23702@bytesex> <20050124174559.GJ3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124174559.GJ3515@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The patch below should fix this.
> 
> Not completely:

>   CC      drivers/media/video/saa7134/saa7134-core.o
> drivers/media/video/saa7134/saa7134-core.c: In function `saa7134_initdev':
> drivers/media/video/saa7134/saa7134-core.c:997: error: `need_empress' undeclared (first use in this function)

New version, this time using a #define, which should kill the reference
to need_* as well ...

  Gerd

Index: linux-2005-01-23/drivers/media/video/saa7134/saa7134-core.c
===================================================================
--- linux-2005-01-23.orig/drivers/media/video/saa7134/saa7134-core.c	2005-01-24 18:43:20.000000000 +0100
+++ linux-2005-01-23/drivers/media/video/saa7134/saa7134-core.c	2005-01-25 10:04:17.000000000 +0100
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
+#define request_module_depend(name,flag)
+
+#endif /* CONFIG_MODULES */
+
 /* ------------------------------------------------------------------ */
 
 /* nr of (saa7134-)pages for the given buffer size */
