Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269044AbUHMIhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269044AbUHMIhh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 04:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269048AbUHMIgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 04:36:06 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:3244 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S269044AbUHMIc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 04:32:56 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Fri, 13 Aug 2004 04:32:51 -0400
User-Agent: KMail/1.6.82
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <Pine.LNX.4.58.0408102159000.1839@ppc970.osdl.org> <200408130027.24470.gene.heskett@verizon.net>
In-Reply-To: <200408130027.24470.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408130432.51520.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.57.32] at Fri, 13 Aug 2004 03:32:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 August 2004 00:27, Gene Heskett wrote:
>On Wednesday 11 August 2004 00:59, Linus Torvalds wrote:
>>I wrote:
>>> Notably, the output of "/proc/meminfo" and "/proc/slabinfo". "ps
>>> axm" helps too.
>>
>>That should be "ps axv" of course. Just shows what a retard I am.
>>
>>		Linus
>
Acck!  I just logged another Oops, this time with only:
04:22:50 up  3:52,  5 users,  load average: 4.31, 2.95, 2.22
uptime.

Aug 13 04:20:21 coyote kernel: Unable to handle kernel paging request at virtual address 00003614
Aug 13 04:20:21 coyote kernel:  printing eip:
Aug 13 04:20:21 coyote kernel: c01632ae
Aug 13 04:20:21 coyote kernel: *pde = 00000000
Aug 13 04:20:21 coyote kernel: Oops: 0000 [#1]
Aug 13 04:20:21 coyote kernel: PREEMPT
Aug 13 04:20:21 coyote kernel: Modules linked in: eeprom snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd forcedeth sg
Aug 13 04:20:21 coyote kernel: CPU:    0
Aug 13 04:20:21 coyote kernel: EIP:    0060:[<c01632ae>]    Not tainted
Aug 13 04:20:21 coyote kernel: EFLAGS: 00010206   (2.6.8-rc4)
Aug 13 04:20:21 coyote kernel: EIP is at prune_dcache+0x14e/0x1c0
Aug 13 04:20:21 coyote kernel: eax: 00003600   ebx: dbbf3070   ecx: da707230   edx: da703430
Aug 13 04:20:21 coyote kernel: esi: da703420   edi: c198b000   ebp: c198bf04   esp: c198beec
Aug 13 04:20:21 coyote kernel: ds: 007b   es: 007b   ss: 0068
Aug 13 04:20:21 coyote kernel: Process kswapd0 (pid: 66, threadinfo=c198b000 task=c1978050)
Aug 13 04:20:21 coyote kernel: Stack: df5580fc c198bef0 00000046 00000080 00000000 c198b000 c198bf10 c0163770
Aug 13 04:20:21 coyote kernel:        00000080 c198bf44 c013a32c 00000080 000000d0 0001f3cf 02277700 00000000
Aug 13 04:20:21 coyote kernel:        0000011a 00000000 f7ffea60 c035c624 00000002 0000000a c198bf8c c013b639
Aug 13 04:20:21 coyote kernel: Call Trace:
Aug 13 04:20:21 coyote kernel:  [<c010476f>] show_stack+0x7f/0xa0
Aug 13 04:20:21 coyote kernel:  [<c0104908>] show_registers+0x158/0x1b0
Aug 13 04:20:21 coyote kernel:  [<c0104a89>] die+0x89/0x100
Aug 13 04:20:21 coyote kernel:  [<c0111725>] do_page_fault+0x1f5/0x553
Aug 13 04:20:21 coyote kernel:  [<c01043d9>] error_code+0x2d/0x38
Aug 13 04:20:21 coyote kernel:  [<c0163770>] shrink_dcache_memory+0x20/0x50
Aug 13 04:20:21 coyote kernel:  [<c013a32c>] shrink_slab+0x14c/0x190
Aug 13 04:20:21 coyote kernel:  [<c013b639>] balance_pgdat+0x1a9/0x1f0
Aug 13 04:20:21 coyote kernel:  [<c013b73f>] kswapd+0xbf/0xd0
Aug 13 04:20:21 coyote kernel:  [<c0102471>] kernel_thread_helper+0x5/0x14
Aug 13 04:20:21 coyote kernel: Code: 8b 50 14 85 d2 75 27 89 34 24 e8 83 2b 00 00 8b 73 0c 89 1c

[root@coyote themes]# cat /proc/meminfo
MemTotal:      1035844 kB
MemFree:          4184 kB
Buffers:         23072 kB
Cached:         109932 kB
SwapCached:        864 kB
Active:         171624 kB
Inactive:       113532 kB
HighTotal:      131008 kB
HighFree:          280 kB
LowTotal:       904836 kB
LowFree:          3904 kB
SwapTotal:     3857104 kB
SwapFree:      3827944 kB
Dirty:              76 kB
Writeback:           0 kB
Mapped:         195660 kB
Slab:           736384 kB
Committed_AS:   315580 kB
PageTables:       3200 kB
VmallocTotal:   114680 kB
VmallocUsed:     19644 kB
VmallocChunk:    94932 kB

But top says I'm 102140 K into the swap?????

slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
unix_sock            164    170    384   10    1 : tunables   54   27    0 : slabdata     17     17      0
tcp_tw_bucket          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket       19    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_hash           10    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache           4     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
arp_cache              3     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    480    8    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               2      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock              31     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
flow_cache             0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
mqueue_inode_cache      1      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
udf_inode_cache        0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
smb_request            0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
smb_inode_cache        2     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
isofs_inode_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache      132    132    352   11    1 : tunables   54   27    0 : slabdata     12     12      0
ext2_inode_cache       0      0    416    9    1 : tunables   54   27    0 : slabdata      0      0      0
journal_handle        16    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head        1357   2754     48   81    1 : tunables  120   60    0 : slabdata     34     34      0
revoke_table          12    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache  1328526 1328526    416    9    1 : tunables   54   27    0 : slabdata 147614 147614      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache        172    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
file_lock_cache       43     43     92   43    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache      5     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              9    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    0 : slabdata      2      2      0
cfq_pool              64    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool               0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq               130    195     60   65    1 : tunables  120   60    0 : slabdata      3      3      0
blkdev_ioc            76    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          12     18    448    9    1 : tunables   54   27    0 : slabdata      2      2      0
blkdev_requests       96    156    152   26    1 : tunables  120   60    0 : slabdata      6      6      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            265    265    768    5    1 : tunables   54   27    0 : slabdata     53     53      0
biovec-16            280    280    192   20    1 : tunables  120   60    0 : slabdata     14     14      0
biovec-4             272    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             364    678     16  226    1 : tunables  120   60    0 : slabdata      3      3      0
bio                  369    549     64   61    1 : tunables  120   60    0 : slabdata      9      9      0
sock_inode_cache     202    209    352   11    1 : tunables   54   27    0 : slabdata     19     19      0
skbuff_head_cache    245    400    160   25    1 : tunables  120   60    0 : slabdata     16     16      0
sock                   3     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     337    408    320   12    1 : tunables   54   27    0 : slabdata     34     34      0
sigqueue              27     27    148   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     5371  14994    276   14    1 : tunables   54   27    0 : slabdata   1071   1071      0
bdev_cache            11     18    416    9    1 : tunables   54   27    0 : slabdata      2      2      0
mnt_cache             26     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         2179   2212    288   14    1 : tunables   54   27    0 : slabdata    158    158      0
dentry_cache      1061172 1061172    140   28    1 : tunables  120   60    0 : slabdata  37899  37899      0
filp                1970   2150    160   25    1 : tunables  120   60    0 : slabdata     86     86      0
names_cache            9      9   4096    1    1 : tunables   24   12    0 : slabdata      9      9      0
idr_layer_cache       81     87    136   29    1 : tunables  120   60    0 : slabdata      3      3      0
buffer_head        11414  40014     48   81    1 : tunables  120   60    0 : slabdata    494    494      0
mm_struct             98     98    512    7    1 : tunables   54   27    0 : slabdata     14     14      0
vm_area_struct      7442   7802     84   47    1 : tunables  120   60    0 : slabdata    166    166      0
fs_cache              88    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           88     99    416    9    1 : tunables   54   27    0 : slabdata     11     11      0
signal_cache         108    123     96   41    1 : tunables  120   60    0 : slabdata      3      3      0
sighand_cache        102    105   1312    3    1 : tunables   24   12    0 : slabdata     35     35      0
task_struct          110    115   1424    5    2 : tunables   24   12    0 : slabdata     23     23      0
anon_vma            1674   2035      8  407    1 : tunables  120   60    0 : slabdata      5      5      0
pgd                   89     89   4096    1    1 : tunables   24   12    0 : slabdata     89     89      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             4      4  16384    1    4 : tunables    8    4    0 : slabdata      4      4      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             11     11   8192    1    2 : tunables    8    4    0 : slabdata     11     11      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096            184    184   4096    1    1 : tunables   24   12    0 : slabdata    184    184      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            166    170   2048    2    1 : tunables   24   12    0 : slabdata     85     85      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            120    120   1024    4    1 : tunables   54   27    0 : slabdata     30     30      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             169    448    512    8    1 : tunables   54   27    0 : slabdata     56     56      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             165    420    256   15    1 : tunables  120   60    0 : slabdata     28     28      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192              98    100    192   20    1 : tunables  120   60    0 : slabdata      5      5      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            1231   1240    128   31    1 : tunables  120   60    0 : slabdata     40     40      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64            49226  49227     64   61    1 : tunables  120   60    0 : slabdata    807    807      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             1309   1309     32  119    1 : tunables  120   60    0 : slabdata     11     11      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

But dentry_cache      1061172 ?

  PID TTY      STAT   TIME  MAJFL   TRS   DRS  RSS %MEM COMMAND
    1 ?        S      0:01     12    31  1440  480  0.0 init [3]  
    2 ?        SWN    0:00      0     0     0    0  0.0 [ksoftirqd/0]
    3 ?        SW<    0:00      0     0     0    0  0.0 [events/0]
    4 ?        SW<    0:00      0     0     0    0  0.0 [khelper]
   21 ?        SW<    0:01      0     0     0    0  0.0 [kblockd/0]
   22 ?        SW     0:00      0     0     0    0  0.0 [khubd]
   62 ?        SW     0:00      0     0     0    0  0.0 [kapmd]
   64 ?        SW     0:00      0     0     0    0  0.0 [pdflush]
   65 ?        SW     0:00      0     0     0    0  0.0 [pdflush]
   67 ?        SW<    0:00      0     0     0    0  0.0 [aio/0]
  194 ?        SW     0:00      0     0     0    0  0.0 [kseriod]
  231 ?        SW     0:00      0     0     0    0  0.0 [kjournald]
 1415 ?        SW     0:00      0     0     0    0  0.0 [kjournald]
 1416 ?        SW     0:00      0     0     0    0  0.0 [kjournald]
 1417 ?        SW     0:00      0     0     0    0  0.0 [kjournald]
 1418 ?        SW     0:00      0     0     0    0  0.0 [kjournald]
 1419 ?        SW     0:00      0     0     0    0  0.0 [kjournald]
 1886 ?        S      0:00      0    27  1432  580  0.0 syslogd -m 0
 1890 ?        S      0:00      0    20  1383  448  0.0 klogd -x
 1901 ?        S      0:00      1    27  1508  568  0.0 portmap
 1911 ?        S      0:00      0   141  1566  752  0.0 /usr/sbin/smartd
 1977 ?        S      0:00      1   149  2918  996  0.0 arpwatch -u pcap -e root -s root (Arpwatch)
 1986 ?        S      0:00      9   237  8886 3336  0.3 cupsd
 2114 ?        S      0:00      0   262  3385 1460  0.1 /usr/sbin/sshd
 2129 ?        S      0:00      1   143  1872  916  0.0 xinetd -stayalive -pidfile /var/run/xinetd.pid
 2151 ?        S      0:00      1   690  6357 2808  0.2 sendmail: accepting connections
 2162 ?        S      0:00      0   690  5433 2364  0.2 sendmail: Queue runner@01:00:00 for /var/spool/clientmqueue
 2172 ?        S      0:00      0    78  1521  460  0.0 gpm -m /dev/input/mice -t imps2
 2184 ?        S      0:00     34   250 22985 10396  1.0 /usr/sbin/httpd
 2237 ?        S      0:00      0   133  1758 1056  0.1 /usr/sbin/cannaserver -syslog -u bin
 2249 ?        S      0:00      1    23  1488  652  0.0 crond
 2261 ?        S      0:00      0   250 22985 10412  1.0 /usr/sbin/httpd
 2262 ?        S      0:00      0   250 22985 10408  1.0 /usr/sbin/httpd
 2263 ?        S      0:00      0   250 22985 10408  1.0 /usr/sbin/httpd
 2264 ?        S      0:00      0   250 22985 10408  1.0 /usr/sbin/httpd
 2265 ?        S      0:00      0   250 22985 10408  1.0 /usr/sbin/httpd
 2266 ?        S      0:00      0   250 22985 10408  1.0 /usr/sbin/httpd
 2267 ?        S      0:00      0   250 22985 10408  1.0 /usr/sbin/httpd
 2268 ?        S      0:00      0   250 22985 10408  1.0 /usr/sbin/httpd
 2320 ?        S      0:00     18    72  7383 6012  0.5 xfs -droppriv -daemon
 2329 ?        S      0:00      4  2727  7584 2676  0.2 smbd -D
 2333 ?        S      0:00      1   868  7183 2004  0.1 nmbd -D
 2347 ?        S      0:00      0   627  7324 2072  0.2 /sbin/mount.smbfs //gene.coyote.den/public /mnt/gene -o rw username root password XXXXXXXXX
 2349 ?        SW     0:00      0     0     0    0  0.0 [smbiod]
 2352 ?        S      0:00      0   627  7272 1980  0.1 /sbin/mount.smbfs //gene.coyote.den/dlds /mnt/dlds -o rw username root password XXXXXXXXX
 2369 ?        S      0:00      0    15  1484  604  0.0 /usr/sbin/atd
 2386 ?        S      0:00      0   230  1629  816  0.0 dbus-daemon-1 --system
 2399 ttyS0    S      0:13      4   153  1810  900  0.0 /usr/local/bulldog/upsd
 2498 ttyS1    S      0:00      0    44  1567  564  0.0 heyu_relay ck
 2499 ?        S      0:01      0    44  1571  556  0.0 heyu monitor
 2503 ?        S      0:00      0    19  1392  424  0.0 xtend -f /etc/.xtendrc
 2504 ?        S      0:00      0   554  3797 1176  0.1 /bin/sh /root/bin/setibatch -run
 2615 ?        S      0:00      3    17  2594 1072  0.1 login -- root     
 2616 tty2     S      0:00      0     8  1375  340  0.0 /sbin/mingetty tty2
 2617 tty3     S      0:00      0     8  1375  340  0.0 /sbin/mingetty tty3
 2618 tty4     S      0:00      0     8  1375  340  0.0 /sbin/mingetty tty4
 2619 tty5     S      0:00      0     8  1375  340  0.0 /sbin/mingetty tty5
 2620 tty6     S      0:00      0     8  1375  340  0.0 /sbin/mingetty tty6
 2771 tty1     S      0:00      0   554  3801 1332  0.1 -bash
 2803 tty1     S      0:00      0   554  3741 1012  0.0 /bin/sh /usr/X11R6/bin/startx
 2814 tty1     S      0:00      3     8  2195  508  0.0 xinit /etc/X11/xinit/xinitrc --
 2815 ?        S<     5:39     63  1498 153113 18040  1.7 X :0
 2829 tty1     S      0:00      1   554  3745  896  0.0 /bin/sh /root/kde3.3-beta2/bin/startkde
 2848 ?        S      0:00      0    55  3252  560  0.0 ssh-agent /etc/X11/xinit/Xclients
 2890 ?        S      0:00     15    34 24313 4156  0.4 kdeinit: Running...      
 2893 ?        S      0:00      6    34 23521 3608  0.3 kdeinit: dcopserver --nosid
 2895 ?        S      0:00     47    34 26377 4532  0.4 kdeinit: klauncher       
 2898 ?        S      0:01     50    34 28673 6096  0.5 kdeinit: kded            
 2899 ?        S      0:00     12   135  3136 1740  0.1 fam
 2907 ?        S      0:00      5    34 27025 5772  0.5 kdeinit: kxkb            
 2915 ?        S      0:06     72   154 19217 2588  0.2 artsd -F 11 -S 4096 -a alsa -s 15 -m artsmessage -c drkonqi -l 3 -f
 2917 ?        S      0:00     11    34 33445 5748  0.5 kdeinit: knotify         
 2918 tty1     S      0:00     25     1 20538 4560  0.4 ksmserver
 2919 ?        S      0:01     35    34 27273 6612  0.6 kdeinit: kwin -session 11c0a80103000104545060000000016110000_1092371276_861353
 2922 ?        S      0:00      2    34 25225 5220  0.5 kdeinit: khotkeys        
 2923 ?        S      0:03     39    34 30149 7712  0.7 kdeinit: kdesktop        
 2926 ?        S      0:03     90    34 32925 8216  0.7 kdeinit: kicker          
 2928 ?        S      0:00     33    34 42277 6432  0.6 kdeinit: klipper         
 2931 ?        S      0:01     23    61 30106 6588  0.6 korgac --miniicon korganizer
 2935 ?        S      0:00      6   830 28705 6520  0.6 kgpg -session 11c0a84703000109133389800000023980007_1092371276_68550
 2937 ?        S      0:00     11   240 30979 6068  0.5 knotes -session 11c0a84703000107107498500000013490017_1092371275_892454
 2939 ?        S      0:01      4    34 28801 7048  0.6 kdeinit: kmix -session 11c0a84703000109118722300000023870010_1092371275_970301
 2940 ?        S      0:01     17    34 31385 6768  0.6 kdeinit: konsole -session 11c0a84703000109146439400000023670008_1092371275_892612 -name Qt-subapplication
 2941 ?        S      0:06     49   590 31101 5060  0.4 /usr/bin/gkrellm --sm-client-id 11c0a84703000109197323200000021320011
 2944 pts/1    S      0:00      0   554  3801 1120  0.1 /bin/bash
 2952 ?        S      0:19      3    34 31369 6752  0.6 kdeinit: konsole -session 11c0a84703000109223264800000028730008_1092371276_29035 -name Qt-subapplication
 2953 ?        S      0:01     16    34 31377 7276  0.7 kdeinit: konsole -session 11c0a84703000109223268000000028730009_1092371275_892929 -name Qt-subapplication
 2955 ?        S      0:04     15  1060  4947 1608  0.1 /usr/local/bulldog/monitor
 2956 ?        S      0:00      1    96 25219 3616  0.3 kalarmd --login
 2965 pts/2    S      0:00      5   554  3805 1308  0.1 /bin/bash
 2976 pts/3    S      0:00      0   554  3801 1120  0.1 /bin/bash
 3005 ?        S      2:53    474    11 134332 76968  7.4 kmail
 3093 pts/1    S      0:00      0    33  3934  504  0.0 tail -f /var/log/messages
 3095 pts/3    S      0:26      1    47  1776  912  0.0 top
 7587 ?        S      0:00      0    37  2482  720  0.0 /usr/bin/esd -terminate -nobeeps -as 2 -spawnfd 17
 7923 ?        RN    16:18      7   131 17624 15104  1.4 /usr/local/bin/setiathome -stop_after_process -nice 19
 8081 ?        S      0:00      0    23  1492  656  0.0 CROND
 8082 ?        S      0:00      0   554  1449  824  0.0 /bin/bash /usr/bin/run-parts /etc/cron.daily
 8700 ?        S      0:00      0   690  5433 2432  0.2 /usr/sbin/sendmail -FCronDaemon -i -odi -oem root
10304 ?        SN     0:00      0   554  1449  788  0.0 /bin/sh /etc/cron.daily/slocate.cron
10305 ?        S      0:00      0   245  1558  496  0.0 awk -v progname=/etc/cron.daily/slocate.cron progname {?????   print progname ":\n"?????   progname="";????       }????       { print; }
10307 ?        DN     0:12      0    27  1508  712  0.0 /usr/bin/updatedb
10320 ?        S      0:00      3    34 51105 4676  0.4 kdeinit: kio_pop3 pop3 /tmp/ksocket-root/klauncherilvgna.slave-socket /tmp/ksocket-root/kmailkizaqa.slave-socket
10359 ?        S      0:00      8    34 26645 8180  0.7 kdeinit: kio_file file /tmp/ksocket-root/klauncherilvgna.slave-socket /tmp/ksocket-root/kmailWoeNac.slave-socket
10362 ?        S      0:00     48    34 28797 11940  1.1 kdeinit: kio_uiserver    
10371 pts/2    R      0:00      1    64  2143  576  0.0 ps axv

I won't repeat the dmesg as it, except for the Oops, will be the same.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
