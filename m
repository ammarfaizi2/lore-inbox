Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283668AbRLCXq0>; Mon, 3 Dec 2001 18:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282915AbRLCXoO>; Mon, 3 Dec 2001 18:44:14 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:8832 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S285180AbRLCVWv>; Mon, 3 Dec 2001 16:22:51 -0500
Message-ID: <3C0BED29.3090207@optonline.net>
Date: Mon, 03 Dec 2001 16:22:49 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, dledford@redhat.com
Subject: partial patch for i810_audio
Content-Type: multipart/mixed;
 boundary="------------060603030907000505000408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060603030907000505000408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

this patch will crash your machine eventually... be warned. :-)

the attached patch is against 2.4.17-pre1 and attempts to (naively) 
merge Doug Ledford's 0.05 i810_audio.c from redhat's 2.4.7 kernel with 
the latest features of the driver in 2.4.17. (2.4.7-redhat doesn't 
appear to include APM or s/pdif support). I bumped the version to 0.05a ;-)

it fixes KDE's artsd problem on my machine, but I screwed something up 
involving virtual memory or buffer allocation. this causes an oops which 
makes the machine unstable. expect to see crashes in fs and kswapd code.

maybe somebody else can debug this faster than me - it's been a while 
since i've done anything kernel related.

--------------060603030907000505000408
Content-Type: text/plain;
 name="oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops"

