Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUJHSet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUJHSet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUJHSaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:30:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:3053 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261426AbUJHS1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:27:19 -0400
Subject: Re: [PATCH] protect against buggy drivers
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linus@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041008171414.GA28001@kroah.com>
References: <1097254421.16787.27.camel@localhost.localdomain>
	 <20041008171414.GA28001@kroah.com>
Content-Type: text/plain
Organization: Open Source Development Lab
Date: Fri, 08 Oct 2004 11:27:25 -0700
Message-Id: <1097260045.16787.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a better fix (thanks Greg) that allows long names for character
device objects.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	2004-10-08 11:14:29 -07:00
+++ b/fs/char_dev.c	2004-10-08 11:14:29 -07:00
@@ -207,8 +207,8 @@
 
 	cdev->owner = fops->owner;
 	cdev->ops = fops;
-	strcpy(cdev->kobj.name, name);
-	for (s = strchr(cdev->kobj.name, '/'); s; s = strchr(s, '/'))
+	kobject_set_name(&cdev->kobj, "%s", name);
+	for (s = strchr(kobject_name(&cdev->kobj),'/'); s; s = strchr(s, '/'))
 		*s = '!';
 		
 	err = cdev_add(cdev, MKDEV(cd->major, 0), 256);


