Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbUATBUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbUATBTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:19:00 -0500
Received: from mail.kroah.org ([65.200.24.183]:32457 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265350AbUATBMt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:12:49 -0500
Subject: Re: [PATCH] Driver Core update and fixes for 2.6.1
In-Reply-To: <1074561161776@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 17:12:41 -0800
Message-Id: <1074561161146@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1505, 2004/01/19 16:57:07-08:00, greg@kroah.com

[PATCH] Kobject: prevent oops in kset_find_obj() if kobject_name() is NULL

Thanks to Hollis Blanchard <hollisb@us.ibm.com> for pointing this out.


 lib/kobject.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Mon Jan 19 17:04:40 2004
+++ b/lib/kobject.c	Mon Jan 19 17:04:40 2004
@@ -547,7 +547,7 @@
 	down_read(&kset->subsys->rwsem);
 	list_for_each(entry,&kset->list) {
 		struct kobject * k = to_kobj(entry);
-		if (!strcmp(kobject_name(k),name)) {
+		if (kobject_name(k) && (!strcmp(kobject_name(k),name))) {
 			ret = k;
 			break;
 		}

