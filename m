Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWGQQep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWGQQep (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWGQQeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:34:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:52924 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750975AbWGQQdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:47 -0400
Date: Mon, 17 Jul 2006 09:27:51 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, meissner@suse.de, axboe@suse.de,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 24/45] cdrom: fix bad cgc.buflen assignment
Message-ID: <20060717162751.GY4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cdrom-fix-bad-cgc.buflen-assignment.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jens Axboe <axboe@suse.de>

The code really means to mask off the high bits, not assign 0xff.

Signed-off-by: Jens Axboe <axboe@suse.de>
Cc: Marcus Meissner <meissner@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/cdrom/cdrom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.4.orig/drivers/cdrom/cdrom.c
+++ linux-2.6.17.4/drivers/cdrom/cdrom.c
@@ -1838,7 +1838,7 @@ static int dvd_read_bca(struct cdrom_dev
 	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
 	cgc.cmd[0] = GPCMD_READ_DVD_STRUCTURE;
 	cgc.cmd[7] = s->type;
-	cgc.cmd[9] = cgc.buflen = 0xff;
+	cgc.cmd[9] = cgc.buflen & 0xff;
 
 	if ((ret = cdo->generic_packet(cdi, &cgc)))
 		return ret;

--
