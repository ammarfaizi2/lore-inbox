Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRCKTsD>; Sun, 11 Mar 2001 14:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRCKTry>; Sun, 11 Mar 2001 14:47:54 -0500
Received: from avalon.student.liu.se ([130.236.230.76]:22967 "EHLO
	mail.student.liu.se") by vger.kernel.org with ESMTP
	id <S129112AbRCKTrh>; Sun, 11 Mar 2001 14:47:37 -0500
Date: Sun, 11 Mar 2001 20:51:50 +0100
From: JörgenCederlöf 
	<jorce778@student.liu.se>
To: torvalds@transmeta.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Correct module count in do_mount()
Message-ID: <20010311205149.A19941@ondska>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
X-god-play-dice: No
X-eric-conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If do_mount() fails in the wrong place, the filesystem module count
is incremented twice, but decremented only once.

This patch agains 2.4.2 fixes the problem.

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
 
