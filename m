Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbVCWJIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbVCWJIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVCWJIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:08:41 -0500
Received: from smtp17.wxs.nl ([195.121.6.13]:32194 "EHLO smtp17.wxs.nl")
	by vger.kernel.org with ESMTP id S262895AbVCWJHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:07:49 -0500
Date: Wed, 23 Mar 2005 10:07:38 +0100
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: [PATCH] Re: drivers/media/video/bt819.c: bt819_init: wrong array
	indexing
In-reply-to: <20050323003808.GX1948@stusta.de>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <1111568857.547.37.camel@tux.lan>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: multipart/mixed; boundary="Boundary_(ID_qtIhZXNvNAuq7di3Z6QsOQ)"
References: <20050323003808.GX1948@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_qtIhZXNvNAuq7di3Z6QsOQ)
Content-type: text/plain
Content-transfer-encoding: 7BIT

On Wed, 2005-03-23 at 01:38, Adrian Bunk wrote:
> The Coverity checker found the following bug in array indexing in the 
> function bt819_init in drivers/media/video/bt819.c:
> 
>         init[0x19*2-1] = decoder->norm == 0 ? 115 : 93;
> 
> I don't know whether the other array indexes in this function are 
> correct, but this is definitely wrong:
> It indexes element 49 wile only the elements 0-43 are available.

Auch, that is kinda embarrassing... Attached patch fixes it. Andrew, can
you please put this patch in the kernel?

Signed-off-by: Ronald S. Bultje <rbultje@ronald.bitfreak.net>

Ronald

-- 
Ronald S. Bultje <rbultje@ronald.bitfreak.net>

--Boundary_(ID_qtIhZXNvNAuq7di3Z6QsOQ)
Content-type: text/x-patch; name=d; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=d

Index: bt819.c
===================================================================
RCS file: /cvsroot/mjpeg/driver-zoran/bt819.c,v
retrieving revision 1.6
diff -u -r1.6 bt819.c
--- bt819.c	16 Sep 2004 22:53:26 -0000	1.6
+++ bt819.c	23 Mar 2005 09:04:52 -0000
@@ -239,7 +239,8 @@
 	init[0x07 * 2 - 1] = timing->hactive & 0xff;
 	init[0x08 * 2 - 1] = timing->hscale >> 8;
 	init[0x09 * 2 - 1] = timing->hscale & 0xff;
-	init[0x19*2-1] = decoder->norm == 0 ? 115 : 93;	/* Chroma burst delay */
+	/* 0x15 in array is address 0x19 */
+	init[0x15 * 2 - 1] = (decoder->norm == 0) ? 115 : 93;	/* Chroma burst delay */
 	/* reset */
 	bt819_write(client, 0x1f, 0x00);
 	mdelay(1);

--Boundary_(ID_qtIhZXNvNAuq7di3Z6QsOQ)--
