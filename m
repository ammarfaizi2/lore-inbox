Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWEITcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWEITcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWEITcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:32:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59834 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750963AbWEITcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:32:08 -0400
Subject: PATCH: Final rio polish
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 May 2006 20:44:04 +0100
Message-Id: <1147203844.3172.148.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

At this point I think its time to remind Al Viro he
promised that if I cleaned it up he'd mark it up and
check it with sparse ;)

Alan

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.17-rc3/drivers/char/Kconfig linux-2.6.17-rc3/drivers/char/Kconfig
--- linux.vanilla-2.6.17-rc3/drivers/char/Kconfig	2006-05-02 15:43:26.000000000 +0100
+++ linux-2.6.17-rc3/drivers/char/Kconfig	2006-05-08 16:45:06.881767720 +0100
@@ -291,7 +291,7 @@
 
 config RIO
 	tristate "Specialix RIO system support"
-	depends on SERIAL_NONSTANDARD && !64BIT
+	depends on SERIAL_NONSTANDARD
 	help
 	  This is a driver for the Specialix RIO, a smart serial card which
 	  drives an outboard box that can support up to 128 ports.  Product
diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.17-rc3/drivers/char/rio/host.h linux-2.6.17-rc3/drivers/char/rio/host.h
--- linux.vanilla-2.6.17-rc3/drivers/char/rio/host.h	2006-05-02 15:43:26.000000000 +0100
+++ linux-2.6.17-rc3/drivers/char/rio/host.h	2006-05-08 16:53:16.153387128 +0100
@@ -33,12 +33,6 @@
 #ifndef __rio_host_h__
 #define __rio_host_h__
 
-#ifdef SCCS_LABELS
-#ifndef lint
-static char *_host_h_sccs_ = "@(#)host.h	1.2";
-#endif
-#endif
-
 /*
 ** the host structure - one per host card in the system.
 */
@@ -77,9 +71,6 @@
 #define RC_STARTUP            1
 #define RC_RUNNING            2
 #define RC_STUFFED            3
-#define RC_SOMETHING          4
-#define RC_SOMETHING_NEW      5
-#define RC_SOMETHING_ELSE     6
 #define RC_READY              7
 #define RUN_STATE             7
 /*
diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.17-rc3/drivers/char/rio/rioioctl.h linux-2.6.17-rc3/drivers/char/rio/rioioctl.h
--- linux.vanilla-2.6.17-rc3/drivers/char/rio/rioioctl.h	2006-05-02 15:42:24.000000000 +0100
+++ linux-2.6.17-rc3/drivers/char/rio/rioioctl.h	2006-05-08 16:50:48.920769888 +0100
@@ -33,10 +33,6 @@
 #ifndef	__rioioctl_h__
 #define	__rioioctl_h__
 
-#ifdef SCCS_LABELS
-static char *_rioioctl_h_sccs_ = "@(#)rioioctl.h	1.2";
-#endif
-
 /*
 ** RIO device driver - user ioctls and associated structures.
 */
@@ -44,55 +40,13 @@
 struct portStats {
 	int port;
 	int gather;
-	ulong txchars;
-	ulong rxchars;
-	ulong opens;
-	ulong closes;
-	ulong ioctls;
+	unsigned long txchars;
+	unsigned long rxchars;
+	unsigned long opens;
+	unsigned long closes;
+	unsigned long ioctls;
 };
 
-
-#define rIOC	('r'<<8)
-#define	TCRIOSTATE	(rIOC | 1)
-#define	TCRIOXPON	(rIOC | 2)
-#define	TCRIOXPOFF	(rIOC | 3)
-#define	TCRIOXPCPS	(rIOC | 4)
-#define	TCRIOXPRINT	(rIOC | 5)
-#define TCRIOIXANYON	(rIOC | 6)
-#define	TCRIOIXANYOFF	(rIOC | 7)
-#define TCRIOIXONON	(rIOC | 8)
-#define	TCRIOIXONOFF	(rIOC | 9)
-#define	TCRIOMBIS	(rIOC | 10)
-#define	TCRIOMBIC	(rIOC | 11)
-#define	TCRIOTRIAD	(rIOC | 12)
-#define TCRIOTSTATE	(rIOC | 13)
-
-/*
-** 15.10.1998 ARG - ESIL 0761 part fix
-** Add RIO ioctls for manipulating RTS and CTS flow control, (as LynxOS
-** appears to not support hardware flow control).
-*/
-#define TCRIOCTSFLOWEN	(rIOC | 14)	/* enable CTS flow control */
-#define TCRIOCTSFLOWDIS	(rIOC | 15)	/* disable CTS flow control */
-#define TCRIORTSFLOWEN	(rIOC | 16)	/* enable RTS flow control */
-#define TCRIORTSFLOWDIS	(rIOC | 17)	/* disable RTS flow control */
-
-/*
-** 09.12.1998 ARG - ESIL 0776 part fix
-** Definition for 'RIOC' also appears in daemon.h, so we'd better do a
-** #ifndef here first.
-** 'RIO_QUICK_CHECK' also #define'd here as this ioctl is now
-** allowed to be used by customers.
-**
-** 05.02.1999 ARG -
-** This is what I've decied to do with ioctls etc., which are intended to be
-** invoked from users applications :
-** Anything that needs to be defined here will be removed from daemon.h, that
-** way it won't end up having to be defined/maintained in two places. The only
-** consequence of this is that this file should now be #include'd by daemon.h
-**
-** 'stats' ioctls now #define'd here as they are to be used by customers.
-*/
 #define	RIOC	('R'<<8)|('i'<<16)|('o'<<24)
 
 #define	RIO_QUICK_CHECK	  	(RIOC | 105)

