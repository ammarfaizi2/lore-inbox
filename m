Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161178AbWFVSua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161178AbWFVSua (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWFVSu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:50:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:24479 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161178AbWFVSu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:50:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=KH3/cuh5PM60Q596ykKNyKR7Zr0NzFXmCNeo5z8tyUyMHarkFV4h6aM6LoaHo16LzNoRWbR3Q9cXKltx8b6dkRaS/Op/tb45d7weUTRra4EdR6dc8yN4jBejWtZ0q2XpKrGu0MsXjpA0M8TaX8LDrDQfOV2uIcTkK5TORpP6awU=
Message-ID: <449AE670.8080909@gmail.com>
Date: Thu, 22 Jun 2006 12:50:24 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 02/11 ] gpio-patchset-fixups: ENOMEM on device_add failure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If platform_device_alloc fails, return -ENOMEM, not ENODEV.

Signed-off-by:   Jim Cromie <jim.cromie@gmail.com>


diff -ruNp -X dontdiff -X exclude-diffs aa-1/drivers/char/scx200_gpio.c aa-2/drivers/char/scx200_gpio.c
--- aa-1/drivers/char/scx200_gpio.c	2006-06-22 09:29:24.000000000 -0600
+++ aa-2/drivers/char/scx200_gpio.c	2006-06-22 09:43:16.000000000 -0600
@@ -87,7 +87,7 @@ static int __init scx200_gpio_init(void)
 	/* support dev_dbg() with pdev->dev */
 	pdev = platform_device_alloc(DEVNAME, 0);
 	if (!pdev)
-		return -ENODEV;
+		return -ENOMEM;
 
 	rc = platform_device_add(pdev);
 	if (rc)


