Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264074AbTJ1SP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTJ1SP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:15:56 -0500
Received: from dsl-hkigw4g29.dial.inet.fi ([80.222.54.41]:13696 "EHLO
	dsl-hkigw4g29.dial.inet.fi") by vger.kernel.org with ESMTP
	id S264072AbTJ1SOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:14:55 -0500
Date: Tue, 28 Oct 2003 20:14:53 +0200 (EET)
From: Petri Koistinen <petri.koistinen@iki.fi>
X-X-Sender: petri@dsl-hkigw4g29.dial.inet.fi
To: cltien@cmedia.com.tw, support@cmedia.com.tw
Cc: trivial@rustcorp.com.au, linux-sound@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Remove one of sound/oss/cmpci.c compile warnings
Message-ID: <Pine.LNX.4.58.0310282002530.4918@dsl-hkigw4g29.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch removes this compile warning:

sound/oss/cmpci.c: In function `cm_release_mixdev':
sound/oss/cmpci.c:1465: warning: unused variable `s'

GCC doesn't seem to unstand that VALIDATE_STATE macro uses s variable.
I hope this is correct way to fix this.

Petri

--- linux-2.6/sound/oss/cmpci.c.orig	2003-10-28 19:54:27.000000000 +0200
+++ linux-2.6/sound/oss/cmpci.c	2003-10-28 19:55:50.000000000 +0200
@@ -1462,7 +1462,9 @@

 static int cm_release_mixdev(struct inode *inode, struct file *file)
 {
-	struct cm_state *s = (struct cm_state *)file->private_data;
+	struct cm_state *s;
+
+	s = (struct cm_state *)file->private_data;

 	VALIDATE_STATE(s);
 	return 0;
