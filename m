Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271704AbTHKJoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 05:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272325AbTHKJoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 05:44:18 -0400
Received: from trappist.elis.UGent.be ([157.193.204.1]:22439 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S271704AbTHKJoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 05:44:17 -0400
Subject: [PATCH] get/put_task_struct
From: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 11 Aug 2003 11:44:01 +0200
Message-Id: <1060595041.1602.3.camel@tom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In order to be able to safely manipulate a task_struct (!= current) from
within a module one should use get/put_task_struct. This is currently
not possible because __put_task_struct is not exported. Next patch
solves this issue. Please apply.

Frank.


--- linux-2.6.0-test3.orig/kernel/ksyms.c	2003-08-09 06:31:15.000000000 +0200
+++ linux-2.6.0-test3/kernel/ksyms.c	2003-08-11 11:03:40.000000000 +0200
@@ -498,6 +498,7 @@
 #if !defined(__ia64__)
 EXPORT_SYMBOL(loops_per_jiffy);
 #endif
+EXPORT_SYMBOL(__put_task_struct);
 

 /* misc */


