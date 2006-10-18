Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbWJRTMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbWJRTMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbWJRTMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:12:15 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:15541 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161091AbWJRTMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:12:14 -0400
Date: Wed, 18 Oct 2006 21:10:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: akpm@osdl.org
cc: Paul.Clements@steeleye.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] pull in necessary header files for cdev.h
In-Reply-To: <200610091223.28070.vapier@gentoo.org>
Message-ID: <Pine.LNX.4.61.0610182107260.8696@yvahk01.tjqt.qr>
References: <200610082012.27879.vapier@gentoo.org>
 <Pine.LNX.4.61.0610090912030.12485@yvahk01.tjqt.qr> <200610091223.28070.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



linux/cdev.h uses struct kobject and other structs and should 
therefore include them. Currently, a module either needs to add the 
missing includes itself, or, in case a module includes other headers 
already, needs to put <linux/cdev.h> last, which goes against a 
alphabetically-sorted include list.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.19-rc2/include/linux/cdev.h
===================================================================
--- linux-2.6.19-rc2.orig/include/linux/cdev.h
+++ linux-2.6.19-rc2/include/linux/cdev.h
@@ -2,6 +2,10 @@
 #define _LINUX_CDEV_H
 #ifdef __KERNEL__
 
+#include <linux/kobject.h>
+#include <linux/kdev_t.h>
+#include <linux/list.h>
+
 struct cdev {
 	struct kobject kobj;
 	struct module *owner;
#<EOF>

	-`J'
-- 
