Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUCPPfV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUCPOjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:39:10 -0500
Received: from styx.suse.cz ([82.208.2.94]:65409 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261935AbUCPOTn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:43 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446777108@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 26/44] Always assume i8042 is in XLATE mode
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <10794467773954@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.56.4, 2004-03-03 15:14:01+01:00, vojtech@suse.cz
  input: i8042.c:
    Assume the chip always is in XLATE mode, even when it doesn't
    have the XLATE bit set - apparently IBM PS/2 model 70 behaves
    this way.


 i8042.c |    8 --------
 1 files changed, 8 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue Mar 16 13:18:29 2004
+++ b/drivers/input/serio/i8042.c	Tue Mar 16 13:18:29 2004
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

