Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUGALfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUGALfM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 07:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbUGALfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 07:35:12 -0400
Received: from av9-1-sn1.fre.skanova.net ([81.228.11.115]:11992 "EHLO
	av9-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S264595AbUGALfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 07:35:05 -0400
To: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Can't open CDROM device for writing
From: Peter Osterlund <petero2@telia.com>
Date: 01 Jul 2004 13:34:54 +0200
Message-ID: <m2eknw3qqp.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Opening a CDROM device for writing no longer works, because
cdrom_open() returns -EROFS even if cdrom_open_write() succeeds. This
patch for 2.6.7-bk13 fixes it.

Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/drivers/cdrom/cdrom.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/cdrom/cdrom.c~cdrom-write-fix drivers/cdrom/cdrom.c
--- linux/drivers/cdrom/cdrom.c~cdrom-write-fix	2004-07-01 13:16:27.772595136 +0200
+++ linux-petero/drivers/cdrom/cdrom.c	2004-07-01 13:17:34.380469200 +0200
@@ -901,6 +901,7 @@ int cdrom_open(struct cdrom_device_info 
 				goto err;
 			if (cdrom_open_write(cdi))
 				goto err;
+			ret = 0;
 		}
 	}
 
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
