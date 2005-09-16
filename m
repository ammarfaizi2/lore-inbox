Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbVIPPPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbVIPPPi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbVIPPPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:15:38 -0400
Received: from imap.gmx.net ([213.165.64.20]:19612 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932663AbVIPPPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:15:37 -0400
Date: Fri, 16 Sep 2005 17:15:36 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: akpm@osdl.org
Cc: alan@redhat.com, michael.kerrisk@gmx.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [patch 2.6.14-rc1] PR_GET_DUMPABLE returns incorrect info
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <18739.1126883736@www47.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

2.6.13 incorporated Alan Cox's patch for /proc/sys/fs/suid_dumpable
(one version of this patch can be found here
http://marc.theaimsgroup.com/?l=linux-kernel&m=109647550421014&w=2 ).
This patch also made corresponding changes in kernel/sys.c to
change the prctl() PR_SET_DUMPABLE operation so that the 
permitted range of 'arg2' was modified from 0..1 to 0..2.

However, a corresponding change was not made for 
PR_GET_DUMPABLE: if the dumpable flag is non-zero, then
PR_GET_DUMPABLE always returns 1, so that the caller can't
determine the true setting of this flag.

I suggest the following small patch.  Perhaps Alan has comments.

Cheers,

Michael


--- linux-2.6.14-rc1/kernel/sys.c       2005-09-15 08:21:30.000000000 +0200
+++ linux-2.6.14-rc1-mod/kernel/sys.c   2005-09-16 16:55:29.000000000 +0200
@@ -1729,6 +1729,5 @@
                        break;
                case PR_GET_DUMPABLE:
-                       if (current->mm->dumpable)
-                               error = 1;
+                       error = current->mm->dumpable;
                        break;
                case PR_SET_DUMPABLE:

-- 
5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
+++ GMX - die erste Adresse für Mail, Message, More +++