ksymoops 2.4.1 on i686 2.4.16.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map-2.4.16 (default)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Dec  3 15:26:11 lasn-001 kernel: ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices AD1885)
Dec  3 15:28:26 lasn-001 kernel: ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices AD1885)
Dec  3 15:30:59 lasn-001 kernel: Unable to handle kernel paging request at virtual address dc2bb5d0
Dec  3 15:30:59 lasn-001 kernel: c0129fb8
Dec  3 15:30:59 lasn-001 kernel: *pde = 12b28067
Dec  3 15:30:59 lasn-001 kernel: Oops: 0002
Dec  3 15:30:59 lasn-001 kernel: CPU:    0
Dec  3 15:30:59 lasn-001 kernel: EIP:    0010:[kmem_cache_free+56/160]    Not tainted
Dec  3 15:30:59 lasn-001 kernel: EIP:    0010:[<c0129fb8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec  3 15:30:59 lasn-001 kernel: EFLAGS: 00210096
Dec  3 15:30:59 lasn-001 kernel: eax: 032c06a9   ebx: c160fe30   ecx: d3800000   edx: 0000001f
Dec  3 15:30:59 lasn-001 kernel: esi: 00200282   edi: 022aed6e   ebp: c15efcc0   esp: c1619ee0
Dec  3 15:30:59 lasn-001 kernel: ds: 0018   es: 0018   ss: 0018
Dec  3 15:30:59 lasn-001 kernel: Process kswapd (pid: 4, stackpage=c1619000)
Dec  3 15:30:59 lasn-001 kernel: Stack: 00000008 d3800f60 d3800f60 d3800f60 c0132c93 c160fe30 d3800f60 c0134658 
Dec  3 15:30:59 lasn-001 kernel:        d3800f60 d3800f60 c1658200 c15efcc0 000001d0 c0132f19 000001d0 c15efcc0 
Dec  3 15:30:59 lasn-001 kernel:        0000001a 000019db c012aca5 c15efcc0 000001d0 d257c460 c1618000 00000100 
Dec  3 15:31:00 lasn-001 kernel: Call Trace: [__put_unused_buffer_head+35/80] [try_to_free_buffers+120/224] [try_to_release_page+41/80] [shrink_cache+469/720] [shrink_caches+82/128] 
Dec  3 15:31:00 lasn-001 kernel: Call Trace: [<c0132c93>] [<c0134658>] [<c0132f19>] [<c012aca5>] [<c012aed2>] 
Dec  3 15:31:00 lasn-001 kernel:    [<c012af2c>] [<c012afd1>] [<c012b046>] [<c012b181>] [<c012b0e0>] [<c0105000>] 
Dec  3 15:31:00 lasn-001 kernel:    [<c0105516>] [<c012b0e0>] 
Dec  3 15:31:00 lasn-001 kernel: Code: 89 44 b9 18 89 79 14 8b 51 10 8d 42 ff 89 41 10 85 c0 75 24 

>>EIP; c0129fb8 <kmem_cache_free+38/a0>   <=====
Trace; c0132c93 <__put_unused_buffer_head+23/50>
Trace; c0134658 <try_to_free_buffers+78/e0>
Trace; c0132f19 <try_to_release_page+29/50>
Trace; c012aca5 <shrink_cache+1d5/2d0>
Trace; c012aed2 <shrink_caches+52/80>
Trace; c012af2c <try_to_free_pages+2c/50>
Trace; c012afd1 <kswapd_balance_pgdat+51/a0>
Trace; c012b046 <kswapd_balance+26/40>
Trace; c012b181 <kswapd+a1/c0>
Trace; c012b0e0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c012b0e0 <kswapd+0/c0>
Code;  c0129fb8 <kmem_cache_free+38/a0>
00000000 <_EIP>:
Code;  c0129fb8 <kmem_cache_free+38/a0>   <=====
   0:   89 44 b9 18               mov    %eax,0x18(%ecx,%edi,4)   <=====
Code;  c0129fbc <kmem_cache_free+3c/a0>
   4:   89 79 14                  mov    %edi,0x14(%ecx)
Code;  c0129fbf <kmem_cache_free+3f/a0>
   7:   8b 51 10                  mov    0x10(%ecx),%edx
Code;  c0129fc2 <kmem_cache_free+42/a0>
   a:   8d 42 ff                  lea    0xffffffff(%edx),%eax
Code;  c0129fc5 <kmem_cache_free+45/a0>
   d:   89 41 10                  mov    %eax,0x10(%ecx)
Code;  c0129fc8 <kmem_cache_free+48/a0>
  10:   85 c0                     test   %eax,%eax
Code;  c0129fca <kmem_cache_free+4a/a0>
  12:   75 24                     jne    38 <_EIP+0x38> c0129ff0 <kmem_cache_free+70/a0>

Dec  3 15:31:42 lasn-001 kernel:  <1>Unable to handle kernel paging request at virtual address f3f8f13e
Dec  3 15:31:42 lasn-001 kernel: c01322c6
Dec  3 15:31:42 lasn-001 kernel: *pde = 00000000
Dec  3 15:31:42 lasn-001 kernel: Oops: 0000
Dec  3 15:31:42 lasn-001 kernel: CPU:    0
Dec  3 15:31:42 lasn-001 kernel: EIP:    0010:[get_hash_table+102/144]    Not tainted
Dec  3 15:31:42 lasn-001 kernel: EIP:    0010:[<c01322c6>]    Not tainted
Dec  3 15:31:42 lasn-001 kernel: EFLAGS: 00010286
Dec  3 15:31:42 lasn-001 kernel: eax: c1620000   ebx: 00000003   ecx: d3800180   edx: f3f8f13a
Dec  3 15:31:42 lasn-001 kernel: esi: 00008251   edi: 00000306   ebp: 0000000f   esp: ca5e7d94
Dec  3 15:31:42 lasn-001 kernel: ds: 0018   es: 0018   ss: 0018
Dec  3 15:31:42 lasn-001 kernel: Process bash (pid: 6166, stackpage=ca5e7000)
Dec  3 15:31:42 lasn-001 kernel: Stack: 00007d0c 00000306 00001000 00008251 00000000 c01329f8 00000306 00008251 
Dec  3 15:31:42 lasn-001 kernel:        00001000 00001000 00000000 00000000 c0151f28 00000306 00008251 00001000 
Dec  3 15:31:42 lasn-001 kernel:        c3089cc0 d257c860 d78d4430 00000000 00000000 d257c860 ca5e7e60 d7ce0bc0 
Dec  3 15:31:42 lasn-001 kernel: Call Trace: [getblk+24/64] [ext3_getblk+184/608] [ext3_reserve_inode_write+49/176] [ext3_mark_iloc_dirty+36/80] [ext3_mark_iloc_dirty+53/80] 
Dec  3 15:31:42 lasn-001 kernel: Call Trace: [<c01329f8>] [<c0151f28>] [<c0154011>] [<c0153fb4>] [<c0153fc5>] 
Dec  3 15:31:42 lasn-001 kernel:    [<c015f81b>] [<c015a917>] [<c01520f2>] [<c014fb3d>] [<c013bbd0>] [<c013a1f5>] 
Dec  3 15:31:42 lasn-001 kernel:    [<c013ca9a>] [<c013ce70>] [<c013cfff>] [<c013ce70>] [<c0106ceb>] 
Dec  3 15:31:42 lasn-001 kernel: Code: 39 72 04 89 d1 75 f3 0f b7 42 08 3b 44 24 20 75 e9 66 39 7a 

>>EIP; c01322c6 <get_hash_table+66/90>   <=====
Trace; c01329f8 <getblk+18/40>
Trace; c0151f28 <ext3_getblk+b8/260>
Trace; c0154011 <ext3_reserve_inode_write+31/b0>
Trace; c0153fb4 <ext3_mark_iloc_dirty+24/50>
Trace; c0153fc5 <ext3_mark_iloc_dirty+35/50>
Trace; c015f81b <__jbd_kmalloc+2b/c0>
Trace; c015a917 <journal_stop+217/230>
Trace; c01520f2 <ext3_bread+22/80>
Trace; c014fb3d <ext3_readdir+9d/400>
Trace; c013bbd0 <vfs_follow_link+c0/130>
Trace; c013a1f5 <open_namei+2f5/520>
Trace; c013ca9a <vfs_readdir+5a/80>
Trace; c013ce70 <filldir64+0/140>
Trace; c013cfff <sys_getdents64+4f/c0>
Trace; c013ce70 <filldir64+0/140>
Trace; c0106ceb <system_call+33/38>
Code;  c01322c6 <get_hash_table+66/90>
00000000 <_EIP>:
Code;  c01322c6 <get_hash_table+66/90>   <=====
   0:   39 72 04                  cmp    %esi,0x4(%edx)   <=====
Code;  c01322c9 <get_hash_table+69/90>
   3:   89 d1                     mov    %edx,%ecx
Code;  c01322cb <get_hash_table+6b/90>
   5:   75 f3                     jne    fffffffa <_EIP+0xfffffffa> c01322c0 <get_hash_table+60/90>
Code;  c01322cd <get_hash_table+6d/90>
   7:   0f b7 42 08               movzwl 0x8(%edx),%eax
Code;  c01322d1 <get_hash_table+71/90>
   b:   3b 44 24 20               cmp    0x20(%esp,1),%eax
Code;  c01322d5 <get_hash_table+75/90>
   f:   75 e9                     jne    fffffffa <_EIP+0xfffffffa> c01322c0 <get_hash_table+60/90>
Code;  c01322d7 <get_hash_table+77/90>
  11:   66 39 7a 00               cmp    %di,0x0(%edx)

Dec  3 15:33:18 lasn-001 kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000018
Dec  3 15:33:18 lasn-001 kernel: c0134600
Dec  3 15:33:18 lasn-001 kernel: *pde = 00000000
Dec  3 15:33:18 lasn-001 kernel: Oops: 0000
Dec  3 15:33:18 lasn-001 kernel: CPU:    0
Dec  3 15:33:18 lasn-001 kernel: EIP:    0010:[try_to_free_buffers+32/224]    Not tainted
Dec  3 15:33:18 lasn-001 kernel: EIP:    0010:[<c0134600>]    Not tainted
Dec  3 15:33:18 lasn-001 kernel: EFLAGS: 00010203
Dec  3 15:33:18 lasn-001 kernel: eax: 00000000   ebx: 00000000   ecx: 000000f0   edx: 00000000
Dec  3 15:33:18 lasn-001 kernel: esi: 00001000   edi: d3800780   ebp: c14e0a00   esp: ca4a3d7c
Dec  3 15:33:18 lasn-001 kernel: ds: 0018   es: 0018   ss: 0018
Dec  3 15:33:18 lasn-001 kernel: Process kdeinit (pid: 5912, stackpage=ca4a3000)
Dec  3 15:33:18 lasn-001 kernel: Stack: c16136b0 c16e33bc c01252af c16136b0 c14e0a00 00001000 00000306 001a8028 
Dec  3 15:33:18 lasn-001 kernel:        c01342fb c14e0a00 000000f0 001a8028 c1660120 c01344e6 c1660120 001a8028 
Dec  3 15:33:19 lasn-001 kernel:        00001000 00000306 00001000 001a8028 00024300 c0132a07 00000306 001a8028 
Dec  3 15:33:19 lasn-001 kernel: Call Trace: [find_or_create_page+63/208] [grow_dev_page+91/176] [grow_buffers+166/240] [getblk+39/64] [bread+24/128] 
Dec  3 15:33:19 lasn-001 kernel: Call Trace: [<c01252af>] [<c01342fb>] [<c01344e6>] [<c0132a07>] [<c0132c08>] 
Dec  3 15:33:19 lasn-001 kernel:    [<c0131ca0>] [<c0153718>] [<c0153795>] [<c01549e7>] [<c0142622>] [<c01426b3>] 
Dec  3 15:33:20 lasn-001 kernel:    [<c01428e2>] [<c0154b48>] [<c013924f>] [<c01395ae>] [<c01ca088>] [<c0138f9e>] 
Dec  3 15:33:20 lasn-001 kernel:    [<c0139e33>] [<c012fffe>] [<c0106ceb>] 
Dec  3 15:33:20 lasn-001 kernel: Code: 8b 53 18 8b 43 10 83 e2 06 09 d0 75 7a 8b 5b 28 39 fb 75 ec 

>>EIP; c0134600 <try_to_free_buffers+20/e0>   <=====
Trace; c01252af <find_or_create_page+3f/d0>
Trace; c01342fb <grow_dev_page+5b/b0>
Trace; c01344e6 <grow_buffers+a6/f0>
Trace; c0132a07 <getblk+27/40>
Trace; c0132c08 <bread+18/80>
Trace; c0131ca0 <end_buffer_io_sync+20/30>
Trace; c0153718 <ext3_get_inode_loc+128/190>
Trace; c0153795 <ext3_read_inode+15/2b0>
Trace; c01549e7 <ext3_find_entry+247/350>
Trace; c0142622 <get_new_inode+42/160>
Trace; c01426b3 <get_new_inode+d3/160>
Trace; c01428e2 <iget4+c2/d0>
Trace; c0154b48 <ext3_lookup+58/80>
Trace; c013924f <real_lookup+4f/c0>
Trace; c01395ae <link_path_walk+20e/710>
Trace; c01ca088 <sock_read+88/a0>
Trace; c0138f9e <getname+5e/a0>
Trace; c0139e33 <__user_walk+33/50>
Trace; c012fffe <sys_access+7e/120>
Trace; c0106ceb <system_call+33/38>
Code;  c0134600 <try_to_free_buffers+20/e0>
00000000 <_EIP>:
Code;  c0134600 <try_to_free_buffers+20/e0>   <=====
   0:   8b 53 18                  mov    0x18(%ebx),%edx   <=====
Code;  c0134603 <try_to_free_buffers+23/e0>
   3:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c0134606 <try_to_free_buffers+26/e0>
   6:   83 e2 06                  and    $0x6,%edx
Code;  c0134609 <try_to_free_buffers+29/e0>
   9:   09 d0                     or     %edx,%eax
Code;  c013460b <try_to_free_buffers+2b/e0>
   b:   75 7a                     jne    87 <_EIP+0x87> c0134687 <try_to_free_buffers+a7/e0>
Code;  c013460d <try_to_free_buffers+2d/e0>
   d:   8b 5b 28                  mov    0x28(%ebx),%ebx
Code;  c0134610 <try_to_free_buffers+30/e0>
  10:   39 fb                     cmp    %edi,%ebx
Code;  c0134612 <try_to_free_buffers+32/e0>
  12:   75 ec                     jne    0 <_EIP>

Dec  3 15:35:47 lasn-001 kernel: cpu: 0, clocks: 1328944, slice: 664472
Dec  3 15:35:47 lasn-001 kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html

--------------060603030907000505000408
Content-Type: text/plain;
 name="i810.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i810.diff"

--- i810_audio.c.17p1	Mon Dec  3 14:14:40 2001
+++ linux/drivers/sound/i810_audio.c	Mon Dec  3 15:27:14 2001
@@ -197,7 +197,7 @@
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.04"
+#define DRIVER_VERSION "0.05a"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -357,6 +357,10 @@
 	struct i810_channel *(*alloc_rec_pcm_channel)(struct i810_card *);
 	struct i810_channel *(*alloc_rec_mic_channel)(struct i810_card *);
 	void (*free_pcm_channel)(struct i810_card *, int chan);
+
+        /* We have a *very* long init time possibly, so use this to block */
+        /* attempts to open our devices before we are ready (stops oops'es) */
+	int initializing;
 };
 
 static struct i810_card *devs = NULL;
