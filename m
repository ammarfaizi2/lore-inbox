Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbUKHVeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUKHVeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbUKHVep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:34:45 -0500
Received: from mail.appliedminds.com ([65.104.119.58]:51098 "EHLO
	appliedminds.com") by vger.kernel.org with ESMTP id S261242AbUKHVee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:34:34 -0500
Message-ID: <418FE536.80009@appliedminds.com>
Date: Mon, 08 Nov 2004 13:29:26 -0800
From: James Lamanna <jamesl@appliedminds.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040917)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Return EINVAL if read size is not multiple of struct size
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a small patch to return EINVAL when the value given
to read() from an event device is not a multiple of 
sizeof(struct input_event).

Prior to this patch read() with a size less than sizeof(struct input_event)
would always return 0.
This should probably be marked as an error.

Signed-off by: James Lamanna

--- linux-2.6.9/drivers/input/evdev.c   2004-10-18 14:54:40.000000000 -0700
+++ linux-2.6.9-ev-patch/drivers/input/evdev.c  2004-11-08 12:23:45.495800064 -0800
@@ -183,6 +183,9 @@
        if (!list->evdev->exist)
                return -ENODEV;

+       if (count % sizeof(struct input_event) != 0)
+               return -EINVAL;
+
        while (list->head != list->tail && retval + sizeof(struct input_event) <= count) {
                if (copy_to_user(buffer + retval, list->buffer + list->tail,
                         sizeof(struct input_event))) return -EFAULT;
-- 
James Lamanna
