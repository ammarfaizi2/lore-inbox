Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbUKRQpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbUKRQpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 11:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbUKRQpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 11:45:21 -0500
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:3849 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP id S262535AbUKRQnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 11:43:35 -0500
Message-ID: <419CEB08.4010406@gentoo.org>
Date: Thu, 18 Nov 2004 18:33:44 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Permit LOG_SENSE and LOG_SELECT in SG_IO command table
Content-Type: multipart/mixed;
 boundary="------------080403030304040708040000"
X-Spam-Score: -5.9 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CUpNa-0002pF-3l*c/kuRiZg0Us*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080403030304040708040000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch adds LOG_SENSE as a read-ok command. cdrecord-prodvd uses this.
I also added LOG_SELECT as write-ok as this seems to fit in as well.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------080403030304040708040000
Content-Type: text/plain;
 name="scsi_ioctl-permit-log-sense-select.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi_ioctl-permit-log-sense-select.patch"

--- linux/drivers/block/scsi_ioctl.c.orig	2004-11-18 18:18:49.666216472 +0000
+++ linux/drivers/block/scsi_ioctl.c	2004-11-18 18:22:50.271638888 +0000
@@ -127,6 +127,7 @@ static int verify_command(struct file *f
 		safe_for_read(INQUIRY),
 		safe_for_read(MODE_SENSE),
 		safe_for_read(MODE_SENSE_10),
+		safe_for_read(LOG_SENSE),
 		safe_for_read(START_STOP),
 		safe_for_read(GPCMD_VERIFY_10),
 		safe_for_read(VERIFY_16),
@@ -169,6 +170,7 @@ static int verify_command(struct file *f
 		safe_for_write(ERASE),
 		safe_for_write(GPCMD_MODE_SELECT_10),
 		safe_for_write(MODE_SELECT),
+		safe_for_write(LOG_SELECT),
 		safe_for_write(GPCMD_BLANK),
 		safe_for_write(GPCMD_CLOSE_TRACK),
 		safe_for_write(GPCMD_FLUSH_CACHE),

--------------080403030304040708040000--
