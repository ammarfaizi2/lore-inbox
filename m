Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276894AbRK1ROz>; Wed, 28 Nov 2001 12:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRK1ROq>; Wed, 28 Nov 2001 12:14:46 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:19144 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S276894AbRK1ROk>;
	Wed, 28 Nov 2001 12:14:40 -0500
Date: Wed, 28 Nov 2001 11:14:32 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Small bugfix in signal code in exec.c
Message-ID: <62120000.1006967672@baldur>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a small bug, not likely to be hit often, but likely painful if it
does trigger.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059


-------------------------

--- linux-2.4.16/fs/exec.c	Fri Nov  2 19:39:20 2001
+++ linux-2.4.16/fs/exec.c.new	Wed Nov 28 11:06:25 2001
@@ -586,7 +586,7 @@
 flush_failed:
 	spin_lock_irq(&current->sigmask_lock);
 	if (current->sig != oldsig) {
-		kfree(current->sig);
+		kmem_cache_free(sigact_cachep, current->sig);
 		current->sig = oldsig;
 	}
 	spin_unlock_irq(&current->sigmask_lock);

