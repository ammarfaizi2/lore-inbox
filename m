Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131672AbRCXNwv>; Sat, 24 Mar 2001 08:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131676AbRCXNwl>; Sat, 24 Mar 2001 08:52:41 -0500
Received: from avalon.student.liu.se ([130.236.230.76]:201 "EHLO
	mail.student.liu.se") by vger.kernel.org with ESMTP
	id <S131672AbRCXNwc>; Sat, 24 Mar 2001 08:52:32 -0500
Date: Sat, 24 Mar 2001 14:58:23 +0100
From: Jorgen Cederlof <jorgen.cederlof@cendio.se>
To: torvalds@transmeta.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Bug in do_mount()
Message-ID: <20010324145822.B1353@ondska>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
X-god-play-dice: No
X-eric-conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_mount() can sometimes fail to mount a filesystem, but still
increment the filesystem module count.

This patch against 2.4.2 should fix the problem.

       Jörgen

--- fs/super.c.orig	Sun Mar 11 20:25:26 2001
+++ fs/super.c	Sun Mar 11 20:05:27 2001
@@ -1414,6 +1414,8 @@
 fail:
 	if (list_empty(&sb->s_mounts))
 		kill_super(sb, 0);
+	else
+		put_filesystem(fstype);
 	goto unlock_out;
 }
 

