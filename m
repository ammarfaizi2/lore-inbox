Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVGEQE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVGEQE0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVGEQEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:04:16 -0400
Received: from serv4.servweb.de ([82.96.83.76]:63208 "EHLO serv4.servweb.de")
	by vger.kernel.org with ESMTP id S261890AbVGEPub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:50:31 -0400
Date: Tue, 5 Jul 2005 17:50:21 +0200
From: Patrick Plattes <patrick@erdbeere.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org,
       Aleksander Pavic <aleksander.pavic@t-online.de>
Subject: Re: Memory leak with 2.6.12 and cdrecord
Message-ID: <20050705155021.GA10277@erdbeere.net>
References: <20050705113343.GA6349@erdbeere.net> <1120565206.12942.3.camel@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120565206.12942.3.camel@linux>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 02:06:45PM +0200, Jens Axboe wrote:
> On Tue, 2005-07-05 at 13:33 +0200, Patrick Plattes wrote:
> > Hi Ho :-),
> > 
> > we have some trouble with the 2.6v kernel tree and CDRecord 2.01 (Debian
> > Sarge package). If we try to write an 150MB CD the memory fills up to
> > 150MB. The memory will not deallocate after closing cdrecord. Next if we
> > try to write an 200MB CD the memory will filled up to additional 50MB.
> > 
> > We don't know which part of the software is steals our memory. This only
> > happens on 2.6, not on an 2.4 system and we can reproduce the bug only
> > on the asus notebook.
> > 
> > We have tried to find the leak with top and slabtop, but inconclusively. I 
> > put some information together. The informations are taken from the system 
> > after burning a 154MB CD. Please have a look at: http://cdrecord.sourcecode.cc . 
> > I uploaded the files to this address, to avoid high traffic on the lkml.
> 
> Please post /proc/slabinfo as well.
> 
> -- 
> Jens Axboe <axboe@suse.de>
> 

Hi Jens,

sorry i forgot to upload the file. Now it is online.

Thanks,
Patrick


slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
udf_inode_cache        0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
isofs_inode_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache        0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    0 : slabdata      2      2      0
unix_sock             25     30    384   10    1 : tunables   54   27    0 : slabdata      3      3      0
tcp_tw_bucket          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket        0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_open_request       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
secpath_cache          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_hash            9    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache           0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
arp_cache              0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
raw4_sock              0      0    480    8    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               0      0    480    8    1 : tunables   54   27    0 : slabdata      0      0      0
tcp_sock               2      4   1024    4    1 : tunables   54   27    0 : slabdata      1      1      0
flow_cache             0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
mqueue_inode_cache      1      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
ext2_inode_cache       2      9    416    9    1 : tunables   54   27    0 : slabdata      1      1      0
journal_handle        16    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head          36    162     48   81    1 : tunables  120   60    0 : slabdata      2      2      0
revoke_table           8    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache    2772   2772    416    9    1 : tunables   54   27    0 : slabdata    308    308      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    0 : slabdata      0      0      0
file_lock_cache        0      0     92   43    1 : tunables  120   60    0 : slabdata      0      0      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache      9     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              1    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
cfq_pool              64    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool               0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                41     65     60   65    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_ioc            23    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue           2      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
blkdev_requests       17     26    152   26    1 : tunables  120   60    0 : slabdata      1      1      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             296    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  281    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
sock_inode_cache      30     33    352   11    1 : tunables   54   27    0 : slabdata      3      3      0
skbuff_head_cache    100    100    160   25    1 : tunables  120   60    0 : slabdata      4      4      0
sock                   2     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     264    264    320   12    1 : tunables   54   27    0 : slabdata     22     22      0
sigqueue              27     27    148   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     3448   3472    276   14    1 : tunables   54   27    0 : slabdata    248    248      0
bdev_cache             8      9    416    9    1 : tunables   54   27    0 : slabdata      1      1      0
mnt_cache             23     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         1780   1792    288   14    1 : tunables   54   27    0 : slabdata    128    128      0
dentry_cache        5992   5992    140   28    1 : tunables  120   60    0 : slabdata    214    214      0
filp                 600    600    160   25    1 : tunables  120   60    0 : slabdata     24     24      0
names_cache            4      4   4096    1    1 : tunables   24   12    0 : slabdata      4      4      0
idr_layer_cache       77     87    136   29    1 : tunables  120   60    0 : slabdata      3      3      0
buffer_head        10338  10368     48   81    1 : tunables  120   60    0 : slabdata    128    128      0
mm_struct             44     56    512    7    1 : tunables   54   27    0 : slabdata      8      8      0
vm_area_struct      1410   1410     84   47    1 : tunables  120   60    0 : slabdata     30     30      0
fs_cache              28    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           44     54    416    9    1 : tunables   54   27    0 : slabdata      6      6      0
signal_cache          44    123     96   41    1 : tunables  120   60    0 : slabdata      3      3      0
sighand_cache         51     51   1312    3    1 : tunables   24   12    0 : slabdata     17     17      0
task_struct           57     60   1424    5    2 : tunables   24   12    0 : slabdata     12     12      0
anon_vma             742    814      8  407    1 : tunables  120   60    0 : slabdata      2      2      0
pgd                   30     30   4096    1    1 : tunables   24   12    0 : slabdata     30     30      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             2      2  32768    1    8 : tunables    8    4    0 : slabdata      2      2      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384            15     15  16384    1    4 : tunables    8    4    0 : slabdata     15     15      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             49     49   8192    1    2 : tunables    8    4    0 : slabdata     49     49      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096             42     42   4096    1    1 : tunables   24   12    0 : slabdata     42     42      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048             33     36   2048    2    1 : tunables   24   12    0 : slabdata     18     18      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024             96    100   1024    4    1 : tunables   54   27    0 : slabdata     25     25      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             242    440    512    8    1 : tunables   54   27    0 : slabdata     55     55      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             138    405    256   15    1 : tunables  120   60    0 : slabdata     27     27      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128             839    868    128   31    1 : tunables  120   60    0 : slabdata     28     28      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             1951   1952     64   61    1 : tunables  120   60    0 : slabdata     32     32      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             1856   1904     32  119    1 : tunables  120   60    0 : slabdata     16     16      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

