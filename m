Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289159AbSAGJz4>; Mon, 7 Jan 2002 04:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289161AbSAGJzr>; Mon, 7 Jan 2002 04:55:47 -0500
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:56331 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S289159AbSAGJze> convert rfc822-to-8bit; Mon, 7 Jan 2002 04:55:34 -0500
X-Envelope-From: mmokrejs
Posted-Date: Mon, 7 Jan 2002 10:55:31 +0100 (MET)
Date: Mon, 7 Jan 2002 10:55:31 +0100 (MET)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: mysql@lists.mysql.com, linux-kernel@vger.kernel.org
Subject: Swapped out mysqld on linux 2.4.17-rc2 with INSERT DELAYED data
Message-ID: <Pine.OSF.4.21.0201071029230.18645-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm using INSERT DELAYED to insert about 120GB of data into mysql from mysqldumpped
data from remote server. After the weekend I've found such output from our perl script
(after was dumped let's say 60GB):

Just dumping Mthermoautotrophicum.orf
Just dumping Mthermoautotrophicum.orf_data
Just dumping Mthermoautotrophicum.pfam
Just dumping Mthermoautotrophicum.pfam_data
ERROR 1135 at line 30: Can't create a new thread (errno 11). If you are not out of available memory, you can consult the manual for a possible OS-dependent bug
Failed to dump Mthermoautotrophicum.pfam_data
Just dumping Mthermoautotrophicum.pirkw
ERROR 1135 at line 46: Can't create a new thread (errno 11). If you are not out of available memory, you can consult the manual for a possible OS-dependent bug
Failed to dump Mthermoautotrophicum.pirkw
Just dumping Mthermoautotrophicum.prd
ERROR 1135 at line 31: Can't create a new thread (errno 11). If you are not out of available memory, you can consult the manual for a possible OS-dependent bug
Failed to dump Mthermoautotrophicum.prd

[...]

DBI->connect failed: Can't create a new thread (errno 11). If you are not out of available memory, you can consult the manual for a possible OS-dependent bug at /home/bioadmin/bin/dump_tables.pl line 252

FATAL ERROR: Unable to connect to jerboas: Can't create a new thread (errno 11). If you are not out of available memory, you can consult the manual for a possible OS-dependent bug at /home/bioadmin/bin/dump_tables.pl line 252.
Can't call method "func" without a package or object reference at /home/bioadmin/bin/dump_tables.pl line 254.
shell$

The machine is linux 2.4.17-rc2 running 
/usr/local/mysql/bin/mysql  Ver 11.15 Distrib 3.23.42, for pc-linux-gnu (i686).
The machine runs SMP kernel on 2 Intel Pentium III processor box with 1GB
of memory.

I rerun our script to continue dumps and managed to dump about 60 tables, and then same problem: arrose

Just dumping Mycoplasma_genitalium_G37.cogs_data
ERROR 1135 at line 30: Can't create a new thread (errno 11). If you are not out of available memory, you can consult the manual for a possible OS-dependent bug
Failed to dump Mycoplasma_genitalium_G37.cogs_data

shell$ mysqladmin extended-status          
+--------------------------+------------+
| Variable_name            | Value      |
+--------------------------+------------+
| Aborted_clients          | 196        |
| Aborted_connects         | 23         |
| Bytes_received           | 1584472794 |
| Bytes_sent               | 1311517    |
| Connections              | 11826      |
| Created_tmp_disk_tables  | 0          |
| Created_tmp_tables       | 0          |
| Created_tmp_files        | 0          |
| Delayed_insert_threads   | 4089       |
| Delayed_writes           | 78047350   |
| Delayed_errors           | 3591775    |
| Flush_commands           | 1          |
| Handler_delete           | 0          |
| Handler_read_first       | 1          |
| Handler_read_key         | 0          |
| Handler_read_next        | 2          |
| Handler_read_prev        | 0          |
| Handler_read_rnd         | 0          |
| Handler_read_rnd_next    | 418        |
| Handler_update           | 0          |
| Handler_write            | 85799969   |
| Key_blocks_used          | 249376     |
| Key_read_requests        | 2092226517 |
| Key_reads                | 21218      |
| Key_write_requests       | 542944973  |
| Key_writes               | 10606554   |
| Max_used_connections     | 4          |
| Not_flushed_key_blocks   | 0          |
| Not_flushed_delayed_rows | 0          |
| Open_tables              | 4318       |
| Open_files               | 28192      |
| Open_streams             | 0          |
| Opened_tables            | 10989      |
| Questions                | 25236      |
| Select_full_join         | 0          |
| Select_full_range_join   | 0          |
| Select_range             | 0          |
| Select_range_check       | 0          |
| Select_scan              | 0          |
| Slave_running            | OFF        |
| Slave_open_temp_tables   | 0          |
| Slow_launch_threads      | 0          |
| Slow_queries             | 949        |
| Sort_merge_passes        | 0          |
| Sort_range               | 0          |
| Sort_rows                | 0          |
| Sort_scan                | 0          |
| Table_locks_immediate    | 10247      |
| Table_locks_waited       | 0          |
| Threads_cached           | 3          |
| Threads_created          | 16         |
| Threads_connected        | 4090       |
| Threads_running          | 1          |
| Uptime                   | 1445845    |
+--------------------------+------------+
shell$


mysqladmin processlist gives me:

| 11711 | DELAYED | localhost      | Mthermoautotrophicum                         | Delayed_insert | 981    | Waiting on cond | scop2                                 |
| 11713 | DELAYED | localhost      | Mthermoautotrophicum                         | Delayed_insert | 971    | Waiting on cond | scop2_data                            |
| 11715 | DELAYED | localhost      | Mthermoautotrophicum                         | Delayed_insert | 970    | Waiting on cond | seg                                   |
| 11717 | DELAYED | localhost      | Mthermoautotrophicum                         | Delayed_insert | 968    | Waiting on cond | struc                                 |
| 11719 | DELAYED | localhost      | Mthermoautotrophicum                         | Delayed_insert | 945    | Waiting on cond | supfam                                |
| 11721 | DELAYED | localhost      | Mthermoautotrophicum                         | Delayed_insert | 936    | Waiting on cond | taxon                                 |
| 11725 | DELAYED | localhost      | Mycoplasma_genitalium_G37                    | Delayed_insert | 927    | Waiting on cond | Upd                                   |
| 11727 | DELAYED | localhost      | Mycoplasma_genitalium_G37                    | Delayed_insert | 921    | Waiting on cond | blast                                 |
| 11729 | DELAYED | localhost      | Mycoplasma_genitalium_G37                    | Delayed_insert | 911    | Waiting on cond | blast_data                            |
| 11731 | DELAYED | localhost      | Mycoplasma_genitalium_G37                    | Delayed_insert | 909    | Waiting on cond | blastindex                            |
| 11733 | DELAYED | localhost      | Mycoplasma_genitalium_G37                    | Delayed_insert | 908    | Waiting on cond | blimps                                |
| 11735 | DELAYED | localhost      | Mycoplasma_genitalium_G37                    | Delayed_insert | 908    | Waiting on cond | blimps_data                           |
| 11737 | DELAYED | localhost      | Mycoplasma_genitalium_G37                    | Delayed_insert | 902    | Waiting on cond | cogs                                  |


shell$ mysqladmin processlist | wc -l
   4094
shell$

  PID TTY      STAT   TIME  MAJFL   TRS   DRS  RSS %MEM COMMAND
    1 ?        S      0:12    127    24  1275  452  0.0 init [3] 
    2 ?        SW     0:00      0     0     0    0  0.0 [keventd]
    3 ?        SWN    0:00      0     0     0    0  0.0 [ksoftirqd_CPU0]
    4 ?        SWN    0:00      0     0     0    0  0.0 [ksoftirqd_CPU1]
    5 ?        SW     2:49      0     0     0    0  0.0 [kswapd]
    6 ?        SW     0:00      0     0     0    0  0.0 [bdflush]
    7 ?        SW     3:00      0     0     0    0  0.0 [kupdated]
    8 ?        SW     0:00      0     0     0    0  0.0 [scsi_eh_0]
    9 ?        SW<    0:00      0     0     0    0  0.0 [mdrecoveryd]
   75 ?        SW     0:54      0     0     0    0  0.0 [kreiserfsd]
   94 ?        S      0:01     43     9  1410  516  0.0 /sbin/portmap
  148 ?        S      0:00      1    19  2240  424  0.0 /usr/sbin/powertweakd
  155 ?        S      0:07     73    24  1351  596  0.0 /sbin/syslogd
  157 ?        S      0:00    108    17  1974  480  0.0 /sbin/klogd
  161 ?        S      3:14    400   658  3713 1812  0.1 /usr/bin/perl -w /usr/bin/egd.pl /etc/entropy
  201 ?        S      0:02    111   642  1749  492  0.0 /usr/local/sbin/sshd
  203 ?        S      0:37    506   454  3837 2880  0.2 /usr/sbin/named
  208 ?        S      0:00     60    15  1308  448  0.0 /usr/sbin/inetd
  218 ?        S      0:00    231   345  1494  648  0.0 lpd Waiting  
  240 ?        S      0:33     44   848  2171  852  0.0 sendmail: accepting connections      
  249 ?        S      0:05     36    20  1423  580  0.0 /usr/sbin/cron
  289 ?        S      0:13     67  1602  2465  636  0.0 /usr/local/www/bin/httpsd
  292 tty1     S      0:00    122    11  1272  408  0.0 /sbin/getty 38400 tty1
  293 tty2     S      0:00    122    11  1272  408  0.0 /sbin/getty 38400 tty2
  294 tty3     S      0:00    122    11  1272  408  0.0 /sbin/getty 38400 tty3
  295 tty4     S      0:00    122    11  1272  408  0.0 /sbin/getty 38400 tty4
  296 tty5     S      0:00    122    11  1272  408  0.0 /sbin/getty 38400 tty5
  297 tty6     S      0:00    122    11  1272  408  0.0 /sbin/getty 38400 tty6
  298 ?        S      0:08   2962  1602  2629 1488  0.1 /usr/local/www/bin/httpsd
  299 ?        S      0:08   3554  1602  2629 1496  0.1 /usr/local/www/bin/httpsd
  300 ?        S      0:08   2956  1602  2629 1464  0.1 /usr/local/www/bin/httpsd
  301 ?        S      0:08   2988  1602  2629 1496  0.1 /usr/local/www/bin/httpsd
  351 ?        S      0:08   3028  1602  2629 1468  0.1 /usr/local/www/bin/httpsd
  387 ?        S      0:07   5598  1602  2629 1468  0.1 /usr/local/www/bin/httpsd
  424 ?        S      0:09   3566  1602  2621 1488  0.1 /usr/local/www/bin/httpsd
  453 ?        S      0:07   2861  1602  2621 1468  0.1 /usr/local/www/bin/httpsd
  507 ?        S      0:07   3589  1602  2629 1468  0.1 /usr/local/www/bin/httpsd
  662 ?        S      0:07   3032  1602  2629 1556  0.1 /usr/local/www/bin/httpsd
10035 ?        S      0:00    219   420  1663  764  0.0 /bin/sh ./bin/safe_mysqld --datadir=/data2/mysql --pid-file=/usr/local/mysql/ru
n/jerboas.pid
10067 ?        S      0:01    672  1553 606658 510836 49.6 /usr/local/mysql/libexec/mysqld --basedir=/usr/local/mysql --datadir=/data2/
mysql --user=mysql --pid-file=/usr/local/mysql/run/jerboas.pid --skip-locking --log=/usr/local/mysql/log/jerboas.log
10069 ?        S      0:07    235  1553 606658 510836 49.6 /usr/local/mysql/libexec/mysqld --basedir=/usr/local/mysql --datadir=/data2/
mysql --user=mysql --pid-file=/usr/local/mysql/run/jerboas.pid --skip-locking --log=/usr/local/mysql/log/jerboas.log
10070 ?        S      1:45      0  1553 606658 510836 49.6 /usr/local/mysql/libexec/mysqld --basedir=/usr/local/mysql --datadir=/data2/
mysql --user=mysql --pid-file=/usr/local/mysql/run/jerboas.pid --skip-locking --log=/usr/local/mysql/log/jerboas.log
23352 ?        S<    98:41   3133  1553 606658 510836 49.6 /usr/local/mysql/libexec/mysqld --basedir=/usr/local/mysql --datadir=/data2/
mysql --user=mysql --pid-file=/usr/local/mysql/run/jerboas.pid --skip-locking --log=/usr/local/mysql/log/jerboas.log
 5878 ?        S     65:41   1653  1553 606658 510836 49.6 /usr/local/mysql/libexec/mysqld --basedir=/usr/local/mysql --datadir=/data2/
mysql --user=mysql --pid-file=/usr/local/mysql/run/jerboas.pid --skip-locking --log=/usr/local/mysql/log/jerboas.log
21240 ?        S      0:03    169   642  2049  888  0.0 /usr/local/sbin/sshd
21241 pts/0    S      0:00    325   420  1875  876  0.0 -bash
[...]
shell$ vmstat 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0 449668  62364  62304 225840   0   0     1     3    4     9   4   1  12
 0  0  0 449668  62364  62304 225840   0   0     0     0  275   124   3  29  68
 0  0  0 449668  62364  62304 225840   0   0     0     0  276   124   3  29  68

shell$ swapon -s
Filename                        Type            Size    Used    Priority
/dev/sda2                       partition       2097136 449668  -1
shell$


I did mysdqladmin flush-tables ,
but now mysql stops responding to other queries. Swap usage is still the same, so it looks
that system cannot swapout mysqld processes to flush the cache. Any idea what I can do right now to
unswap processes? Is it safe to send mysqld -1 or run the mysqladmin
shutdown? Would it actually help when it doesn't currently respond to
"mysqlamdin processlist" command, possibly because of the "mysqladmin
flush-tables" command pending? I just cannot get any status information
right now. There're no error in the mysqls error log file and no errors in
system log files.

Please, Cc: me in reply. Thanks!
-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3616 , fax: +49-89-3187 3585

