Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262299AbREXVJa>; Thu, 24 May 2001 17:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262297AbREXVJY>; Thu, 24 May 2001 17:09:24 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:4061 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262296AbREXVJN>;
	Thu, 24 May 2001 17:09:13 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105242109.OAA29748@csl.Stanford.EDU>
Subject: [CHECKER] null bugs in 2.4.4 and 2.4.4-ac8
To: linux-kernel@vger.kernel.org
Date: Thu, 24 May 2001 14:09:11 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Enclosed are 103 potential errors where code gets a pointer from a
possibly-failing routine (kmalloc, etc) and dereferences it without
checking.  Many follow the simple pattern of alloc-memset:

	private = kmalloc(sizeof(*private),GFP_KERNEL);
	memset(private, 0, sizeof(struct xircom_private));

   Summary for 
	2.4.4ac8-specific errors       	= 7
	2.4.4-specific errors 		= 24
	Common errors 		        = 72
  	Total 			  	= 103

 BUGs	|	File Name
9	|	drivers/block/DAC960.c
5	|	drivers/scsi/sd.c
4	|	drivers/net/aironet4500_card.c
4	|	net/atm/lec.c
3	|	drivers/md/raid5.c
3	|	drivers/scsi/osst.c
3	|	fs/nfsd/nfsfh.c
3	|	drivers/char/ip2main.c
3	|	drivers/ide/ide-probe.c
2	|	arch/i386/kernel/irq.c
2	|	drivers/scsi/hosts.c
2	|	drivers/scsi/megaraid.c
2	|	fs/hpfs/anode.c
2	|	drivers/media/video/bttv-driver.c
2	|	fs/jffs/intrep.c
2	|	drivers/net/skfp/ess.c
2	|	drivers/net/wan/sdla_fr.c
2	|	drivers/pcmcia/bulkmem.c
1	|	drivers/video/sis/sis_main.c
1	|	drivers/net/pcmcia/xircom_cb.c
1	|	drivers/net/wan/comx-proto-fr.c
1	|	drivers/char/drm/context.c
1	|	net/sched/sch_gred.c
1	|	drivers/char/drm/dma.c
1	|	drivers/char/drm/radeon_bufs.c
1	|	fs/bfs/inode.c
1	|	drivers/mtd/slram.c
1	|	fs/locks.c
1	|	drivers/char/epca.c
1	|	drivers/scsi/gdth.c
1	|	drivers/i2o/i2o_core.c
1	|	drivers/char/rio/riocmd.c
1	|	drivers/scsi/ultrastor.c
1	|	drivers/scsi/g_NCR5380.c
1	|	drivers/scsi/scsi_proc.c
1	|	drivers/usb/kaweth.c
1	|	drivers/net/wan/sdla_chdlc.c
1	|	drivers/scsi/eata_dma.c
1	|	drivers/isdn/hisax/fsm.c
1	|	fs/qnx4/inode.c
1	|	drivers/pcmcia/rsrc_mgr.c
1	|	drivers/scsi/sr.c
1	|	drivers/char/rio/riotable.c
1	|	drivers/media/video/zoran_procfs.c
1	|	drivers/scsi/gdth_proc.c
1	|	net/irda/irproc.c
1	|	drivers/mtd/mtdram.c
1	|	drivers/net/eql.c
1	|	fs/binfmt_misc.c
1	|	drivers/char/drm/fops.c
1	|	drivers/media/video/i2c-parport.c
1	|	drivers/usb/hp5300.c
1	|	drivers/scsi/scsi_scan.c
1	|	drivers/ieee1394/video1394.c
1	|	drivers/block/ll_rw_blk.c
1	|	drivers/ide/ide-tape.c
1	|	drivers/mtd/ftl.c
1	|	drivers/media/video/videodev.c
1	|	drivers/video/matrox/matroxfb_crtc2.c
1	|	fs/ntfs/support.c
1	|	drivers/char/drm/r128_bufs.c
1	|	fs/hpfs/dir.c
1	|	drivers/usb/se401.c
1	|	fs/reiserfs/journal.c
1	|	drivers/scsi/sr_ioctl.c
1	|	drivers/char/drm/proc.c
------------------------------------------------------------------

Boilerplate disclaimer:
        - this is part of a one-time large batch of errors.  In the future,
          we'll send out incremental bug reports along with a pointer to
          the bug database on our website.

        - as always, bugs may not be errors --- we have inspected the
          error logs to counter this.

        - bugs may be missing in one distribution versus the other because
          we did not compile that file (or failed to fully compile it).
          It can be worthwhile to cross check important bugs to make sure
          they've been killed.

	- bugs are sorted roughly by severity and ease-of-diagnosis.
	  The highest ranked bugs are "SECURITY" which (in most of the
	  examples) are primarily denial-of-service vulnerabilities
	  where the user could trigger the bug when they canted to.
	  Ease-of-diagnosis is currently crude: we rank LOCAL errors
	  over GLOBAL (GLOBAL require looking at call chains) and then
	  distance between error source and manifestation as the next
	  (closer is better)

	- these errors are a subset of the ones we found --- we typically
	  did not inspect many of the global errors, since there were so
	  many local ones.  If you'd like to see uninspected files, let
	  me know.


############################################################
# 2.4.4ac8 specific errors
#
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/pcmcia/xircom_cb.c:222:xircom_probe: ERROR:NULL:221:222: Passing unknown ptr "private"! as arg 0 to call "memset"! set by 'kmalloc':222 [nbytes = 148] 
	/* 
	   Before changing the hardware, allocate the memory.
	   This way, we can fail gracefully if not enough memory
	   is available. 
	 */
Start --->
	private = kmalloc(sizeof(*private),GFP_KERNEL);
Error --->
	memset(private, 0, sizeof(struct xircom_private));
	
	/* Allocate the send/receive buffers */
	private->rx_buffer = pci_alloc_consistent(pdev,8192,&private->rx_dma_handle);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/usb/hp5300.c:415:usc_scsi_detect: ERROR:NULL:414:415: Using unknown ptr "host" illegally! set by 'scsi_register':415
	strcpy(sht->proc_name, local_name);

 	sht->proc_dir = NULL;

	/* In host->hostdata we store a pointer to desc */
Start --->
	desc->host = scsi_register(sht, sizeof(desc));
Error --->
	desc->host->hostdata[0] = (unsigned long)desc;
/* FIXME: what if sizeof(void*) != sizeof(unsigned long)? */ 

	return 1;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/aironet4500_card.c:846:awc_i365_init: ERROR:NULL:841:846: Using unknown ptr "dev" illegally! set by 'init_etherdev':846 [nbytes = 376] 

	struct net_device * dev;
	int i;


Start --->
	dev = init_etherdev(0, sizeof(struct awc_private) );

//	dev->tx_queue_len = tx_queue_len;
	ether_setup(dev);

Error --->
	dev->hard_start_xmit = 		&awc_start_xmit;
//	dev->set_config = 		&awc_config_misiganes,aga mitte awc_config;
	dev->get_stats = 		&awc_get_stats;
	dev->set_multicast_list = 	&awc_set_multicast_list;
---------------------------------------------------------
[BUG]  create_entry can return 0, but its getting checked with IS_ERR!  blech.
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/binfmt_misc.c:504:bm_register_write: ERROR:NULL:497:504: Using unknown ptr "e" illegally! set by 'create_entry':504 [nbytes = 40] 
	Node *e;
	struct dentry *root, *dentry;
	struct super_block *sb = file->f_vfsmnt->mnt_sb;
	int err = 0;

Start --->
	e = create_entry(buffer, count);

	if (IS_ERR(e))
		return PTR_ERR(e);

	root = dget(sb->s_root);
	down(&root->d_inode->i_sem);
Error --->
	dentry = lookup_one(e->name, root);
	err = PTR_ERR(dentry);
	if (!IS_ERR(dentry)) {
		down(&root->d_inode->i_zombie);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/usb/kaweth.c:887:kaweth_probe: ERROR:NULL:880:887: Using unknown ptr "net" illegally! set by 'init_etherdev':887
	kaweth_dbg("Initializing net device.");

	kaweth->tx_urb = usb_alloc_urb(0);
	kaweth->rx_urb = usb_alloc_urb(0);

Start --->
	kaweth->net = init_etherdev(0, 0);

	memcpy(kaweth->net->broadcast, &bcast_addr, sizeof(bcast_addr));
	memcpy(kaweth->net->dev_addr, 
               &kaweth->configuration.hw_addr,
               sizeof(kaweth->configuration.hw_addr));
	 
Error --->
	kaweth->net->priv = kaweth;
	kaweth->net->open = kaweth_open;
	kaweth->net->stop = kaweth_close;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/usb/se401.c:1418:se401_init: ERROR:NULL:1411:1418: Using unknown ptr "height" illegally! set by 'kmalloc':1418
	}
	sprintf (temp, "ExtraFeatures: %d", cp[3]);

	se401->sizes=cp[4]+cp[5]*256;
	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
Start --->
	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
	for (i=0; i<se401->sizes; i++) {
		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
	}
	sprintf (temp, "%s Sizes:", temp);
	for (i=0; i<se401->sizes; i++) {
Error --->
		sprintf(temp, "%s %dx%d", temp, se401->width[i], se401->height[i]);
	}
	info("%s", temp);
	se401->maxframesize=se401->width[se401->sizes-1]*se401->height[se401->sizes-1]*3;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/media/video/zoran_procfs.c:124:zoran_write_proc: ERROR:NULL:114:124: Passing unknown ptr "sp"! as arg 0 to call "strpbrk"! set by 'vmalloc':124 [nbytes = 1] 
	char *line, *ldelim, *varname, *svar, *tdelim;
	struct zoran *zr;

	zr = (struct zoran *) data;

Start --->
	string = sp = vmalloc(count + 1);
	if (!string) {
		printk(KERN_ERR "%s: write_proc: can not allocate memory\n", zr->name);
		return -ENOMEM;
	}
	memcpy(string, buffer, count);
	string[count] = 0;
	DEBUG2(printk(KERN_INFO "%s: write_proc: name=%s count=%lu data=%x\n", zr->name, file->f_dentry->d_name.name, count, (int) data));
	ldelim = " \t\n";
	tdelim = "=";
Error --->
	line = strpbrk(sp, ldelim);
	while (line) {
		*line = 0;
		svar = strpbrk(sp, tdelim);


############################################################
# 2.4.4 specific errors

#
---------------------------------------------------------
[BUG] DAC960_AllocateCommand
/u2/engler/mc/oses/linux/2.4.4/drivers/block/DAC960.c:1442:DAC960_V2_ReadDeviceConfiguration: ERROR:NULL:1439:1442: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':1442 [nbytes = 2192] 
      Controller->V2.InquiryUnitSerialNumber[PhysicalDeviceIndex] =
	InquiryUnitSerialNumber;
      memset(InquiryUnitSerialNumber, 0,
	     sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T));
      InquiryUnitSerialNumber->PeripheralDeviceType = 0x1F;
