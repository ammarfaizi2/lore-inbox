Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTJKPP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 11:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbTJKPP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 11:15:28 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.36.232]:647 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S262795AbTJKPP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 11:15:27 -0400
Date: Sat, 11 Oct 2003 10:13:57 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@iguana.domsch.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre7 build problems
In-Reply-To: <Pine.LNX.4.44.0310111146190.1700-100000@logos.cnet>
Message-ID: <Pine.LNX.4.44.0310111011470.7261-100000@iguana.domsch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have the fix for the nsp driver but not for the megaraid2.

ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.00.9/megaraid-2009-wo-hostlock.patch.gz
ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.00.9/megaraid-2009-wo-hostlock.patch.gz.sig

and appended.  Done by Atul Mukker @ LSIL.

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff -Naur linux/drivers/scsi/megaraid2.c linux/drivers/scsi/megaraid2.c
--- linux/drivers/scsi/megaraid2.c	2003-09-09 15:31:43.000000000 -0400
+++ linux/drivers/scsi/megaraid2.c	2003-09-09 15:32:03.000000000 -0400
@@ -398,9 +398,7 @@
 		// replace adapter->lock with io_request_lock for kernels w/o
 		// per host lock and delete the line which tries to initialize
 		// the lock in host structure.
-		adapter->host_lock = &adapter->lock;
-
-		host->lock = adapter->host_lock;
+		adapter->host_lock = &io_request_lock;
 
 		host->cmd_per_lun = max_cmd_per_lun;
 		host->max_sectors = max_sectors_per_io;

