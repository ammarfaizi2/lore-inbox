Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTKPNIr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 08:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTKPNIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 08:08:47 -0500
Received: from gprs145-223.eurotel.cz ([160.218.145.223]:3200 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262740AbTKPNIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 08:08:46 -0500
Date: Sun, 16 Nov 2003 14:09:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: vojtech@ucw.cz, kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: cleanups for input
Message-ID: <20031116130909.GA275@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I know cleanups are not wanted just now, but I'd like this queued...

GFP_ATOMIC can fail at any time; I believe we do not want "heisenbugs"
so we should at least warn.

[serio_rescan() does not return error value yet it can fail. It seems
pretty broken to me :-(.]

--- tmp/linux/drivers/input/serio/serio.c	2003-09-28 22:05:48.000000000 +0200
+++ linux/drivers/input/serio/serio.c	2003-11-15 20:41:24.000000000 +0100
@@ -134,8 +134,10 @@
 {
 	struct serio_event *event;
 
-	if (!(event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC)))
+	if (!(event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
+		printk(KERN_CRIT "Could not rescan serio: out of memory\n");
 		return;
+	}
 
 	event->type = SERIO_RESCAN;
 	event->serio = serio;
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
