Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265661AbUFSMba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUFSMba (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 08:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265685AbUFSMb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 08:31:29 -0400
Received: from mail.dif.dk ([193.138.115.101]:7905 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265661AbUFSMb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 08:31:28 -0400
Date: Sat, 19 Jun 2004 14:30:32 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
       James Simmons <jsimmons@infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Fix warning in tdfxfb.c (Was: Re: IA32 (2.6.7 - 2004-06-18.22.30)
 - 2 New warnings (gcc 3.2.2))
In-Reply-To: <200406191135.i5JBZsXL017823@cherrypit.pdx.osdl.net>
Message-ID: <Pine.LNX.4.56.0406191425340.18856@jjulnx.backbone.dif.dk>
References: <200406191135.i5JBZsXL017823@cherrypit.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, John Cherry wrote:

> drivers/video/tdfxfb.c:1104: warning: initialization discards qualifiers from pointer target type

Here's a patch for that.

The issue is that the mask member of struct fb_cursor is const, so
we shouldn't be assigning it to a non-const char*

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-orig/drivers/video/tdfxfb.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.7/drivers/video/tdfxfb.c	2004-06-19 14:25:16.000000000 +0200
@@ -1101,7 +1101,7 @@ static int tdfxfb_cursor(struct fb_info
 		 */
 		u8 *cursorbase = (u8 *) info->cursor.image.data;
 		char *bitmap = (char *)cursor->image.data;
-		char *mask = cursor->mask;
+		const char *mask = cursor->mask;
 		int i, j, k, h = 0;

 		for (i = 0; i < 64; i++) {


--
Jesper Juhl <juhl-lkml@dif.dk>

