Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSHOWIn>; Thu, 15 Aug 2002 18:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317541AbSHOWIn>; Thu, 15 Aug 2002 18:08:43 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:37010 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317540AbSHOWIn>; Thu, 15 Aug 2002 18:08:43 -0400
Subject: [PATCH] Include tgid when finding next_safe in get_pid()
From: Paul Larson <plars@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 Aug 2002 17:05:27 -0500
Message-Id: <1029449128.4604.77.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was broken out from the original get_pid() patch, but it is
aplicable even if the other isn't taken. Please apply.

Thanks,
Paul Larson

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.519   -> 1.520  
#	       kernel/fork.c	1.61    -> 1.62   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/15	plars@austin.ibm.com	1.520
# Include tgid when finding next_safe in get_pid()
# --------------------------------------------
#
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Thu Aug 15 17:48:18 2002
+++ b/kernel/fork.c	Thu Aug 15 17:48:18 2002
@@ -186,6 +186,8 @@
 				next_safe = p->pid;
 			if(p->pgrp > last_pid && next_safe > p->pgrp)
 				next_safe = p->pgrp;
+			if(p->tgid > last_pid && next_safe > p->tgid)
+				next_safe = p->tgid;
 			if(p->session > last_pid && next_safe > p->session)
 				next_safe = p->session;
 		}

