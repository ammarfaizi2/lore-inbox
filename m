Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030706AbWI0TiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030706AbWI0TiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030708AbWI0TiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:38:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:26546 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030704AbWI0TiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:38:09 -0400
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] Oops on boot (probably ACPI related)
References: <200609271424.47824.eike-kernel@sf-tec.de>
From: Andi Kleen <ak@suse.de>
Date: 27 Sep 2006 21:38:03 +0200
In-Reply-To: <200609271424.47824.eike-kernel@sf-tec.de>
Message-ID: <p73k63pje1w.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer <eike-kernel@sf-tec.de> writes:

> I get this on my machine. SMP kernel, linus git from this morning. .config and 
> test available on request.

What gcc do you use?

Anyways, does this patch fix it? This might have been Andrew's vaio problem too.

-Andi

i386: Use early clobbers for semaphores now

The new code does clobber the result early, so make sure to tell
gcc to not put it into the same register as a input argument

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/asm-i386/semaphore.h
===================================================================
--- linux.orig/include/asm-i386/semaphore.h
+++ linux/include/asm-i386/semaphore.h
@@ -126,7 +126,7 @@ static inline int down_interruptible(str
 		"lea %1,%%eax\n\t"
 		"call __down_failed_interruptible\n"
 		"2:"
-		:"=a" (result), "+m" (sem->count)
+		:"=&a" (result), "+m" (sem->count)
 		:
 		:"memory");
 	return result;
@@ -148,7 +148,7 @@ static inline int down_trylock(struct se
 		"lea %1,%%eax\n\t"
 		"call __down_failed_trylock\n\t"
 		"2:\n"
-		:"=a" (result), "+m" (sem->count)
+		:"=&a" (result), "+m" (sem->count)
 		:
 		:"memory");
 	return result;