@@ -364,32 +368,6 @@
 static int i810_open_mixdev(struct inode *inode, struct file *file);
 static int i810_ioctl_mixdev(struct inode *inode, struct file *file, unsigned int cmd,
 				unsigned long arg);
-
-static inline unsigned ld2(unsigned int x)
-{
-	unsigned r = 0;
-	
-	if (x >= 0x10000) {
-		x >>= 16;
-		r += 16;
-	}
-	if (x >= 0x100) {
-		x >>= 8;
-		r += 8;
-	}
-	if (x >= 0x10) {
-		x >>= 4;
-		r += 4;
-	}
-	if (x >= 4) {
-		x >>= 2;
-		r += 2;
-	}
-	if (x >= 2)
-		r++;
-	return r;
-}
-
 static u16 i810_ac97_get(struct ac97_codec *dev, u8 reg);
 static void i810_ac97_set(struct ac97_codec *dev, u8 reg, u16 data);
 
@@ -969,14 +947,6 @@
 	else
 		port += dmabuf->write_channel->port;
 
-	if(dmabuf->mapped) {
-		if(rec)
-			dmabuf->swptr = (dmabuf->hwptr + dmabuf->dmasize
-				       	- dmabuf->count) % dmabuf->dmasize;
-		else
-			dmabuf->swptr = (dmabuf->hwptr + dmabuf->count)
-			       		% dmabuf->dmasize;
-	}
 	/*
 	 * two special cases, count == 0 on write
 	 * means no data, and count == dmasize
@@ -993,7 +963,7 @@
 	/* swptr - 1 is the tail of our transfer */
 	x = (dmabuf->dmasize + dmabuf->swptr - 1) % dmabuf->dmasize;
 	x /= dmabuf->fragsize;
