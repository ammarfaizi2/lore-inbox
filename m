Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264422AbUFGLz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbUFGLz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbUFGLz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:55:27 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:48768 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264422AbUFGLzU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:20 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093523713@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <20040607115022.GA12072@ucw.cz>
Mime-Version: 1.0
Subject: [PATCH 1/39] input: Fix a workaround for USB Legacy detected as MUX in i8042.c.
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 7 Jun 2004 13:55:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.594.5, 2004-03-19 14:56:45+01:00, vojtech@suse.cz
  input: Chips passing MUX detection incorrectly due to USB Legacy support
         report MUX version 10.12, not 12.10. Fixed.


 i8042.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-06-07 13:13:49 +02:00
+++ b/drivers/input/serio/i8042.c	2004-06-07 13:13:49 +02:00
@@ -532,8 +532,8 @@
 		return -1;
 	
 	/* Workaround for broken chips which seem to support MUX, but in reality don't. */
-	/* They all report version 12.10 */
-	if (mux_version == 0xCA)
+	/* They all report version 10.12 */
+	if (mux_version == 0xAC)
 		return -1;
 
 	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev %d.%d.\n",

