Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTFVOGG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 10:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTFVOGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 10:06:06 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:41927 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261568AbTFVOGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 10:06:02 -0400
Subject: Re: [PATCH] 2.[45] eexpress.c skb_padto fixes broke pppoe
From: Shane Shrybman <shrybman@sympatico.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1056199563.25974.29.camel@dhcp22.swansea.linux.org.uk>
References: <1055975326.28012.13.camel@mars.goatskin.org>
	 <1056199563.25974.29.camel@dhcp22.swansea.linux.org.uk>
Content-Type: multipart/mixed; boundary="=-5/ulVcub0NJhJxq4zy/f"
Organization: 
Message-Id: <1056291600.2405.12.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Jun 2003 10:20:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5/ulVcub0NJhJxq4zy/f
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Sat, 2003-06-21 at 08:46, Alan Cox wrote:
[..SNIP..]
> 
> Cleaner is to set buf->len = ETH_ZLEN for the padto path IMHO, that
> keeps the old horrible length compute stuff dead
> 

Attached is a better patch that also removes a duplicate comment. I have
tested it on 2.4 but it applies to 2.5 as well (with offset).

Regards,

Shane

--=-5/ulVcub0NJhJxq4zy/f
Content-Disposition: attachment; filename=eexpress_skb_padto_fix3.diff
Content-Type: text/x-diff; name=eexpress_skb_padto_fix3.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.4.21aarc8A/drivers/net/eexpress.c.broken	Fri Jun 13 10:51:34 2003
+++ linux-2.4.21aarc8A/drivers/net/eexpress.c	Sat Jun 21 18:50:03 2003
@@ -654,7 +654,7 @@
 		buf = skb_padto(buf, ETH_ZLEN);
 		if(buf == NULL)
 			return 0;
-		length = buf->len;
+		length = ETH_ZLEN;
 	}
 
 	disable_irq(dev->irq);
@@ -682,13 +682,6 @@
 	enable_irq(dev->irq);
 	return 0;
 }
-
-/*
- * Handle an EtherExpress interrupt
- * If we've finished initializing, start the RU and CU up.
- * If we've already started, reap tx buffers, handle any received packets,
- * check to make sure we've not become wedged.
- */
 
 /*
  * Handle an EtherExpress interrupt

--=-5/ulVcub0NJhJxq4zy/f--

