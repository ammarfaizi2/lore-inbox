Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267831AbTAMLIU>; Mon, 13 Jan 2003 06:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267839AbTAMLIU>; Mon, 13 Jan 2003 06:08:20 -0500
Received: from fmr02.intel.com ([192.55.52.25]:43506 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267831AbTAMLIT>; Mon, 13 Jan 2003 06:08:19 -0500
Subject: concerns about sysfs_ops
From: Louis Zhuang <louis.zhuang@linux.co.intel.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Intel Crop.
Message-Id: <1042456636.10860.11.camel@hawk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 13 Jan 2003 19:17:16 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mochel,
	I found you removed off/count params in new sysfs_ops functions. That's
good change for show functions, but for store function, if you don't
give the len of data, the chained xxx_store function has to assume
or/and guess how long the data is. This might be a potential issue. So I
suggest you add 'size_t count' in store function of sysfs_ops.

include/linux/sysfs.h:  1.21 1.22 louis 03/01/13 18:39:41 (modified, 
needs delta)

@@ -18,7 +18,7 @@
 
 struct sysfs_ops {
 	ssize_t	(*show)(struct kobject *, struct attribute *,char *);
-	ssize_t	(*store)(struct kobject *,struct attribute *,const char *);
+	ssize_t	(*store)(struct kobject *,struct attribute *,const char *,
size_t count);
 };
 
 extern int


Yours truly,
Louis Zhuang
---------------
Fault Injection Test Harness Project
BK tree: http://fault-injection.bkbits.net/linux-2.5
Home Page: http://sf.net/projects/fault-injection

