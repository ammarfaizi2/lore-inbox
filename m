Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSLUUY6>; Sat, 21 Dec 2002 15:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSLUUY5>; Sat, 21 Dec 2002 15:24:57 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:28871 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S264631AbSLUUYz>; Sat, 21 Dec 2002 15:24:55 -0500
Message-ID: <20021221203246.16082.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Date: Sun, 22 Dec 2002 04:32:46 +0800
Subject: 2.5.52, load and process in D state
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I booted 2.5.52 with the following parmater:
apm=off mem=32M (not sure about the amount, anyway I can reproduce
the problem for sure with 32M and 40M)

Then I tried the osdb (www.osdb.org) benchmark with
40M of data.

$./bin/osdb-pg --nomulti

the result is that aftwer a few second running top I see the postmaster
process in D state and a lot if iowait.
I tried to understand if with 2.5* my hd is too slow,
but hdparm -t -T gives me better results then 2.4.19.

I _can not_ reproduce this issue with 2.4.19

Following a part of the top -b > foo output, if you need I can post
the entire output.

Is it a known issue ? And, is it a problem or am I just trying
to run the kernel with too few memory?

If you want to replay this email please cc me ;-)

Ciao,
          Paolo
          

 21:59:09  up 6 min,  3 users,  load average: 0.91, 0.57, 0.28
34 processes: 33 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  24.9% user   7.9% system   0.0% nice  63.7% iowait   3.3% idle
Mem:    21216k av,   20700k used,     516k free,       0k shrd,     324k buff
        11748k active,               4388k inactive
Swap:  272120k av,    1848k used,  270272k free                    8960k cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
 1135 postgres  15   0  7228 2924  6252 D    30.9 13.7   0:03   0 postmaster
    6 root      15   0     0    0     0 DW    0.7  0.0   0:00   0 kswapd0
 1136 root      15   0  2016 1028  1888 R     0.3  4.8   0:00   0 top
  930 root      15   0  2020  744  1888 S     0.1  3.5   0:00   0 top
    1 root      15   0  1292  244  1244 S     0.0  1.1   0:06   0 init
    2 root      34  19     0    0     0 SWN   0.0  0.0   0:00   0 ksoftirqd/0
    3 root      15   0     0    0     0 SW    0.0  0.0   0:00   0 events/0
    4 root      15   0     0    0     0 SW    0.0  0.0   0:00   0 pdflush
    5 root      15   0     0    0     0 SW    0.0  0.0   0:00   0 pdflush
    7 root      25   0     0    0     0 SW    0.0  0.0   0:00   0 aio/0
    8 root      25   0     0    0     0 SW    0.0  0.0   0:00   0 kseriod
   10 root      21   0     0    0     0 SW    0.0  0.0   0:00   0 reiserfs/0
  486 root      15   0  1360  368  1280 S     0.0  1.7   0:00   0 syslogd
  494 root      15   0  2120 1024  1232 S     0.0  4.8   0:00   0 klogd
  525 root      15   0  1340  276  1288 S     0.0  1.3   0:00   0 gpm
  596 xfs       15   0  5052 3036  2232 S     0.0 14.3   0:00   0 xfs
  611 daemon    18   0  1316  256  1268 S     0.0  1.2   0:00   0 atd
  625 root      16   0  2076  388  1792 S     0.0  1.8   0:00   0 xinetd
  678 root      15   0  1488  324  1428 S     0.0  1.5   0:00   0 crond
  787 root      15   0  2252  428  1892 S     0.0  2.0   0:00   0 login
  788 root      15   0  2252  412  1892 S     0.0  1.9   0:00   0 login
  789 root      15   0  2252  520  1892 S     0.0  2.4   0:00   0 login
  790 root      15   0  1252  188  1220 S     0.0  0.8   0:00   0 mingetty
  791 root      15   0  1252  188  1220 S     0.0  0.8   0:00   0 mingetty
  792 root      15   0  1252  188  1220 S     0.0  0.8   0:00   0 mingetty
  795 root      15   0  2736  520  2336 S     0.0  2.4   0:00   0 bash
  828 root      16   0  2264  504  1920 S     0.0  2.3   0:00   0 su
  829 postgres  15   0  2704 1160  2336 S     0.0  5.4   0:00   0 bash
  864 root      15   0  2740  724  2336 S     0.0  3.4   0:00   0 bash
  890 root      15   0  2748 1204  2336 S     0.0  5.6   0:00   0 bash
 1092 postgres  15   0  6808 1400  6252 S     0.0  6.5   0:00   0 postmaster
 1094 postgres  15   0  7800 1380  6252 S     0.0  6.5   0:00   0 postmaster
 1095 postgres  15   0  6844 1424  6252 S     0.0  6.7   0:00   0 postmaster
 1104 postgres  15   0  1780  692  1528 S     0.0  3.2   0:00   0 osdb-pg

 21:59:14  up 6 min,  3 users,  load average: 0.91, 0.58, 0.29
