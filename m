Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282497AbRLOMgh>; Sat, 15 Dec 2001 07:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282525AbRLOMg3>; Sat, 15 Dec 2001 07:36:29 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:1928 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S282508AbRLOMgP>; Sat, 15 Dec 2001 07:36:15 -0500
Subject: Unfreeable buffer/cache problem in 2.4.17-rc1 still there
From: Chris Chabot <chabotc@reviewboard.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Content-Type: multipart/mixed; boundary="=-8q0heuiKmBMkjLbggyCl"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 15 Dec 2001 13:36:11 +0100
Message-Id: <1008419776.6780.0.camel@gandalf.chabotc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8q0heuiKmBMkjLbggyCl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote,
>Well, I want people with the "unfreeable" buffer/cache problem to
>confirm with me that 2.4.17-rc1 is working ok.

I'm afraid the problem still seems to exist on my box. It takes a while
to kick in, but after 1 day and 8 hours, i have just lost about 400 mb
of usable memory (!)

I have attached the output from free, slabinfo and a ps aux for 2.4.16
after 1 day and 20 hours, and for 2.4.17-rc1 after 1 day and 8 hours.

When the system comes fresh out of a reboot, there's about 900 and some
megabytes of memory 'free' in the 'free' output.. this number has
remained steady for about a day or so (it was still ok last night), then
i checked this morning, and 400 megs of memory seems to evaporated on me
;-)

The box is a dual p3-600, 1 gig of (ecc) ram, AIC7xxx/u2w, 2 scsi disks
(/ and /home), scsi cdrom, scsi DLT tape, 4 ide disks (internal PIIX4
ide controller) in a single raid0 volume (320 gigs), using ext3 on all
mounts, and 3 network cards (1 3com 3c905tx and 2 intel etherexpresspro
10/100's).

the box runs a basic firewall setup (with a ip route to enable it to
handle both cable modem and adsl), and some other basic services (smb,
named, nfs, dhcp, xinetd, pppd). Nothing fancy realy that could explain
this behaviour.

Ofcource i did check ps aux to see if anything was _using_ this memory,
but unfortunatly this is not the case.

Hope the outputs help trace this problem. If any more input is required,
dont hesitate to bomb my inbox ;-)

	-- Chris Chabot


ps, i don't know if its related, but i also found the folowing messages
in my dmesg, dont know where there from.. but i figured i'd mention it
invalidate: busy buffer
invalidate: busy buffer
...
<repeats about 20 times>




--=-8q0heuiKmBMkjLbggyCl
Content-Disposition: attachment; filename=slabinfo-2.4.16
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

[uptime]

2:42pm up 1 day, 22:38, 1 user, load average: 0.00, 0.00, 0.00

[free]

total used free shared buffers cached=20
Mem: 1029752 1018424 11328 0 130904 404380=20
-/+ buffers/cache: 483140 546612=20
Swap: 2104464 1328 2103136

[slabinfo]

slabinfo - version: 1.1 (SMP)
kmem_cache            80     80    244    5    5    1 :  252  126
ip_conntrack          66     66    352    6    6    1 :  124   62
ip_fib_hash           22    226     32    2    2    1 :  252  126
ip_mrt_cache           0      0     96    0    0    1 :  252  126
tcp_tw_bucket         40     40     96    1    1    1 :  252  126
tcp_bind_bucket      226    226     32    2    2    1 :  252  126
tcp_open_request      59     59     64    1    1    1 :  252  126
inet_peer_cache        2    118     64    2    2    1 :  252  126
ip_dst_cache         197    240    160   10   10    1 :  252  126
arp_cache              7     60    128    2    2    1 :  252  126
blkdev_requests     1024   1040     96   26   26    1 :  252  126
journal_head         424   1560     48   19   20    1 :  252  126
revoke_table           4    253     12    1    1    1 :  252  126
revoke_record        113    113     32    1    1    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache      168    168     92    4    4    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache              3    226     32    2    2    1 :  252  126
skbuff_head_cache    351    528    160   22   22    1 :  252  126
sock                 126    126    832   14   14    2 :  124   62
sigqueue              58     58    132    2    2    1 :  252  126
cdev_cache          2320   2360     64   40   40    1 :  252  126
bdev_cache            14    118     64    2    2    1 :  252  126
mnt_cache             14    118     64    2    2    1 :  252  126
inode_cache       686896 686896    480 85862 85862    1 :  124   62
dentry_cache      696810 696810    128 23227 23227    1 :  252  126
dquot                  0      0    128    0    0    1 :  252  126
filp                 450    480    128   16   16    1 :  252  126
names_cache            4      4   4096    4    4    1 :   60   30
buffer_head       134892 218120     96 5453 5453    1 :  252  126
mm_struct            150    168    160    7    7    1 :  252  126
vm_area_struct       832   1040     96   26   26    1 :  252  126
fs_cache             152    177     64    3    3    1 :  252  126
files_cache           86     90    416   10   10    1 :  124   62
signal_act            68     69   1312   23   23    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384            10     10  16384   10   10    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              2      2   8192    2    2    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             43     43   4096   43   43    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            202    202   2048  101  101    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            114    124   1024   30   31    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             656    656    512   82   82    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             224    255    256   16   17    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128            2910   2910    128   97   97    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64            28261  28261     64  479  479    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32           121924 121927     32 1079 1079    1 :  252  126

