Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbUJ1Qkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUJ1Qkc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbUJ1Qkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:40:32 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:38345 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S261171AbUJ1QkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:40:23 -0400
Date: Thu, 28 Oct 2004 19:40:11 +0300 (EEST)
From: Tero Roponen <teanropo@cc.jyu.fi>
X-X-Sender: teanropo@silmu.st.jyu.fi
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.x /dev/pg0 is always busy
Message-ID: <Pine.LNX.4.44.0410281932130.22348-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: by miltrassassin
	at posti5.jyu.fi; Thu, 28 Oct 2004 19:40:21 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Without this patch my HP CD-Writer doesn't work.
With this applied everything is fine.

Signed-off-by: Tero Roponen <teanropo@cc.jyu.fi>


--- linux-2.6.10-rc1/drivers/block/paride/pg.c.orig	2004-10-28 18:49:50.431556152 +0300
+++ linux-2.6.10-rc1/drivers/block/paride/pg.c	2004-10-28 18:50:13.742012424 +0300
@@ -262,7 +262,7 @@ static void pg_init_units(void)
 		int *parm = *drives[unit];
 		struct pg *dev = &devices[unit];
 		dev->pi = &dev->pia;
-		set_bit(0, &dev->access);
+		clear_bit(0, &dev->access);
 		dev->busy = 0;
 		dev->present = 0;
 		dev->bufptr = NULL;

