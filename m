Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270957AbRHTAsP>; Sun, 19 Aug 2001 20:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270962AbRHTAsF>; Sun, 19 Aug 2001 20:48:05 -0400
Received: from Cambot.lecs.CS.UCLA.EDU ([131.179.144.110]:42765 "EHLO
	cambot.lecs.cs.ucla.edu") by vger.kernel.org with ESMTP
	id <S270957AbRHTArz>; Sun, 19 Aug 2001 20:47:55 -0400
Message-Id: <200108200048.f7K0m8k11749@cambot.lecs.cs.ucla.edu>
To: linux-kernel@vger.kernel.org
cc: jelson@circlemud.org, alan@redhat.com, torvalds@transmeta.com
Subject: [PATCH] kernel 2.4.x: __wake_up_sync should be exported
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11746.998268488.1@cambot.lecs.cs.ucla.edu>
Date: Sun, 19 Aug 2001 17:48:08 -0700
From: Jeremy Elson <jelson@circlemud.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tried using wake_up_interruptible_sync() from a kernel module,
and found that __wake_up_sync wasn't being exported.  Here's a
one-line patch to ksyms.c to fix that.

diff -u --recursive linux-2.4.9-orig/kernel/ksyms.c linux-2.4.9/kernel
--- linux-2.4.9-orig/kernel/ksyms.c     Sun Aug 19 17:44:16 2001
+++ linux-2.4.9/kernel/ksyms.c  Sun Aug 19 17:41:50 2001
@@ -434,6 +434,7 @@
 /* process management */
 EXPORT_SYMBOL(complete_and_exit);
 EXPORT_SYMBOL(__wake_up);
+EXPORT_SYMBOL(__wake_up_sync);
 EXPORT_SYMBOL(wake_up_process);
 EXPORT_SYMBOL(sleep_on);
 EXPORT_SYMBOL(sleep_on_timeout);

Regards,
Jeremy
