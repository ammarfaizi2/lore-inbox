Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUCPPfY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbUCPOi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:38:58 -0500
Received: from styx.suse.cz ([82.208.2.94]:64897 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261933AbUCPOTn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:43 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446777817@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 24/44] Workaround i8042 chips with broken MUX mode
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <10794467772648@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.56.2, 2004-03-03 11:49:20+01:00, vojtech@suse.cz
  input: Workaround i8042 chips with broken MUX mode.


 i8042.c |    5 +++++
 1 files changed, 5 insertions(+)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue Mar 16 13:18:37 2004
+++ b/drivers/input/serio/i8042.c	Tue Mar 16 13:18:37 2004
@@ -530,6 +530,11 @@
 
 	if (i8042_enable_mux_mode(values, &mux_version))
 		return -1;
+	
+	/* Workaround for broken chips which seem to support MUX, but in reality don't. */
+	/* They all report version 12.10 */
+	if (mux_version == 0xCA)
+		return -1;
 
 	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev %d.%d.\n",
 		(mux_version >> 4) & 0xf, mux_version & 0xf);

