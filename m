Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265327AbUAZXGC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbUAZXGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:06:02 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:25258 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S265327AbUAZXF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:05:58 -0500
To: linux-kernel@vger.kernel.org
Subject: Strange xmms deaths under high disk load
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 27 Jan 2004 00:05:55 +0100
Message-ID: <yw1xu12i1fak.fsf@ford.guide>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have encountered a very strange (to me, at least) error.  I can
reliably cause xmms to crash by simply doing some intensive disk IO.
Copying a few hundred megabytes usually does it.  After about 20
seconds of heavy disk IO, xmms will die with this message:

** WARNING **: snd_pcm_wait: Input/output error
Xlib: unexpected async reply (sequence 0x2ef5c)!

The hex number varies.

The machine is an Alpha SX164 running Linux 2.6.2-rc2 patched up to
ALSA 1.0.1.  The problem has been around for quite a while, probably
also with kernel 2.4.21, though I can't confirm that at the moment.
The sound card is a cmi8738.

If I play music with TCVP instead, it keeps playing, but sound is
choppy at intervals.  Below is vmstat output during a copying.

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0  86128   3424 165920    0    0    66    66   24     4 23 23 54  0
 0  0      0  86128   3424 165920    0    0     0     0 1131  1352 17 14 69  0
 0  0      0  86128   3424 165920    0    0     0     0 1128  1360 13  4 84  0
 0  0      0  86128   3424 165920    0    0     0     0 1129  1351 13  4 84  0
 0  0      0  86128   3424 165920    0    0     0   153 1142  1361 14  3 83  0
 0  0      0  86128   3424 165920    0    0     0     0 1127  1353 14  4 83  0
 0  0      0  86128   3424 165920    0    0     0     0 1128  1348 12  3 84  0
 0  0      0  86128   3424 165920    0    0     0     0 1130  1344 17 15 69  0
 0  0      0  86000   3424 166048    0    0   128     0 1132  1356 13  3 84  0
 1  1      0  71648   3472 179992    0    0  7064    81 1255  1540 16 26 44 14
 2  0      0  34912   3480 216296    0    0 18081    88 1409  1792 20 61  1 18
 1  0      0   2016   3464 248720    0    0 19420     0 1423  1795 20 65  0 15
14  1      0   2400   3392 246544    0    0 11632 24929 1596  1489 16 60  1 23
11  2      0   2400   3392 246368    0    0   768 26112  969   626 25 71  0  3
 3  0      0   1952   3392 248552    0    0 10112  6310 1250  1396 29 51  0 20
 1  0      0   1568   3376 248760    0    0 18328     4 1409  1794 20 63  0 17
 1  0      0   2336   1696 249464    0    0 19576     0 1417  1858 20 68  0 11
 7  1      0   2400   1704 248160    0    0  8904 22984 1230   955 16 70  1 13
11  0      0   3040   1704 248160    0    0     0 33704  696    58 10 90  0  0
 1  1      0   2016   1704 249840    0    0 13980    88 1345  1710 29 60  0 10
 0  1      0   2016   1696 250056    0    0 17920     0 1479  1903 22 65  0 13
 1  0      0   2016   1712 250616    0    0 17968     0 1605  2085 27 66  0  7
16  0      0   2016   1736 249352    0    0  3224 53457 1284   379 11 86  0  4
 4  0      0   2208   1736 250448    0    0  9736    88 1558  1793 41 45  2 12
 1  1      0   2272   1728 250368    0    0 10200   105 1406  1691 46 42  0 12
 4  1      0   2272   1728 250544    0    0 11024     0 1362  1790 53 40  0  8
 2  0      0   2336   1720 250480    0    0 16760    33 1488  1916 26 62  0 12
19  0      0   2976   1720 248904    0    0  5644 53328 1537   682 12 81  0  6
 2  0      0   1760   1744 251080    0    0 12216    73 1365  1700 31 57  0 12
 1  0      0   1568   1736 251400    0    0 18520    72 1410  1809 21 66  0 13
 0  1      0   1568   1736 251368    0    0 17316    20 1405  1759 20 61  0 19
13  0      0   1888   1736 250632    0    0  5352 32205 1090   625 11 74  0 15
 1  1      0   2528   1736 250608    0    0  1756 21332  965   590 35 56  0  8
 4  0      0   1760   1696 251352    0    0 20040     0 1428  1825 21 69  0 10
 1  1      0   1504   1696 251824    0    0 15164    16 1366  1742 24 65  0 11
 6  1      0   2400   1696 249424    0    0 16460 27005 2106  1992 19 68  0 13

Whenever there was a high value for "bo" the sound was really choppy.

I don't mind an occasional glitch in the sound too much, but the fact
that xmms died makes me a little nervous.  What's worse, yesterday it
even corrupted the playlist file on disk rather badly.

The filesystems are XFS on device-mapper on raid1 over raid0 on four
disks connected to a hpt374 controller.

Should I just call it an xmms bug, or should I start digging for
hardware problems or kernel bugs?

-- 
Måns Rullgård
mru@kth.se
