Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161139AbWJXShQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbWJXShQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 14:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbWJXShQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 14:37:16 -0400
Received: from [213.234.233.54] ([213.234.233.54]:9390 "EHLO mail.screens.ru")
	by vger.kernel.org with ESMTP id S1161139AbWJXShO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 14:37:14 -0400
Date: Tue, 24 Oct 2006 22:36:58 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] add-process_session-helper-routine-deprecate-old-field-tidy
Message-ID: <20061024183658.GA1905@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater wrote:
>
> -	.session	= 1,						\
> +	.tty_old_pgrp   = 0,						\
> +	{ .session      = 1},						\

Any reason to initialize .tty_old_pgrp explicitly? This gives a false
positive from grep...

--- rc2-mm2/include/linux/init_task.h~	2006-10-22 19:28:17.000000000 +0400
+++ rc2-mm2/include/linux/init_task.h	2006-10-24 22:24:04.000000000 +0400
@@ -66,8 +66,7 @@
 	.cpu_timers	= INIT_CPU_TIMERS(sig.cpu_timers),		\
 	.rlim		= INIT_RLIMITS,					\
 	.pgrp		= 1,						\
-	.tty_old_pgrp   = 0,						\
-	{ .__session      = 1},						\
+	{ .__session	= 1 },						\
 }
 
 extern struct nsproxy init_nsproxy;

