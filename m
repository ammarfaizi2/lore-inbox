Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTDIIfm (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 04:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbTDIIfm (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 04:35:42 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:59069 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S262914AbTDIIfl (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 04:35:41 -0400
Date: Wed, 9 Apr 2003 10:47:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] z2ram fix (was: Re: Linux 2.5.67)
In-Reply-To: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0304091044230.21742-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Apr 2003, Linus Torvalds wrote:
> Jens Axboe:
>   o kill blk_queue_empty()

This change contained a typo, here's a fix:

--- linux-2.5.x/drivers/block/z2ram.c	Tue Apr  8 10:05:00 2003
+++ linux-m68k-2.5.x/drivers/block/z2ram.c	Tue Apr  8 14:16:49 2003
@@ -74,7 +74,7 @@
 static void do_z2_request(request_queue_t *q)
 {
 	struct request *req;
-	while ((req = elv_next_request) != NULL) {
+	while ((req = elv_next_request(q)) != NULL) {
 		unsigned long start = req->sector << 9;
 		unsigned long len  = req->current_nr_sectors << 9;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



