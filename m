Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVDEGIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVDEGIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 02:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVDEGIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 02:08:18 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:51669 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261533AbVDEGIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 02:08:15 -0400
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc2: random oops on nmi_watchdog=1
Date: Tue, 5 Apr 2005 15:13:10 +0900
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504051513.11055.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With nmi_watchdog=1, I got random Oopses (Unable to handle kernel
paging request, not by the NMI oopser) from many processes.
It is not happend with -rc1.

The following change fixes this problem. but I'm not familiar with
these area.  If anyone wants more information, let me know.


--- 2.6-rc/arch/i386/kernel/entry.S.orig	2005-04-05 14:21:57.000000000 +0900
+++ 2.6-rc/arch/i386/kernel/entry.S	2005-04-05 14:22:36.000000000 +0900
@@ -550,7 +550,7 @@ nmi_stack_correct:
 	xorl %edx,%edx		# zero error code
 	movl %esp,%eax		# pt_regs pointer
 	call do_nmi
-	jmp restore_all
+	jmp restore_nocheck
 
 nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)