-	outb(x&31, port+OFF_LVI);
+	outb(x, port+OFF_LVI);
 }
 
 static void i810_update_lvi(struct i810_state *state, int rec)
@@ -1020,7 +990,9 @@
 		/* update hardware pointer */
 		hwptr = i810_get_dma_addr(state, 1);
 		diff = (dmabuf->dmasize + hwptr - dmabuf->hwptr) % dmabuf->dmasize;
-//		printk("HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#ifdef DEBUG_INTERRUPTS
+		printk("ADC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#endif
 		dmabuf->hwptr = hwptr;
 		dmabuf->total_bytes += diff;
 		dmabuf->count += diff;
@@ -1043,7 +1015,9 @@
 		/* update hardware pointer */
 		hwptr = i810_get_dma_addr(state, 0);
 		diff = (dmabuf->dmasize + hwptr - dmabuf->hwptr) % dmabuf->dmasize;
-//		printk("HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#ifdef DEBUG_INTERRUPTS
+		printk("DAC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
+#endif
 		dmabuf->hwptr = hwptr;
 		dmabuf->total_bytes += diff;
 		dmabuf->count -= diff;
@@ -1068,6 +1042,40 @@
 	}
 }
 
+static inline int i810_get_free_write_space(struct i810_state *state)
+{
+	struct dmabuf *dmabuf = &state->dmabuf;
+	int free;
+
+	i810_update_ptr(state);
+	// catch underruns during playback
+	if (dmabuf->count < 0) {
+		dmabuf->count = 0;
+	}
+	free = dmabuf->dmasize - dmabuf->count;
+	free -= (dmabuf->hwptr % dmabuf->fragsize);
+	if(free < 0)
+		return(0);
+	return(free);
+}
+
+static inline int i810_get_available_read_data(struct i810_state *state)
+{
+	struct dmabuf *dmabuf = &state->dmabuf;
+	int avail;
+
+	i810_update_ptr(state);
+	// catch overruns during record
+	if (dmabuf->count > dmabuf->dmasize) {
+		dmabuf->count = dmabuf->dmasize;
+	}
+	avail = dmabuf->count;
+	avail -= (dmabuf->hwptr % dmabuf->fragsize);
+	if(avail < 0)
+		return(0);
+	return(avail);
+}
+
 static int drain_dac(struct i810_state *state, int nonblock)
 {
 	DECLARE_WAITQUEUE(wait, current);
@@ -1271,10 +1279,7 @@
                         continue;
                 }
 		swptr = dmabuf->swptr;
