Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270448AbRHNEjm>; Tue, 14 Aug 2001 00:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270446AbRHNEjd>; Tue, 14 Aug 2001 00:39:33 -0400
Received: from patan.Sun.COM ([192.18.98.43]:17550 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S270440AbRHNEjZ>;
	Tue, 14 Aug 2001 00:39:25 -0400
Message-ID: <3B78AC66.3621AD86@sun.com>
Date: Mon, 13 Aug 2001 21:43:18 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        torvalds@transmeta.com, alan@redhat.com
Subject: [PATCH] small SCSI use count fix
Content-Type: multipart/mixed;
 boundary="------------4687D170C28CABC726FD609D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4687D170C28CABC726FD609D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is a small fix to increment the use count in scsi_register_host()
before we start working with it - prevent false decrementing.  (from one of
the crew here ;)

Please let me know if there is any reason this shouldn't go mainline in the
next 2.4.x.

thanks
Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------4687D170C28CABC726FD609D
Content-Type: text/plain; charset=us-ascii;
 name="scsi_use_count.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi_use_count.diff"

diff -ruN dist+patches-2.4.8/drivers/scsi/scsi.c cobalt-2.4.8/drivers/scsi/scsi.c
--- dist+patches-2.4.8/drivers/scsi/scsi.c	Thu Jul 19 21:07:04 2001
+++ cobalt-2.4.8/drivers/scsi/scsi.c	Mon Aug 13 16:42:24 2001
@@ -1835,6 +1828,8 @@
 
 	pcount = next_scsi_host;
 
+	MOD_INC_USE_COUNT;
+
 	/* The detect routine must carefully spinunlock/spinlock if 
 	   it enables interrupts, since all interrupt handlers do 
 	   spinlock as well.
@@ -1964,8 +1965,6 @@
 	       (scsi_init_memory_start - scsi_memory_lower_value) / 1024,
 	       (scsi_memory_upper_value - scsi_init_memory_start) / 1024);
 #endif
-
-	MOD_INC_USE_COUNT;
 
 	if (out_of_space) {
 		scsi_unregister_host(tpnt);	/* easiest way to clean up?? */

--------------4687D170C28CABC726FD609D--

