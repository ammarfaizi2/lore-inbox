Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVIXRfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVIXRfo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 13:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVIXRfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 13:35:44 -0400
Received: from pihost.us ([208.3.80.9]:38621 "EHLO pihost.us")
	by vger.kernel.org with ESMTP id S932202AbVIXRfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 13:35:43 -0400
Date: Sat, 24 Sep 2005 11:35:43 -0600
From: Anthony Martinez <pi@pihost.us>
To: linux-kernel@vger.kernel.org
Subject: Problem: Kernel bug at mm/slab.c:2839
Message-ID: <20050924173543.GA15710@cnsp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Modeline: vim:tw=80:fo+=an:fo-=c:fo-=o
User-Agent: Mutt/1.5.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I triggered a BUG on my machine at mm/slab.c:2839. I am using 2.6.13.1 which I
compiled using make-kpkg on Debian. I don't know what to do to trigger it, as I
would wake up in the morning, *occasionally* finding my machine locked up. I
finally had the presence of mind to take it out of X before I went to sleep so
I could see the panic message, which is how I captured it.

My hardware is an IBM Thinkpad a31p, Pentium-4 Mobile, 2GHz, 512 MB DDR RAM,
Intel 82801 chipset, Prism2.5 minipci wireless, Intel pro/100 ethernet, Radeon
Mobility 7800.

I ran one pass of memtest, which didn't see any obvious problems.

I attached all that I could think of that might help, but I'm not an expert
at this. So, if you need any more information, please ask me.

Thanks,

Anthony Martinez

Here's the BUG:

BeFS(hdb1): Name using character set cp437 contains a character that cannot be converted to unicode.
BeFS(hdb1): Name using character set cp437 contains a character that cannot be converted to unicode.
BeFS(hdb1): Name using character set cp437 contains a character that cannot be converted to unicode.
------------[ cut here ]--------------
kernel BUG at mm/slab.c:2839!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: rfcomm l2cap bluetooth nfsd exportfs lockd sunrpc nsc_ircc lp ipt_state ip_conntrack iptable_filter ip_tables tun thermal fan button processor ac battery hostap_crypt_wep mousedev evdev irtty_sir sir_dev irda crc_ccitt parport_pc parport pcspkr hostap_pci hostap snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc i2c_i801 hw_random uhci_hcd usbcore e100 mii ohci1394 yenta_socket rsrc_nonstatic befs nls_iso8859_1 nls_cp437 capability commoncap sr_mod sbp2 scsi_mod ieee1394 psmouse nvram thinkpad cpufreq_userspace speedstep_ich freq_table speedstep_lib
CPU:    0
EIP:    0060:[<c01383bd>]   Not tainted VLI
EFLAGS: 00010002  (2.6.13.1-coffee)
EIP is at cache_reap+0xb2/0x16f
eax: dff6f69c  ebx: dff6f680  ecx: 00000001 edx: dff28000
esi: da96bbe0  edi: 00000001  ebp: dff6f6f0 esp: dff29f68
ds: 007b  es: 007b  ss: 0068
Process events/0 (pid: 3, threadinfo=dff28000 task=dff52020)
Stack: c044b9c4 00000297 c044b9c0 dff6b680 c01250a3 00000000 c013830b 00000000
       00000001 00000000 dff52148 00010000 00000000 00000000 dff52020 c0114813
       00100100 00200200 ffffffff ffffffff dff28000 dff1ff78 dff6b680 c0124f31
Call Trace:
 [<c01250a3>] worker_thread+0x172/0x1fd
 [<c013830b>] cache_reap+0x0/0x16f
 [<c0114813>] default_wake_function+0x0/0x12
 [<c0124f31>] worker_thread+0x0/0x1fd
 [<c0128621>] kthread+0x69/0x96
 [<c01285b8>] kthread+0x0/0x96
 [<c01012c9>] kernel_thread_helper+0x5/0xb
Code: 00 00 00 e9 81 00 00 00 6b 4b 3c 05 8b 53 40 01 ca 4a 89 d0 31 d2 f7 f1 89 c7 8b 73 1c 8d 43 1c 39 c6 74 65 83 7e 10 00 74 08 <0f> 0b 17 0b 98 d8 31 c0 8b 16 8b 46 04 89 42 04 89 10 c7 06 00
 <6>note: events/0[3] exited with preempt_count 1
BeFS(hdb1): Name using character set cp437 contains a character that cannot be converted to unicode.



Here is some other information:

/proc/version:
Linux version 2.6.13.1-coffee (pi@coffeehost) (gcc version 4.0.2 20050913 (prerelease) (Debian 4.0.1-7)) #1 Sat Sep 17 12:32:19 MDT 2005

