Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288083AbSBNKrO>; Thu, 14 Feb 2002 05:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289653AbSBNKrD>; Thu, 14 Feb 2002 05:47:03 -0500
Received: from linux.kappa.ro ([194.102.255.131]:50376 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S288083AbSBNKqz>;
	Thu, 14 Feb 2002 05:46:55 -0500
Date: Thu, 14 Feb 2002 12:48:39 +0200 (EET)
From: Teodor Iacob <theo@astral.kappa.ro>
X-X-Sender: <theo@linux.kappa.ro>
Reply-To: <Teodor.Iacob@astral.kappa.ro>
To: <linux-kernel@vger.kernel.org>
Subject: weird system load (2.4.18-pre3)
Message-ID: <Pine.LNX.4.31.0202141244060.7065-100000@linux.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a linux router running 2.4.18-pre3 kernel and I've got the
following problem with it:

It doesn't have free cpu, more than 75% of the resources go to system:

   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
 3  0  2   5544  16088 165440 265572   0   0     1    62   62    24  14
44  41
 3  0  2   5544  15724 165440 265640   0   0     0     0 5385  5998  22
78   0
 2  0  2   5544  15916 165440 265624   0   0     0     0 4646  4763  22
78   0
 3  0  2   5544  15356 165440 265648   0   0     0     0 3876  3553  19
81   0
 3  0  2   5544  15660 165460 265672   0   0     0   492 4571  4200  20
80   0
 2  0  2   5544  16000 165460 265684   0   0     0     0 5635  5605  19
81   0
 2  0  1   5544  15624 165460 265752   0   0     0     0 6341  5389  21
79   0
 4  0  2   5544  15220 165468 265744   0   0     0   200 5137  5024  25
75   0
 3  0  2   5544  15520 165468 265808   0   0     0     0 5569  5161  20
79   1
 2  0  2   5544  15240 165480 265788   0   0     0   360 5778  4334  20
80   0
 3  0  1   5544  15456 165480 265832   0   0     0     0 6113  5114  19
81   0
 3  0  2   5544  15100 165480 265848   0   0     0     0 6103  4913  19
81   0
 3  0  2   5544  15444 165480 265884   0   0     0   152 5910  5601  19
80   0
 3  0  2   5544  15648 165480 265900   0   0     0     0 4448  4256  20
80   0
 2  0  2   5544  15372 165480 265972   0   0     0   448 4721  4975  20
80   0
 3  0  2   5544  15340 165480 265968   0   0     0   112 5509  5347  23
77   0
 3  0  2   5544  15020 165480 265988   0   0     0     0 5691  4933  20
80   0
 3  0  2   5544  15312 165480 266020   0   0     0     0 6026  4480  18
82   0
 2  0  2   5544  14996 165480 266028   0   0     0     0 5717  5560  22
78   0
 3  0  2   5544  15260 165484 266056   0   0     0   560 6052  5510  21
78   0
 3  0  2   5544  14904 165484 266076   0   0     0     0 6148  5641  17
83   0
 3  0  2   5544  15308 165484 266104   0   0     0     0 5702  5024  21
79   0
 3  0  2   5544  15560 165484 266120   0   0     0   188 5892  4814  24
76   0

Here is a process listing:

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1428  488 ?        S    Feb10   0:20 init [3]
root         2  0.0  0.0     0    0 ?        SW   Feb10   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        RWN  Feb10   2:44
[ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        RWN  Feb10   2:48
[ksoftirqd_CPU1]
root         5  0.0  0.0     0    0 ?        SW   Feb10   0:07 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   Feb10   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        SW   Feb10   0:26 [kupdated]
root         8  0.0  0.0     0    0 ?        SW   Feb10   0:00 [scsi_eh_0]
root         9  0.0  0.0     0    0 ?        SW   Feb10   0:36 [kjournald]
root        95  0.0  0.0     0    0 ?        SW   Feb10   0:23 [kjournald]
root        96  0.0  0.0     0    0 ?        SW   Feb10   1:29 [kjournald]
root       372  0.0  0.1  2208  832 ?        S    Feb10   0:01
/usr/local/sbin/zebra -dk
root       376  0.0  0.2  3276 1464 ?        S    Feb10   0:21
/usr/local/sbin/bgpd -d
root       420  0.0  0.1  1504  660 ?        S    Feb10   0:12 syslogd -m
0 -r
root       430  0.0  0.0  1484  508 ?        S    Feb10   0:00 klogd
nobody     456  0.0  0.1  7724  712 ?        S    Feb10   0:00 identd -e
-o
nobody     458  0.0  0.1  7724  712 ?        S    Feb10   0:10 identd -e
-o
nobody     459  0.0  0.1  7724  712 ?        S    Feb10   0:56 identd -e
-o
nobody     460  0.0  0.1  7724  712 ?        S    Feb10   0:56 identd -e
-o
nobody     461  0.0  0.1  7724  712 ?        S    Feb10   0:00 identd -e
-o
root       470  0.0  0.1  2796  776 ?        S    Feb10   0:10
/usr/sbin/sshd
root       492  0.0  0.1  2324  892 ?        S    Feb10   0:00 xinetd
-reuse -pidfile /var/run/xinetd.pid
root       637  0.0  0.6  8772 3144 ?        S    Feb10   0:23
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
root       652  0.0  0.1  1660  716 ?        S    Feb10   0:03 crond
apache     653  0.0  0.7  8920 3636 ?        S    Feb10   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
apache     654  0.0  0.6  8920 3524 ?        S    Feb10   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
apache     655  0.0  0.7  8948 3636 ?        S    Feb10   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
apache     656  0.0  0.7  8924 3608 ?        S    Feb10   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
apache     657  0.0  0.6  8920 3520 ?        S    Feb10   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
apache     658  0.0  0.7  8920 3636 ?        S    Feb10   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
apache     659  0.0  0.6  8920 3596 ?        S    Feb10   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
apache     660  0.0  0.7  8920 3604 ?        S    Feb10   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
root      1325  0.0  0.1 16912  620 ?        S    Feb10   0:30
/usr/sbin/snmpd -f
root      6451  0.0  0.0  1400  372 tty1     S    Feb10   0:00
/sbin/mingetty tty1
root      6452  0.0  0.0  1400  372 tty2     S    Feb10   0:00
/sbin/mingetty tty2
root      6453  0.0  0.0  1400  372 tty3     S    Feb10   0:00
/sbin/mingetty tty3
root      6454  0.0  0.0  1400  372 tty4     S    Feb10   0:00
/sbin/mingetty tty4
root      6455  0.0  0.0  1400  372 tty5     S    Feb10   0:00
/sbin/mingetty tty5
root      6456  0.0  0.0  1400  372 tty6     S    Feb10   0:00
/sbin/mingetty tty6
apache   26828  0.0  0.7  8924 3680 ?        S    Feb11   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
apache   13247  0.0  0.7  8924 3632 ?        S    Feb12   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
apache   13248  0.0  0.7  8964 3728 ?        S    Feb12   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVEapache
13249  0.0  0.7  8912 3620 ?        S    Feb12   0:00 /usr/sbin/httpd -D
HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
apache   15815  0.0  0.7  8912 3620 ?        S    Feb12   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
apache   11408  0.0  0.7  8912 3628 ?        S    Feb12   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
apache   11910  0.0  0.7  8960 3724 ?        S    Feb12   0:00
/usr/sbin/httpd -D HAVE_PERL -D HAVE_PHP4 -D HAVE_PROXY -D HAVE
root      9437  0.1  0.2  3008 1496 ?        R    11:40   0:05
/usr/sbin/sshd
root      9465  0.0  0.3  2932 1760 pts/6    S    11:40   0:00 -bash
root     16104  0.0  0.2  2968 1396 ?        S    11:52   0:01
/usr/sbin/sshd
root     16111  0.0  0.2  2556 1364 pts/7    S    11:52   0:00 -bash
root     16158  0.0  0.2  2968 1396 ?        S    11:52   0:00
/usr/sbin/sshd
root     16159  0.0  0.2  2556 1364 pts/8    S    11:52   0:00 -bash
root     16186  0.1  0.3  3332 1840 pts/7    S    11:52   0:03 /usr/bin/mc
-P
root     16188  0.0  0.2  2624 1432 pts/9    S    11:52   0:00 bash
-rcfile .bashrc
root     19926  0.0  0.3  3144 1668 pts/8    S    12:01   0:01 /usr/bin/mc
-P
root     19928  0.0  0.2  2616 1412 pts/0    S    12:01   0:00 bash
-rcfile .bashrc
root     29668  0.0  0.2  2880 1380 ?        S    12:19   0:00
/usr/sbin/sshd
root     29669  0.0  0.2  2552 1360 pts/5    S    12:19   0:00 -bash
root      2056  0.0  0.1  1660  776 ?        S    12:30   0:00 CROND
root      2057  0.0  0.1  2036  976 ?        SN   12:30   0:00 /bin/sh
/root/cbq/bin/collect
root      4297  0.9  0.9  6048 4856 ?        SN   12:32   0:04
/usr/bin/perl /usr/local/mrtg/bin/mrtg /root/cbq/etc/mrtg-shape
root      7174  0.0  0.1  1660  776 ?        S    12:40   0:00 CROND
root      7175  0.1  0.1  2036  964 ?        SN   12:40   0:00 /bin/sh
/root/cbq/bin/collect
root      7178  0.5  0.1  1720  604 ?        SN   12:40   0:00 tc -s class
show dev eth0
root      7179  0.0  0.0  1500  512 ?        SN   12:40   0:00 grep -E (^
*class|^ *Sent)
root      7180  0.5  0.1  2036  984 ?        SN   12:40   0:00 /bin/sh
/root/cbq/bin/collect
root      7249  0.0  0.1  1664  592 pts/6    S    12:40   0:00 script
log.load
root      7250  0.5  0.1  1668  616 pts/6    R    12:40   0:00 script
log.load
root      7251  2.5  0.2  2632 1420 pts/10   S    12:40   0:00 bash -i
root      7284  0.0  0.1  2304  704 ?        RN   12:40   0:00
/usr/local/mrtg/bin//rateup /var/www/html/mrtg/cbq/ cbq-4398-pe
root      7291  0.0  0.1  2688  780 pts/10   R    12:40   0:00 ps axu
root      7292  0.0  0.1  2036  984 ?        SN   12:40   0:00 /bin/sh
/root/cbq/bin/collect
root      7294  0.0  0.0  1560  288 ?        RN   12:40   0:00 cut -b 3-




It is a Dual PIII 667 on a Dual VIA 694x Motherboard, the filesystems are
ext3 mounted, and we had a lot of problems with ext3 when reaching maximum
capacity ( after reboot had a lot of fatal errors ), but that seemed to
passed, and now we are getting this unusual load, plus the system is not
so reponsive.

Oh, btw the system does a lot of cbq ( which actually worked fine without
extra load in 2.2.x kernel series ).

What should I follow to discover what is the source of this load?


Teo


