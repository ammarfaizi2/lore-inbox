Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbUJYXyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUJYXyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 19:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUJYWWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 18:22:47 -0400
Received: from gprs214-185.eurotel.cz ([160.218.214.185]:41601 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262029AbUJYWVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 18:21:41 -0400
Date: Tue, 26 Oct 2004 00:21:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Kill useless pm_access from vt.c
Message-ID: <20041025222124.GA381@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

pm_access does nothing these days, and looks ugly. This removes it
from vt.c. That actually looks like last user in the tree; it should
be possible to kill pm_access completely after 2.6.10. Ouch and add
warning to obsolete pm.txt file. Please apply,

								Pavel

--- clean/drivers/char/vt.c	2004-10-01 00:30:12.000000000 +0200
+++ linux/drivers/char/vt.c	2004-10-26 00:14:17.000000000 +0200
@@ -2186,8 +2186,6 @@
 	if (!printable || test_and_set_bit(0, &printing))
 		return;
 
-	pm_access(pm_con);
-
 	if (kmsg_redirect && vc_cons_allocated(kmsg_redirect - 1))
 		currcons = kmsg_redirect - 1;
 
@@ -2387,7 +2385,6 @@
 {
 	int	retval;
 
-	pm_access(pm_con);
 	retval = do_con_write(tty, from_user, buf, count);
 	con_flush_chars(tty);
 
@@ -2398,7 +2395,6 @@
 {
 	if (in_interrupt())
 		return;	/* n_r3964 calls put_char() from interrupt context */
-	pm_access(pm_con);
 	do_con_write(tty, 0, &ch, 1);
 }
 
@@ -2467,8 +2463,6 @@
 	if (in_interrupt())	/* from flush_to_ldisc */
 		return;
 
-	pm_access(pm_con);
-	
 	/* if we race with con_close(), vt may be null */
 	acquire_console_sem();
 	vt = tty->driver_data;


--- clean/Documentation/pm.txt	2001-12-19 22:38:12.000000000 +0100
+++ linux/Documentation/pm.txt	2004-10-26 00:18:13.000000000 +0200
@@ -36,8 +36,8 @@
   apmd:   http://worldvisions.ca/~apenwarr/apmd/
   acpid:  http://acpid.sf.net/
 
-Driver Interface
-----------------
+Driver Interface -- OBSOLETE, DO NOT USE!
+----------------*************************
 If you are writing a new driver or maintaining an old driver, it
 should include power management support.  Without power management
 support, a single driver may prevent a system with power management
@@ -262,8 +262,8 @@
 
 ACPI Development mailing list: acpi-devel@lists.sourceforge.net
 
-System Interface
-----------------
+System Interface -- OBSOLETE, DO NOT USE!
+----------------*************************
 If you are providing new power management support to Linux (ie.
 adding support for something like APM or ACPI), you should
 communicate with drivers through the existing generic power

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
