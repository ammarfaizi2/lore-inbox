Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268998AbTBWWWf>; Sun, 23 Feb 2003 17:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268999AbTBWWWf>; Sun, 23 Feb 2003 17:22:35 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:40935 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S268998AbTBWWWe>; Sun, 23 Feb 2003 17:22:34 -0500
Subject: Re: Question about Linux signal handling
From: Albert Cahalan <albert@users.sf.net>
To: developer_linux@yahoo.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Feb 2003 17:29:00 -0500
Message-Id: <1046039341.32116.34.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sanders writes:

> If I catch a signal (SIGUSR2) using "sigaction" call
> then is the signal handler replaced with default
> handling, if I don't install the signal handler again?

That depends on how you set sa_flags. Read the
sigaction man page.

> I remember that in UNIX "signal" system call default
> signal bahavior was to replace the signal handler with
> default after everytime signal was received?

Yes. This is the behavior of all SysV UNIX systems
and Linux kernels. Unfortunately, BSD got it wrong.
Worse, the glibc developers saw fit to ignore both
UNIX history and Linus. They implemented BSD behavior
by making signal() use the sigaction system call
instead of the signal system call. This of course
makes it harder to port apps from SysV UNIX systems
to Linux. Use sigaction() in all new code.