[ps aux]

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1416  472 ?        S    Nov30   0:03 init [3]=20
root         2  0.0  0.0     0    0 ?        SW   Nov30   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Nov30   0:00 [ksoftirqd_C=
PU0]
root         4  0.0  0.0     0    0 ?        SWN  Nov30   0:00 [ksoftirqd_C=
PU1]
root         5  0.0  0.0     0    0 ?        SW   Nov30   0:11 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   Nov30   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        SW   Nov30   0:00 [kupdated]
root         8  0.0  0.0     0    0 ?        SW   Nov30   0:00 [scsi_eh_0]
root         9  0.0  0.0     0    0 ?        SW<  Nov30   0:00 [mdrecoveryd=
]
root        10  0.0  0.0     0    0 ?        SW   Nov30   0:01 [kjournald]
root       145  0.0  0.0     0    0 ?        SW   Nov30   0:00 [kjournald]
root       146  0.0  0.0     0    0 ?        SW   Nov30   0:01 [kjournald]
root       147  0.0  0.0     0    0 ?        SW   Nov30   0:08 [kjournald]
root       717  0.0  0.0  1756  848 ?        S    Nov30   0:00 syslogd -m 0=
 -r
root       722  0.0  0.0  1404  476 ?        S    Nov30   0:00 klogd -2 -x
bin        742  0.0  0.0  1660  764 ?        S    Nov30   0:00 portmap
root       799  0.0  0.0  1792  568 ?        S    Nov30   0:00 rpc.rquotad
root       804  0.0  0.0  1620  708 ?        S    Nov30   0:00 rpc.mountd
root       810  0.0  0.0     0    0 ?        SW   Nov30   0:07 [nfsd]
root       811  0.0  0.0     0    0 ?        SW   Nov30   0:07 [nfsd]
root       812  0.0  0.0     0    0 ?        SW   Nov30   0:07 [nfsd]
root       813  0.0  0.0     0    0 ?        SW   Nov30   0:07 [nfsd]
root       814  0.0  0.0     0    0 ?        SW   Nov30   0:07 [nfsd]
root       815  0.0  0.0     0    0 ?        SW   Nov30   0:06 [nfsd]
root       816  0.0  0.0     0    0 ?        SW   Nov30   0:06 [nfsd]
root       817  0.0  0.0     0    0 ?        SW   Nov30   0:07 [nfsd]
root       818  0.0  0.0     0    0 ?        SW   Nov30   0:00 [lockd]
root       819  0.0  0.0     0    0 ?        SW   Nov30   0:00 [rpciod]
root       984  0.0  0.0  3260  628 ?        S    Nov30   0:00 smbd -D
root       989  0.0  0.0  2448  820 ?        S    Nov30   0:00 nmbd -D
root      1038  0.0  0.1  5684 1248 ?        S    Nov30   0:00 sendmail: ac=
cepti
root      1057  0.0  0.0  1648  676 ?        S    Nov30   0:00 crond
root      1536  0.0  0.0  1388  376 tty1     S    Nov30   0:00 /sbin/minget=
ty tt
root      1537  0.0  0.0  1388  372 tty2     S    Nov30   0:00 /sbin/minget=
ty tt
root      1996  0.0  0.0  1920  896 ?        S    Nov30   0:00 /usr/sbin/pp=
pd ca
root      1997  0.2  0.0  1456  528 ?        S    Nov30   7:07 /usr/sbin/pp=
tp pp
root      1999  0.0  0.0  1448  560 ?        S    Nov30   0:00 /usr/sbin/pp=
tp pp
named    15213  0.0  0.4 15348 4540 ?        S    Dec01   0:00 named -u nam=
ed
named    15215  0.0  0.4 15348 4540 ?        S    Dec01   0:00 named -u nam=
ed
named    15216  0.0  0.4 15348 4540 ?        S    Dec01   0:02 named -u nam=
ed
named    15217  0.0  0.4 15348 4540 ?        S    Dec01   0:02 named -u nam=
ed
named    15218  0.0  0.4 15348 4540 ?        S    Dec01   0:00 named -u nam=
ed
named    15219  0.0  0.4 15348 4540 ?        S    Dec01   0:00 named -u nam=
ed
root     16544  0.0  0.1  2312 1036 ?        S    Dec01   0:00 xinetd -stay=
alive
root     18557  0.0  0.1  2676 1276 ?        S    04:04   0:00 /usr/sbin/ss=
hd
root     19251  0.0  0.1  3600 2048 ?        S    14:29   0:00 /usr/sbin/ss=
hd
root     19252  0.0  0.1  2588 1424 pts/0    S    14:29   0:00 -bash
root     19348  0.0  0.0  2664  760 pts/0    R    14:43   0:00 ps aux

