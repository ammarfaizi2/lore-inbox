Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUACNg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 08:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbUACNgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 08:36:25 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:27777 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262913AbUACNgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 08:36:24 -0500
Date: Sat, 3 Jan 2004 14:37:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Alt-arrow console switch sometimes dropped
Message-ID: <20040103133746.GA516@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Alt-arrow console switch is routinely dropped under high load. This
patch fixes it: alt-arrow has to start from console _we want to switch
to_, if switch is already pending. Please apply,
								Pavel

Index: linux.new/drivers/char/keyboard.c
===================================================================
--- linux.new.orig/drivers/char/keyboard.c	2003-12-25 13:28:51.000000000 +0100
+++ linux.new/drivers/char/keyboard.c	2003-12-25 13:29:08.000000000 +0100
@@ -507,8 +528,12 @@
 static void fn_inc_console(struct vc_data *vc, struct pt_regs *regs)
 {
 	int i;
+	int cur = fg_console;
 
-	for (i = fg_console+1; i != fg_console; i++) {
+	if (want_console != -1)
+		cur = want_console;
+
+	for (i = cur+1; i != cur; i++) {
 		if (i == MAX_NR_CONSOLES)
 			i = 0;
 		if (vc_cons_allocated(i))


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
