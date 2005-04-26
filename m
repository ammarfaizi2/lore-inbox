Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVDZHeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVDZHeU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVDZHeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:34:20 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:39585 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261389AbVDZHeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:34:15 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: [PATCH 0/5] Misc driver core changes (constness)
Date: Tue, 26 Apr 2005 02:29:03 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504260229.03866.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It all started when code like this:

static const char driver_name = "blah";
static struct device_driver {
	.name = driver_name,
};

would give me compiler warning about removing constness because driver
core has "name" fields drclared simply as "char *". I think it is a good
idea to have them as "const char *" since whoever accesses them should
not try to change them.

01-hotplug-use-kobject-name.patch
  - kobject_hotplug should use kobject_name() instead of
    accessing kobj->name directly since for objects with
    long names it can contain garbage.

02-sysfs-link-constness.patch
  - make sysfs_{create|remove}_link to take const char * name.

03-kobject-const-name.patch
  - make kobject's name const char * since users should not
    attempt to change it (except by calling kobject_rename).

04-kset-name-const.patch
  - change name() method in kset_hiotplug_ops return const char *
    since users shoudl not try to modify returned data.

05-driver-const-name.patch
  - change driver's, bus's, class's and platform device's names
    to be const char * so one can use const char *drv_name = "asdfg";
    when initializing structures.
    Also kill couple of whitespaces.

Please consider for inclusion.

-- 
Dmitry
