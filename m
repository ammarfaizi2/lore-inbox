Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288225AbSACHXC>; Thu, 3 Jan 2002 02:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288234AbSACHWy>; Thu, 3 Jan 2002 02:22:54 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:36612 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288231AbSACHWg>; Thu, 3 Jan 2002 02:22:36 -0500
Date: Thu, 3 Jan 2002 10:22:35 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] kreiserfsd sleep timeout thinko
Message-ID: <20020103102235.A2641@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    This patch corrects a typo in fs/reiserfs/journal.c:
    interruptible_sleep_on_timeout() takes timeout in jiffies, rather
    than seconds.

Bye,
    Oleg

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="L-kreiserfsd-sleep-timeout.patch"

diff -rup -X dontdiff linux/fs/reiserfs/journal.c linux.patched/fs/reiserfs/journal.c
--- linux/fs/reiserfs/journal.c	Mon Nov 19 21:17:03 2001
+++ linux.patched/fs/reiserfs/journal.c	Mon Nov 19 21:36:38 2001
@@ -1851,7 +1851,7 @@ static int reiserfs_journal_commit_threa
       break ;
     }
     wake_up(&reiserfs_commit_thread_done) ;
-    interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5) ;
+    interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5 * HZ) ;
   }
   unlock_kernel() ;
   wake_up(&reiserfs_commit_thread_done) ;

--wRRV7LY7NUeQGEoC--