-		if (dmabuf->count > dmabuf->dmasize) {
-			dmabuf->count = dmabuf->dmasize;
-		}
-		cnt = dmabuf->count - dmabuf->fragsize;
+		cnt = i810_get_available_read_data(state);
 		// this is to make the copy_to_user simpler below
 		if(cnt > (dmabuf->dmasize - swptr))
 			cnt = dmabuf->dmasize - swptr;
@@ -1402,10 +1407,7 @@
                 }
 
 		swptr = dmabuf->swptr;
-		if (dmabuf->count < 0) {
-			dmabuf->count = 0;
-		}
-		cnt = dmabuf->dmasize - swptr;
+		cnt = i810_get_free_write_space(state);
 		if(cnt > (dmabuf->dmasize - dmabuf->count))
 			cnt = dmabuf->dmasize - dmabuf->count;
 		spin_unlock_irqrestore(&state->card->lock, flags);
@@ -1508,13 +1510,8 @@
 			mask |= POLLIN | POLLRDNORM;
 	}
 	if (file->f_mode & FMODE_WRITE && dmabuf->enable & DAC_RUNNING) {
-		if (dmabuf->mapped) {
-			if (dmabuf->count >= (signed)dmabuf->fragsize)
-				mask |= POLLOUT | POLLWRNORM;
-		} else {
-			if ((signed)dmabuf->dmasize >= dmabuf->count + (signed)dmabuf->fragsize)
-				mask |= POLLOUT | POLLWRNORM;
-		}
+		if ((signed)dmabuf->dmasize >= dmabuf->count + (signed)dmabuf->fragsize)
+			mask |= POLLOUT | POLLWRNORM;
 	}
 	spin_unlock_irqrestore(&state->card->lock, flags);
 
