Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWIMQjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWIMQjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWIMQin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:38:43 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:59466 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750738AbWIMQiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:38:23 -0400
Date: Wed, 13 Sep 2006 18:38:42 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [04/12] driver core fixes: retval check in class_register()
Message-ID: <20060913183842.733d561a@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for return value of add_class_attrs() in class_register().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 class.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.18-rc6/drivers/base/class.c	2006-09-12 16:19:43.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/class.c	2006-09-12 17:01:12.000000000 +0200
@@ -153,6 +153,8 @@ int class_register(struct class * cls)
 	error = subsystem_register(&cls->subsys);
 	if (!error) {
 		error = add_class_attrs(class_get(cls));
+		if (error)
+			subsystem_unregister(&cls->subsys);
 		class_put(cls);
 	}
 	return error;
