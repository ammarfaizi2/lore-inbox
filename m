Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTAJGc3>; Fri, 10 Jan 2003 01:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbTAJGc3>; Fri, 10 Jan 2003 01:32:29 -0500
Received: from [209.39.166.171] ([209.39.166.171]:47369 "EHLO mail.roland.net")
	by vger.kernel.org with ESMTP id <S263039AbTAJGc1>;
	Fri, 10 Jan 2003 01:32:27 -0500
Message-ID: <004d01c2b873$44156d80$2002a8c0@jimws>
From: "Jim Roland" <jroland@roland.net>
To: <linux-kernel@vger.kernel.org>
Subject: ksoftirqd_CPU0 causing severe latency
Date: Fri, 10 Jan 2003 00:41:11 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running a RH7.2 router with kernel 2.4.18-19.7.x and upgraded from 
2.4.18-17 in hopes this would fix the problem, but it hasn't.

The problem I am experiencing is that after a while, the system begins to 
lag badly, and running "ps -ax" writes to a SSH console like a terminal 
running at 14.4kbps.  This only seems to have occurred after the box 
started procesing a network load.

The box is a router, with a Supermicro (model=?) motherboard with embedded 
Intel EEpro/100 NICs using the eepro100 module.  This box is also serving 
as an iptables filter for the network as well.  It's processing 
approximately 60Mbps sustained traffic outbound, and about 10-15Mbps 
traffic inbound.

The box also lags SEVERLY when I'm trying to use the state matching in the 
kernel (as module), lagging badly when ip_conntrack is loaded.


In contrast, I am running the same OS and kernel versions on another box 
(same modules) and am not having the same problem (it is only handling 
about 5Mbps sustained out, and 1Mbps sustained inbound).

I need HELP!


Here are the specs on the troubled system:
Intel P3-1.0GHz, 512MB RAM, 2x Intel EEPro/100 (eepro100 module)
Dual CPU board, w/o 2nd CPU, running non-smp kernel (uniprocessor kernel).

Module List (system runnin at its best):
Module                  Size  Used by    Not tainted
cls_route               5056   0  (unused)
cls_u32                 5764   1
cls_fw                  3264   0  (unused)
sch_prio                3552   0  (unused)
sch_sfq                 4512   0  (unused)
sch_tbf                 3264   2
sch_cbq                14080   1
autofs                 11172   0  (autoclean) (unused)
eepro100               20240   2
ipt_REJECT              3744  22  (autoclean)
iptable_filter          2464   1  (autoclean)
ip_tables              13696   2  [ipt_REJECT iptable_filter]
ext3                   64768   5
jbd                    47892   5  [ext3]

  PID TTY      STAT   TIME COMMAND
    1 ?        S      1:43 init [3]
    2 ?        SW     0:00 [keventd]
    3 ?        SW     2:17 [kapmd]
    4 ?        RWN  506:27 [ksoftirqd_CPU0]
    5 ?        SW     1:34 [kswapd]
    6 ?        SW     0:00 [bdflush]
    7 ?        SW     0:31 [kupdated]
    8 ?        SW     0:00 [mdrecoveryd]
   12 ?        SW     0:56 [kjournald]
  134 ?        SW     0:00 [kjournald]
  135 ?        SW     0:00 [kjournald]
  136 ?        SW     0:47 [kjournald]
  137 ?        SW     0:27 [kjournald]
  598 ?        S      0:21 syslogd -m 0
  603 ?        S      0:01 klogd -2
  641 ?        SL     7:34 ntpd -U ntp
  695 ?        S      0:49 /usr/sbin/snmpd -s -l /dev/null -P 
/var/run/snmpd -a
  713 ?        S      0:07 /usr/sbin/sshd
  746 ?        S      0:00 xinetd -stayalive -reuse -pidfile 
/var/run/xinetd.pid

  787 ?        S      0:15 crond
  823 ?        S      0:00 /usr/sbin/atd
  829 ?        S      0:00 /etc/bkupexec/agent.be -c 
