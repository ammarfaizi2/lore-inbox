Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWACVED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWACVED (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWACVED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:04:03 -0500
Received: from peabody.ximian.com ([130.57.169.10]:58292 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S964794AbWACVEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:04:00 -0500
Subject: [patch] miih: don't leak kernel types
From: Robert Love <rml@novell.com>
To: davem@redhat.com, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1136321441.6106.3.camel@betsy.boston.ximian.com>
References: <1136321441.6106.3.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 16:01:45 -0500
Message-Id: <1136322105.6106.4.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 15:50 -0500, Robert Love wrote:

> The header <linux/ethtool.h> leaks the kernel types u32, et al types to
> user-space.  These types are defined in <asm/types.h> but only under
> __KERNEL__.
> 
> Attached patch switches to the __u32, et al types.

Same deal for <linux/mii.h>.

	Robert Love


don't leak the kernel uX types to user-space, use __uX in lieu

Signed-off-by: Robert Love <rml@novell.com>

 include/linux/mii.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -urN linux-2.6.15/include/linux/mii.h linux/include/linux/mii.h
--- linux-2.6.15/include/linux/mii.h	2006-01-02 22:21:10.000000000 -0500
+++ linux/include/linux/mii.h	2006-01-03 15:59:39.000000000 -0500
@@ -171,10 +171,10 @@
 
 /* This structure is used in all SIOCxMIIxxx ioctl calls */
 struct mii_ioctl_data {
-	u16		phy_id;
-	u16		reg_num;
-	u16		val_in;
-	u16		val_out;
+	__u16		phy_id;
+	__u16		reg_num;
+	__u16		val_in;
+	__u16		val_out;
 };
 
 


