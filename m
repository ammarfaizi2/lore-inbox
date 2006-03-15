Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751834AbWCOBCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbWCOBCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbWCOBCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:02:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3755 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751834AbWCOBCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:02:05 -0500
Message-ID: <441767EB.6070908@ce.jp.nec.com>
Date: Tue, 14 Mar 2006 20:03:39 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject_uevent CONFIG_SYSFS=n build fix
References: <4416EB14.50306@ce.jp.nec.com> <20060314220130.GB12257@suse.de> <44175911.1010400@ce.jp.nec.com> <20060315000951.GA6608@suse.de>
In-Reply-To: <20060315000951.GA6608@suse.de>
Content-Type: multipart/mixed;
 boundary="------------020402030101040701080707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020402030101040701080707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Greg KH wrote:
>>@@ -27,6 +27,8 @@
>> #include <asm/atomic.h>
>> 
>> #define KOBJ_NAME_LEN			20
>>+
>>+#ifdef CONFIG_HOTPLUG
>> #define UEVENT_HELPER_PATH_LEN		256

> That shouldn't be needed, right?

You're right. They are not needed.
Please disregard that part.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------020402030101040701080707
Content-Type: text/x-patch;
 name="kobject_uevent-config_sysfs_n-build-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kobject_uevent-config_sysfs_n-build-fix.patch"

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

--------------020402030101040701080707--
