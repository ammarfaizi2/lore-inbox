Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVCUKdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVCUKdd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 05:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVCUKdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 05:33:33 -0500
Received: from fmr21.intel.com ([143.183.121.13]:4008 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261726AbVCUKd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 05:33:29 -0500
Subject: [PATCH 2.6] fix mmap() return value to conform to POSIX
From: Hong Liu <hong.liu@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1111400799.3548.7.camel@devlinux-hong>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 21 Mar 2005 18:26:39 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX said:
mmap() should return [EOVERFLOW] if the file is a regular file and the
value of off + len exceeds the offset maximum established in the open
file description associated with fildes.

--- a/mm/mmap.c.orig 2005-03-16 14:08:59.116052416 +0800
+++ b/mm/mmap.c      2005-03-16 14:10:16.167338840 +0800
@@ -906,7 +906,7 @@ unsigned long do_mmap_pgoff(struct file
        
	/* offset overflow? */
        if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
-               return -EINVAL;
+               return -EOVERFLOW;

        /* Too many mappings? */
        if (mm->map_count > sysctl_max_map_count)