@@ -1559,10 +1556,7 @@
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
-	if(vma->vm_flags & VM_WRITE)
-		dmabuf->count = dmabuf->dmasize;
-	else
-		dmabuf->count = 0;
+	dmabuf->count = 0;
 	ret = 0;
 #ifdef DEBUG
 	printk("i810_audio: mmap'ed %ld bytes of data space\n", size);
@@ -1580,11 +1574,9 @@
 	audio_buf_info abinfo;
 	count_info cinfo;
 	unsigned int i_glob_cnt;
-	int val = 0, mapped, ret;
+	int val = 0, ret;
 	struct ac97_codec *codec = state->card->ac97_codec[0];
 
-	mapped = ((file->f_mode & FMODE_WRITE) && dmabuf->mapped) ||
-		((file->f_mode & FMODE_READ) && dmabuf->mapped);
 #ifdef DEBUG
 	printk("i810_audio: i810_ioctl, arg=0x%x, cmd=", arg ? *(int *)arg : 0);
 #endif
@@ -1674,9 +1666,6 @@
 #ifdef DEBUG
 		printk("SNDCTL_DSP_STEREO\n");
 #endif
-		if (get_user(val, (int *)arg))
-			return -EFAULT;
-
 		if (dmabuf->enable & DAC_RUNNING) {
 			stop_dac(state);
 		}
@@ -1820,22 +1809,47 @@
 
 		dmabuf->ossfragsize = 1<<(val & 0xffff);
 		dmabuf->ossmaxfrags = (val >> 16) & 0xffff;