Start --->
      Command = DAC960_AllocateCommand(Controller);
      CommandMailbox = &Command->V2.CommandMailbox;
      DAC960_V2_ClearCommand(Command);
Error --->
      Command->CommandType = DAC960_ImmediateCommand;
      CommandMailbox->SCSI_10.CommandOpcode = DAC960_V2_SCSI_10_Passthru;
      CommandMailbox->SCSI_10.CommandControlBits
			     .DataTransferControllerToHost = true;
---------------------------------------------------------
[BUG] DAC960_AllocateCommand
/u2/engler/mc/oses/linux/2.4.4/drivers/block/DAC960.c:603:DAC960_V2_ControllerInfo: ERROR:NULL:599:603: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':603 [nbytes = 2192] 
static boolean DAC960_V2_ControllerInfo(DAC960_Controller_T *Controller,
					DAC960_V2_IOCTL_Opcode_T IOCTL_Opcode,
					void *DataPointer,
					unsigned int DataByteCount)
{
Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
  DAC960_V2_CommandStatus_T CommandStatus;
  DAC960_V2_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->ControllerInfo.CommandOpcode = DAC960_V2_IOCTL;
  CommandMailbox->ControllerInfo.CommandControlBits
				.DataTransferControllerToHost = true;
---------------------------------------------------------
[BUG] DAC960_AllocateCommand
/u2/engler/mc/oses/linux/2.4.4/drivers/block/DAC960.c:730:DAC960_V2_DeviceOperation: ERROR:NULL:726:730: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':730 [nbytes = 2192] 
static boolean DAC960_V2_DeviceOperation(DAC960_Controller_T *Controller,
					 DAC960_V2_IOCTL_Opcode_T IOCTL_Opcode,
					 DAC960_V2_OperationDevice_T
					   OperationDevice)
{
Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
  DAC960_V2_CommandStatus_T CommandStatus;
  DAC960_V2_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->DeviceOperation.CommandOpcode = DAC960_V2_IOCTL;
  CommandMailbox->DeviceOperation.CommandControlBits
				 .DataTransferControllerToHost = true;
---------------------------------------------------------
[BUG] DAC960_AllocateCommand
/u2/engler/mc/oses/linux/2.4.4/drivers/block/DAC960.c:645:DAC960_V2_LogicalDeviceInfo: ERROR:NULL:641:645: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':645 [nbytes = 2192] 
					   unsigned short
					     LogicalDeviceNumber,
					   void *DataPointer,
					   unsigned int DataByteCount)
{
Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
  DAC960_V2_CommandStatus_T CommandStatus;
  DAC960_V2_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->LogicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
  CommandMailbox->LogicalDeviceInfo.CommandControlBits
				   .DataTransferControllerToHost = true;
---------------------------------------------------------
[BUG] DAC960_AllocateCommand can return NULL
/u2/engler/mc/oses/linux/2.4.4/drivers/block/DAC960.c:512:DAC960_V1_ExecuteType3: ERROR:NULL:508:512: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':512 [nbytes = 2192] 

static boolean DAC960_V1_ExecuteType3(DAC960_Controller_T *Controller,
				      DAC960_V1_CommandOpcode_T CommandOpcode,
				      void *DataPointer)
{
Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
  DAC960_V1_CommandStatus_T CommandStatus;
  DAC960_V1_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->Type3.CommandOpcode = CommandOpcode;
  CommandMailbox->Type3.BusAddress = Virtual_to_Bus32(DataPointer);
  DAC960_ExecuteCommand(Command);
---------------------------------------------------------
[BUG] DAC960_AllocateCommand
/u2/engler/mc/oses/linux/2.4.4/drivers/block/DAC960.c:565:DAC960_V2_GeneralInfo: ERROR:NULL:561:565: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':565 [nbytes = 2192] 
static boolean DAC960_V2_GeneralInfo(DAC960_Controller_T *Controller,
				     DAC960_V2_IOCTL_Opcode_T IOCTL_Opcode,
				     void *DataPointer,
				     unsigned int DataByteCount)
{
Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
  DAC960_V2_CommandStatus_T CommandStatus;
  DAC960_V2_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->Common.CommandOpcode = DAC960_V2_IOCTL;
  CommandMailbox->Common.CommandControlBits
			.DataTransferControllerToHost = true;
---------------------------------------------------------
[BUG] DAC960_AllocateCommand
/u2/engler/mc/oses/linux/2.4.4/drivers/block/DAC960.c:689:DAC960_V2_PhysicalDeviceInfo: ERROR:NULL:685:689: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':689 [nbytes = 2192] 
					    unsigned char TargetID,
					    unsigned char LogicalUnit,
					    void *DataPointer,
					    unsigned int DataByteCount)
{
Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
  DAC960_V2_CommandStatus_T CommandStatus;
  DAC960_V2_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->PhysicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
  CommandMailbox->PhysicalDeviceInfo.CommandControlBits
				    .DataTransferControllerToHost = true;
---------------------------------------------------------
[BUG]  DAC960_AllocateCommand
/u2/engler/mc/oses/linux/2.4.4/drivers/block/DAC960.c:538:DAC960_V1_ExecuteType3D: ERROR:NULL:534:538: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':538 [nbytes = 2192] 
				       DAC960_V1_CommandOpcode_T CommandOpcode,
				       unsigned char Channel,
				       unsigned char TargetID,
				       void *DataPointer)
{
Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
  DAC960_V1_CommandStatus_T CommandStatus;
  DAC960_V1_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->Type3D.CommandOpcode = CommandOpcode;
  CommandMailbox->Type3D.Channel = Channel;
  CommandMailbox->Type3D.TargetID = TargetID;
---------------------------------------------------------
[BUG] drm_alloc can return NULL
/u2/engler/mc/oses/linux/2.4.4/drivers/char/drm/context.c:97:drm_alloc_queue: ERROR:NULL:96:97: Passing unknown ptr "queue"! as arg 0 to call "memset"! set by 'drm_alloc':97 [nbytes = 100] 
		atomic_dec(&dev->queuelist[i]->use_count);
	}
				/* Allocate a new queue */
	down(&dev->struct_sem);
	
Start --->
	queue = drm_alloc(sizeof(*queue), DRM_MEM_QUEUES);
Error --->
	memset(queue, 0, sizeof(*queue));
	atomic_set(&queue->use_count, 1);
	
	++dev->queue_count;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/engler/mc/oses/linux/2.4.4/drivers/md/raid5.c:1270:__check_consistency: ERROR:NULL:1269:1270: Using unknown ptr "tmp" illegally! set by 'kmalloc':1270 [nbytes = 96] 
	int i, ret = 0, nr = 0, count;
	struct buffer_head *bh_ptr[MAX_XOR_BLOCKS];

	if (conf->working_disks != conf->raid_disks)
		goto out;
Start --->
	tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
Error --->
	tmp->b_size = 4096;
	tmp->b_page = alloc_page(GFP_KERNEL);
	tmp->b_data = page_address(tmp->b_page);
	if (!tmp->b_data)
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/ieee1394/video1394.c:305:alloc_dma_iso_ctx: ERROR:NULL:304:305: Passing unknown ptr "d"! as arg 0 to call "memset"! set by 'kmalloc':305 [nbytes = 88] 
{
	struct dma_iso_ctx *d=NULL;
	int i;

	d = (struct dma_iso_ctx *)kmalloc(sizeof(struct dma_iso_ctx), 
Start --->
					  GFP_KERNEL);
Error --->
	memset(d, 0, sizeof(struct dma_iso_ctx));

	if (d==NULL) {
		PRINT(KERN_ERR, ohci->id, "failed to allocate dma_iso_ctx");
---------------------------------------------------------
[BUG] kmem_cache_alloc can return NULL
/u2/engler/mc/oses/linux/2.4.4/drivers/block/ll_rw_blk.c:368:blk_init_free_list: ERROR:NULL:367:368: Passing unknown ptr "rq"! as arg 0 to call "memset"! set by 'kmem_cache_alloc':368 [nbytes = 88] 

	/*
	 * Divide requests in half between read and write
	 */
	for (i = 0; i < queue_nr_requests; i++) {
Start --->
		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
Error --->
		memset(rq, 0, sizeof(struct request));
		rq->rq_status = RQ_INACTIVE;
		list_add(&rq->table, &q->request_freelist[i & 1]);
	}
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/engler/mc/oses/linux/2.4.4/drivers/pcmcia/bulkmem.c:363:setup_regions: ERROR:NULL:362:363: Using unknown ptr "r" illegally! set by 'kmalloc':363 [nbytes = 76] 
    
    offset = 0;
    for (i = 0; i < device.ndev; i++) {
	if ((device.dev[i].type != CISTPL_DTYPE_NULL) &&
	    (device.dev[i].size != 0)) {
Start --->
	    r = kmalloc(sizeof(*r), GFP_KERNEL);
Error --->
	    r->region_magic = REGION_MAGIC;
	    r->state = 0;
	    r->dev_info[0] = '\0';
	    r->mtd = NULL;
---------------------------------------------------------
[BUG] alloc_pages can return NULL
/u2/engler/mc/oses/linux/2.4.4/drivers/md/raid5.c:160:grow_buffers: ERROR:NULL:159:160: Using unknown ptr "page" illegally! set by 'alloc_pages':160 [nbytes = 68] 
		bh = kmalloc(sizeof(struct buffer_head), priority);
		if (!bh)
			return 1;
		memset(bh, 0, sizeof (struct buffer_head));
		init_waitqueue_head(&bh->b_wait);
Start --->
		page = alloc_page(priority);
Error --->
		bh->b_data = page_address(page);
		if (!bh->b_data) {
			kfree(bh);
			return 1;
---------------------------------------------------------
[BUG] drm_alloc can return NULL
/u2/engler/mc/oses/linux/2.4.4/drivers/char/drm/fops.c:50:drm_open_helper: ERROR:NULL:49:50: Passing unknown ptr "priv"! as arg 0 to call "memset"! set by 'drm_alloc':50 [nbytes = 40] 
	if (filp->f_flags & O_EXCL)   return -EBUSY; /* No exclusive opens */
	if (!drm_cpu_valid())         return -EINVAL;

	DRM_DEBUG("pid = %d, minor = %d\n", current->pid, minor);

Start --->
	priv		    = drm_alloc(sizeof(*priv), DRM_MEM_FILES);
Error --->
	memset(priv, 0, sizeof(*priv));
	filp->private_data  = priv;
	priv->uid	    = current->euid;
	priv->pid	    = current->pid;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/engler/mc/oses/linux/2.4.4/drivers/pcmcia/bulkmem.c:232:setup_erase_request: ERROR:NULL:231:232: Using unknown ptr "busy" illegally! set by 'kmalloc':232 [nbytes = 36] 
	else if ((erase->Offset+erase->Size > info->RegionSize) ||
		 (erase->Size & (info->BlockSize-1)))
	    erase->State = ERASE_BAD_SIZE;
	else {
	    erase->State = 1;
Start --->
	    busy = kmalloc(sizeof(erase_busy_t), GFP_KERNEL);
Error --->
	    busy->erase = erase;
	    busy->client = handle;
	    init_timer(&busy->timeout);
	    busy->timeout.data = (u_long)busy;
---------------------------------------------------------
[BUG] sm_to_para can return NULL. But the start line is not correct.
/u2/engler/mc/oses/linux/2.4.4/drivers/net/skfp/ess.c:261:ess_raf_received_pack: ERROR:NULL:260:261: Using unknown ptr "p" illegally! set by 'sm_to_para':261 [nbytes = 0] 
		}

		/*
		 * Extract message parameters
		 */
Start --->
		p = (void *) sm_to_para(smc,sm,SMT_P320F) ;
Error --->
		payload = ((struct smt_p_320f *)p)->mib_payload ;
		p = (void *) sm_to_para(smc,sm,SMT_P3210) ;
		overhead = ((struct smt_p_3210 *)p)->mib_overhead ;

---------------------------------------------------------
[BUG] alloc_page can return NULL
/u2/engler/mc/oses/linux/2.4.4/drivers/md/raid5.c:1272:__check_consistency: ERROR:NULL:1271:1272: Using unknown ptr "b_page" illegally! set by 'alloc_pages':1272

	if (conf->working_disks != conf->raid_disks)
		goto out;
	tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
	tmp->b_size = 4096;
Start --->
	tmp->b_page = alloc_page(GFP_KERNEL);
Error --->
	tmp->b_data = page_address(tmp->b_page);
	if (!tmp->b_data)
		goto out;
	md_clear_page(tmp->b_data);
---------------------------------------------------------
[BUG] create_proc_entry can return NULL
/u2/engler/mc/oses/linux/2.4.4/arch/i386/kernel/irq.c:1140:register_irq_proc: ERROR:NULL:1138:1140: Using unknown ptr "entry" illegally! set by 'create_proc_entry':1140 [nbytes = 76] 

	/* create /proc/irq/1234 */
	irq_dir[irq] = proc_mkdir(name, root_irq_dir);

	/* create /proc/irq/1234/smp_affinity */
Start --->
	entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);

Error --->
	entry->nlink = 1;
	entry->data = (void *)(long)irq;
	entry->read_proc = irq_affinity_read_proc;
	entry->write_proc = irq_affinity_write_proc;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/engler/mc/oses/linux/2.4.4/drivers/video/sis/sis_main.c:1033:poh_new_node: ERROR:NULL:1031:1033: Using unknown ptr "poha" illegally! set by 'kmalloc':1033 [nbytes = 20] 
	unsigned long cOhs;
	struct OHALLOC *poha;
	struct OH *poh;

	if (heap.pohFreeList == NULL) {
Start --->
		poha = kmalloc(OH_ALLOC_SIZE, GFP_KERNEL);

Error --->
		poha->pohaNext = heap.pohaChain;
		heap.pohaChain = poha;

		cOhs =
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/engler/mc/oses/linux/2.4.4/drivers/i2o/i2o_core.c:925:i2o_core_evt: ERROR:NULL:922:925: Passing unknown ptr "d"! as arg 0 to call "memcpy"! set by 'kmalloc':925 [nbytes = 88] 
		 	 * - Inform all interested drivers about this device's existence
		 	 */
			case I2O_EVT_IND_EXEC_NEW_LCT_ENTRY:
			{
				struct i2o_device *d = (struct i2o_device *)
Start --->
					kmalloc(sizeof(struct i2o_device), GFP_KERNEL);
				int i;

Error --->
				memcpy(&d->lct_data, &msg[5], sizeof(i2o_lct_entry));
	
				d->next = NULL;
				d->controller = c;
---------------------------------------------------------
[BUG] Function will not terminate if "drm_dev_root" is NULL. just printk
/u2/engler/mc/oses/linux/2.4.4/drivers/char/drm/proc.c:96:drm_proc_init: ERROR:NULL:91:96: Using unknown ptr "drm_dev_root" illegally! set by 'create_proc_entry':96 [nbytes = 76] 

				/* Instead of doing this search, we should
				   add some global support for /proc/dri. */
	for (i = 0; i < 8; i++) {
		sprintf(drm_slot_name, "dri/%d", i);
Start --->
		drm_dev_root = create_proc_entry(drm_slot_name, S_IFDIR, NULL);
		if (!drm_dev_root) {
			DRM_ERROR("Cannot create /proc/%s\n", drm_slot_name);
			remove_proc_entry("dri", NULL);
		}
Error --->
		if (drm_dev_root->nlink == 2) break;
		drm_dev_root = NULL;
	}
	if (!drm_dev_root) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/scsi/osst.c:1163:osst_read_back_buffer_and_rewrite: ERROR:NULL:1127:1163: Using unknown ptr "SRpnt" illegally! set by 'osst_do_scsi':1163 [nbytes = 216] 
#endif
				memset(cmd, 0, MAX_COMMAND_SIZE);
				cmd[0] = WRITE_FILEMARKS;
				cmd[1] = 1;
				SRpnt = osst_do_scsi(SRpnt, STp, cmd, 0, SCSI_DATA_NONE,
Start --->
							    STp->timeout, MAX_WRITE_RETRIES, TRUE);

	... DELETED 30 lines ...

			}
		}
		if (flag) {
			if ((SRpnt->sr_sense_buffer[ 2] & 0x0f) == 13 &&
			     SRpnt->sr_sense_buffer[12]         ==  0 &&
Error --->
			     SRpnt->sr_sense_buffer[13]         ==  2) {
				printk(KERN_ERR "osst%d: Volume overflow in write error recovery\n", dev);
				vfree((void *)buffer);
				return (-EIO);			/* hit end of tape = fail */
---------------------------------------------------------
[BUG] osst_do_scsi will never return NULL if argument SRpnt isn't NULL. But they copy SRpnt back by *aSRpnt, implies it could be NULL
/u2/engler/mc/oses/linux/2.4.4/drivers/scsi/osst.c:1163:osst_read_back_buffer_and_rewrite: ERROR:NULL:1111:1163: Using unknown ptr "SRpnt" illegally! set by 'osst_do_scsi':1163 [nbytes = 216] 
#if DEBUG
		if (debugging)
			printk(OSST_DEB_MSG "osst%d: About to attempt to write to frame %d\n", dev, new_block+i);
#endif
		SRpnt = osst_do_scsi(SRpnt, STp, cmd, OS_FRAME_SIZE, SCSI_DATA_WRITE,
Start --->
					    STp->timeout, MAX_WRITE_RETRIES, TRUE);

	... DELETED 46 lines ...

			}
		}
		if (flag) {
			if ((SRpnt->sr_sense_buffer[ 2] & 0x0f) == 13 &&
			     SRpnt->sr_sense_buffer[12]         ==  0 &&
Error --->
			     SRpnt->sr_sense_buffer[13]         ==  2) {
				printk(KERN_ERR "osst%d: Volume overflow in write error recovery\n", dev);
				vfree((void *)buffer);
				return (-EIO);			/* hit end of tape = fail */


############################################################
# errors common to both

#
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/ip2main.c:1061:ip2_init_board: ERROR:NULL:1053:1061: Using unknown ptr "pCh" illegally! set by 'kmalloc':1061 [nbytes = 2024] 
		}
		goto ex_exit;
		break;
	}
	DevTableMem[boardnum] = pCh =
Start --->
		kmalloc ( sizeof (i2ChanStr) * nports, GFP_KERNEL );
	pB->i2eChannelPtr = pCh;
	pB->i2eChannelCnt = nports;
	i2InitChannels ( pB, pB->i2eChannelCnt, pCh );
	pB->i2eChannelPtr = &DevTable[IP2_PORTS_PER_BOARD * boardnum];

	for( i = 0; i < pB->i2eChannelCnt; ++i ) {
		DevTable[IP2_PORTS_PER_BOARD * boardnum + i] = pCh;
Error --->
		pCh->port_index = (IP2_PORTS_PER_BOARD * boardnum) + i;
		pCh++;
	}
ex_exit:
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/ip2main.c:1041:ip2_init_board: ERROR:NULL:1030:1041: Using unknown ptr "pCh" illegally! set by 'kmalloc':1041 [nbytes = 2024] 
					++nports;
				}
			}
		}
		DevTableMem[boardnum] = pCh =
Start --->
			kmalloc( sizeof(i2ChanStr) * nports, GFP_KERNEL );
		if ( !i2InitChannels( pB, nports, pCh ) ) {
			printk(KERN_ERR "i2InitChannels failed: %d\n",pB->i2eError);
		}
		pB->i2eChannelPtr = &DevTable[portnum];
		pB->i2eChannelCnt = ABS_MOST_PORTS;

		for( box = 0; box < ABS_MAX_BOXES; ++box, portnum += ABS_BIGGEST_BOX ) {
			for( i = 0; i < ABS_BIGGEST_BOX; ++i ) {
				if ( pB->i2eChannelMap[box] & (1 << i) ) {
					DevTable[portnum + i] = pCh;
Error --->
					pCh->port_index = portnum + i;
					pCh++;
				}
			}
---------------------------------------------------------
[BUG] But the start line is not correct
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/bfs/inode.c:302:bfs_read_super: ERROR:NULL:301:302: Using unknown ptr "inode" illegally! set by 'iget':302 [nbytes = 468] 
	s->su_freei = 0;
	s->su_lf_eblk = 0;
	s->su_lf_sblk = 0;
	s->su_lf_ioff = 0;
	for (i=BFS_ROOT_INO; i<=s->su_lasti; i++) {
Start --->
		inode = iget(s,i);
Error --->
		if (inode->iu_dsk_ino == 0)
			s->su_freei++;
		else {
			set_bit(i, s->su_imap);
---------------------------------------------------------
[BUG] hpfs_map_anode
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/hpfs/anode.c:299:hpfs_remove_btree: ERROR:NULL:301:299: Using unknown ptr "anode" illegally! set by 'hpfs_map_anode':299 [nbytes = 512] 
	if (s->s_hpfs_chk)
		if (hpfs_stop_cycles(s, ano, &c1, &c2, "hpfs_remove_btree #2")) return;
	brelse(bh);
	hpfs_free_sectors(s, ano, 1);
	oano = ano;
Error --->
	ano = anode->up;
	if (--level) {
Start --->
		anode = hpfs_map_anode(s, ano, &bh);
		btree1 = &anode->btree;
	} else btree1 = btree;
	for (i = 0; i < btree1->n_used_nodes; i++) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/megaraid.c:4118:megadev_ioctl: ERROR:NULL:4117:4118: Passing unknown ptr "scsicmd"! as arg 0 to call "memset"! set by 'kmalloc':4118 [nbytes = 388] 
				}
			}
		}
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)	/* 0x020400 */
		scsicmd = (Scsi_Cmnd *) kmalloc (sizeof (Scsi_Cmnd),
Start --->
						 GFP_KERNEL | GFP_DMA);
Error --->
		memset (scsicmd, 0, sizeof (Scsi_Cmnd));
#else
		scsicmd = (Scsi_Cmnd *) scsi_init_malloc (sizeof (Scsi_Cmnd),
							  GFP_ATOMIC | GFP_DMA);
---------------------------------------------------------
[BUG] scsi_allocate_device can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/gdth_proc.c:701:gdth_get_info: ERROR:NULL:700:701: Using unknown ptr "scp" illegally! set by 'scsi_allocate_device':701 [nbytes = 388] 
    TRACE2(("gdth_get_info() ha %d bus %d\n",hanum,busnum));
    ha = HADATA(gdth_ctr_tab[hanum]);

#if LINUX_VERSION_CODE >= 0x020322
    sdev = scsi_get_host_dev(gdth_ctr_vtab[vh]);
Start --->
    scp  = scsi_allocate_device(sdev, 1, FALSE);
Error --->
    scp->cmd_len = 12;
    scp->use_sg = 0;
#else
    memset(&sdev,0,sizeof(Scsi_Device));
---------------------------------------------------------
[BUG] 
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/gdth.c:4593:gdth_halt: ERROR:NULL:4592:4593: Using unknown ptr "scp" illegally! set by 'scsi_allocate_device':4593 [nbytes = 388] 
#ifndef __alpha__
        /* controller reset */
        memset(cmnd, 0xff, 12);
#if LINUX_VERSION_CODE >= 0x020322
        sdev = scsi_get_host_dev(gdth_ctr_tab[hanum]);
Start --->
        scp  = scsi_allocate_device(sdev, 1, FALSE);
Error --->
        scp->cmd_len = 12;
        scp->use_sg = 0;
#else
        memset(&sdev,0,sizeof(Scsi_Device));
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/megaraid.c:3986:megadev_ioctl: ERROR:NULL:3985:3986: Passing unknown ptr "scsicmd"! as arg 0 to call "memset"! set by 'kmalloc':3986 [nbytes = 388] 
						ioc.ui.fcs.length);
			}
		}
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
		scsicmd = (Scsi_Cmnd *) kmalloc (sizeof (Scsi_Cmnd),
Start --->
						 GFP_KERNEL | GFP_DMA);
