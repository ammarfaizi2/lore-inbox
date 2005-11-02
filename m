Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbVKBInE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbVKBInE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVKBInD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:43:03 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:21689 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932653AbVKBInB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:43:01 -0500
Message-ID: <43687BE4.3000708@gmail.com>
Date: Wed, 02 Nov 2005 02:42:12 -0600
From: Hareesh Nagarajan <hnagar2@gmail.com>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
CC: akpm@osdl.org
Subject: [PATCH] register_filesystem() must return -EEXIST if the filesystem
 with the same name is already registered
Content-Type: multipart/mixed;
 boundary="------------090901040900030402050304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090901040900030402050304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If we have a look at the register_filesystem() function defined in 
fs/filesystems.c, we see that if a filesystem with a same name has 
already been registered then the find_filesystem() function will return 
NON-NULL otherwise it will return NULL.

Hence, register_filesystem() should return EEXIST instead of EBUSY. 
Returning EBUSY is misleading (unless of course I'm missing something 
obvious) to the caller of register_filesystem().

Thanks,

Hareesh Nagarajan


--------------090901040900030402050304
Content-Type: text/x-patch;
 name="err-register-filesystem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="err-register-filesystem.patch"

--- linux-2.6.13.4/fs/filesystems.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/fs/filesystems.c	2005-11-02 02:33:30.685600000 -0600
@@ -76,7 +76,7 @@
 	write_lock(&file_systems_lock);
 	p = find_filesystem(fs->name);
 	if (*p)
-		res = -EBUSY;
+		res = -EEXIST;
 	else
 		*p = fs;
 	write_unlock(&file_systems_lock);

--------------090901040900030402050304--
