Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUGMQdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUGMQdu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 12:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265433AbUGMQdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 12:33:49 -0400
Received: from mail.ccur.com ([208.248.32.212]:37901 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265462AbUGMQb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 12:31:26 -0400
Message-ID: <40F40E51.8030803@ccur.com>
From: "Blackwood, John" <john.blackwood@ccur.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/i386|x86_64/kernel/ptrace.c linux-2.6.7
Date: Tue, 13 Jul 2004 12:31:13 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just want to try one more time to post a good diff without newlines.
Thanks.



diff -ru linux-2.6.7/arch/i386/kernel/ptrace.c
linux/arch/i386/kernel/ptrace.c
--- linux-2.6.7/arch/i386/kernel/ptrace.c       2004-06-16
01:19:03.000000000 -0400
+++ linux/arch/i386/kernel/ptrace.c     2004-07-12 13:09:33.000000000 -0400
@@ -428,11 +428,11 @@
                         ret = -EIO;
                         break;
                 }
+               ret = 0;
                 for ( i = 0; i < FRAME_SIZE*sizeof(long); i += sizeof(long)
) {
-                       __put_user(getreg(child, i), datap);
+                       ret |= __put_user(getreg(child, i), datap);
                         datap++;
                 }
-               ret = 0;
                 break;
         }

@@ -442,12 +442,12 @@
                         ret = -EIO;
                         break;
                 }
+               ret = 0;
                 for ( i = 0; i < FRAME_SIZE*sizeof(long); i += sizeof(long)
) {
-                       __get_user(tmp, datap);
+                       ret |=__get_user(tmp, datap);
                         putreg(child, i, tmp);
                         datap++;
                 }
-               ret = 0;
                 break;
         }




diff -ru linux-2.6.7/arch/x86_64/kernel/ptrace.c
linux/arch/x86_64/kernel/ptrace.c
--- linux-2.6.7/arch/x86_64/kernel/ptrace.c     2004-06-16
01:19:09.000000000 -0400
+++ linux/arch/x86_64/kernel/ptrace.c   2004-07-12 16:03:35.584411668 -0400
@@ -429,30 +429,30 @@
                 break;

         case PTRACE_GETREGS: { /* Get all gp regs from the child. */
-               if (!access_ok(VERIFY_WRITE, (unsigned __user *)data,
FRAME_SIZE)) {
+               if (!access_ok(VERIFY_WRITE, (unsigned __user *)data,
sizeof(struct user_regs_struct))) {
                         ret = -EIO;
                         break;
                 }
+               ret = 0;
                 for (ui = 0; ui < sizeof(struct user_regs_struct); ui +=
sizeof(long)) {
-                       __put_user(getreg(child, ui),(unsigned long __user
*) data);
+                       ret |= __put_user(getreg(child, ui),(unsigned long
__user *) data);
                         data += sizeof(long);
                 }
-               ret = 0;
                 break;
         }

         case PTRACE_SETREGS: { /* Set all gp regs in the child. */
                 unsigned long tmp;
-               if (!access_ok(VERIFY_READ, (unsigned __user *)data,
FRAME_SIZE)) {
+               if (!access_ok(VERIFY_READ, (unsigned __user *)data,
sizeof(struct user_regs_struct))) {
                         ret = -EIO;
                         break;
                 }
+               ret = 0;
                 for (ui = 0; ui < sizeof(struct user_regs_struct); ui +=
sizeof(long)) {
-                       __get_user(tmp, (unsigned long __user *) data);
+                       ret |= __get_user(tmp, (unsigned long __user *)
data);
                         putreg(child, ui, tmp);
                         data += sizeof(long);
                 }
-               ret = 0;
                 break;
         }


