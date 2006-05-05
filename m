Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWEEWD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWEEWD7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 18:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWEEWD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 18:03:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:4382 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751788AbWEEWD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 18:03:58 -0400
X-IronPort-AV: i="4.05,93,1146466800"; 
   d="scan'208"; a="33070850:sNHT3455347833"
Subject: [patch] add new uevent
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: arjan@linux.intel.com, greg@kroah.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 05 May 2006 15:13:36 -0700
Message-Id: <1146867216.21633.6.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 05 May 2006 22:03:32.0990 (UTC) FILETIME=[BFF6E1E0:01C6708F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add dock uevents so that userspace can be notified of dock and undock
events.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 include/linux/kobject.h |    2 ++
 lib/kobject_uevent.c    |    4 ++++
 2 files changed, 6 insertions(+)

--- 2.6-git-kca2.orig/include/linux/kobject.h
+++ 2.6-git-kca2/include/linux/kobject.h
@@ -46,6 +46,8 @@ enum kobject_action {
 	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices (broken) */
 	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* device offline */
 	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* device online */
+	KOBJ_UNDOCK	= (__force kobject_action_t) 0x08, 	/* undocking */
+	KOBJ_DOCK	= (__force kobject_action_t) 0x09,	/* dock */
 };
 
 struct kobject {
--- 2.6-git-kca2.orig/lib/kobject_uevent.c
+++ 2.6-git-kca2/lib/kobject_uevent.c
@@ -48,6 +48,10 @@ static char *action_to_string(enum kobje
 		return "offline";
 	case KOBJ_ONLINE:
 		return "online";
+	case KOBJ_DOCK:
+		return "dock";
+	case KOBJ_UNDOCK:
+		return "undock";
 	default:
 		return NULL;
 	}
