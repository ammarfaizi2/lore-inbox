Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbQKQItV>; Fri, 17 Nov 2000 03:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129349AbQKQItD>; Fri, 17 Nov 2000 03:49:03 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7684 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130026AbQKQIsz>;
	Fri, 17 Nov 2000 03:48:55 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14868.59680.687933.68204@wire.cadcamlab.org>
Date: Fri, 17 Nov 2000 02:15:28 -0600 (CST)
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org, linux-kbuild@torque.net
Subject: test11pre6: incorrect makefile change
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This toplevel Makefile change in 11pre6 is wrong:

-	$(HOSTCC) $(HOSTCFLAGS) -o scripts/split-include scripts/split-include.c
+	$(HOSTCC) $(HOSTCFLAGS) -I$(HPATH) -o scripts/split-include scripts/split-include.c

Many people have proposed this patch over the last few years, to kludge
around having a broken setup.  Basically, split-include.c is a regular
userspace program so if you can't compile it (without the -I), you
won't be able to compile the rest of userspace either.

Either you need the proper kernel directory symlinks in /usr/include/*,
or you need to make a copy of them like Debian does.

Linus, please revert.  Not only is it conceptually wrong, it will do
interesting things if you happen to be cross-compiling for another
architecture.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
