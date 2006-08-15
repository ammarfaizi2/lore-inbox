Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWHOW0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWHOW0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 18:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWHOW0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 18:26:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:42720 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750753AbWHOW0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 18:26:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IKa+5bCmkdOgFXgDryA77C9mzzuhtkE8vn/uXNJNxdpyc7ViUICMMHaMWZewKHca4ToQCUnZmlohYMc6noNM+mxJtj/ytLgJH+Q+CkyOKYt29wTLHG32mHGX/BcUyxEPsva4cMwrt+Q1S3Ri26rS3MKB3gNXvm1SV6Q+I/tEfyM=
Message-ID: <41840b750608151526r19748630y75118a2f5032ca6@mail.gmail.com>
Date: Wed, 16 Aug 2006 01:26:07 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [-mm patch] hdaps: Add explicit hardware configuration functions - fix
Cc: "Andrew Morton" <akpm@osdl.org>, "Robert Love" <rlove@rlove.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       hdaps-devel@lists.sourceforge.net, "Pavel Machek" <pavel@suse.cz>,
       "Jean Delvare" <khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes two things about hdaps_check_ec() in the hdaps driver:
1. Remove the __init, it may be called well after module init, during resume.
2. Remove an unused parameter.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
---
This applies on top of
hdaps-add-explicit-hardware-configuration-functions.patch
currently in -mm
(LKML: "[PATCH 08/12] hdaps: Add explicit hardware configuration functions").

Andrew, do you prefer to get the full rolled-up patch in such cases?

--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -305,7 +305,7 @@ static int hdaps_get_ec_mode(u8 *mode)
  * Follows the clean-room spec for HDAPS; we don't know what it means.
  * Returns zero on success and negative error code on failure.  Can sleep.
  */
-static int __init hdaps_check_ec(u8 *mode)
+static int hdaps_check_ec()
 {
 	const struct thinkpad_ec_row args =
 		{ .mask=0x0003, .val={0x17, 0x81} };
@@ -343,7 +343,7 @@ static int hdaps_device_init(void)
 	if (mode==0x00)
 		{ ABORT_INIT("accelerometer not available"); goto bad; }

-	if (hdaps_check_ec(&mode))
+	if (hdaps_check_ec())
 		{ ABORT_INIT("hdaps_check_ec failed"); goto bad; }

 	if (hdaps_set_power(1))
