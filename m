Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbUCCEeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbUCCEd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:33:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:39298 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262369AbUCCEWD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:22:03 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4-rc1
In-Reply-To: <1078287398405@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:16:38 -0800
Message-Id: <10782873983442@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1612.17.4, 2004/02/27 11:18:21-08:00, greg@kroah.com

kobject: clean up kobject_get() convoluted logic.


 lib/kobject.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Tue Mar  2 19:50:26 2004
+++ b/lib/kobject.c	Tue Mar  2 19:50:26 2004
@@ -425,14 +425,11 @@
 
 struct kobject * kobject_get(struct kobject * kobj)
 {
-	struct kobject * ret = kobj;
-
 	if (kobj) {
 		WARN_ON(!atomic_read(&kobj->refcount));
 		atomic_inc(&kobj->refcount);
-	} else
-		ret = NULL;
-	return ret;
+	}
+	return kobj;
 }
 
 /**

