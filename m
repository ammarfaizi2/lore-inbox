Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTKNUWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTKNUWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:22:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31106 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262297AbTKNUWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:22:21 -0500
Date: Fri, 14 Nov 2003 20:22:20 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix XFree86 build
Message-ID: <20031114202220.GK30485@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus.

Andries changed the struct member's name from "period" to "rate"
back in October 2002.  This was great for kernel code, but not so good
when the header is used for userspace (ie the XFree86 build uses it).
The following patch restores the old name for the benefit of userspace.

Index: include/linux/kd.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/kd.h,v
retrieving revision 1.1
diff -u -p -r1.1 kd.h
--- a/include/linux/kd.h	29 Jul 2003 17:02:13 -0000	1.1
+++ b/include/linux/kd.h	14 Nov 2003 20:18:38 -0000
@@ -134,8 +134,11 @@ struct kbkeycode {
 
 struct kbd_repeat {
 	int delay;	/* in msec; <= 0: don't change */
+#ifdef __KERNEL__
 	int period;	/* in msec; <= 0: don't change */
-			/* earlier this field was misnamed "rate" */
+#else
+	int rate;	/* earlier this field was misnamed "rate" */
+#endif
 };
 
 #define KDKBDREP        0x4B52  /* set keyboard delay/repeat rate;

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
