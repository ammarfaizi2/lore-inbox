Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265441AbUAEF2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 00:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265882AbUAEF2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 00:28:53 -0500
Received: from SMTP2.andrew.cmu.edu ([128.2.10.82]:23991 "EHLO
	smtp2.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S265441AbUAEF2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 00:28:50 -0500
Date: Mon, 5 Jan 2004 00:28:50 -0500 (EST)
From: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: File system cache corruption in 2.6?
Message-ID: <Pine.LNX.4.58-035.0401050014450.5565@unix49.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	I'm trying to work out the cause of a series of issues I've seen
on my 2.6 machine.  It appears as though files (specifically libraries) in
memory can get corrupted, resulting in strangeness like segfaults and
things like "relocation error: can't find symbol ...-VOMD-POINTER" instead
of "...-VOID-POINTER".

I don't believe it's actual hardware failure for a few reasons: memtest86
passes all tests, GCC doesn't crash (it's a Gentoo system, so gcc and I
are well acquainted - and before I get jumped on, I've installed udev ;)
), and most importantly, sometimes thrashing the file system or engaging a
kernel compile will rectify the situation, as just happened with emacs.
It crashed, I killed it, it wouldn't load - I started a kernel compile,
waited a bit, and lo', it works again.  No messages of relevance appear in
dmesg.

I have no reliable test-case and the problem only seems to surface after a
decent amount of uptime (12 hours this time, but other times the system
has been perfectly well behaved for days).

My system's running XFS filesystems, 2.6.0 vanilla, and is a Fujitsu P2120
Crusoe based laptop with 386MB RAM.

I recall there was some concern about SLAB corruption and XFS - could it
still be a problem?

ver_linux output:
Linux Enthare 2.6.0 #1 Wed Dec 24 00:13:49 EST 2003 i686 Transmeta(tm)
Crusoe(tm) Processor TM5800 GenuineTMx86 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre4
e2fsprogs              1.34
pcmcia-cs              3.2.5
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0.91
Modules Loaded         8139too mii crc32 sg md5 ipv6 rtc usbcore
orinoco_pci orinoco hermes ide_cd cdrom

If anything else could be added to make this bug report / help request
more useful, let me know.  I'm going to reboot soon with this newly built
kernel (2.6.0-rc1-mm1) and will report back if the same problem seems to
crop up again.

Thanks in advance, and keep up the great work.
--nwf;
