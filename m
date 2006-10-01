Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWJATXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWJATXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 15:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWJATXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 15:23:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17628 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932234AbWJATXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 15:23:24 -0400
Date: Sun, 1 Oct 2006 12:21:07 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, <fabrice@bellet.info>, zaitcev@redhat.com
Subject: pcmcia: patch to fix pccard_store_cis
Message-Id: <20061001122107.9260aa5d.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ``ret'' obviously cannot be zero here, because it's initialized to the
write count and not zero.

For the complete description, see:
 https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=207910

Author: Fabrice Bellet <fabrice@bellet.info>
Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>

--- linux-2.6.17.i686/drivers/pcmcia/socket_sysfs.c	2006-06-18 03:49:35.000000000 +0200
+++ /tmp/socket_sysfs.c	2006-10-01 19:30:09.000000000 +0200
@@ -321,7 +321,7 @@
 
 	kfree(cis);
 
-	if (!ret) {
+	if (ret == count) {
 		mutex_lock(&s->skt_mutex);
 		if ((s->callback) && (s->state & SOCKET_PRESENT) &&
 		    !(s->state & SOCKET_CARDBUS)) {
