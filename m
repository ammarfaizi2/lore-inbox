Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTFJVKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTFJVKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:10:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:42902 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262763AbTFJVJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:09:54 -0400
Date: Tue, 10 Jun 2003 14:22:09 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeff Muizelaar <muizelaar@rogers.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@digeo.com,
       viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Fw: [PATCH] cleanup up seq file usage in resource.c
Message-Id: <20030610142209.59ac8c5b.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__10_Jun_2003_14:22:09_-0700_0956c550"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__10_Jun_2003_14:22:09_-0700_0956c550
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Date: Wed, 28 May 2003 20:05:33 -0400
From: Jeff Muizelaar <muizelaar@rogers.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] cleanup up seq file usage in resource.c


This patch against 2.5.70-bk2 removes the buffer allocation from 
resource.c and lets seq_read do it instead.

-Jeff
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Looks fine to me and works too.

Andrew, please apply to your next patch set.

Thanks,
--
~Randy

--Multipart_Tue__10_Jun_2003_14:22:09_-0700_0956c550
Content-Type: text/plain;
 name="resource-seq-file-cleanup.patch"
Content-Disposition: attachment;
 filename="resource-seq-file-cleanup.patch"
Content-Transfer-Encoding: 7bit

diff -urN linux-2.5.70-bk2/kernel/resource.c linux-2.5.70-bk2-resource-seq-file-cleanup/kernel/resource.c
--- linux-2.5.70-bk2/kernel/resource.c	2003-05-26 21:00:42.000000000 -0400
+++ linux-2.5.70-bk2-resource-seq-file-cleanup/kernel/resource.c	2003-05-28 19:22:04.000000000 -0400
@@ -71,20 +71,7 @@
 
 static int ioresources_open(struct file *file, struct resource *root)
 {
-	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	struct seq_file *m;
-	int res;
-
-	if (!buf)
-		return -ENOMEM;
-	res = single_open(file, ioresources_show, root);
-	if (!res) {
-		m = file->private_data;
-		m->buf = buf;
-		m->size = PAGE_SIZE;
-	} else
-		kfree(buf);
-	return res;
+	return single_open(file, ioresources_show, root);
 }
 
 static int ioports_open(struct inode *inode, struct file *file)


--Multipart_Tue__10_Jun_2003_14:22:09_-0700_0956c550--
