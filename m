Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268819AbTBZRCu>; Wed, 26 Feb 2003 12:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268830AbTBZRCu>; Wed, 26 Feb 2003 12:02:50 -0500
Received: from cmailm1.svr.pol.co.uk ([195.92.193.18]:24584 "EHLO
	cmailm1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S268819AbTBZRCU>; Wed, 26 Feb 2003 12:02:20 -0500
Date: Wed, 26 Feb 2003 17:11:57 +0000
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] dm: allow slashes in dm device names
Message-ID: <20030226171157.GF8369@fib011235813.fsnet.co.uk>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.3i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow slashes ('/') within a DM device name, but not at the beginning.

Devfs will automatically create all necessary sub-directories if a name
with embedded slashes is registered.  [Kevin Corry]

--- diff/drivers/md/dm-ioctl.c	2003-02-26 16:09:57.000000000 +0000
+++ source/drivers/md/dm-ioctl.c	2003-02-26 16:10:07.000000000 +0000
@@ -545,7 +545,7 @@
 
 static int check_name(const char *name)
 {
-	if (strchr(name, '/')) {
+	if (name[0] == '/') {
 		DMWARN("invalid device name");
 		return -EINVAL;
 	}
