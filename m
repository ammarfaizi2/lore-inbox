Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbSLKXsB>; Wed, 11 Dec 2002 18:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbSLKXsB>; Wed, 11 Dec 2002 18:48:01 -0500
Received: from [209.223.116.56] ([209.223.116.56]:57476 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267345AbSLKXra> convert rfc822-to-8bit; Wed, 11 Dec 2002 18:47:30 -0500
From: "Steven Roussey" <sroussey@network54.com>
To: <akpm@digeo.com>
Cc: <robm@fastmail.fm>, <linux-kernel@vger.kernel.org>
Subject: RE: Strange load spikes on 2.4.19 kernel
Date: Wed, 11 Dec 2002 15:54:57 -0800
Message-ID: <001d01c2a170$b72639e0$026fa8c0@wehohome>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <3DF7C5B2.D9E0249C@digeo.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for looking at this.

> Tried mounting all filesystems `-o noatime'?

Did that a while back.

> Is there much disk write activity?  

No:
# iostat -k
Linux 2.4.18-18.7.xsmp (morpheus.network54.com)         12/11/2002

avg-cpu:  %user   %nice    %sys   %idle
          43.70    0.00   14.87   41.43

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
dev3-0            6.36        36.76        28.33    2588238    1994376

>What journalling mode are you using?

I remember just using the default. How can I tell?

# mount
/dev/hda1 on / type ext3 (rw,noatime)
none on /proc type proc (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /dev/shm type tmpfs (rw)
/dev/hda3 on /usr type ext3 (rw,noatime)

> The output of `ps aux' during a stall would be interesting,
> as would the `vmstat 1' ouptut.

If it helps, I recompiled Apache to have a higher limit on the number of
child servers that it can have running. I don't know why it was 256 (I
changed it to 512), unless the kernel has issues with lots of processes. But
what is 'lots'?

It is really odd. The idle % goes way up and then drops to nothing while
cpu(r) goes way high relative to normal.

This is from a mid-afternoon spike (load from 3 to 48):

#vmstat 1
...
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 6  0  0   7444  87024  13980 158236   0   0     0    16 3491  2510  19  18
63
 0  0  0   7444  80104  13876 158340   0   0     0     0 2224  1538  12   7
81
 1  0  0   7444  72860  13808 158408   0   0     0     0 2912  1759  16  11
73
 0  0  0   7444  67388  13768 158448   0   0     0     0 2025  1348  10   6
84
 0  0  0   7444  64156  13756 158460   0   0     0     0 1823  1142   8   6
86
 0  0  0   7444  62908  13756 158460   0   0     0     0 1444   515   6   6
87
 1  0  0   7444  62904  13744 158472   0   0     0     0 1073    75   1   1
98
 0  0  0   7444  62904  13672 158544   0   0     0     0  880    49   0   1
98
 0  0  0   7444  61788  13668 158548   0   0     0     0 1450   452   6   3
91
 3  0  1   7444  58904  13660 158556   0   0     0     0 3104  1386  14   8
78
 0  0  0   7444  58252  13656 158568   0   0     0    16 1481   628   6   7
87
 0  0  0   7444  54584  13648 158576   0   0     0     0 3188  2287  17   6
77
350  0  2   7444  50044  13652 158580   0   0    12     0 8759  3995  50  18
31
293 27  2   7444  41456  13644 158588   0   0     4     0 8576  3644  78  22
0
297  0  2   7444  38076  13640 158600   0   0     4    16 13163  6299  77
23   0
289  0  2   7444  36600  13616 158624   0   0     4     0 9035  4545  73  26
0
255  0  2   7444  36740  13624 158632   0   0    16     0 9827  4974  75  25
0
289  0  2   7444  36456  13604 158676   0   0    28     0 10030  4619  77
22   0
292  0  2   7444  35036  13596 158684   0   0     4     0 9064  4434  75  25
0
236  0  2   7444  32576  13656 158688   0   0    60    32 14771  7496  79
21   0
151  0  2   7444  32384  13652 158692   0   0     0     0 8670  5028  69  31
0
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
125  0  2   7444  31272  13652 158700   0   0     8     0 8825  4676  79  21
0
98  0  2   7444  30340  13648 158712   0   0    12     0 9248  5197  77  23
0
25  0  0   7444  32928  13664 158724   0   0     0   132 8649  4629  70  28
2
58  0  2   7444  32960  13672 158744   0   0    28    60 8016  4156  62  18
19
13  0  1   7444  34020  13668 158756   0   0     8     0 8759  4982  73  27
0
 1  0  0   7444  33696  13668 158776   0   0    20     0 8252  5977  65  18
17
 5  0  0   7444  34952  13668 158776   0   0     0     0 7625  5618  50  17
33
 4  0  0   7444  34752  13644 158800   0   0     0     0 8869  5982  70  20
10
 5  0  0   7444  39588  13656 158856   0   0    68     0 7054  5321  46  17
37
 1  0  0   7444  40472  13640 158872   0   0     0     0 6915  5282  50  20
30
 4  0  1   7444  41892  13640 158872   0   0     0     0 6286  4728  39  14
47
22  0  1   7444  41936  13612 158920   0   0    20     0 6323  4507  44  17
39
 5  0  0   7444  43292  13612 158936   0   0    12    16 7257  5086  53  18
28
 6  0  2   7444  44532  13604 158976   0   0    36     0 7306  5384  53  21
25
 3  0  0   7444  43952  13596 158988   0   0     4     0 7759  5077  50  46
4
 0  0  0   7444  45188  13684 158980   0   0     0   448 7696  5710  59  25
16 


## ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1416  456 ?        S    Dec10   0:06 init [3]
root         2  0.0  0.0     0    0 ?        SW   Dec10   0:00
[migration_CPU0]
root         3  0.0  0.0     0    0 ?        SW   Dec10   0:00
[migration_CPU1]
root         4  0.0  0.0     0    0 ?        SW   Dec10   0:00 [keventd]
root         5  0.0  0.0     0    0 ?        RWN  Dec10   0:01
[ksoftirqd_CPU0]
root         6  0.0  0.0     0    0 ?        RWN  Dec10   0:01
[ksoftirqd_CPU1]
root         7  0.2  0.0     0    0 ?        SW   Dec10   3:29 [kswapd]
root         8  0.0  0.0     0    0 ?        SW   Dec10   0:00 [bdflush]
root         9  0.0  0.0     0    0 ?        SW   Dec10   0:00 [kupdated]
root        10  0.0  0.0     0    0 ?        SW   Dec10   0:00 [mdrecoveryd]
root        14  0.0  0.0     0    0 ?        SW   Dec10   0:13 [kjournald]
root        92  0.0  0.0     0    0 ?        SW   Dec10   0:00 [khubd]
root       182  0.0  0.0     0    0 ?        SW   Dec10   0:00 [kjournald]
root       798  0.0  0.0  1476  528 ?        S    Dec10   0:03 syslogd -m 0
root       803  0.0  0.0  2136  492 ?        S    Dec10   0:00 klogd -2
rpc        823  0.0  0.0  1568  604 ?        S    Dec10   0:00 portmap
rpcuser    851  0.0  0.0  1600  596 ?        S    Dec10   0:00 rpc.statd
root      1002  0.0  0.1  3268 1216 ?        S    Dec10   0:00
/usr/sbin/sshd
root      1035  0.0  0.0  2316  704 ?        S    Dec10   0:00 xinetd
-stayalive -reuse -pidfile /var/run/xinetd.pid
root      1076  0.0  0.2  5304 1644 ?        S    Dec10   0:03 sendmail:
accepting connections
root      1107  0.0  0.0  1592  644 ?        S    Dec10   0:00 crond
xfs       1161  0.0  0.0  4564  664 ?        S    Dec10   0:00 xfs -droppriv
-daemon
daemon    1197  0.0  0.0  1448  488 ?        S    Dec10   0:00 /usr/sbin/atd
named     1232  0.0  0.3 13900 2528 ?        S    Dec10   0:00 named -u
named
named     1234  0.0  0.3 13900 2528 ?        S    Dec10   0:00 named -u
named
named     1235  0.0  0.3 13900 2528 ?        S    Dec10   0:59 named -u
named
named     1236  0.0  0.3 13900 2528 ?        S    Dec10   0:58 named -u
named
named     1237  0.0  0.3 13900 2528 ?        S    Dec10   0:00 named -u
named
named     1238  0.0  0.3 13900 2528 ?        S    Dec10   0:25 named -u
named
root      1249  0.0  0.1  5956 1256 ?        S    Dec10   0:01 /usr/bin/perl
/usr/libexec/webmin/miniserv.pl /etc/webmin/mini
root      1253  0.0  0.0  1388  368 tty1     S    Dec10   0:00
/sbin/mingetty tty1
root      1254  0.0  0.0  1388  368 tty2     S    Dec10   0:00
/sbin/mingetty tty2
root      1255  0.0  0.0  1388  368 tty3     S    Dec10   0:00
/sbin/mingetty tty3
root      1256  0.0  0.0  1388  368 tty4     S    Dec10   0:00
/sbin/mingetty tty4
root      1257  0.0  0.0  1388  368 tty5     S    Dec10   0:00
/sbin/mingetty tty5
root      1258  0.0  0.0  1388  368 tty6     S    Dec10   0:00
/sbin/mingetty tty6
root      6940  0.0  0.2  6712 1788 ?        S    Dec10   0:00
/usr/sbin/sshd
root      6944  0.0  0.1  2556 1176 pts/1    S    Dec10   0:00 -bash
root     29549  0.0  0.2  6664 2076 ?        S    13:46   0:00
/usr/sbin/sshd
root     29552  0.0  0.1  2528 1352 pts/0    S    13:46   0:00 -bash
root     29622  0.0  0.2  4940 1892 ?        S    13:47   0:00 smbd -D
root     29627  0.0  0.2  3920 1740 ?        S    13:47   0:02 nmbd -D
root     29628  0.0  0.1  3872 1500 ?        S    13:47   0:00 nmbd -D
root     29929  0.0  0.2  3360 1668 pts/0    S    13:53   0:00 ssh 10.1.1.10
root     31539  0.0  0.3  6348 2568 ?        S    14:56   0:00 sendmail:
./gB9LXsY03345 hotmail.co.uk.: user open
root     32124  0.0  0.6 41352 4648 ?        S    15:19   0:00
/usr/local/apache/bin/httpd -DSSL
500      32125  0.3  1.2 42140 9484 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32126  0.3  1.1 42092 9228 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32127  0.3  1.2 41956 9272 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32128  0.3  1.2 42056 9348 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32129  0.3  1.2 41976 9424 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32130  0.3  1.2 42064 9492 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32131  0.4  1.1 41956 9008 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32132  0.2  1.1 42352 9196 ?        S    15:19   0:04
/usr/local/apache/bin/httpd -DSSL
500      32133  0.3  1.2 42076 9396 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32134  0.1  1.1 42044 9080 ?        S    15:19   0:02
/usr/local/apache/bin/httpd -DSSL
500      32135  0.3  1.2 42064 9444 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32136  0.3  1.2 42084 9336 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32137  0.3  1.2 42032 9388 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32138  0.3  1.1 42036 8916 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32139  0.3  1.2 42072 9376 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32140  0.2  1.2 42020 9356 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32141  0.5  1.3 43344 10616 ?       R    15:19   0:08
/usr/local/apache/bin/httpd -DSSL
500      32142  0.3  1.1 42016 9140 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32143  0.4  1.2 42152 9580 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32144  0.1  1.2 42436 9372 ?        R    15:19   0:02
/usr/local/apache/bin/httpd -DSSL
500      32145  0.3  1.2 42084 9856 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32146  0.3  1.2 41960 9500 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32147  0.3  1.1 41992 9048 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32148  0.3  1.2 42092 9400 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32149  0.1  1.1 41888 8912 ?        R    15:19   0:03
/usr/local/apache/bin/httpd -DSSL
500      32150  0.3  1.1 41944 9224 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32151  0.3  1.2 42140 9352 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32152  0.3  1.2 42096 9556 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32153  0.3  1.2 42160 9528 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32154  0.4  1.2 41964 9844 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32155  0.2  1.1 42020 8860 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32156  0.3  1.2 42244 9472 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32157  0.3  1.1 42064 9048 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32158  0.3  1.1 42020 9072 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32159  0.3  1.2 42128 9748 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32160  0.3  1.2 42092 9384 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32161  0.3  1.1 42160 9244 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32162  0.3  1.2 41992 9348 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32163  0.3  1.2 42116 9416 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32164  0.3  1.1 42076 9240 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32165  0.3  1.1 41800 8980 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32166  0.4  1.1 41976 9008 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32167  0.3  1.1 41968 9236 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32168  0.3  1.1 41924 8908 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32169  0.3  1.2 42036 9368 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32170  0.3  1.2 42048 9284 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32171  0.3  1.2 41916 9580 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32172  0.3  1.1 41996 8916 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32173  0.4  1.2 42168 9328 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32174  0.3  1.2 41976 9432 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32175  0.3  1.1 41988 8912 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32176  0.1  1.1 41948 8752 ?        R    15:19   0:02
/usr/local/apache/bin/httpd -DSSL
500      32177  0.3  1.2 42096 9544 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32178  0.3  1.2 42028 9304 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32179  0.3  1.1 42068 9168 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32180  0.3  1.2 41936 9392 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32181  0.3  1.2 42004 9700 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32182  0.3  1.1 41976 9196 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32183  0.3  1.2 42060 9796 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32184  0.4  1.1 42036 8888 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32185  0.3  1.2 42232 9824 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32186  0.3  1.1 42068 9084 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32187  0.4  1.1 42056 8900 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32188  0.3  1.2 41932 9488 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32189  0.3  1.1 42016 9112 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32190  0.3  1.1 42000 9036 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32191  0.2  1.1 41904 8980 ?        S    15:19   0:03
/usr/local/apache/bin/httpd -DSSL
500      32192  0.3  1.1 42112 9176 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32193  0.3  1.1 42044 9184 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32194  0.3  1.1 42016 9184 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32195  0.3  1.2 41916 9428 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32196  0.2  1.2 42076 9348 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32197  0.3  1.1 41952 8984 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32198  0.3  1.2 42128 9272 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32199  0.3  1.1 42092 9048 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32200  0.3  1.2 42036 9464 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32201  0.3  1.2 42024 9312 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32202  0.3  1.1 41988 8868 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32203  0.3  1.2 41944 9364 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32204  0.3  1.2 42128 9392 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32205  0.3  1.1 41888 9248 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32206  0.3  1.2 42016 9580 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32207  0.3  1.2 42360 9344 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32208  0.2  1.1 41984 9152 ?        R    15:19   0:04
/usr/local/apache/bin/httpd -DSSL
500      32209  0.3  1.2 42016 9516 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32210  0.3  1.2 41956 9472 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32211  0.4  1.2 42012 9700 ?        S    15:19   0:08
/usr/local/apache/bin/httpd -DSSL
500      32212  0.3  1.2 42092 9600 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32213  0.3  1.2 42012 9688 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32214  0.3  1.1 42028 9008 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32215  0.3  1.1 42028 9168 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32216  0.3  1.2 42116 9304 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32217  0.3  1.1 42132 8820 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32218  0.3  1.1 42012 9256 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32219  0.3  1.1 41956 9072 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32220  0.3  1.1 41984 9220 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32221  0.3  1.1 42012 9180 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32222  0.3  1.1 42244 9244 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32223  0.3  1.1 42044 9236 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32224  0.3  1.1 41896 9140 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32225  0.4  1.1 42088 8912 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32226  0.2  1.1 42088 8792 ?        S    15:19   0:04
/usr/local/apache/bin/httpd -DSSL
500      32227  0.3  1.2 42048 9336 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32228  0.3  1.1 42140 8864 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32229  0.1  1.1 41876 8520 ?        S    15:19   0:02
/usr/local/apache/bin/httpd -DSSL
500      32230  0.3  1.1 41916 9204 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32231  0.3  1.2 42308 9568 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32232  0.3  1.2 42084 9316 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32233  0.3  1.2 42084 9824 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32234  0.3  1.2 42008 9340 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32235  0.3  1.2 42100 9668 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32236  0.3  1.1 41976 9024 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32237  0.3  1.1 41960 9104 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32238  0.3  1.2 42124 9344 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32239  0.3  1.2 42140 9608 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32240  0.3  1.2 41948 9360 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32241  0.4  1.2 42104 9860 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32242  0.3  1.1 42072 9224 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32243  0.3  1.1 42112 9252 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32244  0.3  1.2 42076 9380 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32245  0.3  1.1 41924 8912 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32246  0.3  1.1 42028 8700 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32247  0.3  1.1 42084 9252 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32248  0.3  1.1 41916 8864 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32249  0.4  1.2 42164 9884 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32250  0.3  1.2 42292 9424 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32251  0.3  1.1 42056 9000 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32252  0.4  1.2 42140 9704 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32253  0.3  1.2 42004 9396 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32254  0.3  1.1 41948 9008 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32255  0.3  1.1 42024 8988 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32256  0.3  1.1 42104 9244 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32257  0.3  1.2 42148 9628 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32258  0.3  1.2 42232 9328 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32259  0.3  1.2 42104 9644 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32260  0.3  1.1 42064 9224 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32261  0.3  1.1 41940 8924 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32262  0.3  1.1 41972 9224 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32263  0.3  1.2 42068 9488 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32264  0.3  1.2 41940 9396 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32265  0.3  1.1 41928 9240 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32266  0.3  1.1 42172 9228 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32267  0.3  1.1 41952 9172 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32268  0.1  1.1 41992 8756 ?        R    15:19   0:02
/usr/local/apache/bin/httpd -DSSL
500      32269  0.3  1.1 41980 9140 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32270  0.3  1.2 41948 9284 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32271  0.3  1.2 42064 9296 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32272  0.3  1.2 42104 9352 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32273  0.3  1.1 42040 9244 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32274  0.3  1.1 42064 9048 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32275  0.3  1.2 42112 9796 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32276  0.3  1.2 42056 9304 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32277  0.3  1.2 41920 9340 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32278  0.3  1.2 42060 9332 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32279  0.3  1.1 42188 9180 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32280  0.3  1.1 41944 9048 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32281  0.3  1.1 42024 8512 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32282  0.3  1.2 42292 9400 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32283  0.3  1.1 41948 8840 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32284  0.3  1.2 42188 9396 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32285  0.3  1.2 42116 9792 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32286  0.3  1.1 41936 9100 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32287  0.3  1.2 41964 9420 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32288  0.3  1.1 41996 9260 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32289  0.3  1.1 42024 9156 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32290  0.3  1.2 42076 9320 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32291  0.3  1.1 42048 9036 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32292  0.3  1.1 42040 9012 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32293  0.3  1.1 42100 9184 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32294  0.3  1.2 42072 9500 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32295  0.3  1.1 41952 9204 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32296  0.1  1.0 41932 8404 ?        R    15:19   0:01
/usr/local/apache/bin/httpd -DSSL
500      32297  0.3  1.1 42008 9164 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32298  0.3  1.2 42016 9312 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32299  0.3  1.2 42032 9696 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32300  0.3  1.2 41936 9268 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32301  0.3  1.2 42088 9432 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32302  0.3  1.1 41912 9020 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32303  0.3  1.1 41888 9088 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32304  0.3  1.1 42032 8984 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32305  0.3  1.2 42128 9576 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32306  0.3  1.1 42008 8840 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32307  0.3  1.2 42012 9404 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32308  0.3  1.2 42092 9372 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32309  0.4  1.2 42340 9460 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32310  0.3  1.1 41988 9264 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32311  0.3  1.1 41996 9184 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32312  0.3  1.1 42200 8808 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32313  0.3  1.1 41968 8952 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32314  0.3  1.1 42224 9108 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32315  0.3  1.2 42400 9596 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32316  0.3  1.2 42500 9708 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32317  0.3  1.1 42016 8820 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32318  0.3  1.1 42048 8876 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32319  0.3  1.2 42064 9568 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32320  0.3  1.2 41920 9544 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32321  0.4  1.1 42108 9064 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32322  0.3  2.0 48804 15572 ?       S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32323  0.3  1.2 42176 9368 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32324  0.3  1.2 42180 9460 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32325  0.3  1.1 41976 8932 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32326  0.3  1.2 42216 9420 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32327  0.3  1.1 42008 9172 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32328  0.3  1.2 42116 9436 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32329  0.3  1.2 42416 9280 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32330  0.4  1.1 42032 8800 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32331  0.3  1.1 42036 9184 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32332  0.4  1.1 41972 9260 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32333  0.2  1.2 42004 9268 ?        S    15:19   0:03
/usr/local/apache/bin/httpd -DSSL
500      32334  0.3  1.1 41988 9172 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32335  0.3  1.1 42052 8920 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32336  0.4  1.2 42084 9352 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32337  0.3  1.2 42244 9668 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32338  0.3  1.1 42036 8964 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32339  0.3  1.1 41992 8772 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32340  0.3  1.1 42124 9012 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32341  0.3  1.2 42000 9568 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32342  0.3  1.2 42032 9284 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32343  0.3  1.2 42292 9272 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32344  0.4  1.1 42280 9132 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32345  0.3  1.1 41912 9044 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32346  0.3  1.2 42040 9492 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32347  0.3  1.2 41992 9676 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32348  0.3  1.2 42056 9404 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32349  0.4  1.1 42040 9080 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32350  0.3  1.1 41964 9060 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32351  0.1  1.1 42140 9192 ?        S    15:19   0:02
/usr/local/apache/bin/httpd -DSSL
500      32352  0.3  1.1 42024 8868 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32353  0.3  1.1 42124 8888 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32354  0.3  1.2 41960 9668 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32355  0.3  1.1 42068 9212 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32356  0.3  1.2 42020 9292 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32357  0.3  1.1 41952 8968 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32358  0.3  1.2 42020 9340 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32359  0.3  1.2 42088 9504 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32360  0.3  1.1 42008 9056 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32361  0.2  1.1 41764 8844 ?        S    15:19   0:03
/usr/local/apache/bin/httpd -DSSL
500      32362  0.3  1.2 42240 9692 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32363  0.3  1.1 42272 9248 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32364  0.4  1.1 41888 8952 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32365  0.3  1.1 41964 9208 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32366  0.3  1.1 42140 9248 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32367  0.3  1.2 42020 9288 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32368  0.4  1.2 42032 9768 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32369  0.3  1.1 42084 9244 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32370  0.3  1.1 41936 8880 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32371  0.1  1.1 41968 8636 ?        R    15:19   0:03
/usr/local/apache/bin/httpd -DSSL
500      32372  0.3  1.1 42044 9220 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32373  0.3  1.2 42040 9316 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32374  0.3  1.1 41896 8812 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32375  0.1  1.1 42160 8872 ?        S    15:19   0:02
/usr/local/apache/bin/httpd -DSSL
500      32376  0.3  1.1 41936 8552 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32377  0.4  1.3 43472 10388 ?       S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32378  0.3  1.1 42012 8932 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32379  0.3  1.2 42156 9484 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32380  0.3  1.2 42204 9792 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32381  0.3  1.2 42028 9436 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32382  0.3  1.1 42048 9084 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32383  0.3  1.2 42068 9268 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32384  0.3  1.1 41924 8984 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32385  0.3  1.1 42100 9156 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32386  0.3  1.1 41944 8920 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32387  0.3  1.2 42116 9380 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32388  0.3  1.1 41928 9172 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32389  0.3  1.1 41940 9036 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32390  0.3  1.2 42248 9820 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32391  0.3  1.1 42008 9124 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32392  0.3  1.2 41988 9328 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32393  0.3  1.1 41924 8884 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32394  0.2  1.1 42648 9140 ?        S    15:19   0:04
/usr/local/apache/bin/httpd -DSSL
500      32395  0.3  1.2 42064 9336 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32396  0.3  1.1 42120 9244 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32397  0.3  1.2 41968 9272 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32398  0.3  1.1 41852 9252 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32399  0.3  1.2 42032 9540 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32400  0.3  1.2 42004 9392 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32401  0.3  1.2 42044 9340 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32402  0.3  1.1 41976 8972 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32403  0.1  1.1 41944 9008 ?        S    15:19   0:03
/usr/local/apache/bin/httpd -DSSL
500      32404  0.1  1.1 42064 8592 ?        S    15:19   0:02
/usr/local/apache/bin/httpd -DSSL
500      32405  0.3  1.2 42068 9384 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32406  0.3  1.1 42004 9024 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32407  0.3  1.1 42016 9012 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32408  0.3  1.1 41952 8640 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32409  0.3  1.2 42124 9356 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32410  0.3  1.1 42128 9028 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32411  0.3  1.1 41980 9196 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32412  0.3  1.1 42040 9196 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32413  0.3  1.1 42144 9136 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32414  0.3  1.1 42032 8940 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32415  0.3  1.2 42016 9488 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32416  0.3  1.1 42008 9236 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32417  0.3  1.2 42200 9436 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32418  0.4  1.1 41980 8672 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32419  0.3  1.1 42048 8900 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32420  0.3  1.1 42052 9104 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32421  0.3  1.2 42184 9564 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32422  0.3  1.1 42036 8972 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32423  0.3  1.2 42172 9528 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32424  0.4  1.1 42068 9176 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32425  0.3  1.1 41988 8716 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32426  0.3  1.1 42008 9056 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32427  0.3  1.1 42056 9188 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32428  0.4  1.1 41988 9000 ?        R    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32429  0.3  1.1 41948 9148 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32430  0.3  1.2 42288 9484 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32431  0.3  1.1 42016 8964 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32432  0.4  1.1 41940 9080 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32433  0.4  1.2 42120 9280 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32434  0.3  1.2 42228 9332 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32435  0.3  1.1 42088 8944 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32436  0.1  1.1 41968 8628 ?        S    15:19   0:02
/usr/local/apache/bin/httpd -DSSL
500      32437  0.3  1.1 42056 9192 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32438  0.3  1.2 42280 9988 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32439  0.3  1.2 42096 9276 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32440  0.3  1.1 42020 9076 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32441  0.3  1.1 41880 9252 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32442  0.3  1.1 42388 9232 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32443  0.3  1.1 42072 9244 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32444  0.4  1.1 41944 9140 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32445  0.3  1.1 42064 9140 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32446  0.3  1.2 42116 9440 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32447  0.3  1.2 42224 9724 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32448  0.3  1.1 41948 9208 ?        S    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32449  0.0  1.0 41944 8448 ?        S    15:19   0:01
/usr/local/apache/bin/httpd -DSSL
500      32450  0.3  1.2 42084 9324 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32451  0.4  1.1 42024 8952 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32452  0.4  1.1 42004 9108 ?        S    15:19   0:07
/usr/local/apache/bin/httpd -DSSL
500      32453  0.3  1.2 42112 9552 ?        R    15:19   0:05
/usr/local/apache/bin/httpd -DSSL
500      32454  0.3  1.1 42008 9204 ?        S    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32455  0.3  1.2 42176 9584 ?        R    15:19   0:06
/usr/local/apache/bin/httpd -DSSL
500      32536  0.3  1.2 42216 9364 ?        S    15:22   0:05
/usr/local/apache/bin/httpd -DSSL
500      32568  0.3  1.1 42016 9248 ?        S    15:23   0:04
/usr/local/apache/bin/httpd -DSSL
500      32599  0.3  1.1 42112 9220 ?        S    15:24   0:05
/usr/local/apache/bin/httpd -DSSL
500      32600  0.3  1.1 41964 8992 ?        S    15:24   0:05
/usr/local/apache/bin/httpd -DSSL
500      32601  0.3  1.1 42128 9092 ?        S    15:24   0:05
/usr/local/apache/bin/httpd -DSSL
500      32602  0.3  1.1 41984 8852 ?        S    15:24   0:04
/usr/local/apache/bin/httpd -DSSL
500      32603  0.3  1.2 42020 9596 ?        S    15:24   0:05
/usr/local/apache/bin/httpd -DSSL
500      32644  0.3  1.2 42112 9388 ?        S    15:26   0:05
/usr/local/apache/bin/httpd -DSSL
500      32645  0.3  1.1 41972 9052 ?        S    15:26   0:04
/usr/local/apache/bin/httpd -DSSL
500      32647  0.0  0.9 42152 7664 ?        S    15:26   0:00
/usr/local/apache/bin/httpd -DSSL
root       391  2.2  0.1  2364 1296 pts/1    S    15:32   0:22 top
root       392  0.0  0.2  6668 2084 ?        S    15:32   0:00
/usr/sbin/sshd
root       394  0.0  0.1  2540 1360 pts/2    S    15:32   0:00 -bash
root       440  2.3  0.0  1448  484 pts/2    S    15:32   0:22 vmstat 1
root       441  0.0  0.2  6668 2100 ?        S    15:32   0:00
/usr/sbin/sshd
root       447  0.0  0.1  2540 1364 pts/3    S    15:32   0:00 -bash
500        843  0.2  0.9 41756 7436 ?        S    15:45   0:00
/usr/local/apache/bin/httpd -DSSL
500        907  0.4  0.9 41776 7112 ?        S    15:47   0:00
/usr/local/apache/bin/httpd -DSSL
500        921  0.2  0.8 42108 6844 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        922  0.3  0.8 41764 6628 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        923  0.3  0.8 41812 6748 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        924  0.2  0.8 41728 6664 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        925  0.8  0.8 41676 6940 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        926  0.2  0.8 41676 6632 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        927  0.3  0.8 41844 6788 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        928  0.3  0.9 41896 7112 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        929  0.2  0.8 41792 6624 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        930  0.2  0.8 41772 6880 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        931  0.2  0.8 41744 6940 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        932  0.4  0.8 41756 6792 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        933  0.4  0.9 42268 7252 ?        R    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        934  0.4  0.9 41792 7236 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        935  0.2  0.8 41760 6640 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        936  0.3  0.8 41836 6792 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        937  0.3  0.8 41876 6684 ?        R    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        938  0.3  0.8 41720 6724 ?        R    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        939  0.2  0.9 41792 6952 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        940  0.4  0.8 41900 6716 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        941  0.2  0.8 41740 6780 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        942  0.2  0.8 41772 6508 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        943  0.1  0.8 41776 6564 ?        R    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        944  0.3  0.8 41788 6788 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        945  0.3  0.8 41692 6580 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        946  0.0  0.8 41820 6544 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        947  0.5  0.8 41956 6948 ?        R    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        948  0.2  0.8 41752 6816 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        949  0.3  0.8 41800 6860 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        950  0.3  0.9 41788 6956 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        951  0.3  0.9 41920 7204 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        952  0.6  0.9 41752 6996 ?        R    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        953  0.3  0.9 41700 7072 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        954  0.7  0.8 41740 6724 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        955  0.3  0.9 41904 6964 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        956  0.2  0.8 41764 6480 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        957  0.6  0.9 41740 7072 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        958  0.3  0.9 41800 6960 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        959  0.2  0.8 41712 6624 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        960  0.5  0.8 41688 6672 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        961  0.3  0.8 41768 6864 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        962  0.3  0.8 41800 6848 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        963  0.4  0.8 41936 6912 ?        R    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        964  0.4  0.9 41740 7020 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        965  0.3  0.8 41804 6828 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        966  0.1  0.8 41904 6784 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        967  0.3  0.9 41748 6952 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        968  0.2  0.8 41944 6792 ?        R    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        969  0.3  0.8 41760 6812 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        970  0.3  0.8 41776 6676 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        971  0.1  0.8 41760 6828 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        972  0.5  0.8 41768 6940 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        973  0.6  0.8 41736 6904 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        974  0.3  0.8 41720 6776 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        975  0.3  0.8 41768 6896 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        976  0.1  0.8 41764 6668 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        977  0.2  0.8 41732 6740 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        978  0.1  0.8 41788 6784 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        979  0.3  0.8 41764 6640 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        980  0.2  0.8 41768 6584 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        981  0.0  0.8 41840 6476 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        982  0.2  0.8 41696 6740 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        983  0.1  0.8 41700 6556 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        984  0.3  0.8 41752 6924 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        985  0.2  0.8 41764 6768 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        986  0.8  0.9 41820 6980 ?        S    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
500        987  0.3  0.8 41768 6644 ?        R    15:48   0:00
/usr/local/apache/bin/httpd -DSSL
root       988  0.0  0.1  4876 1376 ?        S    15:48   0:00
/usr/sbin/sendmail -i -t -fnobody@network54.com
root       989 23.0  0.1  3224 1292 pts/3    R    15:48   0:00 ps aux
root       990  0.0  0.1  4876 1376 ?        R    15:48   0:00
/usr/sbin/sendmail -i -t -fnobody@network54.com


Sincerely,
Steven Roussey
http://Network54.com/ 



