Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286744AbRL1EUI>; Thu, 27 Dec 2001 23:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286747AbRL1ETt>; Thu, 27 Dec 2001 23:19:49 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:2826 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286746AbRL1ETl>;
	Thu, 27 Dec 2001 23:19:41 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.17 drivers/scsi/NCR5380.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Dec 2001 15:19:27 +1100
Message-ID: <20002.1009513167@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers #include "NCR5380.c".  If two or more of those drivers
are built into vmlinux then you get duplicate global symbols.
Functions in NCR5380.c must be static.  There are a couple of other
suspect functions but they are conditioned by #ifdef so I left them
alone.

Index: 17.9/drivers/scsi/NCR5380.c
--- 17.9/drivers/scsi/NCR5380.c Sat, 08 Dec 2001 10:12:02 +1100 kaos (linux-2.4/U/b/0_NCR5380.c 1.4 644)
+++ 17.9(w)/drivers/scsi/NCR5380.c Fri, 28 Dec 2001 15:15:16 +1100 kaos (linux-2.4/U/b/0_NCR5380.c 1.4 644)
@@ -612,7 +612,7 @@ static int NCR5380_set_timer(struct Scsi
  *	Locks: disables irqs, takes and frees io_request_lock
  */
  
-void NCR5380_timer_fn(unsigned long unused)
+static void NCR5380_timer_fn(unsigned long unused)
 {
 	struct Scsi_Host *instance;
 

