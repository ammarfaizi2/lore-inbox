Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132902AbRDJCmD>; Mon, 9 Apr 2001 22:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132904AbRDJCly>; Mon, 9 Apr 2001 22:41:54 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:32762 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S132902AbRDJCli>; Mon, 9 Apr 2001 22:41:38 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <ram@kasenna.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Increasing the FD_SETSIZE
Date: Mon, 9 Apr 2001 19:41:35 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKAECOOEAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
In-Reply-To: <3AD26831.9DAA0BDE@kasenna.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I am having trouble with increasing the file descriptor size for my
> application - it opens several files for each client session (and needs
> to keep them open as long as the session is active, which can be upto 3
> hours long). What I see from the application is "open failed in
> FileStreamReader::setupFile: Too many open files".
>
> I have bumped up /proc/sys/fs/file-max to 16K, but I am failing at  2638
> (cat /proc/sys/fs/file-max returns "2638 97 16384") when the number of
> files my app opened reached 1023.
>
> There is a comment in /usr/include/linux/posix_types.h regarding
> __FD_SETSIZE being set to 1024. How can I increase this value?

	You are tinkering with the wrong value. FD_SETSIZE affects fd_sets used in
the 'select' system call. If you don't use select (and you shouldn't) it's
not an issue.

	Also, tampering with the system-wide limits is the wrong approach too.
There is no problem in the kernel for you to fix.

	What you are hitting is a per-process resource limit. Read the man pages on
'setrlimit' or the bash help on 'ulimit'.

	DS

