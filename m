Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSFDOMz>; Tue, 4 Jun 2002 10:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSFDOMy>; Tue, 4 Jun 2002 10:12:54 -0400
Received: from mgw-x1.nokia.com ([131.228.20.21]:14540 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S311710AbSFDOMy>;
	Tue, 4 Jun 2002 10:12:54 -0400
Date: Tue, 4 Jun 2002 17:08:55 +0300
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Bug in asm-i386/rwlock.h
Message-ID: <20020604140855.GA6967@terrapin>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: alexey.vyskubov@nokia.com (Alexey Vyskubov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

We suppose that include/asm-i386/rwlock.h contains a bug.

Under some circumstances (compiling some external modules + no
optimization + SMP) it's possible to get the following error:

/tmp/ccw7qDe1.s: Assembler messages:
/tmp/ccw7qDe1.s:6815: Error: bad expression
/tmp/ccw7qDe1.s:6815: Error: missing ')'
/tmp/ccw7qDe1.s:6815: Error: missing ')'
/tmp/ccw7qDe1.s:6815: Error: junk `ebx))' after expression

We believe that it's a typo in include/asm-i386/rwlock.h

--- include/asm-i386/rwlock.h.orig      Tue Jun  4 16:32:38 2002
+++ include/asm-i386/rwlock.h   Tue Jun  4 16:33:02 2002
@@ -61,7 +61,7 @@
                     ::"a" (rw) : "memory")
 
 #define __build_write_lock_const(rw, helper) \
-       asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
+       asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
                     "jnz 2f\n" \
                     "1:\n" \
                     ".section .text.lock,\"ax\"\n" \

-- 
Alexey Vyskubov
Dmitry Kasatkin
Nokia Research Center / Helsinki
