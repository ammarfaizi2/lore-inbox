Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVHDGMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVHDGMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVHDGJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:09:48 -0400
Received: from hendrix.ece.utexas.edu ([128.83.59.42]:47757 "EHLO
	hendrix.ece.utexas.edu") by vger.kernel.org with ESMTP
	id S261903AbVHDGIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:08:11 -0400
Date: Thu, 4 Aug 2005 01:08:09 -0500 (CDT)
From: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
Reply-To: youssef@ece.utexas.edu
To: linux-kernel@vger.kernel.org
cc: toshiba_acpi@memebeam.org, youssef@ece.utexas.edu
Subject: [PATCH][ACPI] toshiba_acpi.c: add check for NULL pointer
Message-ID: <Pine.LNX.4.61.0508040048190.14176@linux08.ece.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a check for NULL return from kmalloc.

Signed-off-by: Youssef Hmamouche <hyoussef@gmail.com>



--- a/drivers/acpi/toshiba_acpi.c       2005-07-15 14:18:57.000000000 -0700
+++ b/drivers/acpi/toshiba_acpi.c       2005-08-03 21:35:12.000000000 -0700
@@ -263,6 +263,9 @@
          * destination so that sscanf can be used on it safely.
          */
         tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+       if(tmp_buffer == NULL) {
+               return -ENOMEM;
+       }
         if (copy_from_user(tmp_buffer, buffer, count)) {
                 result = -EFAULT;
         }
