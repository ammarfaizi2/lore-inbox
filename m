Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268917AbUHMBC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268917AbUHMBC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 21:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268919AbUHMBC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 21:02:27 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:13751 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S268917AbUHMBCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 21:02:15 -0400
Date: Thu, 12 Aug 2004 18:00:32 -0700
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Possible dcache BUG
Message-ID: <20040812180033.62b389db@laptop.delusion.de>
In-Reply-To: <Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040808113930.24ae0273.akpm@osdl.org>
	<200408100012.08945.gene.heskett@verizon.net>
	<200408102342.12792.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	<20040810211849.0d556af4@laptop.delusion.de>
	<Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__12_Aug_2004_18_00_33_-0700_xS0=hm_6iODFfPl9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__12_Aug_2004_18_00_33_-0700_xS0=hm_6iODFfPl9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 10 Aug 2004 22:15:34 -0700 (PDT) Linus Torvalds (LT) wrote:

LT> > So I suspect it's a balancing issue. Possibly just the slight change in 
LT> > slab balancing to fix the highmem problems. Maybe we shrink slab _too_ 
LT> > aggressively or something. 
LT> 
LT> Udo, that's a simple thing to check. If it's the slab balancing changes, 
LT> then you should be able to test it with just a
LT> 
LT> 	bk cset -x1.1830.4.3

Linus,

After nearly 2 days of running 2.6.8-rc4 with above patch backed out, the 
machine has gone back into heavy swapping, being rather unresponsive for
several minutes. At that time the only bigger applications running were
X and my mailer, as can be seen in the ps output below.

-Udo.

MemTotal:       125124 kB
MemFree:          1812 kB
Buffers:           216 kB
Cached:           2796 kB
SwapCached:      10024 kB
Active:           8352 kB
Inactive:         4800 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       125124 kB
LowFree:          1812 kB
SwapTotal:      506512 kB
SwapFree:       457116 kB
Dirty:               0 kB
Writeback:         904 kB
Mapped:           8924 kB
Slab:           107936 kB
Committed_AS:    53088 kB
PageTables:        500 kB
VmallocTotal:   909268 kB
VmallocUsed:      8936 kB
VmallocChunk:   900312 kB

slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : slabdata      4      4      0
rpc_tasks              8     25    160   25    1 : tunables  120   60    0 : slabdata      1      1      0
rpc_inode_cache        0      0    416    9    1 : tunables   54   27    0 : slabdata      0      0      0
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
fib6_nodes             5    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
ip6_dst_cache          5     18    224   18    1 : tunables  120   60    0 : slabdata      1      1      0
ndisc_cache            1     25    160   25    1 : tunables  120   60    0 : slabdata      1      1      0
raw6_sock              0      0    640    6    1 : tunables   54   27    0 : slabdata      0      0      0
udp6_sock              0      0    608    6    1 : tunables   54   27    0 : slabdata      0      0      0
tcp6_sock              6      7   1120    7    2 : tunables   24   12    0 : slabdata      1      1      0
unix_sock             31     40    384   10    1 : tunables   54   27    0 : slabdata      4      4      0
ip_conntrack           1     25    160   25    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_tw_bucket          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket        5    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
secpath_cache          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_hash            9    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache          65     75    256   15    1 : tunables  120   60    0 : slabdata      5      5      0
arp_cache              1     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    480    8    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               1      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock               8      8   1024    4    1 : tunables   54   27    0 : slabdata      2      2      0
flow_cache             0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uhci_urb_priv          0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
ntfs_big_inode_cache      0      0    448    9    1 : tunables   54   27    0 : slabdata      0      0      0
ntfs_inode_cache       0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
ntfs_name_cache        0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
ntfs_attr_ctx_cache      0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
ntfs_index_ctx_cache      0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
smb_request            0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
smb_inode_cache        0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
nfs_write_data        36     36    448    9    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_read_data         32     36    416    9    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_inode_cache        0      0    544    7    1 : tunables   54   27    0 : slabdata      0      0      0
nfs_page               0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
isofs_inode_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache        0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_inode_cache       0      0    416    9    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
journal_handle         4    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head          36    324     48   81    1 : tunables  120   60    0 : slabdata      4      4      0
revoke_table          12    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          1    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ext3_inode_cache     284    549    448    9    1 : tunables   54   27    0 : slabdata     61     61      0
ext3_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    0 : slabdata      0      0      0
file_lock_cache        1     43     92   43    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache      5     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              2    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
cfq_pool              64    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool               0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq               130    195     60   65    1 : tunables  120   60    0 : slabdata      3      3      0
blkdev_ioc            34    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue           9      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
blkdev_requests      122    182    152   26    1 : tunables  120   60    0 : slabdata      7      7      0
biovec-(256)          60     60   3072    2    2 : tunables   24   12    0 : slabdata     30     30      0
biovec-128           121    125   1536    5    2 : tunables   24   12    0 : slabdata     25     25      0
biovec-64            250    250    768    5    1 : tunables   54   27    0 : slabdata     50     50      0
biovec-16            251    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             249    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             512    678     16  226    1 : tunables  120   60    0 : slabdata      3      3      0
bio                  510   1281     64   61    1 : tunables  120   60    0 : slabdata     21     21      0
sock_inode_cache      51     66    352   11    1 : tunables   54   27    0 : slabdata      6      6      0
skbuff_head_cache    600    740    192   20    1 : tunables  120   60    0 : slabdata     37     37      0
sock                   4     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache      52    288    320   12    1 : tunables   54   27    0 : slabdata     24     24      0
sigqueue              27     27    148   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node      419   1078    276   14    1 : tunables   54   27    0 : slabdata     77     77      0
bdev_cache            10     18    416    9    1 : tunables   54   27    0 : slabdata      2      2      0
mnt_cache             23     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         1056   1078    288   14    1 : tunables   54   27    0 : slabdata     77     77      0
dentry_cache        1413   2436    140   28    1 : tunables  120   60    0 : slabdata     87     87      0
filp                 441    750    160   25    1 : tunables  120   60    0 : slabdata     30     30      0
names_cache           13     13   4096    1    1 : tunables   24   12    0 : slabdata     13     13      0
idr_layer_cache       82     87    136   29    1 : tunables  120   60    0 : slabdata      3      3      0
buffer_head          152    891     48   81    1 : tunables  120   60    0 : slabdata     11     11      0
mm_struct             37     56    512    7    1 : tunables   54   27    0 : slabdata      8      8      0
vm_area_struct       929   1598     84   47    1 : tunables  120   60    0 : slabdata     34     34      0
fs_cache              38    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           37     72    416    9    1 : tunables   54   27    0 : slabdata      8      8      0
signal_cache          60    123     96   41    1 : tunables  120   60    0 : slabdata      3      3      0
sighand_cache         53     60   1312    3    1 : tunables   24   12    0 : slabdata     20     20      0
task_struct           60     80   1424    5    2 : tunables   24   12    0 : slabdata     16     16      0
anon_vma             455    814      8  407    1 : tunables  120   60    0 : slabdata      2      2      0
pgd                   37     37   4096    1    1 : tunables   24   12    0 : slabdata     37     37      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768            28     28  32768    1    8 : tunables    8    4    0 : slabdata     28     28      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             3      3  16384    1    4 : tunables    8    4    0 : slabdata      3      3      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             61     61   8192    1    2 : tunables    8    4    0 : slabdata     61     61      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096             34     34   4096    1    1 : tunables   24   12    0 : slabdata     34     34      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048             32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            246    252   1024    4    1 : tunables   54   27    0 : slabdata     63     63      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             380    568    512    8    1 : tunables   54   27    0 : slabdata     71     71      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             335    480    256   15    1 : tunables  120   60    0 : slabdata     32     32      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             220    220    192   20    1 : tunables  120   60    0 : slabdata     11     11      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128             323    372    128   31    1 : tunables  120   60    0 : slabdata     12     12      0
size-96(DMA)           0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
size-96             1629   1681     96   41    1 : tunables  120   60    0 : slabdata     41     41      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64           1554463 1554463     64   61    1 : tunables  120   60    0 : slabdata  25483  25483      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             2618   2737     32  119    1 : tunables  120   60    0 : slabdata     23     23      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

