Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWCON1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWCON1W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 08:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbWCON1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 08:27:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61373 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750962AbWCON1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 08:27:21 -0500
Message-ID: <44181697.2070709@ce.jp.nec.com>
Date: Wed, 15 Mar 2006 08:28:55 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject_uevent CONFIG_SYSFS=n build fix
References: <4416EB14.50306@ce.jp.nec.com> <20060314220130.GB12257@suse.de> <44175911.1010400@ce.jp.nec.com> <20060315000951.GA6608@suse.de> <441767EB.6070908@ce.jp.nec.com> <20060315024933.GA10742@suse.de>
In-Reply-To: <20060315024933.GA10742@suse.de>
Content-Type: multipart/mixed;
 boundary="------------000001040809080707060306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000001040809080707060306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
>>>>+#ifdef CONFIG_HOTPLUG
>>>>#define UEVENT_HELPER_PATH_LEN		256
>>
>>>That shouldn't be needed, right?
>>
>>You're right. They are not needed.
>>Please disregard that part.
> 
> 
> Looks good.  Care to resend it one more time, this time with a good
> changelog description and a Signed-off-by: line?

OK, here you are.
The patch is applicable to either 2.6.16-rc6 or 2.6.16-rc6-mm1.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------000001040809080707060306
Content-Type: text/x-patch;
 name="kobject_uevent-config_sysfs_n-build-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kobject_uevent-config_sysfs_n-build-fix.patch"

Moving uevent_seqnum and uevent_helper to kobject_uevent.c
because they are used even if CONFIG_SYSFS=n
while kernel/ksysfs.c is built only if CONFIG_SYSFS=y,

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

--- linux-2.6.16-rc6-mm1.orig/lib/kobject_uevent.c	2006-03-14 22:57:23.000000000 +0900
+++ linux-2.6.16-rc6-mm1/lib/kobject_uevent.c	2006-03-15 08:39:33.000000000 +0900
@@ -25,6 +25,11 @@
 #define BUFFER_SIZE	2048	/* buffer for the variables */
 #define NUM_ENVP	32	/* number of env pointers */
 
+#ifdef CONFIG_HOTPLUG
+u64 uevent_seqnum;
+char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
+#endif
+
 #if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 static DEFINE_SPINLOCK(sequence_lock);
 static struct sock *uevent_sock;
--- linux-2.6.16-rc6-mm1.orig/kernel/ksysfs.c	2006-03-14 22:57:31.000000000 +0900
+++ linux-2.6.16-rc6-mm1/kernel/ksysfs.c	2006-03-15 08:41:11.000000000 +0900
@@ -15,9 +15,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-u64 uevent_seqnum;
-char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
-
 #define KERNEL_ATTR_RO(_name) \
 static struct subsys_attribute _name##_attr = __ATTR_RO(_name)

--------------000001040809080707060306--
