Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbTCGQSD>; Fri, 7 Mar 2003 11:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261652AbTCGQSD>; Fri, 7 Mar 2003 11:18:03 -0500
Received: from angband.namesys.com ([212.16.7.85]:28804 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261651AbTCGQRt>; Fri, 7 Mar 2003 11:17:49 -0500
Date: Fri, 7 Mar 2003 19:28:18 +0300
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [2.5] memleak in drivers/char/vt.c
Message-ID: <20030307192818.L7347@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Seems there is a memleak on error exit path in drivers/char/vt.c in current bk,
   here's the patch. Found with help of smatch + enhanced unfree script.


===== drivers/char/vt.c 1.34 vs edited =====
--- 1.34/drivers/char/vt.c	Fri Mar  7 08:27:16 2003
+++ edited/drivers/char/vt.c	Fri Mar  7 19:25:45 2003
@@ -747,8 +747,10 @@
 	screenbuf_size = new_screen_size;
 
 	err = resize_screen(currcons, new_cols, new_rows);
-	if (err)
+	if (err) {
+		kfree(newscreen);
 		return err;
+	}
 
 	rlth = min(old_row_size, new_row_size);
 	rrem = new_row_size - rlth;

Bye,
    Oleg
