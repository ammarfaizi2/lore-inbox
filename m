Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbUKEAzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbUKEAzK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUKEAwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:52:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:51678 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262528AbUKEAtG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:49:06 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <10996157052267@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 4 Nov 2004 16:48:25 -0800
Message-Id: <10996157053960@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2449.2.7, 2004/11/04 10:55:28-08:00, tj@home-tj.org

[PATCH] driver-model: kobject_add() error path reference counting fix

 df_04_kobject_add_ref_fix.patch

In kobject_add(), @kobj wasn't put'd properly on error path.  This
patch fixes it.


Signed-off-by: Tejun Heo <tj@home-tj.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-11-04 16:30:32 -08:00
+++ b/lib/kobject.c	2004-11-04 16:30:32 -08:00
@@ -183,6 +183,7 @@
 		unlink(kobj);
 		if (parent)
 			kobject_put(parent);
+		kobject_put(kobj);
 	} else {
 		kobject_hotplug(kobj, KOBJ_ADD);
 	}

