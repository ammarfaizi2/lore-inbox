Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267422AbUHWTEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267422AbUHWTEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUHWTBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:01:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:10948 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267303AbUHWShC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:02 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286087677@kroah.com>
Date: Mon, 23 Aug 2004 11:34:47 -0700
Message-Id: <1093286087695@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.25, 2004/08/06 15:26:03-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: Added w1_check_family().

w1_check_family() checks new family before registering it.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1_family.c |   11 +++++++++++
 1 files changed, 11 insertions(+)


diff -Nru a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c	2004-08-23 11:04:14 -07:00
+++ b/drivers/w1/w1_family.c	2004-08-23 11:04:14 -07:00
@@ -27,11 +27,22 @@
 spinlock_t w1_flock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(w1_families);
 
+static int w1_check_family(struct w1_family *f)
+{
+	if (!f->fops->rname || !f->fops->rbin || !f->fops->rval || !f->fops->rvalname)
+		return -EINVAL;
+
+	return 0;
+}
+
 int w1_register_family(struct w1_family *newf)
 {
 	struct list_head *ent, *n;
 	struct w1_family *f;
 	int ret = 0;
+
+	if (w1_check_family(newf))
+		return -EINVAL;
 
 	spin_lock(&w1_flock);
 	list_for_each_safe(ent, n, &w1_families) {

