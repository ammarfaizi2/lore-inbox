Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131595AbRCQJcJ>; Sat, 17 Mar 2001 04:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131599AbRCQJbx>; Sat, 17 Mar 2001 04:31:53 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:51374 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S131595AbRCQJbl>; Sat, 17 Mar 2001 04:31:41 -0500
Date: Sat, 17 Mar 2001 01:30:54 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: <linux-kernel@vger.kernel.org>
cc: <mc@cs.stanford.edu>
Subject: [CHECKER] 120 potential dereference to invalid pointers errors for
 linux 2.4.1
Message-ID: <Pine.GSO.4.31.0103170126540.14147-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This checker warns when the pointer returned by a "plausibly" failing
routine is not checked before being used.

It automatically builds up the list of failing routines by examining
all callsites.  If a function's returned pointer is checked at more
than one callsite, the checker ensures it is always checked.
(Functions like strtok or hash-table lookups are culled from this list
by hand.)

Sometimes we are unaware of preconditions that make such checks
unnecessary, so the "errors" might still have false positives.

Junfeng & Dawson

Where the errors are:
--------------------------------------+---------------------------------------------+
| file                                 | fn                                          |
+--------------------------------------+---------------------------------------------+
| arch/i386/kernel/irq.c               | init_irq_proc                               |
| arch/i386/kernel/irq.c               | register_irq_proc                           |
| arch/i386/kernel/mtrr.c              | mtrr_init                                   |
| drivers/acpi/dispatcher/dswload.c    | acpi_ds_load2_end_op                        |
| drivers/acpi/interpreter/amutils.c   | acpi_aml_build_copy_internal_package_object |
| drivers/acpi/parser/psparse.c        | acpi_ps_parse_loop                          |
| drivers/atm/fore200e.c               | fore200e_get_esi                            |
| drivers/atm/zatm.c                   | zatm_detect                                 |
| drivers/block/DAC960.c               | DAC960_V1_ExecuteType3                      |
| drivers/block/DAC960.c               | DAC960_V1_ExecuteType3D                     |
| drivers/block/DAC960.c               | DAC960_V2_ControllerInfo                    |
| drivers/block/DAC960.c               | DAC960_V2_DeviceOperation                   |
| drivers/block/DAC960.c               | DAC960_V2_GeneralInfo                       |
| drivers/block/DAC960.c               | DAC960_V2_LogicalDeviceInfo                 |
| drivers/block/DAC960.c               | DAC960_V2_PhysicalDeviceInfo                |
| drivers/block/DAC960.c               | DAC960_V2_ReadDeviceConfiguration           |
| drivers/block/ll_rw_blk.c            | blk_init_free_list                          |
| drivers/char/drm/context.c           | drm_alloc_queue                             |
| drivers/char/drm/fops.c              | drm_open_helper                             |
| drivers/char/drm/proc.c              | drm_proc_init                               |
| drivers/char/ip2main.c               | old_ip2_init                                |
| drivers/char/pc_keyb.c               | psaux_init                                  |
| drivers/char/rio/rio_linux.c         | rio_init_datastructures                     |
| drivers/i2o/i2o_core.c               | i2o_core_evt                                |
| drivers/ide/ide-probe.c              | init_gendisk                                |
| drivers/ide/ide-probe.c              | init_irq                                    |
| drivers/ide/ide-tape.c               | idetape_onstream_read_back_buffer           |
| drivers/isdn/avmb1/avm_cs.c          | avmcs_attach                                |
| drivers/isdn/avmb1/capi.c            | capinc_raw_write                            |
| drivers/isdn/avmb1/capi.c            | capi_write                                  |
| drivers/isdn/avmb1/capidrv.c         | if_readstat                                 |
| drivers/isdn/avmb1/capidrv.c         | if_sendbuf                                  |
| drivers/md/raid5.c                   | grow_buffers                                |
| drivers/md/raid5.c                   | __check_consistency                         |
| drivers/media/video/i2c-parport.c    | i2c_parport_attach                          |
| drivers/media/video/videodev.c       | videodev_proc_create_dev                    |
| drivers/net/3c505.c                  | receive_packet                              |
| drivers/net/3c515.c                  | corkscrew_found_device                      |
| drivers/net/aironet4500_card.c       | awc4500_isa_probe                           |
| drivers/net/aironet4500_card.c       | awc4500_pnp_probe                           |
| drivers/net/defxx.c                  | dfx_rcv_init                                |
| drivers/net/dgrs.c                   | dgrs_found_device                           |
| drivers/net/pcmcia/aironet4500_cs.c  | awc_attach                                  |
| drivers/net/pcmcia/wavelan_cs.c      | wavelan_attach                              |
| drivers/net/pcmcia/xircom_tulip_cb.c | tulip_probe1                                |
| drivers/net/skfp/ess.c               | ess_raf_received_pack                       |
| drivers/net/skfp/ess.c               | ess_send_response                           |
| drivers/net/smc9194.c                | smc_rcv                                     |
| drivers/net/sunhme.c                 | happy_meal_pci_init                         |
| drivers/net/tokenring/ibmtr.c        | ibmtr_probe1                                |
| drivers/net/tokenring/lanstreamer.c  | streamer_arb_cmd                            |
| drivers/net/tokenring/olympic.c      | olympic_arb_cmd                             |
| drivers/net/tokenring/olympic.c      | olympic_scan                                |
| drivers/net/tokenring/smctr.c        | smctr_process_rx_packet                     |
| drivers/net/tokenring/smctr.c        | smctr_rx_frame                              |
| drivers/net/tokenring/tms380tr.c     | tms380tr_rcv_status_irq                     |
| drivers/net/wan/comx-proto-fr.c      | fr_xmit                                     |
| drivers/net/wan/lmc/lmc_proto.c      | lmc_proto_init                              |
| drivers/pci/setup-res.c              | pdev_sort_resources                         |
| drivers/pcmcia/bulkmem.c             | setup_erase_request                         |
| drivers/pcmcia/bulkmem.c             | setup_regions                               |
| drivers/pcmcia/ds.c                  | bind_request                                |
| drivers/scsi/AM53C974.c              | AM53C974_init                               |
| drivers/scsi/gdth.c                  | gdth_halt                                   |
| drivers/scsi/gdth_proc.c             | gdth_get_info                               |
| drivers/scsi/g_NCR5380.c             | generic_NCR5380_detect                      |
| drivers/scsi/hosts.c                 | scsi_register                               |
| drivers/scsi/NCR53c406a.c            | NCR53c406a_detect                           |
| drivers/scsi/osst.c                  | osst_read_back_buffer_and_rewrite           |
| drivers/scsi/osst.c                  | osst_reposition_and_retry                   |
| drivers/scsi/pci2220i.c              | Pci2220i_Detect                             |
| drivers/scsi/qla1280.c               | qla1280_detect                              |
| drivers/scsi/qlogicfas.c             | qlogicfas_detect                            |
| drivers/scsi/qlogicfc.c              | isp2x00_detect                              |
| drivers/scsi/qlogicisp.c             | isp1020_detect                              |
| drivers/scsi/scsi_ioctl.c            | ioctl_internal_command                      |
| drivers/scsi/scsi_proc.c             | build_proc_dir_entries                      |
| drivers/scsi/scsi_scan.c             | scan_scsis                                  |
| drivers/scsi/scsi_scan.c             | scan_scsis_single                           |
| drivers/scsi/sd.c                    | sd_init_onedisk                             |
| drivers/scsi/sr_ioctl.c              | sr_do_ioctl                                 |
| drivers/scsi/ultrastor.c             | ultrastor_24f_detect                        |
| drivers/telephony/ixj.c              | ixj_attach                                  |
| drivers/usb/bluetooth.c              | bluetooth_read_bulk_callback                |
| drivers/usb/microtek.c               | mts_scsi_detect                             |
| drivers/video/sis/sis_main.c         | poh_new_node                                |
| fs/bfs/inode.c                       | bfs_read_super                              |
| fs/coda/sysctl.c                     | coda_sysctl_init                            |
| fs/coda/upcall.c                     | coda_upcall                                 |
| fs/hpfs/anode.c                      | hpfs_add_sector_to_btree                    |
| fs/hpfs/anode.c                      | hpfs_remove_btree                           |
| fs/hpfs/dir.c                        | hpfs_lookup                                 |
| fs/nfsd/nfsfh.c                      | nfsd_iget                                   |
| fs/ntfs/dir.c                        | ntfs_getdir_unsorted                        |
| fs/ntfs/inode.c                      | ntfs_extend_mft                             |
| fs/ntfs/inode.c                      | ntfs_new_inode                              |
| fs/reiserfs/journal.c                | journal_read                                |
| fs/udf/file.c                        | udf_adinicb_commit_write                    |
| fs/udf/file.c                        | udf_adinicb_readpage                        |
| fs/udf/file.c                        | udf_adinicb_writepage                       |
| fs/udf/namei.c                       | udf_symlink                                 |
| fs/udf/partition.c                   | udf_fill_spartable                          |
| fs/udf/super.c                       | udf_process_sequence                        |
| net/atm/lec.c                        | lec_arp_update                              |
| net/atm/lec.c                        | lec_vcc_added                               |
| net/bridge/br_stp.c                  | br_root_selection                           |
| net/bridge/br_stp.c                  | br_should_become_root_port                  |
| net/irda/irproc.c                    | irda_proc_register                          |
+--------------------------------------+---------------------------------------------+

Listing:
---------------------------------------------------------
[BUG] create_proc_entry
/u2/acc/oses/linux/2.4.1/arch/i386/kernel/irq.c:1160:init_irq_proc: ERROR:NULL:1158:1160: Using unknown ptr "entry" illegally! set by 'create_proc_entry':1158

Start --->
	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);

Error --->
	entry->nlink = 1;
	entry->data = (void *)&prof_cpu_mask;
---------------------------------------------------------
[BUG] create_proc_entry can return NULL
/u2/acc/oses/linux/2.4.1/arch/i386/kernel/irq.c:1139:register_irq_proc: ERROR:NULL:1137:1139: Using unknown ptr "entry" illegally! set by 'create_proc_entry':1137

Start --->
	entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);

Error --->
	entry->nlink = 1;
	entry->data = (void *)(long)irq;
---------------------------------------------------------
[BUG] create_proc_entry
/u2/acc/oses/linux/2.4.1/arch/i386/kernel/mtrr.c:2075:mtrr_init: ERROR:NULL:2074:2075: Using unknown ptr "proc_root_mtrr" illegally! set by 'create_proc_entry':2074

Start --->
    proc_root_mtrr = create_proc_entry ("mtrr", S_IWUSR | S_IRUGO, &proc_root);
Error --->
    proc_root_mtrr->owner = THIS_MODULE;
    proc_root_mtrr->proc_fops = &mtrr_fops;