Error --->
		memset (scsicmd, 0, sizeof (Scsi_Cmnd));
#else
		scsicmd = (Scsi_Cmnd *) scsi_init_malloc (sizeof (Scsi_Cmnd),
							  GFP_ATOMIC | GFP_DMA);
---------------------------------------------------------
[BUG] dereference to invalid pointer in error message
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/hpfs/dir.c:215:hpfs_lookup: ERROR:NULL:213:215: Using unknown ptr "result" illegally! set by 'iget':215 [nbytes = 468] 
	/*
	 * Go find or make an inode.
	 */

	hpfs_lock_iget(dir->i_sb, de->directory || (de->ea_size && dir->i_sb->s_hpfs_eas) ? 1 : 2);
Start --->
	if (!(result = iget(dir->i_sb, ino))) {
		hpfs_unlock_iget(dir->i_sb);
Error --->
		hpfs_error(result->i_sb, "hpfs_lookup: can't get inode");
		goto bail1;
	}
	if (!de->directory) result->i_hpfs_parent_dir = dir->i_ino;
---------------------------------------------------------
[BUG] iget can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/nfsd/nfsfh.c:140:nfsd_iget: ERROR:NULL:137:140: Using unknown ptr "inode" illegally! set by 'iget':140 [nbytes = 468] 
	 * of 0 means "accept any"
	 */
	struct inode *inode;
	struct list_head *lp;
	struct dentry *result;
