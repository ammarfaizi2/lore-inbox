Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313168AbSDDN66>; Thu, 4 Apr 2002 08:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313170AbSDDN6s>; Thu, 4 Apr 2002 08:58:48 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:52392 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S313168AbSDDN6f>; Thu, 4 Apr 2002 08:58:35 -0500
Date: Thu, 4 Apr 2002 15:58:26 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: davej@suse.de, pavel@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2.5.8-pre1] nbd compile fixes...
Message-ID: <20020404135826.GG9820@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	davej@suse.de, pavel@atrey.karlin.mff.cuni.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.8-pre1 include/linux/nbd.h a struct member name was changed
from 'queue_lock' to 'tx_lock', with the comment "nbd compile fix"
from Dave Jones.

In fact, since nbd.c still reference 'queue_lock' I suspect that
the actual modifications to nbd.c were lost somewhere in etherspace
between Dave and Linus.

Either provide the right fix for nbd.c or apply the attached patch,
which reverts the patch to nbd.h.

In other words, the attached patch provides a "nbd compile fix" by
reverting the previous "nbd compile fix" :-)

Stelian.


===== include/linux/nbd.h 1.7 vs edited =====
--- 1.7/include/linux/nbd.h	Sun Mar 31 15:43:18 2002
+++ edited/include/linux/nbd.h	Thu Apr  4 13:53:15 2002
@@ -70,7 +70,7 @@
 	struct file * file; 		/* If == NULL, device is not ready, yet	*/
 	int magic;			/* FIXME: not if debugging is off	*/
 	struct list_head queue_head;	/* Requests are added here...			*/
-	struct semaphore tx_lock;
+	struct semaphore queue_lock;
 };
 #endif
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
