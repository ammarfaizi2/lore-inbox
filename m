Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269041AbRHaTYu>; Fri, 31 Aug 2001 15:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269067AbRHaTYk>; Fri, 31 Aug 2001 15:24:40 -0400
Received: from [145.254.151.110] ([145.254.151.110]:19694 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S269041AbRHaTYZ>;
	Fri, 31 Aug 2001 15:24:25 -0400
Message-ID: <3B8FE42B.23804609@pcsystems.de>
Date: Fri, 31 Aug 2001 21:23:23 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mj@atrey.karlin.mff.cuni.cz,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]: problem: pc_keyb.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin!

Why can't I include pc_keyb.h directtly into a C program ?
I need that for a part of GPM.

nico@flapp:~/computer/programming/c/test > gcc pc_keyb.h.c
In file included from pc_keyb.h.c:3:
/usr/include/linux/pc_keyb.h:127: parse error before `wait_queue_head_t'

/usr/include/linux/pc_keyb.h:127: warning: no semicolon at end of struct
or union
/usr/include/linux/pc_keyb.h:130: parse error before `}'

When adding

#define wait_queue_head_t     struct wait_queue *

(stolen from compatmac.h)

before including pc_keyb.h it runs fine.

So I suggest the following:

================================================
flapp:/usr/include/linux # diff -u compatmac.h.orig compatmac.h


-- compatmac.h.orig    Fri Aug 31 13:14:38 2001

+++ compatmac.h Fri Aug 31 13:14:50 2001

@@ -151,7 +151,6 @@

 #ifndef TWO_THREE

 /* These are new in 2.3. The source now uses 2.3 syntax, and
here is

    the compatibility define... */

-#define wait_queue_head_t     struct wait_queue
*

 #define DECLARE_MUTEX(name)   struct semaphore name
= MUTEX

 #define DECLARE_WAITQUEUE(wait, current) \


struct wait_queue wait = { current, NULL }

================================================
and

================================================
flapp:/usr/include/linux # diff -u pc_keyb.h.orig pc_keyb.h
--- pc_keyb.h.orig      Fri Aug 31 13:15:31 2001
+++ pc_keyb.h   Fri Aug 31 13:15:40 2001
@@ -121,6 +121,8 @@
                                           but then the read function
would need
                                           a lock etc - ick */

+#define wait_queue_head_t     struct wait_queue *
+
 struct aux_queue {
        unsigned long head;
        unsigned long tail;

==================================================


Nico

