Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVKQRmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVKQRmQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVKQRmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:42:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932425AbVKQRmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:42:15 -0500
Date: Thu, 17 Nov 2005 09:42:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: build error in current -git tree
In-Reply-To: <20051117171047.GA27534@kroah.com>
Message-ID: <Pine.LNX.4.64.0511170941220.13959@g5.osdl.org>
References: <20051117171047.GA27534@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Nov 2005, Greg KH wrote:
>
> In trying to build your kernel tree right now, I get the following
> error:

Heh. That's what I get for being on ppc64 now.

This should fix it (and I'll try it out on my laptop before I commit it).

		Linus

---
diff --git a/include/asm-i386/signal.h b/include/asm-i386/signal.h
index 6ba29f1..76524b4 100644
--- a/include/asm-i386/signal.h
+++ b/include/asm-i386/signal.h
@@ -186,7 +186,7 @@ static __inline__ void __gen_sigdelset(s
 	__asm__("btrl %1,%0" : "+m"(*set) : "Ir"(_sig - 1) : "cc");
 }
 
-static __inline__ void __const_sigaddset(sigset_t *set, int _sig)
+static __inline__ void __const_sigdelset(sigset_t *set, int _sig)
 {
 	unsigned long sig = _sig - 1;
 	set->sig[sig / _NSIG_BPW] &= ~(1 << (sig % _NSIG_BPW));
