Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTLWPSQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTLWPSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:18:16 -0500
Received: from mx.laposte.net ([81.255.54.11]:34114 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S261500AbTLWPSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:18:12 -0500
Subject: [TRIVIAL PATCH] superfluous assignement in ide_diag_taskfile()
From: Bernadette SING <bernadette.sing@laposte.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-1LjvXo2PxJgbCqND43LG"
Message-Id: <1072193271.4456.11.camel@silenus.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Dec 2003 16:28:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1LjvXo2PxJgbCqND43LG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
>From ide_diag_taskfile()

        ide_init_drive_taskfile(&rq);
        rq.flags = REQ_DRIVE_TASKFILE;
        rq.buffer = buf;

but in ide_init_drive_taskfile() we've got:

	void ide_init_drive_taskfile (struct request *rq)
	{
	        memset(rq, 0, sizeof(*rq));
	        rq->flags = REQ_DRIVE_TASKFILE;
	}	
The REQ_DRIVE_TASKFILE assignement in ide_diag_taskfile() looks
superfluous.
Patch attached.

-- 
Frederik DEWEERDT

--=-1LjvXo2PxJgbCqND43LG
Content-Disposition: inline; filename=patch.ide-taskfile_c.cleanup
Content-Type: text/plain; name=patch.ide-taskfile_c.cleanup; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- /usr/src/linux-2.6.0/drivers/ide/ide-taskfile.c	2003-12-18 15:41:19.000000000 +0100
+++ linux/drivers/ide/ide-taskfile.c	2003-12-22 11:12:06.000000000 +0100
@@ -1372,7 +1372,6 @@
 	struct request rq;
 
 	ide_init_drive_taskfile(&rq);
-	rq.flags = REQ_DRIVE_TASKFILE;
 	rq.buffer = buf;
 
 	/*

--=-1LjvXo2PxJgbCqND43LG--