Start --->
	inode = iget(sb, ino);
	if (is_bad_inode(inode)
	    || (generation && inode->i_generation != generation)
Error --->
		) {
		/* we didn't find the right inode.. */
		dprintk("fh_verify: Inode %lu, Bad count: %d %d or version  %u %u\n",
			inode->i_ino,
---------------------------------------------------------
[BUG] scsi_allocate_request can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/sr_ioctl.c:88:sr_do_ioctl: ERROR:NULL:87:88: Using unknown ptr "SRpnt" illegally! set by 'scsi_allocate_request':88 [nbytes = 216] 
        struct request *req;
	int result, err = 0, retries = 0;
	char *bounce_buffer;

	SDev = scsi_CDs[target].device;
Start --->
	SRpnt = scsi_allocate_request(scsi_CDs[target].device);
Error --->
	SRpnt->sr_data_direction = readwrite;

	/* use ISA DMA buffer if necessary */
	SRpnt->sr_request.buffer = buffer;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/video/matrox/matroxfb_crtc2.c:653:matroxfb_dh_regit: ERROR:NULL:651:653: Passing unknown ptr "d"! as arg 0 to call "memset"! set by 'kmalloc':653 [nbytes = 276] 
static int matroxfb_dh_regit(CPMINFO struct matroxfb_dh_fb_info* m2info) {
#define minfo (m2info->primary_dev)
	struct display* d;
	void* oldcrtc2;

Start --->
	d = kmalloc(sizeof(*d), GFP_KERNEL);

Error --->
	memset(d, 0, sizeof(*d));

	strcpy(m2info->fbcon.modename, "MATROX CRTC2");
	m2info->fbcon.changevar = NULL;
---------------------------------------------------------
[BUG] skb_clone could return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/wan/comx-proto-fr.c:506:fr_xmit: ERROR:NULL:505:506: Using unknown ptr "newskb" illegally! set by 'skb_clone':506 [nbytes = 168] 
	if (ch->debug_flags & DEBUG_COMX_DLCI) {
		comx_debug_skb(dev, skb, "Sending frame");
	}

	if (dev != fr->master) {
Start --->
		struct sk_buff *newskb=skb_clone(skb, GFP_ATOMIC);
Error --->
		newskb->dev=fr->master;
		dev_queue_xmit(newskb);
		ch->stats.tx_bytes += skb->len;
		ch->stats.tx_packets++;
---------------------------------------------------------
[BUG] at line 1796
/u2/engler/mc/oses/linux/2.4.4-ac8/net/atm/lec.c:1799:lec_arp_update: ERROR:NULL:1798:1799: Using unknown ptr "entry" illegally! set by 'make_entry':1799 [nbytes = 124] 
                        return;
                }
        }
        entry = lec_arp_find(priv, mac_addr);
        if (!entry) {
Start --->
                entry = make_entry(priv, mac_addr);
Error --->
                entry->status = ESI_UNKNOWN;
                lec_arp_put(priv->lec_arp_tables, entry);
                /* Temporary, changes before end of function */
        }
---------------------------------------------------------
[BUG] scsi_register
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/ultrastor.c:605:ultrastor_24f_detect: ERROR:NULL:604:605: Using unknown ptr "shpnt" illegally! set by 'scsi_register':605 [nbytes = 124] 
#endif
      tpnt->this_id = config.ha_scsi_id;
      tpnt->unchecked_isa_dma = 0;
      tpnt->sg_tablesize = ULTRASTOR_24F_MAX_SG;

Start --->
      shpnt = scsi_register(tpnt, 0);
Error --->
      shpnt->irq = config.interrupt;
      shpnt->dma_channel = config.dma_channel;
      shpnt->io_port = config.port_address;

---------------------------------------------------------
[BUG] make_entry can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/net/atm/lec.c:1970:lec_vcc_added: ERROR:NULL:1969:1970: Using unknown ptr "entry" illegally! set by 'make_entry':1970 [nbytes = 124] 
                dump_arp_table(priv);
                return;
        }
        /* Not found, snatch address from first data packet that arrives from
           this vcc */
Start --->
        entry = make_entry(priv, bus_mac);
Error --->
        entry->vcc = vcc;
        entry->old_push = old_push;
        memcpy(entry->atm_addr, ioc_data->atm_addr, ATM_ESA_LEN);
        memset(entry->mac_addr, 0, ETH_ALEN);
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/media/video/i2c-parport.c:77:i2c_parport_attach: ERROR:NULL:76:77: Using unknown ptr "b" illegally! set by 'kmalloc':77 [nbytes = 108] 
};

static void i2c_parport_attach(struct parport *port)
{
  struct parport_i2c_bus *b = kmalloc(sizeof(struct parport_i2c_bus), 
Start --->
				      GFP_KERNEL);
Error --->
  b->i2c = parport_i2c_bus_template;
  b->i2c.data = parport_get_port (port);
  strncpy(b->i2c.name, port->name, 32);
  spin_lock(&bus_list_lock);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/rio/riocmd.c:626:RIOGetCmdBlk: ERROR:NULL:625:626: Passing unknown ptr "CmdBlkP"! as arg 0 to call "memset"! set by 'kmalloc':626 [nbytes = 100] 
struct CmdBlk *
RIOGetCmdBlk()
{
	struct CmdBlk *CmdBlkP;

Start --->
	CmdBlkP = (struct CmdBlk *)sysbrk(sizeof(struct CmdBlk));
Error --->
	bzero(CmdBlkP, sizeof(struct CmdBlk));

	return CmdBlkP;
}
---------------------------------------------------------
[BUG] proc_mkdir can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/net/irda/irproc.c:70:irda_proc_register: ERROR:NULL:69:70: Using unknown ptr "proc_irda" illegally! set by 'proc_mkdir':70 [nbytes = 76] 
 */
void irda_proc_register(void) 
{
	int i;

Start --->
	proc_irda = proc_mkdir("net/irda", NULL);
Error --->
	proc_irda->owner = THIS_MODULE;

	for (i=0;i<IRDA_ENTRIES_NUM;i++)
		create_proc_info_entry(dir[i].name,0,proc_irda,dir[i].fn);
---------------------------------------------------------
[BUG] create_proc_entry can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/media/video/videodev.c:376:videodev_proc_create_dev: ERROR:NULL:375:376: Using unknown ptr "p" illegally! set by 'create_proc_entry':376 [nbytes = 76] 

	d = kmalloc (sizeof (struct videodev_proc_data), GFP_KERNEL);
	if (!d)
		return;

Start --->
	p = create_proc_entry(name, S_IFREG|S_IRUGO|S_IWUSR, video_dev_proc_entry);
Error --->
	p->data = vfd;
	p->read_proc = videodev_proc_read;

	d->proc_entry = p;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/block/DAC960.c:6629:DAC960_CreateProcEntries: ERROR:NULL:6628:6629: Using unknown ptr "UserCommandProcEntry" illegally! set by 'create_proc_read_entry':6629 [nbytes = 76] 
      create_proc_read_entry("current_status", 0, ControllerProcEntry,
			     DAC960_ProcReadCurrentStatus, Controller);
      UserCommandProcEntry =
	create_proc_read_entry("user_command", S_IWUSR | S_IRUSR,
			       ControllerProcEntry, DAC960_ProcReadUserCommand,
Start --->
			       Controller);
Error --->
      UserCommandProcEntry->write_proc = DAC960_ProcWriteUserCommand;
      Controller->ControllerProcEntry = ControllerProcEntry;
    }
}
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/ide-probe.c:762:init_gendisk: ERROR:NULL:761:762: Using unknown ptr "gd" illegally! set by 'kmalloc':762 [nbytes = 48] 
	for (units = MAX_DRIVES; units > 0; --units) {
		if (hwif->drives[units-1].present)
			break;
	}
	minors    = units * (1<<PARTN_BITS);
