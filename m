Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263789AbUDUHsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbUDUHsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 03:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbUDUHsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 03:48:35 -0400
Received: from [213.156.65.50] ([213.156.65.50]:36773 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S263789AbUDUHse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 03:48:34 -0400
Subject: 2.6.5, loop_set_fd()...
From: Yury Umanets <torque@ukrpost.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Content-Type: text/plain
Message-Id: <1082533853.2589.77.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 21 Apr 2004 10:51:11 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have found small inconsistency in loop_set_fd(). It checks if
->sendfile() is implemented for passed block device file. But in fact,
loop back device driver never calls it. It uses ->sendfile() from
backing store file. See patch.

--- linux-2.6.5/drivers/block/loop.c.orig       2004-04-04
06:37:23.000000000 +0300
+++ linux-2.6.5/drivers/block/loop.c    2004-04-21 10:34:39.066501968
+0300
@@ -646,7 +646,7 @@ static int loop_set_fd(struct loop_devic
                 * If we can't read - sorry. If we only can't write -
well,
                 * it's going to be read-only.
                 */
-               if (!lo_file->f_op->sendfile)
+               if (!file->f_op->sendfile)
                        goto out_putf;
  
                if (!aops->prepare_write || !aops->commit_write)


Thanks.

-- 
umka
-- 
umka