-		if (dmabuf->ossmaxfrags <= 4)
-			dmabuf->ossmaxfrags = 4;
-		else if (dmabuf->ossmaxfrags <= 8)
-			dmabuf->ossmaxfrags = 8;
-		else if (dmabuf->ossmaxfrags <= 16)
-			dmabuf->ossmaxfrags = 16;
-		else
-			dmabuf->ossmaxfrags = 32;
+		if (!dmabuf->ossfragsize || !dmabuf->ossmaxfrags)
+			return -EINVAL;
+		/*
+		 * Bound the frag size into our allowed range of 256 - 4096
+		 */
+		if (dmabuf->ossfragsize < 256)
+			dmabuf->ossfragsize = 256;
+		else if (dmabuf->ossfragsize > 4096)
+			dmabuf->ossfragsize = 4096;
+		/*
+		 * The numfrags could be something reasonable, or it could
+		 * be 0xffff meaning "Give me as much as possible".  So,
+		 * we check the numfrags * fragsize doesn't exceed our
+		 * 64k buffer limit, nor is it less than our 8k minimum.
+		 * If it fails either one of these checks, then adjust the
+		 * number of fragments, not the size of them.  It's OK if
+		 * our number of fragments doesn't equal 32 or anything
+		 * like our hardware based number now since we are using
+		 * a different frag count for the hardware.  Before we get
+		 * into this though, bound the maxfrags to avoid overflow
+		 * issues.  A reasonable bound would be 64k / 256 since our
+		 * maximum buffer size is 64k and our minimum frag size is
+		 * 256.  On the other end, our minimum buffer size is 8k and
+		 * our maximum frag size is 4k, so the lower bound should
+		 * be 2.
+		 */
+
+		if(dmabuf->ossmaxfrags > 256)
+			dmabuf->ossmaxfrags = 256;
+		else if (dmabuf->ossmaxfrags < 2)
+			dmabuf->ossmaxfrags = 2;
+
 		val = dmabuf->ossfragsize * dmabuf->ossmaxfrags;
