Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTBOM0m>; Sat, 15 Feb 2003 07:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTBOM0m>; Sat, 15 Feb 2003 07:26:42 -0500
Received: from holomorphy.com ([66.224.33.161]:50309 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261868AbTBOMZ6>;
	Sat, 15 Feb 2003 07:25:58 -0500
Date: Sat, 15 Feb 2003 04:34:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: clean up SLAB_KERNEL non-usage
Message-ID: <20030215123441.GH29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20030215114054.GA32256@holomorphy.com> <20030215114931.A18281@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215114931.A18281@infradead.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 03:40:54AM -0800, William Lee Irwin III wrote:
>> Use SLAB_KERNEL and SLAB_ATOMIC instead of GFP_KERNEL and GFP_ATOMIC
>> when passing args to slab allocation functions.

On Sat, Feb 15, 2003 at 11:49:31AM +0000, Christoph Hellwig wrote:
> Why?  I'd prefer to completly get rid of the SLAB_ flags instead.
> (stupid slowaris compat..)


Kill SLAB_KERNEL and SLAB_ATOMIC.

 Documentation/DMA-mapping.txt             |    4 +-
 Documentation/filesystems/devfs/ChangeLog |    1 
 Documentation/usb/URB.txt                 |    2 -
 arch/arm/common/sa1111-pcipool.c          |    6 ++--
 arch/i386/mm/pgtable.c                    |    4 +-
 arch/ia64/ia32/binfmt_elf32.c             |    6 ++--
 arch/ia64/kernel/perfmon.c                |    2 -
 arch/ia64/mm/init.c                       |    4 +-
 arch/s390x/kernel/exec32.c                |    2 -
 arch/x86_64/ia32/ia32_binfmt.c            |    2 -
 drivers/block/DAC960.c                    |    4 +-
 drivers/block/ll_rw_blk.c                 |    2 -
 drivers/ieee1394/amdtp.c                  |   16 +++++-----
 drivers/ieee1394/cmp.c                    |    2 -
 drivers/ieee1394/eth1394.c                |    2 -
 drivers/ieee1394/hosts.c                  |    2 -
 drivers/ieee1394/iso.c                    |    2 -
 drivers/ieee1394/nodemgr.c                |    2 -
 drivers/ieee1394/ohci1394.c               |   12 ++++----
 drivers/ieee1394/pcilynx.c                |    2 -
 drivers/ieee1394/raw1394.c                |   44 +++++++++++++++---------------
 drivers/ieee1394/sbp2.c                   |    2 -
 drivers/pci/pool.c                        |    8 ++---
 drivers/usb/core/hub.c                    |    2 -
 drivers/usb/core/message.c                |    2 -
 drivers/usb/host/ehci-dbg.c               |    2 -
 drivers/usb/host/ehci-hcd.c               |    2 -
 drivers/usb/host/ehci-q.c                 |    2 -
 drivers/usb/host/ohci-dbg.c               |    2 -
 drivers/usb/host/ohci-q.c                 |    4 +-
 drivers/usb/host/uhci-hcd.c               |    2 -
 drivers/usb/input/aiptek.c                |    2 -
 drivers/usb/input/hid-core.c              |   10 +++---
 drivers/usb/input/powermate.c             |    4 +-
 drivers/usb/input/usbkbd.c                |    8 ++---
 drivers/usb/input/usbmouse.c              |    4 +-
 drivers/usb/input/wacom.c                 |    2 -
 drivers/usb/input/xpad.c                  |    2 -
 drivers/usb/misc/usbtest.c                |   28 +++++++++----------
 drivers/usb/net/catc.c                    |    2 -
 drivers/usb/net/kaweth.c                  |    2 -
 drivers/usb/net/pegasus.c                 |    2 -
 drivers/usb/net/rtl8150.c                 |    2 -
 fs/adfs/super.c                           |    2 -
 fs/affs/super.c                           |    2 -
 fs/afs/super.c                            |    2 -
 fs/befs/linuxvfs.c                        |    2 -
 fs/bfs/inode.c                            |    2 -
 fs/block_dev.c                            |    2 -
 fs/char_dev.c                             |    2 -
 fs/cifs/cifsfs.c                          |    2 -
 fs/cifs/misc.c                            |    2 -
 fs/cifs/transport.c                       |    2 -
 fs/coda/inode.c                           |    2 -
 fs/devfs/base.c                           |    4 +-
 fs/dnotify.c                              |    2 -
 fs/dquot.c                                |    2 -
 fs/efs/super.c                            |    2 -
 fs/eventpoll.c                            |    4 +-
 fs/exec.c                                 |    2 -
 fs/ext2/super.c                           |    2 -
 fs/fat/inode.c                            |    2 -
 fs/fcntl.c                                |    2 -
 fs/file_table.c                           |    2 -
 fs/freevxfs/vxfs_fshead.c                 |    2 -
 fs/freevxfs/vxfs_inode.c                  |    4 +-
 fs/hfs/super.c                            |    2 -
 fs/hpfs/super.c                           |    2 -
 fs/inode.c                                |    2 -
 fs/intermezzo/dcache.c                    |    2 -
 fs/isofs/inode.c                          |    2 -
 fs/jffs/jffs_fm.c                         |    4 +-
 fs/jffs2/super.c                          |    2 -
 fs/locks.c                                |    2 -
 fs/minix/inode.c                          |    2 -
 fs/ncpfs/inode.c                          |    2 -
 fs/nfs/inode.c                            |    2 -
 fs/proc/inode.c                           |    2 -
 fs/qnx4/inode.c                           |    2 -
 fs/reiserfs/super.c                       |    2 -
 fs/romfs/inode.c                          |    2 -
 fs/smbfs/inode.c                          |    2 -
 fs/smbfs/request.c                        |    2 -
 fs/sysv/inode.c                           |    2 -
 fs/udf/super.c                            |    2 -
 fs/ufs/super.c                            |    2 -
 include/linux/fs.h                        |    2 -
 include/linux/slab.h                      |    2 -
 include/net/tcp.h                         |    2 -
 kernel/fork.c                             |    6 ++--
 kernel/user.c                             |    2 -
 mm/mmap.c                                 |    6 ++--
 mm/mremap.c                               |    2 -
 mm/shmem.c                                |    2 -
 mm/slab.c                                 |    2 -
 net/core/dst.c                            |    2 -
 net/core/neighbour.c                      |    2 -
 net/decnet/dn_table.c                     |    2 -
 net/ipv4/fib_hash.c                       |    2 -
 net/ipv4/tcp_ipv4.c                       |    2 -
 net/ipv4/tcp_minisocks.c                  |    2 -
 net/ipv4/xfrm_input.c                     |    2 -
 net/ipv4/xfrm_policy.c                    |    2 -
 net/ipv6/ip6_fib.c                        |    2 -
 net/socket.c                              |    2 -
 net/sunrpc/rpc_pipe.c                     |    2 -
 106 files changed, 180 insertions(+), 181 deletions(-)


diff -urpN linux-2.5.61/Documentation/DMA-mapping.txt slab-2.5.61/Documentation/DMA-mapping.txt
--- linux-2.5.61/Documentation/DMA-mapping.txt	2003-02-14 15:51:46.000000000 -0800
+++ slab-2.5.61/Documentation/DMA-mapping.txt	2003-02-15 04:31:19.000000000 -0800
@@ -341,8 +341,8 @@ Allocate memory from a pci pool like thi
 
 	cpu_addr = pci_pool_alloc(pool, flags, &dma_handle);
 
-flags are SLAB_KERNEL if blocking is permitted (not in_interrupt nor
-holding SMP locks), SLAB_ATOMIC otherwise.  Like pci_alloc_consistent,
+flags are GFP_KERNEL if blocking is permitted (not in_interrupt nor
+holding SMP locks), GFP_ATOMIC otherwise.  Like pci_alloc_consistent,
 this returns two values, cpu_addr and dma_handle.
 
 Free memory that was allocated from a pci_pool like this:
diff -urpN linux-2.5.61/Documentation/filesystems/devfs/ChangeLog slab-2.5.61/Documentation/filesystems/devfs/ChangeLog
--- linux-2.5.61/Documentation/filesystems/devfs/ChangeLog	2003-02-14 15:51:18.000000000 -0800
+++ slab-2.5.61/Documentation/filesystems/devfs/ChangeLog	2003-02-15 04:31:18.000000000 -0800
@@ -1822,7 +1822,7 @@ Changes for patch v202
 ===============================================================================
 Changes for patch v203
 
-- Use SLAB_ATOMIC in <devfsd_notify_de> from <devfs_d_delete>
+- Use GFP_ATOMIC in <devfsd_notify_de> from <devfs_d_delete>
 ===============================================================================
 Changes for patch v204
 
diff -urpN linux-2.5.61/Documentation/usb/URB.txt slab-2.5.61/Documentation/usb/URB.txt
--- linux-2.5.61/Documentation/usb/URB.txt	2003-02-14 15:51:26.000000000 -0800
+++ slab-2.5.61/Documentation/usb/URB.txt	2003-02-15 04:31:19.000000000 -0800
@@ -121,7 +121,7 @@ Just call
 
 	int usb_submit_urb(struct urb *urb, int mem_flags)
 
-The mem_flags parameter, such as SLAB_ATOMIC, controls memory allocation,
+The mem_flags parameter, such as GFP_ATOMIC, controls memory allocation,
 such as whether the lower levels may block when memory is tight.
 
 It immediately returns, either with status 0 (request queued) or some
diff -urpN linux-2.5.61/arch/arm/common/sa1111-pcipool.c slab-2.5.61/arch/arm/common/sa1111-pcipool.c
--- linux-2.5.61/arch/arm/common/sa1111-pcipool.c	2003-02-14 15:52:04.000000000 -0800
+++ slab-2.5.61/arch/arm/common/sa1111-pcipool.c	2003-02-15 04:31:18.000000000 -0800
@@ -110,7 +110,7 @@ pci_pool_create (const char *name, struc
 	} else if (allocation < size)
 		return 0;
 
-	if (!(retval = kmalloc (sizeof *retval, SLAB_KERNEL)))
+	if (!(retval = kmalloc (sizeof *retval, GFP_KERNEL)))
 		return retval;
 
 	strncpy (retval->name, name, sizeof retval->name);
@@ -228,7 +228,7 @@ pci_pool_destroy (struct pci_pool *pool)
 /**
  * pci_pool_alloc - get a block of consistent memory
  * @pool: pci pool that will produce the block
- * @mem_flags: SLAB_KERNEL or SLAB_ATOMIC
+ * @mem_flags: GFP_KERNEL or GFP_ATOMIC
  * @handle: pointer to dma address of block
  *
  * This returns the kernel virtual address of a currently unused block,
@@ -266,7 +266,7 @@ restart:
 		}
 	}
 	if (!(page = pool_alloc_page (pool, mem_flags))) {
-		if (mem_flags == SLAB_KERNEL) {
+		if (mem_flags == GFP_KERNEL) {
 			DECLARE_WAITQUEUE (wait, current);
 
 			current->state = TASK_INTERRUPTIBLE;
diff -urpN linux-2.5.61/arch/i386/mm/pgtable.c slab-2.5.61/arch/i386/mm/pgtable.c
--- linux-2.5.61/arch/i386/mm/pgtable.c	2003-02-14 15:53:03.000000000 -0800
+++ slab-2.5.61/arch/i386/mm/pgtable.c	2003-02-15 04:30:46.000000000 -0800
@@ -188,7 +188,7 @@ void pgd_ctor(void *__pgd, kmem_cache_t 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
-	pgd_t *pgd = kmem_cache_alloc(pgd_cache, SLAB_KERNEL);
+	pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
 
 	if (PTRS_PER_PMD == 1)
 		return pgd;
@@ -196,7 +196,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 		return NULL;
 
 	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
-		pmd_t *pmd = kmem_cache_alloc(pmd_cache, SLAB_KERNEL);
+		pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
 		if (!pmd)
 			goto out_oom;
 		set_pgd(pgd + i, __pgd(1 + __pa((unsigned long long)((unsigned long)pmd))));
diff -urpN linux-2.5.61/arch/ia64/ia32/binfmt_elf32.c slab-2.5.61/arch/ia64/ia32/binfmt_elf32.c
--- linux-2.5.61/arch/ia64/ia32/binfmt_elf32.c	2003-02-14 15:52:38.000000000 -0800
+++ slab-2.5.61/arch/ia64/ia32/binfmt_elf32.c	2003-02-15 04:30:46.000000000 -0800
@@ -79,7 +79,7 @@ ia64_elf32_init (struct pt_regs *regs)
 	 * it with privilege level 3 because the IVE uses non-privileged accesses to these
 	 * tables.  IA-32 segmentation is used to protect against IA-32 accesses to them.
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 	if (vma) {
 		vma->vm_mm = current->mm;
 		vma->vm_start = IA32_GDT_OFFSET;
@@ -101,7 +101,7 @@ ia64_elf32_init (struct pt_regs *regs)
 	 * Install LDT as anonymous memory.  This gives us all-zero segment descriptors
 	 * until a task modifies them via modify_ldt().
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 	if (vma) {
 		vma->vm_mm = current->mm;
 		vma->vm_start = IA32_LDT_OFFSET;
@@ -172,7 +172,7 @@ ia32_setup_arg_pages (struct linux_binpr
 		bprm->loader += stack_base;
 	bprm->exec += stack_base;
 
-	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	mpnt = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 	if (!mpnt)
 		return -ENOMEM;
 
diff -urpN linux-2.5.61/arch/ia64/kernel/perfmon.c slab-2.5.61/arch/ia64/kernel/perfmon.c
--- linux-2.5.61/arch/ia64/kernel/perfmon.c	2003-02-14 15:52:38.000000000 -0800
+++ slab-2.5.61/arch/ia64/kernel/perfmon.c	2003-02-15 04:30:46.000000000 -0800
@@ -796,7 +796,7 @@ pfm_smpl_buffer_alloc(pfm_context_t *ctx
 	}
 
 	/* allocate vma */
-	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 	if (!vma) {
 		DBprintk(("Cannot allocate vma\n"));
 		goto error_kmem;
diff -urpN linux-2.5.61/arch/ia64/mm/init.c slab-2.5.61/arch/ia64/mm/init.c
--- linux-2.5.61/arch/ia64/mm/init.c	2003-02-14 15:51:33.000000000 -0800
+++ slab-2.5.61/arch/ia64/mm/init.c	2003-02-15 04:30:46.000000000 -0800
@@ -74,7 +74,7 @@ ia64_init_addr_space (void)
 	 * the problem.  When the process attempts to write to the register backing store
 	 * for the first time, it will get a SEGFAULT in this case.
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 	if (vma) {
 		vma->vm_mm = current->mm;
 		vma->vm_start = IA64_RBS_BOT;
@@ -90,7 +90,7 @@ ia64_init_addr_space (void)
 
 	/* map NaT-page at address zero to speed up speculative dereferencing of NULL: */
 	if (!(current->personality & MMAP_PAGE_ZERO)) {
-		vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+		vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 		if (vma) {
 			memset(vma, 0, sizeof(*vma));
 			vma->vm_mm = current->mm;
diff -urpN linux-2.5.61/arch/s390x/kernel/exec32.c slab-2.5.61/arch/s390x/kernel/exec32.c
--- linux-2.5.61/arch/s390x/kernel/exec32.c	2003-02-14 15:51:05.000000000 -0800
+++ slab-2.5.61/arch/s390x/kernel/exec32.c	2003-02-15 04:30:47.000000000 -0800
@@ -51,7 +51,7 @@ int setup_arg_pages32(struct linux_binpr
 		bprm->loader += stack_base;
 	bprm->exec += stack_base;
 
-	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	mpnt = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 	if (!mpnt) 
 		return -ENOMEM; 
 	
diff -urpN linux-2.5.61/arch/x86_64/ia32/ia32_binfmt.c slab-2.5.61/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.5.61/arch/x86_64/ia32/ia32_binfmt.c	2003-02-14 15:51:09.000000000 -0800
+++ slab-2.5.61/arch/x86_64/ia32/ia32_binfmt.c	2003-02-15 04:30:47.000000000 -0800
@@ -290,7 +290,7 @@ int setup_arg_pages(struct linux_binprm 
 		bprm->loader += stack_base;
 	bprm->exec += stack_base;
 
-	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	mpnt = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 	if (!mpnt) 
 		return -ENOMEM; 
 	
diff -urpN linux-2.5.61/drivers/block/DAC960.c slab-2.5.61/drivers/block/DAC960.c
--- linux-2.5.61/drivers/block/DAC960.c	2003-02-14 15:52:26.000000000 -0800
+++ slab-2.5.61/drivers/block/DAC960.c	2003-02-15 04:31:16.000000000 -0800
@@ -251,13 +251,13 @@ static boolean DAC960_CreateAuxiliaryStr
       Command->Next = Controller->FreeCommands;
       Controller->FreeCommands = Command;
       Controller->Commands[CommandIdentifier-1] = Command;
-      ScatterGatherCPU = pci_pool_alloc(ScatterGatherPool, SLAB_ATOMIC,
+      ScatterGatherCPU = pci_pool_alloc(ScatterGatherPool, GFP_ATOMIC,
 							&ScatterGatherDMA);
       if (ScatterGatherCPU == NULL)
 	  return DAC960_Failure(Controller, "AUXILIARY STRUCTURE CREATION");
 
       if (RequestSensePool != NULL) {
-  	  RequestSenseCPU = pci_pool_alloc(RequestSensePool, SLAB_ATOMIC,
+  	  RequestSenseCPU = pci_pool_alloc(RequestSensePool, GFP_ATOMIC,
 						&RequestSenseDMA);
   	  if (RequestSenseCPU == NULL) {
                 pci_pool_free(ScatterGatherPool, ScatterGatherCPU,
diff -urpN linux-2.5.61/drivers/block/ll_rw_blk.c slab-2.5.61/drivers/block/ll_rw_blk.c
--- linux-2.5.61/drivers/block/ll_rw_blk.c	2003-02-14 15:51:12.000000000 -0800
+++ slab-2.5.61/drivers/block/ll_rw_blk.c	2003-02-15 04:30:44.000000000 -0800
@@ -1222,7 +1222,7 @@ static int blk_init_free_list(request_qu
 	 */
 	rl = &q->rq[READ];
 	for (i = 0; i < (queue_nr_requests*2); i++) {
-		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
+		rq = kmem_cache_alloc(request_cachep, GFP_KERNEL);
 		if (!rq)
 			goto nomem;
 
diff -urpN linux-2.5.61/drivers/ieee1394/amdtp.c slab-2.5.61/drivers/ieee1394/amdtp.c
--- linux-2.5.61/drivers/ieee1394/amdtp.c	2003-02-14 15:51:55.000000000 -0800
+++ slab-2.5.61/drivers/ieee1394/amdtp.c	2003-02-15 04:31:17.000000000 -0800
@@ -558,15 +558,15 @@ struct packet_list *packet_list_alloc(st
 	struct packet_list *pl;
 	struct packet *next;
 
-	pl = kmalloc(sizeof *pl, SLAB_KERNEL);
+	pl = kmalloc(sizeof *pl, GFP_KERNEL);
 	if (pl == NULL)
 		return NULL;
 
 	for (i = 0; i < PACKET_LIST_SIZE; i++) {
 		struct packet *p = &pl->packets[i];
-		p->db = pci_pool_alloc(s->descriptor_pool, SLAB_KERNEL,
+		p->db = pci_pool_alloc(s->descriptor_pool, GFP_KERNEL,
 				       &p->db_bus);
-		p->payload = pci_pool_alloc(s->packet_pool, SLAB_KERNEL,
+		p->payload = pci_pool_alloc(s->packet_pool, GFP_KERNEL,
 					    &p->payload_bus);
 	}
 
@@ -597,7 +597,7 @@ static struct buffer *buffer_alloc(int s
 {
 	struct buffer *b;
 
-	b = kmalloc(sizeof *b + size, SLAB_KERNEL);
+	b = kmalloc(sizeof *b + size, GFP_KERNEL);
 	b->head = 0;
 	b->tail = 0;
 	b->length = 0;
@@ -834,7 +834,7 @@ static int stream_alloc_packet_lists(str
 
 	max_packet_size = max_nevents * s->dimension * 4 + 8;
 	s->packet_pool = hpsb_pci_pool_create("packet pool", s->host->ohci->dev,
-					 max_packet_size, 0, 0 ,SLAB_KERNEL);
+					 max_packet_size, 0, 0 ,GFP_KERNEL);
 
 	if (s->packet_pool == NULL)
 		return -1;
@@ -1006,7 +1006,7 @@ struct stream *stream_alloc(struct amdtp
 	struct stream *s;
 	unsigned long flags;
 
-        s = kmalloc(sizeof(struct stream), SLAB_KERNEL);
+        s = kmalloc(sizeof(struct stream), GFP_KERNEL);
         if (s == NULL)
                 return NULL;
 
@@ -1021,7 +1021,7 @@ struct stream *stream_alloc(struct amdtp
 
 	s->descriptor_pool = hpsb_pci_pool_create("descriptor pool", host->ohci->dev,
 					     sizeof(struct descriptor_block),
-					     16, 0 ,SLAB_KERNEL);
+					     16, 0 ,GFP_KERNEL);
 
 	if (s->descriptor_pool == NULL) {
 		kfree(s->input);
@@ -1212,7 +1212,7 @@ static void amdtp_add_host(struct hpsb_h
 	if (strcmp(host->driver->name, OHCI1394_DRIVER_NAME) != 0)
 		return;
 
-	ah = kmalloc(sizeof *ah, in_interrupt() ? SLAB_ATOMIC : SLAB_KERNEL);
+	ah = kmalloc(sizeof *ah, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 	ah->host = host;
 	ah->ohci = host->hostdata;
 	INIT_LIST_HEAD(&ah->stream_list);
diff -urpN linux-2.5.61/drivers/ieee1394/cmp.c slab-2.5.61/drivers/ieee1394/cmp.c
--- linux-2.5.61/drivers/ieee1394/cmp.c	2003-02-14 15:52:25.000000000 -0800
+++ slab-2.5.61/drivers/ieee1394/cmp.c	2003-02-15 04:31:18.000000000 -0800
@@ -159,7 +159,7 @@ static void cmp_add_host(struct hpsb_hos
 {
 	struct cmp_host *ch;
 
-	ch = kmalloc(sizeof *ch, in_interrupt() ? SLAB_ATOMIC : SLAB_KERNEL);
+	ch = kmalloc(sizeof *ch, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 	if (ch == NULL) {
 		HPSB_ERR("Failed to allocate cmp_host");
 		return;
diff -urpN linux-2.5.61/drivers/ieee1394/eth1394.c slab-2.5.61/drivers/ieee1394/eth1394.c
--- linux-2.5.61/drivers/ieee1394/eth1394.c	2003-02-14 15:51:59.000000000 -0800
+++ slab-2.5.61/drivers/ieee1394/eth1394.c	2003-02-15 04:31:18.000000000 -0800
@@ -360,7 +360,7 @@ static void ether1394_add_host (struct h
 	priv->host = host;
 
 	hi = (struct host_info *)kmalloc (sizeof (struct host_info),
-					  in_interrupt() ? SLAB_ATOMIC : SLAB_KERNEL);
+					  in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 
 	if (hi == NULL)
 		goto out;
diff -urpN linux-2.5.61/drivers/ieee1394/hosts.c slab-2.5.61/drivers/ieee1394/hosts.c
--- linux-2.5.61/drivers/ieee1394/hosts.c	2003-02-14 15:51:31.000000000 -0800
+++ slab-2.5.61/drivers/ieee1394/hosts.c	2003-02-15 04:30:45.000000000 -0800
@@ -123,7 +123,7 @@ struct hpsb_host *hpsb_alloc_host(struct
         struct hpsb_host *h;
 	int i;
 
-        h = kmalloc(sizeof(struct hpsb_host) + extra, SLAB_KERNEL);
+        h = kmalloc(sizeof(struct hpsb_host) + extra, GFP_KERNEL);
         if (!h) return NULL;
         memset(h, 0, sizeof(struct hpsb_host) + extra);
 
diff -urpN linux-2.5.61/drivers/ieee1394/iso.c slab-2.5.61/drivers/ieee1394/iso.c
--- linux-2.5.61/drivers/ieee1394/iso.c	2003-02-14 15:52:28.000000000 -0800
+++ slab-2.5.61/drivers/ieee1394/iso.c	2003-02-15 04:30:45.000000000 -0800
@@ -80,7 +80,7 @@ static struct hpsb_iso* hpsb_iso_common_
 
 	/* allocate and write the struct hpsb_iso */
 	
-	iso = kmalloc(sizeof(*iso), SLAB_KERNEL);
+	iso = kmalloc(sizeof(*iso), GFP_KERNEL);
 	if(!iso)
 		return NULL;
 	
diff -urpN linux-2.5.61/drivers/ieee1394/nodemgr.c slab-2.5.61/drivers/ieee1394/nodemgr.c
--- linux-2.5.61/drivers/ieee1394/nodemgr.c	2003-02-14 15:51:57.000000000 -0800
+++ slab-2.5.61/drivers/ieee1394/nodemgr.c	2003-02-15 04:31:17.000000000 -0800
@@ -1325,7 +1325,7 @@ static void nodemgr_add_host(struct hpsb
 	struct host_info *hi;
 	unsigned long flags;
 
-	hi = kmalloc(sizeof (struct host_info), in_interrupt() ? SLAB_ATOMIC : SLAB_KERNEL);
+	hi = kmalloc(sizeof (struct host_info), in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 
 	if (!hi) {
 		HPSB_ERR ("NodeMgr: out of memory in add host");
diff -urpN linux-2.5.61/drivers/ieee1394/ohci1394.c slab-2.5.61/drivers/ieee1394/ohci1394.c
--- linux-2.5.61/drivers/ieee1394/ohci1394.c	2003-02-14 15:52:31.000000000 -0800
+++ slab-2.5.61/drivers/ieee1394/ohci1394.c	2003-02-15 04:30:45.000000000 -0800
@@ -1056,7 +1056,7 @@ static int ohci_iso_recv_init(struct hps
 	int ctx;
 	int ret = -ENOMEM;
 	
-	recv = kmalloc(sizeof(*recv), SLAB_KERNEL);
+	recv = kmalloc(sizeof(*recv), GFP_KERNEL);
 	if(!recv)
 		return -ENOMEM;
 
@@ -1416,7 +1416,7 @@ static int ohci_iso_xmit_init(struct hps
 	int ctx;
 	int ret = -ENOMEM;
 	
-	xmit = kmalloc(sizeof(*xmit), SLAB_KERNEL);
+	xmit = kmalloc(sizeof(*xmit), GFP_KERNEL);
 	if(!xmit)
 		return -ENOMEM;
 
@@ -2394,7 +2394,7 @@ alloc_dma_rcv_ctx(struct ti_ohci *ohci, 
 	}
 
 	d->prg_pool = hpsb_pci_pool_create("ohci1394 rcv prg", ohci->dev,
-				sizeof(struct dma_cmd), 4, 0, SLAB_KERNEL);
+				sizeof(struct dma_cmd), 4, 0, GFP_KERNEL);
 	OHCI_DMA_ALLOC("dma_rcv prg pool");
 
 	for (i=0; i<d->num_desc; i++) {
@@ -2412,7 +2412,7 @@ alloc_dma_rcv_ctx(struct ti_ohci *ohci, 
 			return -ENOMEM;
 		}
 
-		d->prg_cpu[i] = pci_pool_alloc(d->prg_pool, SLAB_KERNEL, d->prg_bus+i);
+		d->prg_cpu[i] = pci_pool_alloc(d->prg_pool, GFP_KERNEL, d->prg_bus+i);
 		OHCI_DMA_ALLOC("pool dma_rcv prg[%d]", i);
 
                 if (d->prg_cpu[i] != NULL) {
@@ -2503,11 +2503,11 @@ alloc_dma_trm_ctx(struct ti_ohci *ohci, 
 	memset(d->prg_bus, 0, d->num_desc * sizeof(dma_addr_t));
 
 	d->prg_pool = hpsb_pci_pool_create("ohci1394 trm prg", ohci->dev,
-				sizeof(struct at_dma_prg), 4, 0, SLAB_KERNEL);
+				sizeof(struct at_dma_prg), 4, 0, GFP_KERNEL);
 	OHCI_DMA_ALLOC("dma_rcv prg pool");
 
 	for (i = 0; i < d->num_desc; i++) {
-		d->prg_cpu[i] = pci_pool_alloc(d->prg_pool, SLAB_KERNEL, d->prg_bus+i);
+		d->prg_cpu[i] = pci_pool_alloc(d->prg_pool, GFP_KERNEL, d->prg_bus+i);
 		OHCI_DMA_ALLOC("pool dma_trm prg[%d]", i);
 
                 if (d->prg_cpu[i] != NULL) {
diff -urpN linux-2.5.61/drivers/ieee1394/pcilynx.c slab-2.5.61/drivers/ieee1394/pcilynx.c
--- linux-2.5.61/drivers/ieee1394/pcilynx.c	2003-02-14 15:51:29.000000000 -0800
+++ slab-2.5.61/drivers/ieee1394/pcilynx.c	2003-02-15 04:30:45.000000000 -0800
@@ -865,7 +865,7 @@ static int mem_open(struct inode *inode,
                 type = t_ram;
         }
 
-        md = (struct memdata *)kmalloc(sizeof(struct memdata), SLAB_KERNEL);
+        md = (struct memdata *)kmalloc(sizeof(struct memdata), GFP_KERNEL);
         if (md == NULL)
                 return -ENOMEM;
 
diff -urpN linux-2.5.61/drivers/ieee1394/raw1394.c slab-2.5.61/drivers/ieee1394/raw1394.c
--- linux-2.5.61/drivers/ieee1394/raw1394.c	2003-02-14 15:51:06.000000000 -0800
+++ slab-2.5.61/drivers/ieee1394/raw1394.c	2003-02-15 04:31:17.000000000 -0800
@@ -116,7 +116,7 @@ static struct pending_request *__alloc_p
 
 static inline struct pending_request *alloc_pending_request(void)
 {
-        return __alloc_pending_request(SLAB_KERNEL);
+        return __alloc_pending_request(GFP_KERNEL);
 }
 
 static void free_pending_request(struct pending_request *req)
@@ -195,7 +195,7 @@ static void add_host(struct hpsb_host *h
         unsigned long flags;
 
         hi = (struct host_info *)kmalloc(sizeof(struct host_info),
-		in_interrupt() ? SLAB_ATOMIC : SLAB_KERNEL);
+		in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
         if (hi != NULL) {
                 INIT_LIST_HEAD(&hi->list);
                 hi->host = host;
@@ -272,7 +272,7 @@ static void host_reset(struct hpsb_host 
                 list_for_each(lh, &hi->file_info_list) {
                         fi = list_entry(lh, struct file_info, list);
                         if (fi->notification == RAW1394_NOTIFY_ON) {
-                                req = __alloc_pending_request(SLAB_ATOMIC);
+                                req = __alloc_pending_request(GFP_ATOMIC);
 
                                 if (req != NULL) {
                                         req->file_info = fi;
@@ -320,12 +320,12 @@ static void iso_receive(struct hpsb_host
                                 continue;
                         }
 
-                        req = __alloc_pending_request(SLAB_ATOMIC);
+                        req = __alloc_pending_request(GFP_ATOMIC);
                         if (!req) break;
 
                         if (!ibs) {
                                 ibs = kmalloc(sizeof(struct iso_block_store)
-                                              + length, SLAB_ATOMIC);
+                                              + length, GFP_ATOMIC);
                                 if (!ibs) {
                                         kfree(req);
                                         break;
@@ -389,12 +389,12 @@ static void fcp_request(struct hpsb_host
                                 continue;
                         }
 
-                        req = __alloc_pending_request(SLAB_ATOMIC);
+                        req = __alloc_pending_request(GFP_ATOMIC);
                         if (!req) break;
 
                         if (!ibs) {
                                 ibs = kmalloc(sizeof(struct iso_block_store)
-                                              + length, SLAB_ATOMIC);
+                                              + length, GFP_ATOMIC);
                                 if (!ibs) {
                                         kfree(req);
                                         break;
@@ -520,7 +520,7 @@ static int state_initialized(struct file
         case RAW1394_REQ_LIST_CARDS:
                 spin_lock_irq(&host_info_lock);
                 khl = kmalloc(sizeof(struct raw1394_khost_list) * host_count,
-                              SLAB_ATOMIC);
+                              GFP_ATOMIC);
 
                 if (khl != NULL) {
                         req->req.misc = host_count;
@@ -942,7 +942,7 @@ static int arm_read (struct hpsb_host *h
         }
         if (arm_addr->notification_options & ARM_READ) {
                 DBGMSG("arm_read -> entering notification-section");
-                req = __alloc_pending_request(SLAB_ATOMIC);
+                req = __alloc_pending_request(GFP_ATOMIC);
                 if (!req) {
                         DBGMSG("arm_read -> rcode_conflict_error");
                         spin_unlock(&host_info_lock);
@@ -957,7 +957,7 @@ static int arm_read (struct hpsb_host *h
                         size =  sizeof(struct arm_request)+sizeof(struct arm_response) +
                                 sizeof (struct arm_request_response);
                 }
-                req->data = kmalloc(size, SLAB_ATOMIC);
+                req->data = kmalloc(size, GFP_ATOMIC);
                 if (!(req->data)) {
                         free_pending_request(req);
                         DBGMSG("arm_read -> rcode_conflict_error");
@@ -1079,7 +1079,7 @@ static int arm_write (struct hpsb_host *
         }
         if (arm_addr->notification_options & ARM_WRITE) {
                 DBGMSG("arm_write -> entering notification-section");
-                req = __alloc_pending_request(SLAB_ATOMIC);
+                req = __alloc_pending_request(GFP_ATOMIC);
                 if (!req) {
                         DBGMSG("arm_write -> rcode_conflict_error");
                         spin_unlock(&host_info_lock);
@@ -1089,7 +1089,7 @@ static int arm_write (struct hpsb_host *
                 size =  sizeof(struct arm_request)+sizeof(struct arm_response) +
                         (length) * sizeof(byte_t) +
                         sizeof (struct arm_request_response);
-                req->data = kmalloc(size, SLAB_ATOMIC);
+                req->data = kmalloc(size, GFP_ATOMIC);
                 if (!(req->data)) {
                         free_pending_request(req);
                         DBGMSG("arm_write -> rcode_conflict_error");
@@ -1255,7 +1255,7 @@ static int arm_lock (struct hpsb_host *h
         }
         if (arm_addr->notification_options & ARM_LOCK) {
                 DBGMSG("arm_lock -> entering notification-section");
-                req = __alloc_pending_request(SLAB_ATOMIC);
+                req = __alloc_pending_request(GFP_ATOMIC);
                 if (!req) {
                         DBGMSG("arm_lock -> rcode_conflict_error");
                         spin_unlock(&host_info_lock);
@@ -1265,7 +1265,7 @@ static int arm_lock (struct hpsb_host *h
                 size =  sizeof(struct arm_request)+sizeof(struct arm_response) +
                         3 * sizeof(*store) + 
                         sizeof (struct arm_request_response);  /* maximum */
-                req->data = kmalloc(size, SLAB_ATOMIC);
+                req->data = kmalloc(size, GFP_ATOMIC);
                 if (!(req->data)) {
                         free_pending_request(req);
                         DBGMSG("arm_lock -> rcode_conflict_error");
@@ -1462,7 +1462,7 @@ static int arm_lock64 (struct hpsb_host 
         }
         if (arm_addr->notification_options & ARM_LOCK) {
                 DBGMSG("arm_lock64 -> entering notification-section");
-                req = __alloc_pending_request(SLAB_ATOMIC);
+                req = __alloc_pending_request(GFP_ATOMIC);
                 if (!req) {
                         spin_unlock(&host_info_lock);
                         DBGMSG("arm_lock64 -> rcode_conflict_error");
@@ -1472,7 +1472,7 @@ static int arm_lock64 (struct hpsb_host 
                 size =  sizeof(struct arm_request)+sizeof(struct arm_response) +
                         3 * sizeof(*store) +
                         sizeof (struct arm_request_response); /* maximum */
-                req->data = kmalloc(size, SLAB_ATOMIC);
+                req->data = kmalloc(size, GFP_ATOMIC);
                 if (!(req->data)) {
                         free_pending_request(req);
                         spin_unlock(&host_info_lock);
@@ -1571,13 +1571,13 @@ static int arm_register(struct file_info
                 return (-EINVAL);
         }
         /* addr-list-entry for fileinfo */
-        addr = (struct arm_addr *)kmalloc(sizeof(struct arm_addr), SLAB_KERNEL); 
+        addr = (struct arm_addr *)kmalloc(sizeof(struct arm_addr), GFP_KERNEL); 
         if (!addr) {
                 req->req.length = 0;
                 return (-ENOMEM);
         } 
         /* allocation of addr_space_buffer */
-        addr->addr_space_buffer = (u8 *)kmalloc(req->req.length,SLAB_KERNEL);
+        addr->addr_space_buffer = (u8 *)kmalloc(req->req.length,GFP_KERNEL);
         if (!(addr->addr_space_buffer)) {
                 kfree(addr);
                 req->req.length = 0;
@@ -1827,7 +1827,7 @@ static int get_config_rom(struct file_in
         size_t return_size;
         unsigned char rom_version;
         int ret=sizeof(struct raw1394_request);
-        quadlet_t *data = kmalloc(req->req.length, SLAB_KERNEL);
+        quadlet_t *data = kmalloc(req->req.length, GFP_KERNEL);
         int status;
         if (!data) return -ENOMEM;
         status = hpsb_get_config_rom(fi->host, data, 
@@ -1854,7 +1854,7 @@ static int get_config_rom(struct file_in
 static int update_config_rom(struct file_info *fi, struct pending_request *req)
 {
         int ret=sizeof(struct raw1394_request);
-        quadlet_t *data = kmalloc(req->req.length, SLAB_KERNEL);
+        quadlet_t *data = kmalloc(req->req.length, GFP_KERNEL);
         if (!data) return -ENOMEM;
         if (copy_from_user(data,int2ptr(req->req.sendb), 
                 req->req.length)) {
@@ -2033,7 +2033,7 @@ static void rawiso_activity_cb(struct hp
 
 			/* only one ISO activity event may be in the queue */
 			if(!__rawiso_event_in_queue(fi)) {
-				struct pending_request *req = __alloc_pending_request(SLAB_ATOMIC);
+				struct pending_request *req = __alloc_pending_request(GFP_ATOMIC);
 
 				if(req) {
 					req->file_info = fi;
@@ -2248,7 +2248,7 @@ static int raw1394_open(struct inode *in
                 return -ENXIO;
         }
 
-        fi = kmalloc(sizeof(struct file_info), SLAB_KERNEL);
+        fi = kmalloc(sizeof(struct file_info), GFP_KERNEL);
         if (fi == NULL)
                 return -ENOMEM;
         
diff -urpN linux-2.5.61/drivers/ieee1394/sbp2.c slab-2.5.61/drivers/ieee1394/sbp2.c
--- linux-2.5.61/drivers/ieee1394/sbp2.c	2003-02-14 15:51:17.000000000 -0800
+++ slab-2.5.61/drivers/ieee1394/sbp2.c	2003-02-15 04:31:17.000000000 -0800
@@ -1011,7 +1011,7 @@ static void sbp2_add_host(struct hpsb_ho
 
 	/* Allocate some memory for our host info structure */
 	hi = (struct sbp2scsi_host_info *)kmalloc(sizeof(struct sbp2scsi_host_info),
-						  in_interrupt() ? SLAB_ATOMIC : SLAB_KERNEL);
+						  in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 
 	if (hi == NULL) {
 		SBP2_ERR("out of memory in sbp2_add_host");
diff -urpN linux-2.5.61/drivers/pci/pool.c slab-2.5.61/drivers/pci/pool.c
--- linux-2.5.61/drivers/pci/pool.c	2003-02-14 15:52:39.000000000 -0800
+++ slab-2.5.61/drivers/pci/pool.c	2003-02-15 04:31:17.000000000 -0800
@@ -125,7 +125,7 @@ pci_pool_create (const char *name, struc
 	} else if (allocation < size)
 		return 0;
 
-	if (!(retval = kmalloc (sizeof *retval, SLAB_KERNEL)))
+	if (!(retval = kmalloc (sizeof *retval, GFP_KERNEL)))
 		return retval;
 
 	strncpy (retval->name, name, sizeof retval->name);
@@ -249,7 +249,7 @@ pci_pool_destroy (struct pci_pool *pool)
 /**
  * pci_pool_alloc - get a block of consistent memory
  * @pool: pci pool that will produce the block
- * @mem_flags: SLAB_KERNEL or SLAB_ATOMIC
+ * @mem_flags: GFP_KERNEL or GFP_ATOMIC
  * @handle: pointer to dma address of block
  *
  * This returns the kernel virtual address of a currently unused block,
@@ -286,8 +286,8 @@ restart:
 			}
 		}
 	}
-	if (!(page = pool_alloc_page (pool, SLAB_ATOMIC))) {
-		if (mem_flags == SLAB_KERNEL) {
+	if (!(page = pool_alloc_page (pool, GFP_ATOMIC))) {
+		if (mem_flags == GFP_KERNEL) {
 			DECLARE_WAITQUEUE (wait, current);
 
 			current->state = TASK_INTERRUPTIBLE;
diff -urpN linux-2.5.61/drivers/usb/core/hub.c slab-2.5.61/drivers/usb/core/hub.c
--- linux-2.5.61/drivers/usb/core/hub.c	2003-02-14 15:51:44.000000000 -0800
+++ slab-2.5.61/drivers/usb/core/hub.c	2003-02-15 04:31:15.000000000 -0800
@@ -233,7 +233,7 @@ void usb_hub_tt_clear_buffer (struct usb
 	 * since each TT has "at least two" buffers that can need it (and
 	 * there can be many TTs per hub).  even if they're uncommon.
 	 */
-	if ((clear = kmalloc (sizeof *clear, SLAB_ATOMIC)) == 0) {
+	if ((clear = kmalloc (sizeof *clear, GFP_ATOMIC)) == 0) {
 		err ("can't save CLEAR_TT_BUFFER state for hub at usb-%s-%s",
 			dev->bus->bus_name, tt->hub->devpath);
 		/* FIXME recover somehow ... RESET_TT? */
diff -urpN linux-2.5.61/drivers/usb/core/message.c slab-2.5.61/drivers/usb/core/message.c
--- linux-2.5.61/drivers/usb/core/message.c	2003-02-14 15:51:21.000000000 -0800
+++ slab-2.5.61/drivers/usb/core/message.c	2003-02-15 04:31:15.000000000 -0800
@@ -439,7 +439,7 @@ void usb_sg_wait (struct usb_sg_request 
 	for (i = 0; i < io->entries && !io->status; i++) {
 		int	retval;
 
-		retval = usb_submit_urb (io->urbs [i], SLAB_ATOMIC);
+		retval = usb_submit_urb (io->urbs [i], GFP_ATOMIC);
 
 		/* after we submit, let completions or cancelations fire;
 		 * we handshake using io->status.
diff -urpN linux-2.5.61/drivers/usb/host/ehci-dbg.c slab-2.5.61/drivers/usb/host/ehci-dbg.c
--- linux-2.5.61/drivers/usb/host/ehci-dbg.c	2003-02-14 15:52:27.000000000 -0800
+++ slab-2.5.61/drivers/usb/host/ehci-dbg.c	2003-02-15 04:31:16.000000000 -0800
@@ -429,7 +429,7 @@ show_periodic (struct device *dev, char 
 	char			*next;
 	unsigned		i, tag;
 
-	if (!(seen = kmalloc (DBG_SCHED_LIMIT * sizeof *seen, SLAB_ATOMIC)))
+	if (!(seen = kmalloc (DBG_SCHED_LIMIT * sizeof *seen, GFP_ATOMIC)))
 		return 0;
 	seen_count = 0;
 
diff -urpN linux-2.5.61/drivers/usb/host/ehci-hcd.c slab-2.5.61/drivers/usb/host/ehci-hcd.c
--- linux-2.5.61/drivers/usb/host/ehci-hcd.c	2003-02-14 15:52:03.000000000 -0800
+++ slab-2.5.61/drivers/usb/host/ehci-hcd.c	2003-02-15 04:30:43.000000000 -0800
@@ -361,7 +361,7 @@ static int ehci_start (struct usb_hcd *h
 	 * periodic_size can shrink by USBCMD update if hcc_params allows.
 	 */
 	ehci->periodic_size = DEFAULT_I_TDPS;
-	if ((retval = ehci_mem_init (ehci, SLAB_KERNEL)) < 0)
+	if ((retval = ehci_mem_init (ehci, GFP_KERNEL)) < 0)
 		return retval;
 
 	/* controllers may cache some of the periodic schedule ... */
diff -urpN linux-2.5.61/drivers/usb/host/ehci-q.c slab-2.5.61/drivers/usb/host/ehci-q.c
--- linux-2.5.61/drivers/usb/host/ehci-q.c	2003-02-14 15:52:27.000000000 -0800
+++ slab-2.5.61/drivers/usb/host/ehci-q.c	2003-02-15 04:31:16.000000000 -0800
@@ -756,7 +756,7 @@ static struct ehci_qh *qh_append_tds (
 	qh = (struct ehci_qh *) *ptr;
 	if (unlikely (qh == 0)) {
 		/* can't sleep here, we have ehci->lock... */
-		qh = qh_make (ehci, urb, SLAB_ATOMIC);
+		qh = qh_make (ehci, urb, GFP_ATOMIC);
 		*ptr = qh;
 	}
 	if (likely (qh != 0)) {
diff -urpN linux-2.5.61/drivers/usb/host/ohci-dbg.c slab-2.5.61/drivers/usb/host/ohci-dbg.c
--- linux-2.5.61/drivers/usb/host/ohci-dbg.c	2003-02-14 15:52:32.000000000 -0800
+++ slab-2.5.61/drivers/usb/host/ohci-dbg.c	2003-02-15 04:31:16.000000000 -0800
@@ -427,7 +427,7 @@ show_periodic (struct device *dev, char 
 	char			*next;
 	unsigned		i;
 
-	if (!(seen = kmalloc (DBG_SCHED_LIMIT * sizeof *seen, SLAB_ATOMIC)))
+	if (!(seen = kmalloc (DBG_SCHED_LIMIT * sizeof *seen, GFP_ATOMIC)))
 		return 0;
 	seen_count = 0;
 
diff -urpN linux-2.5.61/drivers/usb/host/ohci-q.c slab-2.5.61/drivers/usb/host/ohci-q.c
--- linux-2.5.61/drivers/usb/host/ohci-q.c	2003-02-14 15:52:39.000000000 -0800
+++ slab-2.5.61/drivers/usb/host/ohci-q.c	2003-02-15 04:31:16.000000000 -0800
@@ -362,7 +362,7 @@ static struct ed *ed_get (
 	if (!(ed = dev->ep [ep])) {
 		struct td	*td;
 
-		ed = ed_alloc (ohci, SLAB_ATOMIC);
+		ed = ed_alloc (ohci, GFP_ATOMIC);
 		if (!ed) {
 			/* out of memory */
 			goto done;
@@ -370,7 +370,7 @@ static struct ed *ed_get (
 		dev->ep [ep] = ed;
 
   		/* dummy td; end of td list for ed */
-		td = td_alloc (ohci, SLAB_ATOMIC);
+		td = td_alloc (ohci, GFP_ATOMIC);
  		if (!td) {
 			/* out of memory */
 			ed_free (ohci, ed);
diff -urpN linux-2.5.61/drivers/usb/host/uhci-hcd.c slab-2.5.61/drivers/usb/host/uhci-hcd.c
--- linux-2.5.61/drivers/usb/host/uhci-hcd.c	2003-02-14 15:52:36.000000000 -0800
+++ slab-2.5.61/drivers/usb/host/uhci-hcd.c	2003-02-15 04:31:16.000000000 -0800
@@ -647,7 +647,7 @@ static struct urb_priv *uhci_alloc_urb_p
 {
 	struct urb_priv *urbp;
 
-	urbp = kmem_cache_alloc(uhci_up_cachep, SLAB_ATOMIC);
+	urbp = kmem_cache_alloc(uhci_up_cachep, GFP_ATOMIC);
 	if (!urbp) {
 		err("uhci_alloc_urb_priv: couldn't allocate memory for urb_priv\n");
 		return NULL;
diff -urpN linux-2.5.61/drivers/usb/input/aiptek.c slab-2.5.61/drivers/usb/input/aiptek.c
--- linux-2.5.61/drivers/usb/input/aiptek.c	2003-02-14 15:52:25.000000000 -0800
+++ slab-2.5.61/drivers/usb/input/aiptek.c	2003-02-15 04:31:15.000000000 -0800
@@ -263,7 +263,7 @@ aiptek_probe(struct usb_interface *intf,
 
 	memset(aiptek, 0, sizeof (struct aiptek));
 
-	aiptek->data = usb_buffer_alloc(dev, 10, SLAB_ATOMIC, &aiptek->data_dma);
+	aiptek->data = usb_buffer_alloc(dev, 10, GFP_ATOMIC, &aiptek->data_dma);
 	if (!aiptek->data) {
 		kfree(aiptek);
 		return -ENOMEM;
diff -urpN linux-2.5.61/drivers/usb/input/hid-core.c slab-2.5.61/drivers/usb/input/hid-core.c
--- linux-2.5.61/drivers/usb/input/hid-core.c	2003-02-14 15:51:50.000000000 -0800
+++ slab-2.5.61/drivers/usb/input/hid-core.c	2003-02-15 04:31:14.000000000 -0800
@@ -915,7 +915,7 @@ static void hid_irq_in(struct urb *urb, 
 		dbg("nonzero status in input irq %d", urb->status);
 	}
 	
-	status = usb_submit_urb (urb, SLAB_ATOMIC);
+	status = usb_submit_urb (urb, GFP_ATOMIC);
 	if (status)
 		err ("can't resubmit intr, %s-%s/input%d, status %d",
 				hid->dev->bus->bus_name, hid->dev->devpath,
@@ -1377,13 +1377,13 @@ struct hid_blacklist {
 
 static int hid_alloc_buffers(struct usb_device *dev, struct hid_device *hid)
 {
-	if (!(hid->inbuf = usb_buffer_alloc(dev, HID_BUFFER_SIZE, SLAB_ATOMIC, &hid->inbuf_dma)))
+	if (!(hid->inbuf = usb_buffer_alloc(dev, HID_BUFFER_SIZE, GFP_ATOMIC, &hid->inbuf_dma)))
 		return -1;
-	if (!(hid->outbuf = usb_buffer_alloc(dev, HID_BUFFER_SIZE, SLAB_ATOMIC, &hid->outbuf_dma)))
+	if (!(hid->outbuf = usb_buffer_alloc(dev, HID_BUFFER_SIZE, GFP_ATOMIC, &hid->outbuf_dma)))
 		return -1;
-	if (!(hid->cr = usb_buffer_alloc(dev, sizeof(*(hid->cr)), SLAB_ATOMIC, &hid->cr_dma)))
+	if (!(hid->cr = usb_buffer_alloc(dev, sizeof(*(hid->cr)), GFP_ATOMIC, &hid->cr_dma)))
 		return -1;
-	if (!(hid->ctrlbuf = usb_buffer_alloc(dev, HID_BUFFER_SIZE, SLAB_ATOMIC, &hid->ctrlbuf_dma)))
+	if (!(hid->ctrlbuf = usb_buffer_alloc(dev, HID_BUFFER_SIZE, GFP_ATOMIC, &hid->ctrlbuf_dma)))
 		return -1;
 
 	return 0;
diff -urpN linux-2.5.61/drivers/usb/input/powermate.c slab-2.5.61/drivers/usb/input/powermate.c
--- linux-2.5.61/drivers/usb/input/powermate.c	2003-02-14 15:51:51.000000000 -0800
+++ slab-2.5.61/drivers/usb/input/powermate.c	2003-02-15 04:31:14.000000000 -0800
@@ -270,11 +270,11 @@ static int powermate_input_event(struct 
 static int powermate_alloc_buffers(struct usb_device *udev, struct powermate_device *pm)
 {
 	pm->data = usb_buffer_alloc(udev, POWERMATE_PAYLOAD_SIZE,
-				    SLAB_ATOMIC, &pm->data_dma);
+				    GFP_ATOMIC, &pm->data_dma);
 	if (!pm->data)
 		return -1;
 	pm->configcr = usb_buffer_alloc(udev, sizeof(*(pm->configcr)),
-					SLAB_ATOMIC, &pm->configcr_dma);
+					GFP_ATOMIC, &pm->configcr_dma);
 	if (!pm->configcr)
 		return -1;
 
diff -urpN linux-2.5.61/drivers/usb/input/usbkbd.c slab-2.5.61/drivers/usb/input/usbkbd.c
--- linux-2.5.61/drivers/usb/input/usbkbd.c	2003-02-14 15:52:39.000000000 -0800
+++ slab-2.5.61/drivers/usb/input/usbkbd.c	2003-02-15 04:31:15.000000000 -0800
@@ -126,7 +126,7 @@ static void usb_kbd_irq(struct urb *urb,
 	memcpy(kbd->old, kbd->new, 8);
 
 resubmit:
-	i = usb_submit_urb (urb, SLAB_ATOMIC);
+	i = usb_submit_urb (urb, GFP_ATOMIC);
 	if (i)
 		err ("can't resubmit intr, %s-%s/input0, status %d",
 				kbd->usbdev->bus->bus_name,
@@ -204,11 +204,11 @@ static int usb_kbd_alloc_mem(struct usb_
 		return -1;
 	if (!(kbd->led = usb_alloc_urb(0, GFP_KERNEL)))
 		return -1;
-	if (!(kbd->new = usb_buffer_alloc(dev, 8, SLAB_ATOMIC, &kbd->new_dma)))
+	if (!(kbd->new = usb_buffer_alloc(dev, 8, GFP_ATOMIC, &kbd->new_dma)))
 		return -1;
-	if (!(kbd->cr = usb_buffer_alloc(dev, sizeof(struct usb_ctrlrequest), SLAB_ATOMIC, &kbd->cr_dma)))
+	if (!(kbd->cr = usb_buffer_alloc(dev, sizeof(struct usb_ctrlrequest), GFP_ATOMIC, &kbd->cr_dma)))
 		return -1;
-	if (!(kbd->leds = usb_buffer_alloc(dev, 1, SLAB_ATOMIC, &kbd->leds_dma)))
+	if (!(kbd->leds = usb_buffer_alloc(dev, 1, GFP_ATOMIC, &kbd->leds_dma)))
 		return -1;
 
 	return 0;
diff -urpN linux-2.5.61/drivers/usb/input/usbmouse.c slab-2.5.61/drivers/usb/input/usbmouse.c
--- linux-2.5.61/drivers/usb/input/usbmouse.c	2003-02-14 15:52:38.000000000 -0800
+++ slab-2.5.61/drivers/usb/input/usbmouse.c	2003-02-15 04:31:15.000000000 -0800
@@ -90,7 +90,7 @@ static void usb_mouse_irq(struct urb *ur
 
 	input_sync(dev);
 resubmit:
-	status = usb_submit_urb (urb, SLAB_ATOMIC);
+	status = usb_submit_urb (urb, GFP_ATOMIC);
 	if (status)
 		err ("can't resubmit intr, %s-%s/input0, status %d",
 				mouse->usbdev->bus->bus_name,
@@ -149,7 +149,7 @@ static int usb_mouse_probe(struct usb_in
 		return -ENOMEM;
 	memset(mouse, 0, sizeof(struct usb_mouse));
 
-	mouse->data = usb_buffer_alloc(dev, 8, SLAB_ATOMIC, &mouse->data_dma);
+	mouse->data = usb_buffer_alloc(dev, 8, GFP_ATOMIC, &mouse->data_dma);
 	if (!mouse->data) {
 		kfree(mouse);
 		return -ENOMEM;
diff -urpN linux-2.5.61/drivers/usb/input/wacom.c slab-2.5.61/drivers/usb/input/wacom.c
--- linux-2.5.61/drivers/usb/input/wacom.c	2003-02-14 15:51:10.000000000 -0800
+++ slab-2.5.61/drivers/usb/input/wacom.c	2003-02-15 04:31:14.000000000 -0800
@@ -507,7 +507,7 @@ static int wacom_probe(struct usb_interf
 		return -ENOMEM;
 	memset(wacom, 0, sizeof(struct wacom));
 
-	wacom->data = usb_buffer_alloc(dev, 10, SLAB_ATOMIC, &wacom->data_dma);
+	wacom->data = usb_buffer_alloc(dev, 10, GFP_ATOMIC, &wacom->data_dma);
 	if (!wacom->data) {
 		kfree(wacom);
 		return -ENOMEM;
diff -urpN linux-2.5.61/drivers/usb/input/xpad.c slab-2.5.61/drivers/usb/input/xpad.c
--- linux-2.5.61/drivers/usb/input/xpad.c	2003-02-14 15:51:45.000000000 -0800
+++ slab-2.5.61/drivers/usb/input/xpad.c	2003-02-15 04:31:14.000000000 -0800
@@ -239,7 +239,7 @@ static int xpad_probe(struct usb_interfa
 	memset(xpad, 0, sizeof(struct usb_xpad));
 	
 	xpad->idata = usb_buffer_alloc(udev, XPAD_PKT_LEN,
-				       SLAB_ATOMIC, &xpad->idata_dma);
+				       GFP_ATOMIC, &xpad->idata_dma);
 	if (!xpad->idata) {
 		kfree(xpad);
 		return -ENOMEM;
diff -urpN linux-2.5.61/drivers/usb/misc/usbtest.c slab-2.5.61/drivers/usb/misc/usbtest.c
--- linux-2.5.61/drivers/usb/misc/usbtest.c	2003-02-14 15:52:39.000000000 -0800
+++ slab-2.5.61/drivers/usb/misc/usbtest.c	2003-02-15 04:31:15.000000000 -0800
@@ -100,7 +100,7 @@ static struct urb *simple_alloc_urb (
 
 	if (bytes < 0)
 		return 0;
-	urb = usb_alloc_urb (0, SLAB_KERNEL);
+	urb = usb_alloc_urb (0, GFP_KERNEL);
 	if (!urb)
 		return urb;
 	usb_fill_bulk_urb (urb, udev, pipe, 0, bytes, simple_callback, 0);
@@ -110,7 +110,7 @@ static struct urb *simple_alloc_urb (
 	urb->transfer_flags = URB_NO_DMA_MAP;
 	if (usb_pipein (pipe))
 		urb->transfer_flags |= URB_SHORT_NOT_OK;
-	urb->transfer_buffer = usb_buffer_alloc (udev, bytes, SLAB_KERNEL,
+	urb->transfer_buffer = usb_buffer_alloc (udev, bytes, GFP_KERNEL,
 			&urb->transfer_dma);
 	if (!urb->transfer_buffer) {
 		usb_free_urb (urb);
@@ -141,7 +141,7 @@ static int simple_io (
 	urb->context = &completion;
 	while (retval == 0 && iterations-- > 0) {
 		init_completion (&completion);
-		if ((retval = usb_submit_urb (urb, SLAB_KERNEL)) != 0)
+		if ((retval = usb_submit_urb (urb, GFP_KERNEL)) != 0)
 			break;
 
 		/* NOTE:  no timeouts; can't be broken out of by interrupt */
@@ -198,7 +198,7 @@ alloc_sglist (int nents, int max, int va
 	unsigned		i;
 	unsigned		size = max;
 
-	sg = kmalloc (nents * sizeof *sg, SLAB_KERNEL);
+	sg = kmalloc (nents * sizeof *sg, GFP_KERNEL);
 	if (!sg)
 		return 0;
 	memset (sg, 0, nents * sizeof *sg);
@@ -206,7 +206,7 @@ alloc_sglist (int nents, int max, int va
 	for (i = 0; i < nents; i++) {
 		char		*buf;
 
-		buf = kmalloc (size, SLAB_KERNEL);
+		buf = kmalloc (size, GFP_KERNEL);
 		if (!buf) {
 			free_sglist (sg, i);
 			return 0;
@@ -245,7 +245,7 @@ static int perform_sglist (
 				(udev->speed == USB_SPEED_HIGH)
 					? (INTERRUPT_RATE << 3)
 					: INTERRUPT_RATE,
-				sg, nents, 0, SLAB_KERNEL);
+				sg, nents, 0, GFP_KERNEL);
 		
 		if (retval)
 			break;
@@ -658,7 +658,7 @@ error:
 
 	/* resubmit if we need to, else mark this as done */
 	if ((status == 0) && (ctx->pending < ctx->count)) {
-		if ((status = usb_submit_urb (urb, SLAB_ATOMIC)) != 0) {
+		if ((status = usb_submit_urb (urb, GFP_ATOMIC)) != 0) {
 			dbg ("can't resubmit ctrl %02x.%02x, err %d",
 				reqp->bRequestType, reqp->bRequest, status);
 			urb->dev = 0;
@@ -693,7 +693,7 @@ test_ctrl_queue (struct usbtest_dev *dev
 	 * as with bulk/intr sglists, sglen is the queue depth; it also
 	 * controls which subtests run (more tests than sglen) or rerun.
 	 */
-	urb = kmalloc (param->sglen * sizeof (struct urb *), SLAB_KERNEL);
+	urb = kmalloc (param->sglen * sizeof (struct urb *), GFP_KERNEL);
 	if (!urb)
 		goto cleanup;
 	memset (urb, 0, param->sglen * sizeof (struct urb *));
@@ -793,7 +793,7 @@ test_ctrl_queue (struct usbtest_dev *dev
 		if (!u)
 			goto cleanup;
 
-		reqp = usb_buffer_alloc (udev, sizeof req, SLAB_KERNEL,
+		reqp = usb_buffer_alloc (udev, sizeof req, GFP_KERNEL,
 				&u->setup_dma);
 		if (!reqp)
 			goto cleanup;
@@ -809,7 +809,7 @@ test_ctrl_queue (struct usbtest_dev *dev
 	context.urb = urb;
 	spin_lock_irq (&context.lock);
 	for (i = 0; i < param->sglen; i++) {
-		context.status = usb_submit_urb (urb [i], SLAB_ATOMIC);
+		context.status = usb_submit_urb (urb [i], GFP_ATOMIC);
 		if (context.status != 0) {
 			dbg ("can't submit urb[%d], status %d",
 					i, context.status);
@@ -849,7 +849,7 @@ static void unlink1_callback (struct urb
 
 	// we "know" -EPIPE (stall) never happens
 	if (!status)
-		status = usb_submit_urb (urb, SLAB_ATOMIC);
+		status = usb_submit_urb (urb, GFP_ATOMIC);
 	if (status) {
 		if (status == -ECONNRESET || status == -ENOENT)
 			status = 0;
@@ -877,7 +877,7 @@ static int unlink1 (struct usbtest_dev *
 	 * FIXME want additional tests for when endpoint is STALLing
 	 * due to errors, or is just NAKing requests.
 	 */
-	if ((retval = usb_submit_urb (urb, SLAB_KERNEL)) != 0) {
+	if ((retval = usb_submit_urb (urb, GFP_KERNEL)) != 0) {
 		dbg ("submit/unlink fail %d", retval);
 		return retval;
 	}
@@ -1214,7 +1214,7 @@ usbtest_probe (struct usb_interface *int
 	}
 #endif
 
-	dev = kmalloc (sizeof *dev, SLAB_KERNEL);
+	dev = kmalloc (sizeof *dev, GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 	memset (dev, 0, sizeof *dev);
@@ -1229,7 +1229,7 @@ usbtest_probe (struct usb_interface *int
 	dev->intf = intf;
 
 	/* cacheline-aligned scratch for i/o */
-	if ((dev->buf = kmalloc (TBUF_SIZE, SLAB_KERNEL)) == 0) {
+	if ((dev->buf = kmalloc (TBUF_SIZE, GFP_KERNEL)) == 0) {
 		kfree (dev);
 		return -ENOMEM;
 	}
diff -urpN linux-2.5.61/drivers/usb/net/catc.c slab-2.5.61/drivers/usb/net/catc.c
--- linux-2.5.61/drivers/usb/net/catc.c	2003-02-14 15:51:44.000000000 -0800
+++ slab-2.5.61/drivers/usb/net/catc.c	2003-02-15 04:31:15.000000000 -0800
@@ -343,7 +343,7 @@ static void catc_irq_done(struct urb *ur
 		} 
 	}
 resubmit:
-	status = usb_submit_urb (urb, SLAB_ATOMIC);
+	status = usb_submit_urb (urb, GFP_ATOMIC);
 	if (status)
 		err ("can't resubmit intr, %s-%s, status %d",
 				catc->usbdev->bus->bus_name,
diff -urpN linux-2.5.61/drivers/usb/net/kaweth.c slab-2.5.61/drivers/usb/net/kaweth.c
--- linux-2.5.61/drivers/usb/net/kaweth.c	2003-02-14 15:52:09.000000000 -0800
+++ slab-2.5.61/drivers/usb/net/kaweth.c	2003-02-15 04:31:15.000000000 -0800
@@ -499,7 +499,7 @@ static void int_callback(struct urb *u, 
 		kaweth->linkstate = act_state;
 	}
 resubmit:
-	status = usb_submit_urb (u, SLAB_ATOMIC);
+	status = usb_submit_urb (u, GFP_ATOMIC);
 	if (status)
 		err ("can't resubmit intr, %s-%s, status %d",
 				kaweth->dev->bus->bus_name,
diff -urpN linux-2.5.61/drivers/usb/net/pegasus.c slab-2.5.61/drivers/usb/net/pegasus.c
--- linux-2.5.61/drivers/usb/net/pegasus.c	2003-02-14 15:52:46.000000000 -0800
+++ slab-2.5.61/drivers/usb/net/pegasus.c	2003-02-15 04:31:16.000000000 -0800
@@ -719,7 +719,7 @@ static void intr_callback(struct urb *ur
 		}
 	}
 
-	status = usb_submit_urb(urb, SLAB_ATOMIC);
+	status = usb_submit_urb(urb, GFP_ATOMIC);
 	if (status)
 		err("%s: can't resubmit interrupt urb, %d", net->name, status);
 }
diff -urpN linux-2.5.61/drivers/usb/net/rtl8150.c slab-2.5.61/drivers/usb/net/rtl8150.c
--- linux-2.5.61/drivers/usb/net/rtl8150.c	2003-02-14 15:51:54.000000000 -0800
+++ slab-2.5.61/drivers/usb/net/rtl8150.c	2003-02-15 04:31:15.000000000 -0800
@@ -475,7 +475,7 @@ void intr_callback(struct urb *urb, stru
 	/* FIXME if this doesn't do anything, don't submit the urb! */
 
 resubmit:
-	status = usb_submit_urb (urb, SLAB_ATOMIC);
+	status = usb_submit_urb (urb, GFP_ATOMIC);
 	if (status)
 		err ("can't resubmit intr, %s-%s/input0, status %d",
 				dev->udev->bus->bus_name,
diff -urpN linux-2.5.61/fs/adfs/super.c slab-2.5.61/fs/adfs/super.c
--- linux-2.5.61/fs/adfs/super.c	2003-02-14 15:51:05.000000000 -0800
+++ slab-2.5.61/fs/adfs/super.c	2003-02-15 04:30:48.000000000 -0800
@@ -210,7 +210,7 @@ static kmem_cache_t *adfs_inode_cachep;
 static struct inode *adfs_alloc_inode(struct super_block *sb)
 {
 	struct adfs_inode_info *ei;
-	ei = (struct adfs_inode_info *)kmem_cache_alloc(adfs_inode_cachep, SLAB_KERNEL);
+	ei = (struct adfs_inode_info *)kmem_cache_alloc(adfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/affs/super.c slab-2.5.61/fs/affs/super.c
--- linux-2.5.61/fs/affs/super.c	2003-02-14 15:52:04.000000000 -0800
+++ slab-2.5.61/fs/affs/super.c	2003-02-15 04:30:51.000000000 -0800
@@ -89,7 +89,7 @@ static kmem_cache_t * affs_inode_cachep;
 static struct inode *affs_alloc_inode(struct super_block *sb)
 {
 	struct affs_inode_info *ei;
-	ei = (struct affs_inode_info *)kmem_cache_alloc(affs_inode_cachep, SLAB_KERNEL);
+	ei = (struct affs_inode_info *)kmem_cache_alloc(affs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	ei->vfs_inode.i_version = 1;
diff -urpN linux-2.5.61/fs/afs/super.c slab-2.5.61/fs/afs/super.c
--- linux-2.5.61/fs/afs/super.c	2003-02-14 15:51:31.000000000 -0800
+++ slab-2.5.61/fs/afs/super.c	2003-02-15 04:30:47.000000000 -0800
@@ -484,7 +484,7 @@ static struct inode *afs_alloc_inode(str
 {
 	afs_vnode_t *vnode;
 
-	vnode = (afs_vnode_t *) kmem_cache_alloc(afs_inode_cachep,SLAB_KERNEL);
+	vnode = (afs_vnode_t *) kmem_cache_alloc(afs_inode_cachep,GFP_KERNEL);
 	if (!vnode)
 		return NULL;
 
diff -urpN linux-2.5.61/fs/befs/linuxvfs.c slab-2.5.61/fs/befs/linuxvfs.c
--- linux-2.5.61/fs/befs/linuxvfs.c	2003-02-14 15:51:33.000000000 -0800
+++ slab-2.5.61/fs/befs/linuxvfs.c	2003-02-15 04:30:49.000000000 -0800
@@ -282,7 +282,7 @@ befs_alloc_inode(struct super_block *sb)
 {
         struct befs_inode_info *bi;
         bi = (struct befs_inode_info *)kmem_cache_alloc(befs_inode_cachep,
-							SLAB_KERNEL);
+							GFP_KERNEL);
         if (!bi)
                 return NULL;
         return &bi->vfs_inode;
diff -urpN linux-2.5.61/fs/bfs/inode.c slab-2.5.61/fs/bfs/inode.c
--- linux-2.5.61/fs/bfs/inode.c	2003-02-14 15:51:31.000000000 -0800
+++ slab-2.5.61/fs/bfs/inode.c	2003-02-15 04:30:48.000000000 -0800
@@ -219,7 +219,7 @@ static kmem_cache_t * bfs_inode_cachep;
 static struct inode *bfs_alloc_inode(struct super_block *sb)
 {
 	struct bfs_inode_info *bi;
-	bi = kmem_cache_alloc(bfs_inode_cachep, SLAB_KERNEL);
+	bi = kmem_cache_alloc(bfs_inode_cachep, GFP_KERNEL);
 	if (!bi)
 		return NULL;
 	return &bi->vfs_inode;
diff -urpN linux-2.5.61/fs/block_dev.c slab-2.5.61/fs/block_dev.c
--- linux-2.5.61/fs/block_dev.c	2003-02-14 15:53:03.000000000 -0800
+++ slab-2.5.61/fs/block_dev.c	2003-02-15 04:30:53.000000000 -0800
@@ -223,7 +223,7 @@ static spinlock_t bdev_lock __cacheline_
 static kmem_cache_t * bdev_cachep;
 
 #define alloc_bdev() \
-	 ((struct block_device *) kmem_cache_alloc(bdev_cachep, SLAB_KERNEL))
+	 ((struct block_device *) kmem_cache_alloc(bdev_cachep, GFP_KERNEL))
 #define destroy_bdev(bdev) kmem_cache_free(bdev_cachep, (bdev))
 
 static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
diff -urpN linux-2.5.61/fs/char_dev.c slab-2.5.61/fs/char_dev.c
--- linux-2.5.61/fs/char_dev.c	2003-02-14 15:51:26.000000000 -0800
+++ slab-2.5.61/fs/char_dev.c	2003-02-15 04:30:51.000000000 -0800
@@ -35,7 +35,7 @@ static spinlock_t cdev_lock = SPIN_LOCK_
 static kmem_cache_t * cdev_cachep;
 
 #define alloc_cdev() \
-	 ((struct char_device *) kmem_cache_alloc(cdev_cachep, SLAB_KERNEL))
+	 ((struct char_device *) kmem_cache_alloc(cdev_cachep, GFP_KERNEL))
 #define destroy_cdev(cdev) kmem_cache_free(cdev_cachep, (cdev))
 
 static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
diff -urpN linux-2.5.61/fs/cifs/cifsfs.c slab-2.5.61/fs/cifs/cifsfs.c
--- linux-2.5.61/fs/cifs/cifsfs.c	2003-02-14 15:51:47.000000000 -0800
+++ slab-2.5.61/fs/cifs/cifsfs.c	2003-02-15 04:30:47.000000000 -0800
@@ -174,7 +174,7 @@ cifs_alloc_inode(struct super_block *sb)
 	struct cifsInodeInfo *cifs_inode;
 	cifs_inode =
 	    (struct cifsInodeInfo *) kmem_cache_alloc(cifs_inode_cachep,
-						      SLAB_KERNEL);
+						      GFP_KERNEL);
 	if (!cifs_inode)
 		return NULL;
 	cifs_inode->cifsAttrs = 0x20;	/* default */
diff -urpN linux-2.5.61/fs/cifs/misc.c slab-2.5.61/fs/cifs/misc.c
--- linux-2.5.61/fs/cifs/misc.c	2003-02-14 15:52:40.000000000 -0800
+++ slab-2.5.61/fs/cifs/misc.c	2003-02-15 04:30:48.000000000 -0800
@@ -153,7 +153,7 @@ buf_get(void)
    but it may be more efficient to always alloc same size 
    albeit slightly larger */
 	ret_buf =
-	    (struct smb_hdr *) kmem_cache_alloc(cifs_req_cachep, SLAB_KERNEL);
+	    (struct smb_hdr *) kmem_cache_alloc(cifs_req_cachep, GFP_KERNEL);
 
 	/* clear the first few header bytes */
 	if (ret_buf) {
diff -urpN linux-2.5.61/fs/cifs/transport.c slab-2.5.61/fs/cifs/transport.c
--- linux-2.5.61/fs/cifs/transport.c	2003-02-14 15:51:25.000000000 -0800
+++ slab-2.5.61/fs/cifs/transport.c	2003-02-15 04:30:47.000000000 -0800
@@ -45,7 +45,7 @@ AllocMidQEntry(struct smb_hdr *smb_buffe
 	}
 	temp = kmalloc(sizeof (struct mid_q_entry), GFP_KERNEL);
 	temp = (struct mid_q_entry *) kmem_cache_alloc(cifs_mid_cachep,
-						       SLAB_KERNEL);
+						       GFP_KERNEL);
 	if (temp == NULL)
 		return temp;
 	else {
diff -urpN linux-2.5.61/fs/coda/inode.c slab-2.5.61/fs/coda/inode.c
--- linux-2.5.61/fs/coda/inode.c	2003-02-14 15:51:45.000000000 -0800
+++ slab-2.5.61/fs/coda/inode.c	2003-02-15 04:30:48.000000000 -0800
@@ -41,7 +41,7 @@ static kmem_cache_t * coda_inode_cachep;
 static struct inode *coda_alloc_inode(struct super_block *sb)
 {
 	struct coda_inode_info *ei;
-	ei = (struct coda_inode_info *)kmem_cache_alloc(coda_inode_cachep, SLAB_KERNEL);
+	ei = (struct coda_inode_info *)kmem_cache_alloc(coda_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	memset(&ei->c_fid, 0, sizeof(struct ViceFid));
diff -urpN linux-2.5.61/fs/devfs/base.c slab-2.5.61/fs/devfs/base.c
--- linux-2.5.61/fs/devfs/base.c	2003-02-14 15:51:19.000000000 -0800
+++ slab-2.5.61/fs/devfs/base.c	2003-02-15 04:31:18.000000000 -0800
@@ -577,7 +577,7 @@
 	       Added process group check for devfsd privileges.
   v1.4
     20011204   Richard Gooch <rgooch@atnf.csiro.au>
-	       Use SLAB_ATOMIC in <devfsd_notify_de> from <devfs_d_delete>.
+	       Use GFP_ATOMIC in <devfsd_notify_de> from <devfs_d_delete>.
   v1.5
     20011211   Richard Gooch <rgooch@atnf.csiro.au>
 	       Return old entry in <devfs_mk_dir> for 2.4.x kernels.
@@ -1407,7 +1407,7 @@ static int devfsd_notify_de (struct devf
 
     if ( !( fs_info->devfsd_event_mask & (1 << type) ) ) return (FALSE);
     if ( ( entry = kmem_cache_alloc (devfsd_buf_cache,
-				     atomic ? SLAB_ATOMIC : SLAB_KERNEL) )
+				     atomic ? GFP_ATOMIC : GFP_KERNEL) )
 	 == NULL )
     {
 	atomic_inc (&fs_info->devfsd_overrun_count);
diff -urpN linux-2.5.61/fs/dnotify.c slab-2.5.61/fs/dnotify.c
--- linux-2.5.61/fs/dnotify.c	2003-02-14 15:51:26.000000000 -0800
+++ slab-2.5.61/fs/dnotify.c	2003-02-15 04:30:51.000000000 -0800
@@ -79,7 +79,7 @@ int fcntl_dirnotify(int fd, struct file 
 	inode = filp->f_dentry->d_inode;
 	if (!S_ISDIR(inode->i_mode))
 		return -ENOTDIR;
-	dn = kmem_cache_alloc(dn_cache, SLAB_KERNEL);
+	dn = kmem_cache_alloc(dn_cache, GFP_KERNEL);
 	if (dn == NULL)
 		return -ENOMEM;
 	write_lock(&dn_lock);
diff -urpN linux-2.5.61/fs/dquot.c slab-2.5.61/fs/dquot.c
--- linux-2.5.61/fs/dquot.c	2003-02-14 15:52:04.000000000 -0800
+++ slab-2.5.61/fs/dquot.c	2003-02-15 04:30:52.000000000 -0800
@@ -474,7 +474,7 @@ static struct dquot *get_empty_dquot(str
 {
 	struct dquot *dquot;
 
-	dquot = kmem_cache_alloc(dquot_cachep, SLAB_KERNEL);
+	dquot = kmem_cache_alloc(dquot_cachep, GFP_KERNEL);
 	if(!dquot)
 		return NODQUOT;
 
diff -urpN linux-2.5.61/fs/efs/super.c slab-2.5.61/fs/efs/super.c
--- linux-2.5.61/fs/efs/super.c	2003-02-14 15:52:27.000000000 -0800
+++ slab-2.5.61/fs/efs/super.c	2003-02-15 04:30:51.000000000 -0800
@@ -34,7 +34,7 @@ static kmem_cache_t * efs_inode_cachep;
 static struct inode *efs_alloc_inode(struct super_block *sb)
 {
 	struct efs_inode_info *ei;
-	ei = (struct efs_inode_info *)kmem_cache_alloc(efs_inode_cachep, SLAB_KERNEL);
+	ei = (struct efs_inode_info *)kmem_cache_alloc(efs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/eventpoll.c slab-2.5.61/fs/eventpoll.c
--- linux-2.5.61/fs/eventpoll.c	2003-02-14 15:51:31.000000000 -0800
+++ slab-2.5.61/fs/eventpoll.c	2003-02-15 04:30:52.000000000 -0800
@@ -81,13 +81,13 @@
 				     ((1 << (hbits)) % EP_HENTRY_X_PAGE ? 1: 0)))
 
 /* Macro to allocate a "struct epitem" from the slab cache */
-#define EPI_MEM_ALLOC()	(struct epitem *) kmem_cache_alloc(epi_cache, SLAB_KERNEL)
+#define EPI_MEM_ALLOC()	(struct epitem *) kmem_cache_alloc(epi_cache, GFP_KERNEL)
 
 /* Macro to free a "struct epitem" to the slab cache */
 #define EPI_MEM_FREE(p) kmem_cache_free(epi_cache, p)
 
 /* Macro to allocate a "struct eppoll_entry" from the slab cache */
-#define PWQ_MEM_ALLOC()	(struct eppoll_entry *) kmem_cache_alloc(pwq_cache, SLAB_KERNEL)
+#define PWQ_MEM_ALLOC()	(struct eppoll_entry *) kmem_cache_alloc(pwq_cache, GFP_KERNEL)
 
 /* Macro to free a "struct eppoll_entry" to the slab cache */
 #define PWQ_MEM_FREE(p) kmem_cache_free(pwq_cache, p)
diff -urpN linux-2.5.61/fs/exec.c slab-2.5.61/fs/exec.c
--- linux-2.5.61/fs/exec.c	2003-02-14 15:51:30.000000000 -0800
+++ slab-2.5.61/fs/exec.c	2003-02-15 04:30:52.000000000 -0800
@@ -388,7 +388,7 @@ int setup_arg_pages(struct linux_binprm 
 		bprm->loader += stack_base;
 	bprm->exec += stack_base;
 
-	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	mpnt = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 	if (!mpnt)
 		return -ENOMEM;
 
diff -urpN linux-2.5.61/fs/ext2/super.c slab-2.5.61/fs/ext2/super.c
--- linux-2.5.61/fs/ext2/super.c	2003-02-14 15:52:03.000000000 -0800
+++ slab-2.5.61/fs/ext2/super.c	2003-02-15 04:30:50.000000000 -0800
@@ -154,7 +154,7 @@ static kmem_cache_t * ext2_inode_cachep;
 static struct inode *ext2_alloc_inode(struct super_block *sb)
 {
 	struct ext2_inode_info *ei;
-	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL);
+	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
diff -urpN linux-2.5.61/fs/fat/inode.c slab-2.5.61/fs/fat/inode.c
--- linux-2.5.61/fs/fat/inode.c	2003-02-14 15:51:42.000000000 -0800
+++ slab-2.5.61/fs/fat/inode.c	2003-02-15 04:30:49.000000000 -0800
@@ -672,7 +672,7 @@ static kmem_cache_t *fat_inode_cachep;
 static struct inode *fat_alloc_inode(struct super_block *sb)
 {
 	struct msdos_inode_info *ei;
-	ei = (struct msdos_inode_info *)kmem_cache_alloc(fat_inode_cachep, SLAB_KERNEL);
+	ei = (struct msdos_inode_info *)kmem_cache_alloc(fat_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/fcntl.c slab-2.5.61/fs/fcntl.c
--- linux-2.5.61/fs/fcntl.c	2003-02-14 15:51:13.000000000 -0800
+++ slab-2.5.61/fs/fcntl.c	2003-02-15 04:30:51.000000000 -0800
@@ -550,7 +550,7 @@ int fasync_helper(int fd, struct file * 
 	int result = 0;
 
 	if (on) {
-		new = kmem_cache_alloc(fasync_cache, SLAB_KERNEL);
+		new = kmem_cache_alloc(fasync_cache, GFP_KERNEL);
 		if (!new)
 			return -ENOMEM;
 	}
diff -urpN linux-2.5.61/fs/file_table.c slab-2.5.61/fs/file_table.c
--- linux-2.5.61/fs/file_table.c	2003-02-14 15:51:09.000000000 -0800
+++ slab-2.5.61/fs/file_table.c	2003-02-15 04:30:50.000000000 -0800
@@ -74,7 +74,7 @@ struct file * get_empty_filp(void)
 	 */
 	if (files_stat.nr_files < files_stat.max_files) {
 		file_list_unlock();
-		f = kmem_cache_alloc(filp_cachep, SLAB_KERNEL);
+		f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
 		file_list_lock();
 		if (f) {
 			files_stat.nr_files++;
diff -urpN linux-2.5.61/fs/freevxfs/vxfs_fshead.c slab-2.5.61/fs/freevxfs/vxfs_fshead.c
--- linux-2.5.61/fs/freevxfs/vxfs_fshead.c	2003-02-14 15:51:09.000000000 -0800
+++ slab-2.5.61/fs/freevxfs/vxfs_fshead.c	2003-02-15 04:30:49.000000000 -0800
@@ -83,7 +83,7 @@ vxfs_getfsh(struct inode *ip, int which)
 	if (buffer_mapped(bp)) {
 		struct vxfs_fsh		*fhp;
 
-		if (!(fhp = kmalloc(sizeof(*fhp), SLAB_KERNEL)))
+		if (!(fhp = kmalloc(sizeof(*fhp), GFP_KERNEL)))
 			return NULL;
 		memcpy(fhp, bp->b_data, sizeof(*fhp));
 
diff -urpN linux-2.5.61/fs/freevxfs/vxfs_inode.c slab-2.5.61/fs/freevxfs/vxfs_inode.c
--- linux-2.5.61/fs/freevxfs/vxfs_inode.c	2003-02-14 15:51:20.000000000 -0800
+++ slab-2.5.61/fs/freevxfs/vxfs_inode.c	2003-02-15 04:30:49.000000000 -0800
@@ -114,7 +114,7 @@ vxfs_blkiget(struct super_block *sbp, u_
 		struct vxfs_inode_info	*vip;
 		struct vxfs_dinode	*dip;
 
-		if (!(vip = kmem_cache_alloc(vxfs_inode_cachep, SLAB_KERNEL)))
+		if (!(vip = kmem_cache_alloc(vxfs_inode_cachep, GFP_KERNEL)))
 			goto fail;
 		dip = (struct vxfs_dinode *)(bp->b_data + offset);
 		memcpy(vip, dip, sizeof(*vip));
@@ -156,7 +156,7 @@ __vxfs_iget(ino_t ino, struct inode *ili
 		struct vxfs_dinode	*dip;
 		caddr_t			kaddr = (char *)page_address(pp);
 
-		if (!(vip = kmem_cache_alloc(vxfs_inode_cachep, SLAB_KERNEL)))
+		if (!(vip = kmem_cache_alloc(vxfs_inode_cachep, GFP_KERNEL)))
 			goto fail;
 		dip = (struct vxfs_dinode *)(kaddr + offset);
 		memcpy(vip, dip, sizeof(*vip));
diff -urpN linux-2.5.61/fs/hfs/super.c slab-2.5.61/fs/hfs/super.c
--- linux-2.5.61/fs/hfs/super.c	2003-02-14 15:51:28.000000000 -0800
+++ slab-2.5.61/fs/hfs/super.c	2003-02-15 04:30:48.000000000 -0800
@@ -48,7 +48,7 @@ static kmem_cache_t * hfs_inode_cachep;
 static struct inode *hfs_alloc_inode(struct super_block *sb)
 {
 	struct hfs_inode_info *ei;
-	ei = (struct hfs_inode_info *)kmem_cache_alloc(hfs_inode_cachep, SLAB_KERNEL);
+	ei = (struct hfs_inode_info *)kmem_cache_alloc(hfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/hpfs/super.c slab-2.5.61/fs/hpfs/super.c
--- linux-2.5.61/fs/hpfs/super.c	2003-02-14 15:51:50.000000000 -0800
+++ slab-2.5.61/fs/hpfs/super.c	2003-02-15 04:30:49.000000000 -0800
@@ -164,7 +164,7 @@ static kmem_cache_t * hpfs_inode_cachep;
 static struct inode *hpfs_alloc_inode(struct super_block *sb)
 {
 	struct hpfs_inode_info *ei;
-	ei = (struct hpfs_inode_info *)kmem_cache_alloc(hpfs_inode_cachep, SLAB_KERNEL);
+	ei = (struct hpfs_inode_info *)kmem_cache_alloc(hpfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	ei->vfs_inode.i_version = 1;
diff -urpN linux-2.5.61/fs/inode.c slab-2.5.61/fs/inode.c
--- linux-2.5.61/fs/inode.c	2003-02-14 15:52:59.000000000 -0800
+++ slab-2.5.61/fs/inode.c	2003-02-15 04:30:53.000000000 -0800
@@ -97,7 +97,7 @@ static struct inode *alloc_inode(struct 
 	if (sb->s_op->alloc_inode)
 		inode = sb->s_op->alloc_inode(sb);
 	else
-		inode = (struct inode *) kmem_cache_alloc(inode_cachep, SLAB_KERNEL);
+		inode = (struct inode *) kmem_cache_alloc(inode_cachep, GFP_KERNEL);
 
 	if (inode) {
 		struct address_space * const mapping = &inode->i_data;
diff -urpN linux-2.5.61/fs/intermezzo/dcache.c slab-2.5.61/fs/intermezzo/dcache.c
--- linux-2.5.61/fs/intermezzo/dcache.c	2003-02-14 15:52:31.000000000 -0800
+++ slab-2.5.61/fs/intermezzo/dcache.c	2003-02-15 04:30:48.000000000 -0800
@@ -234,7 +234,7 @@ inline struct presto_dentry_data *izo_al
 {
         struct presto_dentry_data *dd;
 
-        dd = kmem_cache_alloc(presto_dentry_slab, SLAB_KERNEL);
+        dd = kmem_cache_alloc(presto_dentry_slab, GFP_KERNEL);
         if (dd == NULL) {
                 CERROR("IZO: out of memory trying to allocate presto_dentry_data\n");
                 return NULL;
diff -urpN linux-2.5.61/fs/isofs/inode.c slab-2.5.61/fs/isofs/inode.c
--- linux-2.5.61/fs/isofs/inode.c	2003-02-14 15:52:40.000000000 -0800
+++ slab-2.5.61/fs/isofs/inode.c	2003-02-15 04:30:51.000000000 -0800
@@ -81,7 +81,7 @@ static kmem_cache_t *isofs_inode_cachep;
 static struct inode *isofs_alloc_inode(struct super_block *sb)
 {
 	struct iso_inode_info *ei;
-	ei = (struct iso_inode_info *)kmem_cache_alloc(isofs_inode_cachep, SLAB_KERNEL);
+	ei = (struct iso_inode_info *)kmem_cache_alloc(isofs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/jffs/jffs_fm.c slab-2.5.61/fs/jffs/jffs_fm.c
--- linux-2.5.61/fs/jffs/jffs_fm.c	2003-02-14 15:51:46.000000000 -0800
+++ slab-2.5.61/fs/jffs/jffs_fm.c	2003-02-15 04:30:52.000000000 -0800
@@ -706,7 +706,7 @@ struct jffs_fm *jffs_alloc_fm(void)
 {
 	struct jffs_fm *fm;
 
-	fm = kmem_cache_alloc(fm_cache,GFP_KERNEL);
+	fm = kmem_cache_alloc(fm_cache, GFP_KERNEL);
 	DJM(if (fm) no_jffs_fm++;);
 	
 	return fm;
@@ -724,7 +724,7 @@ struct jffs_node *jffs_alloc_node(void)
 {
 	struct jffs_node *n;
 
-	n = (struct jffs_node *)kmem_cache_alloc(node_cache,GFP_KERNEL);
+	n = (struct jffs_node *)kmem_cache_alloc(node_cache, GFP_KERNEL);
 	if(n != NULL)
 		no_jffs_node++;
 	return n;
diff -urpN linux-2.5.61/fs/jffs2/super.c slab-2.5.61/fs/jffs2/super.c
--- linux-2.5.61/fs/jffs2/super.c	2003-02-14 15:51:26.000000000 -0800
+++ slab-2.5.61/fs/jffs2/super.c	2003-02-15 04:30:48.000000000 -0800
@@ -36,7 +36,7 @@ static kmem_cache_t *jffs2_inode_cachep;
 static struct inode *jffs2_alloc_inode(struct super_block *sb)
 {
 	struct jffs2_inode_info *ei;
-	ei = (struct jffs2_inode_info *)kmem_cache_alloc(jffs2_inode_cachep, SLAB_KERNEL);
+	ei = (struct jffs2_inode_info *)kmem_cache_alloc(jffs2_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/locks.c slab-2.5.61/fs/locks.c
--- linux-2.5.61/fs/locks.c	2003-02-14 15:52:39.000000000 -0800
+++ slab-2.5.61/fs/locks.c	2003-02-15 04:30:52.000000000 -0800
@@ -148,7 +148,7 @@ static struct file_lock *locks_alloc_loc
 	struct file_lock *fl;
 	if (account && current->locks >= current->rlim[RLIMIT_LOCKS].rlim_cur)
 		return NULL;
-	fl = kmem_cache_alloc(filelock_cache, SLAB_KERNEL);
+	fl = kmem_cache_alloc(filelock_cache, GFP_KERNEL);
 	if (fl)
 		current->locks++;
 	return fl;
diff -urpN linux-2.5.61/fs/minix/inode.c slab-2.5.61/fs/minix/inode.c
--- linux-2.5.61/fs/minix/inode.c	2003-02-14 15:51:46.000000000 -0800
+++ slab-2.5.61/fs/minix/inode.c	2003-02-15 04:30:51.000000000 -0800
@@ -55,7 +55,7 @@ static kmem_cache_t * minix_inode_cachep
 static struct inode *minix_alloc_inode(struct super_block *sb)
 {
 	struct minix_inode_info *ei;
-	ei = (struct minix_inode_info *)kmem_cache_alloc(minix_inode_cachep, SLAB_KERNEL);
+	ei = (struct minix_inode_info *)kmem_cache_alloc(minix_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/ncpfs/inode.c slab-2.5.61/fs/ncpfs/inode.c
--- linux-2.5.61/fs/ncpfs/inode.c	2003-02-14 15:51:45.000000000 -0800
+++ slab-2.5.61/fs/ncpfs/inode.c	2003-02-15 04:30:50.000000000 -0800
@@ -46,7 +46,7 @@ static kmem_cache_t * ncp_inode_cachep;
 static struct inode *ncp_alloc_inode(struct super_block *sb)
 {
 	struct ncp_inode_info *ei;
-	ei = (struct ncp_inode_info *)kmem_cache_alloc(ncp_inode_cachep, SLAB_KERNEL);
+	ei = (struct ncp_inode_info *)kmem_cache_alloc(ncp_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/nfs/inode.c slab-2.5.61/fs/nfs/inode.c
--- linux-2.5.61/fs/nfs/inode.c	2003-02-14 15:52:26.000000000 -0800
+++ slab-2.5.61/fs/nfs/inode.c	2003-02-15 04:30:47.000000000 -0800
@@ -1520,7 +1520,7 @@ static kmem_cache_t * nfs_inode_cachep;
 static struct inode *nfs_alloc_inode(struct super_block *sb)
 {
 	struct nfs_inode *nfsi;
-	nfsi = (struct nfs_inode *)kmem_cache_alloc(nfs_inode_cachep, SLAB_KERNEL);
+	nfsi = (struct nfs_inode *)kmem_cache_alloc(nfs_inode_cachep, GFP_KERNEL);
 	if (!nfsi)
 		return NULL;
 	nfsi->flags = 0;
diff -urpN linux-2.5.61/fs/proc/inode.c slab-2.5.61/fs/proc/inode.c
--- linux-2.5.61/fs/proc/inode.c	2003-02-14 15:52:37.000000000 -0800
+++ slab-2.5.61/fs/proc/inode.c	2003-02-15 04:30:50.000000000 -0800
@@ -92,7 +92,7 @@ static struct inode *proc_alloc_inode(st
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	ei = (struct proc_inode *)kmem_cache_alloc(proc_inode_cachep, SLAB_KERNEL);
+	ei = (struct proc_inode *)kmem_cache_alloc(proc_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	ei->task = NULL;
diff -urpN linux-2.5.61/fs/qnx4/inode.c slab-2.5.61/fs/qnx4/inode.c
--- linux-2.5.61/fs/qnx4/inode.c	2003-02-14 15:52:34.000000000 -0800
+++ slab-2.5.61/fs/qnx4/inode.c	2003-02-15 04:30:52.000000000 -0800
@@ -515,7 +515,7 @@ static kmem_cache_t *qnx4_inode_cachep;
 static struct inode *qnx4_alloc_inode(struct super_block *sb)
 {
 	struct qnx4_inode_info *ei;
-	ei = kmem_cache_alloc(qnx4_inode_cachep, SLAB_KERNEL);
+	ei = kmem_cache_alloc(qnx4_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/reiserfs/super.c slab-2.5.61/fs/reiserfs/super.c
--- linux-2.5.61/fs/reiserfs/super.c	2003-02-14 15:51:42.000000000 -0800
+++ slab-2.5.61/fs/reiserfs/super.c	2003-02-15 04:30:49.000000000 -0800
@@ -414,7 +414,7 @@ static kmem_cache_t * reiserfs_inode_cac
 static struct inode *reiserfs_alloc_inode(struct super_block *sb)
 {
 	struct reiserfs_inode_info *ei;
-	ei = (struct reiserfs_inode_info *)kmem_cache_alloc(reiserfs_inode_cachep, SLAB_KERNEL);
+	ei = (struct reiserfs_inode_info *)kmem_cache_alloc(reiserfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/romfs/inode.c slab-2.5.61/fs/romfs/inode.c
--- linux-2.5.61/fs/romfs/inode.c	2003-02-14 15:52:03.000000000 -0800
+++ slab-2.5.61/fs/romfs/inode.c	2003-02-15 04:30:51.000000000 -0800
@@ -554,7 +554,7 @@ static kmem_cache_t * romfs_inode_cachep
 static struct inode *romfs_alloc_inode(struct super_block *sb)
 {
 	struct romfs_inode_info *ei;
-	ei = (struct romfs_inode_info *)kmem_cache_alloc(romfs_inode_cachep, SLAB_KERNEL);
+	ei = (struct romfs_inode_info *)kmem_cache_alloc(romfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/smbfs/inode.c slab-2.5.61/fs/smbfs/inode.c
--- linux-2.5.61/fs/smbfs/inode.c	2003-02-14 15:51:17.000000000 -0800
+++ slab-2.5.61/fs/smbfs/inode.c	2003-02-15 04:30:50.000000000 -0800
@@ -55,7 +55,7 @@ static kmem_cache_t *smb_inode_cachep;
 static struct inode *smb_alloc_inode(struct super_block *sb)
 {
 	struct smb_inode_info *ei;
-	ei = (struct smb_inode_info *)kmem_cache_alloc(smb_inode_cachep, SLAB_KERNEL);
+	ei = (struct smb_inode_info *)kmem_cache_alloc(smb_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/smbfs/request.c slab-2.5.61/fs/smbfs/request.c
--- linux-2.5.61/fs/smbfs/request.c	2003-02-14 15:53:02.000000000 -0800
+++ slab-2.5.61/fs/smbfs/request.c	2003-02-15 04:30:50.000000000 -0800
@@ -60,7 +60,7 @@ static struct smb_request *smb_do_alloc_
 	struct smb_request *req;
 	unsigned char *buf = NULL;
 
-	req = kmem_cache_alloc(req_cachep, SLAB_KERNEL);
+	req = kmem_cache_alloc(req_cachep, GFP_KERNEL);
 	VERBOSE("allocating request: %p\n", req);
 	if (!req)
 		goto out;
diff -urpN linux-2.5.61/fs/sysv/inode.c slab-2.5.61/fs/sysv/inode.c
--- linux-2.5.61/fs/sysv/inode.c	2003-02-14 15:51:06.000000000 -0800
+++ slab-2.5.61/fs/sysv/inode.c	2003-02-15 04:30:49.000000000 -0800
@@ -293,7 +293,7 @@ static struct inode *sysv_alloc_inode(st
 {
 	struct sysv_inode_info *si;
 
-	si = kmem_cache_alloc(sysv_inode_cachep, SLAB_KERNEL);
+	si = kmem_cache_alloc(sysv_inode_cachep, GFP_KERNEL);
 	if (!si)
 		return NULL;
 	return &si->vfs_inode;
diff -urpN linux-2.5.61/fs/udf/super.c slab-2.5.61/fs/udf/super.c
--- linux-2.5.61/fs/udf/super.c	2003-02-14 15:52:03.000000000 -0800
+++ slab-2.5.61/fs/udf/super.c	2003-02-15 04:30:48.000000000 -0800
@@ -117,7 +117,7 @@ static kmem_cache_t * udf_inode_cachep;
 static struct inode *udf_alloc_inode(struct super_block *sb)
 {
 	struct udf_inode_info *ei;
-	ei = (struct udf_inode_info *)kmem_cache_alloc(udf_inode_cachep, SLAB_KERNEL);
+	ei = (struct udf_inode_info *)kmem_cache_alloc(udf_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -urpN linux-2.5.61/fs/ufs/super.c slab-2.5.61/fs/ufs/super.c
--- linux-2.5.61/fs/ufs/super.c	2003-02-14 15:51:04.000000000 -0800
+++ slab-2.5.61/fs/ufs/super.c	2003-02-15 04:30:47.000000000 -0800
@@ -1004,7 +1004,7 @@ static kmem_cache_t * ufs_inode_cachep;
 static struct inode *ufs_alloc_inode(struct super_block *sb)
 {
 	struct ufs_inode_info *ei;
-	ei = (struct ufs_inode_info *)kmem_cache_alloc(ufs_inode_cachep, SLAB_KERNEL);
+	ei = (struct ufs_inode_info *)kmem_cache_alloc(ufs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	ei->vfs_inode.i_version = 1;
diff -urpN linux-2.5.61/include/linux/fs.h slab-2.5.61/include/linux/fs.h
--- linux-2.5.61/include/linux/fs.h	2003-02-14 15:51:22.000000000 -0800
+++ slab-2.5.61/include/linux/fs.h	2003-02-15 04:30:47.000000000 -0800
@@ -1026,7 +1026,7 @@ extern char * getname(const char *);
 /* fs/dcache.c */
 extern void vfs_caches_init(unsigned long);
 
-#define __getname()	kmem_cache_alloc(names_cachep, SLAB_KERNEL)
+#define __getname()	kmem_cache_alloc(names_cachep, GFP_KERNEL)
 #define putname(name)	kmem_cache_free(names_cachep, (void *)(name))
 
 enum {BDEV_FILE, BDEV_SWAP, BDEV_FS, BDEV_RAW};
diff -urpN linux-2.5.61/include/linux/slab.h slab-2.5.61/include/linux/slab.h
--- linux-2.5.61/include/linux/slab.h	2003-02-14 15:52:59.000000000 -0800
+++ slab-2.5.61/include/linux/slab.h	2003-02-15 04:32:05.000000000 -0800
@@ -17,9 +17,7 @@ typedef struct kmem_cache_s kmem_cache_t
 /* flags for kmem_cache_alloc() */
 #define	SLAB_NOFS		GFP_NOFS
 #define	SLAB_NOIO		GFP_NOIO
-#define	SLAB_ATOMIC		GFP_ATOMIC
 #define	SLAB_USER		GFP_USER
-#define	SLAB_KERNEL		GFP_KERNEL
 #define	SLAB_DMA		GFP_DMA
 
 #define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS|__GFP_COLD|__GFP_NOWARN)
diff -urpN linux-2.5.61/include/net/tcp.h slab-2.5.61/include/net/tcp.h
--- linux-2.5.61/include/net/tcp.h	2003-02-14 15:51:16.000000000 -0800
+++ slab-2.5.61/include/net/tcp.h	2003-02-15 04:31:18.000000000 -0800
@@ -539,7 +539,7 @@ struct open_request {
 /* SLAB cache for open requests. */
 extern kmem_cache_t *tcp_openreq_cachep;
 
-#define tcp_openreq_alloc()		kmem_cache_alloc(tcp_openreq_cachep, SLAB_ATOMIC)
+#define tcp_openreq_alloc()		kmem_cache_alloc(tcp_openreq_cachep, GFP_ATOMIC)
 #define tcp_openreq_fastfree(req)	kmem_cache_free(tcp_openreq_cachep, req)
 
 static inline void tcp_openreq_free(struct open_request *req)
diff -urpN linux-2.5.61/kernel/fork.c slab-2.5.61/kernel/fork.c
--- linux-2.5.61/kernel/fork.c	2003-02-14 15:51:12.000000000 -0800
+++ slab-2.5.61/kernel/fork.c	2003-02-15 04:30:54.000000000 -0800
@@ -261,7 +261,7 @@ static inline int dup_mmap(struct mm_str
 				goto fail_nomem;
 			charge += len;
 		}
-		tmp = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+		tmp = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 		if (!tmp)
 			goto fail_nomem;
 		*tmp = *mpnt;
@@ -333,7 +333,7 @@ static inline void mm_free_pgd(struct mm
 spinlock_t mmlist_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 int mmlist_nr;
 
-#define allocate_mm()	(kmem_cache_alloc(mm_cachep, SLAB_KERNEL))
+#define allocate_mm()	(kmem_cache_alloc(mm_cachep, GFP_KERNEL))
 #define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
 
 #include <linux/init_task.h>
@@ -576,7 +576,7 @@ static int copy_files(unsigned long clon
 
 	tsk->files = NULL;
 	error = -ENOMEM;
-	newf = kmem_cache_alloc(files_cachep, SLAB_KERNEL);
+	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
 	if (!newf) 
 		goto out;
 
diff -urpN linux-2.5.61/kernel/user.c slab-2.5.61/kernel/user.c
--- linux-2.5.61/kernel/user.c	2003-02-14 15:51:29.000000000 -0800
+++ slab-2.5.61/kernel/user.c	2003-02-15 04:30:54.000000000 -0800
@@ -90,7 +90,7 @@ struct user_struct * alloc_uid(uid_t uid
 	if (!up) {
 		struct user_struct *new;
 
-		new = kmem_cache_alloc(uid_cachep, SLAB_KERNEL);
+		new = kmem_cache_alloc(uid_cachep, GFP_KERNEL);
 		if (!new)
 			return NULL;
 		new->uid = uid;
diff -urpN linux-2.5.61/mm/mmap.c slab-2.5.61/mm/mmap.c
--- linux-2.5.61/mm/mmap.c	2003-02-14 15:51:59.000000000 -0800
+++ slab-2.5.61/mm/mmap.c	2003-02-15 04:30:55.000000000 -0800
@@ -643,7 +643,7 @@ munmap_back:
 	 * specific mapper. the address has already been validated, but
 	 * not unmapped, but the maps are removed from the list.
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 	error = -ENOMEM;
 	if (!vma)
 		goto unacct_error;
@@ -1179,7 +1179,7 @@ int split_vma(struct mm_struct * mm, str
 	if (mm->map_count >= MAX_MAP_COUNT)
 		return -ENOMEM;
 
-	new = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
@@ -1346,7 +1346,7 @@ unsigned long do_brk(unsigned long addr,
 	/*
 	 * create a vma struct for an anonymous mapping
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 	if (!vma) {
 		vm_unacct_memory(len >> PAGE_SHIFT);
 		return -ENOMEM;
diff -urpN linux-2.5.61/mm/mremap.c slab-2.5.61/mm/mremap.c
--- linux-2.5.61/mm/mremap.c	2003-02-14 15:51:47.000000000 -0800
+++ slab-2.5.61/mm/mremap.c	2003-02-15 04:30:55.000000000 -0800
@@ -237,7 +237,7 @@ static unsigned long move_vma(struct vm_
 
 	allocated_vma = 0;
 	if (!new_vma) {
-		new_vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+		new_vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 		if (!new_vma)
 			goto out;
 		allocated_vma = 1;
diff -urpN linux-2.5.61/mm/shmem.c slab-2.5.61/mm/shmem.c
--- linux-2.5.61/mm/shmem.c	2003-02-14 15:51:33.000000000 -0800
+++ slab-2.5.61/mm/shmem.c	2003-02-15 04:30:55.000000000 -0800
@@ -1760,7 +1760,7 @@ static kmem_cache_t *shmem_inode_cachep;
 static struct inode *shmem_alloc_inode(struct super_block *sb)
 {
 	struct shmem_inode_info *p;
-	p = (struct shmem_inode_info *)kmem_cache_alloc(shmem_inode_cachep, SLAB_KERNEL);
+	p = (struct shmem_inode_info *)kmem_cache_alloc(shmem_inode_cachep, GFP_KERNEL);
 	if (!p)
 		return NULL;
 	return &p->vfs_inode;
diff -urpN linux-2.5.61/mm/slab.c slab-2.5.61/mm/slab.c
--- linux-2.5.61/mm/slab.c	2003-02-14 15:52:26.000000000 -0800
+++ slab-2.5.61/mm/slab.c	2003-02-15 04:30:55.000000000 -0800
@@ -904,7 +904,7 @@ kmem_cache_create (const char *name, siz
 		BUG();
 
 	/* Get cache's description obj. */
-	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
+	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, GFP_KERNEL);
 	if (!cachep)
 		goto opps;
 	memset(cachep, 0, sizeof(kmem_cache_t));
diff -urpN linux-2.5.61/net/core/dst.c slab-2.5.61/net/core/dst.c
--- linux-2.5.61/net/core/dst.c	2003-02-14 15:51:56.000000000 -0800
+++ slab-2.5.61/net/core/dst.c	2003-02-15 04:31:19.000000000 -0800
@@ -119,7 +119,7 @@ void * dst_alloc(struct dst_ops * ops)
 		if (ops->gc())
 			return NULL;
 	}
-	dst = kmem_cache_alloc(ops->kmem_cachep, SLAB_ATOMIC);
+	dst = kmem_cache_alloc(ops->kmem_cachep, GFP_ATOMIC);
 	if (!dst)
 		return NULL;
 	memset(dst, 0, ops->entry_size);
diff -urpN linux-2.5.61/net/core/neighbour.c slab-2.5.61/net/core/neighbour.c
--- linux-2.5.61/net/core/neighbour.c	2003-02-14 15:51:09.000000000 -0800
+++ slab-2.5.61/net/core/neighbour.c	2003-02-15 04:31:19.000000000 -0800
@@ -232,7 +232,7 @@ static struct neighbour *neigh_alloc(str
 			goto out;
 	}
 
-	n = kmem_cache_alloc(tbl->kmem_cachep, SLAB_ATOMIC);
+	n = kmem_cache_alloc(tbl->kmem_cachep, GFP_ATOMIC);
 	if (!n)
 		goto out;
 
diff -urpN linux-2.5.61/net/decnet/dn_table.c slab-2.5.61/net/decnet/dn_table.c
--- linux-2.5.61/net/decnet/dn_table.c	2003-02-14 15:51:23.000000000 -0800
+++ slab-2.5.61/net/decnet/dn_table.c	2003-02-15 04:30:54.000000000 -0800
@@ -530,7 +530,7 @@ create:
 
 replace:
 	err = -ENOBUFS;
-	new_f = kmem_cache_alloc(dn_hash_kmem, SLAB_KERNEL);
+	new_f = kmem_cache_alloc(dn_hash_kmem, GFP_KERNEL);
 	if (new_f == NULL)
 		goto out;
 
diff -urpN linux-2.5.61/net/ipv4/fib_hash.c slab-2.5.61/net/ipv4/fib_hash.c
--- linux-2.5.61/net/ipv4/fib_hash.c	2003-02-14 15:51:45.000000000 -0800
+++ slab-2.5.61/net/ipv4/fib_hash.c	2003-02-15 04:30:53.000000000 -0800
@@ -561,7 +561,7 @@ create:
 
 replace:
 	err = -ENOBUFS;
-	new_f = kmem_cache_alloc(fn_hash_kmem, SLAB_KERNEL);
+	new_f = kmem_cache_alloc(fn_hash_kmem, GFP_KERNEL);
 	if (new_f == NULL)
 		goto out;
 
diff -urpN linux-2.5.61/net/ipv4/tcp_ipv4.c slab-2.5.61/net/ipv4/tcp_ipv4.c
--- linux-2.5.61/net/ipv4/tcp_ipv4.c	2003-02-14 15:51:26.000000000 -0800
+++ slab-2.5.61/net/ipv4/tcp_ipv4.c	2003-02-15 04:31:19.000000000 -0800
@@ -129,7 +129,7 @@ struct tcp_bind_bucket *tcp_bucket_creat
 					  unsigned short snum)
 {
 	struct tcp_bind_bucket *tb = kmem_cache_alloc(tcp_bucket_cachep,
-						      SLAB_ATOMIC);
+						      GFP_ATOMIC);
 	if (tb) {
 		tb->port = snum;
 		tb->fastreuse = 0;
diff -urpN linux-2.5.61/net/ipv4/tcp_minisocks.c slab-2.5.61/net/ipv4/tcp_minisocks.c
--- linux-2.5.61/net/ipv4/tcp_minisocks.c	2003-02-14 15:52:25.000000000 -0800
+++ slab-2.5.61/net/ipv4/tcp_minisocks.c	2003-02-15 04:31:19.000000000 -0800
@@ -354,7 +354,7 @@ void tcp_time_wait(struct sock *sk, int 
 		recycle_ok = tp->af_specific->remember_stamp(sk);
 
 	if (tcp_tw_count < sysctl_tcp_max_tw_buckets)
-		tw = kmem_cache_alloc(tcp_timewait_cachep, SLAB_ATOMIC);
+		tw = kmem_cache_alloc(tcp_timewait_cachep, GFP_ATOMIC);
 
 	if(tw != NULL) {
 		struct inet_opt *inet = inet_sk(sk);
diff -urpN linux-2.5.61/net/ipv4/xfrm_input.c slab-2.5.61/net/ipv4/xfrm_input.c
--- linux-2.5.61/net/ipv4/xfrm_input.c	2003-02-14 15:51:08.000000000 -0800
+++ slab-2.5.61/net/ipv4/xfrm_input.c	2003-02-15 04:31:19.000000000 -0800
@@ -108,7 +108,7 @@ int xfrm4_rcv(struct sk_buff *skb)
 
 	if (!skb->sp || atomic_read(&skb->sp->refcnt) != 1) {
 		struct sec_path *sp;
-		sp = kmem_cache_alloc(secpath_cachep, SLAB_ATOMIC);
+		sp = kmem_cache_alloc(secpath_cachep, GFP_ATOMIC);
 		if (!sp)
 			goto drop;
 		if (skb->sp) {
diff -urpN linux-2.5.61/net/ipv4/xfrm_policy.c slab-2.5.61/net/ipv4/xfrm_policy.c
--- linux-2.5.61/net/ipv4/xfrm_policy.c	2003-02-14 15:51:45.000000000 -0800
+++ slab-2.5.61/net/ipv4/xfrm_policy.c	2003-02-15 04:31:19.000000000 -0800
@@ -115,7 +115,7 @@ struct xfrm_policy *flow_lookup(int dir,
 		if (flow_count(cpu) > flow_hwm)
 			flow_cache_shrink(cpu);
 
-		fle = kmem_cache_alloc(flow_cachep, SLAB_ATOMIC);
+		fle = kmem_cache_alloc(flow_cachep, GFP_ATOMIC);
 		if (fle) {
 			flow_count(cpu)++;
 			fle->fl = *fl;
diff -urpN linux-2.5.61/net/ipv6/ip6_fib.c slab-2.5.61/net/ipv6/ip6_fib.c
--- linux-2.5.61/net/ipv6/ip6_fib.c	2003-02-14 15:52:27.000000000 -0800
+++ slab-2.5.61/net/ipv6/ip6_fib.c	2003-02-15 04:31:20.000000000 -0800
@@ -211,7 +211,7 @@ static __inline__ struct fib6_node * nod
 {
 	struct fib6_node *fn;
 
-	if ((fn = kmem_cache_alloc(fib6_node_kmem, SLAB_ATOMIC)) != NULL)
+	if ((fn = kmem_cache_alloc(fib6_node_kmem, GFP_ATOMIC)) != NULL)
 		memset(fn, 0, sizeof(struct fib6_node));
 
 	return fn;
diff -urpN linux-2.5.61/net/socket.c slab-2.5.61/net/socket.c
--- linux-2.5.61/net/socket.c	2003-02-14 15:51:29.000000000 -0800
+++ slab-2.5.61/net/socket.c	2003-02-15 04:30:54.000000000 -0800
@@ -274,7 +274,7 @@ static kmem_cache_t * sock_inode_cachep;
 static struct inode *sock_alloc_inode(struct super_block *sb)
 {
 	struct socket_alloc *ei;
-	ei = (struct socket_alloc *)kmem_cache_alloc(sock_inode_cachep, SLAB_KERNEL);
+	ei = (struct socket_alloc *)kmem_cache_alloc(sock_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	init_waitqueue_head(&ei->socket.wait);
diff -urpN linux-2.5.61/net/sunrpc/rpc_pipe.c slab-2.5.61/net/sunrpc/rpc_pipe.c
--- linux-2.5.61/net/sunrpc/rpc_pipe.c	2003-02-14 15:51:26.000000000 -0800
+++ slab-2.5.61/net/sunrpc/rpc_pipe.c	2003-02-15 04:30:54.000000000 -0800
@@ -108,7 +108,7 @@ static struct inode *
 rpc_alloc_inode(struct super_block *sb)
 {
 	struct rpc_inode *rpci;
-	rpci = (struct rpc_inode *)kmem_cache_alloc(rpc_inode_cachep, SLAB_KERNEL);
+	rpci = (struct rpc_inode *)kmem_cache_alloc(rpc_inode_cachep, GFP_KERNEL);
 	if (!rpci)
 		return NULL;
 	return &rpci->vfs_inode;
