Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129379AbQKOVWv>; Wed, 15 Nov 2000 16:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQKOVWl>; Wed, 15 Nov 2000 16:22:41 -0500
Received: from mail-03-real.cdsnet.net ([63.163.68.110]:37647 "HELO
	mail-03-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129501AbQKOVW1>; Wed, 15 Nov 2000 16:22:27 -0500
Message-ID: <3A12F852.E578E6CE@mvista.com>
Date: Wed, 15 Nov 2000 12:55:46 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: In line ASM magic?  What is this?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to understand what is going on in the following code.  The
reference for %2, i.e. "m"(*__xg(ptr)) seems like magic (from
.../include/i386/system.h).  At the same time, the code "m" (*mem) from
the second __asm__ below (my code) seems to generate the required asm
code.  Before I go with the simple version, could someone tell me why? 
Inquiring minds want to know.

struct __xchg_dummy { unsigned long a[100]; };
#define __xg(x) ((struct __xchg_dummy *)(x))

		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %b1,%2"
				     : "=a"(prev)
				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
				     : "memory");


	__asm__ __volatile__(
                             LOCK "cmpxchgl %1,%2\n\t"
                             :"=a" (result)
                             :"r" (new),
                              "m" (*mem),
                              "a0" (test)
                             : "memory");


George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
