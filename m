Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUDORoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUDORoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:44:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:27574 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263182AbUDORmR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:17 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509122685@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:52 -0700
Message-Id: <10820509124057@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.11, 2004/03/31 15:20:20-08:00, lxiep@ltcfwd.linux.ibm.com

[PATCH] kobject_set_name() doesn't allocate enough space


 lib/kobject.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Thu Apr 15 10:20:40 2004
+++ b/lib/kobject.c	Thu Apr 15 10:20:40 2004
@@ -349,16 +349,16 @@
 		/* 
 		 * Need more space? Allocate it and try again 
 		 */
-		name = kmalloc(need,GFP_KERNEL);
+		limit = need + 1;
+		name = kmalloc(limit,GFP_KERNEL);
 		if (!name) {
 			error = -ENOMEM;
 			goto Done;
 		}
-		limit = need;
 		need = vsnprintf(name,limit,fmt,args);
 
 		/* Still? Give up. */
-		if (need > limit) {
+		if (need >= limit) {
 			kfree(name);
 			error = -EFAULT;
 			goto Done;