/proc/slabinfo:

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
scsi_cmd_cache        10     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : slabdata      4      4      0
rpc_tasks              8     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
rpc_inode_cache        0      0    512    7    1 : tunables   54   27    0 : slabdata      0      0      0
ip_conntrack_expect      0      0     88   45    1 : tunables  120   60    0 : slabdata      0      0      0
ip_conntrack          28     64    248   16    1 : tunables  120   60    0 : slabdata      4      4      0
ip_fib_alias          12    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_fib_hash           12    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
uhci_urb_priv         64     88     44   88    1 : tunables  120   60    0 : slabdata      1      1      0
befs_inode_cache       1      8    492    8    1 : tunables   54   27    0 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    0 : slabdata      2      2      0
UNIX                 256    260    384   10    1 : tunables   54   27    0 : slabdata     26     26      0
tcp_tw_bucket          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket       47    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
secpath_cache          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    384   10    1 : tunables   54   27    0 : slabdata      0      0      0
ip_dst_cache          71    120    256   15    1 : tunables  120   60    0 : slabdata      8      8      0
arp_cache              3     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
RAW                    2      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
UDP                   23     28    512    7    1 : tunables   54   27    0 : slabdata      4      4      0
request_sock_TCP       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
TCP                   48     52   1024    4    1 : tunables   54   27    0 : slabdata     13     13      0
flow_cache             0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
cfq_ioc_pool          77     81     48   81    1 : tunables  120   60    0 : slabdata      1      1      0
cfq_pool              77     82     96   41    1 : tunables  120   60    0 : slabdata      2      2      0
crq_pool              72     88     44   88    1 : tunables  120   60    0 : slabdata      1      1      0
mqueue_inode_cache      1      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
isofs_inode_cache      0      0    344   11    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache       55     55    368   11    1 : tunables   54   27    0 : slabdata      5      5      0
fat_cache              3    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
ext2_inode_cache       0      0    444    9    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
journal_handle         0      0     20  185    1 : tunables  120   60    0 : slabdata      0      0      0
journal_head           0      0     52   75    1 : tunables  120   60    0 : slabdata      0      0      0
revoke_table           0      0     12  290    1 : tunables  120   60    0 : slabdata      0      0      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache       0      0    464    8    1 : tunables   54   27    0 : slabdata      0      0      0
ext3_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
reiser_inode_cache  10143  10690    392   10    1 : tunables   54   27    0 : slabdata   1069   1069      0
dnotify_cache         17    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
eventpoll_pwq          2    107     36  107    1 : tunables  120   60    0 : slabdata      1      1      0
eventpoll_epi          2     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
inotify_event_cache      0      0     28  135    1 : tunables  120   60    0 : slabdata      0      0      0
inotify_watch_cache      0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache    867    873    408    9    1 : tunables   54   27    0 : slabdata     97     97      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache             10     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_ioc            67    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          41     50    380   10    1 : tunables   54   27    0 : slabdata      5      5      0
blkdev_requests       71     78    152   26    1 : tunables  120   60    0 : slabdata      3      3      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    270    256   15    1 : tunables  120   60    0 : slabdata     18     18      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             260    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  260    279    128   31    1 : tunables  120   60    0 : slabdata      9      9      0
file_lock_cache       12     45     88   45    1 : tunables  120   60    0 : slabdata      1      1      0
sock_inode_cache     339    350    384   10    1 : tunables   54   27    0 : slabdata     35     35      0
skbuff_head_cache    120    180    256   15    1 : tunables  120   60    0 : slabdata     12     12      0
proc_inode_cache     342    540    332   12    1 : tunables   54   27    0 : slabdata     45     45      0
sigqueue              54     54    148   27    1 : tunables  120   60    0 : slabdata      2      2      0
radix_tree_node     5113   6342    276   14    1 : tunables   54   27    0 : slabdata    453    453      0
bdev_cache            14     14    512    7    1 : tunables   54   27    0 : slabdata      2      2      0
sysfs_dir_cache     4539   4608     40   96    1 : tunables  120   60    0 : slabdata     48     48      0
mnt_cache             26     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         1541   1788    316   12    1 : tunables   54   27    0 : slabdata    149    149      0
dentry_cache       13528  17922    136   29    1 : tunables  120   60    0 : slabdata    618    618      0
filp                3330   3390    256   15    1 : tunables  120   60    0 : slabdata    226    226      0
names_cache            9      9   4096    1    1 : tunables   24   12    0 : slabdata      9      9      0
key_jar               20     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
idr_layer_cache      100    116    136   29    1 : tunables  120   60    0 : slabdata      4      4      0
buffer_head        14510  14580     48   81    1 : tunables  120   60    0 : slabdata    180    180      0
mm_struct            114    114    640    6    1 : tunables   54   27    0 : slabdata     19     19      0
vm_area_struct      6435   6840     88   45    1 : tunables  120   60    0 : slabdata    152    152      0
fs_cache             119    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache          112    112    512    7    1 : tunables   54   27    0 : slabdata     16     16      0
signal_cache         150    150    384   10    1 : tunables   54   27    0 : slabdata     15     15      0
sighand_cache        145    145   1408    5    2 : tunables   24   12    0 : slabdata     29     29      0
task_struct          165    165   1280    3    1 : tunables   24   12    0 : slabdata     55     55      0
anon_vma            3076   3256      8  407    1 : tunables  120   60    0 : slabdata      8      8      0
pgd                  110    110   4096    1    1 : tunables   24   12    0 : slabdata    110    110      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768            14     14  32768    1    8 : tunables    8    4    0 : slabdata     14     14      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             1      1  16384    1    4 : tunables    8    4    0 : slabdata      1      1      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192            171    171   8192    1    2 : tunables    8    4    0 : slabdata    171    171      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096             93     93   4096    1    1 : tunables   24   12    0 : slabdata     93     93      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048             78     78   2048    2    1 : tunables   24   12    0 : slabdata     39     39      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            216    216   1024    4    1 : tunables   54   27    0 : slabdata     54     54      0
size-512(DMA)          4      8    512    8    1 : tunables   54   27    0 : slabdata      1      1      0
size-512             372    456    512    8    1 : tunables   54   27    0 : slabdata     57     57      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             240    240    256   15    1 : tunables  120   60    0 : slabdata     16     16      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            1891   1891    128   31    1 : tunables  120   60    0 : slabdata     61     61      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             3543   3782     64   61    1 : tunables  120   60    0 : slabdata     62     62      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             4729   5236     32  119    1 : tunables  120   60    0 : slabdata     44     44      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0


