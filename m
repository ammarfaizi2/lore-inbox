Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265180AbUELTEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265180AbUELTEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265184AbUELTEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:04:11 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:53264 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S265180AbUELS4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:56:30 -0400
Date: Wed, 12 May 2004 13:11:19 -0500
From: mike.miller@hp.com, mikem@beardog.cca.cpqcorp.net
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss fix for 2.4.27
Message-ID: <20040512181119.GA19500@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a problem observed on x86_64 platforms. The problem is a flags variable incorrectly declared as an unsigned int. It causes in an EBUSY when some installers try to read thru our /proc entry.
Please consider this for inclusion.

Thanks,
mikem
-------------------------------------------------------------------------------
 cciss_scsi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -burN lx2427-rc2.orig/drivers/block/cciss_scsi.c lx2427-rc2-flag/drivers/block/cciss_scsi.c
--- lx2427-rc2.orig/drivers/block/cciss_scsi.c	2004-04-14 08:05:29.000000000 -0500
+++ lx2427-rc2-flag/drivers/block/cciss_scsi.c	2004-05-10 12:53:21.000000000 -0500
@@ -1569,7 +1569,7 @@
 cciss_proc_tape_report(int ctlr, unsigned char *buffer, off_t *pos, off_t *len)
 {
 	int size;
-	unsigned int flags;
+	unsigned long flags;
 
 	*pos = *pos -1; *len = *len - 1; // cut off the last trailing newline
 
