Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267470AbRGLKzi>; Thu, 12 Jul 2001 06:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbRGLKza>; Thu, 12 Jul 2001 06:55:30 -0400
Received: from picard.csihq.com ([204.17.222.1]:35523 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S267470AbRGLKzN>;
	Thu, 12 Jul 2001 06:55:13 -0400
Message-ID: <05c401c10ac1$0e81ad70$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "Andrew Morton" <andrewm@uow.edu.au>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com> <3B4BD13F.6CC25B6F@uow.edu.au> <021801c10a03$62434540$e1de11cc@csihq.com> <3B4C729B.6352A443@uow.edu.au>
Subject: Re: 2.4.6 and ext3-2.4-0.9.1-246
Date: Thu, 12 Jul 2001 06:54:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope -- still locked up on 8 threads....however...it's apparently not RAID1
causing this.
I'm repeating this now on my SCSI 7x36G RAID5 set and seeing similar
behavior.  It's a little better though since its SCSI.
Since IDE hits the CPU harder the system appeared to lock up for a lot
longer -- it might have finished but I couldn't afford to wait that long.
The CPU is hitting 100% system usage which makes it appear as though it is
locked up.
I've got a vmstat running in a window and it pauses a lot.  When I was
testing the IDE RAID1 it paused (locked?) for a LONG time.
But , it is recovering from the 100% system usage and here what is has so
far:
tiobench.pl --size 4000
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  64.71 51.4% 0.826 2.00% 21.78 32.7% 1.218 0.85%
   .     4000   4096    2  23.28 21.7% 0.935 1.76% 7.374 39.1% 1.261 0.96%
   .     4000   4096    4  20.74 20.7% 1.087 2.50% 5.399 46.8% 1.278 1.09%

It's banging like crazy on the 8-thread run and I'm trying to let it finish
but it's really slow and non-responsive.
Here's the latest vmstat (10 second increments):
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 4 82  6      0   3604   4244 1902520   0   0     6  3342  386   347   0 100
0
 2 84  6      0   3620   4252 1902488   0   0     1  1506  173    17   0  99
1
 4 82  6      0   3636   4228 1902472   0   0     1  3749  448   237   0  84
16
 8 79  7      0   3620   4236 1902448   0   0     2   966  199    56   0  98
2
 4 80  6      0   3620   4252 1902336   0   0     1  1040  330   557   0 100
0
 0 86  5      0   3624   4252 1902332   0   0     0   627  335   725   0  98
2
15 75  5      0   3624   4264 1902636   0   0     1   953  494   182   0  90
10
16 76  6      0   3564   4280 1902748   0   0     1  1581  595   354   0  87
13
11 80  6      0   3564   4292 1902740   0   0     1  1337  174    67   0 100
0
18 74  6      0   3560   4308 1902716   0   0     0   703  313   353   0 100
0
 7 78  7      0   3560   4324 1902632   0   0     5  2181  301   626   0 100
0
 7 79  7      0   3560   4332 1902628   0   0     1   732  351   163   0 100
0
11 81  8      0   3224   4324 1902968   0   0     0     1  280   214   0 100
0
 9 76  7      0   3560   4332 1902624   0   0     0   569  270    83   0 100
0
 6 77  6      0   2832   4336 1903340   0   0     0   910  281   268   0 100
0
 3 83  7      0   3564   4336 1902604   0   0     0   487  281   130   0 100
0
17 77  7      0   3560   4344 1902600   0   0     0  1056  377   102   0 100
0
 9 76  7      0   3560   4364 1902256   0   0     1  3030  517   696   0 100
0
11 75  6      0   3560   4384 1902328   0   0     1  2145  230   131   0 100
0
12 72  7      0   3560   4416 1902296   0   0    16  2487  493    82   0  99
1
 9 76  6      0   3560   4424 1902084   0   0    82  1938  423  1124   0 100
0

______________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message -----
From: "Andrew Morton" <andrewm@uow.edu.au>
To: "Mike Black" <mblack@csihq.com>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>;
<ext2-devel@lists.sourceforge.net>
Sent: Wednesday, July 11, 2001 11:36 AM
Subject: Re: 2.4.6 and ext3-2.4-0.9.1-246


Mike Black wrote:
>
> My system is:
> Dual 1Ghz PIII
> 2G RAM
> 2x2G swapfiles
> And I ran tiobench as tiobench.pl --size 4000 (twice memory)
>
> Me thinkst SMP is probably the biggest difference in this list.

No, the problem is in RAID1.  The buffer allocation in there is nowhere
near strong enough for these loads.

> I ran this on another "smaller" memory (still dual CPU though) machine and
> noticed this on top:
>
> 12983 root      15   0   548  544   448 D    73.6  0.2   0:11 tiotest
>     3 root      18   0     0    0     0 SW   72.6  0.0   0:52 kswapd
>
> kswapd is taking an awful lot of CPU time.  Not sure why it should be
> hitting swap at all.

It's not trying to swap stuff out - it's trying to find pages
to recycle.  kswapd often goes berzerk like this.  I think it
was a design objective.



For me, RAID1 works OK with tiobench, but it is trivially deadlockable
with other workloads.  The usual failure mode is for bdflush to be
stuck in raid1_alloc_r1bh() - can't allocate any more r1bh's, can't
move dirty buffers to disk.  Dead.

The below patch increases the size of the reserved r1bh pool, scales it
by PAGE_CACHE_SIZE and introduces a reservation policy for PF_FLUSH
callers (ie: bdflush).  That fixes the raid1_alloc_r1bh() deadlocks.

bdflush can also deadlock in raid1_alloc_bh(), trying to allocate
buffer_heads.  So we do the same thing there.

Putting swap on RAID1 would definitely have exacerbated the problem.
The last thing we want to do when we're trying to push stuff out
of memory is to have to allocate more of it.  So I allowed PF_MEMALLOC
tasks to bite into the reserves as well.


Please, if you have time, apply and retest.

--- linux-2.4.6/include/linux/sched.h Wed May  2 22:00:07 2001
+++ lk-ext3/include/linux/sched.h Thu Jul 12 01:03:20 2001
@@ -413,7 +418,7 @@ struct task_struct {
 #define PF_SIGNALED 0x00000400 /* killed by a signal */
 #define PF_MEMALLOC 0x00000800 /* Allocating memory */
 #define PF_VFORK 0x00001000 /* Wake up parent in mm_release */
-
+#define PF_FLUSH 0x00002000 /* Flushes buffers to disk */
 #define PF_USEDFPU 0x00100000 /* task used FPU this quantum (SMP) */

 /*
--- linux-2.4.6/include/linux/raid/raid1.h Tue Dec 12 08:20:08 2000
+++ lk-ext3/include/linux/raid/raid1.h Thu Jul 12 01:15:39 2001
@@ -37,12 +37,12 @@ struct raid1_private_data {
  /* buffer pool */
  /* buffer_heads that we have pre-allocated have b_pprev -> &freebh
  * and are linked into a stack using b_next
- * raid1_bh that are pre-allocated have R1BH_PreAlloc set.
  * All these variable are protected by device_lock
  */
  struct buffer_head *freebh;
  int freebh_cnt; /* how many are on the list */
  struct raid1_bh *freer1;
+ unsigned freer1_cnt;
  struct raid1_bh *freebuf; /* each bh_req has a page allocated */
  md_wait_queue_head_t wait_buffer;

@@ -87,5 +87,4 @@ struct raid1_bh {
 /* bits for raid1_bh.state */
 #define R1BH_Uptodate 1
 #define R1BH_SyncPhase 2
-#define R1BH_PreAlloc 3 /* this was pre-allocated, add to free list */
 #endif
--- linux-2.4.6/fs/buffer.c Wed Jul  4 18:21:31 2001
+++ lk-ext3/fs/buffer.c Thu Jul 12 01:03:57 2001
@@ -2685,6 +2748,7 @@ int bdflush(void *sem)
  sigfillset(&tsk->blocked);
  recalc_sigpending(tsk);
  spin_unlock_irq(&tsk->sigmask_lock);
+ current->flags |= PF_FLUSH;

  up((struct semaphore *)sem);

@@ -2726,6 +2790,7 @@ int kupdate(void *sem)
  siginitsetinv(&current->blocked, sigmask(SIGCONT) | sigmask(SIGSTOP));
  recalc_sigpending(tsk);
  spin_unlock_irq(&tsk->sigmask_lock);
+ current->flags |= PF_FLUSH;

  up((struct semaphore *)sem);

--- linux-2.4.6/drivers/md/raid1.c Wed Jul  4 18:21:26 2001
+++ lk-ext3/drivers/md/raid1.c Thu Jul 12 01:28:58 2001
@@ -51,6 +51,28 @@ static mdk_personality_t raid1_personali
 static md_spinlock_t retry_list_lock = MD_SPIN_LOCK_UNLOCKED;
 struct raid1_bh *raid1_retry_list = NULL, **raid1_retry_tail;

+/*
+ * We need to scale the number of reserved buffers by the page size
+ * to make writepage()s sucessful. --akpm
+ */
+#define R1_BLOCKS_PP (PAGE_CACHE_SIZE / 1024)
+#define FREER1_MEMALLOC_RESERVED (16 * R1_BLOCKS_PP)
+
+/*
+ * Return true if the caller make take a bh from the list.
+ * PF_FLUSH and PF_MEMALLOC tasks are allowed to use the reserves, because
+ * they're trying to *free* some memory.
+ *
+ * Requires that conf->device_lock be held.
+ */
+static int may_take_bh(raid1_conf_t *conf, int cnt)
+{
+ int min_free = (current->flags & (PF_FLUSH|PF_MEMALLOC)) ?
+ cnt :
+ (cnt + FREER1_MEMALLOC_RESERVED * conf->raid_disks);
+ return conf->freebh_cnt >= min_free;
+}
+
 static struct buffer_head *raid1_alloc_bh(raid1_conf_t *conf, int cnt)
 {
  /* return a linked list of "cnt" struct buffer_heads.
@@ -62,7 +84,7 @@ static struct buffer_head *raid1_alloc_b
  while(cnt) {
  struct buffer_head *t;
  md_spin_lock_irq(&conf->device_lock);
- if (conf->freebh_cnt >= cnt)
+ if (may_take_bh(conf, cnt))
  while (cnt) {
  t = conf->freebh;
  conf->freebh = t->b_next;
@@ -83,7 +105,7 @@ static struct buffer_head *raid1_alloc_b
  cnt--;
  } else {
  PRINTK("raid1: waiting for %d bh\n", cnt);
- wait_event(conf->wait_buffer, conf->freebh_cnt >= cnt);
+ wait_event(conf->wait_buffer, may_take_bh(conf, cnt));
  }
  }
  return bh;
@@ -96,9 +118,9 @@ static inline void raid1_free_bh(raid1_c
  while (bh) {
  struct buffer_head *t = bh;
  bh=bh->b_next;
- if (t->b_pprev == NULL)
+ if (conf->freebh_cnt >= FREER1_MEMALLOC_RESERVED) {
  kfree(t);
- else {
+ } else {
  t->b_next= conf->freebh;
  conf->freebh = t;
  conf->freebh_cnt++;
@@ -108,29 +130,6 @@ static inline void raid1_free_bh(raid1_c
  wake_up(&conf->wait_buffer);
 }

-static int raid1_grow_bh(raid1_conf_t *conf, int cnt)
-{
- /* allocate cnt buffer_heads, possibly less if kalloc fails */
- int i = 0;
-
- while (i < cnt) {
- struct buffer_head *bh;
- bh = kmalloc(sizeof(*bh), GFP_KERNEL);
- if (!bh) break;
- memset(bh, 0, sizeof(*bh));
-
- md_spin_lock_irq(&conf->device_lock);
- bh->b_pprev = &conf->freebh;
- bh->b_next = conf->freebh;
- conf->freebh = bh;
- conf->freebh_cnt++;
- md_spin_unlock_irq(&conf->device_lock);
-
- i++;
- }
- return i;
-}
-
 static int raid1_shrink_bh(raid1_conf_t *conf, int cnt)
 {
  /* discard cnt buffer_heads, if we can find them */
@@ -147,7 +146,16 @@ static int raid1_shrink_bh(raid1_conf_t
  md_spin_unlock_irq(&conf->device_lock);
  return i;
 }
-
+
+/*
+ * Return true if the caller make take a raid1_bh from the list.
+ * Requires that conf->device_lock be held.
+ */
+static int may_take_r1bh(raid1_conf_t *conf)
+{
+ return ((conf->freer1_cnt > FREER1_MEMALLOC_RESERVED) ||
+   (current->flags & (PF_FLUSH|PF_MEMALLOC))) && conf->freer1;
+}

 static struct raid1_bh *raid1_alloc_r1bh(raid1_conf_t *conf)
 {
@@ -155,8 +163,9 @@ static struct raid1_bh *raid1_alloc_r1bh

  do {
  md_spin_lock_irq(&conf->device_lock);
- if (conf->freer1) {
+ if (may_take_r1bh(conf)) {
  r1_bh = conf->freer1;
+ conf->freer1_cnt--;
  conf->freer1 = r1_bh->next_r1;
  r1_bh->next_r1 = NULL;
  r1_bh->state = 0;
@@ -170,7 +179,7 @@ static struct raid1_bh *raid1_alloc_r1bh
  memset(r1_bh, 0, sizeof(*r1_bh));
  return r1_bh;
  }
- wait_event(conf->wait_buffer, conf->freer1);
+ wait_event(conf->wait_buffer, may_take_r1bh(conf));
  } while (1);
 }

@@ -178,49 +187,30 @@ static inline void raid1_free_r1bh(struc
 {
  struct buffer_head *bh = r1_bh->mirror_bh_list;
  raid1_conf_t *conf = mddev_to_conf(r1_bh->mddev);
+ unsigned long flags;

  r1_bh->mirror_bh_list = NULL;

- if (test_bit(R1BH_PreAlloc, &r1_bh->state)) {
- unsigned long flags;
- spin_lock_irqsave(&conf->device_lock, flags);
+ spin_lock_irqsave(&conf->device_lock, flags);
+ if (conf->freer1_cnt < FREER1_MEMALLOC_RESERVED) {
  r1_bh->next_r1 = conf->freer1;
  conf->freer1 = r1_bh;
+ conf->freer1_cnt++;
  spin_unlock_irqrestore(&conf->device_lock, flags);
  } else {
+ spin_unlock_irqrestore(&conf->device_lock, flags);
  kfree(r1_bh);
  }
  raid1_free_bh(conf, bh);
 }

-static int raid1_grow_r1bh (raid1_conf_t *conf, int cnt)
-{
- int i = 0;
-
- while (i < cnt) {
- struct raid1_bh *r1_bh;
- r1_bh = (struct raid1_bh*)kmalloc(sizeof(*r1_bh), GFP_KERNEL);
- if (!r1_bh)
- break;
- memset(r1_bh, 0, sizeof(*r1_bh));
-
- md_spin_lock_irq(&conf->device_lock);
- set_bit(R1BH_PreAlloc, &r1_bh->state);
- r1_bh->next_r1 = conf->freer1;
- conf->freer1 = r1_bh;
- md_spin_unlock_irq(&conf->device_lock);
-
- i++;
- }
- return i;
-}
-
 static void raid1_shrink_r1bh(raid1_conf_t *conf)
 {
  md_spin_lock_irq(&conf->device_lock);
  while (conf->freer1) {
  struct raid1_bh *r1_bh = conf->freer1;
  conf->freer1 = r1_bh->next_r1;
+ conf->freer1_cnt--; /* pedantry */
  kfree(r1_bh);
  }
  md_spin_unlock_irq(&conf->device_lock);
@@ -1610,21 +1600,6 @@ static int raid1_run (mddev_t *mddev)
  goto out_free_conf;
  }

-
- /* pre-allocate some buffer_head structures.
- * As a minimum, 1 r1bh and raid_disks buffer_heads
- * would probably get us by in tight memory situations,
- * but a few more is probably a good idea.
- * For now, try 16 r1bh and 16*raid_disks bufferheads
- * This will allow at least 16 concurrent reads or writes
- * even if kmalloc starts failing
- */
- if (raid1_grow_r1bh(conf, 16) < 16 ||
-     raid1_grow_bh(conf, 16*conf->raid_disks)< 16*conf->raid_disks) {
- printk(MEM_ERROR, mdidx(mddev));
- goto out_free_conf;
- }
-
  for (i = 0; i < MD_SB_DISKS; i++) {

  descriptor = sb->disks+i;
@@ -1713,6 +1688,8 @@ out_free_conf:
  raid1_shrink_r1bh(conf);
  raid1_shrink_bh(conf, conf->freebh_cnt);
  raid1_shrink_buffers(conf);
+ if (conf->freer1_cnt != 0)
+ BUG();
  kfree(conf);
  mddev->private = NULL;
 out:

