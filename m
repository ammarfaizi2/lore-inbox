Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTJFNu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTJFNu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:50:26 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:12252 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262086AbTJFNuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:50:21 -0400
Message-ID: <3F8173EA.7040802@terra.com.br>
Date: Mon, 06 Oct 2003 10:53:46 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] check copy_from_user return value in sony535
Content-Type: multipart/mixed;
 boundary="------------030401000804050001060109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030401000804050001060109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Jens,

	Patch against 2.6.0-test6.

	- Check the return value of copy_from_user on sony535 CDROM driver. 
Found by smatch.

	Following the local style, btw :)

	Please apply,

	Thanks.

Felipe

--------------030401000804050001060109
Content-Type: text/plain;
 name="sonycd535-copy_from_user.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sonycd535-copy_from_user.patch"

--- linux-2.6.0-test6/drivers/cdrom/sonycd535.c.orig	2003-10-06 10:46:56.000000000 -0300
+++ linux-2.6.0-test6/drivers/cdrom/sonycd535.c	2003-10-06 10:48:20.000000000 -0300
@@ -1158,7 +1158,8 @@
 			return err;
 		spin_up_drive(status);
 		set_drive_mode(SONY535_AUDIO_DRIVE_MODE, status);
-		copy_from_user(params, (void *)arg, 6);
+		if (copy_from_user(params, (void *)arg, 6))
+			return -EFAULT;
 
 		/* The parameters are given in int, must be converted */
 		for (i = 0; i < 3; i++) {

--------------030401000804050001060109--

