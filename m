Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSLZVga>; Thu, 26 Dec 2002 16:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264629AbSLZVg3>; Thu, 26 Dec 2002 16:36:29 -0500
Received: from [68.96.149.130] ([68.96.149.130]:42430 "EHLO resonant.org")
	by vger.kernel.org with ESMTP id <S264620AbSLZVfX>;
	Thu, 26 Dec 2002 16:35:23 -0500
Date: Thu, 26 Dec 2002 15:43:38 -0600
From: Zed Pobre <zed@resonant.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Complete freeze with 2.4.20 on 4-proc IBM xSeries 350
Message-ID: <20021226214338.GA1285@resonant.org>
Mail-Followup-To: Zed Pobre <zed@resonant.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E8EE16A19D69D611B40000D0B73EBB250F06BE@exchange.intern.eproduction.ch> <11930000.1039565421@flay>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <11930000.1039565421@flay>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
X-GPG-Fingerprint: FF 75 8D 70 57 8D A4 7D  3A DE 6D 2F 25 C3 E6 E7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2002 at 04:10:21PM -0800, Martin J. Bligh wrote:
> > I'm experiencing serious problems with Kernel 2.4.20 on a IBM xSeries 3=
50
> > machine, having 4 700 MHz processors and 4 GB RAM (same on another mach=
ine
> > with the same configuration, but only 3 GB RAM). The machine just com-
> > pletely freezes after some time, ranging from 20 minutes to 3 hours. It
> > is running IBM DB/2 with quite some load, the base system is RedHat 7.2
> > with all the updates applied. There is no oops or other fault, just a
> > plain freeze.
>=20
> Can you watch /proc/meminfo and see how low "lowfree" gets?
> If it gets low (eg below 50Mb), dump /proc/slabinfo as well.

    I'm running off a Soyo Dragon KT400 board, single AMD 2400+
processor, 1GB ram (4GB limit set in kernel), and was also having
freezes, apparently related to having software raid 1 in use (on two
drives sitting on the on-board Highpoint controller).  If I started a
large data transfer over the net, the machine would freeze after some
time ranging from a few minutes to an hour, with either 2.4.20-ac2 or
2.4.21-pre2.  I tried letting the system resync before restarting, and
the first pass through it actually froze during resyncing, with
nothing special going on.  Later, after a resync, I started trying all
sorts of things, from turning off XFree86 and running a minimal set of
loaded modules, to using mdadm to fail one of the drives (it was a
RAID1 setup) to force only a single disk to be in use.  Right now,
I've taken it off of RAID entirely, and am mounting /dev/hdex
directly, and copying data to that, and it seems to be okay so far
(for the last hour or so).


cat /proc/meminfo gives:

        total:    used:    free:  shared: buffers:  cached:
Mem:  1055412224 1045782528  9629696        0 90771456 720228352
Swap: 526376960 39202816 487174144
MemTotal:      1030676 kB
MemFree:          9404 kB
MemShared:           0 kB
Buffers:         88644 kB
Cached:         684644 kB
SwapCached:      18704 kB
Active:         540556 kB
Inact_dirty:    356560 kB
Inact_clean:     44764 kB
Inact_target:   188376 kB
HighTotal:      131008 kB
HighFree:         1024 kB
LowTotal:       899668 kB
LowFree:          8380 kB
SwapTotal:      514040 kB
SwapFree:       475756 kB
Committed_AS:   322008 kB


So if you were concerned about LowFree going low, it is.

/proc/slabinfo:

slabinfo - version: 1.1
kmem_cache            68     68    112    2    2    1
fib6_nodes             5    112     32    1    1    1
ip6_dst_cache          5     20    192    1    1    1
ndisc_cache            1     30    128    1    1    1
ip_conntrack          10     24    320    2    2    1
tcp_tw_bucket          0      0    128    0    0    1
tcp_bind_bucket       25    112     32    1    1    1
tcp_open_request       0      0    128    0    0    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            9    112     32    1    1    1
ip_dst_cache          12     40    192    2    2    1
arp_cache              3     30    128    1    1    1
urb_priv               4     59     64    1    1    1
blkdev_requests     1408   1410    128   47   47    1
nfs_write_data         0      0    384    0    0    1
nfs_read_data          0      0    384    0    0    1
nfs_page               0      0    128    0    0    1
journal_head          26     77     48    1    1    1
revoke_table           1    250     12    1    1    1
revoke_record          0      0     32    0    0    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache        4     40     96    1    1    1
fasync_cache           1    202     16    1    1    1
uid_cache              6    112     32    1    1    1
skbuff_head_cache    163    260    192   13   13    1
sock                 201    204    896   51   51    1
sigqueue               1     29    132    1    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache            22    472     64    8    8    1
bdev_cache             9     59     64    1    1    1
mnt_cache             18     59     64    1    1    1
inode_cache        54639  57071    512 8153 8153    1
dentry_cache         804   4050    128  135  135    1
dquot                  0      0    128    0    0    1
filp                1563   1590    128   53   53    1
names_cache            0      2   4096    0    2    1
buffer_head       185515 191520    128 6368 6384    1
mm_struct             63     80    192    4    4    1
vm_area_struct      2749   2850    128   92   95    1
fs_cache              62    118     64    2    2    1
files_cache           62     63    448    7    7    1
signal_act            71     75   1344   24   25    1
pte_chain          70104  74592      8  221  222    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             2      2  65536    2    2   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             2      2  32768    2    2    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             2      7  16384    2    7    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192             15     19   8192   15   19    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096            121    139   4096  121  139    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             50    130   2048   26   65    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             53     60   1024   14   15    1
size-512(DMA)          0      0    512    0    0    1
size-512              99    120    512   13   15    1
size-256(DMA)          0      0    256    0    0    1
size-256              86    120    256    6    8    1
size-128(DMA)          3     30    128    1    1    1
size-128             953    990    128   33   33    1
size-64(DMA)           0      0     64    0    0    1
size-64              776   1062     64   17   18    1
size-32(DMA)          52     59     64    1    1    1
size-32              714    767     64   13   13    1


Does this provide you with any useful information?

--=20
Zed Pobre <zed@debian.org> a.k.a. Zed Pobre <zed@resonant.org>
PGP key and fingerprint available on finger; encrypted mail welcomed.

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQEVAwUBPgt4Ch0207zoJUw5AQEWIQf+N6d3I6eB1RjfGgXPx4vBEpL9oIWcUSER
KvIHAgtVjNu+5aPsSgH7AIlf1tMICLCKK2XBkrSFYWx9YqOgmGpuKLUOwaFFJf+n
KQk3mpRFzOVB9dFefWF8rFv+vKwSwKE6rZNaobG0BD8h7x/ub0+FO63UjUtm57Uv
wgVQR4EpX0rRjfnKIvVMZXi0CdrtKvDMSdqKHQEGlDS8nlyciEd3PK90m/yE1JpB
R983KmRxe7ZucCUysgVefRF9z4rNdEQGRHZZ8ij70BhNseB7y0bqgMzAXhhP0fUG
IBQYSHQrJWC1ZtiX2fFpChpJbJMLZcOGe9SSiSlqnN8R83LqkaqkFw==
=KxCD
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
