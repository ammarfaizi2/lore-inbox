Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271335AbTHRJPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 05:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271341AbTHRJPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 05:15:33 -0400
Received: from mail.webmaster.com ([216.152.64.131]:37569 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S271335AbTHRJPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 05:15:32 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: Mon, 18 Aug 2003 02:15:29 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEBAFDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3F3EB8FA.1080605@sktc.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Valdis.Kletnieks@vt.edu wrote:

> > Consider this code:
> >
> > 	char *foo = 0;
> > 	sigset(SIGSEGV,SIG_IGNORE);
> > 	for(;;) { *foo = '\5'; }
> >
> > Your logfiles just got DoS'ed....

> Why not then just log uncaught exceptions?

	Because deliberately creating an uncaught exception is a perfectly sane,
reasonable thing to do with well-defined semantics. Applications should feel
free to do such reasonable things without getting complaints from the system
administrator that their log is being flooded with garbage.

	There is no mechanism that is guaranteed to terminate a process other than
sending yourself an exception that is not caught. So in cases where you must
guarantee that your process terminates, it is perfectly reasonable to send
yourself a SIGILL.

	FreeBSD logs any number of normal things that sane, reasonable processes do
and it's very annoying. A very annoying example is FreeBSD's desire to log
calls to 'wait' functions with 'SIGCHLD' ignored. How else can portable
programs say, "I want you to automatically reap my zombies if you can, but
otherwise, I'll reap them if needed by calling waitpid(WNOHANG) every once
in a while".

	DS


