Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbVLIM7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVLIM7B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 07:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVLIM7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 07:59:01 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:55373 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1751048AbVLIM7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 07:59:01 -0500
Message-ID: <43997F5C.1080700@ru.mvista.com>
Date: Fri, 09 Dec 2005 15:58:04 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] posix_fadvise bug (unexpected success on FIFO/pipe)
Content-Type: multipart/mixed;
 boundary="------------070806050804090605070205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070806050804090605070205
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello all.
This patch adds a FIFO/pipe check to posix_fadvise system call.
If the specified file descriptor is pipe or FIFO, the system call 
returns ESPIPE error.
Thank you.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>


--------------070806050804090605070205
Content-Type: text/x-patch;
 name="fadv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fadv.patch"

--- a/mm/fadvise.c 2005-10-10 22:54:29.000000000 +0400
+++ b/mm/fadvise.c 2005-12-06 23:04:19.980711464 +0300
@@ -37,6 +37,11 @@
        if (!file)
                return -EBADF;
 
+       if (S_ISFIFO(file->f_dentry->d_inode->i_mode)) {
+               ret = -ESPIPE;
+               goto out;
+       }
+
        mapping = file->f_mapping;
        if (!mapping || len < 0) {
                ret = -EINVAL;


--------------070806050804090605070205--
