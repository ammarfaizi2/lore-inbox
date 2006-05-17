Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWEQWSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWEQWSR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWEQWSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:18:07 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:49283 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751246AbWEQWMI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:08 -0400
Message-Id: <20060517221350.738753000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:01 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, neilb@suse.de,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/22] md: Avoid oops when attempting to fix read errors on raid10
Content-Disposition: inline; filename=md-avoid-oops-when-attempting-to-fix-read-errors-on-raid10.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

We should add to the counter for the rdev *after* checking if the rdev is
NULL!!!

Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/md/raid10.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.16.orig/drivers/md/raid10.c
+++ linux-2.6.16.16/drivers/md/raid10.c
@@ -1436,9 +1436,9 @@ static void raid10d(mddev_t *mddev)
 						sl--;
 						d = r10_bio->devs[sl].devnum;
 						rdev = conf->mirrors[d].rdev;
-						atomic_add(s, &rdev->corrected_errors);
 						if (rdev &&
 						    test_bit(In_sync, &rdev->flags)) {
+							atomic_add(s, &rdev->corrected_errors);
 							if (sync_page_io(rdev->bdev,
 									 r10_bio->devs[sl].addr +
 									 sect + rdev->data_offset,

--
