Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261871AbSJIRQg>; Wed, 9 Oct 2002 13:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261878AbSJIRQg>; Wed, 9 Oct 2002 13:16:36 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:31650 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261871AbSJIRQf>; Wed, 9 Oct 2002 13:16:35 -0400
Date: Wed, 9 Oct 2002 12:19:11 -0500
From: David Kleikamp <shaggy@austin.ibm.com>
Message-Id: <200210091719.g99HJBVM001363@kleikamp.austin.ibm.com>
To: rmk@flint.arm.linux.org.uk
Subject: [PATCH 2.5.41] trap in __release_resource
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,
I was getting a NULL pointer dereference in __release_resource when I tried
to boot 2.5.41.  I traced it down to your recent patch to 8250.c.  Since
the call to serial8250_request_std_resource() is now conditional, the call
to release_resource() needs to be conditional as well.  This patch fixes
the problem.  It looks obviously correct to me, but I don't know this code
at all.

Thanks,
Shaggy

diff -Nur linux-2.5.41/drivers/serial/8250.c linux/drivers/serial/8250.c
--- linux-2.5.41/drivers/serial/8250.c	Wed Oct  9 11:16:52 2002
+++ linux/drivers/serial/8250.c	Wed Oct  9 11:17:19 2002
@@ -1636,7 +1636,7 @@
 	if (up->port.type != PORT_RSA && res_rsa)
 		release_resource(res_rsa);
 
-	if (up->port.type == PORT_UNKNOWN)
+	if (up->port.type == PORT_UNKNOWN && res_std)
 		release_resource(res_std);
 }
 
