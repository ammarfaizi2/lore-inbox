Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWHCQYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWHCQYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWHCQYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:24:41 -0400
Received: from rubidium.solidboot.com ([81.22.244.175]:30404 "EHLO
	mail.solidboot.com") by vger.kernel.org with ESMTP id S932578AbWHCQYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:24:40 -0400
Date: Thu, 3 Aug 2006 19:06:25 +0300
From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@solidboot.com>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, neilb@suse.de
Subject: [PATCH] sysfs: Make poll behaviour consistent
Message-ID: <20060803160625.GA24946@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When no events have been reported by sysfs_notify(), sd->s_events
was previously set to zero.  The initial value for new readers is
also zero, so poll was blocking, regardless of whether the attribute
was read by the process or not.

Make poll behave consistently by setting the initial value of
sd->s_events to non-zero.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
---
 fs/sysfs/dir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 61c4243..5f3d725 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -43,7 +43,7 @@ static struct sysfs_dirent * sysfs_new_d
 
 	memset(sd, 0, sizeof(*sd));
 	atomic_set(&sd->s_count, 1);
-	atomic_set(&sd->s_event, 0);
+	atomic_set(&sd->s_event, 1);
 	INIT_LIST_HEAD(&sd->s_children);
 	list_add(&sd->s_sibling, &parent_sd->s_children);
 	sd->s_element = element;
-- 
1.4.1

