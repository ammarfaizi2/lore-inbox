Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269869AbUIDKV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269869AbUIDKV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269871AbUIDKV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:21:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27336 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269869AbUIDKVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:21:23 -0400
Date: Sat, 4 Sep 2004 12:21:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Maximilian Attems <janitor@sternwelten.at>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.9-rc1-mm3: char/riscom8.c doesn't compile
Message-ID: <20040904102116.GM28499@fs.tum.de>
References: <20040903014811.6247d47d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903014811.6247d47d.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 01:48:11AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.9-rc1-mm2:
>...
> +drivers-char-riscom8c-min-max-removal.patch
>...
>  Janitorial things
>...

Doesn't compile:

<--  snip  -->

...
  CC      drivers/char/riscom8.o
drivers/char/riscom8.c:1178: macro `min_t' used with only 2 args
...
make[2]: *** [drivers/char/riscom8.o] Error 1

<--  snip  -->


Trivial fix:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm3-full/drivers/char/riscom8.c.old	2004-09-04 11:36:08.000000000 +0200
+++ linux-2.6.9-rc1-mm3-full/drivers/char/riscom8.c	2004-09-04 11:36:57.000000000 +0200
@@ -1174,7 +1174,7 @@
 			}
 
 			cli();
-			c = min_t(c, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
+			c = min_t(int, c, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 					 SERIAL_XMIT_SIZE - port->xmit_head));
 			memcpy(port->xmit_buf + port->xmit_head, tmp_buf, c);
 			port->xmit_head = (port->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
