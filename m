Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVCJBTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVCJBTR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVCJBSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:18:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:45727 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262611AbVCJAmZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:25 -0500
Cc: alexn@dsv.su.se
Subject: [PATCH] AoE warning on 64-bit archs
In-Reply-To: <20050310001812.GA31984@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:19:22 -0800
Message-Id: <1110413962220@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2035, 2005/03/09 10:20:37-08:00, alexn@dsv.su.se

[PATCH] AoE warning on 64-bit archs

I just accidently built AoE on x86-64 and it emits a warning
due to conversion of types of different size, trivial fix:


Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/block/aoe/aoechr.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
--- a/drivers/block/aoe/aoechr.c	2005-03-09 16:16:13 -08:00
+++ b/drivers/block/aoe/aoechr.c	2005-03-09 16:16:13 -08:00
@@ -178,13 +178,13 @@
 static ssize_t
 aoechr_read(struct file *filp, char __user *buf, size_t cnt, loff_t *off)
 {
-	int n;
+	unsigned long n;
 	char *mp;
 	struct ErrMsg *em;
 	ssize_t len;
 	ulong flags;
 
-	n = (int) filp->private_data;
+	n = (unsigned long) filp->private_data;
 	switch (n) {
 	case MINOR_ERR:
 		spin_lock_irqsave(&emsgs_lock, flags);

