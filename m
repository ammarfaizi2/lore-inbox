Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129118AbQKAPAx>; Wed, 1 Nov 2000 10:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130119AbQKAPAn>; Wed, 1 Nov 2000 10:00:43 -0500
Received: from c90610-a.alton1.il.home.com ([24.11.42.157]:9233 "EHLO
	www.linuxnet") by vger.kernel.org with ESMTP id <S129118AbQKAPAc>;
	Wed, 1 Nov 2000 10:00:32 -0500
Date: Wed, 1 Nov 2000 09:00:29 -0600 (CST)
From: matthew <matthew@mattshouse.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test10 Sluggish After Load
Message-ID: <Pine.LNX.4.21.0011010845210.6574-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm evaluating my company's needs for a new database server which means
that I get to beat the hell out of the contenders.  I'm a long time Linux
user, and the founder of the Orasoft Project (Oracle Apps for
Linux).  There, I'm no Linux spring chicken. :-)

I wrote stress testing apps that simulates extreme database load.  I ran
it against 2.4.0-test9 and locked it up solid on two occasions.  I grabbed
2.0.4-test10 and reran.

I was impressed.  The distributed stress tester (DDOS) created 1800 Oracle
connections, and then proceeded to bang on the server by selecting random
connections and executing SELECT statements.

Load average got to 5.48.
Memory was depleted, and 200M remained of the 800M swap.

After being pleased by the results, I killed the stress tester.  That's
when things went to hell.  After the stresser was dead the server's load
average spiked to 795!  I still had a remote console open so I tried to
run some things.  The pstools would hang for about 20 minutes before
spitting out data.  Just hitting ENTER in my ssh session would take 10
minutes to register with the server.

The machine shouldn't be under any kind of load right now, yet it's acting
as though it's getting killed.

I've left it in this condition.  It's still accepting SSH connections,
albeit very slowly.  If anyone want to take a look I'll create an account
and allow SSH.  I'd prefer it to be someone that I know, or someone with
an @redhat||suse||etc e-mail address.

Here's the hardware:
2x 500mhz PIII
256M RAM
100% SCSI
HP Kayak
Kernel 2.4.0-test10

Here's some stats just before I killed the stress tester:

[root@oserv02 /root]# pstree 
init-+-atd
     |-crond
     |-gpm
     |-kflushd
     |-klogd
     |-kreclaimd
     |-kswapd
     |-kupdate
     |-6*[mingetty]
     |-1803*[oracle]
     |-portmap
     |-sendmail
     |-sshd---sshd---bash---pstree
     |-syslogd
     |-tnslsnr
     |-wu.ftpd
     `-xfs

[root@oserv02 /root]# w
  9:40pm  up 26 min,  1 user,  load average: 4.40, 5.48, 4.10
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU  WHAT
root     pts/1    matthome.godfrey  9:29pm  1:38   5.94s  4.57s  w


[root@oserv02 /root]# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  261881856 259772416  2109440        0   212992 24477696
Swap: 814178304 524578816 289599488
MemTotal:       255744 kB
MemFree:          2060 kB
MemShared:           0 kB
Buffers:           208 kB
Cached:          23904 kB
Active:          15268 kB
Inact_dirty:       180 kB
Inact_clean:      8664 kB
Inact_target:    12036 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255744 kB
LowFree:          2060 kB
SwapTotal:      795096 kB
SwapFree:       282812 kB

I'm not on the list, so direct your reply to matthew@mattshouse.com.

Matthew


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
