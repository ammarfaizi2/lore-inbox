Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVGQSZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVGQSZo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 14:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVGQSZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 14:25:44 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:13842 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261337AbVGQSZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 14:25:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=q07ILUE9cyjNuxXexDE/kaUnxpwIMquAjGv5buemxQZVGyfG4WiQ8RUJDfqqjTvu5W5WTkJhLlOzrRVsYd8yfIgf9NRfq/LOziEiBAxQRZd3+K7OwDjcr+7NvjV/4H2qUk1BxS9/gxQYMe4sawGf+dj7vvgCBA/jpkKmB7lH+wQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add NULL short circuit to fb_dealloc_cmap()
Date: Sun, 17 Jul 2005 20:43:41 +0200
User-Agent: KMail/1.8.1
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Geert Uytterhoeven <geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507172043.41473.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resource freeing functions should generally be safe to call with NULL pointers.
Why?
 - there is some precedence in the kernel for this for deallocation functions.
 - removes the need for callers to check pointers for NULL.
 - space is saved overall by less code to test pointers for NULL all over the place.
 - removes possible NULL pointer dereferences when a caller forgot to check.

This patch makes  fb_dealloc_cmap()  safe to call with a NULL pointer argument.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/video/fbcmap.c |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2.6.13-rc3-orig/drivers/video/fbcmap.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc3/drivers/video/fbcmap.c	2005-07-17 20:33:43.000000000 +0200
@@ -130,6 +130,9 @@ fail:
 
 void fb_dealloc_cmap(struct fb_cmap *cmap)
 {
+	if (unlikely(!cmap))
+		return;
+
 	kfree(cmap->red);
 	kfree(cmap->green);
 	kfree(cmap->blue);


