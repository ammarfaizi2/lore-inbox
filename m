Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030541AbWJCVEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbWJCVEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbWJCVEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:04:22 -0400
Received: from outmx024.isp.belgacom.be ([195.238.4.128]:37267 "EHLO
	outmx024.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030554AbWJCVEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:04:20 -0400
Date: Tue, 3 Oct 2006 23:04:06 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.19 watchdog patches - part 2bis
Message-ID: <20061003210406.GC2397@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I forgot to add this trivial bit. Sorry about that. Can you do an extra
pull from 'master' branch of
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 drivers/char/watchdog/iTCO_wdt.c    |    2 +-
 drivers/char/watchdog/pnx4008_wdt.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

with these Changes:

Merge: f311896... 2fee7b1...
Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Tue Oct 3 23:01:47 2006 +0200

    Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Wed Sep 13 21:27:29 2006 +0200

    [WATCHDOG] use ENOTTY instead of ENOIOCTLCMD in ioctl()
    
    Return ENOTTY instead of ENOIOCTLCMD in user-visible ioctl() results
    
    The watchdog drivers used to return ENOIOCTLCMD for bad ioctl() commands.
    ENOIOCTLCMD should not be visible by the user, so use ENOTTY instead.
    
    Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Acked-by: Alan Cox <alan@redhat.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/char/watchdog/iTCO_wdt.c b/drivers/char/watchdog/iTCO_wdt.c
index ebd3fc8..8f89948 100644
--- a/drivers/char/watchdog/iTCO_wdt.c
+++ b/drivers/char/watchdog/iTCO_wdt.c
@@ -494,7 +494,7 @@ static int iTCO_wdt_ioctl (struct inode 
 		}
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
diff --git a/drivers/char/watchdog/pnx4008_wdt.c b/drivers/char/watchdog/pnx4008_wdt.c
index e7f0450..db2731b 100644
--- a/drivers/char/watchdog/pnx4008_wdt.c
+++ b/drivers/char/watchdog/pnx4008_wdt.c
@@ -184,7 +184,7 @@ static int
 pnx4008_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 		  unsigned long arg)
 {
-	int ret = -ENOIOCTLCMD;
+	int ret = -ENOTTY;
 	int time;
 
 	switch (cmd) {
