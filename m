Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265680AbSKAKTm>; Fri, 1 Nov 2002 05:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265685AbSKAKTm>; Fri, 1 Nov 2002 05:19:42 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:36528 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265680AbSKAKTk>; Fri, 1 Nov 2002 05:19:40 -0500
Date: Fri, 1 Nov 2002 03:25:54 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: davidel@xmailserver.org
Cc: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.45/fs/fcblist.c - export symbols for unix sockets
Message-ID: <20021101032554.A441@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.5.45/fs/fcblist.c contains some symbols that are
needed for unix domain sockets if unix sockets are compiled as a
module.  fcblist.o is already in the export-objs declaration in
fs/Makefile, so I think the intention was for the EXPORT_SYMBOL
declarations to be in that file.

	Here is the patch.  I have verified that unix domain sockets
load with this patch (possibly with some more EXPORT_SYMBOL changes in
my netsyms.c, which has a bunch of additional exports).

	Davide: please let me know if this patch is OK (others are
welcome to comment too), and, if so, if you are going to forward this
to Linus or if you want me to do something more.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fcblist.diff"

--- linux-2.5.45/fs/fcblist.c	2002-10-30 16:43:07.000000000 -0800
+++ linux/fs/fcblist.c	2002-10-31 02:39:38.000000000 -0800
@@ -31,6 +31,7 @@
 	0,		/* POLL_PRI */
 	ION_HUP		/* POLL_HUP */
 };
+EXPORT_SYMBOL(ion_band_table);
 
 long poll_band_table[NSIGPOLL] = {
 	POLLIN | POLLRDNORM,			/* POLL_IN */
@@ -40,6 +41,7 @@
 	POLLPRI | POLLRDBAND,			/* POLL_PRI */
 	POLLHUP | POLLERR			/* POLL_HUP */
 };
+EXPORT_SYMBOL(poll_band_table);
 
 
 
@@ -65,6 +67,7 @@
 
 	read_unlock_irqrestore(&filep->f_cblock, flags);
 }
+EXPORT_SYMBOL(file_notify_event);
 
 
 /*

--9amGYk9869ThD9tj--
