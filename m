Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbUCRMCb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbUCRMCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:02:31 -0500
Received: from dp.samba.org ([66.70.73.150]:14502 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262548AbUCRMCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:02:04 -0500
Date: Thu, 18 Mar 2004 23:01:14 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Frank <mhf@linuxmail.org>
Cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.x atkbd.c moaning
Message-ID: <20040318120114.GN28212@krispykreme>
References: <opr41z9zel4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr41z9zel4evsfm@smtp.pacific.net.th>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why is this and should I investigate further?
..
 
> mice: PS/2 mouse device common for all mice
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: AT Translated Set 2 keyboard on isa0060/serio0
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).

Did this happen recently? If so, does backing out the following patch help?

Anton


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/03 15:14:01+01:00 vojtech@suse.cz 
#   input: i8042.c:
#     Assume the chip always is in XLATE mode, even when it doesn't
#     have the XLATE bit set - apparently IBM PS/2 model 70 behaves
#     this way.
# 
# drivers/input/serio/i8042.c
#   2004/03/03 15:13:56+01:00 vojtech@suse.cz +0 -8
#   input: i8042.c:
#     Assume the chip always is in XLATE mode, even when it doesn't
#     have the XLATE bit set - apparently IBM PS/2 model 70 behaves
#     this way.
# 
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Thu Mar 18 15:06:59 2004
+++ b/drivers/input/serio/i8042.c	Thu Mar 18 15:06:59 2004
@@ -722,14 +722,6 @@
 	}
 
 /*
- * If the chip is configured into nontranslated mode by the BIOS, don't
- * bother enabling translating and be happy.
- */
-
-	if (~i8042_ctr & I8042_CTR_XLATE)
-		i8042_direct = 1;
-
-/*
  * Set nontranslated mode for the kbd interface if requested by an option.
  * After this the kbd interface becomes a simple serial in/out, like the aux
  * interface is. We don't do this by default, since it can confuse notebook
