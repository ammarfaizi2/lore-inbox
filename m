Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263699AbTHZMS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 08:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263703AbTHZMS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 08:18:58 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:12928 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S263699AbTHZMS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 08:18:56 -0400
To: linux-kernel@vger.kernel.org
Subject: Strange memory usage reporting
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 26 Aug 2003 14:18:54 +0200
Message-ID: <yw1xad9w1uj5.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was a little surprised to see top tell me this:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND           
10642 mru       11   0 23200  81m 2740 S  0.0 37.0   0:00.07 tcvp              

It didn't make sense that RES > VIRT, so I check /proc/pid/*.  Their
contents are below.  Am I missing something?  Note that they are not
consistent with the 'top' line above, since they were copied at a
different time.  The effect is easily reproducible.  It happens every
time I run my music player with using ALSA.

The memory usage summary by top, also doesn't agree:

Mem:    224140k total,   219236k used,     4904k free,     7184k buffers
Swap:   524280k total,      224k used,   524056k free,   125976k cached

Subtracting the cached memory and some heavy processes doesn't leave
room for another 80 MB.

/proc/pid/stat:
10642 (tcvp) S 926 10642 926 34816 10642 0 68 0 2556 0 4 3 0 0 11 0 0 0 1162589 25665536 18902 4294967295 134512640 134523016 3221216832 3221215328 1074519393 0 0 0 2 3222307553 0 0 17 0 0 0

/proc/pid/statm:
6266 18902 685 4 0 6262 0

/proc/pid/status:
Name:	tcvp
State:	S (sleeping)
Tgid:	10642
Pid:	10642
PPid:	926
TracerPid:	0
Uid:	51770	51770	51770	51770
Gid:	100	100	100	100
FDSize:	256
Groups:	100 102 
VmSize:	   25064 kB
VmLck:	       0 kB
VmRSS:	   75608 kB
VmData:	   22308 kB
VmStk:	      16 kB
VmExe:	      12 kB
VmLib:	    2492 kB
SigPnd:	0000000000000000
ShdPnd:	0000000000000000
SigBlk:	0000000000000000
SigIgn:	8000000000000000
SigCgt:	0000000380000002
CapInh:	0000000000000000
CapPrm:	0000000000000000
CapEff:	0000000000000000



-- 
Måns Rullgård
mru@users.sf.net
