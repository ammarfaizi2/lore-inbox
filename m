Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267452AbTASMHG>; Sun, 19 Jan 2003 07:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267453AbTASMHF>; Sun, 19 Jan 2003 07:07:05 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6916 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267452AbTASMHE>;
	Sun, 19 Jan 2003 07:07:04 -0500
Date: Sun, 19 Jan 2003 13:14:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: scsi_eh_* needs to be ran even during suspend
Message-ID: <20030119121419.GA1064@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


...because suspend does not prevent hard disk from reporting
error. Here's a patch, please apply.
								Pavel

--- clean/drivers/scsi/scsi_error.c	2003-01-17 23:12:23.000000000 +0100
+++ linux-swsusp/drivers/scsi/scsi_error.c	2003-01-19 12:28:00.000000000 +0100
@@ -1594,6 +1595,7 @@
 	 */
 
 	sprintf(current->comm, "scsi_eh_%d", shost->host_no);
+	current->flags |= PF_IOTHREAD;
 
 	shost->eh_wait = &sem;
 	shost->ehandler = current;

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
