Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbUKQXqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbUKQXqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbUKQWFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:05:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:33252 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262555AbUKQWBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:01:18 -0500
Message-ID: <419BC726.3030806@osdl.org>
Date: Wed, 17 Nov 2004 13:48:22 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, axboe@suse.de
Subject: [PATCH] cdrom: handle SYSCTL without PROC_FS
Content-Type: multipart/mixed;
 boundary="------------010102070305000506010401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010102070305000506010401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fixes oops (reference to cdrom_root_table->child->)
when CONFIG_SYSCTL=y and CONFIG_PROC_FS=n.

diffstat:=
  drivers/cdrom/cdrom.c |    2 --
  1 files changed, 2 deletions(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
-- 

--------------010102070305000506010401
Content-Type: text/x-patch;
 name="cdrom_sysctl_26.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdrom_sysctl_26.patch"

diff -Naurp ./drivers/cdrom/cdrom.c~cdrom_sysctl ./drivers/cdrom/cdrom.c
--- ./drivers/cdrom/cdrom.c~cdrom_sysctl	2004-11-16 13:33:30.177562576 -0800
+++ ./drivers/cdrom/cdrom.c	2004-11-17 13:23:54.831232024 -0800
@@ -3336,7 +3336,6 @@ ctl_table cdrom_cdrom_table[] = {
 
 /* Make sure that /proc/sys/dev is there */
 ctl_table cdrom_root_table[] = {
-#ifdef CONFIG_PROC_FS
 	{
 		.ctl_name	= CTL_DEV,
 		.procname	= "dev",
@@ -3344,7 +3343,6 @@ ctl_table cdrom_root_table[] = {
 		.mode		= 0555,
 		.child		= cdrom_cdrom_table,
 	},
-#endif /* CONFIG_PROC_FS */
 	{ .ctl_name = 0 }
 };
 static struct ctl_table_header *cdrom_sysctl_header;

--------------010102070305000506010401--
