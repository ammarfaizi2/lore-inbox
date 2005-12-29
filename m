Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVL2Ani@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVL2Ani (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVL2AjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:14 -0500
Received: from mx.pathscale.com ([64.160.42.68]:42728 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932565AbVL2AjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:08 -0500
Content-Type: multipart/mixed; boundary="===============0823513804=="
MIME-Version: 1.0
Subject: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
Message-Id: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:19 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============0823513804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Following Roland's submission of our InfiniPath InfiniBand HCA driver
earlier this month, we have responded to people's comments by making a
large number of changes to the driver.

Here is another set of driver patches for review.  Roland is on
vacation until January 4, so I'm posting these in his place.  Once
again, your comments are appreciated.  We'd like to submit this driver
for inclusion in 2.6.16, so we'll be responding quickly to all
feedback.

A short summary of the changes we have made is as follows:

  - sparse annotations (yes, it passes "make C=1")

  - Removed x86_64 specificity from driver

  - Introduced generic memcpy_toio32 for safe MMIO access

  - Got rid of release and RCS IDs

  - Use set_page_dirty_lock instead of SetPageDirty

  - Fixed misuse of copy_from_user

  - Removed all sysctls

  - Removed stuff inside #ifndef __KERNEL__

  - Use ALIGN() instead of round_up()

  - Use static inlines instead of #defines, generally tidied inline
    functions

  - Renamed _BITS_PER_BYTE to BITS_PER_BYTE, and moved it into
    linux/types.h

  - Got rid of ipath_shortcopy

  - Use fixed-size types for user/kernel communication

  - Renamed ipath_mlock to ipath_get_user_pages, fixed some bugs

There are a few requested changes we have chosen to omit for now:

  - The driver still uses EXPORT_SYMBOL, for consistency with other
    code in drivers/infiniband

  - Someone asked for the kernel's i2c infrastructure to be used, but
    our i2c usage is very specialised, and it would be more of a mess
    to use the kernel's

  - We're still using ioctls instead of sysfs or configfs in some
    cases, to maintain userspace compatibility

Please note that these patches require a set of OpenIB kernel patches
that are awaiting the 2.6.16 submission window in order to compile; in
other words, they really are for review only.  I'll be happy to
provide a suitable jumbo OpenIB patch to anyone who feels a need to
compile-test these patches.

	<b

--===============0823513804==--
