Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUETGy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUETGy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 02:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265016AbUETGy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 02:54:29 -0400
Received: from ozlabs.org ([203.10.76.45]:7052 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265002AbUETGy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 02:54:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16556.21513.425381.322732@cargo.ozlabs.ibm.com>
Date: Thu, 20 May 2004 16:45:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH][PPC64] Fix inline version of _raw_spin_trylock
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I added the out-of-line spinlocks on PPC64, I inadvertently
introduced a bug in the inline version of _raw_spin_trylock, where it
returns the opposite of what it should return.  The patch below fixes
it.

Please apply.

Thanks,
Paul.

--- linux-2.5/include/asm-ppc64/spinlock.h	2004-05-15 13:32:16.000000000 +1000
+++ ppc64-linux-2.5/include/asm-ppc64/spinlock.h	2004-05-20 16:42:45.662218328 +1000
@@ -65,7 +65,7 @@
 	: "r"(&lock->lock)
 	: "cr0", "memory");
 
-	return tmp != 0;
+	return tmp == 0;
 }
 
 static __inline__ void _raw_spin_lock(spinlock_t *lock)