-		if (val < 16384)
-			val = 16384;
-		if (val > 65536)
-			val = 65536;
-		dmabuf->ossmaxfrags = val/dmabuf->ossfragsize;
-		if(dmabuf->ossmaxfrags<4)
-			dmabuf->ossfragsize = val/4;
+		while (val < 8192) {
+		    val <<= 1;
+		    dmabuf->ossmaxfrags <<= 1;
+		}
+		while (val > 65536) {
+		    val >>= 1;
+		    dmabuf->ossmaxfrags >>= 1;
+		}
 		dmabuf->ready = 0;
 #ifdef DEBUG
 		printk("SNDCTL_DSP_SETFRAGMENT 0x%x, %d, %d\n", val,
@@ -1853,10 +1867,10 @@
 		i810_update_ptr(state);
 		abinfo.fragsize = dmabuf->userfragsize;
 		abinfo.fragstotal = dmabuf->userfrags;
-		if(dmabuf->mapped)
-			abinfo.bytes = dmabuf->count;
-		else
-			abinfo.bytes = dmabuf->dmasize - dmabuf->fragsize - dmabuf->count;
+		if (dmabuf->mapped)
+ 			abinfo.bytes = dmabuf->dmasize;
+  		else
+ 			abinfo.bytes = i810_get_free_write_space(state);
 		abinfo.fragments = abinfo.bytes / dmabuf->userfragsize;
 		spin_unlock_irqrestore(&state->card->lock, flags);
 #ifdef DEBUG
@@ -1871,13 +1885,13 @@
 		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
-		i810_update_ptr(state);
+		val = i810_get_free_write_space(state);
 		cinfo.bytes = dmabuf->total_bytes;
 		cinfo.ptr = dmabuf->hwptr;
-		cinfo.blocks = (dmabuf->dmasize - dmabuf->count)/dmabuf->userfragsize;
-		if (dmabuf->mapped) {
-			dmabuf->count = (dmabuf->dmasize - 
-					 (dmabuf->count & (dmabuf->userfragsize-1)));
+		cinfo.blocks = val/dmabuf->userfragsize;
+		if (dmabuf->mapped && dmabuf->enable && DAC_RUNNING) {
+			dmabuf->count += val;
+			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
 			__i810_update_lvi(state, 0);
 		}
 		spin_unlock_irqrestore(&state->card->lock, flags);
@@ -1893,10 +1907,9 @@
 		if (!dmabuf->ready && (val = prog_dmabuf(state, 1)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
-		i810_update_ptr(state);
+		abinfo.bytes = i810_get_available_read_data(state);
 		abinfo.fragsize = dmabuf->userfragsize;
 		abinfo.fragstotal = dmabuf->userfrags;
-		abinfo.bytes = dmabuf->dmasize - dmabuf->count;
 		abinfo.fragments = abinfo.bytes / dmabuf->userfragsize;
 		spin_unlock_irqrestore(&state->card->lock, flags);
 #ifdef DEBUG
@@ -1911,12 +1924,13 @@
 		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
-		i810_update_ptr(state);
+		val = i810_get_available_read_data(state);
 		cinfo.bytes = dmabuf->total_bytes;
-		cinfo.blocks = dmabuf->count/dmabuf->userfragsize;
+		cinfo.blocks = val/dmabuf->userfragsize;
 		cinfo.ptr = dmabuf->hwptr;
-		if (dmabuf->mapped) {
-			dmabuf->count &= (dmabuf->userfragsize-1);
+		if (dmabuf->mapped && dmabuf->enable && ADC_RUNNING) {
+			dmabuf->count -= val;
+			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
 			__i810_update_lvi(state, 1);
 		}
 		spin_unlock_irqrestore(&state->card->lock, flags);
@@ -1970,8 +1984,12 @@
 			if (!dmabuf->ready && (ret = prog_dmabuf(state, 0)))
 				return ret;
 			if (dmabuf->mapped) {
-				dmabuf->count = dmabuf->dmasize;
-				i810_update_lvi(state,0);
+				spin_lock_irqsave(&state->card->lock, flags);
+				i810_update_ptr(state);
+				dmabuf->count = 0;
+				dmabuf->count = i810_get_free_write_space(state);
+				__i810_update_lvi(state, 0);
+				spin_unlock_irqrestore(&state->card->lock, flags);
 			}
 			if (!dmabuf->enable && dmabuf->count > dmabuf->userfragsize)
 				start_dac(state);
@@ -1985,10 +2003,6 @@
 			}
 			if (!dmabuf->ready && (ret = prog_dmabuf(state, 1)))
 				return ret;
-			if (dmabuf->mapped) {
-				dmabuf->count = 0;
-				i810_update_lvi(state,1);
-			}
 			if (!dmabuf->enable && dmabuf->count <
 			    (dmabuf->dmasize - dmabuf->userfragsize))
 				start_adc(state);
@@ -2195,7 +2209,11 @@
 
 	/* find an avaiable virtual channel (instance of /dev/dsp) */
 	while (card != NULL) {
-		for (i = 0; i < NR_HW_CH; i++) {
+		for (i = 0; i < 50 && card->initializing; i++) {
+			current->state = TASK_UNINTERRUPTIBLE;
+			schedule_timeout(HZ/20);
+		}
+		for (i = 0; i < NR_HW_CH && !card->initializing; i++) {
 			if (card->states[i] == NULL) {
 				state = card->states[i] = (struct i810_state *)
 					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
@@ -2344,13 +2362,18 @@
 	int minor = MINOR(inode->i_rdev);
 	struct i810_card *card = devs;
 
-	for (card = devs; card != NULL; card = card->next)
-		for (i = 0; i < NR_AC97; i++)
+	for (card = devs; card != NULL; card = card->next) {
+		for (i = 0; i < 50 && card->initializing; i++) {
+			current->state = TASK_UNINTERRUPTIBLE;
+			schedule_timeout(HZ/20);
+		}
+		for (i = 0; i < NR_AC97 && !card->initializing; i++)
 			if (card->ac97_codec[i] != NULL &&
 			    card->ac97_codec[i]->dev_mixer == minor) {
 				file->private_data = card->ac97_codec[i];
 				return 0;
 			}
+	}
 	return -ENODEV;
 }
 
@@ -2696,6 +2719,7 @@
 	}
 	memset(card, 0, sizeof(*card));
 
+	card->initializing = 1;
 	card->iobase = pci_resource_start (pci_dev, 1);
 	card->ac97base = pci_resource_start (pci_dev, 0);
 	card->pci_dev = pci_dev;
@@ -2771,7 +2795,10 @@
 		kfree(card);
 		return -ENODEV;
 	}
-
+	if(clocking == 48000) {
+		i810_configure_clocking();
+ 	}
+ 	card->initializing = 0;
 	return 0;
 }
 
@@ -2789,6 +2816,7 @@
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
 			kfree (card->ac97_codec[i]);
+			card->ac97_codec[i] = NULL;
 		}
 	unregister_sound_dsp(card->dev_audio);
 	kfree(card);
@@ -2957,9 +2985,6 @@
 	if(ftsodell != 0) {
 		printk("i810_audio: ftsodell is now a deprecated option.\n");
 	}
-	if(clocking == 48000) {
-		i810_configure_clocking();
-	}
 	if(spdif_locked > 0 ) {
 		if(spdif_locked == 32000 || spdif_locked == 44100 || spdif_locked == 48000) {
 			printk("i810_audio: Enabling S/PDIF at sample rate %dHz.\n", spdif_locked);

--------------060603030907000505000408--

