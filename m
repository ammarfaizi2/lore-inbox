Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbUKLXEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbUKLXEE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbUKLXDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:03:43 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:51078 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262657AbUKLXAl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:00:41 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <11003004062835@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 12 Nov 2004 15:00:06 -0800
Message-Id: <11003004064171@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2095, 2004/11/12 11:42:28-08:00, anil.s.keshavamurthy@intel.com

[PATCH] Add KOBJ_ONLINE

I am trying to fix the current ACPI container.ko and processor.ko to use
kobject_hotplug() for notification. For this I would be requiring the
KOBJ_ONLINE definitions to be added to kobject_action.

Signed-off-by: Anil Keshavamurty <anil.s.keshavamurthy@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/kobject_uevent.h |    1 +
 lib/kobject_uevent.c           |    2 ++
 2 files changed, 3 insertions(+)


diff -Nru a/include/linux/kobject_uevent.h b/include/linux/kobject_uevent.h
--- a/include/linux/kobject_uevent.h	2004-11-12 14:53:26 -08:00
+++ b/include/linux/kobject_uevent.h	2004-11-12 14:53:26 -08:00
@@ -28,6 +28,7 @@
 	KOBJ_MOUNT	= (__force kobject_action_t) 0x04,	/* mount event for block devices */
 	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices */
 	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* offline event for hotplug devices */
+	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* online event for hotplug devices */
 };
 
 
diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-11-12 14:53:26 -08:00
+++ b/lib/kobject_uevent.c	2004-11-12 14:53:26 -08:00
@@ -42,6 +42,8 @@
 		return "umount";
 	case KOBJ_OFFLINE:
 		return "offline";
+	case KOBJ_ONLINE:
+		return "online";
 	default:
 		return NULL;
 	}

