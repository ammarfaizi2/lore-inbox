Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932803AbWCVVt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803AbWCVVt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWCVVt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:49:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:57523 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932803AbWCVVtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:49:55 -0500
X-Authenticated: #704063
Subject: [Patch] Use of uninitialized variable in drivers/net/depca.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: davies@maniac.ultranet.com
Content-Type: text/plain
Date: Wed, 22 Mar 2006 22:49:48 +0100
Message-Id: <1143064188.26672.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity bug #888, where the variable
dev is used uninitialized. I assume the programmer
meant to use mdev, which is initialized.
Compile tested only.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.16/drivers/net/depca.c.orig	2006-03-22 22:40:52.000000000 +0100
+++ linux-2.6.16/drivers/net/depca.c	2006-03-22 22:41:16.000000000 +0100
@@ -1412,7 +1412,7 @@ static int __init depca_mca_probe(struct
 		irq = 11;
 		break;
 	default:
-		printk("%s: mca_probe IRQ error.  You should never get here (%d).\n", dev->name, where);
+		printk("%s: mca_probe IRQ error.  You should never get here (%d).\n", mdev->name, where);
 		return -EINVAL;
 	}
 


