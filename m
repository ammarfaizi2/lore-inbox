Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266881AbUHWTjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266881AbUHWTjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUHWTiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:38:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:54979 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266881AbUHWSgb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:31 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860861336@kroah.com>
Date: Mon, 23 Aug 2004 11:34:46 -0700
Message-Id: <10932860862720@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.21, 2004/08/06 11:08:00-07:00, greg@kroah.com

MODULE: delete local static copy of param_set_byte as we now have a real version of it.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 kernel/module.c |   13 -------------
 1 files changed, 13 deletions(-)


diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	2004-08-23 11:04:36 -07:00
+++ b/kernel/module.c	2004-08-23 11:04:36 -07:00
@@ -725,19 +725,6 @@
 #endif /* CONFIG_MODULE_UNLOAD */
 
 #ifdef CONFIG_OBSOLETE_MODPARM
-static int param_set_byte(const char *val, struct kernel_param *kp)  
-{
-	char *endp;
-	long l;
-
-	if (!val) return -EINVAL;
-	l = simple_strtol(val, &endp, 0);
-	if (endp == val || *endp || ((char)l != l))
-		return -EINVAL;
-	*((char *)kp->arg) = l;
-	return 0;
-}
-
 /* Bounds checking done below */
 static int obsparm_copy_string(const char *val, struct kernel_param *kp)
 {

