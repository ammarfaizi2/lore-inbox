Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVAYQmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVAYQmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVAYQmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:42:14 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:39432
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262004AbVAYQmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:42:05 -0500
Date: Tue, 25 Jan 2005 17:42:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: CVSps@dm.cobite.com, Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>
Subject: kernel CVS troubles with cvsps
Message-ID: <20050125164203.GY7587@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry to annoy you about this, but something is going wrong with either
cvsps or the kernel CVS.

I reproducibly get this as the last changeset, note the date. The
--bkcvs breaks completely too, but that would be a minor issue since
cvsps by default will get it right from the dates that are atomic with
the bk2cvs conversion.

---------------------
PatchSet 58582
Date: 1970/01/01 01:33:25
Author: zwane
Log:
x86_64: Notify user of MCE events.

(Logical change 1.25778)

Members:
        arch/x86_64/kernel/mce.c:1.18->1.19


But cvs log says this:

[..]
description:
BitKeeper to RCS/CVS export
----------------------------
revision 1.20
date: 2005-01-15 23:24:52 +0000;  author: suresh.b.siddha;  state: Exp;
lines: +2 -2
x86_64: use cpumask_t instead of unsigned long

(Logical change 1.25965)
----------------------------
revision 1.19
date: 2005-01-12 01:51:57 +0000;  author: zwane;  state: Exp;  lines:
+18 -0
x86_64: Notify user of MCE events.

(Logical change 1.25778)
[..]

So something is going wrong, that's not even the last checkin in the
mce.c file, so it can't be the last global changeset. I thought it was
the kernel CVS being wrong since no change has happened to cvsps for a
long time, but now I'm not sure anymore because I couldn't find obvious
screwups in the kernel CVS yet. I reproduced with latest stable and
unstable cvsps. Kernel cvs is fetched with:

rsync -za --delete --force \
rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/ linux-2.5/

Can somebody else reproduce it? It would be helpful to know somebody
else can reproduce it too.

Notably `cvsps -x` spawns a number of warnings while it builds the cache
which again made me think this isn't a cvsps mistake.

I get the same screwup in the 2.4 kernel CVS too (not only in 2.5/2.6):

andrea@dualathlon:~/devel/kernel/linux-2.4> cvsps -x
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members


So I doubt it's some internal overflow of cvsps, plus it didn't start
happening on a special date (i.e. it happened in 2004 too).

Any help is appreciated. I'm just starting to look more seriously into
this since I've some tools that depends on the cvsps to work and kernel
CVS is the only fully coherent linearized source of info in open format
(rest is either a priorietary format or unusable because out of
synchrony because not linearized).  Until now I hoped that by waiting it
would automatically fixup, but it didn't yet ;).

Thanks!
