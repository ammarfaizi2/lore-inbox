Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274281AbRITAYG>; Wed, 19 Sep 2001 20:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274282AbRITAX4>; Wed, 19 Sep 2001 20:23:56 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:61189 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S274281AbRITAXj>; Wed, 19 Sep 2001 20:23:39 -0400
Date: Wed, 19 Sep 2001 20:25:39 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: <linux-kernel@vger.kernel.org>
cc: Fabian Arias <dewback@vtr.net>, <reiserfs-list@namesys.com>
Subject: [PATCH] 2.4.9-ac12 - problem mounting reiserfs (parse error?)
In-Reply-To: <Pine.LNX.4.40.0109191248360.5460-100000@ronto.dewback.cl>
Message-ID: <Pine.LNX.4.33.0109192018010.1016-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> But in my case I don't have "defaults" on fstab on my reiserfs partitions:
>
> /dev/hdc1  /      ext2          defaults,errors=remount-ro      0 1
> /dev/hdc5  /home  reiserfs      rw                              0 2

The common part is that you only have options recognized before they come
to the reiserfs level.  So the option list is empty at this point, with
reiserfs cannot deal with it.

Here's the fix for 2.4.9-ac12:

---------------------------------
--- linux.orig/fs/reiserfs/super.c
+++ linux/fs/reiserfs/super.c
@@ -223,7 +223,7 @@ static int parse_options (
 	{"0", 0}
     };
     *blocks = 0;
-    if (!options)
+    if (!options || !*options)
 	/* use default configuration: create tails, journaling on, no
            conversion to newest format */
 	return 1;
---------------------------------

If the string is empty, there is nothing to parse in it.  Another question
is that the parser could be made more robust, but my patch is correct,
minimal and works for me.

> > "reiserfs kgetopt: there is not option" appears on the console and in the
> > dmesg output, it's not coming from mount.

To reiserfs team: please check spelling.  It should be "there is no
option".  Also there are "pounters" in the comments.

-- 
Regards,
Pavel Roskin

