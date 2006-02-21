Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWBUOgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWBUOgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWBUOgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:36:39 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:55731 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932391AbWBUOgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:36:39 -0500
Message-ID: <43FB2573.3070909@us.ibm.com>
Date: Tue, 21 Feb 2006 09:36:35 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: xen-devel@lists.xensource.com
CC: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [ PATCH 2.6.16-rc3-xen 1/3] sysfs: export Xen hypervisor attributes
 to sysfs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches is a module that exports Xen Hypervisor attributes
to sysfs. The directory structure created is: 

+---sys
	+---hypervisor
		+---xen
			+---version
			+---major
			+---minor
			+---extra
		+---compilation
			+---by
			+---date
			+---compiler 
		+---properties
			+---changeset
			+---capabilities
			+---virt_start
			+---translated_pm
			+---writable_dt
			+---writable_pt

The xen_sysfs module has a tri-state Kconfig so it can be built-in or
loaded as a module.

The module is in three patches: 

Patch 1 (this patch) is a Xen file that is used by all OS kernels that run
on Xen. This includes linux, NetBSD, FreeBSD, Solaris, and others. Patch 1
adds #defined constants so that linux users of this file can avoid typedefs. 

Patch 2 (follows) contains the Kconfig changes necessary to add this module
to the kernel build. 

Patch 3 (follows) contains the source for the xen_sysfs module itself. 

# HG changeset patch
# User mdday@dual.silverwood.home
# Node ID d296aaf07bcb4141c6dc2a1bfa7d183f919c2167
# Parent  a05e56904e7e5e86aae5a2e022621caaf7b3a6f5
define constants for array sizes. Allows linux users of this file 
to avoid #typedefs. Existing typedefs work as before. 

signed-off-by: Mike D. Day <ncmike@us.ibm.com>

diff -r a05e56904e7e -r d296aaf07bcb xen/include/public/version.h
--- a/xen/include/public/version.h	Mon Feb 20 23:01:50 2006 +0000
+++ b/xen/include/public/version.h	Tue Feb 21 08:11:03 2006 -0500
@@ -1,8 +1,8 @@
/******************************************************************************
 * version.h
- * 
+ *
 * Xen version, type, and compile information.
- * 
+ *
 * Copyright (c) 2005, Nguyen Anh Quynh <aquynh@gmail.com>
 * Copyright (c) 2005, Keir Fraser <keir@xensource.com>
 */
@@ -17,6 +17,7 @@

/* arg == xen_extraversion_t. */
#define XENVER_extraversion 1
+#define XENVER_EXTRAVERSION_LEN 16
typedef char xen_extraversion_t[16];

/* arg == xen_compile_info_t. */
@@ -29,9 +30,11 @@ typedef struct xen_compile_info {
} xen_compile_info_t;

#define XENVER_capabilities 3
+#define XENVER_CAPABILITIES_INFO_LEN 1024
typedef char xen_capabilities_info_t[1024];

#define XENVER_changeset 4
+#define XENVER_CSET_INFO_LEN 64
typedef char xen_changeset_info_t[64];

#define XENVER_platform_parameters 5


