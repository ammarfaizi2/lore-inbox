Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSLONn7>; Sun, 15 Dec 2002 08:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbSLONn7>; Sun, 15 Dec 2002 08:43:59 -0500
Received: from [81.2.122.30] ([81.2.122.30]:44805 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261411AbSLONn6>;
	Sun, 15 Dec 2002 08:43:58 -0500
From: John Bradford <john@bradfords.org.uk>
Message-Id: <200212151403.gBFE3Ti5000861@darkstar.example.net>
Subject: Union mounts
To: linux-kernel@vger.kernel.org
Date: Sun, 15 Dec 2002 14:03:29 +0000 (GMT)
Cc: junkio@cox.net, andrew@walrond.org
In-Reply-To: <200212151258.gBFCwEDZ000672@darkstar.example.net> from "John Bradford" at Dec 15, 2002 12:58:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I disagree.  It should create it in directory d, even though that is
> the mount point.
> 
> A union mount should include files from another directory, but writes
> should go to the actual named directory.
> 
> Union mounts should be read only.
> 
> If read-write union mounts are needed, I don't think that we should
> implement them significantly differently to the way they work in BSD.

That wasn't very well explained, what I mean is this:

Example:

# cd /
# mkdir foo
# mount -o union /dev/hda2 /foo
# echo foobar > foo/bar
# umount /dev/hda2
# cat foo/bar
foobar

That's what I would consider to be the most useful way to implement
union mounts - the contents of /dev/hda2 would be accessible,
read-only, at /foo/bar, with files that already exist in /foo/bar
replacing files that would otherwise be visible from /dev/hda2.

Writes would go to the directory foo, which is just an ordinary
subdirectory of the root filesystem.

This is completely different to the mount_union behavior in BSD, where
writes go to the most recently added union mount.

However, it might be best to implement things the BSD way for
compatibility reasons, but I'm not sure how widespread the use of
mount_union is.  It's probably not widely used.

John.
