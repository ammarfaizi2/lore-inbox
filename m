Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSKEPLg>; Tue, 5 Nov 2002 10:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264864AbSKEPLg>; Tue, 5 Nov 2002 10:11:36 -0500
Received: from vt-williston4b-36.bur.adelphia.net ([24.48.243.36]:49801 "EHLO
	infocalypse.jimlawson.org") by vger.kernel.org with ESMTP
	id <S264863AbSKEPLf>; Tue, 5 Nov 2002 10:11:35 -0500
Date: Tue, 5 Nov 2002 10:18:11 -0500 (EST)
From: Jim Lawson <jim+linux-kernel@jimlawson.org>
X-X-Sender: jim@infocalypse.jimlawson.org
To: linux-kernel@vger.kernel.org
Subject: [Q] How to flush disk cache w/read-only filesystem w/o unmount&remount?
 (shared SAN filesystem) 
Message-ID: <Pine.LNX.4.44.0211051014110.24422-100000@infocalypse.jimlawson.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings kernel-hackers -

I'm setting up a web farm with a number of Linux machines (ia32) attached
via FC-AL to a shared SAN.  There are 3 web servers, one of them mounts
the filesystem read/write, the other 2 read/only.  (Filesystem is
currently ext3.)

Everything works "fine", until of course I try to modify files on the r/w
server.  Then we start seeing cache incoherency - the r/o systems now have
"stale" information cached.  Old versions of files and directories are not
replaced.

I'm looking for a way to flush or invalidate the cache on the block
device/filesystem, so that the system is forced to go all the way to the
disk.  Unmounting and remounting would accomplish this, of course, but
that's tough to do in production.

This is a "read-mostly" application - I really only need to update the
filesystem once a day or so - but I'd like to find a nice way to do it,
without having to use NFS.

More info, if needed: Running Linux 2.4.18 (under Debian woody.)  Using
the qla2200 driver from Qlogic, although I don't think that matters - it
looks like the caching happens in the VFS somewhere...

I've tried blockdev --flushbufs, which appears to do a BLKFLSBUF, but that
seems to be equivalent to "sync" - just pushes the dirty buffers to disk,
which doesn't help me.

Looking in fs/dcache.c, I see shrink_dcache_sb(struct super_block *),
which *might* do what I want, but there doesn't seem to be any way to call
that from user-land.  And that probably just updates the dentries - I
don't know if that has any effect on the file data.

Hoping someone with more kernel experience can enlighten me -
Jim Lawson







