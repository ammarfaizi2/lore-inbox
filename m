Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbTJHADc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 20:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTJHADc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 20:03:32 -0400
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([67.60.40.239]:15744
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S262896AbTJHADW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 20:03:22 -0400
From: "Shawn Starr" <spstarr@sh0n.net>
To: <linux-kernel@vger.kernel.org>
Subject: [2.6.0-test6-bk6] page allocation failure problems
Date: Tue, 7 Oct 2003 20:03:21 -0400
Message-ID: <000001c38d2f$983a1af0$030aa8c0@panic>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
sshd: page allocation failure. order:0, mode:0x20
named: page allocation failure. order:0, mode:0x20
bash: page allocation failure. order:0, mode:0x20
bash: page allocation failure. order:0, mode:0x20
multilog: page allocation failure. order:0, mode:0x20
tcpserver: page allocation failure. order:0, mode:0x20

Somehow, when I tried to transfer a lot of data over the network interface,
the box locked up. I came home and saw the above page allocation failures
(swapper). When I sysctl+I all the processes were reporting the same error.
The box was alive again. That said, ALL the ram on the system has been eaten
up!

Unless apache 2.0.xx somehow went into a mad memory eating binge I don't see
how this much ram could be gobbled up so quickly. The machine is idle for
the most part and handles a few internet services.

Has anyone else reported Page allocation failure issues recently?

The system specs:

Pentium III Katmai 450Mhz w/ 512kb cache
576MB RAM PC100

             total       used       free     shared    buffers     cached
Mem:        578912     573008       5904          0       1320       4620
-/+ buffers/cache:     567068      11844
Swap:        72284         72      72212

Memory reported:

/proc/slabinfo:

slabinfo - version: 2.0 (statistics)
# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata
<active_slabs> <num_slabs> <sharedavail> : globalstat <listallocs> <maxobjs>
<grown> <reaped> <error> <maxfreeable> <freelimit> : cpustat <allochit>
<allocmiss> <freehit> <freemiss>
unix_sock              0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat     187     22   175  175    0
0   25 : cpustat    360    184    544      0
tcp_tw_bucket          0      0    100   39    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat     752     19    39   39    0
0   71 : cpustat      7     47     54      0
tcp_bind_bucket        5    126     28  126    1 : tunables   32   16    0 :
slabdata      1      1      0 : globalstat     432     30     1    0    0
0  158 : cpustat     47     27     69      0
tcp_open_request       0      0     68   56    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat    1248     16    78   78    0
0   88 : cpustat     62     78    140      0
inet_peer_cache        7     72     52   72    1 : tunables   32   16    0 :
slabdata      1      1      0 : globalstat     448     20     1    0    0
0  104 : cpustat      3     28     24      0
secpath_cache          0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
xfrm_dst_cache         0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
ip_fib_hash            9    126     28  126    1 : tunables   32   16    0 :
slabdata      1      1      0 : globalstat      16     16     1    0    0
0  158 : cpustat      8      1      0      0
ip_dst_cache          71     71   4096    1    1 : tunables   24   12    0 :
slabdata     71     71      0 : globalstat    5209    173  4579 3813    0
25   25 : cpustat    283   4709   4787    106
arp_cache              3      3   4096    1    1 : tunables   24   12    0 :
slabdata      3      3      0 : globalstat      53      4    51   48    0
0   25 : cpustat      0     53     50      0
raw4_sock              0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
udp_sock               3      3   4096    1    1 : tunables   24   12    0 :
slabdata      3      3      0 : globalstat       6      3     6    3    0
0   25 : cpustat      0      6      3      0
tcp_sock               9      9   4096    1    1 : tunables   24   12    0 :
slabdata      9      9      0 : globalstat     226     25   221  212    0
0   25 : cpustat    427    226    644      0
flow_cache             0      0    104   37    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   69 : cpustat      0      0      0      0
uhci_urb_priv          0      0     72   53    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   85 : cpustat      0      0      0      0
scsi_cmd_cache         1      1   4096    1    1 : tunables   24   12    0 :
slabdata      1      1      0 : globalstat       2      2     2    1    0
0   25 : cpustat      7      2      8      0
isofs_inode_cache      0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
ext2_inode_cache       0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
journal_handle         9     92     40   92    1 : tunables   32   16    0 :
slabdata      1      1      0 : globalstat  146336     18  6795 6794    0
0  124 : cpustat  58557   9146  67703      0
journal_head          24     63     60   63    1 : tunables   32   16    0 :
slabdata      1      1      0 : globalstat  221964    363    54   36    0
1   95 : cpustat  83622  13900  97328    178
revoke_table           2    145     24  145    1 : tunables   32   16    0 :
slabdata      1      1      0 : globalstat      16     16     1    0    0
0  177 : cpustat      1      1      0      0
revoke_record          0      0     28  126    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat     752    112    39   39    0
0  158 : cpustat    149     47    191      5
ext3_inode_cache     380    380   4096    1    1 : tunables   24   12    0 :
slabdata    380    380      0 : globalstat    7508   6358  7330  489    0
25   25 : cpustat    415   7349   6828    561
ext3_xattr             0      0     56   67    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   99 : cpustat      0      0      0      0
eventpoll_pwq          0      0     48   78    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0  110 : cpustat      0      0      0      0
eventpoll_epi          0      0     88   44    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   76 : cpustat      0      0      0      0
kioctx                 0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
kiocb                  0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
dnotify_cache          0      0     32  113    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0  145 : cpustat      0      0      0      0
file_lock_cache       10     30    128   30    1 : tunables   32   16    0 :
slabdata      1      1      0 : globalstat     720     30     1    0    0
0   62 : cpustat   3303     45   3338      0
fasync_cache           0      0     28  126    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat      16     16     1    1    0
0  158 : cpustat      0      1      1      0
shmem_inode_cache      4      4   4096    1    1 : tunables   24   12    0 :
slabdata      4      4      0 : globalstat      17      9    17   13    0
0   25 : cpustat      0     17     13      0
idr_layer_cache        0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
posix_timers_cache      0      0   4096    1    1 : tunables   24   12    0
: slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
uid_cache              6    101     36  101    1 : tunables   32   16    0 :
slabdata      1      1      0 : globalstat     736     24     1    0    0
0  133 : cpustat     13     46     53      0
sgpool-MAX_PHYS_SEGMENTS     32     32   4096    1    1 : tunables   24   12
0 : slabdata     32     32      0 : globalstat      32     32    32    0
0    0   25 : cpustat      0     32      0      0
sgpool-64             32     32   4096    1    1 : tunables   24   12    0 :
slabdata     32     32      0 : globalstat      32     32    32    0    0
0   25 : cpustat      0     32      0      0
sgpool-32             32     32   4096    1    1 : tunables   24   12    0 :
slabdata     32     32      0 : globalstat      32     32    32    0    0
0   25 : cpustat      0     32      0      0
sgpool-16             32     32   4096    1    1 : tunables   24   12    0 :
slabdata     32     32      0 : globalstat      32     32    32    0    0
0   25 : cpustat      0     32      0      0
sgpool-8              32     32   4096    1    1 : tunables   24   12    0 :
slabdata     32     32      0 : globalstat      32     32    32    0    0
0   25 : cpustat      0     32      0      0
deadline_drq           0      0     60   63    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   95 : cpustat      0      0      0      0
as_arq                20     53     72   53    1 : tunables   32   16    0 :
slabdata      1      1      0 : globalstat  151808    138    26    8    0
1   85 : cpustat 257696   9516 267031    165
blkdev_requests       26     38   4096    1    1 : tunables   24   12    0 :
slabdata     26     38      0 : globalstat   32425    129 11076 10478    0
25   25 : cpustat 236641  30571 267013    183
biovec-BIO_MAX_PAGES    256    256   4096    1    1 : tunables   24   12
0 : slabdata    256    256      0 : globalstat     256    256   256    0
0    0   25 : cpustat      0    256      0      0
biovec-128           256    256   4096    1    1 : tunables   24   12    0 :
slabdata    256    256      0 : globalstat     256    256   256    0    0
0   25 : cpustat      0    256      0      0
biovec-64            256    256   4096    1    1 : tunables   24   12    0 :
slabdata    256    256      0 : globalstat     269    262   268   12    0
0   25 : cpustat    168    269    181      0
biovec-16            257    257   4096    1    1 : tunables   24   12    0 :
slabdata    257    257      0 : globalstat     499    274   484  227    0
0   25 : cpustat  22117    492  22353      0
biovec-4             258    315     60   63    1 : tunables   32   16    0 :
slabdata      5      5      0 : globalstat    1532    274     5    0    0
0   95 : cpustat  12802     96  12642      0
biovec-1             276    290     24  145    1 : tunables   32   16    0 :
slabdata      2      2      0 : globalstat  258663   1417   129   23    0
1  177 : cpustat 428686  16254 442107   2577
bio                  268    336     68   56    1 : tunables   32   16    0 :
slabdata      6      6      0 : globalstat  268762   1416   260   78    0
1   88 : cpustat 463184  16932 476670   3190
sock_inode_cache      17     17   4096    1    1 : tunables   24   12    0 :
slabdata     17     17      0 : globalstat     303     49   287  270    0
24   25 : cpustat    721    302   1004      2
skbuff_head_cache  66314  66314   4096    1    1 : tunables   24   12    0 :
slabdata  66314  66314      0 : globalstat   78982  66314 76133 9784    0
25   25 : cpustat 177154  87425 189273      8
sock                   2      2   4096    1    1 : tunables   24   12    0 :
slabdata      2      2      0 : globalstat       2      2     2    0    0
0   25 : cpustat      0      2      0      0
proc_inode_cache     203    203   4096    1    1 : tunables   24   12    0 :
slabdata    203    203      0 : globalstat     621    255   593  135    0
25   25 : cpustat    483    601    856     25
sigqueue               1      1   4096    1    1 : tunables   24   12    0 :
slabdata      1      1      0 : globalstat      38     23    34   33    0
0   25 : cpustat 178147    102 178185      0
radix_tree_node      343    343   4096    1    1 : tunables   24   12    0 :
slabdata    343    343      0 : globalstat    4806   2026  4058 1751    0
25   25 : cpustat 118769   4133 122307    252
bdev_cache             4      4   4096    1    1 : tunables   24   12    0 :
slabdata      4      4      0 : globalstat       5      4     5    1    0
0   25 : cpustat      0      5      1      0
mnt_cache             17     53     72   53    1 : tunables   32   16    0 :
slabdata      1      1      0 : globalstat      48     30     1    0    0
0   85 : cpustat     17      3      3      0
inode_cache          909    909   4096    1    1 : tunables   24   12    0 :
slabdata    909    909      0 : globalstat    1013    915  1011  102    0
0   25 : cpustat    163   1013    267      0
dentry_cache        1444   1444   4096    1    1 : tunables   24   12    0 :
slabdata   1444   1444      0 : globalstat   10619   8418 10274  508    0
25   25 : cpustat   1915  10333  10080    724
filp                 221    221   4096    1    1 : tunables   24   12    0 :
slabdata    221    221      0 : globalstat   29120    552  8522 7822    0
25   25 : cpustat  11237  28827  39799     44
names_cache            1      1   4096    1    1 : tunables   24   12    0 :
slabdata      1      1      0 : globalstat   20890      8  6970 6969    0
0   25 : cpustat 183429  20888 204317      0
buffer_head          297    441     60   63    1 : tunables   32   16    0 :
slabdata      7      7      0 : globalstat  191217  11703   221   12    0
1   95 : cpustat  66127  12656  76153   2345
mm_struct             32     32   4096    1    1 : tunables   24   12    0 :
slabdata     32     32      0 : globalstat     317     56   271  228    0
25   25 : cpustat    664    292    922      3
vm_area_struct       398    400     76   50    1 : tunables   32   16    0 :
slabdata      8      8      0 : globalstat    7434   1598    73   35    0
1   82 : cpustat  17950    521  17852    236
fs_cache              38     84     44   84    1 : tunables   32   16    0 :
slabdata      1      1      0 : globalstat    1520     69     2    1    0
0  116 : cpustat    431     95    494      2
files_cache           30     30   4096    1    1 : tunables   24   12    0 :
slabdata     30     30      0 : globalstat     248     54   218  177    0
25   25 : cpustat    297    229    493      3
signal_cache          55     67     56   67    1 : tunables   32   16    0 :
slabdata      1      1      0 : globalstat    1563     92     2    1    0
0   99 : cpustat    461    105    517      2
sighand_cache         37     37   4096    1    1 : tunables   24   12    0 :
slabdata     37     37      0 : globalstat     246     62   224  176    0
25   25 : cpustat    297    234    491      3
task_struct           47     47   4096    1    1 : tunables   24   12    0 :
slabdata     47     47      0 : globalstat     275     77   251  193    0
25   25 : cpustat    303    263    516      3
pte_chain           1282   1356     32  113    1 : tunables   32   16    0 :
slabdata     12     12      0 : globalstat   23595  11542   130   19    0
1  145 : cpustat  79536   1584  78641   1223
pgd                   32     32   4096    1    1 : tunables   24   12    0 :
slabdata     32     32      0 : globalstat     316     56   275  232    0
25   25 : cpustat    664    292    922      3
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0    9 : cpustat      0      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0    9 : cpustat      0      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0    9 : cpustat      0      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0    9 : cpustat      0      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0    9 : cpustat      0      0      0      0
size-32768             1      1  32768    1    8 : tunables    8    4    0 :
slabdata      1      1      0 : globalstat       2      1     2    1    0
0    9 : cpustat      0      2      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0    9 : cpustat      0      0      0      0
size-16384             1      1  16384    1    4 : tunables    8    4    0 :
slabdata      1      1      0 : globalstat     105      4    69   68    0
0    9 : cpustat    934     92   1025      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0    9 : cpustat      0      0      0      0
size-8192             47     47   8192    1    2 : tunables    8    4    0 :
slabdata     47     47      0 : globalstat     321     77   287  197    0
9    9 : cpustat    634    312    886     13
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
size-4096             59     59   4096    1    1 : tunables   24   12    0 :
slabdata     59     59      0 : globalstat     412     64   388  329    0
0   25 : cpustat   1072    413   1426      0
size-2048(DMA)         0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
size-2048          65628  65628   4096    1    1 : tunables   24   12    0 :
slabdata  65628  65628      0 : globalstat   66379  65628 66242  614    0
0   25 : cpustat  37455  66392  38190      0
size-1024(DMA)         0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
size-1024             94     94   4096    1    1 : tunables   24   12    0 :
slabdata     94     94      0 : globalstat     346    103   315  221    0
0   25 : cpustat  17700    343  17949      0
size-512(DMA)          0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
size-512             704    704   4096    1    1 : tunables   24   12    0 :
slabdata    704    704      0 : globalstat    6615    708  6178 5474    0
0   25 : cpustat  22226   6613  28136      0
size-256(DMA)          0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       1      1     1    1    0
0   25 : cpustat      6      1      7      0
size-256              98     98   4096    1    1 : tunables   24   12    0 :
slabdata     98     98      0 : globalstat    2648    100  2519 2421    0
0   25 : cpustat   3825   2648   6375      0
size-192(DMA)          0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
size-192              66     66   4096    1    1 : tunables   24   12    0 :
slabdata     66     66      0 : globalstat    1229     96  1108 1042    0
12   25 : cpustat  59674   1212  60821      1
size-128(DMA)          0      0   4096    1    1 : tunables   24   12    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   25 : cpustat      0      0      0      0
size-128             188    188   4096    1    1 : tunables   24   12    0 :
slabdata    188    188      0 : globalstat     194    193   194    6    0
0   25 : cpustat     76    194     82      0
size-96(DMA)           0      0    108   36    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   68 : cpustat      0      0      0      0
size-96             1330   1368    108   36    1 : tunables   32   16    0 :
slabdata     38     38      0 : globalstat    3100   1362    39    0    0
1   68 : cpustat   2647    232   1544     12
size-64(DMA)           0      0     76   50    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0   82 : cpustat      0      0      0      0
size-64              272    300     76   50    1 : tunables   32   16    0 :
slabdata      6      6      0 : globalstat     468    293     6    0    0
0   82 : cpustat   2018     42   1788      0
size-32(DMA)           0      0     44   84    1 : tunables   32   16    0 :
slabdata      0      0      0 : globalstat       0      0     0    0    0
0  116 : cpustat      0      0      0      0
size-32           138910 141372     44   84    1 : tunables   32   16    0 :
slabdata   1683   1683      0 : globalstat  162565 141624  1688    1    0
1  116 : cpustat 660774  11479 531978   1371
kmem_cache           116    120    192   20    1 : tunables   32   16    0 :
slabdata      6      6      0 : globalstat     116    116     6    0    0
0   52 : cpustat     64     38      0      0

Thanks, 

Shawn.

