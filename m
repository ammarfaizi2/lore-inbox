Return-Path: <linux-kernel-owner+willy=40w.ods.org-S287011AbVBEF3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S287011AbVBEF3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 00:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S287010AbVBEF3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 00:29:13 -0500
Received: from hornet.berlios.de ([195.37.77.140]:54237 "EHLO
	hornet.berlios.de") by vger.kernel.org with ESMTP id S286989AbVBEF3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 00:29:07 -0500
From: Michael Frank at BerliOS <mhf@hornet.berlios.de>
Date: Sat, 05 Feb 2005 06:29:06 +0100
To: <linux-kernel@vger.kernel.org>, "Kernel Mailing List"@hornet.berlios.de
Subject: [PATCH] 2.6.11-rc3 fix compile failure in arch/i386/kernel/i387.c
Message-ID: <420459A2.nailH9511F7VV@hornet.berlios.de>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using patch-2.6.11-rc3.bz2 from kernel.org on top of 2.6.10, 
a compile failure in /arch/i386/kernel/i387.c due to tsk->used_math undef.

The patch log shows offsets but no rejects

patching file arch/i386/kernel/i387.c
Hunk #6 succeeded at 538 (offset 15 lines).
Hunk #7 succeeded at 553 (offset 15 lines).

Patch below fixes it.

 Regards
 Michael

Signed off by: Michael Frank <mhf@berlios.de>

diff -uN linux-2.6.11-rc3-Vanilla/arch/i386/kernel/i387.c linux-2.6.11-rc3-mhf241/arch/i386/kernel/i387.c
--- linux-2.6.11-rc3-Vanilla/arch/i386/kernel/i387.c    2005-02-04 10:43:06.000000000 +0100
+++ linux-2.6.11-rc3-mhf241/arch/i386/kernel/i387.c     2005-02-04 11:12:53.000000000 +0100
@@ -526,7 +526,7 @@
        int fpvalid;
        struct task_struct *tsk = current;

-       fpvalid = tsk->used_math && cpu_has_fxsr;
+       fpvalid = !!used_math() && cpu_has_fxsr;
        if ( fpvalid ) {
                unlazy_fpu( tsk );
                memcpy( fpu, &tsk->thread.i387.fxsave,
