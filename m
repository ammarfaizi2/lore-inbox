Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281921AbRLRNKG>; Tue, 18 Dec 2001 08:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282418AbRLRNJt>; Tue, 18 Dec 2001 08:09:49 -0500
Received: from mout1.freenet.de ([194.97.50.132]:59867 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S281921AbRLRNJ0>;
	Tue, 18 Dec 2001 08:09:26 -0500
Message-ID: <3C1F4014.2010705@athlon.maya.org>
Date: Tue, 18 Dec 2001 14:09:40 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [2.4.17rc1] Swapping
Content-Type: multipart/mixed;
 boundary="------------020608060407030908070009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020608060407030908070009
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,


I tested linux 2.4.17rc1 regarding the VM. As test I did what I'm doing 
frequently: making a incremental backup (the source is about 20 GB) with 
rsync (via ssh) of my server to my backup-server.



server 	----->			backup-server


The building of the filelist on the server needed 64MB (!) swap. The 
building of the filelist on the backup-server needed 151 MB swap (!)

You can find the processlist with all running processes of the server 
and the backup-server in the attached file VM. I used a file because of 
the ugly line cutting in the mail.

The processlist of the server was done after completing the filelist on 
the server - the processlist of the backup-server was a snapshot while 
building its filelist.


During data transport, the swap space on the backup-server increased to 
243 MB (!) and the system swaped nearly nonstop. Because the 
swap-space reached the limit, I gave the backup-server during 
data-transport more swap with swapon /dev/hdb13.

A snapshot of free on the backup-server:
free
              total       used       free     shared    buffers     cached
Mem:        514368     509968       4400          0     177328     164220
-/+ buffers/cache:     168420     345948
Swap:      1052208     243228     808980

After completing, the swap on the backupserver was reduced to 65MB and 
on the server to 37MB

I think it is not necessary to emphasis, that the backup-server was very 
slow and tenacious during data transport!
The behaviour of 2.4.17rc1 isn't better than evry other 2.4.x-version. 
There is only one exception:
I did the same with kernel 2.4.13 - and this version worked extremly 
fine nearly without any swapping.
Linux-2.2.x is working fine, too - that is without swapping in this 
situation.


Regards,
Andreas Hartmann

--------------020608060407030908070009
Content-Type: text/plain;
 name="VM"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="VM"

server

ps -aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1100   56 ?        S    Dec17   0:03 init [2]
root         2  0.0  0.0     0    0 ?        SW   Dec17   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Dec17   0:00 [ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SW   Dec17   0:28 [kswapd]
root         5  0.0  0.0     0    0 ?        SW   Dec17   0:00 [bdflush]
root         6  0.0  0.0     0    0 ?        SW   Dec17   0:03 [kupdated]
root        26  0.0  0.0     0    0 ?        SW   Dec17   0:00 [kreiserfsd]
bin         78  0.0  0.0  1116   52 ?        S    Dec17   0:00 /sbin/portmap
root        90  0.0  0.0  1424  256 ?        S    Dec17   0:00 /usr/sbin/syslogd
root        92  0.0  0.0  1972  228 ?        S    Dec17   0:00 /usr/local/sbin/sshd
root        95  0.0  0.0  1152  144 ?        S    Dec17   0:00 /usr/sbin/klogd -c 1
named      116  0.0  0.0  2456  244 ?        S    Dec17   0:02 /usr/sbin/named -u named -g named
at         120  0.0  0.0  1224  148 ?        S    Dec17   0:00 /usr/sbin/atd
root       172  0.0  0.0  5068  232 ?        S    Dec17   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf -D SSLroot       173  0.0  0.0  1384  228 ?        S    Dec17   0:00 /usr/sbin/inetd
wwwrun     200  0.0  0.1  5132  388 ?        S    Dec17   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf -D SSLwwwrun     201  0.0  0.1  5120  360 ?        S    Dec17   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf -D SSLwwwrun     202  0.0  0.1  5132  392 ?        S    Dec17   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf -D SSLwwwrun     203  0.0  0.1  5136  364 ?        S    Dec17   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf -D SSLwwwrun     204  0.0  0.1  5132  392 ?        S    Dec17   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf -D SSLnews       205  0.0  0.4  5740 1252 ?        S    Dec17   0:00 /usr/local/news/bin/innd -p4 -a
news       206  0.0  0.0  1772  128 ?        S    Dec17   0:00 /bin/sh /usr/local/news/bin/rc.news
news       217  0.0  0.0  1552   56 ?        SN   Dec17   0:00 /usr/local/news/bin/crosspost
news       218  0.0  0.0  1548   56 ?        SN   Dec17   0:00 /usr/local/news/bin/overchan
daemon     221  0.0  0.0  1964  184 ?        S    Dec17   0:00 lpd Waiting
root       241  0.0  0.0  1120  248 ?        S    Dec17   0:00 /usr/sbin/crond
root       249  0.0  0.1  2948  416 ?        S    Dec17   0:00 sendmail: accepting connections
fax        258  0.0  0.0  2240  160 ?        S    Dec17   0:00 /usr/local/sbin/faxq
fax        260  0.0  0.0  2572  156 ?        S    Dec17   0:00 /usr/local/sbin/hfaxd -i hylafax
squid      266  0.0  0.0  3876  160 ?        S<   Dec17   0:00 /usr/sbin/squid -sYD
squid      268  0.0  0.4  9744 1156 ?        S<   Dec17   0:04 (squid) -sYD
squid      269  0.0  0.0  1068   76 ?        S    Dec17   0:00 (unlinkd)
root       280  0.0  0.0 28484  196 ?        S    Dec17   0:00 /sbin/junkbuster /etc/junkbuster/config
root       286  0.0  0.0  1380  160 ?        S    Dec17   0:00 /usr/sbin/rpc.kmountd
root       287  0.0  0.0     0    0 ?        SW   Dec17   0:00 [nfsd]
root       288  0.0  0.0     0    0 ?        SW   Dec17   0:00 [lockd]
root       289  0.0  0.0     0    0 ?        SW   Dec17   0:00 [rpciod]
root       293  0.0  0.1  1548  292 ?        S    Dec17   0:00 /usr/sbin/timed -M -t -n maya.org -F localhost
root       294  0.0  0.0  1072   56 tty1     S    Dec17   0:00 /sbin/mingetty --noclear tty1
root       295  0.0  0.0  1072   56 tty2     S    Dec17   0:00 /sbin/mingetty tty2
root       296  0.0  0.0  1072   56 tty3     S    Dec17   0:00 /sbin/mingetty tty3
root       297  0.0  0.0  1072   56 tty4     S    Dec17   0:00 /sbin/mingetty tty4
root       298  0.0  0.0  1072   56 tty5     S    Dec17   0:00 /sbin/mingetty tty5
root       299  0.0  0.0  1072   56 tty6     S    Dec17   0:00 /sbin/mingetty tty6
news       321  0.0  0.2  1800  568 ?        S    Dec17   0:10 /bin/sh /usr/local/news/bin/innwatch
wwwrun     454  0.0  0.1  5120  444 ?        S    Dec17   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf -D SSLwwwrun     455  0.0  0.1  5132  452 ?        S    Dec17   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf -D SSLwwwrun     456  0.0  0.1  5136  452 ?        S    Dec17   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf -D SSLwwwrun     457  0.0  0.1  5132  452 ?        S    Dec17   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf -D SSLwwwrun     458  0.0  0.1  5132  452 ?        S    Dec17   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf -D SSLroot       576  0.0  0.0 28484  196 ?        S    Dec17   0:00 /sbin/junkbuster /etc/junkbuster/config
root     12482  0.1  0.1  3368  444 ?        S    12:29   0:04 /usr/local/sbin/sshd
ausgang  12484  0.0  0.0  1904  148 ?        S    12:29   0:00 bash -c export KDEDIR=/opt/kde-2.2 && export PAausgang  12490  0.2  0.3 16364  828 ?        S    12:29   0:06 /opt/kde-2.2/bin/kppp -c 01019 freenet ohne Optroot     12491  0.0  0.0 15060  116 ?        S    12:29   0:00 /opt/kde-2.2/bin/kppp -c 01019 freenet ohne Optausgang  12608  0.0  0.3  6600  812 ?        S    12:30   0:01 /opt/kde.1.1.2/bin/ktail
ausgang  12612  0.0  0.6 17760 1640 ?        S    12:30   0:01 konsole -vt_sz 60x18 -e /usr/local/bin/tail -f
ausgang  12633  0.0  0.1 17468  296 ?        S    12:30   0:00 kdeinit: dcopserver --nosid --suicide
ausgang  12636  0.0  0.1 17916  312 ?        S    12:30   0:00 kdeinit: klauncher
ausgang  12639  0.0  0.2 17820  668 ?        S    12:30   0:00 kdeinit: kded
ausgang  12643  0.0  0.0 17240  228 ?        S    12:30   0:00 kdeinit: Running...
ausgang  12644  0.0  0.0  1232  100 pts/0    S    12:30   0:00 /usr/local/bin/tail -f /usr/local/news/log/newsroot     13324  0.3  0.2  3028  636 ?        S    12:55   0:05 /usr/local/sbin/sshd
root     13327  9.2 32.1 83892 82544 ?       S    12:55   2:45 rsync --server --sender -vbulogDtpr --delete --root     13333  0.0  0.2  3056  716 ?        S    12:55   0:01 /usr/local/sbin/sshd
andreas  13337  0.0  0.3  2116  860 pts/1    S    12:55   0:00 -bash
andreas  13343  0.0  0.3  2528  792 pts/1    S    12:55   0:00 xosview
news     13711  0.0  0.1  1184  432 ?        S    13:16   0:00 sleep 600
andreas  13718  0.0  0.4  2756 1100 pts/1    R    13:24   0:00 ps -aux


free
             total       used       free     shared    buffers     cached
	     Mem:        256516     252152       4364          0     140560       6632
	     -/+ buffers/cache:     104960     151556
	     Swap:       131504      65552      65952
	     
	     
backup server

ps -aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1324  472 ?        S    Dec17   0:04 init [3]
root         2  0.0  0.0     0    0 ?        SW   Dec17   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Dec17   0:00 [ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SW   Dec17   0:13 [kswapd]
root         5  0.0  0.0     0    0 ?        SW   Dec17   0:00 [bdflush]
root         6  0.0  0.0     0    0 ?        SW   Dec17   0:10 [kupdated]
root         7  0.0  0.0     0    0 ?        SW   Dec17   0:00 [kreiserfsd]
root        70  0.0  0.0     0    0 ?        SW   Dec17   0:00 [eth1]
root        82  0.0  0.1  1636  664 ?        S    Dec17   0:00 /usr/sbin/syslogd
root        86  0.0  0.0  1376  400 ?        S    Dec17   0:00 /usr/sbin/klogd -c 1
at         111  0.0  0.0  1436  492 ?        S    Dec17   0:00 /usr/sbin/atd
root       116  0.0  0.1  1600  532 ?        S    Dec17   0:00 /usr/sbin/inetd
root       127  0.0  0.1  2564  712 ?        S    Dec17   0:00 /usr/local/sbin/sshd
daemon     148  0.0  0.1  2204  568 ?        S    Dec17   0:00 lpd Waiting
root       166  0.0  0.0  1332  504 ?        S    Dec17   0:00 /usr/sbin/crond
root       167  0.0  0.1  2620  824 ?        S    Dec17   0:00 sendmail: accepting connections
root       183  0.0  0.1  2268  556 tty1     S    Dec17   0:00 login -- root
root       185  0.0  0.0  1280  380 tty3     S    Dec17   0:00 /sbin/mingetty tty3
root       186  0.0  0.0  1280  380 tty4     S    Dec17   0:00 /sbin/mingetty tty4
root       187  0.0  0.0  1280  380 tty5     S    Dec17   0:00 /sbin/mingetty tty5
root       188  0.0  0.0  1280  380 tty6     S    Dec17   0:00 /sbin/mingetty tty6
root       893  0.0  0.1  2588  764 tty1     S    00:03   0:00 -bash
root      9011  0.0  0.1  2268  568 tty2     S    00:26   0:00 login -- root
root     22092  0.0  0.1  2656  764 tty2     S    07:58   0:00 -bash
root      2505  0.0  0.1  3896  560 tty2     S    08:02   0:00 mc
root      2506  0.0  0.0  1280  296 ?        S    08:02   0:00 cons.saver /dev/tty2
root      2507  0.0  0.1  2656  760 pts/0    S    08:02   0:00 bash -rcfile .bashrc
root      4322  0.0  0.1  1768  640 ?        S    08:04   0:00 /usr/sbin/timed -t -n maya.org
root      4328  0.0  0.1  2296  548 ?        S    08:04   0:00 /opt/kde-2.2/bin/kdm -debug 1
bin       5251  0.0  0.0  1336  308 ?        S    09:51   0:00 /sbin/portmap
root      5256  0.0  0.0  1488  444 ?        S    09:51   0:00 /usr/sbin/rpc.kmountd
root      5259  0.0  0.0     0    0 ?        SW   09:51   0:00 [rpciod]
root      5260  0.0  0.0     0    0 ?        SW   09:51   0:00 [lockd]
root      7034  2.5  1.6 52776 8508 ?        S    12:17   1:44 /usr/X11R6/bin/X -auth /var/lib/xdm/authfiles/Aroot      7035  0.0  0.1  3088  772 ?        S    12:17   0:00 -:0
root      7046  0.0  0.2  3528 1096 ?        S    12:17   0:00 /usr/X11R6/bin/xconsole -geometry 480x130-0-0 -andreas   7054  0.0  0.1  2188  680 ?        S    12:18   0:00 /bin/sh /usr/X11R6/bin/kde-cvs
andreas   7068  0.0  0.1  2192  680 ?        S    12:18   0:00 /bin/sh /opt/kde-2.2/bin/startkde
andreas   7078  0.0  0.6 17496 3552 ?        S    12:18   0:00 kdeinit: Running...
andreas   7081  0.0  0.7 17416 3672 ?        S    12:18   0:00 kdeinit: dcopserver --nosid
andreas   7084  0.0  0.8 18888 4616 ?        S    12:18   0:00 kdeinit: klauncher
andreas   7087  0.0  0.9 18592 4764 ?        S    12:18   0:00 kdeinit: kded
andreas   7100  0.0  0.9 21648 5092 ?        S    12:18   0:00 kdeinit: knotify
andreas   7101  0.0  0.6 13256 3440 ?        S    12:18   0:00 ksmserver --restore
andreas   7102  0.0  1.3 20308 6692 ?        S    12:18   0:03 kdeinit: kwin
andreas   7105  0.0  0.9 19688 5000 ?        S    12:18   0:00 kdeinit: kwrited
andreas   7106  0.0  0.9 19520 5116 ?        S    12:18   0:00 kdeinit: khotkeys
andreas   7108  0.0  1.6 21808 8636 ?        S    12:18   0:01 kdeinit: kdesktop
andreas   7109  0.0  0.0  1636  464 pts/1    S    12:18   0:00 /bin/cat
andreas   7113  0.0  0.4 18416 2140 ?        S    12:18   0:00 kwikdisk
andreas   7114  0.0  0.8 22080 4608 ?        S    12:18   0:03 kdeinit: kicker
andreas   7119  0.0  0.5 19404 2860 ?        S    12:18   0:00 kdeinit: klipper -icon klipper -miniicon klippeandreas   7120  0.2  1.9 21244 9916 ?        S    12:18   0:11 kdeinit: konsole -icon konsole -miniicon konsolandreas   7121  0.0  0.1  2628  904 pts/2    S    12:18   0:00 /bin/bash
andreas   7129  0.8  0.1  2224  848 pts/2    S    12:18   0:35 top
andreas   7131  0.0  0.1  2188  680 ?        S    12:18   0:00 /bin/sh /usr/local/mozilla/mozilla.sh -mail
andreas_  7133  0.0  0.1  2276  680 ?        S    12:18   0:00 /bin/sh /usr/local/mozilla/run-mozilla.sh /usr/andreas_  7138  2.4  5.6 60220 29132 ?       S    12:18   1:39 /usr/local/mozilla/mozilla-bin -mail
andreas_  7140  0.0  5.6 60220 29132 ?       S    12:18   0:00 /usr/local/mozilla/mozilla-bin -mail
andreas_  7141  0.0  5.6 60220 29132 ?       S    12:18   0:00 /usr/local/mozilla/mozilla-bin -mail
andreas_  7142  0.0  5.6 60220 29132 ?       S    12:18   0:00 /usr/local/mozilla/mozilla-bin -mail
andreas   7253  0.0  0.1  2192  680 ?        S    12:29   0:00 /bin/sh /usr/local/bin/internet
andreas   7255  0.0  0.2  3404 1056 ?        S    12:29   0:01 ssh ausgang@susi.maya.org export KDEDIR=/opt/kdandreas_  7403  0.0  0.6 16916 3208 ?        S    12:40   0:00 kdeinit: Running...
andreas_  7406  0.0  0.5 17432 2600 ?        S    12:40   0:00 kdeinit: dcopserver --nosid --suicide
andreas_  7409  0.0  0.5 18316 3020 ?        S    12:40   0:00 kdeinit: klauncher
andreas_  7412  0.0  0.9 19324 5104 ?        S    12:40   0:00 kdeinit: kded
andreas_  7420  0.0  0.9 18608 4824 ?        S    12:40   0:00 kdeinit: kcookiejar
andreas_  7422  0.0  0.4 12396 2348 ?        S    12:40   0:00 kdesud
andreas_  7469  0.0  0.7 17720 3912 ?        S    12:48   0:00 kdeinit: kio_http http /tmp/ksocket-andreas_n/kandreas_  7471  0.0  0.7 17732 3912 ?        S    12:48   0:00 kdeinit: kio_http http /tmp/ksocket-andreas_n/kandreas_  7477  0.0  0.7 17728 3912 ?        S    12:48   0:00 kdeinit: kio_http http /tmp/ksocket-andreas_n/kandreas_  7482  0.0  0.7 17724 3912 ?        S    12:49   0:00 kdeinit: kio_http http /tmp/ksocket-andreas_n/kandreas_  7495  0.0  0.7 17704 3812 ?        S    12:51   0:00 kdeinit: kio_http http /tmp/ksocket-andreas_n/kandreas_  7496  0.0  0.7 17704 3812 ?        S    12:51   0:00 kdeinit: kio_http http /tmp/ksocket-andreas_n/kandreas_  7497  0.0  0.7 17704 3812 ?        S    12:51   0:00 kdeinit: kio_http http /tmp/ksocket-andreas_n/kroot      7502  0.0  0.1  2688  960 pts/5    S    12:54   0:00 bash
root      7528  0.0  0.1  2688 1016 pts/5    S    12:55   0:00 bash
root      7529  5.1 12.8 157752 65852 pts/5  D    12:55   1:37 rsync --delete --ignore-errors -e ssh -avub --eroot      7530  0.1  0.1  3168  680 pts/5    S    12:55   0:02 ssh susi rsync --server --sender -vbulogDtpr --andreas   7533  0.4  0.3  3140 1556 pts/6    S    12:55   0:07 ssh susi.maya.org
andreas   7563  0.0  0.2  2720 1340 ?        S    13:10   0:00 xosview +n
andreas_  7590  0.0  5.6 60220 29132 ?       S    13:18   0:00 /usr/local/mozilla/mozilla-bin -mail
andreas   7591  0.0  0.2  2484 1112 ?        S    13:18   0:00 imapd
andreas   7604  0.1  0.3  2628 1580 pts/3    S    13:25   0:00 /bin/bash
andreas   7612  0.0  0.2  2180 1032 pts/3    S    13:25   0:00 /bin/sh /usr/bin/e VM
andreas   7613  0.7  0.3  4200 1940 pts/3    S    13:25   0:00 mcedit VM
andreas   7615  0.3  0.3  2628 1580 pts/7    S    13:26   0:00 /bin/bash
andreas   7624  0.0  0.2  3116 1284 pts/7    R    13:27   0:00 ps -aux

free
             total       used       free     shared    buffers     cached
	     Mem:        514368     509964       4404          0     322136      27468
	     -/+ buffers/cache:     160360     354008
	     Swap:       208836     135324      73512
--------------020608060407030908070009--

