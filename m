Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319201AbSHTRE2>; Tue, 20 Aug 2002 13:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319202AbSHTRE2>; Tue, 20 Aug 2002 13:04:28 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:35260 "EHLO nick")
	by vger.kernel.org with ESMTP id <S319201AbSHTRE1>;
	Tue, 20 Aug 2002 13:04:27 -0400
Date: Tue, 20 Aug 2002 18:10:40 +0100 (BST)
From: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: automount doesn't "follow" bind mounts
Message-ID: <Pine.LNX.4.44.0208201752430.23681-100000@r2-pc.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-uvscan-result: clean (17hCUa-0001Cw-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to subscribe to the autofs list, but majordomo isn't replying to 
me! I think this is a problem in the automount daemon rather than the 
kernel autofs code itself.

I'm trying to automount our home dirs as
	/homes/$USERNAME
which should bind mount to
	:/home/$SERVER/$HOMENAME/$USERNAME
which should bind mount to
	:/home/$SERVER/$VOLUME/$PATH/$USERNAME
which (phew!) will be an NFS mount to
	$SERVER:/$VOLUME/$PATH/$USERNAME

The idea is that:
	(1) `/bin/pwd` = "/homes/$USERNAME"
	(2) when you run "quota" it'll only report for $SERVER:/$VOLUME

Now.. this all works perfectly if before looking at /homes/$USERNAME you
look at firstly /home/$SERVER/$VOLUME/$PATH/$USERNAME and then secondly
/home/$SERVER/$HOMENAME/$USERNAME, because the bind mounts have something
to bind to. Of course you shouldn't need to know the middle bits, but you
could look them up. Currently the binds mount fail and automount drops in
symlinks; this satisfies (2)  above, but unfortunately not (1).

I hope someone can make sense of this. Is it different in autofs4?

Matt

