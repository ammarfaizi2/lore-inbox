Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273831AbRJASbX>; Mon, 1 Oct 2001 14:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271800AbRJASbG>; Mon, 1 Oct 2001 14:31:06 -0400
Received: from mail.spylog.com ([194.67.35.220]:24470 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S273831AbRJASav>;
	Mon, 1 Oct 2001 14:30:51 -0400
Date: Mon, 1 Oct 2001 22:27:11 +0400
From: "Oleg A. Yurlov" <kris@spylog.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Oleg A. Yurlov" <kris@spylog.com>
Organization: SpyLOG Ltd.
X-Priority: 3 (Normal)
Message-ID: <471459820350.20011001222711@spylog.com>
To: linux-kernel@vger.kernel.org
Subject: 0-oder allocation failed
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi, folks,

        I send two reports about this error.

        1.  Kernel  2.4.10.SuSE-3  with  patches  from  Andrea  (from LKML), M/B
Supermicro  P6DGE,  2  CPU,  1.5Gb  RAM,  2Gb  swap,  Mylex  DAC960PTL1 PCI RAID
Controller.

Oct  1 18:02:25 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 18:02:26 sol kernel: f75a1b20 e02b46c0 00000000 00000020 00000000 00000020 f79ffc20 00000246                                 
Oct  1 18:02:26 sol kernel:        00000020 00000001 e0315c6c e0315dc4 00000020 00000000 e013918e 00000000                          
Oct  1 18:02:26 sol kernel:        e013961a e0134cf1 00000000 f79ffc20 00000020 f79ffc98 00000020 f79ffc98                          
Oct  1 18:02:26 sol kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+329/1184] [kmem_cache_alloc+740/764] [tcp_v4_conn_request+134/972]
Oct  1 18:02:26 sol kernel:    [add_timer_randomness+207/216] [add_blkdev_randomness+66/76] [DAC960_V1_ProcessCompletedCommand+3939/3948] [add_timer_randomness+207/216] [DAC960_PG_InterruptHandler+200/288] [__alloc_pages+70/504]
Oct  1 18:02:26 sol kernel:    [__make_request+485/1980] [__make_request+516/1980] [speedo_start_xmit+449/604] [qdisc_restart+23/688] [tcp_rcv_state_process+109/2496] [tcp_v4_do_rcv+203/288]
Oct  1 18:02:26 sol kernel:    [tcp_v4_rcv+1067/1796] [ip_local_deliver+234/352] [ip_rcv+818/952] [speedo_interrupt+1145/1264] [net_rx_action+406/664] [do_softirq+111/204]
Oct  1 18:02:26 sol kernel:    [do_IRQ+433/448] [path_walk+2471/3024] [open_namei+155/1588] [filp_open+59/92] [sys_open+75/320] [system_call+51/56]

root@sol:~ > cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  1580527616 1574662144  5865472        0 38490112 980557824
Swap: 2097405952 457310208 1640095744
MemTotal:      1543484 kB
MemFree:          5728 kB
MemShared:           0 kB
Buffers:         37588 kB
Cached:         825716 kB
SwapCached:     131860 kB
Active:         137308 kB
Inactive:       857856 kB
HighTotal:     1179520 kB
HighFree:         2044 kB
LowTotal:       363964 kB
LowFree:          3684 kB
SwapTotal:     2048248 kB
SwapFree:      1601656 kB

root@sol:~ > vmstat 2
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  1  0 445268   5852  37628 825772 162 171   141   163   23    71  29   6  66
 0  1  0 444428   5500  37620 824796 822 278  1640   294  396   529   6   4  90
 0  1  0 442168   6260  37620 823816 616   0  1058    78  324   404   0   3  97
 0  2  0 441444   6164  37620 824360 108 472   332  2038  263   206   1   4  95
 1  2  0 440840   5736  37596 824920 152   0   332  1706  252   207   1   2  97
 0  1  0 442016   5468  37588 825600 272 256   444  1930  269   182   0   4  96

