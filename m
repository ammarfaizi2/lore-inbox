Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbUKQDKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbUKQDKP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbUKQDKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:10:15 -0500
Received: from fmr20.intel.com ([134.134.136.19]:65462 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262165AbUKQDKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:10:09 -0500
Subject: [PATCH]Teach drivers don't call may-sleep routines in resume code
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1100660643.7466.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 11:04:04 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
We already found one driver (PCI link device driver) does the odd thing, so alert other drivers.

Thanks,
Shaohua

--- 2.6/Documentation/power/devices.txt.orig	2004-11-17 10:42:25.160212832 +0800
+++ 2.6/Documentation/power/devices.txt	2004-11-17 10:46:11.070869192 +0800
@@ -70,6 +70,9 @@ System devices will only be suspended wi
 after all other devices have been suspended. On resume, they will be
 resumed before any other devices, and also with interrupts disabled.
 
+*CAUTION*: The resume methods of drivers (normal devices and system devices)
+should never use any may-sleep methods, since when resume from memory (S3),
+no task is running.
 
 Runtime Power Management
 


