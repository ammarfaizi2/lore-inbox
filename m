Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161441AbWJKVQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161441AbWJKVQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWJKVQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:16:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:17315 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161441AbWJKVJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:02 -0400
Date: Wed, 11 Oct 2006 14:08:27 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, syrius.ml@no-log.org,
       Richard Bollinger <rabollinger@gmail.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-raid@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 56/67] MD: Fix problem where hot-added drives are not resynced.
Message-ID: <20061011210827.GE16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="md-fix-problem-where-hot-added-drives-are-not-resynced.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Neil Brown <neilb@suse.de>

If a drive is added with HOT_ADD_DISK rather than ADD_NEW_DISK,
saved_raid_disk isn't initialised properly, and the drive can be
included in the array without a resync.


From: Neil Brown <neilb@suse.de>
Cc: <syrius.ml@no-log.org>
Cc: Richard Bollinger <rabollinger@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/md/md.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.18.orig/drivers/md/md.c
+++ linux-2.6.18/drivers/md/md.c
@@ -3867,6 +3867,7 @@ static int hot_add_disk(mddev_t * mddev,
 	}
 	clear_bit(In_sync, &rdev->flags);
 	rdev->desc_nr = -1;
+	rdev->saved_raid_disk = -1;
 	err = bind_rdev_to_array(rdev, mddev);
 	if (err)
 		goto abort_export;

--
