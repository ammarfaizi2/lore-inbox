Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274766AbRJJFOy>; Wed, 10 Oct 2001 01:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274774AbRJJFOn>; Wed, 10 Oct 2001 01:14:43 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:63278 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274766AbRJJFOe>; Wed, 10 Oct 2001 01:14:34 -0400
Subject: Re: Compile Filure on 2.4.10-ac10+preempt+smp
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011009214655.A26663@mikef-linux.matchmail.com>
In-Reply-To: <20011009214655.A26663@mikef-linux.matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 10 Oct 2001 01:15:25 -0400
Message-Id: <1002690949.862.233.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-10 at 00:46, Mike Fedyk wrote:
> Fail    2.4.10-ac10+preempt+smp
> Success 2.4.10-ac10+preempt+up-apic+up-ipapic
> Success 2.4.10-ac10+preempt
> Success 2.4.10-ac10
> 
> Robert, can you do a test compile for smp just in case?

Ahh, yes.  Thank you for spotting this.  include/asm-i386/spinlock.h has
two separate defines for spin_unlock and we only renamed one of them.  I
guess you hit the conditional that used the other define...

The attached patch fixes it.

> Also, I couldn't find any links to old patches on your web site...
> [...]

I only keep around patches to the last official kernel, plus the latest
-pre and -ac I patched.  Since the patch itself is being updated, its a
pain to backport to older kernels.


--- linux-2.4.10-ac10/include/asm-i386/spinlock.h.orig	Mon Oct  8 18:33:10 2001
+++ linux-2.4.10-ac10/include/asm-i386/spinlock.h	Wed Oct 10 01:08:47 2001
@@ -97,7 +97,7 @@
 		:"=q" (oldval), "=m" (lock->lock) \
 		:"0" (1) : "memory"
 
-static inline void spin_unlock(spinlock_t *lock)
+static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 	char oldval;
 #if SPINLOCK_DEBUG


	Robert Love

