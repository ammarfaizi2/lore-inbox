Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTFCH1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 03:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTFCH1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 03:27:23 -0400
Received: from verein.lst.de ([212.34.189.10]:43169 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262366AbTFCH1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 03:27:22 -0400
Date: Tue, 3 Jun 2003 09:37:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kerfnel.org
Subject: [PATCH] fix signal.h compilation
Message-ID: <20030603073753.GA21473@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@transmeta.com,
	linux-kernel@vger.kerfnel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3.2 () PATCH_UNIFIED_DIFF,RESENT_TO,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

signal.h uses spinlock_t now so it needs to include spinlock.h.
Without this compilation failes on PPC.


--- 1.12/include/linux/signal.h	Mon Jun  2 14:45:36 2003
+++ edited/include/linux/signal.h	Mon Jun  2 11:13:33 2003
@@ -1,9 +1,10 @@
 #ifndef _LINUX_SIGNAL_H
 #define _LINUX_SIGNAL_H
 
+#include <linux/list.h>
+#include <linux/spinlock.h>
 #include <asm/signal.h>
 #include <asm/siginfo.h>
-#include <linux/list.h>
 
 #ifdef __KERNEL__
 /*
