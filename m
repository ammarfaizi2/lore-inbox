Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265722AbUG1WNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbUG1WNy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUG1WNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:13:54 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:18093 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S265722AbUG1WM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:12:58 -0400
Date: Wed, 28 Jul 2004 18:49:21 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.8-rc2-mm1
Message-ID: <20040728184921.A17143@mail.kroptech.com>
References: <20040728020444.4dca7e23.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040728020444.4dca7e23.akpm@osdl.org>; from akpm@osdl.org on Wed, Jul 28, 2004 at 02:04:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 02:04:44AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm1/

<snip>

> - If people have patches in here which are important for a 2.6.8 release,
>   please let me know.

There's a trivial yet fairly important fix to hiddev.h in bk-input that
it would be nice to get merged before 2.6.8. Distros have been
shipping the current in-tree (broken) version with their kernel headers
packages so a number of userspace apps cannot build. I've broken out the
patch below.

There's also a hiddev oops-on-removal fix that ought to be merged fairly
soon, but I can understand if Vojtech wants that tested a bit longer
first.

--Adam

diff -Nru a/include/linux/hiddev.h b/include/linux/hiddev.h
--- a/include/linux/hiddev.h	2004-07-27 18:37:32 -07:00
+++ b/include/linux/hiddev.h	2004-07-27 18:37:32 -07:00
@@ -128,10 +128,11 @@
 
 /* hiddev_usage_ref_multi is used for sending multiple bytes to a control.
  * It really manifests itself as setting the value of consecutive usages */
+#define HID_MAX_MULTI_USAGES 1024
 struct hiddev_usage_ref_multi {
 	struct hiddev_usage_ref uref;
 	__u32 num_values;
-	__s32 values[HID_MAX_USAGES];
+	__s32 values[HID_MAX_MULTI_USAGES];
 };
 
 /* FIELD_INDEX_NONE is returned in read() data from the kernel when flags
@@ -211,6 +212,11 @@
 /*
  * In-kernel definitions.
  */
+
+struct hid_device;
+struct hid_usage;
+struct hid_field;
+struct hid_report;
 
 #ifdef CONFIG_USB_HIDDEV
 int hiddev_connect(struct hid_device *);

