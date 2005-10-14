Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVJNKZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVJNKZb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 06:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVJNKZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 06:25:31 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:539 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750712AbVJNKZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 06:25:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=BglP8W9xTPsPnrX/I2Pr7ll0gAFOc97BopJkV28OtZnR+At5JTgxG469dU/BYF9RZkaUDsbO/fzQB1Xy+EkwXXp14NN5pr7lBXKdB37U/GceewrgrgOH3BNtMWtsubXjmVcaRmnwIVrM5/awO0wDU1jZz6wpsoIxyaR9PrKr/lo=
Message-ID: <aec7e5c30510140325t4d04fd33sb5e8818f6f2278fb@mail.gmail.com>
Date: Fri, 14 Oct 2005 19:25:29 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc6: possible idr leak
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7309_16540152.1129285529766"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7309_16540152.1129285529766
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

I've apparently been running 2.6.13-rc6 for 23 days on my i386 desktop
machine, and today it seemed a bit sluggish. It turns out that it is
using 614 of 1024 MiB for slab... It looks like someone is using the
idr code and leaking...

First I thought it was related to the dcache because I use ccache much
on this machine and I had 130 000 files in the c-cache. But it looks
like it is idr-related.

Is this problem fixed in more recent versions? What to do? Any point
in keeping the machine alive?

The hardware is hyperthreading P4 with hyperthreading disabled. I've
played around with cpufreq and software suspend, and I don't remember
if I've suspended the machine or not if that matters.

Thanks,

/ magnus

/proc/version:

