Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTJ0Nz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 08:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTJ0Nz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 08:55:29 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:15565 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262868AbTJ0NzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 08:55:19 -0500
Date: Mon, 27 Oct 2003 14:55:15 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org
Subject: [BK PATCH] TRIVIAL 2.6 patch to fix /proc/tty/driver/serial for non-CAP_SYS_ADMIN user
Message-ID: <20031027135515.GA28577@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	torvalds@osdl.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I have a patch that touches drivers/serial/serial_core.c to fix a
problem with /proc/tty/driver/serial that affects users without
CAP_SYS_ADMIN capability (unprivileged users):

DIFFSTAT:

# serial_core.c |    3 +++
# 1 files changed, 3 insertions(+)

example broken output:

serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:41: uart:16550A port:000002F8 irq:32:
uart:unknown port:000003E8 irq:4
3: uart:unknown port:000002E8 irq:3
...

Lines for 0 and 1 are run together.

The attached BK patch below fixes this to:

0: uart:16550A port:000003F8 irq:4
1: uart:16550A port:000002F8 irq:3
2: uart:unknown port:000003E8 irq:4
3: uart:unknown port:000002E8 irq:3
...

"Root mode" is unaffected.

PULL FROM bk://129.217.163.1/linux-2.5/

ATTACHED is "bk send -" output SUITABLE FOR: bk receive

GNU PATCH (do not apply, use the BK stuff instead)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1359  -> 1.1359.1.1
#	drivers/serial/serial_core.c	1.72    -> 1.73   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/27	matthias.andree@gmx.de	1.1359.1.1
# Properly terminate /proc/tty/driver/serial output lines of known UARTS
# when the caller has no CAP_SYS_ADMIN capability.
# --------------------------------------------
#
diff -Nru a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c	Mon Oct 27 14:51:11 2003
+++ b/drivers/serial/serial_core.c	Mon Oct 27 14:51:11 2003
@@ -1707,6 +1707,9 @@
 		strcat(stat_buf, "\n");
 	
 		ret += sprintf(buf + ret, stat_buf);
+	} else {
+		strcat(buf, "\n");
+		ret++;
 	}
 #undef STATBIT
 #undef INFOBIT

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fix-serial

This BitKeeper patch contains the following changesets:
1.1359.1.1

# User:	matthias.andree
# Host:	gmx.de
# Root:	/suse/kernel/BK/linux-2.5

# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
tausq@debian.org[torvalds]|ChangeSet|20031026222704|00647
D 1.1359.1.1 03/10/27 06:29:34+01:00 matthias.andree@gmx.de +1 -0
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

# Patch checksum=054a94a0

--Nq2Wo0NMKNjxTN9z--
