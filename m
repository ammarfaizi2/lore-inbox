Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWAUVZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWAUVZE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWAUVZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:25:04 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:64682 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S932363AbWAUVZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:25:03 -0500
To: philb@gnu.org, tim@cyberelk.net, campbell@torque.net, andrea@suse.de
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: [PATCH] parport: fix documentation
From: Arnaud Giersch <arnaud.giersch@free.fr>
Date: Sat, 21 Jan 2006 22:24:59 +0100
Message-ID: <87mzhpe0k4.fsf@groumpf.homeip.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Giersch <arnaud.giersch@free.fr>

Fix documentation to actually match the code.

Signed-off-by: Arnaud Giersch <arnaud.giersch@free.fr>
---

 Documentation/parport-lowlevel.txt |    8 ++++----
 drivers/parport/ieee1284.c         |   10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2.6.16-rc1.orig/Documentation/parport-lowlevel.txt	2006-01-17 08:44:47.000000000 +0100
+++ linux-2.6.16-rc1/Documentation/parport-lowlevel.txt	2006-01-21 21:39:08.501249608 +0100
@@ -1068,7 +1068,7 @@ SYNOPSIS
 
 struct parport_operations {
 	...
-	void (*write_status) (struct parport *port, unsigned char s);
+	void (*write_control) (struct parport *port, unsigned char s);
 	...
 };
 
@@ -1097,9 +1097,9 @@ SYNOPSIS
 
 struct parport_operations {
 	...
-	void (*frob_control) (struct parport *port,
-	                      unsigned char mask,
-			      unsigned char val);
+	unsigned char (*frob_control) (struct parport *port,
+				       unsigned char mask,
+				       unsigned char val);
 	...
 };
 
--- linux-2.6.16-rc1.orig/drivers/parport/ieee1284.c	2006-01-17 08:44:47.000000000 +0100
+++ linux-2.6.16-rc1/drivers/parport/ieee1284.c	2006-01-21 21:39:08.504248053 +0100
@@ -61,10 +61,10 @@ static void timeout_waiting_on_port (uns
  *	set to zero, it returns immediately.
  *
  *	If an interrupt occurs before the timeout period elapses, this
- *	function returns one immediately.  If it times out, it returns
- *	a value greater than zero.  An error code less than zero
- *	indicates an error (most likely a pending signal), and the
- *	calling code should finish what it's doing as soon as it can.
+ *	function returns zero immediately.  If it times out, it returns
+ *	one.  An error code less than zero indicates an error (most
+ *	likely a pending signal), and the calling code should finish
+ *	what it's doing as soon as it can.
  */
 
 int parport_wait_event (struct parport *port, signed long timeout)
@@ -110,7 +110,7 @@ int parport_wait_event (struct parport *
  *
  *	If the status lines take on the desired values before the
  *	timeout period elapses, parport_poll_peripheral() returns zero
- *	immediately.  A zero return value greater than zero indicates
+ *	immediately.  A return value greater than zero indicates
  *	a timeout.  An error code (less than zero) indicates an error,
  *	most likely a signal that arrived, and the caller should
  *	finish what it is doing as soon as possible.
