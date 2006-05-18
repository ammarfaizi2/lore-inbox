Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWERSSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWERSSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 14:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWERSSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 14:18:11 -0400
Received: from mail.suse.de ([195.135.220.2]:15078 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932121AbWERSSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 14:18:10 -0400
Date: Thu, 18 May 2006 11:16:03 -0700
From: Greg Kroah-Hartman <gregkh@suse.de>
To: torvalds@osdl.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kobject: quiet errors in kobject_add
Message-ID: <20060518181603.GA27767@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People don't like released kernels yelling at them, no matter how real
the error might be.  So only report it if CONFIG_KOBJECT_DEBUG is
enabled.

Sent on request of Andrew Morton.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 lib/kobject.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/lib/kobject.c
+++ gregkh-2.6/lib/kobject.c
@@ -198,14 +198,14 @@ int kobject_add(struct kobject * kobj)
 
 		/* be noisy on error issues */
 		if (error == -EEXIST)
-			printk("kobject_add failed for %s with -EEXIST, "
+			pr_debug("kobject_add failed for %s with -EEXIST, "
 			       "don't try to register things with the "
 			       "same name in the same directory.\n",
 			       kobject_name(kobj));
 		else
-			printk("kobject_add failed for %s (%d)\n",
+			pr_debug("kobject_add failed for %s (%d)\n",
 			       kobject_name(kobj), error);
-		dump_stack();
+		/* dump_stack(); */
 	}
 
 	return error;

