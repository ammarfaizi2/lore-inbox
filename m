Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135883AbRDTMLZ>; Fri, 20 Apr 2001 08:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135885AbRDTMLP>; Fri, 20 Apr 2001 08:11:15 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:56329 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S135883AbRDTMLG>; Fri, 20 Apr 2001 08:11:06 -0400
Date: Fri, 20 Apr 2001 16:04:43 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic rw_semaphores, compile warnings patch
Message-ID: <20010420160443.A12528@jurassic.park.msu.ru>
In-Reply-To: <15071.30776.914468.900710@pizda.ninka.net> <24459.987753038@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <24459.987753038@warthog.cambridge.redhat.com>; from dhowells@cambridge.redhat.com on Fri, Apr 20, 2001 at 08:50:38AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 08:50:38AM +0100, David Howells wrote:
> There's also a missing "struct rw_semaphore;" declaration in linux/rwsem.h. It
> needs to go in the gap below "#include <linux/wait.h>". Otherwise the
> declarations for the contention handling functions will give warnings about
> the struct being declared in the parameter list.

Also on alpha __u16 is undeclared in rwsem.c, and old rwsem code wasn't
cleaned up properly.

Ivan.

--- 2.4.4p5/include/linux/rwsem-spinlock.h	Fri Apr 20 14:06:50 2001
+++ linux/include/linux/rwsem-spinlock.h	Fri Apr 20 15:37:28 2001
@@ -14,6 +14,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/types.h>
+
 /*
  * the semaphore definition
  */
--- 2.4.4p5/include/asm-alpha/semaphore.h	Fri Apr 20 13:53:28 2001
+++ linux/include/asm-alpha/semaphore.h	Fri Apr 20 15:37:28 2001
@@ -225,5 +225,3 @@ extern inline void up(struct semaphore *
 #endif
 
 #endif
-
-#endif
--- 2.4.4p5/arch/alpha/kernel/alpha_ksyms.c	Fri Apr 20 13:52:56 2001
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Fri Apr 20 14:01:36 2001
@@ -173,9 +173,6 @@ EXPORT_SYMBOL(down);
 EXPORT_SYMBOL(down_interruptible);
 EXPORT_SYMBOL(down_trylock);
 EXPORT_SYMBOL(up);
-EXPORT_SYMBOL(__down_read_failed);
-EXPORT_SYMBOL(__down_write_failed);
-EXPORT_SYMBOL(__rwsem_wake);
 EXPORT_SYMBOL(down_read);
 EXPORT_SYMBOL(down_write);
 EXPORT_SYMBOL(up_read);
