Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271116AbTHQWuM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 18:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271119AbTHQWuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 18:50:12 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:59010 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S271116AbTHQWuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 18:50:07 -0400
Date: Mon, 18 Aug 2003 00:49:54 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@osdl.org
Cc: greg@kroah.com, petri.koistinen@iki.fi, linux-kernel@vger.kernel.org
Subject: [PATCH] Recent i2c changes broke matroxfb
Message-ID: <20030817224954.GC596@vana.vc.cvut.cz>
References: <Pine.LNX.4.56.0308172137300.27362@dsl-hkigw4a35.dial.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0308172137300.27362@dsl-hkigw4a35.dial.inet.fi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

   Name member of i2c clients & adapters moved again back to the
i2c_* from generic device. Please apply following patch. Thanks to Petri
Koistinen for bringing this to my attention.
						Thanks,
							Petr Vandrovec

diff -urdN linux/drivers/video/matrox/i2c-matroxfb.c linux/drivers/video/matrox/i2c-matroxfb.c
--- linux/drivers/video/matrox/i2c-matroxfb.c	2003-08-17 23:32:54.000000000 +0200
+++ linux/drivers/video/matrox/i2c-matroxfb.c	2003-08-18 00:33:31.000000000 +0200
@@ -111,7 +111,7 @@
 	b->mask.data = data;
 	b->mask.clock = clock;
 	b->adapter = matrox_i2c_adapter_template;
-	snprintf(b->adapter.dev.name, DEVICE_NAME_SIZE, name,
+	snprintf(b->adapter.name, DEVICE_NAME_SIZE, name,
 		minfo->fbcon.node);
 	i2c_set_adapdata(&b->adapter, b);
 	b->adapter.algo_data = &b->bac;
diff -urdN linux/drivers/video/matrox/matroxfb_maven.c linux/drivers/video/matrox/matroxfb_maven.c
--- linux/drivers/video/matrox/matroxfb_maven.c	2003-08-17 23:32:04.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_maven.c	2003-08-18 00:34:29.000000000 +0200
@@ -1255,7 +1255,7 @@
 	new_client->adapter = adapter;
 	new_client->driver = &maven_driver;
 	new_client->flags = 0;
-	strcpy(new_client->dev.name, "maven client");
+	strcpy(new_client->name, "maven client");
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR3;
 	err = maven_init_client(new_client);
