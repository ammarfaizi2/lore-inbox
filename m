Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268529AbUHQXva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268529AbUHQXva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 19:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUHQXva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 19:51:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50415 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S268529AbUHQXuT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:50:19 -0400
Date: Tue, 17 Aug 2004 16:50:10 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: linux-mtd@lists.infradead.org, viro@ftp.uk.linux.org
Cc: linux-kernel@vger.kernel.org, yoann@prelude-ids.org
Subject: [PATCH] JFFS2 mount options discarded
Message-ID: <20040817235010.GA18014@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoann Vandoorselaere noticed an attempt to mount a JFFS2 filesystem
read-only mounts writeable instead.  I believe the fix is:

--- linux-2.6.8.1-orig/fs/jffs2/super.c	2004-08-15 11:46:43.000000000 -0700
+++ linux-2.6.8.1-jffs2-mount-fix/fs/jffs2/super.c	2004-08-17 15:45:17.935379784 -0700
@@ -130,7 +130,7 @@
 		  mtd->index, mtd->name));
 
 	sb->s_op = &jffs2_super_operations;
-	sb->s_flags |= MS_NOATIME;
+	sb->s_flags = flags | MS_NOATIME;
 
 	ret = jffs2_do_fill_super(sb, data, (flags&MS_VERBOSE)?1:0);
 

Clue me in if I'm off-base, thanks,

-- 
Todd Poynor
MontaVista Software

