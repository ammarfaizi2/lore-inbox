Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273729AbRJKIGG>; Thu, 11 Oct 2001 04:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273724AbRJKIF4>; Thu, 11 Oct 2001 04:05:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59409 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273691AbRJKIFr>; Thu, 11 Oct 2001 04:05:47 -0400
Date: Thu, 11 Oct 2001 01:04:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Uhhuh.. 2.4.12
Message-ID: <Pine.LNX.4.33.0110110058550.1198-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.11 had a fix for a symlink DoS attack, but sadly that fix broke the
creation of files through a dangling symlink rather badly (it caused the
inode to be created in the very same inode as the symlink, with unhappy
end results).

Happily nobody uses that particular horror - or _almost_ nobody does. It
looks like at least the SuSE installer (yast2) does, which causes a nasty
unkillable inode as /dev/mouse if you use yast2 on 2.4.11.

("debugfs -w rootdev" + "rm /dev/mouse" will remove it, although I suspect
there are other less drastic methods too if your fsck doesn't seem to
notice anything wrong with it. Only one report of this actually happening
so far).

So I made a 2.4.12, and renamed away the sorry excuse for a kernel that
2.4.11 was.

		Linus

-----
final:
 - Greg KH: USB update (fix UHCI timeouts, serial unplug)
 - Christoph Rohland: shmem locking fixes
 - Al Viro: more mount cleanup
 - me: fix bad interaction with link_count handling
 - David Miller: Sparc updates, net cleanup
 - Tim Waugh: parport update
 - Jeff Garzik: net driver updates