Linux version 2.6.13-rc6 (root@cherry) (gcc version 3.3.5-20050130
(Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #2 Wed
Aug 10 21:16:35 JST 2005

/proc/meminfo:

MemTotal:      1027072 kB
MemFree:         15576 kB
Buffers:         13944 kB
Cached:          86416 kB
SwapCached:     155384 kB
Active:         337768 kB
Inactive:        50232 kB
HighTotal:      121368 kB
HighFree:          116 kB
LowTotal:       905704 kB
LowFree:         15460 kB
SwapTotal:     2008116 kB
SwapFree:      1672592 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:         328500 kB
Slab:           614792 kB
CommitLimit:   2521652 kB
Committed_AS:   995552 kB
PageTables:       2256 kB
VmallocTotal:   114680 kB
VmallocUsed:      2864 kB
VmallocChunk:   111540 kB

/proc/slabinfo:

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> :
slabdata <active_slabs> <num_slabs> <sharedavail>
fib6_nodes             5    119     32  119    1 : tunables  120   60=20
  0 : slabdata      1      1      0
ip6_dst_cache          4     15    256   15    1 : tunables  120   60=20
  0 : slabdata      1      1      0
ndisc_cache            1     15    256   15    1 : tunables  120   60=20
  0 : slabdata      1      1      0
RAWv6                  3      6    640    6    1 : tunables   54   27=20
  0 : slabdata      1      1      0
UDPv6                  0      0    640    6    1 : tunables   54   27=20
  0 : slabdata      0      0      0
request_sock_TCPv6      0      0    128   31    1 : tunables  120   60
   0 : slabdata      0      0      0
TCPv6                  1      7   1152    7    2 : tunables   24   12=20
  0 : slabdata      1      1      0
uhci_urb_priv         18     88     44   88    1 : tunables  120   60=20
  0 : slabdata      1      1      0
UNIX                 320    320    384   10    1 : tunables   54   27=20
  0 : slabdata     32     32      0
tcp_tw_bucket          0      0    128   31    1 : tunables  120   60=20
  0 : slabdata      0      0      0
tcp_bind_bucket        7    226     16  226    1 : tunables  120   60=20
  0 : slabdata      1      1      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60=20
  0 : slabdata      0      0      0
secpath_cache          0      0    128   31    1 : tunables  120   60=20
  0 : slabdata      0      0      0
xfrm_dst_cache         0      0    384   10    1 : tunables   54   27=20
  0 : slabdata      0      0      0
ip_fib_alias          10    226     16  226    1 : tunables  120   60=20
  0 : slabdata      1      1      0
ip_fib_hash           10    119     32  119    1 : tunables  120   60=20
  0 : slabdata      1      1      0
ip_dst_cache          89    105    256   15    1 : tunables  120   60=20
  0 : slabdata      7      7      0
arp_cache              2     31    128   31    1 : tunables  120   60=20
  0 : slabdata      1      1      0
RAW                    2      7    512    7    1 : tunables   54   27=20
  0 : slabdata      1      1      0
UDP                   14     14    512    7    1 : tunables   54   27=20
  0 : slabdata      2      2      0
request_sock_TCP       0      0     64   61    1 : tunables  120   60=20
  0 : slabdata      0      0      0
TCP                    6     12   1024    4    1 : tunables   54   27=20
  0 : slabdata      3      3      0
flow_cache             0      0    128   31    1 : tunables  120   60=20
  0 : slabdata      0      0      0
scsi_cmd_cache         2     10    384   10    1 : tunables   54   27=20
  0 : slabdata      1      1      0
deadline_drq          12     75     52   75    1 : tunables  120   60=20
  0 : slabdata      1      1      0
fat_inode_cache        0      0    360   11    1 : tunables   54   27=20
  0 : slabdata      0      0      0
fat_cache              0      0     20  185    1 : tunables  120   60=20
  0 : slabdata      0      0      0
ext2_inode_cache       0      0    436    9    1 : tunables   54   27=20
  0 : slabdata      0      0      0
ext2_xattr             0      0     48   81    1 : tunables  120   60=20
  0 : slabdata      0      0      0
journal_handle         0      0     20  185    1 : tunables  120   60=20
  0 : slabdata      0      0      0
journal_head           0      0     52   75    1 : tunables  120   60=20
  0 : slabdata      0      0      0
revoke_table           0      0     12  290    1 : tunables  120   60=20
  0 : slabdata      0      0      0
revoke_record          0      0     16  226    1 : tunables  120   60=20
  0 : slabdata      0      0      0
ext3_inode_cache       0      0    456    8    1 : tunables   54   27=20
  0 : slabdata      0      0      0
ext3_xattr             0      0     48   81    1 : tunables  120   60=20
  0 : slabdata      0      0      0
reiser_inode_cache  10916  14910    384   10    1 : tunables   54   27
   0 : slabdata   1491   1491      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60=20
  0 : slabdata      0      0      0
eventpoll_epi          0      0    128   31    1 : tunables  120   60=20
  0 : slabdata      0      0      0
inotify_event_cache      0      0     28  135    1 : tunables  120 =20
60    0 : slabdata      0      0      0
inotify_watch_cache     17    107     36  107    1 : tunables  120 =20
60    0 : slabdata      1      1      0
kioctx                 0      0    256   15    1 : tunables  120   60=20
  0 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60=20
  0 : slabdata      0      0      0
fasync_cache           1    226     16  226    1 : tunables  120   60=20
  0 : slabdata      1      1      0
shmem_inode_cache   5237   5240    400   10    1 : tunables   54   27=20
  0 : slabdata    524    524      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60
   0 : slabdata      0      0      0
uid_cache              3     61     64   61    1 : tunables  120   60=20
  0 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12=20
  0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27=20
  0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27=20
  0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60=20
  0 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60=20
  0 : slabdata      2      2      0
blkdev_ioc           171    270     28  135    1 : tunables  120   60=20
  0 : slabdata      2      2      0
blkdev_queue          27     30    380   10    1 : tunables   54   27=20
  0 : slabdata      3      3      0
blkdev_requests       13     75    160   25    1 : tunables  120   60=20
  0 : slabdata      3      3      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12=20
  0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12=20
  0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27=20
  0 : slabdata     52     52      0
biovec-16            256    270    256   15    1 : tunables  120   60=20
  0 : slabdata     18     18      0
biovec-4             256    305     64   61    1 : tunables  120   60=20
  0 : slabdata      5      5      0
biovec-1             257    452     16  226    1 : tunables  120   60=20
  0 : slabdata      2      2      0
bio                  257    279    128   31    1 : tunables  120   60=20
  0 : slabdata      9      9      0
file_lock_cache        4     45     88   45    1 : tunables  120   60=20
  0 : slabdata      1      1      0
sock_inode_cache     340    340    384   10    1 : tunables   54   27=20
  0 : slabdata     34     34      0
skbuff_head_cache    480    720    256   15    1 : tunables  120   60=20
  0 : slabdata     48     48      0
proc_inode_cache      60    288    324   12    1 : tunables   54   27=20
  0 : slabdata     24     24      0
sigqueue              12     27    148   27    1 : tunables  120   60=20
  0 : slabdata      1      1      0
radix_tree_node    10430  10598    276   14    1 : tunables   54   27=20
  0 : slabdata    757    757      0
bdev_cache             6      7    512    7    1 : tunables   54   27=20
  0 : slabdata      1      1      0
sysfs_dir_cache     1983   2016     40   96    1 : tunables  120   60=20
  0 : slabdata     21     21      0
mnt_cache             19     31    128   31    1 : tunables  120   60=20
  0 : slabdata      1      1      0
inode_cache          698    884    308   13    1 : tunables   54   27=20
  0 : slabdata     68     68      0
dentry_cache       13965  27840    136   29    1 : tunables  120   60=20
  0 : slabdata    960    960      0
filp                2850   2910    256   15    1 : tunables  120   60=20
  0 : slabdata    194    194      0
names_cache           14     14   4096    1    1 : tunables   24   12=20
  0 : slabdata     14     14      0
idr_layer_cache   4277318 4277326    136   29    1 : tunables  120 =20
60    0 : slabdata 147494 147494      0
buffer_head         3552  11400     52   75    1 : tunables  120   60=20
  0 : slabdata    152    152      0
mm_struct            102    102    640    6    1 : tunables   54   27=20
  0 : slabdata     17     17      0
vm_area_struct      6420   6795     88   45    1 : tunables  120   60=20
  0 : slabdata    151    151      0
fs_cache             109    119     32  119    1 : tunables  120   60=20
  0 : slabdata      1      1      0
files_cache          105    105    512    7    1 : tunables   54   27=20
  0 : slabdata     15     15      0
signal_cache         120    120    384   10    1 : tunables   54   27=20
  0 : slabdata     12     12      0
sighand_cache        115    115   1408    5    2 : tunables   24   12=20
  0 : slabdata     23     23      0
task_struct          138    138   1264    3    1 : tunables   24   12=20
  0 : slabdata     46     46      0
anon_vma            2909   3256      8  407    1 : tunables  120   60=20
  0 : slabdata      8      8      0
pgd                   96     96   4096    1    1 : tunables   24   12=20
  0 : slabdata     96     96      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4=20
  0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4=20
  0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4=20
  0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4=20
  0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4=20
  0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4=20
  0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4=20
  0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4=20
  0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4=20
  0 : slabdata      0      0      0
size-8192            137    137   8192    1    2 : tunables    8    4=20
  0 : slabdata    137    137      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12=20
  0 : slabdata      0      0      0
size-4096            184    184   4096    1    1 : tunables   24   12=20
  0 : slabdata    184    184      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12=20
  0 : slabdata      0      0      0
size-2048            336    350   2048    2    1 : tunables   24   12=20
  0 : slabdata    175    175      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27=20
  0 : slabdata      0      0      0
size-1024            204    204   1024    4    1 : tunables   54   27=20
  0 : slabdata     51     51      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27=20
  0 : slabdata      0      0      0
size-512             480    512    512    8    1 : tunables   54   27=20
  0 : slabdata     64     64      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60=20
  0 : slabdata      0      0      0
size-256             180    180    256   15    1 : tunables  120   60=20
  0 : slabdata     12     12      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60=20
  0 : slabdata      0      0      0
size-128            1184   1364    128   31    1 : tunables  120   60=20
  0 : slabdata     44     44      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60=20
  0 : slabdata      0      0      0
size-64             1509   3477     64   61    1 : tunables  120   60=20
  0 : slabdata     57     57      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60=20
  0 : slabdata      0      0      0
size-32             2900  10472     32  119    1 : tunables  120   60=20
  0 : slabdata     88     88      0
kmem_cache           124    124    128   31    1 : tunables  120   60=20
  0 : slabdata      4      4      0

ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux cherry 2.6.13-rc6 #2 Wed Aug 10 21:16:35 JST 2005 i686 Intel(R)
Pentium(R) 4 CPU 3.20GHz GenuineIntel GNU/Linux

Gnu C                  3.3.6
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.0
e2fsprogs              1.38
reiserfsprogs          3.6.19
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   068
Modules Loaded         usb_storage ipv6 ohci_hcd parport_pc parport
floppy rtc tg3 ehci_hcd audio usbhid snd_usb_audio snd_usb_lib
snd_rawmidi snd_hwdep uhci_hcd evdev usbcore snd_pcm_oss snd_mixer_oss
snd_pcm snd_timer snd snd_page_alloc processor cpufreq_ondemand
p4_clockmod speedstep_lib freq_table

------=_Part_7309_16540152.1129285529766
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
462f0v4/VHjv9JGJAAA=
------=_Part_7309_16540152.1129285529766
Content-Type: application/x-gzip; name=dmesg.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg.gz"

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

------=_Part_7309_16540152.1129285529766--
