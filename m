Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbTIYOAD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 10:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbTIYOAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 10:00:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12739 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261218AbTIYOAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 10:00:00 -0400
Date: Thu, 25 Sep 2003 14:59:56 +0100
From: Matthew Wilcox <willy@debian.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make help text work again for string/int/hex
Message-ID: <20030925135956.GN13172@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


conf_askvalue calls fgets() which puts "?\n" in the buffer, not "?".
So testing the second char for '\0' fails every time.  You need to
check for \n instead, I think.

(whitespace damaged patch, it's a trivial change to make)

Index: scripts/kconfig/conf.c
===================================================================
RCS file: /var/cvs/linux-2.6/scripts/kconfig/conf.c,v
retrieving revision 1.1
diff -u -p -r1.1 conf.c
--- scripts/kconfig/conf.c      29 Jul 2003 17:02:27 -0000      1.1
+++ scripts/kconfig/conf.c      25 Sep 2003 13:56:03 -0000
@@ -174,7 +174,7 @@ int conf_string(struct menu *menu)
                        break;
                case '?':
                        /* print help */
-                       if (line[1] == 0) {
+                       if (line[1] == '\n') {
                                help = nohelp_text;
                                if (menu->sym->help)
                                        help = menu->sym->help;


-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