34 processes: 31 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:  26.2% user   8.3% system   0.0% nice  57.7% iowait   7.5% idle
Mem:    21216k av,   20576k used,     640k free,       0k shrd,     280k buff
        11044k active,               4992k inactive
Swap:  272120k av,    1848k used,  270272k free                    8932k cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
 1135 postgres  15   0  7228 2928  6252 R    32.8 13.8   0:04   0 postmaster
    6 root      15   0     0    0     0 SW    0.7  0.0   0:00   0 kswapd0
  930 root      16   0  2020  744  1888 S     0.3  3.5   0:00   0 top
    1 root      15   0  1292  244  1244 S     0.0  1.1   0:06   0 init
    2 root      34  19     0    0     0 SWN   0.0  0.0   0:00   0 ksoftirqd/0
    3 root      15   0     0    0     0 RW    0.0  0.0   0:00   0 events/0
    4 root      15   0     0    0     0 SW    0.0  0.0   0:00   0 pdflush
    5 root      15   0     0    0     0 SW    0.0  0.0   0:00   0 pdflush
    7 root      25   0     0    0     0 SW    0.0  0.0   0:00   0 aio/0
    8 root      25   0     0    0     0 SW    0.0  0.0   0:00   0 kseriod
   10 root      21   0     0    0     0 SW    0.0  0.0   0:00   0 reiserfs/0
  486 root      15   0  1360  368  1280 S     0.0  1.7   0:00   0 syslogd
  494 root      15   0  2120 1024  1232 S     0.0  4.8   0:00   0 klogd
  525 root      15   0  1340  276  1288 S     0.0  1.3   0:00   0 gpm
  596 xfs       15   0  5052 3036  2232 S     0.0 14.3   0:00   0 xfs
  611 daemon    18   0  1316  256  1268 S     0.0  1.2   0:00   0 atd
  625 root      16   0  2076  388  1792 S     0.0  1.8   0:00   0 xinetd
  678 root      15   0  1488  324  1428 S     0.0  1.5   0:00   0 crond
  787 root      15   0  2252  428  1892 S     0.0  2.0   0:00   0 login
  788 root      15   0  2252  412  1892 S     0.0  1.9   0:00   0 login
  789 root      15   0  2252  520  1892 S     0.0  2.4   0:00   0 login
  790 root      15   0  1252  188  1220 S     0.0  0.8   0:00   0 mingetty
  791 root      15   0  1252  188  1220 S     0.0  0.8   0:00   0 mingetty
  792 root      15   0  1252  188  1220 S     0.0  0.8   0:00   0 mingetty
  795 root      15   0  2736  520  2336 S     0.0  2.4   0:00   0 bash
  828 root      16   0  2264  504  1920 S     0.0  2.3   0:00   0 su
  829 postgres  15   0  2704 1160  2336 S     0.0  5.4   0:00   0 bash
  864 root      15   0  2740  724  2336 S     0.0  3.4   0:00   0 bash
  890 root      15   0  2748 1204  2336 S     0.0  5.6   0:00   0 bash
 1092 postgres  15   0  6808 1400  6252 S     0.0  6.5   0:00   0 postmaster
 1094 postgres  15   0  7800 1380  6252 S     0.0  6.5   0:00   0 postmaster
 1095 postgres  15   0  6844 1424  6252 S     0.0  6.7   0:00   0 postmaster
 1104 postgres  15   0  1780  692  1528 S     0.0  3.2   0:00   0 osdb-pg
 1136 root      15   0  2016 1028  1888 R     0.0  4.8   0:00   0 top

 21:59:20  up 6 min,  3 users,  load average: 1.00, 0.60, 0.29
