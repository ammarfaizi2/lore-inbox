Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268073AbUHKOiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268073AbUHKOiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 10:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268071AbUHKOiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 10:38:12 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:14051 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S268073AbUHKOh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 10:37:58 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Wed, 11 Aug 2004 10:37:55 -0400
User-Agent: KMail/1.6.82
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_E9iGB9D0s2dehYH"
Message-Id: <200408111037.56062.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.9.122] at Wed, 11 Aug 2004 09:37:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_E9iGB9D0s2dehYH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 11 August 2004 01:15, Linus Torvalds wrote:
>On Tue, 10 Aug 2004, Linus Torvalds wrote:
>> So I suspect it's a balancing issue. Possibly just the slight
>> change in slab balancing to fix the highmem problems. Maybe we
>> shrink slab _too_ aggressively or something.
>
>Udo, that's a simple thing to check. If it's the slab balancing
> changes, then you should be able to test it with just a
>
>	bk cset -x1.1830.4.3
>
>if you have the current BK and are a BK user, or by just revertign
> the patch here ("patch -R -p1" from inside your linux source tree)
> if you're not a BK user..
>
>		Linus
>
With the previously attached patch reverted, a fresh kernel builds in:
real    7m18.296s
user    5m49.385s
sys     0m31.760s
which is a marked improvement, but still about 1m30 or so slow.

Is there anything in the /proc/slabinfo output I should watch 
carefully in hopes I can see things going to hell before they 
actually take the machine down?

The attachment is it with only about 20 minutes uptime.  I had been 
playing in the bios, turning off the 50% cpu throttle on overtemp, 
and managed to kill the bios, so I just turned it off till daylight 
again.  This bios seriously needs a tutorial on the interactions 
between various timeing related things.

[snip patch to revert]

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

--Boundary-00=_E9iGB9D0s2dehYH
Content-Type: text/plain;
  charset="us-ascii";
  name="slabinfo.new"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="slabinfo.new"

slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
unix_sock            157    160    384   10    1 : tunables   54   27    0 : slabdata     16     16      0
tcp_tw_bucket          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket       19    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_hash           10    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache           7     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
arp_cache              4     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    480    8    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               2      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock              31     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
flow_cache             0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
mqueue_inode_cache      1      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
udf_inode_cache        0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
smb_request            0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
smb_inode_cache        2     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
isofs_inode_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache        1     11    352   11    1 : tunables   54   27    0 : slabdata      1      1      0
ext2_inode_cache       0      0    416    9    1 : tunables   54   27    0 : slabdata      0      0      0
journal_handle         8    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head         106    972     48   81    1 : tunables  120   60    0 : slabdata     12     12      0
revoke_table          12    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache   23067  23067    416    9    1 : tunables   54   27    0 : slabdata   2563   2563      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache        172    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
file_lock_cache       43     43     92   43    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache      4     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              7    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    0 : slabdata      2      2      0
cfq_pool              80    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool              68    107     36  107    1 : tunables  120   60    0 : slabdata      1      1      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                 0      0     60   65    1 : tunables  120   60    0 : slabdata      0      0      0
blkdev_ioc            61    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          12     18    448    9    1 : tunables   54   27    0 : slabdata      2      2      0
blkdev_requests       54     78    152   26    1 : tunables  120   60    0 : slabdata      3      3      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             329    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  341    366     64   61    1 : tunables  120   60    0 : slabdata      6      6      0
sock_inode_cache     194    198    352   11    1 : tunables   54   27    0 : slabdata     18     18      0
skbuff_head_cache    245    375    160   25    1 : tunables  120   60    0 : slabdata     15     15      0
sock                   3     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     468    468    320   12    1 : tunables   54   27    0 : slabdata     39     39      0
sigqueue              27     27    148   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node    13342  13342    276   14    1 : tunables   54   27    0 : slabdata    953    953      0
bdev_cache            11     18    416    9    1 : tunables   54   27    0 : slabdata      2      2      0
mnt_cache             26     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         2184   2184    288   14    1 : tunables   54   27    0 : slabdata    156    156      0
dentry_cache       35876  35896    140   28    1 : tunables  120   60    0 : slabdata   1282   1282      0
filp                1930   2050    160   25    1 : tunables  120   60    0 : slabdata     82     82      0
names_cache           19     19   4096    1    1 : tunables   24   12    0 : slabdata     19     19      0
idr_layer_cache       81     87    136   29    1 : tunables  120   60    0 : slabdata      3      3      0
buffer_head        37260  37260     48   81    1 : tunables  120   60    0 : slabdata    460    460      0
mm_struct             84     84    512    7    1 : tunables   54   27    0 : slabdata     12     12      0
vm_area_struct      7079   7332     84   47    1 : tunables  120   60    0 : slabdata    156    156      0
fs_cache              93    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           81     81    416    9    1 : tunables   54   27    0 : slabdata      9      9      0
signal_cache         112    123     96   41    1 : tunables  120   60    0 : slabdata      3      3      0
sighand_cache         93     93   1312    3    1 : tunables   24   12    0 : slabdata     31     31      0
task_struct          100    100   1424    5    2 : tunables   24   12    0 : slabdata     20     20      0
anon_vma            1534   2035      8  407    1 : tunables  120   60    0 : slabdata      5      5      0
pgd                   80     80   4096    1    1 : tunables   24   12    0 : slabdata     80     80      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             6      6  16384    1    4 : tunables    8    4    0 : slabdata      6      6      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             10     10   8192    1    2 : tunables    8    4    0 : slabdata     10     10      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096            181    181   4096    1    1 : tunables   24   12    0 : slabdata    181    181      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            178    192   2048    2    1 : tunables   24   12    0 : slabdata     96     96      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            116    116   1024    4    1 : tunables   54   27    0 : slabdata     29     29      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             184    448    512    8    1 : tunables   54   27    0 : slabdata     56     56      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             180    420    256   15    1 : tunables  120   60    0 : slabdata     28     28      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             100    100    192   20    1 : tunables  120   60    0 : slabdata      5      5      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            1157   1209    128   31    1 : tunables  120   60    0 : slabdata     39     39      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64              606    610     64   61    1 : tunables  120   60    0 : slabdata     10     10      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             1369   1428     32  119    1 : tunables  120   60    0 : slabdata     12     12      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

--Boundary-00=_E9iGB9D0s2dehYH--
