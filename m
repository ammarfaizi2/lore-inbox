Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263482AbTJLQSl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 12:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbTJLQSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 12:18:41 -0400
Received: from zeus.kernel.org ([204.152.189.113]:36812 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263482AbTJLQSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 12:18:40 -0400
Date: Sun, 12 Oct 2003 09:18:28 -0700
To: linux-kernel@vger.kernel.org
Cc: mochel@osdl.org
Subject: [PATCH] Make pmdisk suspend more reliable
Message-ID: <20031012161828.GA1728@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Mailer: Mutt http://www.mutt.org/
X-URL: http://www.muru.com/ http://www.atomide.com
X-Accept-Language: fi en
X-Location: USA, California, San Francisco
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Patrick & all,

Here's a little patch to make pmdisk suspend to disk work on my old
laptop. Basically at least the PMDISK_SIG never got to the disk, and
finding the suspend image would fail without this patch. The patch is
against linux-2.6.0-test7.

Pls cc me on any replies, I'm not on the list right now.

Regards,

Tony



--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pmdisk-bdflush.patch"

--- linux-2.6.0-test7/kernel/power/pmdisk.c-orig	2003-10-12 18:35:58.000000000 +0300
+++ linux-2.6.0-test7/kernel/power/pmdisk.c	2003-10-12 19:00:32.000000000 +0300
@@ -35,6 +35,7 @@
 
 
 extern int pmdisk_arch_suspend(int resume);
+extern int wakeup_bdflush(long nr_pages);
 
 #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
 #define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
@@ -372,6 +373,9 @@
 		goto FreePagedir;
 
 	error = mark_swapfiles(prev);
+
+	/* Make sure the data gets to disk */
+	wakeup_bdflush(0);
  Done:
 	return error;
  FreePagedir:

--tKW2IUtsqtDRztdT--
