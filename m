Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQLQJzu>; Sun, 17 Dec 2000 04:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbQLQJzk>; Sun, 17 Dec 2000 04:55:40 -0500
Received: from mx1.eskimo.com ([204.122.16.48]:42506 "EHLO mx1.eskimo.com")
	by vger.kernel.org with ESMTP id <S129655AbQLQJzf>;
	Sun, 17 Dec 2000 04:55:35 -0500
Date: Sun, 17 Dec 2000 01:25:06 -0800 (PST)
From: Clayton Weaver <cgweav@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: klogd -f logname "append to logname" patch
Message-ID: <Pine.SUN.3.96.1001217011004.16489A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(For anyone else who shares the opinion that

  klogd -f /var/log/kmsg -x

should append to its kmsg log file instead of overwriting it.)

-f insulates klogd messages from syslogd bugs (although you can't split
them up into multiple files the way that /etc/syslog.conf enables). You
can always solve any klogd-to-syslogd problem *after* you find out what
is otherwise wrong with your kernel (and lose the -f switch then if that's
what you prefer or require). But when you are debugging a kernel deadlock
with no oops, for example, and actually have local persistent storage
to write to, it helps if the next hard reset doesn't truncate the -f
pathname when klogd opens it.

--- klogd.c.orig	Mon Sep 18 00:34:11 2000
+++ klogd.c	Wed Nov 29 14:06:40 2000
@@ -1109,7 +1109,7 @@
 	{
 		if ( strcmp(output, "-") == 0 )
 			output_file = stdout;
-		else if ( (output_file = fopen(output, "w")) == (FILE *) 0 )
+		else if ( (output_file = fopen(output, "a")) == (FILE *) 0 )
 		{
 			fprintf(stderr, "klogd: Cannot open output file " \
 				"%s - %s\n", output, strerror(errno));

Regards,

Clayton Weaver
<mailto:cgweav@eskimo.com>
(Seattle)

"Everybody's ignorant, just in different subjects."  Will Rogers



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
