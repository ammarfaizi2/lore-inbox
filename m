Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135426AbRDMGxH>; Fri, 13 Apr 2001 02:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135427AbRDMGw6>; Fri, 13 Apr 2001 02:52:58 -0400
Received: from adsl-213-254-163-44.mistral-uk.net ([213.254.163.44]:45577 "EHLO
	crucigera.fysh.org") by vger.kernel.org with ESMTP
	id <S135426AbRDMGwq>; Fri, 13 Apr 2001 02:52:46 -0400
Date: Fri, 13 Apr 2001 07:52:44 +0100
From: Athanasius <Athanasius@miggy.org>
To: linux-kernel@vger.kernel.org
Subject: Process (mozilla) in 'D' state (down_w)
Message-ID: <20010413075244.A733@miggy.org>
Mail-Followup-To: Athanasius <Athanasius@miggy.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Seems like anytime I first startup mozilla I end up with something
like:

ps afx | grep mozilla
  680 ttyp6    S      0:00              |       \_ grep mozilla
  660 tty1     S      0:00              \_ /bin/sh /other2/mozilla/run-mozilla.sh
  664 tty1     S      0:01                  \_ ./mozilla-bin
  665 tty1     S      0:00                      \_ ./mozilla-bin
  666 tty1     S      0:00                          \_ ./mozilla-bin
  667 tty1     S      0:00                          \_ ./mozilla-bin
  670 tty1     D      0:00                          \_ ./mozilla-bin
athan@emelia:~; ps l 670
  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
040   513   670   665   9   0 19500 12028 down_w D   tty1       0:00 ./mozilla-b

And I can't get that D-state process to budge or die in any way.  I end
up with an fsck of the device the binary is on next reboot due to
unclean umount.  Attaching strace or gdb never works, just hangs, so
about the only useful info I can give (nothing in dmesg or kern.log):

athan@emelia:~; cd /proc/670
athan@emelia:/proc/670; cat stat
670 (mozilla-bin) D 665 499 459 1025 459 64 0 0 0 0 0 0 0 0 9 0 0 0 32526 19968000 3007 4294967295 134512640 134550420 3221223560 3204446832 1076277629 0 0 4096 0 3222297777 0 0 33 0
athan@emelia:/proc/670; cat statm
3007 3007 2143 11 0 2996 864
athan@emelia:/proc/670; cat status
Name:   mozilla-bin
State:  D (disk sleep)
Pid:    670
PPid:   665
TracerPid:      0
Uid:    513     513     513     513
Gid:    1000    1000    1000    1000
FDSize: 32
Groups: 1000 5 6 7 20 21 22 24 25 26 29 30 34 39 40 41 60 100 1001 1003 
VmSize:    19500 kB
VmLck:         0 kB
VmRSS:     12028 kB
VmData:     3424 kB
VmStk:        64 kB
VmExe:        40 kB
VmLib:     14420 kB
SigPnd: 0000000000000000
SigBlk: 0000000080000000
SigIgn: 8000000000001000
SigCgt: 0000000380000000
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000

   I'll sometime if I can remember to run mozilla with a strace -f -ff
-o file to see if it gives any more useful info.  I'll be updating to
2.4.3-ac5 in the next hour or so anyway (currently on plain vanilla
2.4.3).
   If anyone has any other ideas/suggestions/pointers to info about how
to get more information as to what the process is 'doing' and how it got
there I'd be grateful.

-Ath
-- 
- Athanasius = Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
