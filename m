Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271264AbTHMEh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 00:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271324AbTHMEh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 00:37:58 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:33516 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S271264AbTHMEh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 00:37:57 -0400
Date: Wed, 13 Aug 2003 14:37:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ronald Kuetemeier <ron_ker@kuetemeier.com>
Subject: [PATCH][DOCO] Re: 2.6.0-test3 and dnotify
Message-Id: <20030813143751.3dc0b14b.sfr@canb.auug.org.au>
In-Reply-To: <1060705727.1189.12.camel@ronald.kuetemeier.com>
References: <1060705727.1189.12.camel@ronald.kuetemeier.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On 12 Aug 2003 10:28:47 -0600 Ronald Kuetemeier <ron_ker@kuetemeier.com> wrote:
>
> I run some of my programs on 2.6.0-test3 this morning, before my coffee
> ..., anyhow seems dnotify isn't working any more. I compiled the example
> from <linux-2.6.0-test3>/Documentation/dnotify.txt this also doesn't
> work anymore.

This has been asked a couple of times, so can you please apply the
following documentation patch?
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.0-test3/Documentation/dnotify.txt 2.6.0-test3.sfr.1/Documentation/dnotify.txt
--- 2.6.0-test3/Documentation/dnotify.txt	2001-04-07 03:42:48.000000000 +1000
+++ 2.6.0-test3.sfr.1/Documentation/dnotify.txt	2003-08-13 14:32:14.000000000 +1000
@@ -32,7 +32,8 @@
 
 Preferably the application will choose one of the real time signals
 (SIGRTMIN + <n>) so that the notifications may be queued.  This is
-especially important if DN_MULTISHOT is specified.
+especially important if DN_MULTISHOT is specified.  Note that SIGRTMIN
+is often blocked, so it is better to use (at least) SIGRTMIN + 1.
 
 Implementation expectations (features and bugs :-))
 ---------------------------
@@ -78,10 +79,10 @@
 		act.sa_sigaction = handler;
 		sigemptyset(&act.sa_mask);
 		act.sa_flags = SA_SIGINFO;
-		sigaction(SIGRTMIN, &act, NULL);
+		sigaction(SIGRTMIN + 1, &act, NULL);
 		
 		fd = open(".", O_RDONLY);
-		fcntl(fd, F_SETSIG, SIGRTMIN);
+		fcntl(fd, F_SETSIG, SIGRTMIN + 1);
 		fcntl(fd, F_NOTIFY, DN_MODIFY|DN_CREATE|DN_MULTISHOT);
 		/* we will now be notified if any of the files
 		   in "." is modified or new files are created */
