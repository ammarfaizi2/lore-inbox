Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbTJaCtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 21:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTJaCtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 21:49:16 -0500
Received: from ppp-62-245-160-101.mnet-online.de ([62.245.160.101]:129 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S262781AbTJaCtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 21:49:12 -0500
To: linux-kernel@vger.kernel.org
Subject: WD Raptor/SATA with RAID0 way to slow
From: Julien Oster <lkml@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Fri, 31 Oct 2003 03:49:10 +0100
Message-ID: <frodoid.frodo.873cdadsux.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I recently purchased an Asus A7N8X mainboard with the Silicon Imaging
SATA controller online and two Western Digital Raptor SATA harddrives
with 10krpm.

Those harddisks are supposed to be "really fast", but I don't really
get the performance out of them. In fact, I get much less performance
than with my "standard consumer" IBM DeskStars.

Besides the WD Raptors, I have two IBM DeskStars (normal PATA). The
two IBM deskstars and the two WD Raptors are bundled to linux
softraids with RAID level 0 each.

I use the same hdparm command line for all drives during boot, which
is:

hdparm -c 1 -m 16 -S 241 -u 1 -k 1 -K 1

I first used a simple hdparm -t on the harddisks individually to see
how they perform alone. Here's the values I got for one of the IBMs:

IBM DeskStar
 Timing buffered disk reads:  64 MB in  1.41 seconds = 45.39 MB/sec

And now for the Raptors:
WD Raptor
 Timing buffered disk reads:  64 MB in  1.24 seconds = 51.61 MB/sec

Well, at least it's faster. But the next test is really annoying me. I
did the same hdparm -t on the RAID0 containing the IBMs (/dev/md5) and
the one containing the Raptors (/dev/md6) and got the following
result:

/dev/md5:
 Timing buffered disk reads:  64 MB in  0.71 seconds = 90.14 MB/sec

/dev/md6:
 Timing buffered disk reads:  64 MB in  1.06 seconds = 60.38 MB/sec

For the IBMs, the value is fine, it's nearly double the throughput
than with a single drive. But for the Raptor RAID, it's even less than
for the IBM RAID! It doesn't even come close to doubling the
throughput, which is the fact for the IBM drives.

Another quick test with bonnie++ showed that the Raptor RAID really is
slower then the IBM RAID. Not much, but it is - and that despite the
fact that it should be much faster. The Raptors have a very low avg
read seek time of 4.5ms while the IBMs do have 9.8ms, so I expected at
least the filesystem test with bonnie++ to show some performance
improvement, when doing things like creating and deleting files, but
absolutely no test didn't gave a lower performance for the Raptors.

Any idea of what could be wrong? This really annoys me, because I
purchased the smaller Raptors just because I need something as fast as
possible, due to the extensive data amounts I'm working it (and SCSI
not being an option for my development machine at home).

Thanks in advance,
Julien
