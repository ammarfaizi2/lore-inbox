Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbTBKFMP>; Tue, 11 Feb 2003 00:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbTBKFMP>; Tue, 11 Feb 2003 00:12:15 -0500
Received: from pandora.cantech.net.au ([203.26.6.29]:14861 "EHLO
	pandora.cantech.net.au") by vger.kernel.org with ESMTP
	id <S266876AbTBKFMO>; Tue, 11 Feb 2003 00:12:14 -0500
Date: Tue, 11 Feb 2003 13:21:49 +0800 (WST)
From: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>
To: "Vlad@geekizoid.com" <vlad@geekizoid.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Another Linux 2.5.60 Compile error
In-Reply-To: <009f01c2d162$4668d1f0$0200a8c0@wsl3>
Message-ID: <Pine.LNX.4.44.0302111316150.1039-100000@thor.cantech.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Vlad@geekizoid.com wrote:

> Didn't see this one reported yet:
> 
> fs/ncpfs/sock.c: In function `ncp_do_request':
> fs/ncpfs/sock.c:760: structure has no member named `sig'
> fs/ncpfs/sock.c:762: structure has no member named `sig'
> make[2]: *** [fs/ncpfs/sock.o] Error 1
> make[1]: *** [fs/ncpfs] Error 2
> make: *** [fs] Error 2

I don't know if this is correct.  It compiles for me but I don't have any
boxes to test ncpfs with :(

================================================================================
diff -X dontdiff -urN linux-2.5.60.clean/fs/ncpfs/sock.c linux-2.5.60.sighand/fs/ncpfs/sock.c
--- linux-2.5.60.clean/fs/ncpfs/sock.c	2003-02-12 10:53:54.000000000 +0800
+++ linux-2.5.60.sighand/fs/ncpfs/sock.c	2003-02-12 13:03:05.000000000 +0800
@@ -757,9 +757,9 @@
 			   What if we've blocked it ourselves?  What about
 			   alarms?  Why, in fact, are we mucking with the
 			   sigmask at all? -- r~ */
-			if (current->sig->action[SIGINT - 1].sa.sa_handler == SIG_DFL)
+			if (current->sighand->action[SIGINT - 1].sa.sa_handler == SIG_DFL)
 				mask |= sigmask(SIGINT);
-			if (current->sig->action[SIGQUIT - 1].sa.sa_handler == SIG_DFL)
+			if (current->sighand->action[SIGQUIT - 1].sa.sa_handler == SIG_DFL)
 				mask |= sigmask(SIGQUIT);
 		}
 		siginitsetinv(&current->blocked, mask);

Yours Tony.

/*
 * "The significant problems we face cannot be solved at the 
 * same level of thinking we were at when we created them."
 * --Albert Einstein
 */

