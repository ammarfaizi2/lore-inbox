Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265022AbSJPOvw>; Wed, 16 Oct 2002 10:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265024AbSJPOvw>; Wed, 16 Oct 2002 10:51:52 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:9740 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S265022AbSJPOvu>;
	Wed, 16 Oct 2002 10:51:50 -0400
Date: Wed, 16 Oct 2002 15:57:28 +0100
From: John Levon <levon@movementarian.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: willy@debian.org, akpm@digeo.com
Subject: Re: Linux v2.5.43
Message-ID: <20021016145728.GA78571@compsoc.man.ac.uk>
References: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *181pc0-000Cob-00*4zjUyQmTfMQ* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 08:44:10PM -0700, Linus Torvalds wrote:

> John Levon <levon@movementarian.org>:
>   o oprofile - core

Note that anybody actually wanting to use the thing needs an additional
fix like the below, or most of the samples end up being dropped on the
floor.

Matthew, can we submit the proper fix (using cond_resched ?) at some
point ?

thanks
john


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
