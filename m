Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTIEKoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 06:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTIEKoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 06:44:25 -0400
Received: from dsl-hkigw4a35.dial.inet.fi ([80.222.48.53]:40388 "EHLO
	dsl-hkigw4a35.dial.inet.fi") by vger.kernel.org with ESMTP
	id S262375AbTIEKoY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 06:44:24 -0400
Date: Fri, 5 Sep 2003 13:44:21 +0300 (EEST)
From: Petri Koistinen <petri.koistinen@iki.fi>
X-X-Sender: petri@dsl-hkigw4a35.dial.inet.fi
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/input/input.c compile warning fix
Message-ID: <Pine.LNX.4.56.0309051309070.8475@dsl-hkigw4a35.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

$ make allnoconfig
$ make

  CC      drivers/input/input.o
drivers/input/input.c: In function `input_init':
drivers/input/input.c:687: warning: unused variable `entry'

Perhaps following patch could remove that warning. Linus don't like use
of #ifdefs but they are already used in that file.

Best regards,
Petri Koistinen

--- linux-2.5/drivers/input/input.c.orig	2003-09-05 13:36:19.000000000 +0300
+++ linux-2.5/drivers/input/input.c	2003-09-05 13:36:58.000000000 +0300
@@ -684,7 +684,9 @@

 static int __init input_init(void)
 {
+#ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *entry;
+#endif
 	int retval = -ENOMEM;

 	class_register(&input_class);
