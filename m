Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262943AbSJBDSF>; Tue, 1 Oct 2002 23:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262945AbSJBDSF>; Tue, 1 Oct 2002 23:18:05 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:63499 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262943AbSJBDSE>; Tue, 1 Oct 2002 23:18:04 -0400
Date: Wed, 2 Oct 2002 04:23:27 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: willy@debian.org
Subject: Re: flock(fd, LOCK_UN) taking 500ms+ ?
Message-ID: <20021002032327.GA91947@compsoc.man.ac.uk>
References: <20021002023901.GA91171@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002023901.GA91171@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17wa6h-000NzI-00*YE18j5pvs7Y* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 03:39:01AM +0100, John Levon wrote:

> Unlock, took 541386 usecs

Hmm. This :

--- linux-linus/fs/locks.c	Sat Sep 28 15:56:28 2002
+++ linux/fs/locks.c	Wed Oct  2 04:15:54 2002
@@ -727,11 +727,11 @@
 	}
 	unlock_kernel();
 
-	if (found)
-		yield();
-
 	if (new_fl->fl_type == F_UNLCK)
 		return 0;
+
+	if (found)
+		yield();
 
 	lock_kernel();
 	for_each_lock(inode, before) {

"fixes" the problem (a simultaneous kernel compile is going on; it's a
2-way SMP machine). What is the yield for ? What's the right fix (if
any) ? This turns our app's main loop from a second or two into a
90-second behemoth.

There are no other apps taking locks on the relevant files, btw

regards
john

-- 
"I never understood what's so hard about picking a unique
 first and last name - and not going beyond the 6 character limit."
 	- Toon Moene
