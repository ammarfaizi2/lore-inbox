Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbSI1OVh>; Sat, 28 Sep 2002 10:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261670AbSI1OVg>; Sat, 28 Sep 2002 10:21:36 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:29459 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261630AbSI1OVf>; Sat, 28 Sep 2002 10:21:35 -0400
Date: Sat, 28 Sep 2002 16:25:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: linux kernel conf 0.7
Message-ID: <Pine.LNX.4.44.0209281529580.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At http://www.xs4all.nl/~zippel/lc/ you can find the latest version of the
new config system. Besides the usual archive there is also now a patch
against a 2.5.39 kernel and finally some documentation. This patch I also
consider as my first release canditate, so please test this one carefully,
this release contains pretty much everything I want from the first release
to be integrated into the kernel.
Other changes:
- update to 2.5.39
- seperate kernel Makefile (by Sam Ravnborg/Kai Germaschewski)
- lots of qconf fine tuning
- the generated config files are now named Build.conf and use tabs
  instead of two spaces, which makes it easier to read.

An issue (which was also mentioned by Jeff Garzik) is the help text
format. Jeff likes to have an endhelp, where I think it's redundant. The
parser currently checks the amount of indendation to find the end of the
help text, this makes the help text quite easy to read and parse. If
someone prefers an endhelp (or has an even better idea), please speak up
now, if enough people complain, I have no problem changing it.

If someone is still wondering, why he should use lkc, as he is happy with
"make oldconfig", look at this comparison. Current version:

$ time make oldconfig
/bin/sh ./scripts/Configure -d arch/i386/config.in
#
# Using defaults found in .config
#
...

real    0m13.213s
user    0m5.520s
sys     0m5.440s

New version:

$ time make oldconfig
make[1]: Entering directory `/home/roman/src/lc'
make[1]: `conf' is up to date.
make[1]: Leaving directory `/home/roman/src/lc'
./scripts/lkc/conf -o arch/i386/Build.conf
#
# using defaults found in .config
#
...

real    0m0.473s
user    0m0.220s
sys     0m0.050s

These are the numbers from cache, so you have to add the amount of time
needed to read the config files from disk. The new files are larger as
they include the help text, but as long as you don't configure over a very
slow network, it will still be faster.

bye, Roman

