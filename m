Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTFDPJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTFDPJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:09:43 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:40591 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP id S263380AbTFDPJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:09:42 -0400
Date: Wed, 4 Jun 2003 22:16:25 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: linux-kernel@vger.kernel.org
Subject: [PATCH] get_current_user() macro in linux/sched.h conflicts with
 __user defined in compiler.h
Message-ID: <Pine.SGI.4.10.10306042158520.992312-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


get_current_user() macro in linux/sched.h conflicts with the
user space attribute #define __user from compiler.h.

I have not found any usage of this macro in all kernel code though.

--- linux-2.5.70/include/linux/sched.h.orig	Tue May 27 08:00:23 2003
+++ linux-2.5.70/include/linux/sched.h	Wed Jun  4 21:58:00 2003
@@ -289,9 +289,9 @@
 };
 
 #define get_current_user() ({ 				\
-	struct user_struct *__user = current->user;	\
-	atomic_inc(&__user->__count);			\
-	__user; })
+	struct user_struct *_user_ = current->user;	\
+	atomic_inc(&_user_->__count);			\
+	_user_; })
 
 extern struct user_struct *find_user(uid_t);

