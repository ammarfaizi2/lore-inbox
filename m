Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWIZFpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWIZFpZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWIZFpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:45:17 -0400
Received: from cantor2.suse.de ([195.135.220.15]:58837 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751415AbWIZFkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:08 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 39/47] v4l-dev2: handle __must_check
Date: Mon, 25 Sep 2006 22:37:59 -0700
Message-Id: <1159249209773-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592492061208-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com> <1159249200793-git-send-email-greg@kroah.com> <11592492023883-git-send-email-greg@kroah.com> <11592492061208-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

We get hundreds of these:

include/media/v4l2-dev.h:348: warning: ignoring return value of 'class_device_create_file', declared with attribute warn_unused_result

Handle it, and propagate the __must_check back a level.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/media/v4l2-dev.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
index 810462f..bb495b7 100644
--- a/include/media/v4l2-dev.h
+++ b/include/media/v4l2-dev.h
@@ -341,7 +341,7 @@ #include <linux/mm.h>
 extern struct video_device* video_devdata(struct file*);
 
 #define to_video_device(cd) container_of(cd, struct video_device, class_dev)
-static inline int
+static inline int __must_check
 video_device_create_file(struct video_device *vfd,
 			 struct class_device_attribute *attr)
 {
-- 
1.4.2.1