nr_dirty 0
nr_writeback 0
nr_unstable 0
nr_page_table_pages 125
nr_mapped 2558
nr_slab 26996
pgpgin 6850970
pgpgout 2663539
pswpin 346485
pswpout 178555
pgalloc_high 0
pgalloc_normal 54477318
pgalloc_dma 7478366
pgfree 61956118
pgactivate 696231
pgdeactivate 1111221
pgfault 13656600
pgmajfault 138898
pgrefill_high 0
pgrefill_normal 11740872
pgrefill_dma 1307467
pgsteal_high 0
pgsteal_normal 1842048
pgsteal_dma 297724
pgscan_kswapd_high 0
pgscan_kswapd_normal 5756289
pgscan_kswapd_dma 1211228
pgscan_direct_high 0
pgscan_direct_normal 886314
pgscan_direct_dma 151569
pginodesteal 68
slabs_scanned 1428023
kswapd_steal 1655861
kswapd_inodesteal 805
pageoutrun 15255
allocstall 9684
pgrotated 177966

  PID TTY      STAT   TIME  MAJFL   TRS   DRS  RSS %MEM COMMAND
    1 ?        S      0:01    319   446    33   52  0.0 init [4]        
    2 ?        SN     0:00      0     0     0    0  0.0 [ksoftirqd/0]
    3 ?        S<     0:00      0     0     0    0  0.0 [events/0]
    4 ?        S<     0:00      0     0     0    0  0.0 [khelper]
    5 ?        S<     0:02      0     0     0    0  0.0 [kacpid]
   22 ?        S<     0:01      0     0     0    0  0.0 [kblockd/0]
   23 ?        S      0:00      0     0     0    0  0.0 [khubd]
   40 ?        S<     0:00      0     0     0    0  0.0 [aio/0]
   39 ?        S      0:12      0     0     0    0  0.0 [kswapd0]
  142 ?        S      0:00      0     0     0    0  0.0 [pccardd]
  144 ?        S      0:00      0     0     0    0  0.0 [pccardd]
  152 ?        S      0:00      0     0     0    0  0.0 [kseriod]
  171 ?        S      0:00      0     0     0    0  0.0 [kjournald]
  330 ?        S      0:00      0     0     0    0  0.0 [kjournald]
  331 ?        S<     1:31      0     0     0    0  0.0 [loop0]
  332 ?        S      0:00      0     0     0    0  0.0 [kjournald]
  333 ?        S      0:00      0     0     0    0  0.0 [kjournald]
  334 ?        S      0:00      0     0     0    0  0.0 [kjournald]
  335 ?        S      0:00      0     0     0    0  0.0 [kjournald]
  497 ?        Ss     0:00    374    23  1384   80  0.0 /usr/sbin/syslogd -m 0
  511 ?        Ss     0:00     27    18  1325    0  0.0 /usr/sbin/klogd -c 3 -x
  514 ?        Ss     0:00      7    39  1444    0  0.0 /sbin/cardmgr
  857 ?        Ss     0:00      7    20  1459    0  0.0 /sbin/rpc.portmap
  898 ?        Ss     0:00      7    19  1360    0  0.0 /usr/sbin/inetd
  904 ?        Ss     0:00      7   899  3188    0  0.0 /usr/local/sbin/sshd
  914 ?        S      0:00    273    11  1448  184  0.1 /usr/sbin/crond -l10
  917 ?        Ss     0:00      6    15  1332    0  0.0 /usr/sbin/acpid
  930 ?        Ss     0:00     93    59  1324   60  0.0 /usr/sbin/gpm -m /dev/mouse -t ps2
  933 ?        S      0:00    168   158  1529   44  0.0 /usr/sbin/smartd
  948 tty2     Ss+    0:00      7    11  1324    0  0.0 /sbin/agetty 38400 tty2 linux
  949 tty3     Ss+    0:00      7    11  1324    0  0.0 /sbin/agetty 38400 tty3 linux
  950 tty4     Ss+    0:00      7    11  1324    0  0.0 /sbin/agetty 38400 tty4 linux
  951 tty5     Ss+    0:00      7    11  1324    0  0.0 /sbin/agetty 38400 tty5 linux
  952 tty6     Ss+    0:00      7    11  1324    0  0.0 /sbin/agetty 38400 tty6 linux
  953 tty7     Ss+    0:00      6    11  1324    0  0.0 /sbin/agetty 38400 tty7 linux
  955 tty8     Ss+    0:00      6    11  1324    0  0.0 /sbin/agetty 38400 tty8 linux
  959 tty9     Ss+    0:00      6    11  1324    0  0.0 /sbin/agetty 38400 tty9 linux
  962 tty10    Ss+    0:00      5    11  1324    0  0.0 /sbin/agetty 38400 tty10 linux
  964 ?        Ss     0:00     10    98  3069    0  0.0 /usr/X11R6/bin/xdm -nodaemon
 1081 ?        S     43:25  25126  1505 39590 1712  1.3 /usr/X11R6/bin/X -auth /usr/X11R6/lib/X11/xdm/authdir/authfiles/A:0-dhgq55
 1082 ?        S      0:00      9    98  3517    0  0.0 -:0                         
 1159 ?        S      0:00      0     0     0    0  0.0 [eth1]
 1222 ?        Ss     0:01    217    33  1338  140  0.1 /sbin/dhcpcd -d eth1
 1229 ?        S      0:04   2325   313  3858  476  0.3 blackbox
 1258 ?        S     10:40    245    38  2449  276  0.2 /home/uas/bin/wmbatteries
 1260 ?        S      0:06     87    21  2390  248  0.1 /home/uas/bin/wmcpuload -a -n -lc rgb:ff/ff/33
 1262 ?        S      4:16     84    31  2392  232  0.1 /home/uas/bin/wmnetload -n eth1
 1264 ?        S      0:04     56    19  2388  156  0.1 /home/uas/bin/wmmemload -am -b -c -lc rgb:ff/80/30
 1266 ?        S      0:24    104    28  2391  224  0.1 /home/uas/bin/wmtime -lc rgb:33/33/ff
 1270 ?        Ds     0:00    406    11  2252  220  0.1 /home/uas/bin/root-tail -f -g 350x10+5-10 -fn -schumacher-clean-medium-r-*-*-10-*-*-*-*-*-*-* -color rgb:cc/cc/ff /var/log/messages rgb:88/88/ff /var/log/syslog rgb:ff/88/ff /var/log/maillog
 1294 tty1     Ss+    0:00      5    11  1324    0  0.0 /sbin/agetty 38400 tty1 linux
 4093 ?        S      0:01      0     0     0    0  0.0 [pdflush]
 4707 ?        S      0:00      0     0     0    0  0.0 [pdflush]
 5222 ?        Ss     0:00    429    98  3733  568  0.4 /home/uas/bin/aterm -geometry 80x25
 5223 pts/0    Ss     0:00    313   586  2089  632  0.5 -bash
 5449 ?        Ds     0:15  21414  1403 39548 5784  4.6 sylpheed
 5501 ?        D      0:00     14    11  1452  444  0.3 /usr/sbin/crond -l10
 5502 pts/0    R+     0:00     16    60  2087  652  0.5 ps axv

--Signature=_Thu__12_Aug_2004_18_00_33_-0700_xS0=hm_6iODFfPl9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBHBK3nhRzXSM7nSkRAgcSAJ9dJyPmxdcwLdM2zigI+x0vaDqqywCeK60I
oLG9iKP+CVWRhwF8mcSddjY=
=Rbha
-----END PGP SIGNATURE-----

--Signature=_Thu__12_Aug_2004_18_00_33_-0700_xS0=hm_6iODFfPl9--
