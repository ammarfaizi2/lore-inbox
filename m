Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267105AbSKMCMu>; Tue, 12 Nov 2002 21:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbSKMCMu>; Tue, 12 Nov 2002 21:12:50 -0500
Received: from twinlark.arctic.org ([208.44.199.239]:1481 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S267105AbSKMCMq>; Tue, 12 Nov 2002 21:12:46 -0500
Date: Tue, 12 Nov 2002 18:19:37 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
Subject: repeatable IDE errors when using SMART
Message-ID: <Pine.LNX.4.44.0211121800320.20949-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm 99.99% certain that the use of smartctl and/or hddtemp is causing my
system to lose contact with the drives.  there's just been far too many
concidental errors of this sort:

hdi: status timeout: status=0xd0 { Busy }
hdi: drive not ready for command
hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdi: drive not ready for command

at the exact time i've got cron jobs running to do either "smartctl -a" or
"hddtemp", or at a time when i run the command by hand.

at some times the error state is bad enough to cause md to mark the disk
as bad.

at one point i started running hddtemp every 5 minutes for logging
purposes and it took less than 2 days for the system to lose contact with
one of the disks... and this repeated after i rebooted.

system is:

- linux 2.4.19-pre7-ac4
- tyan 2462, dual athlon 1.4GHz (onboard IDE is unused)
- promise ultra 100TX2
- promise ultra 133TX2
- 4x maxtor D740X 80GB (each master on one of the promise channels)
  (3x 6L080J4, and 1x 6L080L4)

i've replaced drives (always D740X though), cables, and controllers
(swapping a 100TX2 for the 133TX2 which is in there now).

the problem has appeared on all the IDE ports, so it's not restricted to
any one port/drive.  however hdi seems to be particularly sensitive --
even after several controller, disk, and cable combinations.  the 4 disks
are in a sw raid5 which is well balanced according to iostat -- except
that hdi is the hottest disk in the box (41C vs 35C 28C 32C).

any suggestions?

obviously i could move to a more recent kernel ... but i stayed back on
pre7-ac4 because it seemed later kernels messed up the promise driver in
some way and i never quite paid attention enough to know what a good
stable 2.4.x ac kernel was post pre7-ac4.  suggestions welcome.

any known errata regarding SMART accesses interfering with other
operations?

-dean

