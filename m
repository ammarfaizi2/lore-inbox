Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSGWAjD>; Mon, 22 Jul 2002 20:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317901AbSGWAh4>; Mon, 22 Jul 2002 20:37:56 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:10500 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317892AbSGWAhS>;
	Mon, 22 Jul 2002 20:37:18 -0400
Date: Mon, 22 Jul 2002 17:40:34 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM changes for 2.5.27
Message-ID: <20020723004034.GG660@kroah.com>
References: <20020723003702.GA660@kroah.com> <20020723003806.GB660@kroah.com> <20020723003905.GC660@kroah.com> <20020723003935.GD660@kroah.com> <20020723003952.GE660@kroah.com> <20020723004007.GF660@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020723004007.GF660@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 24 Jun 2002 23:35:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683.1.4 -> 1.683.1.5
#	arch/ia64/kernel/ptrace.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/22	greg@kroah.com	1.683.1.5
# added ptrace hook for ia64
# --------------------------------------------
#
diff -Nru a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
--- a/arch/ia64/kernel/ptrace.c	Mon Jul 22 17:25:56 2002
+++ b/arch/ia64/kernel/ptrace.c	Mon Jul 22 17:25:56 2002
@@ -15,6 +15,7 @@
 #include <linux/ptrace.h>
 #include <linux/smp_lock.h>
 #include <linux/user.h>
+#include <linux/security.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -1099,6 +1100,9 @@
 	if (request == PTRACE_TRACEME) {
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
+			goto out;
+		ret = security_ops->ptrace(current->parent, current);
+		if (ret)
 			goto out;
 		current->ptrace |= PT_PTRACED;
 		ret = 0;
