Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264106AbUENX2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbUENX2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUENXNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:13:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:58588 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264106AbUENXIN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:13 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <10845760422513@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:22 -0700
Message-Id: <10845760423849@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.20, 2004/05/05 14:40:43-07:00, greg@kroah.com

Driver core: handle error if we run out of memory in kmap code


 drivers/base/map.c |    7 +++++++
 1 files changed, 7 insertions(+)


diff -Nru a/drivers/base/map.c b/drivers/base/map.c
--- a/drivers/base/map.c	Fri May 14 15:57:59 2004
+++ b/drivers/base/map.c	Fri May 14 15:57:59 2004
@@ -138,6 +138,13 @@
 	struct kobj_map *p = kmalloc(sizeof(struct kobj_map), GFP_KERNEL);
 	struct probe *base = kmalloc(sizeof(struct probe), GFP_KERNEL);
 	int i;
+
+	if ((p == NULL) || (base == NULL)) {
+		kfree(p);
+		kfree(base);
+		return NULL;
+	}
+
 	memset(base, 0, sizeof(struct probe));
 	base->dev = 1;
 	base->range = ~0;

