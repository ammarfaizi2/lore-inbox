Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263072AbVAFXkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbVAFXkw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVAFXkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:40:45 -0500
Received: from mail.dif.dk ([193.138.115.101]:700 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S263072AbVAFXhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:37:55 -0500
Date: Fri, 7 Jan 2005 00:49:22 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-tape@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] ftape: shut up gcc - warning about possibly uninitialized
 var in drivers/char/ftape/lowlevel/ftape-io.c
Message-ID: <Pine.LNX.4.61.0501070043400.3430@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tiny patch whose only purpose in life is to shut up gcc below 
(initializing flags to zero serves no real purpose in this function, so 
this really is just a 'shut up gcc' patch) : 

This is the warning it will elliminate : 
drivers/char/ftape/lowlevel/ftape-io.c:93: warning: 'flags' might be used uninitialized in this function

Apply if you want, if you don't that's just fine too :)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk9-orig/drivers/char/ftape/lowlevel/ftape-format.c linux-2.6.10-bk9/drivers/char/ftape/lowlevel/ftape-format.c
--- linux-2.6.10-bk9-orig/drivers/char/ftape/lowlevel/ftape-format.c	2004-12-24 22:34:45.000000000 +0100
+++ linux-2.6.10-bk9/drivers/char/ftape/lowlevel/ftape-format.c	2005-01-07 00:43:22.000000000 +0100
@@ -91,7 +91,7 @@ static void setup_format_buffer(buffer_s
  */
 int ftape_format_track(const unsigned int track, const __u8 gap3)
 {
-	unsigned long flags;
+	unsigned long flags = 0;
 	buffer_struct *tail, *head;
 	int status;
 	TRACE_FUN(ft_t_flow);


