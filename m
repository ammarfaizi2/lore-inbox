Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270583AbUJUB35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270583AbUJUB35 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270594AbUJUBZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:25:50 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:10725 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S270710AbUJUBQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:16:18 -0400
Date: Thu, 21 Oct 2004 03:17:14 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041021011714.GQ24619@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see why this 'int x' exists, alignment should really work fine
even with empty structure (works with my compiler with an userspace
test, please double check).

Index: linux-2.5/include/linux/mmzone.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/linux/mmzone.h,v
retrieving revision 1.67
diff -u -p -r1.67 mmzone.h
--- linux-2.5/include/linux/mmzone.h	19 Oct 2004 14:58:00 -0000	1.67
+++ linux-2.5/include/linux/mmzone.h	21 Oct 2004 01:14:20 -0000
@@ -35,7 +35,6 @@ struct pglist_data;
  */
 #if defined(CONFIG_SMP)
 struct zone_padding {
-	int x;
 } ____cacheline_maxaligned_in_smp;
 #define ZONE_PADDING(name)	struct zone_padding name;
 #else
