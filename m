Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUCPWA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUCPWA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:00:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63925 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261742AbUCPWAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:00:22 -0500
Subject: [PATCH] Fix blkpg ioctl32 handling
From: Jeremy Katz <katzj@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Content-Type: multipart/mixed; boundary="=-BrBIKaxjqG/lz/PADm2Z"
Message-Id: <1079474322.7787.13.camel@edoras.local.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 (1.5.5-1) 
Date: Tue, 16 Mar 2004 16:58:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BrBIKaxjqG/lz/PADm2Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Simple obvious patch so that all calls to blkpg from the non-native
environment don't get -EINVAL

Jeremy

--=-BrBIKaxjqG/lz/PADm2Z
Content-Disposition: attachment; filename=linux-2.6.4-blkpg.patch
Content-Type: text/x-diff; name=linux-2.6.4-blkpg.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.4/fs/compat_ioctl.c.blkpg	2004-03-16 16:12:17.761705684 -0500
+++ linux-2.6.4/fs/compat_ioctl.c	2004-03-16 16:12:40.186738770 -0500
@@ -1952,6 +1952,7 @@
 		set_fs (KERNEL_DS);
 		err = sys_ioctl(fd, cmd, (unsigned long)&a);
 		set_fs (old_fs);
+                break;
 	default:
 		return -EINVAL;
 	}                                        

--=-BrBIKaxjqG/lz/PADm2Z--

