Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271721AbTHDMyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 08:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271722AbTHDMyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 08:54:16 -0400
Received: from trappist.elis.UGent.be ([157.193.204.1]:17358 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S271721AbTHDMyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 08:54:15 -0400
Subject: [PATCH] get/put_task_struct
From: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 04 Aug 2003 14:54:13 +0200
Message-Id: <1060001653.1271.5.camel@tom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In order to be able to safely manipulate a task_struct from within a
module one should use get/put_task_struct. This is currently not
possible because __put_task_struct is not exported. Next patch solves
this issue.

Frank.

--- linux-2.6.0-test2.orig/kernel/ksyms.c	2003-07-29 10:04:45.000000000 +0200
+++ linux-2.6.0-test2/kernel/ksyms.c	2003-07-29 14:11:40.000000000 +0200
@@ -495,6 +495,7 @@
 #if !defined(__ia64__)
 EXPORT_SYMBOL(loops_per_jiffy);
 #endif
+EXPORT_SYMBOL(__put_task_struct);
 

 /* misc */


