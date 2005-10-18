Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVJRVpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVJRVpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVJRVpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:45:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17565 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932154AbVJRVpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:45:23 -0400
Date: Tue, 18 Oct 2005 22:45:17 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH] build fix for uml/amd64
Message-ID: <20051018214517.GD7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Missing half of the [PATCH] uml: Fix sysrq-r support for skas mode
We need to remove these (UPT_[DEFG]S) from the read side as well as the
write one - otherwise it simply won't build.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----

IMO it should go in before 2.6.14.  Jeff, could you ACK that?

diff -urN RC14-rc4-git4-hppfs-sparse/arch/um/include/sysdep-x86_64/ptrace.h RC14-rc4-git4-pending-1/arch/um/include/sysdep-x86_64/ptrace.h
--- RC14-rc4-git4-hppfs-sparse/arch/um/include/sysdep-x86_64/ptrace.h	2005-10-10 21:36:17.000000000 -0400
+++ RC14-rc4-git4-pending-1/arch/um/include/sysdep-x86_64/ptrace.h	2005-10-16 03:10:04.000000000 -0400
@@ -183,10 +183,6 @@
                 case RBP: val = UPT_RBP(regs); break; \
                 case ORIG_RAX: val = UPT_ORIG_RAX(regs); break; \
                 case CS: val = UPT_CS(regs); break; \
-                case DS: val = UPT_DS(regs); break; \
-                case ES: val = UPT_ES(regs); break; \
-                case FS: val = UPT_FS(regs); break; \
-                case GS: val = UPT_GS(regs); break; \
                 case EFLAGS: val = UPT_EFLAGS(regs); break; \
                 default :  \
                         panic("Bad register in UPT_REG : %d\n", reg);  \
