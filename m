Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbVKRVhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVKRVhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVKRVhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:37:04 -0500
Received: from hera.kernel.org ([140.211.167.34]:28872 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751031AbVKRVhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:37:02 -0500
Date: Fri, 18 Nov 2005 14:16:37 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Brian S. Julin" <bri@calyx.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: small hp_sdc_rtc cleanup: use no_llseek
Message-ID: <20051118161637.GC13943@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use no_llseek function.

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

diff --git a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
index 1cd7657..1be9639 100644
--- a/drivers/input/misc/hp_sdc_rtc.c
+++ b/drivers/input/misc/hp_sdc_rtc.c
@@ -60,8 +60,6 @@ static struct fasync_struct *hp_sdc_rtc_
 
 static DECLARE_WAIT_QUEUE_HEAD(hp_sdc_rtc_wait);
 
-static loff_t hp_sdc_rtc_llseek(struct file *file, loff_t offset, int origin);
-
 static ssize_t hp_sdc_rtc_read(struct file *file, char *buf,
 			       size_t count, loff_t *ppos);
 
@@ -387,11 +385,6 @@ static int hp_sdc_rtc_set_i8042timer (st
 	return 0;
 }
 
-static loff_t hp_sdc_rtc_llseek(struct file *file, loff_t offset, int origin)
-{
-        return -ESPIPE;
-}
-
 static ssize_t hp_sdc_rtc_read(struct file *file, char *buf,
 			       size_t count, loff_t *ppos) {
 	ssize_t retval;
@@ -679,7 +672,7 @@ static int hp_sdc_rtc_ioctl(struct inode
 
 static struct file_operations hp_sdc_rtc_fops = {
         .owner =	THIS_MODULE,
-        .llseek =	hp_sdc_rtc_llseek,
+        .llseek =	no_llseek,
         .read =		hp_sdc_rtc_read,
         .poll =		hp_sdc_rtc_poll,
         .ioctl =	hp_sdc_rtc_ioctl,
