Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272144AbTHRR0t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272150AbTHRR0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:26:49 -0400
Received: from mail.webmaster.com ([216.152.64.131]:63183 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S272144AbTHRR0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:26:47 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: Mon, 18 Aug 2003 10:26:43 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEDFFDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3F409DC1.6070400@softhome.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     You probably have missed some postings on this thread.
>     This one:

[snip]

	If you think those posts are relvent, you misunderstand my point. Those
posts are from the view "if someone wants to DoS the log files, they already
can", my argument is more, "if someone doesn't want to DoS the log files,
but you make this patch, how can they avoid it?"

>      If application cannot be responsible for its children - it is just
> bad programming practice. Fix applications.
>      Reapping zombies 'just in case if any' sounds really bad.

	If we were to write code to detect bad programming practices and syslog
them, it would be nearly impossible to prevent syslog DoSes. Looping on
'waitpid(WNOHANG)' periodically is a perfectly sane way to reap zombies,
especially in cases where there are issues with signal handling and in
multithreaded programs.

	If an application does something that a programmer could sensibly decide to
and that solves problems that can't always be solved in another way, it
should not result in a syslog entry in the default configuration (unless
it's something the system administrator needs to keep track of for
security/audit reasons).

	An application should be free to terminate however it likes without
programmers getting calls from sysadmins that the application is DoSing the
syslog. If you want a special debug mode, that's fine.

	DS