root@sol:~ > ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0   404   64 ?        S    Sep30   0:09 init [3] 
root         2  0.0  0.0     0    0 ?        SW   Sep30   0:01 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Sep30   0:02 [ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SWN  Sep30   0:00 [ksoftirqd_CPU1]
root         5  2.7  0.0     0    0 ?        DW   Sep30  51:51 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   Sep30   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        SW   Sep30   0:29 [kupdated]
root         8  0.0  0.0     0    0 ?        SW<  Sep30   0:00 [mdrecoveryd]
root         9  0.2  0.0     0    0 ?        SW   Sep30   5:31 [rpciod]
bin        238  0.0  0.0  1272    4 ?        S    Sep30   0:00 /sbin/portmap
root       264  0.2  0.0  2488  664 ?        S    Sep30   3:45 /usr/sbin/snmpd -c /etc/ucdsnmpd.conf -f
root       273  0.0  0.0  2120  312 ?        S    Sep30   0:07 /usr/sbin/sshd
root       284  0.0  0.0  1412  252 ?        S    Sep30   0:00 /sbin/syslogd
root       288  0.0  0.0  1856  348 ?        S    Sep30   0:00 /sbin/klogd -c 7
root       352  0.0  0.0     0    0 ?        SW   Sep30   0:00 [lockd]
at         410  0.0  0.0  1388   68 ?        S    Sep30   0:00 /usr/sbin/atd
root       682  0.0  0.0  3492  132 ?        S    Sep30   0:02 /usr/lib/postfix/master
postfix    691  0.0  0.0  3524  188 ?        S    Sep30   0:05 qmgr -l -t unix -u -c
postfix    692  0.0  0.0  3472  168 ?        S    Sep30   0:03 tlsmgr -l -t fifo -u
root       820  0.0  0.2  3924 3916 ?        SL   Sep30   0:12 /usr/sbin/xntpd
root       821  0.0  0.2  3924 3916 ?        SL   Sep30   0:02 /usr/sbin/xntpd
root       822  0.0  0.2  3924 3916 ?        SL   Sep30   0:08 /usr/sbin/xntpd
root       824  0.0  0.0  4040  128 ?        SL   Sep30   0:00 /usr/sbin/xntpd
root       833  0.0  0.0  1396  164 ?        S    Sep30   0:02 /usr/sbin/cron
root       857  0.0  0.0  1276    4 ?        S    Sep30   0:00 /usr/sbin/inetd
samovar   1001  0.0  0.0 89680  844 ?        S    Sep30   0:03 /usr/spylog/bin/iserv2
samovar   1002  0.0  0.0 89680  844 ?        S    Sep30   0:04 /usr/spylog/bin/iserv2
samovar   1003  0.0  0.0 89680  844 ?        S    Sep30   0:00 /usr/spylog/bin/iserv2
lvov      1021  0.0  0.1 121440 2248 ?       SN   Sep30   0:33 /usr/spylog/bin/purging_queue
root      1025  0.0  0.0  1368    4 tty1     S    Sep30   0:00 /sbin/mingetty --noclear tty1
root      1026  0.0  0.0  1368    4 tty2     S    Sep30   0:00 /sbin/mingetty tty2
root      1027  0.0  0.0  1232    4 ttyS0    S    Sep30   0:00 /sbin/agetty -L 115200 ttyS0
root      4017  0.0  0.0  2316    4 ?        S    Sep30   0:00 /bin/sh /usr/local/mysql/bin/safe_mysqld --mysqld=mysqld.42p --user=m
mysql     4052  0.0 21.4 575052 330804 ?     S    Sep30   0:06 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4054  0.0 21.4 575052 330804 ?     S    Sep30   0:03 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4055  0.0 21.4 575052 330804 ?     S    Sep30   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4056  0.0 21.3 575052 329672 ?     S    Sep30   0:27 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4057  2.2 21.3 575052 329672 ?     S    Sep30  40:35 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4058  0.0 21.3 575052 329672 ?     S    Sep30   1:43 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4059  0.1 21.3 575052 329680 ?     D    Sep30   3:32 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4060  0.0 21.3 575052 329684 ?     S    Sep30   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4061  0.0 21.3 575052 329700 ?     S    Sep30   0:02 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
root     16968  0.0  0.0  2492  340 ?        S    Sep30   0:00 /usr/bin/perl /usr/spylog/scripts/exceptlog.reader
root     26853  0.0  0.0  2372  300 ?        SN   07:42   0:00 /usr/bin/perl /usr/spylog/scripts/dblog.reader
mysql    27167  0.0 21.3 575052 329704 ?     S    07:53   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
root     27298  0.0  0.0  2824  388 ?        S    07:57   0:00 /usr/sbin/sshd
graber   27299  0.0  0.0  2568  420 pts/0    S    07:57   0:00 -bash
graber   27316  0.0  0.0  2096  432 pts/0    S    07:57   0:00 mysql -u root
mysql    27714  0.1 21.3 575052 329704 ?     D    08:04   0:53 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql    28515  0.0 21.3 575052 329708 ?     S    10:09   0:03 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
samovar  28722  0.0  0.0  2392  100 ?        S    10:14   0:00 /usr/spylog/bin/qserver
samovar  28723  0.0  0.6 49588 9816 ?        S    10:14   0:00 /usr/spylog/bin/qserver
samovar  28724  0.0  0.6 49588 9816 ?        S    10:14   0:00 /usr/spylog/bin/qserver
samovar  28725  0.0  0.6 49588 9816 ?        S    10:14   0:14 /usr/spylog/bin/qserver
samovar  28726  4.4  0.6 49588 9816 ?        S    10:14  21:15 /usr/spylog/bin/qserver
samovar  28727  3.5  0.6 49588 9816 ?        S    10:14  16:59 /usr/spylog/bin/qserver
samovar  28728  2.2  0.6 49588 9816 ?        S    10:14  10:39 /usr/spylog/bin/qserver
samovar  28729  0.0  0.6 49588 9816 ?        S    10:14   0:00 /usr/spylog/bin/qserver
mysql    30257  0.0 21.3 575052 329712 ?     S    11:26   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql    30561  0.0 21.3 575052 329740 ?     S    11:35   0:01 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql    30566  0.0 21.3 575052 329760 ?     S    11:35   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql    30843  0.0 21.3 575052 329784 ?     S    11:47   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql    31458  0.0 21.3 575052 329784 ?     S    12:09   0:11 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql    31599  0.4 21.3 575052 329788 ?     S    12:12   1:45 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql      332  0.0 21.3 575052 329788 ?     S    13:08   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql      559  0.0 21.3 575052 329788 ?     S    13:19   0:16 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql      575  0.0 21.3 575052 329788 ?     S    13:19   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql      633  0.0 21.3 575052 329788 ?     S    13:22   0:07 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql      664  0.0 21.3 575052 329788 ?     S    13:23   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql      665  0.0 21.3 575052 329788 ?     S    13:23   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql      741  0.0 21.3 575052 329788 ?     S    13:25   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
root       873  0.0  0.0  2820  604 ?        S    13:29   0:00 /usr/sbin/sshd
kris       874  0.0  0.0  2552  868 pts/3    S    13:29   0:00 -bash
mysql     1993  0.3 21.3 575052 329788 ?     S    14:14   0:50 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     1994  0.3 21.3 575052 329788 ?     S    14:14   0:47 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     2054  0.0 21.3 575052 329788 ?     S    14:15   0:08 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     2135  0.0 21.2 575052 328508 ?     S    14:23   0:11 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     2146  0.0 21.2 575052 328508 ?     S    14:24   0:08 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     2392  0.0 21.2 575052 328516 ?     S    14:33   0:05 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     2399  0.0 21.2 575052 328516 ?     S    14:34   0:11 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     2562  0.0 21.2 575052 328516 ?     S    14:41   0:01 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     2664  0.1 21.2 575052 328520 ?     S    14:45   0:19 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3097  0.0 21.2 575052 328532 ?     S    15:10   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3101  0.0 21.2 575052 328532 ?     S    15:10   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3142  0.3 21.2 575052 328532 ?     S    15:12   0:35 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
vz        3269  0.0  0.0  3768  316 ?        S    15:19   0:00 /spylog/layers/layers
vz        3270  0.0  0.1  9348 1900 ?        S    15:19   0:00 hits
vz        3271  0.0  8.9 274980 137656 ?     S    15:19   0:00 layers sf
vz        3272  0.0  8.9 274980 137656 ?     S    15:19   0:00 layers sf
vz        3273  0.0  8.9 274980 137656 ?     S    15:19   0:00 layers sf
vz        3274  0.0  8.9 274980 137656 ?     S    15:19   0:00 layers sf
vz        3275  0.0  8.9 274980 137656 ?     S    15:19   0:00 layers sf
vz        3279  0.0  0.1  9348 1900 ?        S    15:19   0:00 hits
mysql     3429  0.0 21.2 575052 328552 ?     S    15:26   0:04 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3440  0.4 21.2 575052 328556 ?     S    15:27   0:44 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3475  0.4 21.2 575052 328556 ?     S    15:28   0:41 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3513  0.0 21.2 575052 328556 ?     S    15:29   0:06 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3682  0.0 21.2 575052 328556 ?     S    15:36   0:01 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3699  0.0 21.2 575052 328556 ?     S    15:36   0:08 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3715  0.3 21.2 575052 328556 ?     S    15:37   0:35 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3783  0.0 21.2 575052 328556 ?     S    15:39   0:04 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3801  0.0 21.2 575052 328564 ?     S    15:40   0:02 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3839  0.0 21.2 575052 328564 ?     S    15:43   0:05 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3852  0.3 21.2 575052 328564 ?     S    15:43   0:29 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3922  0.0 21.2 575052 328564 ?     S    15:46   0:06 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3962  0.0 21.2 575052 328564 ?     S    15:49   0:01 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3985  0.1 21.2 575052 328564 ?     S    15:50   0:12 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     3999  0.0 21.2 575052 328564 ?     S    15:51   0:02 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4022  0.0 21.2 575052 328576 ?     S    15:51   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4029  0.0 21.2 575052 328584 ?     S    15:51   0:01 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4033  0.0 21.2 575052 328608 ?     S    15:52   0:03 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4091  0.1 21.2 575052 328616 ?     S    15:53   0:09 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4117  0.3 21.2 575052 328616 ?     S    15:55   0:29 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     4605  0.0 21.2 575052 328620 ?     S    16:10   0:01 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     5278  0.4 21.2 575052 328620 ?     S    16:27   0:28 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     5405  0.0 21.2 575052 328624 ?     S    16:31   0:01 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     5425  0.2 21.2 575052 328624 ?     S    16:31   0:13 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     5496  0.5 21.2 575052 328624 ?     S    16:33   0:30 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     5651  0.0 21.2 575052 328624 ?     S    16:38   0:04 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     5893  0.4 21.2 575052 328624 ?     S    16:45   0:23 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     6015  0.6 21.2 575052 328624 ?     S    16:49   0:33 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     6080  0.0 21.2 575052 328636 ?     S    16:50   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     6101  0.1 21.2 575052 328636 ?     S    16:51   0:09 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     6619  0.1 21.2 575052 328644 ?     S    17:09   0:05 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     6633  0.0 21.2 575052 328648 ?     S    17:09   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7006  0.2 21.2 575052 328648 ?     S    17:19   0:08 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7633  0.0 21.2 575052 328648 ?     S    17:42   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7699  0.0 21.2 575052 328680 ?     S    17:44   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7703  0.0 21.2 575052 328680 ?     S    17:45   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7755  0.0 21.2 575052 328680 ?     S    17:46   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7805  0.0 21.2 575052 328680 ?     S    17:49   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7807  0.0 21.2 575052 328680 ?     S    17:49   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7814  0.0 21.2 575052 328680 ?     S    17:50   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7817  0.0 21.2 575052 328688 ?     S    17:50   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7819  0.0 21.2 575052 328692 ?     S    17:50   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7822  0.0 21.2 575052 328700 ?     S    17:50   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7826  0.0 21.2 575052 328704 ?     S    17:51   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7829  0.0 21.2 575052 328716 ?     S    17:51   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7831  0.0 21.2 575052 328724 ?     S    17:51   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7834  0.0 21.2 575052 328724 ?     S    17:51   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7857  0.0 21.2 575052 328724 ?     S    17:51   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7865  0.5 21.2 575052 328724 ?     S    17:52   0:06 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7875  0.0 21.2 575052 328732 ?     S    17:52   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7879  0.0 21.2 575052 328732 ?     S    17:52   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7882  0.0 21.2 575052 328736 ?     S    17:52   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7885  0.0 21.2 575052 328736 ?     S    17:53   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7896  0.0 21.2 575052 328736 ?     S    17:53   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7904  0.0 21.2 575052 328740 ?     S    17:53   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7921  0.0 21.2 575052 328740 ?     S    17:54   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7949  0.0 21.2 575052 328740 ?     S    17:55   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7954  0.0 21.2 575052 328740 ?     S    17:56   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7956  0.0 21.2 575052 328740 ?     S    17:56   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7962  0.0 21.2 575052 328756 ?     S    17:56   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7970  0.0 21.2 575052 328756 ?     S    17:57   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7971  0.0 21.3 575052 328768 ?     S    17:57   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7975  0.6 21.3 575052 328768 ?     S    17:57   0:06 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7983  0.0 21.3 575052 328768 ?     S    17:59   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     7988  0.0 21.3 575052 328784 ?     S    17:59   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8047  0.3 21.3 575052 328784 ?     S    18:00   0:02 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
postfix   8137  0.0  0.0  3456 1196 ?        S    18:05   0:00 pickup -l -t unix -c
mysql     8165  0.0 21.3 575308 328784 ?     S    18:07   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8167  0.0 21.3 575308 328824 ?     S    18:08   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8172  0.0 21.3 575308 328824 ?     S    18:08   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8175  0.0 21.3 575308 328828 ?     S    18:08   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8176  0.0 21.3 575308 328828 ?     S    18:08   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8188  0.1 21.3 575308 328828 ?     S    18:08   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8191  0.0 21.3 575308 328836 ?     S    18:08   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8198  1.9 21.3 575308 328836 ?     S    18:08   0:06 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8201  0.0 21.3 575308 328836 ?     S    18:09   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8204  0.0 21.3 575308 328836 ?     S    18:09   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8213  0.0 21.3 575308 328892 ?     S    18:09   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8223  0.0 21.3 575308 328924 ?     S    18:09   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8226  0.1 21.3 576108 328956 ?     S    18:09   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8263  0.0 21.3 576108 328984 ?     S    18:10   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8269  0.0 21.3 576108 328984 ?     S    18:10   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8275  0.0 21.3 575852 328984 ?     S    18:10   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8289  0.0 21.3 575052 328996 ?     S    18:11   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8297  0.0 21.3 575052 328988 ?     S    18:11   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8299  0.0 21.3 575052 328988 ?     S    18:11   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8300  0.8 21.3 575052 328988 ?     S    18:11   0:01 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8348  0.0 21.3 575052 328988 ?     S    18:12   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
mysql     8377  0.0 21.3 575052 328988 ?     S    18:13   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
root      8394  0.3  0.0  2576 1472 pts/3    S    18:13   0:00 sh
mysql     8398  0.0 21.3 575052 329004 ?     S    18:13   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
vz        8399  0.7  8.9 274980 137656 ?     S    18:13   0:00 layers sf
vz        8401  0.7  8.9 274980 137656 ?     S    18:13   0:00 layers sf
mysql     8405  0.0 21.3 575052 329004 ?     S    18:13   0:00 /usr/local/mysql/libexec/mysqld.42p --basedir=/usr/local/mysql --data
root      8406  0.0  0.0  2780 1048 pts/3    R    18:14   0:02 ps aux
root@sol:~ >   

        2.  Kernel  2.4.10.SuSE-3  (without  any  additional patches), M/B Intel
L440GX,  1  CPU,  1Gb  RAM, 4Gb swap (not on Software RAID), 2 IDE HDD, Software
RAID1. 

Oct  1 06:51:42 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 06:51:42 cesar kernel: e5ab9e30 e0269da0 00000000 00000020 00000000 00000020 e200a698 00000020 
Oct  1 06:51:42 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000004 
Oct  1 06:51:42 cesar kernel:        e012a60a e012769e e200a6a0 e200a698 00000020 e5f52568 e034aa8c 00000084 
Oct  1 06:51:42 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [kmem_cache_alloc+468/488] [send_signal+44/240] 
Oct  1 06:51:42 cesar kernel:    [deliver_signal+29/80] [send_sig_info+116/136] [sys_rt_sigqueueinfo+225/240] [system_call+51/56] 
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e28 e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 ec4c4104 e753a2fc 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [kmalloc+492/536] [alloc_skb+226/400] 
Oct  1 09:23:54 cesar kernel:    [speedo_refill_rx_buf+60/472] [speedo_rx+744/828] [speedo_interrupt+188/864] [handle_IRQ_event+50/92] [do_IRQ+110/176] [default_idle+0/40] 
Oct  1 09:23:54 cesar kernel:    [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+35/40] [cpu_idle+65/84] [rest_init+0/40] 
Oct  1 09:23:54 cesar kernel:    [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: eth0: can't fill rx buffer (force 0)!
Oct  1 09:23:54 cesar kernel: eth0: Tx ring dump,  Tx queue 4630902 / 4630902:
Oct  1 09:23:54 cesar kernel: eth0:     0 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:     1 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     2 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     3 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     4 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     5 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     6 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     7 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     8 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:     9 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    10 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    11 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    12 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    13 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    14 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    15 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    16 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:    17 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    18 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    19 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    20 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    21 400ca000.
Oct  1 09:23:54 cesar kernel: eth0:  *=22 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    23 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    24 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:    25 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    26 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    27 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    28 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    29 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    30 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    31 000ca000.
Oct  1 09:23:54 cesar kernel: eth0: Printing Rx ring (next to receive into 13361143, dirty index 13361142).
Oct  1 09:23:54 cesar kernel: eth0:     0 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     1 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     2 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     3 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     4 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     5 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     6 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     7 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     8 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     9 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    10 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    11 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    12 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    13 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    14 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    15 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    16 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    17 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    18 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    19 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    20 00000001.
Oct  1 09:23:54 cesar kernel: eth0: l  21 c0000001.
Oct  1 09:23:54 cesar kernel: eth0:  * 22 00000000.
Oct  1 09:23:54 cesar kernel: eth0:   =23 0000a020.
Oct  1 09:23:54 cesar kernel: eth0:    24 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    25 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    26 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    27 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    28 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    29 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    30 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    31 00000001.
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e10 e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 e02c10ec 00000001 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [kmalloc+492/536] [speedo_show_state+273/292] 
Oct  1 09:23:54 cesar kernel:    [alloc_skb+226/400] [speedo_refill_rx_buf+60/472] [speedo_refill_rx_buffers+43/56] [speedo_rx+798/828] [speedo_interrupt+188/864] [handle_IRQ_event+50/92] 
Oct  1 09:23:54 cesar kernel:    [do_IRQ+110/176] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+35/40] 
Oct  1 09:23:54 cesar kernel:    [cpu_idle+65/84] [rest_init+0/40] [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e3c e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 00000020 f7eb4a44 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [speedo_show_state+273/292] [alloc_skb+226/400] 
Oct  1 09:23:54 cesar kernel:    [kmalloc+492/536] [alloc_skb+226/400] [speedo_refill_rx_buf+60/472] [speedo_refill_rx_buffers+43/56] [speedo_interrupt+160/864] [handle_IRQ_event+50/92] 
Oct  1 09:23:54 cesar kernel:    [do_IRQ+110/176] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+35/40] 
Oct  1 09:23:54 cesar kernel:    [cpu_idle+65/84] [rest_init+0/40] [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e10 e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 e02c2258 00000020 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [_alloc_pages+22/24] [kmalloc+492/536] 
Oct  1 09:23:54 cesar kernel:    [speedo_show_state+273/292] [alloc_skb+226/400] [speedo_refill_rx_buf+60/472] [speedo_refill_rx_buffers+43/56] [speedo_rx+798/828] [speedo_interrupt+188/864] 
Oct  1 09:23:54 cesar kernel:    [handle_IRQ_event+50/92] [do_IRQ+110/176] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] 
Oct  1 09:23:54 cesar kernel:    [default_idle+35/40] [cpu_idle+65/84] [rest_init+0/40] [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e28 e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 ec4c4104 e753a2fc 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [kmalloc+492/536] [alloc_skb+226/400] 
Oct  1 09:23:54 cesar kernel:    [speedo_refill_rx_buf+60/472] [speedo_rx+744/828] [speedo_interrupt+188/864] [handle_IRQ_event+50/92] [do_IRQ+110/176] [default_idle+0/40] 
Oct  1 09:23:54 cesar kernel:    [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+35/40] [cpu_idle+65/84] [rest_init+0/40] 
Oct  1 09:23:54 cesar kernel:    [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: eth0: can't fill rx buffer (force 0)!
Oct  1 09:23:54 cesar kernel: eth0: Tx ring dump,  Tx queue 4630903 / 4630903:
Oct  1 09:23:54 cesar kernel: eth0:     0 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:     1 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     2 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     3 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     4 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     5 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     6 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     7 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     8 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:     9 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    10 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    11 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    12 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    13 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    14 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    15 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    16 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:    17 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    18 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    19 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    20 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    21 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    22 400ca000.
Oct  1 09:23:54 cesar kernel: eth0:  *=23 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    24 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:    25 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    26 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    27 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    28 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    29 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    30 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    31 000ca000.
Oct  1 09:23:54 cesar kernel: eth0: Printing Rx ring (next to receive into 13361149, dirty index 13361148).
Oct  1 09:23:54 cesar kernel: eth0:     0 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     1 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     2 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     3 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     4 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     5 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     6 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     7 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     8 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     9 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    10 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    11 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    12 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    13 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    14 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    15 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    16 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    17 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    18 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    19 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    20 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    21 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    22 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    23 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    24 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    25 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    26 00000001.
Oct  1 09:23:54 cesar kernel: eth0: l  27 c0000001.
Oct  1 09:23:54 cesar kernel: eth0:  * 28 00000000.
Oct  1 09:23:54 cesar kernel: eth0:   =29 0000a020.
Oct  1 09:23:54 cesar kernel: eth0:    30 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    31 00000001.
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e10 e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 e02c10ec 00000001 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [kmalloc+492/536] [speedo_show_state+273/292] 
Oct  1 09:23:54 cesar kernel:    [alloc_skb+226/400] [speedo_refill_rx_buf+60/472] [speedo_refill_rx_buffers+43/56] [speedo_rx+798/828] [speedo_interrupt+188/864] [handle_IRQ_event+50/92] 
Oct  1 09:23:54 cesar kernel:    [do_IRQ+110/176] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+35/40] 
Oct  1 09:23:54 cesar kernel:    [cpu_idle+65/84] [rest_init+0/40] [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e3c e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 00000020 f7eb4a44 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [speedo_show_state+273/292] [alloc_skb+226/400] 
Oct  1 09:23:54 cesar kernel:    [kmalloc+492/536] [alloc_skb+226/400] [speedo_refill_rx_buf+60/472] [speedo_refill_rx_buffers+43/56] [speedo_interrupt+160/864] [handle_IRQ_event+50/92] 
Oct  1 09:23:54 cesar kernel:    [do_IRQ+110/176] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+35/40] 
Oct  1 09:23:54 cesar kernel:    [cpu_idle+65/84] [rest_init+0/40] [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e10 e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 e02c2258 00000020 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [_alloc_pages+22/24] [kmalloc+492/536] 
Oct  1 09:23:54 cesar kernel:    [speedo_show_state+273/292] [alloc_skb+226/400] [speedo_refill_rx_buf+60/472] [speedo_refill_rx_buffers+43/56] [speedo_rx+798/828] [speedo_interrupt+188/864] 
Oct  1 09:23:54 cesar kernel:    [handle_IRQ_event+50/92] [do_IRQ+110/176] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] 
Oct  1 09:23:54 cesar kernel:    [default_idle+35/40] [cpu_idle+65/84] [rest_init+0/40] [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e28 e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 ec4c4104 e753a2fc 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [kmalloc+492/536] [alloc_skb+226/400] 
Oct  1 09:23:54 cesar kernel:    [speedo_refill_rx_buf+60/472] [speedo_rx+744/828] [speedo_interrupt+188/864] [handle_IRQ_event+50/92] [do_IRQ+110/176] [default_idle+0/40] 
Oct  1 09:23:54 cesar kernel:    [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+35/40] [cpu_idle+65/84] [rest_init+0/40] 
Oct  1 09:23:54 cesar kernel:    [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: eth0: can't fill rx buffer (force 0)!
Oct  1 09:23:54 cesar kernel: eth0: Tx ring dump,  Tx queue 4630904 / 4630904:
Oct  1 09:23:54 cesar kernel: eth0:     0 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:     1 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     2 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     3 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     4 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     5 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     6 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     7 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     8 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:     9 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    10 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    11 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    12 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    13 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    14 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    15 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    16 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:    17 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    18 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    19 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    20 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    21 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    22 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    23 400ca000.
Oct  1 09:23:54 cesar kernel: eth0:  *=24 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:    25 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    26 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    27 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    28 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    29 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    30 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    31 000ca000.
Oct  1 09:23:54 cesar kernel: eth0: Printing Rx ring (next to receive into 13361155, dirty index 13361154).
Oct  1 09:23:54 cesar kernel: eth0:     0 00000001.
Oct  1 09:23:54 cesar kernel: eth0: l   1 c0000001.
Oct  1 09:23:54 cesar kernel: eth0:  *  2 00000000.
Oct  1 09:23:54 cesar kernel: eth0:   = 3 0000a020.
Oct  1 09:23:54 cesar kernel: eth0:     4 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     5 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     6 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     7 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     8 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     9 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    10 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    11 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    12 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    13 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    14 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    15 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    16 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    17 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    18 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    19 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    20 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    21 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    22 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    23 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    24 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    25 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    26 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    27 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    28 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    29 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    30 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    31 00000001.
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e10 e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 e02c10ec 00000001 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [kmalloc+492/536] [speedo_show_state+273/292] 
Oct  1 09:23:54 cesar kernel:    [alloc_skb+226/400] [speedo_refill_rx_buf+60/472] [speedo_refill_rx_buffers+43/56] [speedo_rx+798/828] [speedo_interrupt+188/864] [handle_IRQ_event+50/92] 
Oct  1 09:23:54 cesar kernel:    [do_IRQ+110/176] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+35/40] 
Oct  1 09:23:54 cesar kernel:    [cpu_idle+65/84] [rest_init+0/40] [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e3c e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 00000020 f7eb4a44 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [speedo_show_state+273/292] [alloc_skb+226/400] 
Oct  1 09:23:54 cesar kernel:    [kmalloc+492/536] [alloc_skb+226/400] [speedo_refill_rx_buf+60/472] [speedo_refill_rx_buffers+43/56] [speedo_interrupt+160/864] [handle_IRQ_event+50/92] 
Oct  1 09:23:54 cesar kernel:    [do_IRQ+110/176] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+35/40] 
Oct  1 09:23:54 cesar kernel:    [cpu_idle+65/84] [rest_init+0/40] [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e10 e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 e02c2258 00000020 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [_alloc_pages+22/24] [kmalloc+492/536] 
Oct  1 09:23:54 cesar kernel:    [speedo_show_state+273/292] [alloc_skb+226/400] [speedo_refill_rx_buf+60/472] [speedo_refill_rx_buffers+43/56] [speedo_rx+798/828] [speedo_interrupt+188/864] 
Oct  1 09:23:54 cesar kernel:    [handle_IRQ_event+50/92] [do_IRQ+110/176] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] 
Oct  1 09:23:54 cesar kernel:    [default_idle+35/40] [cpu_idle+65/84] [rest_init+0/40] [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e28 e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 ec4c4104 e753a2fc 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [kmalloc+492/536] [alloc_skb+226/400] 
Oct  1 09:23:54 cesar kernel:    [speedo_refill_rx_buf+60/472] [speedo_rx+744/828] [speedo_interrupt+188/864] [handle_IRQ_event+50/92] [do_IRQ+110/176] [default_idle+0/40] 
Oct  1 09:23:54 cesar kernel:    [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+35/40] [cpu_idle+65/84] [rest_init+0/40] 
Oct  1 09:23:54 cesar kernel:    [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: eth0: can't fill rx buffer (force 0)!
Oct  1 09:23:54 cesar kernel: eth0: Tx ring dump,  Tx queue 4630905 / 4630905:
Oct  1 09:23:54 cesar kernel: eth0:     0 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:     1 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     2 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     3 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     4 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     5 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     6 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     7 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:     8 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:     9 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    10 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    11 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    12 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    13 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    14 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    15 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    16 200ca000.
Oct  1 09:23:54 cesar kernel: eth0:    17 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    18 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    19 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    20 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    21 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    22 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    23 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    24 600ca000.
Oct  1 09:23:54 cesar kernel: eth0:  *=25 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    26 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    27 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    28 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    29 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    30 000ca000.
Oct  1 09:23:54 cesar kernel: eth0:    31 000ca000.
Oct  1 09:23:54 cesar kernel: eth0: Printing Rx ring (next to receive into 13361161, dirty index 13361160).
Oct  1 09:23:54 cesar kernel: eth0:     0 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     1 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     2 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     3 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     4 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     5 00000001.
Oct  1 09:23:54 cesar kernel: eth0:     6 00000001.
Oct  1 09:23:54 cesar kernel: eth0: l   7 c0000001.
Oct  1 09:23:54 cesar kernel: eth0:  *  8 00000000.
Oct  1 09:23:54 cesar kernel: eth0:   = 9 0000a020.
Oct  1 09:23:54 cesar kernel: eth0:    10 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    11 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    12 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    13 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    14 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    15 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    16 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    17 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    18 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    19 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    20 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    21 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    22 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    23 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    24 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    25 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    26 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    27 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    28 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    29 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    30 00000001.
Oct  1 09:23:54 cesar kernel: eth0:    31 00000001.
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e10 e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 e02c10ec 00000001 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [kmalloc+492/536] [speedo_show_state+273/292] 
Oct  1 09:23:54 cesar kernel:    [alloc_skb+226/400] [speedo_refill_rx_buf+60/472] [speedo_refill_rx_buffers+43/56] [speedo_rx+798/828] [speedo_interrupt+188/864] [handle_IRQ_event+50/92] 
Oct  1 09:23:54 cesar kernel:    [do_IRQ+110/176] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+35/40] 
Oct  1 09:23:54 cesar kernel:    [cpu_idle+65/84] [rest_init+0/40] [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e3c e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 00000020 f7eb4a44 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [speedo_show_state+273/292] [alloc_skb+226/400] 
Oct  1 09:23:54 cesar kernel:    [kmalloc+492/536] [alloc_skb+226/400] [speedo_refill_rx_buf+60/472] [speedo_refill_rx_buffers+43/56] [speedo_interrupt+160/864] [handle_IRQ_event+50/92] 
Oct  1 09:23:54 cesar kernel:    [do_IRQ+110/176] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+35/40] 
Oct  1 09:23:54 cesar kernel:    [cpu_idle+65/84] [rest_init+0/40] [rest_init+39/40] 
Oct  1 09:23:54 cesar kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Oct  1 09:23:54 cesar kernel: e02d7e10 e0269da0 00000000 00000020 00000000 00000020 e200b700 00000020 
Oct  1 09:23:54 cesar kernel:        00000020 00000001 e02c2108 e02c2258 00000020 00000000 e012a196 00000000 
Oct  1 09:23:54 cesar kernel:        e012a60a e012769e e200b700 e200b708 00000020 f7eb4a44 e02c2258 00000020 
Oct  1 09:23:54 cesar kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+178/756] [_alloc_pages+22/24] [kmalloc+492/536] 
Oct  1 09:23:54 cesar kernel:    [speedo_show_state+273/292] [alloc_skb+226/400] [speedo_refill_rx_buf+60/472] [speedo_refill_rx_buffers+43/56] [speedo_rx+798/828] [speedo_interrupt+188/864] 
Oct  1 09:23:54 cesar kernel:    [handle_IRQ_event+50/92] [do_IRQ+110/176] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] [default_idle+0/40] 
Oct  1 09:23:54 cesar kernel:    [default_idle+35/40] [cpu_idle+65/84] [rest_init+0/40] [rest_init+39/40] 

        I   can't   send   other   information in this case Because I was not in
office...

--
Oleg A. Yurlov aka Kris Werewolf, SysAdmin      OAY100-RIPN
mailto:kris@spylog.com                          +7 095 332-03-88