/etc/bkupexec/agent.cfg
  843 ?        SN     2:01 /etc/bkupexec/agent.be -c 
/etc/bkupexec/agent.cfg
  850 ?        S      0:16 rhnsd --interval 120
  891 ?        S      2:24 /usr/bin/perl /usr/libexec/webmin/miniserv.pl 
/etc/we

  895 tty1     S      0:00 /sbin/mingetty tty1
  896 tty2     S      0:00 /sbin/mingetty tty2
  897 tty3     S      0:00 /sbin/mingetty tty3
  898 tty4     S      0:00 /sbin/mingetty tty4
  899 tty5     S      0:00 /sbin/mingetty tty5
  900 tty6     S      0:00 /sbin/mingetty tty6
 5409 ?        S      1:42 /usr/sbin/sshd
 5410 pts/0    S      0:22 -bash
 5552 ?        S      0:11 /usr/sbin/httpd -DHAVE_ACCESS -DHAVE_PROXY 
-DHAVE_AUT

 5558 ?        S      0:00 /usr/sbin/httpd -DHAVE_ACCESS -DHAVE_PROXY 
-DHAVE_AUT

 5559 ?        S      0:00 /usr/sbin/httpd -DHAVE_ACCESS -DHAVE_PROXY 
-DHAVE_AUT

 5560 ?        S      0:00 /usr/sbin/httpd -DHAVE_ACCESS -DHAVE_PROXY 
-DHAVE_AUT

 5561 ?        S      0:00 /usr/sbin/httpd -DHAVE_ACCESS -DHAVE_PROXY 
-DHAVE_AUT

 5562 ?        S      0:00 /usr/sbin/httpd -DHAVE_ACCESS -DHAVE_PROXY 
-DHAVE_AUT

 5563 ?        S      0:00 /usr/sbin/httpd -DHAVE_ACCESS -DHAVE_PROXY 
-DHAVE_AUT

 5564 ?        S      0:00 /usr/sbin/httpd -DHAVE_ACCESS -DHAVE_PROXY 
-DHAVE_AUT

 5565 ?        S      0:00 /usr/sbin/httpd -DHAVE_ACCESS -DHAVE_PROXY 
-DHAVE_AUT

 5653 pts/0    R      0:01 ps -ax


  4:23pm  up 1 day, 22:33,  1 user,  load average: 0.66, 0.73, 0.81
43 processes: 41 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:  1.3% user,  1.3% system,  0.0% nice, 20.4% idle
Mem:   513032K av,  183252K used,  329780K free,       0K shrd,  105560K 
buff
Swap:  257000K av,       0K used,  257000K free                   47172K 
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 5655 root      19   0  1028 1024   824 R    33.6  0.1   0:01 top
    4 root      35  19     0    0     0 RWN  18.8  0.0 506:40 
ksoftirqd_CPU0
  641 ntp       15   0  1932 1932  1732 S     0.6  0.3   7:35 ntpd
    1 root      15   0   508  508   440 S     0.0  0.0   1:43 init
    2 root      15   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root      15   0     0    0     0 SW    0.0  0.0   2:17 kapmd
    5 root      15   0     0    0     0 SW    0.0  0.0   1:34 kswapd
    6 root      25   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    7 root      15   0     0    0     0 SW    0.0  0.0   0:31 kupdated
    8 root      25   0     0    0     0 SW    0.0  0.0   0:00 mdrecoveryd
   12 root      15   0     0    0     0 SW    0.0  0.0   0:56 kjournald
  134 root      15   0     0    0     0 SW    0.0  0.0   0:00 kjournald
  135 root      15   0     0    0     0 SW    0.0  0.0   0:00 kjournald
  136 root      15   0     0    0     0 SW    0.0  0.0   0:47 kjournald
  137 root      16   0     0    0     0 SW    0.0  0.0   0:27 kjournald
  598 root      15   0   612  612   516 S     0.0  0.1   0:21 syslogd
  603 root      15   0  1208 1208   448 S     0.0  0.2   0:01 klogd
  695 root      16   0  2940 2940  1844 S     0.0  0.5   0:49 snmpd
