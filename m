Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269629AbUJGNvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269629AbUJGNvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUJGNvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:51:21 -0400
Received: from science.horizon.com ([192.35.100.1]:22327 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S269629AbUJGNvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:51:11 -0400
Date: 7 Oct 2004 13:51:10 -0000
Message-ID: <20041007135110.16475.qmail@science.horizon.com>
From: linux@horizon.com
To: aeb@cwi.nl, linux-kernel@vger.kernel.org
Subject: [PATCH] poll(2) man page, likewise.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As before, the changes are a work of original authorship, and copyright
is abandoned to the public domain.

--- man2/poll.2.old	2004-10-07 09:10:03.000000000 -0400
+++ man2/poll.2	2004-10-07 09:22:14.000000000 -0400
@@ -130,6 +130,12 @@
 The
 .I nfds
 value exceeds the RLIMIT_NOFILE value.
+.SH BUGS
+.B poll
+permits a blocking file descritor in
+.IR ufds ,
+even though there is no valid reason for a program to ever do this, and it is
+a common beginner's mistake.
 .SH "CONFORMING TO"
 XPG4-UNIX.
 .SH AVAILABILITY
@@ -137,6 +143,42 @@
 The poll() library call was introduced in libc 5.4.28
 (and provides emulation using select if your kernel does not
 have a poll syscall).
+.SH NOTES
+When
+.B poll
+indicates that a file descriptor is ready, this is only a strong hint,
+not a guarantee, that a read or write is possible without blocking.
+For this reason, the associated file descriptors
+.I must always be in non-blocking mode
+(see
+.BR fcntl (2))
+in a correct program.  Reasons why the I/O could block include:
+.TP
+(i)
+Another process may have performed I/O on the
+.I fd
+in the meantime.
+.TP
+(ii)
+Some needed kernel buffer space may have been consumed for reasons
+totally unrelated to this I/O, or
+.TP
+(iii)
+Since 2.4.x, Linux has overlapped UDP checksum verification with
+copying to user-space.  If a UDP packet arrives,
+.B poll
+will indicate that data is ready, but during the read, if the checksum is
+bad, the packet will disappear and (if no subsequent packet with a
+valid checksum is waiting) the read will indicate that no data is available.
+.PP
+In general, it is legal for
+.B poll
+to make some optimistic assumptions, subject to later verification by the
+subsequent I/O, as long as this does not result in a busy-loop where
+.B poll
+is stuck thinking data is ready when it is not.
+
 .SH "SEE ALSO"
+.BR fcntl (2),
 .BR select (2),
 .BR select_tut (2)
