Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262177AbTCMFmo>; Thu, 13 Mar 2003 00:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbTCMFmo>; Thu, 13 Mar 2003 00:42:44 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4060 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262177AbTCMFmn>; Thu, 13 Mar 2003 00:42:43 -0500
Date: Thu, 13 Mar 2003 00:53:28 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: Patch for initrd on 2.4.21-pre5
Message-ID: <20030313005328.A29160@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The initrd refuses to work for me without the attached patch
(actually, initrd works, but nothing else does: console is hosed).
I did not see anything on the list. Am I the only one who
uses initrd?

-- Pete

--- linux-2.4.21-pre5/init/do_mounts.c	2003-03-12 21:21:05.000000000 -0800
+++ linux-2.4.21-pre5-nip/init/do_mounts.c	2003-03-12 21:43:03.000000000 -0800
@@ -813,6 +813,8 @@
 	sys_fchdir(root_fd);
 	sys_chroot(".");
 	sys_umount("/old/dev", 0);
+	close(old_fd);
+	close(root_fd);
 
 	if (real_root_dev == ram0) {
 		sys_chdir("/old");
