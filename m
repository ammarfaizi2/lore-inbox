Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRCCPmo>; Sat, 3 Mar 2001 10:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129175AbRCCPmf>; Sat, 3 Mar 2001 10:42:35 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:38925 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129072AbRCCPm0>;
	Sat, 3 Mar 2001 10:42:26 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103031542.SAA25105@ms2.inr.ac.ru>
Subject: Re: Another rsync over ssh hang (repeatable, with 2.4.1 on both ends)
To: laird@internap.COM (Scott Laird)
Date: Sat, 3 Mar 2001 18:42:16 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0103011607540.17365-100000@laird.ocp.internap.com> from "Scott Laird" at Mar 2, 1 03:45:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> this kernel was compiled with GCC 2.95.2,

This is a hint.

Could you make the following things:

1. to disassemble tcp_poll() (the easiest way is to gdb vmlinux, to 
   say x/i tcp_poll and to hold enter pressed long enough, copying screen
   to file) and to send the result to me.
2. to apply the enclosed patchlet.
3. if 3 does not change anything, recompile with egcs-1.1.2

Alexey



--- ../vger3-010223/linux/net/ipv4/tcp.c	Fri Feb 23 21:28:34 2001
+++ linux/net/ipv4/tcp.c	Sat Mar  3 18:37:22 2001
@@ -442,6 +443,8 @@
 				set_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
 				set_bit(SOCK_NOSPACE, &sk->socket->flags);
 
+				barrier();
+
 				/* Race breaker. If space is freed after
 				 * wspace test but before the flags are set,
 				 * IO signal will be lost.