--=-8q0heuiKmBMkjLbggyCl
Content-Disposition: attachment; filename=slabinfo-2.4.17-rc1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

[uptime]

1:16pm up 1 day, 8:50, 1 user, load average: 0.00, 0.00, 0.00


[free]

total used free shared buffers cached=20
Mem: 1029744 1018420 11324 0 119856 413224=20
-/+ buffers/cache: 485340 544404=20
Swap: 2104464 776 2103688


[/proc/slabinfo]

slabinfo - version: 1.1 (SMP)
kmem_cache            80     80    244    5    5    1 :  252  126
ip_conntrack         110    110    352   10   10    1 :  124   62
ip_fib_hash           21    226     32    2    2    1 :  252  126
ip_mrt_cache           0      0     96    0    0    1 :  252  126
tcp_tw_bucket        120    120     96    3    3    1 :  252  126
tcp_bind_bucket      226    226     32    2    2    1 :  252  126
tcp_open_request      59     59     64    1    1    1 :  252  126
inet_peer_cache        3     59     64    1    1    1 :  252  126
ip_dst_cache         367    408    160   17   17    1 :  252  126
arp_cache              7     60    128    2    2    1 :  252  126
blkdev_requests     1024   1040     96   26   26    1 :  252  126
journal_head         342    702     48    9    9    1 :  252  126
revoke_table           4    253     12    1    1    1 :  252  126
revoke_record        113    113     32    1    1    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache      159    168     92    4    4    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache            226    226     32    2    2    1 :  252  126
skbuff_head_cache    402    528    160   22   22    1 :  252  126
sock                 117    117    832   13   13    2 :  124   62
sigqueue             116    116    132    4    4    1 :  252  126
cdev_cache          2319   2360     64   40   40    1 :  252  126
bdev_cache            14    118     64    2    2    1 :  252  126
mnt_cache             14    118     64    2    2    1 :  252  126
inode_cache       688304 688304    480 86038 86038    1 :  124   62
dentry_cache      696690 696690    128 23223 23223    1 :  252  126
dquot                  0      0    128    0    0    1 :  252  126
filp                 456    480    128   16   16    1 :  252  126
names_cache            5      5   4096    5    5    1 :   60   30
buffer_head       132808 231880     96 5797 5797    1 :  252  126
mm_struct            144    144    160    6    6    1 :  252  126
vm_area_struct       834    960     96   24   24    1 :  252  126
fs_cache             177    177     64    3    3    1 :  252  126
files_cache           72     72    416    8    8    1 :  124   62
signal_act            72     72   1312   24   24    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384            10     11  16384   10   11    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              2      3   8192    2    3    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             81     81   4096   81   81    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            220    232   2048  110  116    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            144    144   1024   36   36    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             672    672    512   84   84    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             255    255    256   17   17    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128            2983   3090    128  103  103    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64            28143  28143     64  477  477    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32           122217 122266     32 1082 1082    1 :  252  126