34 processes: 31 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:  24.3% user   7.7% system   0.0% nice  63.5% iowait   4.3% idle
Mem:    21216k av,   20592k used,     624k free,       0k shrd,     248k buff
        10484k active,               5552k inactive
Swap:  272120k av,    2216k used,  269904k free                    9088k cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
 1135 postgres  16   0  7228 2620  6252 D    31.0 12.3   0:06   0 postmaster
    6 root      15   0     0    0     0 DW    0.6  0.0   0:00   0 kswapd0
 1136 root      15   0  2016  824  1888 R     0.4  3.8   0:00   0 top
    5 root      15   0     0    0     0 SW    0.1  0.0   0:00   0 pdflush
  930 root      15   0  2020  684  1888 R     0.1  3.2   0:00   0 top
    1 root      15   0  1292  196  1244 S     0.0  0.9   0:06   0 init
    2 root      34  19     0    0     0 SWN   0.0  0.0   0:00   0 ksoftirqd/0
    3 root      15   0     0    0     0 RW    0.0  0.0   0:00   0 events/0
    4 root      15   0     0    0     0 SW    0.0  0.0   0:00   0 pdflush
    7 root      25   0     0    0     0 SW    0.0  0.0   0:00   0 aio/0
    8 root      25   0     0    0     0 SW    0.0  0.0   0:00   0 kseriod
   10 root      21   0     0    0     0 SW    0.0  0.0   0:00   0 reiserfs/0
  486 root      15   0  1360  324  1280 S     0.0  1.5   0:00   0 syslogd
  494 root      15   0  2120 1008  1232 S     0.0  4.7   0:00   0 klogd
  525 root      15   0  1340  260  1288 S     0.0  1.2   0:00   0 gpm
  596 xfs       15   0  5052 3008  2232 S     0.0 14.1   0:00   0 xfs
  611 daemon    18   0  1316  228  1268 S     0.0  1.0   0:00   0 atd
  625 root      16   0  2076  360  1792 S     0.0  1.6   0:00   0 xinetd
  678 root      15   0  1488  284  1428 S     0.0  1.3   0:00   0 crond
  787 root      15   0  2252  396  1892 S     0.0  1.8   0:00   0 login
  788 root      15   0  2252  376  1892 S     0.0  1.7   0:00   0 login
  789 root      15   0  2252  476  1892 S     0.0  2.2   0:00   0 login
  790 root      15   0  1252  168  1220 S     0.0  0.7   0:00   0 mingetty
  791 root      15   0  1252  164  1220 S     0.0  0.7   0:00   0 mingetty
  792 root      15   0  1252  164  1220 S     0.0  0.7   0:00   0 mingetty
  795 root      15   0  2736  476  2336 S     0.0  2.2   0:00   0 bash
  828 root      16   0  2264  472  1920 S     0.0  2.2   0:00   0 su
  829 postgres  15   0  2704  984  2336 S     0.0  4.6   0:00   0 bash
  864 root      15   0  2740  632  2336 S     0.0  2.9   0:00   0 bash
  890 root      15   0  2748  980  2336 S     0.0  4.6   0:00   0 bash
 1092 postgres  15   0  6808 1124  6252 S     0.0  5.2   0:00   0 postmaster
 1094 postgres  15   0  7800 1108  6252 S     0.0  5.2   0:00   0 postmaster
 1095 postgres  15   0  6844 1096  6252 S     0.0  5.1   0:00   0 postmaster
 1104 postgres  15   0  1780  560  1528 S     0.0  2.6   0:00   0 osdb-pg

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
