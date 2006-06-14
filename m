Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWFNN7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWFNN7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWFNN7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:59:43 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:41012 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964947AbWFNN7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:59:42 -0400
Message-ID: <44901647.4030205@openvz.org>
Date: Wed, 14 Jun 2006 17:59:35 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Return error in case flock_lock_file failure
Content-Type: multipart/mixed;
 boundary="------------080502020109030409080308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080502020109030409080308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

If flock_lock_file() failed to allocate flock with locks_alloc_lock()
then "error = 0" is returned. Need to return some non-zero.

Signed-Off-By: Pavel Emelianov <xemul@openvz.org>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>


--------------080502020109030409080308
Content-Type: text/plain;
 name="diff-ms-flock-lock-file-err-20060605"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-flock-lock-file-err-20060605"

--- ./fs/locks.c.flfix	2006-06-05 12:09:42.000000000 +0400
+++ ./fs/locks.c	2006-06-05 12:27:20.000000000 +0400
@@ -705,6 +705,7 @@ static int flock_lock_file(struct file *
 	if (request->fl_type == F_UNLCK)
 		goto out;
 
+	error = -ENOMEM;
 	new_fl = locks_alloc_lock();
 	if (new_fl == NULL)
 		goto out;
@@ -731,6 +732,7 @@ static int flock_lock_file(struct file *
 	locks_copy_lock(new_fl, request);
 	locks_insert_lock(&inode->i_flock, new_fl);
 	new_fl = NULL;
+	error = 0;
 
 out:
 	unlock_kernel();


--------------080502020109030409080308--
