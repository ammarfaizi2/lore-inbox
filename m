Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbVHYU4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVHYU4c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 16:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVHYU4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 16:56:32 -0400
Received: from vena.lwn.net ([206.168.112.25]:28388 "HELO lwn.net")
	by vger.kernel.org with SMTP id S1751413AbVHYU4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 16:56:32 -0400
Message-ID: <20050825205629.22372.qmail@lwn.net>
To: torvalds@osdl.org
Subject: [PATCH] fix adm9240 oops
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 25 Aug 2005 14:56:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The adm9240 driver, in adm9240_detect(), allocates a structure.  The
error path attempts to kfree() a subfield of that structure, resulting
in an oops (or slab corruption) if the hardware is not present.  This
one seems worth fixing for 2.6.13.

jon

Signed-off-by: Jonathan Corbet <corbet@lwn.net>

--- 2.6.13-rc7/drivers/hwmon/adm9240.c.orig	2005-08-25 14:30:04.000000000 -0600
+++ 2.6.13-rc7/drivers/hwmon/adm9240.c	2005-08-25 14:30:26.000000000 -0600
@@ -616,7 +616,7 @@ static int adm9240_detect(struct i2c_ada
 
 	return 0;
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
