Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTIECeQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 22:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTIECeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 22:34:16 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:34238 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262028AbTIECeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 22:34:13 -0400
Date: Thu, 4 Sep 2003 22:38:13 -0400
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: 2.6.0-test4-mm5 dbench stuck in D state
Message-ID: <20030905023813.GA29171@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uniprocessor x86 ext2 on IDE system running 2.6.0-test4-mm5
has dbench stuck in uninterruptible sleep.  -mm4 didn't 
have a problem with the same workload.

dbench 32 was hung.  I did pkill -9 dbench.  Some of the dbench
processes exited.  Some did not.  Below is "ps aux".   The hung
"dbench 32" processes have START time of 02:09.  

Apparently the mother of all dbench processes exited, because the
wrapper script moved on to the next iteration of dbench.  

A few hours later I noticed dbench wasn't making progress on 
another iteration of dbench 32.  pkill -9 ... one process with
start time of 07:49 didn't exit.

A few hours later "dbench 64" was stuck.  The disk access light
was out. The load average steady at 16.  In the ps below,
those processes have START time of 21:49.

ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1312  168 ?        S    Sep03   0:04 init [3]
root         2  0.0  0.0     0    0 ?        SWN  Sep03   0:00 [ksoftirqd/0]
root         3  0.0  0.0     0    0 ?        SW<  Sep03   0:01 [events/0]
root         4  0.0  0.0     0    0 ?        SW<  Sep03   0:00 [kblockd/0]
root         7  0.0  0.0     0    0 ?        SW   Sep03   0:28 [kswapd0]
root         8  0.0  0.0     0    0 ?        SW<  Sep03   0:00 [aio/0]
root         9  0.0  0.0     0    0 ?        SW<  Sep03   0:00 [aio_fput/0]
root        10  0.0  0.0     0    0 ?        SW   Sep03   0:00 [jfsIO]
root        11  0.0  0.0     0    0 ?        SW   Sep03   0:00 [jfsCommit]
root        12  0.0  0.0     0    0 ?        SW   Sep03   0:00 [jfsSync]
root        13  0.0  0.0     0    0 ?        SW<  Sep03   0:00 [xfslogd/0]
root        14  0.0  0.0     0    0 ?        SW<  Sep03   0:00 [xfsdatad/0]
root        15  0.0  0.0     0    0 ?        SW   Sep03   0:00 [pagebufd]
root        16  0.0  0.0     0    0 ?        SW   Sep03   0:25 [kjournald]
root       403  0.0  0.0  1368  216 ?        S    Sep03   0:00 syslogd -m 0
root       408  0.0  0.0  1300  280 ?        S    Sep03   0:00 klogd -x
rpc        429  0.0  0.0  1448  104 ?        S    Sep03   0:00 portmap
root       542  0.0  0.0  2568  140 ?        S    Sep03   0:00 /usr/sbin/sshd
root       552  0.0  0.0  1284  116 tty1     S    Sep03   0:00 /sbin/mingetty tt
root       553  0.0  0.2  2208 1028 ?        S    Sep03   0:00 login -- root
root       556  0.0  0.1  3440  400 ?        S    Sep03   0:01 /usr/sbin/sshd
rwhron     557  0.0  0.0  2200  144 pts/0    S    Sep03   0:00 -bash
root       601  0.0  0.0  2000  144 pts/0    S    Sep03   0:00 su -
root       602  0.0  0.0  2400  144 pts/0    S    Sep03   0:00 -bash
root       652  0.0  0.1  2216  544 pts/0    S    Sep03   0:00 /bin/bash ./runte
root     16813  0.0  0.0  3352  160 ?        S    Sep03   0:00 /usr/sbin/sshd
rwhron   16814  0.0  0.0  2200  152 pts/1    S    Sep03   0:00 -bash
root     28785  0.0  0.2  2180 1020 pts/0    S    02:09   0:00 /bin/bash /usr/lo
root     28786  0.0  0.1  1568  544 pts/0    S    02:09   0:00 tee -a /root/2.6.
root     28787  0.0  0.2  2180 1040 pts/0    S    02:09   0:00 /bin/bash ./dbrun
root     28790  0.0  0.1  1568  544 pts/0    S    02:09   0:00 tee -a /root/2.6.
root     28797  0.0  0.1  1496  580 pts/0    S    02:09   0:13 ping localhost
root     28816  0.0  0.1  1372  512 pts/0    D    02:09   0:09 ./dbench 32
root     28821  0.0  0.1  1372  512 pts/0    D    02:09   0:03 ./dbench 32
root     28827  0.0  0.1  1372  512 pts/0    D    02:09   0:10 ./dbench 32
root     28831  0.0  0.1  1372  512 pts/0    D    02:09   0:10 ./dbench 32
root     28836  0.0  0.1  1372  512 pts/0    D    02:09   0:10 ./dbench 32
root     28842  0.0  0.1  1372  512 pts/0    D    02:09   0:10 ./dbench 32
root     28889  0.0  0.3  2408 1304 ttyS1    S    07:38   0:27 -bash
root     29133  0.0  0.1  1372  512 pts/0    D    07:49   0:09 ./dbench 32
root     29278  0.0  0.0     0    0 ?        SW   21:48   0:02 [pdflush]
root     29284  0.0  0.1  1364  424 pts/0    S    21:49   0:00 ./dbench 64
root     29290  0.4  0.1  1372  512 pts/0    D    21:49   0:09 ./dbench 64
root     29300  0.3  0.1  1372  512 pts/0    D    21:49   0:08 ./dbench 64
root     29304  0.3  0.1  1372  512 pts/0    D    21:49   0:08 ./dbench 64
root     29308  0.4  0.1  1372  512 pts/0    D    21:49   0:09 ./dbench 64
root     29311  0.4  0.1  1372  512 pts/0    D    21:49   0:09 ./dbench 64
root     29322  0.4  0.1  1372  512 pts/0    D    21:49   0:09 ./dbench 64
root     29324  0.4  0.1  1372  512 pts/0    D    21:49   0:09 ./dbench 64
root     29337  0.3  0.1  1372  512 pts/0    D    21:49   0:08 ./dbench 64
root     29345  0.3  0.1  1372  512 pts/0    D    21:49   0:08 ./dbench 64
root     29422  0.1  0.0     0    0 ?        SW   21:52   0:02 [pdflush]
root     29433  0.0  0.1  2556  680 ttyS1    R    22:26   0:00 ps aux


The behavior is not perfectly repeatable.  :(   To recap, the
sequence of events was like this:

dbench 32    # pkill -9 dbench
dbench 32    # exited normally
dbench 32    # pkill -9 dbench
dbench 32    # pkill -9 dbench
dbench 32    # appeared to exit normally
dbench 64    # some processes don't exit

There is a <sysrq T> trace at:
http://home.earthlink.net/~rwhron/2.6.0-test4-mm5.trace

Is there something else that would help track this down?
2.6.0-test4-mm4 did not exhibit this behavior.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

