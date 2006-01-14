Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWANWx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWANWx1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWANWx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:53:27 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:49632 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751337AbWANWx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:53:26 -0500
Date: Sat, 14 Jan 2006 23:49:26 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: [patch 2.6.15-mm4] drivers/cdrom/cdrom.c fix incorrect test
Message-ID: <20060114224926.GB26443@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In cleanup-cdrom_ioctl.patch,

the test in CDROMREADTOCENTRY ioctl was changed from

if (!((requested_format == CDROM_MSF) || (requested_format == CDROM_LBA)))
		return -EINVAL;

to

if (requested_format != CDROM_MSF || requested_format != CDROM_LBA)
	return -EINVAL;


which is not equivalent with morgan's law.


Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

diff -Naurp -X Documentation/dontdiff ../linux/drivers/cdrom/cdrom.c drivers/cdrom/cdrom.c
--- a/linux/drivers/cdrom/cdrom.c	2006-01-14 16:11:43.000000000 +0100
+++ b/drivers/cdrom/cdrom.c	2006-01-14 23:44:51.000000000 +0100
@@ -2585,7 +2585,7 @@ static int cdrom_ioctl_read_tocentry(str
 		return -EFAULT;
 
 	requested_format = entry.cdte_format;
-	if (requested_format != CDROM_MSF || requested_format != CDROM_LBA)
+	if (requested_format != CDROM_MSF && requested_format != CDROM_LBA)
 		return -EINVAL;
 	/* make interface to low-level uniform */
 	entry.cdte_format = CDROM_MSF;
