Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWEAVp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWEAVp5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWEAVp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:45:57 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:12426 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932278AbWEAVp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:45:56 -0400
Message-Id: <200605012046.k41KkURr005868@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH] UML - Change timer initialization
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 May 2006 16:46:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is definite 2.6.17 material...

As of rc3-mm1, inet_init, which schedules, is called before the UML timer_init,
which sets up the timer.  The result is the interval timers being manipulated
before the appropriate signal handlers are established, causing unhandled
timers.

This is fixed by making timer_init be called earlier.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17-mm/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/kernel/time_kern.c	2006-03-23 16:40:20.000000000 -0500
+++ linux-2.6.17-mm/arch/um/kernel/time_kern.c	2006-05-01 17:34:41.000000000 -0400
@@ -209,4 +209,4 @@ int __init timer_init(void)
 	return(0);
 }
 
-__initcall(timer_init);
+arch_initcall(timer_init);

