Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266601AbUGKOP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266601AbUGKOP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 10:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266602AbUGKOP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 10:15:28 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:8928 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266601AbUGKOPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 10:15:21 -0400
Message-ID: <40F14B75.1010802@comcast.net>
Date: Sun, 11 Jul 2004 10:15:17 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NX: List of apps that probably break with NX
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I've noticed you're pondering an NX technology in the kernel.  I help
maintain a list of applications that break under PaX, an NX/ASLR patch,
used for a script which applies reduced restrictions to these binaries.
~ The result is that I have a handfull of unprotected apps; but
everything works.  You either have to trade off the security for the
usability, or the usability for the security.

PaX uses two tools to set reduced restrictions: chpax and paxctl.  The
chpax tool uses a free field in the ELF header; while paxctl uses a
special field set aside by a specially patched binutils.  Binaries with
this extra field are natively compatible with vanilla Linux.

The different flags are as follows:

P  PageExec (NX method) to supply functionality of NX marking of pages
S  SegmExec (NX method) to supply functionality of NX marking of pages
E  Emulate Trampolines
M  Reduced mprotect() restrictions (basically fixes things wanting +X
stack)
R  Random mmap() base
X  Random ET_EXEC base


I supply these as shell patterns.  Be familiar with bash, or try:

$ echo `exec <pattern>`


NX-Exempt (-psem)
~  Wine:
/usr/lib/wine/bin/{wine{,build,clipsrv,dump,gcc,server,wrap,-{k,p}thread},w{mc,rc,idl}}

~  Java:
/opt/*-{jdk-*/{,jre/},jre-*/}bin/*

OpenOffice.org:
/opt/OpenOffice.org*/program/soffice.bin

Misc:
/usr/X11R6/bin/XFree86
/usr/X11R6/bin/Xorg
/usr/bin/blender
/usr/bin/gxine
/usr/bin/xine
/usr/bin/totem
/usr/bin/acme
/usr/bin/gnome-sound-recorder
/usr/games/bin/bzflag
/usr/bin/xfce4-panel
/usr/bin/{g,}xine

Randmap Exempt (-r)
Java:
/opt/*-{jdk-*/{,jre/},jre-*/}bin/*

X:
/usr/X11R6/bin/XFree86
/usr/X11R6/bin/Xorg

mprotect() restriction exempt (-m)
Java:
/opt/*-{jdk-*/{,jre/},jre-*/}bin/*

Firefox:
/usr/lib/MozillaFirefox/firefox{,-bin}

xmms:
/usr/bin/xmms

RandExec Exempt (-x):
Java:
/opt/*-{jdk-*/{,jre/},jre-*/}bin/*

X:
/usr/X11R6/bin/XFree86
/opt/*-{jdk-*/{,jre/},jre-*/}bin/*



The bug used to track changes in the scripts that supply the application
of reduced restrictions is at
http://bugs.gentoo.org/show_bug.cgi?id=40665 .  This may prove
interesting, as I or someone else will need to update it as more
applications break, or as more begin to work.

- --John
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8Ut0hDd4aOud5P8RAmPyAJ0abHDHZAvb+nyl5Fs0CDXYwX7ZDACgibwV
Ls2RB3CjkY8VHKUS1GAAcmE=
=ASsQ
-----END PGP SIGNATURE-----
