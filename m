Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTE2D6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 23:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTE2D6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 23:58:14 -0400
Received: from dp.samba.org ([66.70.73.150]:58065 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261868AbTE2D6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 23:58:13 -0400
Date: Thu, 29 May 2003 14:06:31 +1000
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] compat_wait4 fix
Message-ID: <20030529040631.GA19129@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

sys_wait4 can return a pid and in this case we want to copy the struct
rusage out to userspace.

Anton

--- gr9/kernel/compat.c	2003-04-17 15:26:39.000000000 -0500
+++ gr9_cacheable_smp_h_2/kernel/compat.c	2003-05-28 21:29:06.000000000 -0500
@@ -362,8 +362,7 @@
 		ret = sys_wait4(pid, stat_addr ? &status : NULL, options, &r);
 		set_fs (old_fs);
 
-		if (!ret)
-		{
+		if (ret > 0) {
 			if (put_compat_rusage(ru, &r)) 
 				return -EFAULT;
 			if (stat_addr && put_user(status, stat_addr))