[ps aux]

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1416  528 ?        S    Dec15   0:04 init [3]=20
root         2  0.0  0.0     0    0 ?        SW   Dec15   0:10 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Dec15   0:00 [ksoftirqd_C=
PU0]
root         4  0.0  0.0     0    0 ?        SWN  Dec15   0:00 [ksoftirqd_C=
PU1]
root         5  0.0  0.0     0    0 ?        SW   Dec15   0:04 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   Dec15   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        SW   Dec15   0:01 [kupdated]
root         8  0.0  0.0     0    0 ?        SW   Dec15   0:00 [scsi_eh_0]
root         9  0.0  0.0     0    0 ?        SW<  Dec15   0:00 [mdrecoveryd=
]
root        10  0.0  0.0     0    0 ?        SW   Dec15   0:00 [kjournald]
root       142  0.0  0.0     0    0 ?        SW   Dec15   0:00 [kjournald]
root       143  0.0  0.0     0    0 ?        SW   Dec15   0:01 [kjournald]
root       144  0.0  0.0     0    0 ?        SW   Dec15   0:07 [kjournald]
root       716  0.0  0.0  1476  604 ?        S    Dec15   0:00 syslogd -m 0=
 -r
root       721  0.0  0.0  1404  480 ?        S    Dec15   0:00 klogd -2 -x
bin        741  0.0  0.0  1660  764 ?        S    Dec15   0:00 portmap
root       798  0.0  0.0  1792  632 ?        S    Dec15   0:00 rpc.rquotad
root       803  0.0  0.0  1620  744 ?        S    Dec15   0:00 rpc.mountd
root       808  0.0  0.0     0    0 ?        SW   Dec15   0:10 [nfsd]
root       809  0.0  0.0     0    0 ?        SW   Dec15   0:10 [nfsd]
root       810  0.0  0.0     0    0 ?        SW   Dec15   0:10 [nfsd]
root       811  0.0  0.0     0    0 ?        SW   Dec15   0:10 [nfsd]
root       812  0.0  0.0     0    0 ?        SW   Dec15   0:10 [nfsd]
root       813  0.0  0.0     0    0 ?        SW   Dec15   0:10 [nfsd]
root       814  0.0  0.0     0    0 ?        SW   Dec15   0:10 [nfsd]
root       815  0.0  0.0     0    0 ?        SW   Dec15   0:10 [nfsd]
root       816  0.0  0.0     0    0 ?        SW   Dec15   0:00 [lockd]
root       817  0.0  0.0     0    0 ?        SW   Dec15   0:00 [rpciod]
root       889  0.0  0.0  1920  912 ?        S    Dec15   0:00 /usr/sbin/pp=
pd ca
root       929  0.0  0.1  2312 1056 ?        S    Dec15   0:00 xinetd -stay=
alive
root       950  0.0  0.0  1796  688 ?        S    Dec15   0:00 /usr/sbin/dh=
cpd
root       986  0.0  0.0  3260  796 ?        S    Dec15   0:00 smbd -D
root       991  0.0  0.0  2448  936 ?        S    Dec15   0:01 nmbd -D
root      1033  0.3  0.0  1456  528 ?        S    Dec15   6:59 /usr/sbin/pp=
tp pp
root      1035  0.0  0.0  1448  572 ?        S    Dec15   0:00 /usr/sbin/pp=
tp pp
root      1043  0.0  0.1  5684 1672 ?        S    Dec15   0:05 sendmail: ac=
cepti
root      1062  0.0  0.0  1648  748 ?        S    Dec15   0:00 crond
root      1541  0.0  0.0  1388  452 tty1     S    Dec15   0:00 /sbin/minget=
ty tt
root      1542  0.0  0.0  1388  452 tty2     S    Dec15   0:00 /sbin/minget=
ty tt
root      1722  0.0  0.1  2680 1280 ?        S    Dec15   0:03 /usr/sbin/ss=
hd
root      5133  0.2  0.2  3652 2080 ?        S    13:15   0:00 /usr/sbin/ss=
hd
root      5135  0.0  0.1  2656 1492 pts/1    S    13:15   0:00 -bash
named     5221  0.0  0.3 14068 4064 ?        S    13:15   0:00 named -u nam=
ed
named     5223  0.0  0.3 14068 4064 ?        S    13:15   0:00 named -u nam=
ed
named     5224  0.1  0.3 14068 4064 ?        S    13:15   0:00 named -u nam=
ed
named     5225  0.0  0.3 14068 4064 ?        S    13:15   0:00 named -u nam=
ed
named     5226  0.0  0.3 14068 4064 ?        S    13:15   0:00 named -u nam=
ed
named     5227  0.0  0.3 14068 4064 ?        S    13:15   0:00 named -u nam=
ed
root      5342  0.0  0.0  2660  756 pts/1    R    13:17   0:00 ps aux

--=-8q0heuiKmBMkjLbggyCl--

