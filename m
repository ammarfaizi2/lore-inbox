Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSFRFQE>; Tue, 18 Jun 2002 01:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317327AbSFRFQD>; Tue, 18 Jun 2002 01:16:03 -0400
Received: from mail14.speakeasy.net ([216.254.0.214]:42145 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S317326AbSFRFP7>; Tue, 18 Jun 2002 01:15:59 -0400
Subject: strange swap usage with ac branch of 2.4.19-pre9/10
From: Ed Sweetman <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-BWCTOQUbyVbQl276RWFj"
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Jun 2002 01:15:58 -0400
Message-Id: <1024377359.7801.38.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BWCTOQUbyVbQl276RWFj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


The only thing I have that gives any hint as to what is using memory is
/proc/meminfo and free .  

        total:    used:    free:  shared: buffers:  cached:
Mem:  660455424 653500416  6955008        0  5558272 56893440
Swap: 1091526656 48332800 1043193856
MemTotal:       644976 kB
MemFree:          6792 kB
MemShared:           0 kB
Buffers:          5428 kB
Cached:          40688 kB
SwapCached:      14872 kB
Active:          71176 kB
Inact_dirty:     26196 kB
Inact_clean:     14768 kB
Inact_target:    22428 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       644976 kB
LowFree:          6792 kB
SwapTotal:     1065944 kB
SwapFree:      1018744 kB
Committed_AS:   229088 kB

            total       used       free     shared    buffers     cached
Mem:        644976     638200      6776          0       7168      42560
-/+ buffers/cache:     588472      56504
Swap:      1065944      56624    1009320


now, usually it's people complaining about all this cache being used in
ram and their system swapping despite this cache.  But here it's
obviously a problem with buffers.  I get a gradual increase in buffers
as time goes by and after 2 days it is at what it is at now, after X
crashed.   I've restarted my normal array of programs I have running all
the time and ps and top both show very little memory being used by any
single program, nothing that could account for 560MB of buffers.  

So where do these buffers come from and how can I find out?  I'm
assuming it's a userlevel program causing all this buffer to be used but
then if that's the case, why does it not show up as being used by it in
ps ? 

closing X doesn't seem to release all the buffer or even much, so I
assume it's something running as a daemon (mysql or apache or whatever)
but then again, they are using almost no memory at all according to ps 


--=-BWCTOQUbyVbQl276RWFj
Content-Disposition: attachment; filename=ps-output
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ps-output; charset=ANSI_X3.4-1968

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1272  436 ?        S    Jun15   0:07 init [2]=20
root         2  0.0  0.0     0    0 ?        SW   Jun15   0:01 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Jun15   0:00 [ksoftirqd_C=
PU0]
root         4  0.0  0.0     0    0 ?        SW   Jun15   0:04 [kswapd]
root         5  0.0  0.0     0    0 ?        SW   Jun15   0:00 [bdflush]
root         6  0.0  0.0     0    0 ?        SW   Jun15   0:00 [kupdated]
root         7  0.0  0.0     0    0 ?        SW   Jun15   0:01 [kjournald]
root        36  0.0  0.0  1512  500 ?        S    Jun15   0:00 /sbin/devfsd=
 /dev
root        69  0.0  0.0     0    0 ?        SW   Jun15   0:00 [khubd]
root        89  0.0  0.0     0    0 ?        SW   Jun15   0:01 [msp3410 [au=
to]]
root       129  0.0  0.0     0    0 ?        SW   Jun15   0:03 [kjournald]
root       130  0.0  0.0     0    0 ?        SW   Jun15   0:00 [kjournald]
root       131  0.0  0.0     0    0 ?        SW   Jun15   0:00 [kjournald]
root       132  0.0  0.0     0    0 ?        SW   Jun15   0:01 [kjournald]
root       133  0.0  0.0     0    0 ?        SW   Jun15   0:01 [kjournald]
root       134  0.0  0.0     0    0 ?        SW   Jun15   0:00 [kjournald]
root       135  0.0  0.0     0    0 ?        SW   Jun15   0:00 [kjournald]
root       136  0.0  0.0     0    0 ?        SW   Jun15   0:01 [kjournald]
root       137  0.0  0.0     0    0 ?        SW   Jun15   0:00 [kjournald]
daemon     160  0.0  0.0  1384  320 ?        S    Jun15   0:00 /sbin/portma=
p
root       240  0.0  0.0  2036  580 ?        S    Jun15   0:00 /sbin/syslog=
d
root       243  0.0  0.0  1968  396 ?        S    Jun15   0:00 /sbin/klogd
root       327  0.0  0.0  1552  448 ?        S    Jun15   0:00 /usr/sbin/gp=
m -m /dev/usbmouse -t imps2
root       333  0.0  0.0  1996  500 ?        S    Jun15   0:00 /usr/sbin/in=
etd
root       355  0.0  0.1  2180  836 ?        S    Jun15   0:00 /bin/sh /usr=
/bin/safe_mysqld
mysql      392  0.0  0.1 37660  652 ?        S    Jun15   0:00 /usr/sbin/my=
sqld --basedir=3D/usr --datadir=3D/var/lib/mysql --user=3Dmysql --pid-file=
=3D/var/run/mysqld/mysqld.pid --skip-locking
mysql      394  0.0  0.1 37660  652 ?        S    Jun15   0:00 /usr/sbin/my=
sqld --basedir=3D/usr --datadir=3D/var/lib/mysql --user=3Dmysql --pid-file=
=3D/var/run/mysqld/mysqld.pid --skip-locking
mysql      395  0.0  0.1 37660  652 ?        S    Jun15   0:00 /usr/sbin/my=
sqld --basedir=3D/usr --datadir=3D/var/lib/mysql --user=3Dmysql --pid-file=
=3D/var/run/mysqld/mysqld.pid --skip-locking
mysql      396  0.0  0.1 37660  652 ?        S    Jun15   0:00 /usr/sbin/my=
sqld --basedir=3D/usr --datadir=3D/var/lib/mysql --user=3Dmysql --pid-file=
=3D/var/run/mysqld/mysqld.pid --skip-locking
root       407  0.0  0.1  2764  716 ?        S    Jun15   0:00 /usr/sbin/nm=
bd -D
root       409  0.0  0.0  3764  448 ?        S    Jun15   0:00 /usr/sbin/sm=
bd -D
root       415  0.0  0.0  2684  452 ?        S    Jun15   0:00 /usr/sbin/ss=
hd
root       418  0.0  0.3  1976 1968 ?        SL   Jun15   0:00 /usr/sbin/nt=
pd
nobody     422  0.0  0.0  2624  600 ?        S    Jun15   0:00 proftpd (acc=
epting connections)
daemon     425  0.0  0.0  1384  468 ?        S    Jun15   0:00 /usr/sbin/at=
d
root       428  0.0  0.0  1652  540 ?        S    Jun15   0:00 /usr/sbin/cr=
on
root       432  0.0  0.1  2240  912 vc/1     S    Jun15   0:00 -bash
root       433  0.0  0.0  1256  396 vc/2     S    Jun15   0:00 /sbin/getty =
38400 tty2
root       434  0.0  0.0  1256  396 vc/3     S    Jun15   0:00 /sbin/getty =
38400 tty3
root       435  0.0  0.0  1256  396 vc/4     S    Jun15   0:00 /sbin/getty =
38400 tty4
root       436  0.0  0.0  1256  396 vc/5     S    Jun15   0:00 /sbin/getty =
38400 tty5
root       437  0.0  0.0  1256  396 vc/6     S    Jun15   0:00 /sbin/getty =
38400 tty6
root      8678  0.0  0.0  5648  620 ?        S    Jun17   0:00 /usr/local/a=
pache/bin/httpd
www-data  8679  0.0  0.1  8392  668 ?        S    Jun17   0:00 /usr/local/a=
pache/bin/httpd
www-data  8680  0.0  0.1  8428  656 ?        S    Jun17   0:00 /usr/local/a=
pache/bin/httpd
www-data  8681  0.0  0.1  8288  648 ?        S    Jun17   0:00 /usr/local/a=
pache/bin/httpd
www-data  8682  0.0  0.1  8388  676 ?        S    Jun17   0:00 /usr/local/a=
pache/bin/httpd
www-data  8683  0.0  0.1  8492  696 ?        S    Jun17   0:00 /usr/local/a=
pache/bin/httpd
www-data  8695  0.0  0.1  8456  664 ?        S    Jun17   0:00 /usr/local/a=
pache/bin/httpd
www-data  8965  0.0  0.1  8388  648 ?        S    Jun17   0:00 /usr/local/a=
pache/bin/httpd
www-data 11351  0.0  0.1  8108  704 ?        S    Jun17   0:00 /usr/local/a=
pache/bin/httpd
www-data 11381  0.0  0.0     0    0 ?        Z    Jun17   0:00 [httpd <defu=
nct>]
root      5705  0.0  0.1  2304  680 vc/1     S    00:28   0:00 /usr/bin/per=
l ./decibel.pl
root      5710  0.0  0.1  2032  756 vc/1     S    00:28   0:00 /bin/sh /usr=
/bin/X11/startx
root      5711  0.0  0.0  2184  548 vc/1     S    00:28   0:00 xinit -- -dp=
i 100
root      5712  0.8  1.9 83636 12740 ?       S<   00:28   0:25 X :0 -dpi 10=
0
root      5717  0.0  0.1  2028  748 vc/1     S    00:28   0:00 sh /root/.xi=
nitrc
root      5718  0.0  0.4  6656 2940 vc/1     S    00:28   0:01 sawfish
root      5722  0.0  0.3  8100 2412 tty1     S    00:28   0:00 rep /usr/lib=
/sawfish/1.0.1/i386-pc-linux-gnu/sawfish-menu
root      5729  0.0  0.3  5976 1996 vc/1     S    00:28   0:00 /usr/bin/Ete=
rm
root      5732  0.0  0.1  2232 1092 pts/0    S    00:28   0:00 -bash
root      5740  0.0  0.3  6064 2288 vc/1     S    00:28   0:00 /usr/bin/Ete=
rm
root      5743  0.0  0.1  2236 1096 pts/1    S    00:28   0:00 -bash
root      5748  0.0  0.2  5976 1732 vc/1     S    00:28   0:00 /usr/bin/Ete=
rm
root      5752  0.0  0.1  2228  944 pts/2    S    00:28   0:00 -bash
root      5759  0.0  0.2  5916 1860 vc/1     S    00:28   0:01 /usr/bin/Ete=
rm
root      5762  0.0  0.1  2228  944 pts/3    S    00:28   0:00 -bash
root      5773  0.0  0.2  5740 1896 vc/1     S    00:28   0:00 /usr/bin/Ete=
rm
root      5776  0.0  0.1  2228  944 pts/4    S    00:28   0:00 -bash
root      5796  0.0  0.2  6336 1760 vc/1     S    00:28   0:00 /usr/bin/Ete=
rm
root      5799  0.0  0.1  2228  944 pts/5    S    00:28   0:00 -bash
root      5808  0.0  0.5 13368 3284 vc/1     S    00:28   0:00 licq -p gtk_=
gui
root      5809  0.0  0.5 13368 3284 vc/1     S    00:28   0:00 licq -p gtk_=
gui
root      5810  0.0  0.5 13368 3284 vc/1     S    00:28   0:00 licq -p gtk_=
gui
root      5811  0.0  0.5 13368 3284 vc/1     S    00:28   0:00 licq -p gtk_=
gui
root      5812  0.0  0.5 13368 3284 vc/1     S    00:28   0:00 licq -p gtk_=
gui
root      5826  0.0  0.7  9400 4640 vc/1     S    00:29   0:01 gaim
safemode  5857  0.0  0.1  2216  944 pts/5    S    00:29   0:00 bash
safemode  5861  0.0  0.2  2876 1396 pts/5    S    00:29   0:00 epic diemen.=
nl.eu.undernet.org
safemode  5875  0.0  0.2  4520 1768 ?        S    00:29   0:00 xterm -geome=
try 80x24 -reverse -bg black -fg white -fa lucida console -fs 8 -e /usr/loc=
al/libexec/wserv localhost 37758
safemode  5876  0.0  0.0  2004  576 pts/6    S    00:29   0:00 /usr/local/l=
ibexec/wserv localhost 37758
safemode  5877  0.0  0.2  4520 1780 ?        S    00:29   0:00 xterm -geome=
try 80x24 -reverse -bg black -fg white -fa lucida console -fs 8 -e /usr/loc=
al/libexec/wserv localhost 37760
safemode  5878  0.0  0.0  2004  576 pts/7    S    00:29   0:00 /usr/local/l=
ibexec/wserv localhost 37760
safemode  5879  0.0  0.2  4520 1896 ?        S    00:29   0:00 xterm -geome=
try 80x24 -reverse -bg black -fg white -fa lucida console -fs 8 -e /usr/loc=
al/libexec/wserv localhost 37762
safemode  5880  0.0  0.0  2004  576 pts/8    S    00:29   0:00 /usr/local/l=
ibexec/wserv localhost 37762
root      5897  0.0  0.3  5984 2492 pts/1    S    00:30   0:00 gprocmeter3
root      5912  0.0  0.1  1772  660 pts/3    S    00:30   0:02 telnet icebo=
x 1111
root      5952  0.0  0.0  1772  616 pts/4    S    00:31   0:00 telnet icebo=
x 1111
root      5967  0.0  0.1  2424  740 pts/2    S    00:31   0:00 alsamixer
root      5975  0.0  0.6 26812 4308 vc/1     S    00:31   0:00 freeamp
root      5977  0.0  0.6 26812 4308 vc/1     S    00:31   0:00 freeamp
root      5978  0.0  0.6 26812 4308 vc/1     S    00:31   0:00 freeamp
root      5979  0.0  0.6 26812 4308 vc/1     S    00:31   0:00 freeamp
root      5980  0.0  0.6 26812 4308 vc/1     S    00:31   0:00 freeamp
root      5983  0.0  0.6 26812 4308 vc/1     S    00:31   0:00 freeamp
root      5985  0.0  0.6 26812 4308 vc/1     S    00:31   0:00 freeamp
root      6015  0.0  1.0 18736 6888 vc/1     S    00:32   0:01 evolution
root      6018  0.0  0.1  3312 1108 ?        S    00:32   0:00 oafd --ac-ac=
tivate --ior-output-fd=3D9
root      6023  0.0  0.5 20664 3592 ?        S    00:32   0:00 /usr/lib/evo=
lution/wombat --oaf-activate-iid=3DOAFIID:Bonobo_Moniker_wombat_Factory --o=
af-ior-fd=3D10
root      6029  0.0  0.4  9716 3020 ?        S    00:32   0:00 bonobo-monik=
er-xmldb --oaf-activate-iid=3DOAFIID:Bonobo_Moniker_xmldb_Factory --oaf-ior=
-fd=3D12
root      6033  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6037  0.0  0.6 20560 4196 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-calendar --oaf-activate-iid=3DOAFIID:GNOME_Evolution_Calen=
dar_ShellComponent --oaf-ior-fd=3D15
root      6042  0.0  0.5 17276 3384 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-alarm-notify --oaf-activate-iid=3DOAFIID:GNOME_Evolution_C=
alendar_AlarmNotify_Factory --oaf-ior-fd=3D16
root      6048  0.2  2.5 39092 16476 ?       S    00:32   0:05 /usr/lib/evo=
lution/evolution-mail --oaf-activate-iid=3DOAFIID:GNOME_Evolution_Mail_Shel=
lComponent --oaf-ior-fd=3D18
root      6053  0.0  0.7 19952 5104 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-addressbook --oaf-activate-iid=3DOAFIID:GNOME_Evolution_Ad=
dressbook_ShellComponent --oaf-ior-fd=3D19
root      6058  0.0  2.5 39092 16476 ?       S    00:32   0:00 /usr/lib/evo=
lution/evolution-mail --oaf-activate-iid=3DOAFIID:GNOME_Evolution_Mail_Shel=
lComponent --oaf-ior-fd=3D18
root      6059  0.0  2.5 39092 16476 ?       S    00:32   0:00 /usr/lib/evo=
lution/evolution-mail --oaf-activate-iid=3DOAFIID:GNOME_Evolution_Mail_Shel=
lComponent --oaf-ior-fd=3D18
root      6061  0.0  2.5 39092 16476 ?       S    00:32   0:00 /usr/lib/evo=
lution/evolution-mail --oaf-activate-iid=3DOAFIID:GNOME_Evolution_Mail_Shel=
lComponent --oaf-ior-fd=3D18
root      6062  0.0  2.5 39092 16476 ?       S    00:32   0:02 /usr/lib/evo=
lution/evolution-mail --oaf-activate-iid=3DOAFIID:GNOME_Evolution_Mail_Shel=
lComponent --oaf-ior-fd=3D18
root      6089  0.0  0.1  2996 1240 ?        S    00:32   0:00 /usr/bin/gco=
nfd-1 22
root      6090  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6091  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6092  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6093  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6094  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6095  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6096  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6097  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6098  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6099  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6100  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6101  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6102  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6103  0.0  0.8 46132 5564 ?        S    00:32   0:00 /usr/lib/evo=
lution/evolution-executive-summary --oaf-activate-iid=3DOAFIID:GNOME_Evolut=
ion_Summary_ShellComponent --oaf-ior-fd=3D14
root      6111  0.1  1.8 36932 12104 tty1    S    00:32   0:04 /usr/lib/moz=
illa/mozilla-bin
root      6162  0.0  1.8 36932 12104 tty1    S    00:32   0:00 /usr/lib/moz=
illa/mozilla-bin
root      6163  0.0  1.8 36932 12104 tty1    S    00:32   0:00 /usr/lib/moz=
illa/mozilla-bin
root      6164  0.0  1.8 36932 12104 tty1    S    00:32   0:00 /usr/lib/moz=
illa/mozilla-bin
root      6166  0.0  1.8 36932 12104 tty1    S    00:32   0:00 /usr/lib/moz=
illa/mozilla-bin
root      6204  0.0  0.2  5704 1744 vc/1     S    00:33   0:00 xawtv -nodga=
 -xv
root      6381  0.7  0.9 17572 6264 ?        S    00:37   0:16 gnome-gtkhtm=
l-editor --oaf-activate-iid=3DOAFIID:GNOME_GtkHTML_Editor_Factory --oaf-ior=
-fd=3D22
root      7801  0.0  2.5 39092 16476 ?       S    01:07   0:00 /usr/lib/evo=
lution/evolution-mail --oaf-activate-iid=3DOAFIID:GNOME_Evolution_Mail_Shel=
lComponent --oaf-ior-fd=3D18
root      8159  0.0  0.0  1528  508 vc/1     S    01:15   0:00 sleep 3s
root      8160  0.0  0.2  3348 1540 pts/1    R    01:15   0:00 ps aux

--=-BWCTOQUbyVbQl276RWFj--

