Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUBKBF4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUBKBF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:05:56 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:15622 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id S261152AbUBKBFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:05:54 -0500
Date: Wed, 11 Feb 2004 02:04:36 +0100
From: =?ISO-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>
To: linux-kernel@vger.kernel.org
Subject: BUG: Why does ramfs always get built?
Message-ID: <20040211010436.GA13684@metuzalem.tesarici.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux metuzalem 2.4.24 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

ramfs cannot be removed from the kernel

Description:
Now, I wonder if there's any reason why the Simple RAM-based file
system, which is "more of an programming example than a usable file
system" (according to Configure.help), needs to be present in the
kernel.

Keywords: ramfs build Config.in

Kernel version:
Linux version 2.4.24 (root@metuzalem) (gcc version 2.95.4 20011002 (Debian prerelease)) #7 Ne úno 8 05:57:36 CET 2004

OK, it's line 55 of fs/Config.in, which reads:

define_bool CONFIG_RAMFS y

I think, it should read:

tristate 'Simple RAM-based file system support' CONFIG_RAMFS

but maybe this is a known issue and the ramfs is needed for something
I can't figure out (I recompiled my kernel without ramfs and it works
fine, so there is at least one configuration which does _NOT_ require
it and it should then definitely be optional anyway).

I know the piece of code is really small, but I don't want it
there.  Just because I don't need it and any unnecessary code is
inherently dangerous, as any code is a potential security hole.

For convenience sake, I've included a patch.

Petr T.

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-ramfs.patch"

diff -ruN linux-orig/fs/Config.in linux/fs/Config.in
--- linux-orig/fs/Config.in	Sat Jan 24 19:00:51 2004
+++ linux/fs/Config.in	Wed Feb 11 01:21:41 2004
@@ -52,7 +52,7 @@
 fi
 tristate 'Compressed ROM file system support' CONFIG_CRAMFS
 bool 'Virtual memory file system support (former shm fs)' CONFIG_TMPFS
-define_bool CONFIG_RAMFS y
+tristate 'Simple RAM-based file system support' CONFIG_RAMFS
 
 tristate 'ISO 9660 CDROM file system support' CONFIG_ISO9660_FS
 dep_mbool '  Microsoft Joliet CDROM extensions' CONFIG_JOLIET $CONFIG_ISO9660_FS

--LQksG6bCIzRHxTLp--
