Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbTJ2DMj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 22:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTJ2DMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 22:12:39 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:52188 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261750AbTJ2DMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 22:12:36 -0500
Date: Wed, 29 Oct 2003 04:12:32 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH/BK] RESEND TRIVIAL fix run-together lines in /proc/tty/driver/serial
Message-ID: <20031029031232.GA18071@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

/proc/tty/driver/serial runs together lines for known UARTS when the
user has no CAP_SYS_ADMIN capabilities. The patch below fixes this.
Works and fixes the problem for me.
GNU patch and BK send format below, or bk pull bk://129.217.163.1/linux-2.5/


 serial_core.c |    3 +++
  1 files changed, 3 insertions(+)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1350.1.9 -> 1.1350.2.1
#	drivers/serial/serial_core.c	1.72    -> 1.73   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/26	torvalds@home.osdl.org	1.1350.1.10
# Add a sticky "PF_DEAD" task flag to keep track of dead processes.
# 
# Use this to simplify 'finish_task_switch', but perhaps more
# importantly we can use this to track down why some processes
# seem to sometimes not die properly even after having been
# marked as ZOMBIE. The "task->state" flags are too fluid to 
# allow that well.
# --------------------------------------------
# 03/10/27	matthias.andree@gmx.de	1.1350.2.1
# Properly terminate /proc/tty/driver/serial output lines of known UARTS
# when the caller has no CAP_SYS_ADMIN capability.
# --------------------------------------------
#
diff -Nru a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c	Wed Oct 29 04:10:06 2003
+++ b/drivers/serial/serial_core.c	Wed Oct 29 04:10:06 2003
@@ -1707,6 +1707,9 @@
 		strcat(stat_buf, "\n");
 	
 		ret += sprintf(buf + ret, stat_buf);
+	} else {
+		strcat(buf, "\n");
+		ret++;
 	}
 #undef STATBIT
 #undef INFOBIT

BK SEND FORMAT:

This BitKeeper patch contains the following changesets:
1.1350.2.1

# User:	matthias.andree
# Host:	gmx.de
# Root:	/suse/kernel/BK/linux-2.5

# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
tausq@debian.org[torvalds]|ChangeSet|20031026222704|00647
D 1.1350.2.1 03/10/27 06:29:34+01:00 matthias.andree@gmx.de +1 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Properly terminate /proc/tty/driver/serial output lines of known UARTS
c when the caller has no CAP_SYS_ADMIN capability.
K 24
P ChangeSet
------------------------------------------------

0a0
> rmk@arm.linux.org.uk|drivers/serial/serial_core.c|20020721233929|00111|3231cf8b6efd7067 matthias.andree@gmx.de|drivers/serial/serial_core.c|20031027050655|19065

== drivers/serial/serial_core.c ==
rmk@arm.linux.org.uk|drivers/serial/serial_core.c|20020721233929|00111|3231cf8b6efd7067
rddunlap@osdl.org[torvalds]|drivers/serial/serial_core.c|20031006052957|16317
D 1.73 03/10/27 06:06:55+01:00 matthias.andree@gmx.de +3 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Properly terminate /proc/tty/driver/serial output lines of known UARTS
c when the caller has no CAP_SYS_ADMIN capability.
K 19065
O -rw-rw-r--
P drivers/serial/serial_core.c
------------------------------------------------

I1709 3
	} else {
		strcat(buf, "\n");
		ret++;

# Patch checksum=e2499498

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
