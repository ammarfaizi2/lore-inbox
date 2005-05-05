Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVEEG5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVEEG5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 02:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVEEG5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 02:57:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:18598 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261908AbVEEG5T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 02:57:19 -0400
Cc: alexn@dsv.su.se
Subject: [PATCH] Hotplug: Make dev->bus checking consistent
In-Reply-To: <20050505065609.GA838@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 23:57:01 -0700
Message-Id: <11152762214193@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Hotplug: Make dev->bus checking consistent

Earlier in the same function dev->bus is checked before dereferenced,
make consistent although I honestly don't know if dev->bus could
ever be NULL

Found by the Coverity tool

Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 177a4324944478f2799ce4ede2797cb0f602f274
tree cc42dcdbce1c3b53ea147abd3ebf784f0d2bf1bc
parent 897f5ab2cd733a77a2279268262919caa8154b9d
author Alexander Nyberg <alexn@dsv.su.se> 1109421531 +0100
committer Greg KH <gregkh@suse.de> 1115275477 -0700

Index: drivers/base/core.c
===================================================================
--- 95866d31faa6db4ec786399296238344c7cfea0c/drivers/base/core.c  (mode:100644 sha1:a7cedd8cefe5385a8d2eb6f334c8661454c443d7)
+++ cc42dcdbce1c3b53ea147abd3ebf784f0d2bf1bc/drivers/base/core.c  (mode:100644 sha1:268a9c8d168b6ac72a46e0c624830b030b79df51)
@@ -139,7 +139,7 @@
 	buffer = &buffer[length];
 	buffer_size -= length;
 
-	if (dev->bus->hotplug) {
+	if (dev->bus && dev->bus->hotplug) {
 		/* have the bus specific function add its stuff */
 		retval = dev->bus->hotplug (dev, envp, num_envp, buffer, buffer_size);
 			if (retval) {