---------------------------------------------------------
[BUG] acpi_ps_get_arg can return NULL
/u2/acc/oses/linux/2.4.1/drivers/acpi/dispatcher/dswload.c:467:acpi_ds_load2_end_op: ERROR:NULL:450:467: Using unknown ptr "arg" illegally! set by 'acpi_ps_get_arg':450

Start --->
			arg = acpi_ps_get_arg (op, 3);
		}
		else {
			/* Create Bit/Byte/Word/Dword field */


	... DELETED 9 lines ...

				 arg->value.string,
				 INTERNAL_TYPE_DEF_ANY,
				 IMODE_LOAD_PASS1,
				 NS_NO_UPSEARCH | NS_DONT_OPEN_SCOPE,
Error --->
				 walk_state, &(new_node));

---------------------------------------------------------
[BUG] same with the previous one
/u2/acc/oses/linux/2.4.1/drivers/acpi/dispatcher/dswload.c:467:acpi_ds_load2_end_op: ERROR:NULL:455:467: Using unknown ptr "arg" illegally! set by 'acpi_ps_get_arg':455

Start --->
			arg = acpi_ps_get_arg (op, 2);
		}

		/*
		 * Enter the Name_string into the namespace

	... DELETED 4 lines ...

				 arg->value.string,
				 INTERNAL_TYPE_DEF_ANY,
				 IMODE_LOAD_PASS1,
				 NS_NO_UPSEARCH | NS_DONT_OPEN_SCOPE,
Error --->
				 walk_state, &(new_node));

---------------------------------------------------------
[BUG] acpi_cm_create_internal_object can return NULL. Call chain is acpi_cm_create_internal_object -> _cm_allocate_object_desc -> _cm_callocate -> acpi_os_callocate -> acpi_os_allocate ->kmalloc
/u2/acc/oses/linux/2.4.1/drivers/acpi/interpreter/amutils.c:472:acpi_aml_build_copy_internal_package_object: ERROR:NULL:468:472: Using unknown ptr "this_dest_obj" illegally! set by '_cm_create_internal_object':468

Start --->
			this_dest_obj = acpi_cm_create_internal_object (ACPI_TYPE_PACKAGE);
			level_ptr->dest_obj->package.elements[this_index] = this_dest_obj;


Error --->
			this_dest_obj->common.type      = ACPI_TYPE_PACKAGE;
			this_dest_obj->package.count    = this_dest_obj->package.count;
---------------------------------------------------------
[BUG]  acpi_cm_create_internal_object can return NULL. Call chain is acpi_cm_create_internal_object -> _cm_allocate_object_desc -> _cm_callocate -> acpi_os_callocate -> acpi_os_allocate ->kmalloc
/u2/acc/oses/linux/2.4.1/drivers/acpi/interpreter/amutils.c:472:acpi_aml_build_copy_internal_package_object: ERROR:NULL:492:472: Using unknown ptr "this_dest_obj" illegally! set by '_cm_create_internal_object':492

Error --->
			this_dest_obj->common.type      = ACPI_TYPE_PACKAGE;
			this_dest_obj->package.count    = this_dest_obj->package.count;

			/*
			 * Save space for the array of objects (Package elements)

	... DELETED 12 lines ...

		}   /* if object is a package */

		else {

Start --->
			this_dest_obj = acpi_cm_create_internal_object (
					   this_source_obj->common.type);
---------------------------------------------------------
[BUG] if walk_state->descending_callback != NULL, op is unknown( line 710 )
/u2/acc/oses/linux/2.4.1/drivers/acpi/parser/psparse.c:655:acpi_ps_parse_loop: ERROR:NULL:681:655: Using NULL ptr "op" illegally! set by 'acpi_ps_alloc_op':681

Error --->
				if (op->opcode == AML_REGION_OP) {
					deferred_op = acpi_ps_to_extended_op (op);
					if (deferred_op) {
						/*
						 * Defer final parsing of an Operation_region body,

	... DELETED 18 lines ...


			else {
				/* Not a named opcode, just allocate Op and append to parent */

Start --->
				op = acpi_ps_alloc_op (opcode);
				if (!op) {
---------------------------------------------------------
[BUG] fore200e_kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/atm/fore200e.c:2032:fore200e_get_esi: ERROR:NULL:2020:2032: Using unknown ptr "prom" illegally! set by 'fore200e_kmalloc':2020

Start --->
    struct prom_data* prom = fore200e_kmalloc(sizeof(struct prom_data), GFP_KERNEL | GFP_DMA);
    int ok, i;

    ok = fore200e->bus->prom_read(fore200e, prom);
    if (ok < 0)

	... DELETED 4 lines ...

	   fore200e->name,
	   (prom->hw_revision & 0xFF) + '@',    /* probably meaningless with SBA boards */
	   prom->serial_number & 0xFFFF,
	   prom->mac_addr[ 2 ], prom->mac_addr[ 3 ], prom->mac_addr[ 4 ],
Error --->
	   prom->mac_addr[ 5 ], prom->mac_addr[ 6 ], prom->mac_addr[ 7 ]);

---------------------------------------------------------
[BUG] break the while loop, but not the for loop
/u2/acc/oses/linux/2.4.1/drivers/atm/zatm.c:1817:zatm_detect: ERROR:NULL:1804:1817: Using NULL ptr "zatm_dev" illegally! set by 'kmalloc':1804

Start --->
	    GFP_KERNEL);
	if (!zatm_dev) return -ENOMEM;
	devs = 0;
	for (type = 0; type < 2; type++) {
		struct pci_dev *pci_dev;

	... DELETED 5 lines ...

		    pci_dev))) {
			if (pci_enable_device(pci_dev)) break;
			dev = atm_dev_register(DEV_LABEL,&ops,-1,NULL);
			if (!dev) break;
Error --->
			zatm_dev->pci_dev = pci_dev;
			ZATM_DEV(dev) = zatm_dev;
---------------------------------------------------------
[BUG] DAC960_AllocateCommand can return NULL
/u2/acc/oses/linux/2.4.1/drivers/block/DAC960.c:512:DAC960_V1_ExecuteType3: ERROR:NULL:508:512: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':508

Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
  DAC960_V1_CommandStatus_T CommandStatus;
  DAC960_V1_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->Type3.CommandOpcode = CommandOpcode;
---------------------------------------------------------
[BUG]  DAC960_AllocateCommand
/u2/acc/oses/linux/2.4.1/drivers/block/DAC960.c:538:DAC960_V1_ExecuteType3D: ERROR:NULL:534:538: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':534

Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
  DAC960_V1_CommandStatus_T CommandStatus;
  DAC960_V1_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->Type3D.CommandOpcode = CommandOpcode;
---------------------------------------------------------
[BUG] DAC960_AllocateCommand
/u2/acc/oses/linux/2.4.1/drivers/block/DAC960.c:603:DAC960_V2_ControllerInfo: ERROR:NULL:599:603: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':599

Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
  DAC960_V2_CommandStatus_T CommandStatus;
  DAC960_V2_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->ControllerInfo.CommandOpcode = DAC960_V2_IOCTL;
---------------------------------------------------------
[BUG] DAC960_AllocateCommand
/u2/acc/oses/linux/2.4.1/drivers/block/DAC960.c:730:DAC960_V2_DeviceOperation: ERROR:NULL:726:730: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':726

Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
  DAC960_V2_CommandStatus_T CommandStatus;
  DAC960_V2_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->DeviceOperation.CommandOpcode = DAC960_V2_IOCTL;
---------------------------------------------------------
[BUG] DAC960_AllocateCommand
/u2/acc/oses/linux/2.4.1/drivers/block/DAC960.c:565:DAC960_V2_GeneralInfo: ERROR:NULL:561:565: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':561

Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
  DAC960_V2_CommandStatus_T CommandStatus;
  DAC960_V2_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->Common.CommandOpcode = DAC960_V2_IOCTL;
---------------------------------------------------------
[BUG] DAC960_AllocateCommand
/u2/acc/oses/linux/2.4.1/drivers/block/DAC960.c:645:DAC960_V2_LogicalDeviceInfo: ERROR:NULL:641:645: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':641

Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
  DAC960_V2_CommandStatus_T CommandStatus;
  DAC960_V2_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->LogicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
---------------------------------------------------------
[BUG] DAC960_AllocateCommand
/u2/acc/oses/linux/2.4.1/drivers/block/DAC960.c:689:DAC960_V2_PhysicalDeviceInfo: ERROR:NULL:685:689: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':685

Start --->
  DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
  DAC960_V2_CommandStatus_T CommandStatus;
  DAC960_V2_ClearCommand(Command);
Error --->
  Command->CommandType = DAC960_ImmediateCommand;
  CommandMailbox->PhysicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
---------------------------------------------------------
[BUG] DAC960_AllocateCommand
/u2/acc/oses/linux/2.4.1/drivers/block/DAC960.c:1442:DAC960_V2_ReadDeviceConfiguration: ERROR:NULL:1439:1442: Using unknown ptr "Command" illegally! set by 'DAC960_AllocateCommand':1439

Start --->
      Command = DAC960_AllocateCommand(Controller);
      CommandMailbox = &Command->V2.CommandMailbox;
      DAC960_V2_ClearCommand(Command);
Error --->
      Command->CommandType = DAC960_ImmediateCommand;
      CommandMailbox->SCSI_10.CommandOpcode = DAC960_V2_SCSI_10_Passthru;
---------------------------------------------------------
[BUG] kmem_cache_alloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/block/ll_rw_blk.c:399:blk_init_free_list: ERROR:NULL:397:399: Using unknown ptr "rq" illegally! set by 'kmem_cache_alloc':397

Start --->
		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
		memset(rq, 0, sizeof(struct request));
Error --->
		rq->rq_status = RQ_INACTIVE;
		list_add(&rq->table, &q->request_freelist[i & 1]);
---------------------------------------------------------
[BUG] drm_alloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/char/drm/context.c:98:drm_alloc_queue: ERROR:NULL:96:98: Using unknown ptr "queue" illegally! set by 'drm_alloc':96

Start --->
	queue = drm_alloc(sizeof(*queue), DRM_MEM_QUEUES);
	memset(queue, 0, sizeof(*queue));
Error --->
	atomic_set(&queue->use_count, 1);

---------------------------------------------------------
[BUG] drm_alloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/char/drm/fops.c:52:drm_open_helper: ERROR:NULL:49:52: Using unknown ptr "priv" illegally! set by 'drm_alloc':49

Start --->
	priv		    = drm_alloc(sizeof(*priv), DRM_MEM_FILES);
	memset(priv, 0, sizeof(*priv));
	filp->private_data  = priv;
Error --->
	priv->uid	    = current->euid;
	priv->pid	    = current->pid;
---------------------------------------------------------
[BUG] Function will not terminate if "drm_dev_root" is NULL. just printk
/u2/acc/oses/linux/2.4.1/drivers/char/drm/proc.c:96:drm_proc_init: ERROR:NULL:91:96: Using NULL ptr "drm_dev_root" illegally! set by 'create_proc_entry':91

Start --->
		drm_dev_root = create_proc_entry(drm_slot_name, S_IFDIR, NULL);
		if (!drm_dev_root) {
			DRM_ERROR("Cannot create /proc/%s\n", drm_slot_name);
			remove_proc_entry("dri", NULL);
		}
Error --->
		if (drm_dev_root->nlink == 2) break;
		drm_dev_root = NULL;
---------------------------------------------------------
[BUG] When kmalloc fails, pB could be NULL. It has a printk call
/u2/acc/oses/linux/2.4.1/drivers/char/ip2main.c:897:old_ip2_init: ERROR:NULL:747:897: Using NULL ptr "pB" illegally! set by 'kmalloc':747

Start --->
			pB = kmalloc( sizeof(i2eBordStr), GFP_KERNEL);
			if ( pB != NULL ) {
				i2BoardPtrTable[i] = pB;
				memset( pB, 0, sizeof(i2eBordStr) );
				iiSetAddress( pB, ip2config.addr[i], ii2DelayTimer );

	... DELETED 142 lines ...

			for ( box = 0; box < ABS_MAX_BOXES; ++box )
			{
			    for ( j = 0; j < ABS_BIGGEST_BOX; ++j )
			    {
Error --->
				if ( pB->i2eChannelMap[box] & (1 << j) )
				{
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/char/pc_keyb.c:1018:psaux_init: ERROR:NULL:1016:1018: Using unknown ptr "queue" illegally! set by 'kmalloc':1016

Start --->
	queue = (struct aux_queue *) kmalloc(sizeof(*queue), GFP_KERNEL);
	memset(queue, 0, sizeof(*queue));
Error --->
	queue->head = queue->tail = 0;
	init_waitqueue_head(&queue->proc_list);
---------------------------------------------------------
[BUG] at label free0, p has been freed, or p's allocation failed.
/u2/acc/oses/linux/2.4.1/drivers/char/rio/rio_linux.c:1038:rio_init_datastructures: ERROR:NULL:980:1038: Using NULL ptr "p" illegally! set by 'ckmalloc':980

Start --->
  if (!(p                  = ckmalloc (              RI_SZ))) goto free0;
  if (!(p->RIOHosts        = ckmalloc (RIO_HOSTS * HOST_SZ))) goto free1;
  if (!(p->RIOPortp        = ckmalloc (RIO_PORTS * PORT_SZ))) goto free2;
  if (!(rio_termios        = ckmalloc (RIO_PORTS * TMIO_SZ))) goto free3;
  if (!(rio_termios_locked = ckmalloc (RIO_PORTS * TMIO_SZ))) goto free4;

	... DELETED 50 lines ...

 free2:kfree (p->RIOHosts);
 free1:kfree (p);
 free0:
  rio_dprintk (RIO_DEBUG_INIT, "Not enough memory! %p %p %p %p %p\n",
Error --->
               p, p->RIOHosts, p->RIOPortp, rio_termios, rio_termios);
  return -ENOMEM;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/i2o/i2o_core.c:927:i2o_core_evt: ERROR:NULL:922:927: Using unknown ptr "d" illegally! set by 'kmalloc':922

Start --->
					kmalloc(sizeof(struct i2o_device), GFP_KERNEL);
				int i;

				memcpy(&d->lct_data, &msg[5], sizeof(i2o_lct_entry));

Error --->
				d->next = NULL;
				d->controller = c;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/ide/ide-probe.c:749:init_gendisk: ERROR:NULL:748:749: Using unknown ptr "gd" illegally! set by 'kmalloc':748

Start --->
	gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
Error --->
	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
	gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/ide/ide-probe.c:656:init_irq: ERROR:NULL:654:656: Using unknown ptr "hwgroup" illegally! set by 'kmalloc':654

Start --->
		hwgroup = kmalloc(sizeof(ide_hwgroup_t), GFP_KERNEL);
		memset(hwgroup, 0, sizeof(ide_hwgroup_t));
Error --->
		hwgroup->hwif     = hwif->next = hwif;
		hwgroup->rq       = NULL;
---------------------------------------------------------
[BUG] __idetape_kmalloc_stage can return NULL
/u2/acc/oses/linux/2.4.1/drivers/ide/ide-tape.c:3409:idetape_onstream_read_back_buffer: ERROR:NULL:3406:3409: Using unknown ptr "stage" illegally! set by '__idetape_kmalloc_stage':3406

Start --->
		stage = __idetape_kmalloc_stage(tape, 0, 0);
		if (!first)
			first = stage;
Error --->
		aux = stage->aux;
		p = stage->bh->b_data;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/isdn/avmb1/avm_cs.c:142:avmcs_attach: ERROR:NULL:140:142: Using unknown ptr "link" illegally! set by 'kmalloc':140

Start --->
    link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
    memset(link, 0, sizeof(struct dev_link_t));
Error --->
    link->release.function = &avmcs_release;
    link->release.data = (u_long)link;
---------------------------------------------------------
[BUG] alloc_skb can return NULL
/u2/acc/oses/linux/2.4.1/drivers/isdn/avmb1/capi.c:991:capi_write: ERROR:NULL:985:991: Using unknown ptr "skb" illegally! set by 'alloc_skb':985

Start --->
	skb = alloc_skb(count, GFP_USER);

	if ((retval = copy_from_user(skb_put(skb, count), buf, count))) {
		kfree_skb(skb);
		return retval;
	}
Error --->
	mlen = CAPIMSG_LEN(skb->data);
	if (CAPIMSG_CMD(skb->data) == CAPI_DATA_B3_REQ) {
---------------------------------------------------------
[BUG] alloc_skb can return NULL
/u2/acc/oses/linux/2.4.1/drivers/isdn/avmb1/capi.c:1422:capinc_raw_write: ERROR:NULL:1402:1422: Using unknown ptr "skb" illegally! set by 'alloc_skb':1402

Start --->
	skb = alloc_skb(CAPI_DATA_B3_REQ_LEN+count, GFP_USER);

	skb_reserve(skb, CAPI_DATA_B3_REQ_LEN);
	if ((retval = copy_from_user(skb_put(skb, count), buf, count))) {
		kfree_skb(skb);

	... DELETED 12 lines ...

		if (signal_pending(current))
			return -ERESTARTNOHAND;
	}
	skb_queue_tail(&mp->outqueue, skb);
Error --->
	mp->outbytes += skb->len;
	(void)handle_minor_send(mp);
---------------------------------------------------------
[BUG] pointer is invalid in error message
/u2/acc/oses/linux/2.4.1/drivers/isdn/avmb1/capidrv.c:2134:if_readstat: ERROR:NULL:2128:2134: Using NULL ptr "card" illegally! set by 'findcontrbydriverid':2128

Start --->
	capidrv_contr *card = findcontrbydriverid(id);
	int count;
	__u8 *p;

	if (!card) {
		printk(KERN_ERR "capidrv-%d: if_readstat called with invalid driverId %d!\n",
Error --->
		       card->contrnr, id);
		return -ENODEV;
---------------------------------------------------------
[BUG] pointer is invalid in error message
/u2/acc/oses/linux/2.4.1/drivers/isdn/avmb1/capidrv.c:2064:if_sendbuf: ERROR:NULL:2054:2064: Using NULL ptr "card" illegally! set by 'findcontrbydriverid':2054

Start --->
	capidrv_contr *card = findcontrbydriverid(id);
	capidrv_bchan *bchan;
	capidrv_ncci *nccip;
	int len = skb->len;
	size_t msglen;
	__u16 errcode;
	__u16 datahandle;

	if (!card) {
		printk(KERN_ERR "capidrv-%d: if_sendbuf called with invalid driverId %d!\n",
Error --->
		       card->contrnr, id);
		return 0;
---------------------------------------------------------
[BUG] alloc_page can return NULL
/u2/acc/oses/linux/2.4.1/drivers/md/raid5.c:1278:__check_consistency: ERROR:NULL:1277:1278: Using unknown ptr "b_page" illegally! set by 'alloc_pages':1277

Start --->
	tmp->b_page = alloc_page(GFP_KERNEL);
Error --->
	tmp->b_data = page_address(tmp->b_page);
	if (!tmp->b_data)
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/md/raid5.c:1276:__check_consistency: ERROR:NULL:1275:1276: Using unknown ptr "tmp" illegally! set by 'kmalloc':1275

Start --->
	tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
Error --->
	tmp->b_size = 4096;
	tmp->b_page = alloc_page(GFP_KERNEL);
---------------------------------------------------------
[BUG] alloc_pages can return NULL
/u2/acc/oses/linux/2.4.1/drivers/md/raid5.c:160:grow_buffers: ERROR:NULL:159:160: Using unknown ptr "page" illegally! set by 'alloc_pages':159

Start --->
		page = alloc_page(priority);
Error --->
		bh->b_data = page_address(page);
		if (!bh->b_data) {
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/media/video/i2c-parport.c:77:i2c_parport_attach: ERROR:NULL:76:77: Using unknown ptr "b" illegally! set by 'kmalloc':76

Start --->
				      GFP_KERNEL);
Error --->
  b->i2c = parport_i2c_bus_template;
  b->i2c.data = parport_get_port (port);
---------------------------------------------------------
[BUG] create_proc_entry can return NULL
/u2/acc/oses/linux/2.4.1/drivers/media/video/videodev.c:367:videodev_proc_create_dev: ERROR:NULL:366:367: Using unknown ptr "p" illegally! set by 'create_proc_entry':366

Start --->
	p = create_proc_entry(name, S_IFREG|S_IRUGO|S_IWUSR, video_dev_proc_entry);
Error --->
	p->data = vfd;
	p->read_proc = videodev_proc_read;
---------------------------------------------------------
[BUG] dev_alloc_skb can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/3c505.c:619:receive_packet: ERROR:NULL:598:619: Using NULL ptr "skb" illegally! set by 'dev_alloc_skb':598

Start --->
	skb = dev_alloc_skb(rlen + 2);

	if (!skb) {
		printk("%s: memory squeeze, dropping packet\n", dev->name);
		target = adapter->dma_buffer;

	... DELETED 13 lines ...

	/* if this happens, we die */
	if (test_and_set_bit(0, (void *) &adapter->dmaing))
		printk("%s: rx blocked, DMA in progress, dir %d\n", dev->name, adapter->current_dma.direction);

Error --->
	skb->dev = dev;
	adapter->current_dma.direction = 0;
---------------------------------------------------------
[BUG] init_etherdev could return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/3c515.c:604:corkscrew_found_device: ERROR:NULL:603:604: Using unknown ptr "dev" illegally! set by 'init_etherdev':603

Start --->
	dev = init_etherdev(dev, sizeof(struct corkscrew_private));
Error --->
	dev->base_addr = ioaddr;
	dev->irq = irq;
---------------------------------------------------------
[BUG] init_etherdev can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/aironet4500_card.c:537:awc4500_isa_probe: ERROR:NULL:535:537: Using unknown ptr "dev" illegally! set by 'init_etherdev':535

Start --->
			dev = init_etherdev(dev, 0 );
		}
Error --->
		dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
		memset(dev->priv,0,sizeof(struct awc_private));
---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.1/drivers/net/aironet4500_card.c:375:awc4500_pnp_probe: ERROR:NULL:373:375: Using unknown ptr "dev" illegally! set by 'init_etherdev':373

Start --->
			dev = init_etherdev(dev, 0 );
		}
Error --->
		dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
		memset(dev->priv,0,sizeof(struct awc_private));
---------------------------------------------------------
[BUG] dev_alloc_skb can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/defxx.c:2719:dfx_rcv_init: ERROR:NULL:2712:2719: Using unknown ptr "newskb" illegally! set by 'dev_alloc_skb':2712

Start --->
			newskb = dev_alloc_skb(NEW_SKB_SIZE);
			/*
			 * align to 128 bytes for compatibility with
			 * the old EISA boards.
			 */

			my_skb_align(newskb,128);
Error --->
			bp->descr_block_virt->rcv_data[i+j].long_1 = virt_to_bus(newskb->data);
			/*
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/dgrs.c:1258:dgrs_found_device: ERROR:NULL:1256:1258: Using unknown ptr "dev" illegally! set by 'kmalloc':1256

Start --->
	dev = (struct net_device *) kmalloc(dev_size, GFP_KERNEL);
	memset(dev, 0, dev_size);
Error --->
	dev->priv = ((void *)dev) + sizeof(struct net_device);
	priv = (DGRS_PRIV *)dev->priv;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/dgrs.c:1297:dgrs_found_device: ERROR:NULL:1294:1297: Using unknown ptr "devN" illegally! set by 'kmalloc':1294

Start --->
		devN = (struct net_device *) kmalloc(dev_size, GFP_KERNEL);
			/* Make it an exact copy of dev[0]... */
		memcpy(devN, dev, dev_size);
Error --->
		devN->priv = ((void *)devN) + sizeof(struct net_device);
		privN = (DGRS_PRIV *)devN->priv;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/aironet4500_cs.c:181:awc_attach: ERROR:NULL:179:181: Using unknown ptr "link" illegally! set by 'kmalloc':179

Start --->
	link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
	memset(link, 0, sizeof(struct dev_link_t));
Error --->
	link->dev = kmalloc(sizeof(struct dev_node_t), GFP_KERNEL);
	memset(link->dev, 0, sizeof(struct dev_node_t));
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/wavelan_cs.c:4463:wavelan_attach: ERROR:NULL:4458:4463: Using unknown ptr "dev" illegally! set by 'kmalloc':4458

Start --->
  dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
  memset(dev, 0x00, sizeof(struct net_device));
  link->priv = link->irq.Instance = dev;

  /* Allocate the wavelan-specific data structure. */
Error --->
  dev->priv = lp = (net_local *) kmalloc(sizeof(net_local), GFP_KERNEL);
  memset(lp, 0x00, sizeof(net_local));
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/wavelan_cs.c:4430:wavelan_attach: ERROR:NULL:4426:4430: Using unknown ptr "link" illegally! set by 'kmalloc':4426

Start --->
  link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
  memset(link, 0, sizeof(struct dev_link_t));

  /* Unused for the Wavelan */
Error --->
  link->release.function = &wv_pcmcia_release;
  link->release.data = (u_long) link;
---------------------------------------------------------
[BUG] dev could be NULL, then init_etherdev -> init_netdev will alloc a new device -- it could fail.
/u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/xircom_tulip_cb.c:559:tulip_probe1: ERROR:NULL:522:559: Using unknown ptr "dev" illegally! set by 'init_etherdev':522

Start --->
	dev = init_etherdev(dev, 0);

	pci_read_config_byte(pdev, PCI_REVISION_ID, &chip_rev);
	/* Bring the 21143 out of sleep mode.
	   Caution: Snooze mode does not work with some boards! */

	... DELETED 29 lines ...

			int value, boguscnt = 100000;
			do
				value = inl(ioaddr + CSR9);
			while (value < 0  && --boguscnt > 0);
Error --->
			dev->dev_addr[i] = value;
			sum += value & 0xff;
---------------------------------------------------------
[BUG] init_etherdev
/u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/xircom_tulip_cb.c:577:tulip_probe1: ERROR:NULL:522:577: Using unknown ptr "dev" illegally! set by 'init_etherdev':522

Start --->
	dev = init_etherdev(dev, 0);

	pci_read_config_byte(pdev, PCI_REVISION_ID, &chip_rev);
	/* Bring the 21143 out of sleep mode.
	   Caution: Snooze mode does not work with some boards! */

	... DELETED 47 lines ...

		/* No need to read the EEPROM. */
		put_unaligned(inl(ioaddr + 0xA4), (u32 *)dev->dev_addr);
		put_unaligned(inl(ioaddr + 0xA8), (u16 *)(dev->dev_addr + 4));
		for (i = 0; i < 6; i ++)
Error --->
			sum += dev->dev_addr[i];
	} else if (chip_idx == X3201_3) {
---------------------------------------------------------
[BUG] init_etherdev
/u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/xircom_tulip_cb.c:607:tulip_probe1: ERROR:NULL:522:607: Using unknown ptr "dev" illegally! set by 'init_etherdev':522

Start --->
	dev = init_etherdev(dev, 0);

	pci_read_config_byte(pdev, PCI_REVISION_ID, &chip_rev);
	/* Bring the 21143 out of sleep mode.
	   Caution: Snooze mode does not work with some boards! */

	... DELETED 77 lines ...

				 * This is it.  We have the data we want.
				 */
				for (j = 0; j < 6; j++) {
					outl(i + j + 4, ioaddr + CSR10);
Error --->
					dev->dev_addr[j] = inl(ioaddr + CSR9) & 0xff;
				}
---------------------------------------------------------
[BUG] init_etherdev
/u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/xircom_tulip_cb.c:636:tulip_probe1: ERROR:NULL:522:636: Using unknown ptr "dev" illegally! set by 'init_etherdev':522

Start --->
	dev = init_etherdev(dev, 0);

	pci_read_config_byte(pdev, PCI_REVISION_ID, &chip_rev);
	/* Bring the 21143 out of sleep mode.
	   Caution: Snooze mode does not work with some boards! */

	... DELETED 106 lines ...

			sa_offset = 2;		/* Grrr, damn Matrox boards. */
			multiport_cnt = 4;
		}
		for (i = 0; i < 6; i ++) {
Error --->
			dev->dev_addr[i] = ee_data[i + sa_offset];
			sum += ee_data[i + sa_offset];
---------------------------------------------------------
[BUG] init_etherdev
/u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/xircom_tulip_cb.c:642:tulip_probe1: ERROR:NULL:522:642: Using unknown ptr "dev" illegally! set by 'init_etherdev':522

Start --->
	dev = init_etherdev(dev, 0);

	pci_read_config_byte(pdev, PCI_REVISION_ID, &chip_rev);
	/* Bring the 21143 out of sleep mode.
	   Caution: Snooze mode does not work with some boards! */

	... DELETED 112 lines ...

		}
	}
	/* Lite-On boards have the address byte-swapped. */
	if ((dev->dev_addr[0] == 0xA0  ||  dev->dev_addr[0] == 0xC0)
Error --->
		&&  dev->dev_addr[1] == 0x00)
		for (i = 0; i < 6; i+=2) {
---------------------------------------------------------
[BUG] sm_to_para can return NULL. But the start line is not correct.
/u2/acc/oses/linux/2.4.1/drivers/net/skfp/ess.c:191:ess_raf_received_pack: ERROR:NULL:145:191: Using unknown ptr "p" illegally! set by 'sm_to_para':145

Start --->
	if (!(p = (void *) sm_to_para(smc,sm,SMT_P0015))) {
		DB_ESS("ESS: RAF frame error, parameter type not found\n",0,0) ;
		return(fs) ;
	}
	msg_res_type = ((struct smt_p_0015 *)p)->res_type ;

	... DELETED 38 lines ...

				return(fs) ;

			p = (void *) sm_to_para(smc,sm,SMT_P0019)  ;
			for (i = 0; i < 5; i++) {
Error --->
				if (((struct smt_p_0019 *)p)->alloc_addr.a[i]) {
					return(fs) ;
---------------------------------------------------------
[BUG] sm_to_para can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/skfp/ess.c:539:ess_send_response: ERROR:NULL:538:539: Using unknown ptr "p" illegally! set by 'sm_to_para':538

Start --->
		p = (void *) sm_to_para(smc,sm,SMT_P001A) ;
Error --->
		chg->cat.category = ((struct smt_p_001a *)p)->category ;
	}
---------------------------------------------------------
[BUG] function doesn't exit if skb == NULL. just printk
/u2/acc/oses/linux/2.4.1/drivers/net/smc9194.c:1356:smc_rcv: ERROR:NULL:1341:1356: Using NULL ptr "skb" illegally! set by 'dev_alloc_skb':1341

Start --->
		skb = dev_alloc_skb( packet_length + 5);

		if ( skb == NULL ) {
			printk(KERN_NOTICE CARDNAME
			": Low memory, packet dropped.\n");

	... DELETED 7 lines ...

		*/

		skb_reserve( skb, 2 );   /* 16 bit alignment */

Error --->
		skb->dev = dev;
		data = skb_put( skb, packet_length);
---------------------------------------------------------
[BUG] init_etherdev can return NULL if dev is NULL
/u2/acc/oses/linux/2.4.1/drivers/net/sunhme.c:2838:happy_meal_pci_init: ERROR:NULL:2806:2838: Using unknown ptr "dev" illegally! set by 'init_etherdev':2806

Start --->
		dev = init_etherdev(0, sizeof(struct happy_meal));
	} else {
		dev->priv = kmalloc(sizeof(struct happy_meal), GFP_KERNEL);
		if (dev->priv == NULL)
			return -ENOMEM;

	... DELETED 24 lines ...

	else
		printk(KERN_INFO "%s: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet ",
		       dev->name);

Error --->
	dev->base_addr = (long) pdev;

---------------------------------------------------------
[BUG] dev could be NULL, then init_trdev will call init_netdev to allocate a new device.
/u2/acc/oses/linux/2.4.1/drivers/net/tokenring/ibmtr.c:405:ibmtr_probe1: ERROR:NULL:304:405: Using unknown ptr "dev" illegally! set by 'init_trdev':304

Start --->
	dev = init_trdev(dev,0);
#endif
#endif

	/*	Query the adapter PIO base port which will return

	... DELETED 93 lines ...

	ti->readlog_pending = 0;
	init_waitqueue_head(&ti->wait_for_tok_int);
	init_waitqueue_head(&ti->wait_for_reset);

Error --->
	dev->priv = ti;     /* this seems like the logical use of the
                         field ... let's try some empirical tests
---------------------------------------------------------
[BUG] dev_alloc_skb can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/tokenring/lanstreamer.c:1429:streamer_arb_cmd: ERROR:NULL:1386:1429: Using unknown ptr "mac_frame" illegally! set by 'dev_alloc_skb':1386

Start --->
		mac_frame = dev_alloc_skb(frame_len);

		/* Walk the buffer chain, creating the frame */

		do {

	... DELETED 35 lines ...

		       dev->name, mac_hdr->saddr[0], mac_hdr->saddr[1],
		       mac_hdr->saddr[2], mac_hdr->saddr[3],
		       mac_hdr->saddr[4], mac_hdr->saddr[5]);
#endif
Error --->
		mac_frame->dev = dev;
		mac_frame->protocol = tr_type_trans(mac_frame, dev);
---------------------------------------------------------
[BUG] dev_alloc_skb can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/tokenring/olympic.c:1276:olympic_arb_cmd: ERROR:NULL:1258:1276: Using unknown ptr "mac_frame" illegally! set by 'dev_alloc_skb':1258

Start --->
		mac_frame = dev_alloc_skb(frame_len) ;

		/* Walk the buffer chain, creating the frame */

		do {

	... DELETED 10 lines ...

		mac_hdr = (struct trh_hdr *)mac_frame->data ;
		printk(KERN_WARNING "%s: MAC Frame Dest. Addr: %02x:%02x:%02x:%02x:%02x:%02x \n", dev->name , mac_hdr->daddr[0], mac_hdr->daddr[1], mac_hdr->daddr[2], mac_hdr->daddr[3], mac_hdr->daddr[4], mac_hdr->daddr[5]) ;
		printk(KERN_WARNING "%s: MAC Frame Srce. Addr: %02x:%02x:%02x:%02x:%02x:%02x \n", dev->name , mac_hdr->saddr[0], mac_hdr->saddr[1], mac_hdr->saddr[2], mac_hdr->saddr[3], mac_hdr->saddr[4], mac_hdr->saddr[5]) ;
#endif
Error --->
		mac_frame->dev = dev ;
		mac_frame->protocol = tr_type_trans(mac_frame,dev);
---------------------------------------------------------
[BUG] init_trdev can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/tokenring/olympic.c:219:olympic_scan: ERROR:NULL:217:219: Using unknown ptr "dev" illegally! set by 'init_trdev':217

Start --->
			dev=init_trdev(dev, 0);
#endif
Error --->
			dev->priv=(void *)olympic_priv;
#if OLYMPIC_DEBUG
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/tokenring/olympic.c:226:olympic_scan: ERROR:NULL:212:226: Using unknown ptr "olympic_priv" illegally! set by 'kmalloc':212

Start --->
			olympic_priv=kmalloc(sizeof (struct olympic_private), GFP_KERNEL);
			memset(olympic_priv, 0, sizeof(struct olympic_private));
			init_waitqueue_head(&olympic_priv->srb_wait);
			init_waitqueue_head(&olympic_priv->trb_wait);
#ifndef MODULE

	... DELETED 6 lines ...

#endif
			dev->irq=pci_device->irq;
			dev->base_addr=pci_resource_start(pci_device, 0);
			dev->init=&olympic_init;
Error --->
			olympic_priv->olympic_card_name = (char *)pci_device->resource[0].name ;
			olympic_priv->olympic_mmio =
---------------------------------------------------------
[BUG] dev_alloc_skb can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/tokenring/smctr.c:3956:smctr_process_rx_packet: ERROR:NULL:3955:3956: Using unknown ptr "skb" illegally! set by 'dev_alloc_skb':3955

Start --->
                skb = dev_alloc_skb(size);
Error --->
                skb->len = size;

---------------------------------------------------------
[BUG] dev_alloc_skb can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/tokenring/smctr.c:4633:smctr_rx_frame: ERROR:NULL:4630:4633: Using unknown ptr "skb" illegally! set by 'dev_alloc_skb':4630

Start --->
                                skb = dev_alloc_skb(rx_size);
                                skb_put(skb, rx_size);

Error --->
                                memcpy(skb->data, pbuff, rx_size);
                                sti();
---------------------------------------------------------
[BUG] dev_alloc_skb can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/tokenring/tms380tr.c:2167:tms380tr_rcv_status_irq: ERROR:NULL:2149:2167: Using NULL ptr "skb" illegally! set by 'dev_alloc_skb':2149

Start --->
					skb = dev_alloc_skb(tp->MaxPacketSize);
					if(skb == NULL)
					{
						/* Update Stats ?? */
					}

	... DELETED 10 lines ...

				if(rpl->SkbStat == SKB_DATA_COPY
					|| rpl->SkbStat == SKB_DMA_DIRECT)
				{
					if(rpl->SkbStat == SKB_DATA_COPY)
Error --->
						memmove(skb->data, ReceiveDataPtr, Length);

---------------------------------------------------------
[BUG] dev_alloc_skb can return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/tokenring/tms380tr.c:2172:tms380tr_rcv_status_irq: ERROR:NULL:2149:2172: Using NULL ptr "skb" illegally! set by 'dev_alloc_skb':2149

Start --->
					skb = dev_alloc_skb(tp->MaxPacketSize);
					if(skb == NULL)
					{
						/* Update Stats ?? */
					}

	... DELETED 15 lines ...


					/* Deliver frame to system */
					rpl->Skb = NULL;
					skb_trim(skb,Length);
Error --->
					skb->protocol = tr_type_trans(skb,dev);
					netif_rx(skb);
---------------------------------------------------------
[BUG] skb_clone could return NULL
/u2/acc/oses/linux/2.4.1/drivers/net/wan/comx-proto-fr.c:506:fr_xmit: ERROR:NULL:505:506: Using unknown ptr "newskb" illegally! set by 'skb_clone':505

Start --->
		struct sk_buff *newskb=skb_clone(skb, GFP_ATOMIC);
Error --->
		newskb->dev=fr->master;
		dev_queue_xmit(newskb);
---------------------------------------------------------
[BUG] kmalloc
/u2/acc/oses/linux/2.4.1/drivers/net/wan/lmc/lmc_proto.c:106:lmc_proto_init: ERROR:NULL:105:106: Using unknown ptr "pd" illegally! set by 'kmalloc':105

Start --->
        sc->pd = kmalloc(sizeof(struct ppp_device), GFP_KERNEL);
Error --->
        sc->pd->dev = sc->lmc_device;
#endif
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/pci/setup-res.c:166:pdev_sort_resources: ERROR:NULL:165:166: Using unknown ptr "tmp" illegally! set by 'kmalloc':165

Start --->
				tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
Error --->
				tmp->next = ln;
				tmp->res = r;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/pcmcia/bulkmem.c:231:setup_erase_request: ERROR:NULL:230:231: Using unknown ptr "busy" illegally! set by 'kmalloc':230

Start --->
	    busy = kmalloc(sizeof(erase_busy_t), GFP_KERNEL);
Error --->
	    busy->erase = erase;
	    busy->client = handle;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/pcmcia/bulkmem.c:362:setup_regions: ERROR:NULL:361:362: Using unknown ptr "r" illegally! set by 'kmalloc':361

Start --->
	    r = kmalloc(sizeof(*r), GFP_KERNEL);
Error --->
	    r->region_magic = REGION_MAGIC;
	    r->state = 0;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/pcmcia/ds.c:417:bind_request: ERROR:NULL:416:417: Using unknown ptr "b" illegally! set by 'kmalloc':416

Start --->
    b = kmalloc(sizeof(socket_bind_t), GFP_KERNEL);
Error --->
    b->driver = driver;
    b->function = bind_info->function;
---------------------------------------------------------
[BUG] scsi_register
/u2/acc/oses/linux/2.4.1/drivers/scsi/AM53C974.c:683:AM53C974_init: ERROR:NULL:681:683: Using unknown ptr "instance" illegally! set by 'scsi_register':681

Start --->
	instance = scsi_register(tpnt, sizeof(struct AM53C974_hostdata));
	hostdata = (struct AM53C974_hostdata *) instance->hostdata;
Error --->
	instance->base = 0;
	instance->io_port = pci_resource_start(pdev, 0);
---------------------------------------------------------
[BUG] scsi_register could return NULL
/u2/acc/oses/linux/2.4.1/drivers/scsi/NCR53c406a.c:573:NCR53c406a_detect: ERROR:NULL:572:573: Using unknown ptr "shpnt" illegally! set by 'scsi_register':572

Start --->
    shpnt = scsi_register(tpnt, 0);
Error --->
    shpnt->irq = irq_level;
    shpnt->io_port = port_base;
---------------------------------------------------------
[BUG] function will not quit if "instance" is invalid
/u2/acc/oses/linux/2.4.1/drivers/scsi/g_NCR5380.c:407:generic_NCR5380_detect: ERROR:NULL:395:407: Using NULL ptr "instance" illegally! set by 'scsi_register':395

Start --->
	instance = scsi_register (tpnt, sizeof(struct NCR5380_hostdata));
	if(instance == NULL)
	{
#ifdef CONFIG_SCSI_G_NCR5380_PORT
		release_region(overrides[current_override].NCR5380_map_name,

	... DELETED 4 lines ...

	                                  	NCR5380_region_size);
#endif
	}

Error --->
	instance->NCR5380_instance_name = overrides[current_override].NCR5380_map_name;

---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.1/drivers/scsi/gdth.c:3630:gdth_halt: ERROR:NULL:3629:3630: Using unknown ptr "scp" illegally! set by 'scsi_allocate_device':3629

Start --->
	scp  = scsi_allocate_device(sdev, 1, FALSE);
Error --->
        scp->cmd_len = 12;
        scp->use_sg = 0;
---------------------------------------------------------
[BUG] scsi_allocate_device can return NULL
/u2/acc/oses/linux/2.4.1/drivers/scsi/gdth_proc.c:431:gdth_get_info: ERROR:NULL:430:431: Using unknown ptr "scp" illegally! set by 'scsi_allocate_device':430

Start --->
    scp  = scsi_allocate_device(sdev, 1, FALSE);
Error --->
    scp->cmd_len = 12;
    scp->use_sg = 0;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/scsi/hosts.c:171:scsi_register: ERROR:NULL:170:171: Using unknown ptr "shn" illegally! set by 'kmalloc':170

Start --->
	shn = (Scsi_Host_Name *) kmalloc(sizeof(Scsi_Host_Name), GFP_ATOMIC);
Error --->
	shn->name = kmalloc(hname_len + 1, GFP_ATOMIC);
	if (hname_len > 0)
---------------------------------------------------------
[BUG] osst_do_scsi will never return NULL if argument SRpnt isn't NULL. But they copy SRpnt back by *aSRpnt, implies it could be NULL
/u2/acc/oses/linux/2.4.1/drivers/scsi/osst.c:1145:osst_read_back_buffer_and_rewrite: ERROR:NULL:1042:1145: Using unknown ptr "SRpnt" illegally! set by 'osst_do_scsi':1042

Start --->
					    STp->timeout, MAX_RETRIES, TRUE);

		if ((STp->buffer)->syscall_result) {
			printk(KERN_ERR "osst%d: Failed to read block back from OnStream buffer\n", dev);
			vfree((void *)buffer);

	... DELETED 95 lines ...

					SRpnt = osst_do_scsi(SRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout,
									 MAX_READY_RETRIES, TRUE);

					if (SRpnt->sr_sense_buffer[2] == 2 && SRpnt->sr_sense_buffer[12] == 4 &&
Error --->
					    (SRpnt->sr_sense_buffer[13] == 1 || SRpnt->sr_sense_buffer[13] == 8)) {
						/* in the process of becoming ready */
---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.1/drivers/scsi/osst.c:1145:osst_read_back_buffer_and_rewrite: ERROR:NULL:1111:1145: Using unknown ptr "SRpnt" illegally! set by 'osst_do_scsi':1111

Start --->
					    STp->timeout, MAX_WRITE_RETRIES, TRUE);

		if (STp->buffer->syscall_result)
			flag = 1;
		else {

	... DELETED 26 lines ...

					SRpnt = osst_do_scsi(SRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout,
									 MAX_READY_RETRIES, TRUE);

					if (SRpnt->sr_sense_buffer[2] == 2 && SRpnt->sr_sense_buffer[12] == 4 &&
Error --->
					    (SRpnt->sr_sense_buffer[13] == 1 || SRpnt->sr_sense_buffer[13] == 8)) {
						/* in the process of becoming ready */
---------------------------------------------------------
[BUG] osst_do_scsi can return NULL
/u2/acc/oses/linux/2.4.1/drivers/scsi/osst.c:1243:osst_reposition_and_retry: ERROR:NULL:1237:1243: Using unknown ptr "SRpnt" illegally! set by 'osst_do_scsi':1237

Start --->
						    STp->timeout, MAX_WRITE_RETRIES, TRUE);
			*aSRpnt = SRpnt;

			if (STp->buffer->syscall_result) {		/* additional write error */
				if ((SRpnt->sr_sense_buffer[ 2] & 0x0f) == 13 &&
				     SRpnt->sr_sense_buffer[12]         ==  0 &&
Error --->
				     SRpnt->sr_sense_buffer[13]         ==  2) {
					printk(OSST_DEB_MSG
---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.1/drivers/scsi/pci2220i.c:2659:Pci2220i_Detect: ERROR:NULL:2650:2659: Using unknown ptr "pshost" illegally! set by 'scsi_register':2650

Start --->
		pshost = scsi_register (tpnt, sizeof(ADAPTER2220I));
		padapter = HOSTDATA(pshost);

		if ( GetRegs (pshost, TRUE, pcidev) )
			goto unregister1;

		for ( z = 0;  z < BIGD_MAXDRIVES;  z++ )
			DiskMirror[z].status = inb_p (padapter->regScratchPad + BIGD_RAID_0_STATUS + z);

Error --->
		pshost->max_id = padapter->numberOfDrives;
		padapter->failRegister = inb_p (padapter->regScratchPad + BIGD_ALARM_IMAGE);
---------------------------------------------------------
[BUG] scsi_register can return NULL
/u2/acc/oses/linux/2.4.1/drivers/scsi/qla1280.c:819:qla1280_detect: ERROR:NULL:812:819: Using unknown ptr "host" illegally! set by 'scsi_register':812

Start --->
		host = scsi_register(template, sizeof(scsi_qla_host_t));
		ha = (scsi_qla_host_t *) host->hostdata;
		/* Clear our data area */
		for( j =0, cp = (char *)ha;  j < sizeof(scsi_qla_host_t); j++)
			*cp = 0;
		/* Sanitize the information from PCI BIOS.  */
#if LINUX_VERSION_CODE > KERNEL_VERSION(2,1,95)
Error --->
		host->irq = pdev->irq;
		host->io_port = pci_resource_start(pdev, 0);
---------------------------------------------------------
[BUG] scsi_register
/u2/acc/oses/linux/2.4.1/drivers/scsi/qlogicfas.c:621:qlogicfas_detect: ERROR:NULL:620:621: Using unknown ptr "hreg" illegally! set by 'scsi_register':620

Start --->
	hreg = scsi_register( host , 0 );	/* no host data */
Error --->
	hreg->io_port = qbase;
	hreg->n_io_port = 16;
---------------------------------------------------------
[BUG] scsi_register
/u2/acc/oses/linux/2.4.1/drivers/scsi/qlogicfc.c:762:isp2x00_detect: ERROR:NULL:761:762: Using unknown ptr "host" illegally! set by 'scsi_register':761

Start --->
		        host = scsi_register(tmpt, sizeof(struct isp2x00_hostdata));
Error --->
			host->max_id = QLOGICFC_MAX_ID + 1;
			host->max_lun = QLOGICFC_MAX_LUN;
---------------------------------------------------------
[BUG] scsi_register
/u2/acc/oses/linux/2.4.1/drivers/scsi/qlogicisp.c:702:isp1020_detect: ERROR:NULL:684:702: Using unknown ptr "host" illegally! set by 'scsi_register':684

Start --->
		host = scsi_register(tmpt, sizeof(struct isp1020_hostdata));
		hostdata = (struct isp1020_hostdata *) host->hostdata;

		memset(hostdata, 0, sizeof(struct isp1020_hostdata));


	... DELETED 10 lines ...

		    || isp1020_set_defaults(host)
#endif /* USE_NVRAM_DEFAULTS */
		    || isp1020_load_parameters(host)) {
			iounmap((void *)hostdata->memaddr);
Error --->
			release_region(host->io_port, 0xff);
			goto fail_and_unregister;
---------------------------------------------------------
[BUG] scsi_register
/u2/acc/oses/linux/2.4.1/drivers/scsi/qlogicisp.c:706:isp1020_detect: ERROR:NULL:684:706: Using unknown ptr "host" illegally! set by 'scsi_register':684

Start --->
		host = scsi_register(tmpt, sizeof(struct isp1020_hostdata));
		hostdata = (struct isp1020_hostdata *) host->hostdata;

		memset(hostdata, 0, sizeof(struct isp1020_hostdata));


	... DELETED 14 lines ...

			release_region(host->io_port, 0xff);
			goto fail_and_unregister;
		}

Error --->
		host->this_id = hostdata->host_param.initiator_scsi_id;

---------------------------------------------------------
[BUG] Propagated unchecked kmalloc from scsi_allocate_request
/u2/acc/oses/linux/2.4.1/drivers/scsi/scsi_ioctl.c:106:ioctl_internal_command: ERROR:NULL:104:106: Using unknown ptr "SRpnt" illegally! set by 'scsi_allocate_request':104

Start --->
	SRpnt = scsi_allocate_request(dev);

Error --->
	SRpnt->sr_data_direction = SCSI_DATA_NONE;
        scsi_wait_req(SRpnt, cmd, NULL, 0, timeout, retries);
---------------------------------------------------------
[BUG] proc_mkdir can return NULL
/u2/acc/oses/linux/2.4.1/drivers/scsi/scsi_proc.c:124:build_proc_dir_entries: ERROR:NULL:123:124: Using unknown ptr "proc_dir" illegally! set by 'proc_mkdir':123

Start --->
	tpnt->proc_dir = proc_mkdir(tpnt->proc_name, proc_scsi);
Error --->
	tpnt->proc_dir->owner = tpnt->module;

---------------------------------------------------------
[BUG] data dependency on scsi_result
/u2/acc/oses/linux/2.4.1/drivers/scsi/scsi_scan.c:302:scan_scsis: ERROR:NULL:278:302: Using NULL ptr "SDpnt" illegally! set by 'kmalloc':278

Start --->
					GFP_ATOMIC);
	if (SDpnt) {
		memset(SDpnt, 0, sizeof(Scsi_Device));
		/*
		 * Register the queue for the device.  All I/O requests will

	... DELETED 16 lines ...

	}
	/*
	 * We must chain ourself in the host_queue, so commands can time out
	 */
Error --->
	SDpnt->queue_depth = 1;
	SDpnt->host = shpnt;
---------------------------------------------------------
[BUG] Propagated unchecked kmalloc from scsi_allocate_request
/u2/acc/oses/linux/2.4.1/drivers/scsi/scsi_scan.c:513:scan_scsis_single: ERROR:NULL:495:513: Using unknown ptr "SRpnt" illegally! set by 'scsi_allocate_request':495

Start --->
	SRpnt = scsi_allocate_request(SDpnt);

	/*
	 * We used to do a TEST_UNIT_READY before the INQUIRY but that was
	 * not really necessary.  Spec recommends using INQUIRY to scan for

	... DELETED 10 lines ...

	scsi_cmd[2] = 0;
	scsi_cmd[3] = 0;
	scsi_cmd[4] = 255;
	scsi_cmd[5] = 0;
Error --->
	SRpnt->sr_cmd_len = 0;
	SRpnt->sr_data_direction = SCSI_DATA_READ;
---------------------------------------------------------
[BUG] scsi_allocate_request can return NULL
/u2/acc/oses/linux/2.4.1/drivers/scsi/sd.c:751:sd_init_onedisk: ERROR:NULL:736:751: Using unknown ptr "SRpnt" illegally! set by 'scsi_allocate_request':736

Start --->
	SRpnt = scsi_allocate_request(rscsi_disks[i].device);

	buffer = (unsigned char *) scsi_malloc(512);

	spintime = 0;

	... DELETED 7 lines ...

		while (retries < 3) {
			cmd[0] = TEST_UNIT_READY;
			cmd[1] = (rscsi_disks[i].device->lun << 5) & 0xe0;
			memset((void *) &cmd[2], 0, 8);
Error --->
			SRpnt->sr_cmd_len = 0;
			SRpnt->sr_sense_buffer[0] = 0;
---------------------------------------------------------
[BUG] scsi_allocate_request can return NULL
/u2/acc/oses/linux/2.4.1/drivers/scsi/sd.c:774:sd_init_onedisk: ERROR:NULL:736:774: Using unknown ptr "SRpnt" illegally! set by 'scsi_allocate_request':736

Start --->
	SRpnt = scsi_allocate_request(rscsi_disks[i].device);

	buffer = (unsigned char *) scsi_malloc(512);

	spintime = 0;

	... DELETED 30 lines ...

		 */
		if( the_result != 0
		    && ((driver_byte(the_result) & DRIVER_SENSE) != 0)
		    && SRpnt->sr_sense_buffer[2] == UNIT_ATTENTION
Error --->
		    && SRpnt->sr_sense_buffer[12] == 0x3A ) {
			rscsi_disks[i].capacity = 0x1fffff;
---------------------------------------------------------
[BUG] same with the previous one
/u2/acc/oses/linux/2.4.1/drivers/scsi/sd.c:785:sd_init_onedisk: ERROR:NULL:736:785: Using unknown ptr "SRpnt" illegally! set by 'scsi_allocate_request':736

Start --->
	SRpnt = scsi_allocate_request(rscsi_disks[i].device);

	buffer = (unsigned char *) scsi_malloc(512);

	spintime = 0;

	... DELETED 41 lines ...


		/* Look for non-removable devices that return NOT_READY.
		 * Issue command to spin up drive for these cases. */
		if (the_result && !rscsi_disks[i].device->removable &&
Error --->
		    SRpnt->sr_sense_buffer[2] == NOT_READY) {
			unsigned long time1;
---------------------------------------------------------
[BUG] same
/u2/acc/oses/linux/2.4.1/drivers/scsi/sd.c:826:sd_init_onedisk: ERROR:NULL:736:826: Using unknown ptr "SRpnt" illegally! set by 'scsi_allocate_request':736

Start --->
	SRpnt = scsi_allocate_request(rscsi_disks[i].device);

	buffer = (unsigned char *) scsi_malloc(512);

	spintime = 0;

	... DELETED 82 lines ...

		cmd[0] = READ_CAPACITY;
		cmd[1] = (rscsi_disks[i].device->lun << 5) & 0xe0;
		memset((void *) &cmd[2], 0, 8);
		memset((void *) buffer, 0, 8);
Error --->
		SRpnt->sr_cmd_len = 0;
		SRpnt->sr_sense_buffer[0] = 0;
---------------------------------------------------------
[BUG] scsi_malloc can return NULL. it should find error at line 756
/u2/acc/oses/linux/2.4.1/drivers/scsi/sd.c:889:sd_init_onedisk: ERROR:NULL:738:889: Using unknown ptr "buffer" illegally! set by 'scsi_malloc':738

Start --->
	buffer = (unsigned char *) scsi_malloc(512);

	spintime = 0;

	/* Spin up drives, as required.  Only do this at boot time */

	... DELETED 143 lines ...


		rscsi_disks[i].capacity = 1 + ((buffer[0] << 24) |
					       (buffer[1] << 16) |
					       (buffer[2] << 8) |
Error --->
					       buffer[3]);

---------------------------------------------------------
[BUG] scsi_allocate_request can return NULL
/u2/acc/oses/linux/2.4.1/drivers/scsi/sr_ioctl.c:88:sr_do_ioctl: ERROR:NULL:87:88: Using unknown ptr "SRpnt" illegally! set by 'scsi_allocate_request':87

Start --->
	SRpnt = scsi_allocate_request(scsi_CDs[target].device);
Error --->
	SRpnt->sr_data_direction = readwrite;

---------------------------------------------------------
[BUG] scsi_register
/u2/acc/oses/linux/2.4.1/drivers/scsi/ultrastor.c:605:ultrastor_24f_detect: ERROR:NULL:604:605: Using unknown ptr "shpnt" illegally! set by 'scsi_register':604

Start --->
      shpnt = scsi_register(tpnt, 0);
Error --->
      shpnt->irq = config.interrupt;
      shpnt->dma_channel = config.dma_channel;
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/telephony/ixj.c:5834:ixj_attach: ERROR:NULL:5832:5834: Using unknown ptr "link" illegally! set by 'kmalloc':5832

Start --->
	link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
	memset(link, 0, sizeof(struct dev_link_t));
Error --->
	link->release.function = &ixj_cs_release;
	link->release.data = (u_long) link;
---------------------------------------------------------
[BUG] dereference to invalid pointer "bluetooth" in error message
/u2/acc/oses/linux/2.4.1/drivers/usb/bluetooth.c:924:bluetooth_read_bulk_callback: ERROR:NULL:828:924: Using NULL ptr "bluetooth" illegally! set by 'get_usb_bluetooth':828

Start --->
	struct usb_bluetooth *bluetooth = get_usb_bluetooth ((struct usb_bluetooth *)urb->context, __FUNCTION__);
	unsigned char *data = urb->transfer_buffer;
	unsigned int count = urb->actual_length;
	unsigned int i;
	unsigned int packet_size;

	... DELETED 88 lines ...

		bluetooth->bulk_packet_pos = 0;
	}

exit:
Error --->
	FILL_BULK_URB(bluetooth->read_urb, bluetooth->dev,
		      usb_rcvbulkpipe(bluetooth->dev, bluetooth->bulk_in_endpointAddress),
---------------------------------------------------------
[BUG] scsi_register
/u2/acc/oses/linux/2.4.1/drivers/usb/microtek.c:477:mts_scsi_detect: ERROR:NULL:476:477: Using unknown ptr "host" illegally! set by 'scsi_register':476

Start --->
	desc->host = scsi_register(sht, sizeof(desc));
Error --->
	desc->host->hostdata[0] = (unsigned long)desc;
/* FIXME: what if sizeof(void*) != sizeof(unsigned long)? */
---------------------------------------------------------
[BUG] kmalloc can return NULL
/u2/acc/oses/linux/2.4.1/drivers/video/sis/sis_main.c:1033:poh_new_node: ERROR:NULL:1031:1033: Using unknown ptr "poha" illegally! set by 'kmalloc':1031

Start --->
		poha = kmalloc(OH_ALLOC_SIZE, GFP_KERNEL);

Error --->
		poha->pohaNext = heap.pohaChain;
		heap.pohaChain = poha;
---------------------------------------------------------
[BUG] But the start line is not correct
/u2/acc/oses/linux/2.4.1/fs/bfs/inode.c:302:bfs_read_super: ERROR:NULL:301:302: Using unknown ptr "inode" illegally! set by 'iget':301

Start --->
		inode = iget(s,i);
Error --->
		if (inode->iu_dsk_ino == 0)
			s->su_freei++;
---------------------------------------------------------
[BUG] proc_mkdir could return NULL
/u2/acc/oses/linux/2.4.1/fs/coda/sysctl.c:488:coda_sysctl_init: ERROR:NULL:487:488: Using unknown ptr "proc_fs_coda" illegally! set by 'proc_mkdir':487

Start --->
	proc_fs_coda = proc_mkdir("coda", proc_root_fs);
Error --->
	proc_fs_coda->owner = THIS_MODULE;
	coda_proc_create("vfs_stats", coda_vfs_stats_get_info);
---------------------------------------------------------
[BUG] function will not exit if req is NULL
/u2/acc/oses/linux/2.4.1/fs/coda/upcall.c:700:coda_upcall: ERROR:NULL:699:700: Using NULL ptr "req" illegally! set by 'kmalloc':699

Start --->
	CODA_ALLOC(req,struct upc_req *,sizeof(struct upc_req));
Error --->
	req->uc_data = (void *)buffer;
	req->uc_flags = 0;
---------------------------------------------------------
[BUG] function will not exit if sig_req is NULL
/u2/acc/oses/linux/2.4.1/fs/coda/upcall.c:773:coda_upcall: ERROR:NULL:772:773: Using NULL ptr "sig_req" illegally! set by 'kmalloc':772

Start --->
		    CODA_ALLOC(sig_req, struct upc_req *, sizeof (struct upc_req));
Error --->
		    CODA_ALLOC((sig_req->uc_data), char *, sizeof(struct coda_in_hdr));

---------------------------------------------------------
[BUG] What are they trying to do?
/u2/acc/oses/linux/2.4.1/fs/hpfs/anode.c:191:hpfs_add_sector_to_btree: ERROR:NULL:197:191: Using NULL ptr "anode" illegally! set by 'hpfs_alloc_anode':197

Error --->
		up = up != node ? anode->up : -1;
		btree->u.internal[btree->n_used_nodes - 1].file_secno = /*fs*/-1;
		if (up == -1) anode->up = ra;
		mark_buffer_dirty(bh);
		brelse(bh);
		a = na;
Start --->
		if ((anode = hpfs_alloc_anode(s, a, &na, &bh))) {
			/*anode->up = up != -1 ? up : ra;*/
---------------------------------------------------------
[BUG] hpfs_map_anode
/u2/acc/oses/linux/2.4.1/fs/hpfs/anode.c:299:hpfs_remove_btree: ERROR:NULL:285:299: Using unknown ptr "anode" illegally! set by 'hpfs_map_anode':285

Start --->
		anode = hpfs_map_anode(s, ano, &bh);
		btree1 = &anode->btree;
		level++;
		pos = 0;
	}

	... DELETED 6 lines ...

		if (hpfs_stop_cycles(s, ano, &c1, &c2, "hpfs_remove_btree #2")) return;
	brelse(bh);
	hpfs_free_sectors(s, ano, 1);
	oano = ano;
Error --->
	ano = anode->up;
	if (--level) {
---------------------------------------------------------
[BUG] dereference to invalid pointer in error message
/u2/acc/oses/linux/2.4.1/fs/hpfs/dir.c:215:hpfs_lookup: ERROR:NULL:213:215: Using NULL ptr "result" illegally! set by 'iget':213

Start --->
	if (!(result = iget(dir->i_sb, ino))) {
		hpfs_unlock_iget(dir->i_sb);
Error --->
		hpfs_error(result->i_sb, "hpfs_lookup: can't get inode");
		goto bail1;
---------------------------------------------------------
[BUG] iget can return NULL
/u2/acc/oses/linux/2.4.1/fs/nfsd/nfsfh.c:140:nfsd_iget: ERROR:NULL:137:140: Using unknown ptr "inode" illegally! set by 'iget':137

Start --->
	inode = iget(sb, ino);
	if (is_bad_inode(inode)
	    || (generation && inode->i_generation != generation)
Error --->
		) {
		/* we didn't find the right inode.. */
---------------------------------------------------------
[BUG] iget can return NULL
/u2/acc/oses/linux/2.4.1/fs/nfsd/nfsfh.c:146:nfsd_iget: ERROR:NULL:137:146: Using unknown ptr "inode" illegally! set by 'iget':137

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

---------------------------------------------------------
[BUG] iget can return NULL
/u2/acc/oses/linux/2.4.1/fs/nfsd/nfsfh.c:155:nfsd_iget: ERROR:NULL:137:155: Using unknown ptr "inode" illegally! set by 'iget':137

Start --->
	inode = iget(sb, ino);
	if (is_bad_inode(inode)
	    || (generation && inode->i_generation != generation)
		) {
		/* we didn't find the right inode.. */

	... DELETED 10 lines ...

	/* now to find a dentry.
	 * If possible, get a well-connected one
	 */
	spin_lock(&dcache_lock);
Error --->
	for (lp = inode->i_dentry.next; lp != &inode->i_dentry ; lp=lp->next) {
		result = list_entry(lp,struct dentry, d_alias);
---------------------------------------------------------
[BUG] ntfs_find_attr. the return value of ntfs_find_attr is checked at the first callsite, but not at the second callsite.
/u2/acc/oses/linux/2.4.1/fs/ntfs/dir.c:854:ntfs_getdir_unsorted: ERROR:NULL:831:854: Using unknown ptr "attr" illegally! set by 'ntfs_find_attr':831

Start --->
	attr=ntfs_find_attr(ino,vol->at_bitmap,I30);
	if(!attr){
		/* directory does not have index allocation */
		*p_high=0xFFFFFFFF;
		*p_low=0;

	... DELETED 15 lines ...

		return EIO;
	}
	attr=ntfs_find_attr(ino,vol->at_index_allocation,I30);
	while(1){
Error --->
		if(*p_high*vol->clustersize > attr->size){
			/* no more index records */
---------------------------------------------------------
[BUG] ntfs_find_attr
/u2/acc/oses/linux/2.4.1/fs/ntfs/inode.c:130:ntfs_extend_mft: ERROR:NULL:129:130: Using unknown ptr "bmp" illegally! set by 'ntfs_find_attr':129

Start --->
	bmp=ntfs_find_attr(vol->mft_ino,vol->at_bitmap,0);
Error --->
	if(bmp->size*8<rcount){ /* less bits than MFT records */
		ntfs_u8 buf[1];
---------------------------------------------------------
[BUG] ntfs_find_attr can return NULL
/u2/acc/oses/linux/2.4.1/fs/ntfs/inode.c:104:ntfs_extend_mft: ERROR:NULL:102:104: Using unknown ptr "mdata" illegally! set by 'ntfs_find_attr':102

Start --->
	mdata=ntfs_find_attr(vol->mft_ino,vol->at_data,0);
	/* first check whether there is uninitialized space */
Error --->
	if(mdata->allocated<mdata->size+vol->mft_recordsize){
		size=ntfs_get_free_cluster_count(vol->bitmap)*vol->clustersize;
---------------------------------------------------------
[BUG] ntfs_find_attr can return NULL
/u2/acc/oses/linux/2.4.1/fs/ntfs/inode.c:1077:ntfs_new_inode: ERROR:NULL:1076:1077: Using unknown ptr "data" illegally! set by 'ntfs_find_attr':1076

Start --->
	data=ntfs_find_attr(vol->mft_ino,vol->at_data,0);
Error --->
	length=data->size/vol->mft_recordsize;

---------------------------------------------------------
[BUG] bread
/u2/acc/oses/linux/2.4.1/fs/reiserfs/journal.c:1661:journal_read: ERROR:NULL:1636:1661: Using unknown ptr "d_bh" illegally! set by 'bread':1636

Start --->
    d_bh = bread(p_s_sb->s_dev, reiserfs_get_journal_block(p_s_sb) + le32_to_cpu(jh->j_first_unflushed_offset), p_s_sb->s_blocksize) ;
    ret = journal_transaction_is_valid(p_s_sb, d_bh, NULL, NULL) ;
    if (!ret) {
      continue_replay = 0 ;
    }

	... DELETED 17 lines ...

  while(continue_replay && cur_dblock < (reiserfs_get_journal_block(p_s_sb) + JOURNAL_BLOCK_COUNT)) {
    d_bh = bread(p_s_sb->s_dev, cur_dblock, p_s_sb->s_blocksize) ;
    ret = journal_transaction_is_valid(p_s_sb, d_bh, &oldest_invalid_trans_id, &newest_mount_id) ;
    if (ret == 1) {
Error --->
      desc = (struct reiserfs_journal_desc *)d_bh->b_data ;
      if (oldest_start == 0) { /* init all oldest_ values */
---------------------------------------------------------
[BUG] bread
/u2/acc/oses/linux/2.4.1/fs/reiserfs/journal.c:1661:journal_read: ERROR:NULL:1658:1661: Using unknown ptr "d_bh" illegally! set by 'bread':1658

Start --->
    d_bh = bread(p_s_sb->s_dev, cur_dblock, p_s_sb->s_blocksize) ;
    ret = journal_transaction_is_valid(p_s_sb, d_bh, &oldest_invalid_trans_id, &newest_mount_id) ;
    if (ret == 1) {
Error --->
      desc = (struct reiserfs_journal_desc *)d_bh->b_data ;
      if (oldest_start == 0) { /* init all oldest_ values */
---------------------------------------------------------
[BUG] bread
/u2/acc/oses/linux/2.4.1/fs/udf/file.c:109:udf_adinicb_commit_write: ERROR:NULL:108:109: Using unknown ptr "bh" illegally! set by 'bread':108

Start --->
	bh = bread (inode->i_dev, block, inode->i_sb->s_blocksize);
Error --->
	memcpy(bh->b_data + udf_file_entry_alloc_offset(inode) + offset,
		kaddr + offset, to-offset);
---------------------------------------------------------
[BUG] bread
/u2/acc/oses/linux/2.4.1/fs/udf/file.c:61:udf_adinicb_readpage: ERROR:NULL:60:61: Using unknown ptr "bh" illegally! set by 'bread':60

Start --->
	bh = bread (inode->i_dev, block, inode->i_sb->s_blocksize);
Error --->
	memcpy(kaddr, bh->b_data + udf_ext0_offset(inode), inode->i_size);
	brelse(bh);
---------------------------------------------------------
[BUG] bread
/u2/acc/oses/linux/2.4.1/fs/udf/file.c:84:udf_adinicb_writepage: ERROR:NULL:83:84: Using unknown ptr "bh" illegally! set by 'bread':83

Start --->
	bh = bread (inode->i_dev, block, inode->i_sb->s_blocksize);
Error --->
	memcpy(bh->b_data + udf_ext0_offset(inode), kaddr, inode->i_size);
	mark_buffer_dirty(bh);
---------------------------------------------------------
[BUG] udf_tread will call bread, which can return NULL if the block is unreadable
/u2/acc/oses/linux/2.4.1/fs/udf/namei.c:955:udf_symlink: ERROR:NULL:954:955: Using unknown ptr "bh" illegally! set by 'udf_tread':954

Start --->
	bh = udf_tread(inode->i_sb, block, inode->i_sb->s_blocksize);
Error --->
	ea = bh->b_data + udf_ext0_offset(inode);

---------------------------------------------------------
[BUG] The logic in the second for loop seems wrong
/u2/acc/oses/linux/2.4.1/fs/udf/partition.c:183:udf_fill_spartable: ERROR:NULL:136:183: Using NULL ptr "bh" illegally! set by 'udf_tread':136

Start --->
		bh = udf_read_tagged(sb, spartable, spartable, &ident);

		if (!bh)
		{
			sdata->s_spar_loc[i] = 0;

	... DELETED 39 lines ...

							continue;
						}
						index = 0;
					}
Error --->
					se = (SparingEntry *)&(bh->b_data[index]);
					index += sizeof(SparingEntry);
---------------------------------------------------------
[BUG] bread
/u2/acc/oses/linux/2.4.1/fs/udf/super.c:1186:udf_load_partition: ERROR:NULL:1183:1186: Using unknown ptr "bh" illegally! set by 'bread':1183

Start --->
					bh = bread(sb->s_dev, pos, sb->s_blocksize);
					UDF_SB_TYPEVIRT(sb,i).s_start_offset =
						le16_to_cpu(((struct VirtualAllocationTable20 *)bh->b_data + udf_ext0_offset(UDF_SB_VAT(sb)))->lengthHeader) +
Error --->
							udf_ext0_offset(UDF_SB_VAT(sb));
					UDF_SB_TYPEVIRT(sb,i).s_num_entries = (UDF_SB_VAT(sb)->i_size -
---------------------------------------------------------
[BUG] udf_read_tagged will call udf_read, which can return NULL
/u2/acc/oses/linux/2.4.1/fs/udf/super.c:1050:udf_process_sequence: ERROR:NULL:1049:1050: Using unknown ptr "bh2" illegally! set by 'udf_read_tagged':1049

Start --->
					bh2 = udf_read_tagged(sb, j, j, &ident);
Error --->
					gd = (struct GenericDesc *)bh2->b_data;
					if (ident == TID_PARTITION_DESC)
---------------------------------------------------------
[BUG] at line 1796
/u2/acc/oses/linux/2.4.1/net/atm/lec.c:1799:lec_arp_update: ERROR:NULL:1798:1799: Using unknown ptr "entry" illegally! set by 'make_entry':1798

Start --->
                entry = make_entry(priv, mac_addr);
Error --->
                entry->status = ESI_UNKNOWN;
                lec_arp_put(priv->lec_arp_tables, entry);
---------------------------------------------------------
[BUG] make_entry can return NULL
/u2/acc/oses/linux/2.4.1/net/atm/lec.c:1895:lec_vcc_added: ERROR:NULL:1892:1895: Using unknown ptr "entry" illegally! set by 'make_entry':1892

Start --->
                entry = make_entry(priv, bus_mac);
                memcpy(entry->atm_addr, ioc_data->atm_addr, ATM_ESA_LEN);
                memset(entry->mac_addr, 0, ETH_ALEN);
Error --->
                entry->recv_vcc = vcc;
                entry->old_recv_push = old_push;
---------------------------------------------------------
[BUG] make_entry
/u2/acc/oses/linux/2.4.1/net/atm/lec.c:1970:lec_vcc_added: ERROR:NULL:1969:1970: Using unknown ptr "entry" illegally! set by 'make_entry':1969

Start --->
        entry = make_entry(priv, bus_mac);
Error --->
        entry->vcc = vcc;
        entry->old_push = old_push;
---------------------------------------------------------
[BUG] br_get_port can return NULL
/u2/acc/oses/linux/2.4.1/net/bridge/br_stp.c:127:br_root_selection: ERROR:NULL:126:127: Using unknown ptr "p" illegally! set by 'br_get_port':126

Start --->
		p = br_get_port(br, root_port);
Error --->
		br->designated_root = p->designated_root;
		br->root_path_cost = p->designated_cost + p->path_cost;
---------------------------------------------------------
[BUG] br_get_port can return NULL
/u2/acc/oses/linux/2.4.1/net/bridge/br_stp.c:81:br_should_become_root_port: ERROR:NULL:72:81: Using unknown ptr "rp" illegally! set by 'br_get_port':72

Start --->
	rp = br_get_port(br, root_port);

	t = memcmp(&p->designated_root, &rp->designated_root, 8);
	if (t < 0)
		return 1;
	else if (t > 0)
		return 0;

	if (p->designated_cost + p->path_cost <
Error --->
	    rp->designated_cost + rp->path_cost)
		return 1;
---------------------------------------------------------
[BUG] proc_mkdir can return NULL
/u2/acc/oses/linux/2.4.1/net/irda/irproc.c:70:irda_proc_register: ERROR:NULL:69:70: Using unknown ptr "proc_irda" illegally! set by 'proc_mkdir':69

Start --->
	proc_irda = proc_mkdir("net/irda", NULL);
Error --->
	proc_irda->owner = THIS_MODULE;



