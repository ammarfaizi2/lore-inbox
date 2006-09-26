Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWIZFwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWIZFwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWIZFil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:38:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:28629 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751315AbWIZFi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:26 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 6/47] sysfs: Make poll behaviour consistent
Date: Mon, 25 Sep 2006 22:37:26 -0700
Message-Id: <11592491023995-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592490993970-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: =?utf-8?q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>

When no events have been reported by sysfs_notify(), sd->s_events
was previously set to zero.  The initial value for new readers is
also zero, so poll was blocking, regardless of whether the attribute
was read by the process or not.

Make poll behave consistently by setting the initial value of
sd->s_events to non-zero.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
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
1.4.2.1

