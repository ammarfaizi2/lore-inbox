Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264758AbUD1MFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264758AbUD1MFh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 08:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264759AbUD1MFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 08:05:37 -0400
Received: from dialin-212-144-167-125.arcor-ip.net ([212.144.167.125]:49536
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S264758AbUD1MFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 08:05:25 -0400
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <EB1E9414-9904-11D8-B40E-000A958E35DC@fhm.edu>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-25--383157599"
To: Linux Kernel <linux-kernel@vger.kernel.org>
From: Daniel Egger <degger@fhm.edu>
Subject: Serious memory leak in kernel version >2.4.23
Date: Wed, 28 Apr 2004 13:12:21 +0200
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-25--383157599
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hija,

I've just been able to again discover my memory problems, this time
under 2.4.26 as provided by the Debian people in compiled form:
kernel-image-2.4.26-1-k7

With kernel 2.4.23 and below the same machine worked just fine for
many months....

The net result is that I'm getting:
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process rsync
__alloc_pages: 0-order allocation failed (gfp=0xf0/0)

in my syslog messages.

Also ps shows that there's less than 100MB of memory in use by
processes but nevertheless a lot of memory is gone:

              total       used       free     shared    buffers     
cached
Mem:        515692     481756      33936          0      37772      
64600
-/+ buffers/cache:     379384     136308
Swap:       262576      36360     226216

And here is the slab information....

slabinfo - version: 1.1
kmem_cache            68     72    108    2    2    1
ip_fib_hash            9    112     32    1    1    1
packet_task            0      0     44    0    0    1
hpsb_packet            0      0     96    0    0    1
ext3_xattr             0      0     44    0    0    1
journal_head         447   1617     48   10   21    1
revoke_table           4    250     12    1    1    1
revoke_record          0    112     32    0    1    1
clip_arp_cache         0      0    128    0    0    1
ip_mrt_cache           0      0    128    0    0    1
tcp_tw_bucket          0     60    128    0    2    1
tcp_bind_bucket       18    112     32    1    1    1
tcp_open_request       0     30    128    0    1    1
inet_peer_cache        0     59     64    0    1    1
secpath_cache          0      0    128    0    0    1
xfrm_dst_cache         0      0    256    0    0    1
ip_dst_cache          23     45    256    2    3    1
arp_cache              6     30    128    1    1    1
flow_cache             0      0    128    0    0    1
blkdev_requests     2048   2070    128   69   69    1
devfsd_event           0      0     20    0    0    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache       19     42     92    1    1    1
fasync_cache           0      0     16    0    0    1
uid_cache             10    112     32    1    1    1
skbuff_head_cache    400    500    192   25   25    1
sock                 123    342   1344   46  114    1
sigqueue               5     29    132    1    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache             9    118     64    2    2    1
bdev_cache             6     59     64    1    1    1
mnt_cache             16     59     64    1    1    1
inode_cache       369522 491666    512 70224 70238    1
dentry_cache      172781 368580    128 12286 12286    1
dquot                  0      0    128    0    0    1
filp                1491   1500    128   50   50    1
names_cache            0      5   4096    0    5    1
buffer_head        28502  28530    128  951  951    1
mm_struct             49    100    192    3    5    1
vm_area_struct      1820   3480    128   71  116    1
fs_cache              53    118     64    2    2    1
files_cache           48     90    448    7   10    1
signal_act            61    102   1344   24   34    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      0  32768    0    0    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             7     11  16384    7   11    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              5     12   8192    5   12    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096            287    309   4096  287  309    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             97    242   2048   52  121    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             40     60   1024   12   15    1
size-512(DMA)          0      0    512    0    0    1
size-512              47     64    512    6    8    1
size-256(DMA)          0      0    256    0    0    1
size-256              22     75    256    3    5    1
size-128(DMA)          0      0    128    0    0    1
size-128            5995   6030    128  200  201    1
size-64(DMA)           0      0     64    0    0    1
size-64             7698   7729     64  131  131    1
size-32(DMA)           0      0     64    0    0    1
size-32            55711 126850     64 1172 2150    1

Servus,
       Daniel

--Apple-Mail-25--383157599
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQI+RlTBkNMiD99JrAQIHgwf8CPjTwub+KVB31WweReHSfZmMu+9TViVc
FPc2j5VM6IKSi0YEnqVXDbb4Y6D+5eVJckXEn9N4I2l0Ny93MHc9D7GS96l1+qyI
/Kgcw4idUSrxDrWJFs6WiRSN5USiHxauLOqSjBWnzcTWEMhA7YDMnexFm2qoO1Iu
3kleC7019MQQGsYkovCKvgXTlhUyqP3Do8qrNV9H/FyiKW33zhu2rGrJXKT+7k7A
ZU8kPJ6qhnn4W2ignLPwd1D5Y2ikYBkAm9InObZ/FBjdtFAWd8yY/NAv8z5SMD3g
1flMk2fQIGAekE1mTfUdJBFPXdT3LtT6ZXM+xo0XmBWpu6U9wEkB2w==
=BNFh
-----END PGP SIGNATURE-----

--Apple-Mail-25--383157599--

