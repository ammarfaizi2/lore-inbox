Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSGUM1B>; Sun, 21 Jul 2002 08:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSGUM1B>; Sun, 21 Jul 2002 08:27:01 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:48061 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314446AbSGUM1A>; Sun, 21 Jul 2002 08:27:00 -0400
Date: Sun, 21 Jul 2002 14:29:32 +0200
From: axel@hh59.org
To: linux-kernel@vger.kernel.org
Subject: 2.5.27: Software Suspend failure / JFS errors
Message-ID: <20020721122932.GA23552@neon.hh59.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I invoked software suspend with kernel 2.5.27 and get the following messages
from kernel:

Stopping tasks: ========================
 stopping tasks failed (3 tasks remaining)
Suspend failed: Not all processes stopped!
Restarting tasks...<6> Strange, jfsIO not stopped
 Strange, jfsCommit not stopped
 Strange, jfsSync not stopped
 done

Afterwards, I have full cpu utilization of the JFS kernel threads:

CPU states:   1.0% user,  99.0% system,   0.0% nice,   0.0% idle
Mem:    126284K total,    97112K used,    29172K free,        0K buffers
Swap:   289160K total,        0K used,   289160K free,    53224K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      25   0     0    0     0 RW   36.6  0.0   3:56 jfsIO
    8 root      25   0     0    0     0 RW   30.6  0.0   3:56 jfsCommit
    9 root      25   0     0    0     0 RW   29.6  0.0   3:56 jfsSync
  361 root      15   0   972  972   768 R     0.9  0.7   0:00 top
  235 axel      15   0  3064 3064  1928 R     0.0  2.4   0:00 sawfish
  244 axel      15   0  5004 5004  3724 R     0.0  3.9   0:00 panel
  248 axel      15   0  4508 4508  3324 R     0.0  3.5   0:03 gkrellm

And constant activity of VM:

   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0  0  3      0  29284      0  53224   0   0    61     6 1051   106   2  89
10
 0  0  2      0  29284      0  53224   0   0     0     0 1006    94   0 100
0
 0  0  2      0  29284      0  53224   0   0     0     0 1006    75   1  99
0
 0  0  2      0  29284      0  53224   0   0     0     0 1006    79   1  99
0
 0  0  2      0  29284      0  53224   0   0     0     0 1006    88   1  99
0

I used to have problems with JFS anyway when unpacking big tar archives. The
the system gives an oops and locks up a short while after. The process it is
stuck in is JFSCommit.
I tried latest 2.4 and 2.5, always had the same problems. Strangely JFS
causes no problems at all when I uses the kernel my partitions were
formatted with. That is slackware kernel 2.4.18, jfs 1.0.18. Any kernel
later with jfs versions higher causes these JFSCommit freezes.

I will send an oops report of JFS later.

Regards,
Axel Siebenwirth