Start --->
	gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
Error --->
	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
	gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
	bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
	max_sect  = kmalloc (minors*sizeof(int), GFP_KERNEL);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/mtd/slram.c:162:init_slram: ERROR:NULL:160:162: Passing unknown ptr "mymtd"! as arg 0 to call "memset"! set by 'kmalloc':162 [nbytes = 116] 
	    printk(KERN_NOTICE "physmem: start(%lx) + length(%lx) != end(%lx) !\n",
		   start, length, end);
	    return -EINVAL;
	  }

Start --->
	mymtd = kmalloc(sizeof(struct mtd_info), GFP_KERNEL);
	
Error --->
	memset(mymtd, 0, sizeof(*mymtd));
	
	if (mymtd)
	{
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/hosts.c:171:scsi_register: ERROR:NULL:170:171: Using unknown ptr "shn" illegally! set by 'kmalloc':171 [nbytes = 16] 
    retval->host_failed = 0;
    if(j > 0xffff) panic("Too many extra bytes requested\n");
    retval->extra_bytes = j;
    retval->loaded_as_module = 1;
    if (flag_new) {
Start --->
	shn = (Scsi_Host_Name *) kmalloc(sizeof(Scsi_Host_Name), GFP_ATOMIC);
Error --->
	shn->name = kmalloc(hname_len + 1, GFP_ATOMIC);
	if (hname_len > 0)
	    strncpy(shn->name, hname, hname_len);
	shn->name[hname_len] = 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/ntfs/support.c:244:ntfs_dupuni2map: ERROR:NULL:243:244: Passing unknown ptr "buf"! as arg 0 to call "memcpy"! set by 'kmalloc':244 [nbytes = 1] 
			wchar_t uni = in[i];
			if ((chl = nls->uni2char(uni, charbuf,
						NLS_MAX_CHARSET_SIZE)) > 0) {
				/* adjust result buffer */
				if (chl > 1) {
Start --->
					buf = ntfs_malloc(*out_len + chl - 1);
Error --->
					memcpy(buf, result, o);
					ntfs_free(result);
					result = buf;
					*out_len += (chl - 1);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/net/atm/lec.c:284:lec_send_packet: ERROR:NULL:283:284: Passing unknown ptr "nb"! as arg 0 to call "memcpy"! set by 'kmalloc':284 [nbytes = 1] 
        if (skb->len <62) {
                if (skb->truesize < 62) {
                        printk("%s:data packet %d / %d\n",
                               dev->name,
                               skb->len,skb->truesize);
Start --->
                        nb=(unsigned char*)kmalloc(64, GFP_ATOMIC);
Error --->
                        memcpy(nb,skb->data,skb->len);
                        kfree(skb->head);
                        skb->head = skb->data = nb;
                        skb->tail = nb+62;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/pcmcia/rsrc_mgr.c:192:do_io_probe: ERROR:NULL:191:192: Passing unknown ptr "b"! as arg 0 to call "memset"! set by 'kmalloc':192 [nbytes = 1] 
    
    printk(KERN_INFO "cs: IO port probe 0x%04x-0x%04x:",
	   base, base+num-1);
    
    /* First, what does a floating port look like? */
Start --->
    b = kmalloc(256, GFP_KERNEL);
Error --->
    memset(b, 0, 256);
    for (i = base, most = 0; i < base+num; i += 8) {
	if (check_io_resource(i, 8))
	    continue;
---------------------------------------------------------
[BUG] sm_to_para can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/skfp/ess.c:539:ess_send_response: ERROR:NULL:538:539: Using unknown ptr "p" illegally! set by 'sm_to_para':539 [nbytes = 0] 

	if (sba_cmd == CHANGE_ALLOCATION) {
		/* set P1A */
		chg->cat.para.p_type = SMT_P001A ;
		chg->cat.para.p_len = sizeof(struct smt_p_001a) - PARA_LEN ;
Start --->
		p = (void *) sm_to_para(smc,sm,SMT_P001A) ;
Error --->
		chg->cat.category = ((struct smt_p_001a *)p)->category ;
	}
	dump_smt(smc,(struct smt_header *)chg,"RAF") ;
	ess_send_frame(smc,mb) ;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/aironet4500_card.c:179:awc_pci_init: ERROR:NULL:178:179: Passing unknown ptr "priv"! as arg 0 to call "memset"! set by 'kmalloc':179
		dev = init_etherdev(NULL, 0);	
		if (!dev)
			return -ENOMEM;
		allocd_dev = 1;
	}
Start --->
	dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
Error --->
	memset(dev->priv,0,sizeof(struct awc_private));
	if (!dev->priv) {
		printk(KERN_CRIT "aironet4x00: could not allocate device private, some unstability may follow\n");
		if (allocd_dev) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/aironet4500_card.c:387:awc4500_pnp_probe: ERROR:NULL:386:387: Passing unknown ptr "priv"! as arg 0 to call "memset"! set by 'kmalloc':387
				isapnp_deactivate(logdev->PNP_DEV_NUMBER);
				isapnp_cfg_end();
				return -ENOMEM;
			}
		}
Start --->
		dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
Error --->
		memset(dev->priv,0,sizeof(struct awc_private));
		if (!dev->priv) {
			printk(KERN_CRIT "aironet4x00: could not allocate device private, some unstability may follow\n");
			return -1;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/drm/radeon_bufs.c:135:radeon_addbufs_agp: ERROR:NULL:134:135: Passing unknown ptr "dev_private"! as arg 0 to call "memset"! set by 'drm_alloc':135
		init_waitqueue_head(&buf->dma_wait);
		buf->pid     = 0;

		buf->dev_priv_size = sizeof(drm_radeon_buf_priv_t);
		buf->dev_private   = drm_alloc(sizeof(drm_radeon_buf_priv_t),
Start --->
					       DRM_MEM_BUFS);
Error --->
		memset(buf->dev_private, 0, buf->dev_priv_size);

#if DRM_DMA_HISTOGRAM
		buf->time_queued     = 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/aironet4500_card.c:561:awc4500_isa_probe: ERROR:NULL:560:561: Passing unknown ptr "priv"! as arg 0 to call "memset"! set by 'kmalloc':561
			if (!dev) {
				release_region(isa_ioaddr, AIRONET4X00_IO_SIZE);
				return (card == 0) ? -ENOMEM : 0;
			}
		}
Start --->
		dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
Error --->
		memset(dev->priv,0,sizeof(struct awc_private));
		if (!dev->priv) {
			printk(KERN_CRIT "aironet4x00: could not allocate device private, some unstability may follow\n");
			return -1;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/qnx4/inode.c:321:qnx4_checkroot: ERROR:NULL:320:321: Passing unknown ptr "BitMap"! as arg 0 to call "memcpy"! set by 'kmalloc':321
				rootdir = (struct qnx4_inode_entry *) (bh->b_data + i * QNX4_DIR_ENTRY_SIZE);
				if (rootdir->di_fname != NULL) {
					QNX4DEBUG(("Rootdir entry found : [%s]\n", rootdir->di_fname));
					if (!strncmp(rootdir->di_fname, QNX4_BMNAME, sizeof QNX4_BMNAME)) {
						found = 1;
Start --->
						sb->u.qnx4_sb.BitMap = kmalloc( sizeof( struct qnx4_inode_entry ), GFP_KERNEL );
Error --->
						memcpy( sb->u.qnx4_sb.BitMap, rootdir, sizeof( struct qnx4_inode_entry ) );	/* keep bitmap inode known */
						break;
					}
				}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/rio/riotable.c:975:RIOReMapPorts: ERROR:NULL:974:975: Passing unknown ptr "TxRingBuffer"! as arg 0 to call "memset"! set by 'kmalloc':975
		PortP->closes = 0;
		PortP->ioctls = 0;
		if ( PortP->TxRingBuffer )
			bzero( PortP->TxRingBuffer, p->RIOBufferSize );
		else if ( p->RIOBufferSize ) {
Start --->
			PortP->TxRingBuffer = sysbrk(p->RIOBufferSize);
Error --->
			bzero( PortP->TxRingBuffer, p->RIOBufferSize );
		}
		PortP->TxBufferOut	= 0;
		PortP->TxBufferIn	 = 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/mtd/mtdram.c:118:init_mtdram: ERROR:NULL:117:118: Passing unknown ptr "priv"! as arg 0 to call "memset"! set by 'vmalloc':118
   mtd_info->name = "mtdram test device";
   mtd_info->type = MTD_RAM;
   mtd_info->flags = MTD_CAP_RAM;
   mtd_info->size = MTDRAM_TOTAL_SIZE;
   mtd_info->erasesize = MTDRAM_ERASE_SIZE;
Start --->
   mtd_info->priv = vmalloc(MTDRAM_TOTAL_SIZE);
Error --->
   memset(mtd_info->priv, 0xff, MTDRAM_TOTAL_SIZE);

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
   mtd_info->module = THIS_MODULE;			
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/drm/r128_bufs.c:138:r128_addbufs_agp: ERROR:NULL:137:138: Passing unknown ptr "dev_private"! as arg 0 to call "memset"! set by 'drm_alloc':138
		init_waitqueue_head(&buf->dma_wait);
		buf->pid     = 0;

		buf->dev_priv_size = sizeof(drm_r128_buf_priv_t);
		buf->dev_private   = drm_alloc(sizeof(drm_r128_buf_priv_t),
Start --->
					       DRM_MEM_BUFS);
Error --->
		memset(buf->dev_private, 0, buf->dev_priv_size);

#if DRM_DMA_HISTOGRAM
		buf->time_queued     = 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/hisax/fsm.c:25:FsmNew: ERROR:NULL:24:25: Passing unknown ptr "jumpmatrix"! as arg 0 to call "memset"! set by 'kmalloc':25
FsmNew(struct Fsm *fsm, struct FsmNode *fnlist, int fncount)
{
	int i;

	fsm->jumpmatrix = (FSMFNPTR *)
Start --->
		kmalloc(sizeof (FSMFNPTR) * fsm->state_count * fsm->event_count, GFP_KERNEL);
Error --->
	memset(fsm->jumpmatrix, 0, sizeof (FSMFNPTR) * fsm->state_count * fsm->event_count);

	for (i = 0; i < fncount; i++) 
		if ((fnlist[i].state>=fsm->state_count) || (fnlist[i].event>=fsm->event_count)) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/wan/sdla_fr.c:1337:if_open: ERROR:NULL:1336:1337: Passing unknown ptr "bh_head"! as arg 0 to call "memset"! set by 'kmalloc':1337
	chan->common.wanpipe_task.sync = 0;
	chan->common.wanpipe_task.routine = (void *)(void *)fr_bh;
	chan->common.wanpipe_task.data = dev;

	/* Allocate and initialize BH circular buffer */
Start --->
	chan->bh_head = kmalloc((sizeof(bh_data_t)*MAX_BH_BUFF),GFP_ATOMIC);
Error --->
	memset(chan->bh_head,0,(sizeof(bh_data_t)*MAX_BH_BUFF));
	atomic_set(&chan->bh_buff_used, 0);
#endif

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/mtd/ftl.c:378:build_maps: ERROR:NULL:377:378: Passing unknown ptr "VirtualBlockMap"! as arg 0 to call "memset"! set by 'vmalloc':378
	return -1;
    }
    
    /* Set up virtual page map */
    blocks = le32_to_cpu(header.FormattedSize) >> header.BlockSize;
Start --->
    part->VirtualBlockMap = vmalloc(blocks * sizeof(u_int32_t));
Error --->
    memset(part->VirtualBlockMap, 0xff, blocks * sizeof(u_int32_t));
    part->BlocksPerUnit = (1 << header.EraseUnitSize) >> header.BlockSize;

    part->bam_cache = kmalloc(part->BlocksPerUnit * sizeof(u_int32_t),
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/drm/dma.c:42:drm_dma_setup: ERROR:NULL:41:42: Passing unknown ptr "dma"! as arg 0 to call "memset"! set by 'drm_alloc':42

void drm_dma_setup(drm_device_t *dev)
{
	int i;
	
Start --->
	dev->dma = drm_alloc(sizeof(*dev->dma), DRM_MEM_DRIVER);
Error --->
	memset(dev->dma, 0, sizeof(*dev->dma));
	for (i = 0; i <= DRM_MAX_ORDER; i++)
		memset(&dev->dma->bufs[i], 0, sizeof(dev->dma->bufs[0]));
}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/wan/sdla_chdlc.c:1067:if_open: ERROR:NULL:1066:1067: Passing unknown ptr "bh_head"! as arg 0 to call "memset"! set by 'kmalloc':1067
	chdlc_priv_area->common.wanpipe_task.routine = (void *)(void *)chdlc_bh;
	chdlc_priv_area->common.wanpipe_task.data = dev;

	/* Allocate and initialize BH circular buffer */
	/* Add 1 to MAX_BH_BUFF so we don't have test with (MAX_BH_BUFF-1) */
Start --->
	chdlc_priv_area->bh_head = kmalloc((sizeof(bh_data_t)*(MAX_BH_BUFF+1)),GFP_ATOMIC);
Error --->
	memset(chdlc_priv_area->bh_head,0,(sizeof(bh_data_t)*(MAX_BH_BUFF+1)));
	atomic_set(&chdlc_priv_area->bh_buff_used, 0);
#endif
 
---------------------------------------------------------
[BUG] proc_mkdir can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/scsi_proc.c:128:build_proc_dir_entries: ERROR:NULL:127:128: Using unknown ptr "proc_dir" illegally! set by 'proc_mkdir':128
void build_proc_dir_entries(Scsi_Host_Template * tpnt)
{
	struct Scsi_Host *hpnt;
	char name[10];	/* see scsi_unregister_host() */

Start --->
	tpnt->proc_dir = proc_mkdir(tpnt->proc_name, proc_scsi);
Error --->
	tpnt->proc_dir->owner = tpnt->module;

	hpnt = scsi_hostlist;
	while (hpnt) {
---------------------------------------------------------
[BUG] create_proc_entry
/u2/engler/mc/oses/linux/2.4.4-ac8/arch/i386/kernel/irq.c:1183:init_irq_proc: ERROR:NULL:1181:1183: Using unknown ptr "entry" illegally! set by 'create_proc_entry':1183 [nbytes = 76] 

	/* create /proc/irq */
	root_irq_dir = proc_mkdir("irq", 0);

	/* create /proc/irq/prof_cpu_mask */
Start --->
	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);

Error --->
	entry->nlink = 1;
	entry->data = (void *)&prof_cpu_mask;
	entry->read_proc = prof_cpu_mask_read_proc;
	entry->write_proc = prof_cpu_mask_write_proc;
---------------------------------------------------------
[BUG] make_entry
/u2/engler/mc/oses/linux/2.4.4-ac8/net/atm/lec.c:1895:lec_vcc_added: ERROR:NULL:1892:1895: Using unknown ptr "entry" illegally! set by 'make_entry':1895 [nbytes = 124] 
                        ioc_data->atm_addr[10],ioc_data->atm_addr[11],
                        ioc_data->atm_addr[12],ioc_data->atm_addr[13],
                        ioc_data->atm_addr[14],ioc_data->atm_addr[15],
                        ioc_data->atm_addr[16],ioc_data->atm_addr[17],
                        ioc_data->atm_addr[18],ioc_data->atm_addr[19]);
Start --->
                entry = make_entry(priv, bus_mac);
                memcpy(entry->atm_addr, ioc_data->atm_addr, ATM_ESA_LEN);
                memset(entry->mac_addr, 0, ETH_ALEN);
Error --->
                entry->recv_vcc = vcc;
                entry->old_recv_push = old_push;
                entry->status = ESI_UNKNOWN;
                entry->timer.expires = jiffies + priv->vcc_timeout_period;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/wan/sdla_fr.c:4194:send_inarp_request: ERROR:NULL:4192:4194: Using unknown ptr "ArpPacket" illegally! set by 'kmalloc':4194 [nbytes = 8] 

	in_dev = dev->ip_ptr;

	if(in_dev != NULL ) {	

Start --->
		ArpPacket = kmalloc(sizeof(arphdr_1490_t) + sizeof(arphdr_fr_t), GFP_ATOMIC);
		/* SNAP Header indicating ARP */
Error --->
		ArpPacket->control	= 0x03;
		ArpPacket->pad		= 0x00;
		ArpPacket->NLPID	= 0x80;
		ArpPacket->OUI[0]	= 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/hosts.c:173:scsi_register: ERROR:NULL:171:173: Passing unknown ptr "name"! as arg 0 to call "strncpy"! set by 'kmalloc':173
    if(j > 0xffff) panic("Too many extra bytes requested\n");
    retval->extra_bytes = j;
    retval->loaded_as_module = 1;
    if (flag_new) {
	shn = (Scsi_Host_Name *) kmalloc(sizeof(Scsi_Host_Name), GFP_ATOMIC);
Start --->
	shn->name = kmalloc(hname_len + 1, GFP_ATOMIC);
	if (hname_len > 0)
Error --->
	    strncpy(shn->name, hname, hname_len);
	shn->name[hname_len] = 0;
	shn->host_no = max_scsi_hosts++;
	shn->host_registered = 1;
---------------------------------------------------------
[BUG] __idetape_kmalloc_stage can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/ide-tape.c:3477:idetape_onstream_read_back_buffer: ERROR:NULL:3474:3477: Using unknown ptr "stage" illegally! set by '__idetape_kmalloc_stage':3477 [nbytes = 100] 
	idetape_update_stats(drive);
	frames = tape->cur_frames;
	logical_blk_num = ntohl(tape->first_stage->aux->logical_blk_num) - frames;
	printk(KERN_INFO "ide-tape: %s: reading back %d frames from the drive's internal buffer\n", tape->name, frames);
	for (i = 0; i < frames; i++) {
Start --->
		stage = __idetape_kmalloc_stage(tape, 0, 0);
		if (!first)
			first = stage;
Error --->
		aux = stage->aux;
		p = stage->bh->b_data;
		idetape_queue_rw_tail(drive, IDETAPE_READ_BUFFER_RQ, tape->capabilities.ctl, stage->bh);
#if ONSTREAM_DEBUG
---------------------------------------------------------
[BUG] bread
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/reiserfs/journal.c:1661:journal_read: ERROR:NULL:1658:1661: Using unknown ptr "d_bh" illegally! set by 'bread':1661 [nbytes = 96] 

  /* ok, there are transactions that need to be replayed.  start with the first log block, find
  ** all the valid transactions, and pick out the oldest.
  */
  while(continue_replay && cur_dblock < (reiserfs_get_journal_block(p_s_sb) + JOURNAL_BLOCK_COUNT)) {
Start --->
    d_bh = bread(p_s_sb->s_dev, cur_dblock, p_s_sb->s_blocksize) ;
    ret = journal_transaction_is_valid(p_s_sb, d_bh, &oldest_invalid_trans_id, &newest_mount_id) ;
    if (ret == 1) {
Error --->
      desc = (struct reiserfs_journal_desc *)d_bh->b_data ;
      if (oldest_start == 0) { /* init all oldest_ values */
        oldest_trans_id = le32_to_cpu(desc->j_trans_id) ;
	oldest_start = d_bh->b_blocknr ;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/locks.c:701:locks_mandatory_area: ERROR:NULL:698:701: Using unknown ptr "new_fl" illegally! set by 'locks_alloc_lock':701 [nbytes = 92] 
int locks_mandatory_area(int read_write, struct inode *inode,
			 struct file *filp, loff_t offset,
			 size_t count)
{
	struct file_lock *fl;
Start --->
	struct file_lock *new_fl = locks_alloc_lock(0);
	int error;

Error --->
	new_fl->fl_owner = current->files;
	new_fl->fl_pid = current->pid;
	new_fl->fl_file = filp;
	new_fl->fl_flags = FL_POSIX | FL_ACCESS;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/eql.c:425:eql_enslave: ERROR:NULL:422:425: Using unknown ptr "s" illegally! set by 'eql_new_slave':425 [nbytes = 24] 
                {
			/*slave is not a master & not already a slave:*/
			if (! eql_is_master (slave_dev)  &&
			    ! eql_is_slave (slave_dev) )
			{
Start --->
				slave_t *s = eql_new_slave ();
				equalizer_t *eql = 
					(equalizer_t *) master_dev->priv;
Error --->
				s->dev = slave_dev;
				s->priority = srq.priority;
				s->priority_bps = srq.priority;
				s->priority_Bps = srq.priority / 8;
---------------------------------------------------------
[BUG] osst_do_scsi can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/osst.c:1244:osst_reposition_and_retry: ERROR:NULL:1238:1244: Using unknown ptr "SRpnt" illegally! set by 'osst_do_scsi':1244 [nbytes = 216] 
#if DEBUG
			printk(OSST_DEB_MSG "osst%d: About to write pending lblk %d at frame %d\n",
					  dev, STp->logical_blk_num-1, STp->first_frame_position);
#endif
			SRpnt = osst_do_scsi(SRpnt, STp, cmd, OS_FRAME_SIZE, SCSI_DATA_WRITE,
Start --->
						    STp->timeout, MAX_WRITE_RETRIES, TRUE);
			*aSRpnt = SRpnt;

			if (STp->buffer->syscall_result) {		/* additional write error */
				if ((SRpnt->sr_sense_buffer[ 2] & 0x0f) == 13 &&
				     SRpnt->sr_sense_buffer[12]         ==  0 &&
Error --->
				     SRpnt->sr_sense_buffer[13]         ==  2) {
					printk(OSST_DEB_MSG
					       "osst%d: Volume overflow in write error recovery\n",
					       dev);
---------------------------------------------------------
[BUG] iget can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/nfsd/nfsfh.c:146:nfsd_iget: ERROR:NULL:137:146: Using unknown ptr "inode" illegally! set by 'iget':146 [nbytes = 468] 
	 * of 0 means "accept any"
	 */
	struct inode *inode;
	struct list_head *lp;
	struct dentry *result;
Start --->
	inode = iget(sb, ino);
	if (is_bad_inode(inode)
	    || (generation && inode->i_generation != generation)
		) {
		/* we didn't find the right inode.. */
		dprintk("fh_verify: Inode %lu, Bad count: %d %d or version  %u %u\n",
			inode->i_ino,
			inode->i_nlink, atomic_read(&inode->i_count),
			inode->i_generation,
Error --->
			generation);

		iput(inode);
		return ERR_PTR(-ESTALE);
---------------------------------------------------------
[BUG]  funny -- looks like atype on the check.
/u2/engler/mc/oses/linux/2.4.4-ac8/net/sched/sch_gred.c:446:gred_change: ERROR:NULL:441:446: Passing unknown ptr "table"! as arg 0 to call "memset"! set by 'kmalloc':446
        	over-written 
		*/

		if (table->tab[table->def] == NULL) {
			table->tab[table->def]=
Start --->
				kmalloc(sizeof(struct gred_sched_data), GFP_KERNEL);
			if (NULL == table->tab[ctl->DP])
				return -ENOMEM;

			memset(table->tab[table->def], 0,
Error --->
			       (sizeof(struct gred_sched_data)));
		}
		q= table->tab[table->def]; 
		q->DP=table->def;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/ide-probe.c:768:init_gendisk: ERROR:NULL:763:768: Passing unknown ptr "part"! as arg 0 to call "memset"! set by 'kmalloc':768
			break;
	}
	minors    = units * (1<<PARTN_BITS);
	gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
Start --->
	gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
	bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
	max_sect  = kmalloc (minors*sizeof(int), GFP_KERNEL);
	max_ra    = kmalloc (minors*sizeof(int), GFP_KERNEL);

Error --->
	memset(gd->part, 0, minors * sizeof(struct hd_struct));

	/* cdroms and msdos f/s are examples of non-1024 blocksizes */
	blksize_size[hwif->major] = bs;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/ide-probe.c:66:do_identify: ERROR:NULL:60:66: Using unknown ptr "id" illegally! set by 'kmalloc':66
static inline void do_identify (ide_drive_t *drive, byte cmd)
{
	int bswap = 1;
	struct hd_driveid *id;

Start --->
	id = drive->id = kmalloc (SECTOR_WORDS*4, GFP_ATOMIC);	/* called with interrupts disabled! */
	ide_input_data(drive, id, SECTOR_WORDS);		/* read 512 bytes of id info */
	ide__sti();	/* local CPU only */
	ide_fix_driveid(id);

	if (id->word156 == 0x4d42) {
Error --->
		printk("%s: drive->id->word156 == 0x%04x \n", drive->name, drive->id->word156);
	}

	if (!drive->forced_lun)
---------------------------------------------------------
[BUG] the usual print and then segfaul.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/epca.c:2193:post_fep_init: ERROR:NULL:2187:2193: Passing NULL ptr "tmp_buf"! as arg 0 to call "memset"! set by 'kmalloc':2193
		ch->blocked_open = 0;
		ch->callout_termios = pc_callout.init_termios;
		ch->normal_termios = pc_driver.init_termios;
		init_waitqueue_head(&ch->open_wait);
		init_waitqueue_head(&ch->close_wait);
Start --->
		ch->tmp_buf = kmalloc(ch->txbufsize,GFP_KERNEL);
		if (!(ch->tmp_buf))
		{
			printk(KERN_ERR "POST FEP INIT : kmalloc failed for port 0x%x\n",i);

		}
Error --->
		memset((void *)ch->tmp_buf,0,ch->txbufsize);
	} /* End for each port */

	printk(KERN_INFO 
---------------------------------------------------------
[BUG] check for failure then fall through
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/media/video/bttv-driver.c:899:make_clip_tab: ERROR:NULL:891:899: Passing NULL ptr "clipmap"! as arg 0 to call "memcpy"! set by 'vmalloc':899 [nbytes = 1] 

	if (bttv_debug)
		printk("bttv%d: clip: ro=%08lx re=%08lx\n",
		       btv->nr,virt_to_bus(ro), virt_to_bus(re));

Start --->
	if ((clipmap=vmalloc(VIDEO_CLIPMAP_SIZE))==NULL) {
		/* can't clip, don't generate any risc code */
		*(ro++)=cpu_to_le32(BT848_RISC_JUMP);
		*(ro++)=cpu_to_le32(btv->bus_vbi_even);
		*(re++)=cpu_to_le32(BT848_RISC_JUMP);
		*(re++)=cpu_to_le32(btv->bus_vbi_odd);
	}
	if (ncr < 0) {	/* bitmap was pased */
Error --->
		memcpy(clipmap, (unsigned char *)cr, VIDEO_CLIPMAP_SIZE);
	} else {	/* convert rectangular clips to a bitmap */
		memset(clipmap, 0, VIDEO_CLIPMAP_SIZE); /* clear map */
		for (i=0; i<ncr; i++)
---------------------------------------------------------
[BUG] hpfs_map_anode
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/hpfs/anode.c:299:hpfs_remove_btree: ERROR:NULL:285:299: Using unknown ptr "anode" illegally! set by 'hpfs_map_anode':299 [nbytes = 512] 
		ano = btree1->u.internal[pos].down;
		if (level) brelse(bh);
		if (s->s_hpfs_chk)
			if (hpfs_stop_cycles(s, ano, &d1, &d2, "hpfs_remove_btree #1"))
				return;
Start --->
		anode = hpfs_map_anode(s, ano, &bh);
		btree1 = &anode->btree;
		level++;
		pos = 0;
	}
	for (i = 0; i < btree1->n_used_nodes; i++)
		hpfs_free_sectors(s, btree1->u.external[i].disk_secno, btree1->u.external[i].length);
	go_up:
	if (!level) return;
	if (s->s_hpfs_chk)
		if (hpfs_stop_cycles(s, ano, &c1, &c2, "hpfs_remove_btree #2")) return;
	brelse(bh);
	hpfs_free_sectors(s, ano, 1);
	oano = ano;
Error --->
	ano = anode->up;
	if (--level) {
		anode = hpfs_map_anode(s, ano, &bh);
		btree1 = &anode->btree;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/media/video/bttv-driver.c:901:make_clip_tab: ERROR:NULL:891:901: Passing NULL ptr "clipmap"! as arg 0 to call "memset"! set by 'vmalloc':901 [nbytes = 1] 

	if (bttv_debug)
		printk("bttv%d: clip: ro=%08lx re=%08lx\n",
		       btv->nr,virt_to_bus(ro), virt_to_bus(re));

Start --->
	if ((clipmap=vmalloc(VIDEO_CLIPMAP_SIZE))==NULL) {
		/* can't clip, don't generate any risc code */
		*(ro++)=cpu_to_le32(BT848_RISC_JUMP);
		*(ro++)=cpu_to_le32(btv->bus_vbi_even);
		*(re++)=cpu_to_le32(BT848_RISC_JUMP);
		*(re++)=cpu_to_le32(btv->bus_vbi_odd);
	}
	if (ncr < 0) {	/* bitmap was pased */
		memcpy(clipmap, (unsigned char *)cr, VIDEO_CLIPMAP_SIZE);
	} else {	/* convert rectangular clips to a bitmap */
Error --->
		memset(clipmap, 0, VIDEO_CLIPMAP_SIZE); /* clear map */
		for (i=0; i<ncr; i++)
			clip_draw_rectangle(clipmap, cr[i].x, cr[i].y,
				cr[i].width, cr[i].height);
---------------------------------------------------------
[BUG] function will not quit if "instance" is invalid
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/g_NCR5380.c:404:generic_NCR5380_detect: ERROR:NULL:392:404: Using unknown ptr "instance" illegally! set by 'scsi_register':404 [nbytes = 124] 
		NCR5380_region_size))
		continue;
	request_mem_region(overrides[current_override].NCR5380_map_name,
					NCR5380_region_size, "ncr5380");
#endif
Start --->
	instance = scsi_register (tpnt, sizeof(struct NCR5380_hostdata));
	if(instance == NULL)
	{
#ifdef CONFIG_SCSI_G_NCR5380_PORT
		release_region(overrides[current_override].NCR5380_map_name,
	                                        NCR5380_region_size);
#else
		release_mem_region(overrides[current_override].NCR5380_map_name,
	                                  	NCR5380_region_size);
#endif
	}
	
Error --->
	instance->NCR5380_instance_name = overrides[current_override].NCR5380_map_name;

	NCR5380_init(instance, flags);

---------------------------------------------------------
[BUG] iget can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/nfsd/nfsfh.c:155:nfsd_iget: ERROR:NULL:137:155: Using unknown ptr "inode" illegally! set by 'iget':155 [nbytes = 468] 
	 * of 0 means "accept any"
	 */
	struct inode *inode;
	struct list_head *lp;
	struct dentry *result;
Start --->
	inode = iget(sb, ino);

	... DELETED 12 lines ...

	}
	/* now to find a dentry.
	 * If possible, get a well-connected one
	 */
	spin_lock(&dcache_lock);
Error --->
	for (lp = inode->i_dentry.next; lp != &inode->i_dentry ; lp=lp->next) {
		result = list_entry(lp,struct dentry, d_alias);
		if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED)) {
			dget_locked(result);
---------------------------------------------------------
[BUG] same
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/sd.c:780:sd_init_onedisk: ERROR:NULL:764:780: Using unknown ptr "SRpnt" illegally! set by 'scsi_allocate_request':780 [nbytes = 216] 
	 * We need to retry the READ_CAPACITY because a UNIT_ATTENTION is
	 * considered a fatal error, and many devices report such an error
	 * just after a scsi bus reset.
	 */

Start --->
	SRpnt = scsi_allocate_request(rscsi_disks[i].device);

	... DELETED 10 lines ...

		while (retries < 3) {
			cmd[0] = TEST_UNIT_READY;
			cmd[1] = (rscsi_disks[i].device->scsi_level <= SCSI_2) ?
				 ((rscsi_disks[i].device->lun << 5) & 0xe0) : 0;
			memset((void *) &cmd[2], 0, 8);
Error --->
			SRpnt->sr_cmd_len = 0;
			SRpnt->sr_sense_buffer[0] = 0;
			SRpnt->sr_sense_buffer[2] = 0;
			SRpnt->sr_data_direction = SCSI_DATA_READ;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/jffs/intrep.c:348:jffs_checksum_flash: ERROR:NULL:332:348: Using unknown ptr "read_buf" illegally! set by 'kmalloc':348 [nbytes = 1] 
	loff_t ptr = start;
	__u8 *read_buf;
	int i, length;

	/* Allocate read buffer */
Start --->
	read_buf = (__u8 *) kmalloc (sizeof(__u8) * 4096, GFP_KERNEL);

	... DELETED 10 lines ...

		D3(printk(KERN_NOTICE "jffs_checksum_flash\n"));
		flash_safe_read(mtd, ptr, &read_buf[0], length);

		/* Compute checksum */
		for (i=0; i < length ; i++)
Error --->
			sum += read_buf[i];

		/* Update pointer and size */
		size -= length;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/sr.c:686:get_capabilities: ERROR:NULL:667:686: Using unknown ptr "buffer" illegally! set by 'scsi_malloc':686 [nbytes = 1] 
		"cartridge changer",
		"",
		""
	};

Start --->
	buffer = (unsigned char *) scsi_malloc(512);

	... DELETED 13 lines ...

					 CDC_SELECT_DISC | CDC_SELECT_SPEED);
		scsi_free(buffer, 512);
		printk("sr%i: scsi-1 drive\n", i);
		return;
	}
Error --->
	n = buffer[3] + 4;
	scsi_CDs[i].cdi.speed = ((buffer[n + 8] << 8) + buffer[n + 9]) / 176;
	scsi_CDs[i].readcd_known = 1;
	scsi_CDs[i].readcd_cdda = buffer[n + 5] & 0x01;
---------------------------------------------------------
[BUG] data dependency on scsi_result
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/scsi_scan.c:311:scan_scsis: ERROR:NULL:287:311: Using unknown ptr "SDpnt" illegally! set by 'kmalloc':311 [nbytes = 260] 
	int lun0_sl;

	scsi_result = NULL;

	SDpnt = (Scsi_Device *) kmalloc(sizeof(Scsi_Device),
Start --->
					GFP_ATOMIC);

	... DELETED 18 lines ...

		goto leave;
	}
	/*
	 * We must chain ourself in the host_queue, so commands can time out 
	 */
Error --->
	SDpnt->queue_depth = 1;
	SDpnt->host = shpnt;
	SDpnt->online = TRUE;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/jffs/intrep.c:633:jffs_scan_flash: ERROR:NULL:607:633: Using unknown ptr "read_buf" illegally! set by 'kmalloc':633 [nbytes = 1] 
		  (long)pos, (long)end));

	flash_safe_acquire(fmc->mtd);

	/* Allocate read buffer */
Start --->
	read_buf = (__u8 *) kmalloc (sizeof(__u8) * 4096, GFP_KERNEL);

	... DELETED 20 lines ...


			retlen &= ~3;

			for (i=0 ; i < retlen ; i+=4, pos += 4) {
				if(*((__u32 *) &read_buf[i]) !=
Error --->
						JFFS_EMPTY_BITMASK)
					break;
			}
			if (i == retlen)
---------------------------------------------------------
[BUG] same with the previous one
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/sd.c:803:sd_init_onedisk: ERROR:NULL:764:803: Using unknown ptr "SRpnt" illegally! set by 'scsi_allocate_request':803 [nbytes = 216] 
	 * We need to retry the READ_CAPACITY because a UNIT_ATTENTION is
	 * considered a fatal error, and many devices report such an error
	 * just after a scsi bus reset.
	 */

Start --->
	SRpnt = scsi_allocate_request(rscsi_disks[i].device);

	... DELETED 33 lines ...

		 * this crap.
		 */
		if( the_result != 0
		    && ((driver_byte(the_result) & DRIVER_SENSE) != 0)
		    && SRpnt->sr_sense_buffer[2] == UNIT_ATTENTION
Error --->
		    && SRpnt->sr_sense_buffer[12] == 0x3A ) {
			rscsi_disks[i].capacity = 0x1fffff;
			sector_size = 512;
			rscsi_disks[i].device->changed = 1;
---------------------------------------------------------
[BUG] scsi_allocate_request can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/sd.c:814:sd_init_onedisk: ERROR:NULL:764:814: Using unknown ptr "SRpnt" illegally! set by 'scsi_allocate_request':814 [nbytes = 216] 
	 * We need to retry the READ_CAPACITY because a UNIT_ATTENTION is
	 * considered a fatal error, and many devices report such an error
	 * just after a scsi bus reset.
	 */

Start --->
	SRpnt = scsi_allocate_request(rscsi_disks[i].device);

	... DELETED 44 lines ...

		}

		/* Look for non-removable devices that return NOT_READY.
		 * Issue command to spin up drive for these cases. */
		if (the_result && !rscsi_disks[i].device->removable &&
Error --->
		    SRpnt->sr_sense_buffer[2] == NOT_READY) {
			unsigned long time1;
			if (!spintime) {
				printk("%s: Spinning up disk...", nbuff);
---------------------------------------------------------
[BUG] 
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/sd.c:856:sd_init_onedisk: ERROR:NULL:766:856: Passing unknown ptr "buffer"! as arg 0 to call "memset"! set by 'scsi_malloc':856 [nbytes = 1] 
	 * just after a scsi bus reset.
	 */

	SRpnt = scsi_allocate_request(rscsi_disks[i].device);

Start --->
	buffer = (unsigned char *) scsi_malloc(512);

	... DELETED 84 lines ...

	do {
		cmd[0] = READ_CAPACITY;
		cmd[1] = (rscsi_disks[i].device->scsi_level <= SCSI_2) ?
			 ((rscsi_disks[i].device->lun << 5) & 0xe0) : 0;
		memset((void *) &cmd[2], 0, 8);
Error --->
		memset((void *) buffer, 0, 8);
		SRpnt->sr_cmd_len = 0;
		SRpnt->sr_sense_buffer[0] = 0;
		SRpnt->sr_sense_buffer[2] = 0;
---------------------------------------------------------
[BUG] scsi_allocate_request can return NULL
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/sd.c:857:sd_init_onedisk: ERROR:NULL:764:857: Using unknown ptr "SRpnt" illegally! set by 'scsi_allocate_request':857 [nbytes = 216] 
	 * We need to retry the READ_CAPACITY because a UNIT_ATTENTION is
	 * considered a fatal error, and many devices report such an error
	 * just after a scsi bus reset.
	 */

Start --->
	SRpnt = scsi_allocate_request(rscsi_disks[i].device);

	... DELETED 87 lines ...

		cmd[0] = READ_CAPACITY;
		cmd[1] = (rscsi_disks[i].device->scsi_level <= SCSI_2) ?
			 ((rscsi_disks[i].device->lun << 5) & 0xe0) : 0;
		memset((void *) &cmd[2], 0, 8);
		memset((void *) buffer, 0, 8);
Error --->
		SRpnt->sr_cmd_len = 0;
		SRpnt->sr_sense_buffer[0] = 0;
		SRpnt->sr_sense_buffer[2] = 0;

---------------------------------------------------------
[BUG] GEM this is bizarre
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/eata_dma.c:1249:register_HBA: ERROR:NULL:1139:1249: Using unknown ptr "buff" illegally! set by 'get_board_data':1249 [nbytes = 1] 
	set_dma_mode(dma_channel, DMA_MODE_CASCADE);
	enable_dma(dma_channel);
    }

    if (bustype != IS_EISA && bustype != IS_ISA)
Start --->
	buff = get_board_data(base, gc->IRQ, gc->scsi_id[3]);

	... DELETED 104 lines ...

    } else {	
	strncpy(hd->vendor, &buff[8], 8);
	hd->vendor[8] = 0;
	strncpy(hd->name, &buff[16], 17);
	hd->name[17] = 0;
Error --->
	hd->revision[0] = buff[32];
	hd->revision[1] = buff[33];
	hd->revision[2] = buff[34];
	hd->revision[3] = '.';
---------------------------------------------------------
[BUG] When kmalloc fails, pB could be NULL. It has a printk call
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/ip2main.c:889:old_ip2_init: ERROR:NULL:739:889: Using unknown ptr "pB" illegally! set by 'kmalloc':889 [nbytes = 1016] 
			break;
		}	/* switch */
	}	/* for */
	for ( i = 0; i < IP2_MAX_BOARDS; ++i ) {
		if ( ip2config.addr[i] ) {
Start --->
			pB = kmalloc( sizeof(i2eBordStr), GFP_KERNEL);

	... DELETED 144 lines ...


			for ( box = 0; box < ABS_MAX_BOXES; ++box )
			{
			    for ( j = 0; j < ABS_BIGGEST_BOX; ++j )
			    {
Error --->
				if ( pB->i2eChannelMap[box] & (1 << j) )
				{
				    tty_register_devfs(&ip2_tty_driver,
					0, j + ABS_BIGGEST_BOX *

