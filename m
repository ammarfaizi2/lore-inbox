Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267636AbTBEBE6>; Tue, 4 Feb 2003 20:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267638AbTBEBE6>; Tue, 4 Feb 2003 20:04:58 -0500
Received: from Xenon.Stanford.EDU ([171.64.66.201]:26570 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S267636AbTBEBEV>; Tue, 4 Feb 2003 20:04:21 -0500
Date: Tue, 4 Feb 2003 17:13:53 -0800
From: Andy Chou <acc@CS.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Cc: mc@cs.stanford.edu
Subject: [CHECKER] 112 potential memory leaks in 2.5.48
Message-ID: <20030205011353.GA17941@Xenon.Stanford.EDU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err

Hi everyone,

As part of the MC research project at Stanford, we've developed a
memory leak checker that we've run over Linux 2.5.48.  Below is a list
of 112 potential memory leaks found by our tool.  There are actually
several different memory leak checkers, so more bugs may be posted
later.

The errors are sorted by filename.  Confirmation or denial of these
potential errors would be appreciated.

-Andy Chou


# BUGs	|	File Name
14	|	drivers/hotplug/ibmphp_ebda.c
7	|	fs/freevxfs/vxfs_fshead.c
7	|	drivers/hotplug/cpqphp_nvram.c
6	|	drivers/pnp/pnpbios/core.c
5	|	drivers/pnp/pnpbios/proc.c
5	|	drivers/hotplug/acpiphp_glue.c
5	|	drivers/net/fc/iph5526.c
4	|	fs/isofs/rock.c
2	|	drivers/mtd/chips/cfi_cmdset_0002.c
2	|	fs/jffs/intrep.c
2	|	drivers/md/dm-ioctl.c
2	|	drivers/pnp/resource.c
2	|	net/irda/irttp.c
2	|	drivers/mtd/chips/cfi_cmdset_0001.c
2	|	drivers/usb/input/pid.c
1	|	drivers/media/video/bt819.c
1	|	drivers/usb/class/cdc-acm.c
1	|	fs/quota_v2.c
1	|	fs/xfs/xfs_da_btree.c
1	|	drivers/media/video/videodev.c
1	|	drivers/pnp/quirks.c
1	|	drivers/usb/misc/atmsar.c
1	|	drivers/md/dm-target.c
1	|	fs/cifs/transport.c
1	|	drivers/media/dvb/av7110/saa7146_v4l.c
1	|	drivers/scsi/st.c
1	|	drivers/scsi/scsi_scan.c
1	|	drivers/isdn/pcbit/drv.c
1	|	drivers/mtd/devices/docprobe.c
1	|	fs/xfs/xfs_dir_leaf.c
1	|	drivers/block/cciss_scsi.c
1	|	drivers/usb/class/bluetty.c
1	|	init/do_mounts.c
1	|	fs/xfs/xfs_log_recover.c
1	|	drivers/scsi/sr_ioctl.c
1	|	drivers/message/fusion/mptctl.c
1	|	drivers/ieee1394/eth1394.c
1	|	drivers/media/video/bttv-risc.c
1	|	drivers/pnp/interface.c
1	|	fs/ufs/util.c
1	|	fs/xfs/pagebuf/page_buf.c
1	|	drivers/block/cciss.c
1	|	sound/oss/cs4232.c
1	|	drivers/isdn/i4l/isdn_x25iface.c
1	|	drivers/hotplug/ibmphp_pci.c
1	|	net/ipv6/route.c
1	|	drivers/net/wan/pc300_tty.c
1	|	drivers/net/pcmcia/aironet4500_cs.c
1	|	fs/jffs2/readinode.c
1	|	drivers/net/e100/e100_main.c
1	|	drivers/mtd/chips/sharp.c
1	|	drivers/net/tokenring/madgemc.c
1	|	drivers/message/i2o/i2o_core.c
1	|	net/ipv4/route.c
1	|	drivers/video/radeonfb.c
1	|	fs/jffs2/erase.c
1	|	drivers/hotplug/cpqphp_ctrl.c
1	|	drivers/video/aty/atyfb_base.c
1	|	drivers/pnp/isapnp/core.c
1	|	drivers/net/ewrk3.c


---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/block/cciss.c:1071:register_new_disk: ERROR:LEAK:1038:1071:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/block/cciss.c:1038:kmalloc]
	{
		printk(KERN_ERR "cciss: out of memory\n");
		return -1;
	}
	memset(ld_buff, 0, sizeof(ReportLunData_struct));
Start --->
	size_buff = kmalloc(sizeof( ReadCapdata_struct), GFP_KERNEL);

	... DELETED 27 lines ...

	} else /* reading number of logical volumes failed */
	{
		printk(KERN_WARNING "cciss: report logical volume"
			" command failed\n");
		listlength = 0;
Error --->
		return -1;
	}
	num_luns = listlength / 8; // 8 bytes pre entry
	if (num_luns > CISS_MAX_LUN)
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/block/cciss_scsi.c:1186:cciss_update_non_disk_devices: ERROR:LEAK:1166:1186:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/block/cciss_scsi.c:1166:kmalloc]
	if (ld_buff == NULL) {
		printk(KERN_ERR "cciss: out of memory\n");
		return;
	}
	memset(ld_buff, 0, reportlunsize);
Start --->
	inq_buff = kmalloc(sizeof( InquiryData_struct), GFP_KERNEL);

	... DELETED 14 lines ...

			num_luns = CISS_MAX_PHYS_LUN;
		}
	}
	else {
		printk(KERN_ERR  "cciss: Report physical LUNs failed.\n");
Error --->
		return;
	}


---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/acpiphp_glue.c:581:add_p2p_bridge: ERROR:LEAK:533:581:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/acpiphp_glue.c:533:kmalloc]
	u8 tmp8;
	u16 tmp16;
	u64 base64, limit64;
	u32 base, limit, base32u, limit32u;

Start --->
	bridge = kmalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);

	... DELETED 42 lines ...

		base = (base << 8) & 0xf000;
		limit = ((limit << 8) & 0xf000) + 0xfff;
		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
		if (!bridge->io_head) {
			err("out of memory\n");
Error --->
			return;
		}
		dbg("16bit I/O range: %04x-%04x\n",
		    (u32)bridge->io_head->base,
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/acpiphp_glue.c:595:add_p2p_bridge: ERROR:LEAK:533:595:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/acpiphp_glue.c:533:kmalloc]
	u8 tmp8;
	u16 tmp16;
	u64 base64, limit64;
	u32 base, limit, base32u, limit32u;

Start --->
	bridge = kmalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);

	... DELETED 56 lines ...

		pci_read_config_word(bridge->pci_dev, PCI_IO_LIMIT_UPPER16, &tmp16);
		limit = (((u32)tmp16 << 16) | ((limit << 8) & 0xf000)) + 0xfff;
		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
		if (!bridge->io_head) {
			err("out of memory\n");
Error --->
			return;
		}
		dbg("32bit I/O range: %08x-%08x\n",
		    (u32)bridge->io_head->base,
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/acpiphp_glue.c:616:add_p2p_bridge: ERROR:LEAK:533:616:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/acpiphp_glue.c:533:kmalloc]
	u8 tmp8;
	u16 tmp16;
	u64 base64, limit64;
	u32 base, limit, base32u, limit32u;

Start --->
	bridge = kmalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);

	... DELETED 77 lines ...

	pci_read_config_word(bridge->pci_dev, PCI_MEMORY_LIMIT, &tmp16);
	limit = ((tmp16 & 0xfff0) << 16) | 0xfffff;
	bridge->mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
	if (!bridge->mem_head) {
		err("out of memory\n");
Error --->
		return;
	}
	dbg("32bit Memory range: %08x-%08x\n",
	    (u32)bridge->mem_head->base,
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/acpiphp_glue.c:635:add_p2p_bridge: ERROR:LEAK:533:635:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/acpiphp_glue.c:533:kmalloc]
	u8 tmp8;
	u16 tmp16;
	u64 base64, limit64;
	u32 base, limit, base32u, limit32u;

Start --->
	bridge = kmalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);

	... DELETED 96 lines ...

		base = (base & 0xfff0) << 16;
		limit = ((limit & 0xfff0) << 16) | 0xfffff;
		bridge->p_mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
		if (!bridge->p_mem_head) {
			err("out of memory\n");
Error --->
			return;
		}
		dbg("32bit Prefetchable memory range: %08x-%08x\n",
		    (u32)bridge->p_mem_head->base,
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/acpiphp_glue.c:650:add_p2p_bridge: ERROR:LEAK:533:650:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/acpiphp_glue.c:533:kmalloc]
	u8 tmp8;
	u16 tmp16;
	u64 base64, limit64;
	u32 base, limit, base32u, limit32u;

Start --->
	bridge = kmalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);

	... DELETED 111 lines ...

		limit64 = (((u64)limit32u << 32) | ((limit & 0xfff0) << 16)) + 0xfffff;

		bridge->p_mem_head = acpiphp_make_resource(base64, limit64 - base64 + 1);
		if (!bridge->p_mem_head) {
			err("out of memory\n");
Error --->
			return;
		}
		dbg("64bit Prefetchable memory range: %08x%08x-%08x%08x\n",
		    (u32)(bridge->p_mem_head->base >> 32),
---------------------------------------------------------
[BUG] Hard to tell.
/u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_ctrl.c:3060:configure_new_function: ERROR:LEAK:2551:3060:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_ctrl.c:2551:kmalloc]
		temp_resources.p_mem_head = p_mem_node;
		temp_resources.irqs = &irqs;

		// Make copies of the nodes we are going to pass down so that
		// if there is a problem,we can just use these to free resources
Start --->
		hold_bus_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);

	... DELETED 503 lines ...

		return(DEVICE_TYPE_NOT_SUPPORTED);
	}

	func->configured = 1;

Error --->
	return 0;
}

---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:534:compaq_nvram_load: ERROR:LEAK:524:534:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:524:kmalloc]

		if (p_byte > ((u8*)p_EV_header + evbuffer_length))
			return(2);

		while (nummem--) {
Start --->
			mem_node = (struct pci_resource*) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);

			if (!mem_node)
				break;

			mem_node->base = *(u32*)p_byte;
			dbg("mem base = %8.8x\n",mem_node->base);
			p_byte += 4;

			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
Error --->
				return(2);

			mem_node->length = *(u32*)p_byte;
			dbg("mem length = %8.8x\n",mem_node->length);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:541:compaq_nvram_load: ERROR:LEAK:524:541:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:524:kmalloc]

		if (p_byte > ((u8*)p_EV_header + evbuffer_length))
			return(2);

		while (nummem--) {
Start --->
			mem_node = (struct pci_resource*) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);

	... DELETED 11 lines ...

			mem_node->length = *(u32*)p_byte;
			dbg("mem length = %8.8x\n",mem_node->length);
			p_byte += 4;

			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
Error --->
				return(2);

			mem_node->next = ctrl->mem_head;
			ctrl->mem_head = mem_node;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:558:compaq_nvram_load: ERROR:LEAK:548:558:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:548:kmalloc]
			mem_node->next = ctrl->mem_head;
			ctrl->mem_head = mem_node;
		}

		while (numpmem--) {
Start --->
			p_mem_node = (struct pci_resource*) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);

			if (!p_mem_node)
				break;

			p_mem_node->base = *(u32*)p_byte;
			dbg("pre-mem base = %8.8x\n",p_mem_node->base);
			p_byte += 4;

			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
Error --->
				return(2);

			p_mem_node->length = *(u32*)p_byte;
			dbg("pre-mem length = %8.8x\n",p_mem_node->length);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:565:compaq_nvram_load: ERROR:LEAK:548:565:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:548:kmalloc]
			mem_node->next = ctrl->mem_head;
			ctrl->mem_head = mem_node;
		}

		while (numpmem--) {
Start --->
			p_mem_node = (struct pci_resource*) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);

	... DELETED 11 lines ...

			p_mem_node->length = *(u32*)p_byte;
			dbg("pre-mem length = %8.8x\n",p_mem_node->length);
			p_byte += 4;

			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
Error --->
				return(2);

			p_mem_node->next = ctrl->p_mem_head;
			ctrl->p_mem_head = p_mem_node;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:582:compaq_nvram_load: ERROR:LEAK:572:582:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:572:kmalloc]
			p_mem_node->next = ctrl->p_mem_head;
			ctrl->p_mem_head = p_mem_node;
		}

		while (numio--) {
Start --->
			io_node = (struct pci_resource*) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);

			if (!io_node)
				break;

			io_node->base = *(u32*)p_byte;
			dbg("io base = %8.8x\n",io_node->base);
			p_byte += 4;

			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
Error --->
				return(2);

			io_node->length = *(u32*)p_byte;
			dbg("io length = %8.8x\n",io_node->length);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:589:compaq_nvram_load: ERROR:LEAK:572:589:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:572:kmalloc]
			p_mem_node->next = ctrl->p_mem_head;
			ctrl->p_mem_head = p_mem_node;
		}

		while (numio--) {
Start --->
			io_node = (struct pci_resource*) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);

	... DELETED 11 lines ...

			io_node->length = *(u32*)p_byte;
			dbg("io length = %8.8x\n",io_node->length);
			p_byte += 4;

			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
Error --->
				return(2);

			io_node->next = ctrl->io_head;
			ctrl->io_head = io_node;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:605:compaq_nvram_load: ERROR:LEAK:596:605:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/cpqphp_nvram.c:596:kmalloc]
			io_node->next = ctrl->io_head;
			ctrl->io_head = io_node;
		}

		while (numbus--) {
Start --->
			bus_node = (struct pci_resource*) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);

			if (!bus_node)
				break;

			bus_node->base = *(u32*)p_byte;
			p_byte += 4;

			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
Error --->
				return(2);

			bus_node->length = *(u32*)p_byte;
			p_byte += 4;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:1001:ebda_rsrc_controller: ERROR:LEAK:845:1001:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:845:alloc_ebda_hpc]
		addr += (bus_num * 9);	/* offset of ctlr_type */
		temp = readb (io_mem + addr);

		addr += 1;
		/* init hpc structure */
Start --->
		hpc_ptr = alloc_ebda_hpc (slot_num, bus_num);

	... DELETED 150 lines ...

			if (!hp_slot_ptr->private) {
				iounmap (io_mem);
				kfree (hp_slot_ptr->name);
				kfree (hp_slot_ptr->info);
				kfree (hp_slot_ptr);
Error --->
				return -ENOMEM;
			}

			((struct slot *)hp_slot_ptr->private)->flag = TRUE;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:1025:ebda_rsrc_controller: ERROR:LEAK:972:1025:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:972:kmalloc]
		hpc_ptr->ending_slot_num = hpc_ptr->slots[slot_num-1].slot_num;

		// register slots with hpc core as well as create linked list of ibm slot
		for (index = 0; index < hpc_ptr->slot_count; index++) {

Start --->
			hp_slot_ptr = (struct hotplug_slot *) kmalloc (sizeof (struct hotplug_slot), GFP_KERNEL);

	... DELETED 47 lines ...

			((struct slot *) hp_slot_ptr->private)->bus = hpc_ptr->slots[index].slot_bus_num;

			bus_info_ptr1 = ibmphp_find_same_bus_num (hpc_ptr->slots[index].slot_bus_num);
			if (!bus_info_ptr1) {
				iounmap (io_mem);
Error --->
				return -ENODEV;
			}
			((struct slot *) hp_slot_ptr->private)->bus_on = bus_info_ptr1;
			bus_info_ptr1 = NULL;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:363:ibmphp_access_ebda: ERROR:LEAK:363:363:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:363:alloc_ebda_hpc_list]
			}
			/* rc sub blk signature  */
			num_ctlrs = readb (io_mem + sub_addr);

			sub_addr += 1;

Error --->
			hpc_list_ptr = alloc_ebda_hpc_list ();
			if (!hpc_list_ptr) {
				iounmap (io_mem);
				return -ENOMEM;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:392:ibmphp_access_ebda: ERROR:LEAK:392:392:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:392:alloc_ebda_rsrc_list]

			/* signature of re */
			num_entries = readw (io_mem + sub_addr);

			sub_addr += 2;	/* offset of RSRC_ENTRIES blk */

Error --->
			rsrc_list_ptr = alloc_ebda_rsrc_list ();
			if (!rsrc_list_ptr ) {
				iounmap (io_mem);
				return -ENOMEM;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:608:convert_2digits_to_char: ERROR:LEAK:601:608:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:601:kmalloc]
	int bit;	
	char *str1;

	str = (char *) kmalloc (3, GFP_KERNEL);
	memset (str, 0, 3);
Start --->
	str1 = (char *) kmalloc (2, GFP_KERNEL);
	memset (str, 0, 3);
	bit = (int)(var / 10);
	switch (bit) {
	case 0:
		//one digit number
		*str = (char)(var + 48);
Error --->
		return str;
	default: 	
		//2 digits number
		*str1 = (char)(bit + 48);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:763:create_file_name: ERROR:LEAK:722:763:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:722:kmalloc]

	chassis_str = (char *) kmalloc (30, GFP_KERNEL);
	memset (chassis_str, 0, 30);
	rxe_str = (char *) kmalloc (30, GFP_KERNEL);
	memset (rxe_str, 0, 30);
Start --->
	ptr_chassis_num = (char *) kmalloc (3, GFP_KERNEL);

	... DELETED 35 lines ...

		which = 1;
		++flag;
	} else if (rio_table_ptr) {
		if (rio_table_ptr->ver_num == 3) {
			/* if both NULL and we DO have correct RIO table in BIOS */
Error --->
			return NULL;
		}
	} 
	if (!flag) {
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:785:create_file_name: ERROR:LEAK:724:785:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:724:kmalloc]
	memset (chassis_str, 0, 30);
	rxe_str = (char *) kmalloc (30, GFP_KERNEL);
	memset (rxe_str, 0, 30);
	ptr_chassis_num = (char *) kmalloc (3, GFP_KERNEL);
	memset (ptr_chassis_num, 0, 3);
Start --->
	ptr_rxe_num = (char *) kmalloc (3, GFP_KERNEL);

	... DELETED 55 lines ...

		kfree (ptr_chassis_num);
		strcat (chassis_str, "slot");
		ptr_slot_num = convert_2digits_to_char (slot_num - first_slot + 1);
		strcat (chassis_str, ptr_slot_num);
		kfree (ptr_slot_num);
Error --->
		return chassis_str;
		break;
	case 1:
		/* RXE */
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:796:create_file_name: ERROR:LEAK:722:796:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:722:kmalloc]

	chassis_str = (char *) kmalloc (30, GFP_KERNEL);
	memset (chassis_str, 0, 30);
	rxe_str = (char *) kmalloc (30, GFP_KERNEL);
	memset (rxe_str, 0, 30);
Start --->
	ptr_chassis_num = (char *) kmalloc (3, GFP_KERNEL);

	... DELETED 68 lines ...

		kfree (ptr_rxe_num);
		strcat (rxe_str, "slot");
		ptr_slot_num = convert_2digits_to_char (slot_num - first_slot + 1);
		strcat (rxe_str, ptr_slot_num);
		kfree (ptr_slot_num);
Error --->
		return rxe_str;
		break;
	}	
	return NULL;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:875:ebda_rsrc_controller: ERROR:LEAK:845:875:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:845:alloc_ebda_hpc]
		addr += (bus_num * 9);	/* offset of ctlr_type */
		temp = readb (io_mem + addr);

		addr += 1;
		/* init hpc structure */
Start --->
		hpc_ptr = alloc_ebda_hpc (slot_num, bus_num);

	... DELETED 24 lines ...

			bus_info_ptr2 = ibmphp_find_same_bus_num (slot_ptr->slot_bus_num);
			if (!bus_info_ptr2) {
				bus_info_ptr1 = (struct bus_info *) kmalloc (sizeof (struct bus_info), GFP_KERNEL);
				if (!bus_info_ptr1) {
					iounmap (io_mem);
Error --->
					return -ENOMEM;
				}
				memset (bus_info_ptr1, 0, sizeof (struct bus_info));
				bus_info_ptr1->slot_min = slot_ptr->slot_num;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:943:ebda_rsrc_controller: ERROR:LEAK:845:943:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:845:alloc_ebda_hpc]
		addr += (bus_num * 9);	/* offset of ctlr_type */
		temp = readb (io_mem + addr);

		addr += 1;
		/* init hpc structure */
Start --->
		hpc_ptr = alloc_ebda_hpc (slot_num, bus_num);

	... DELETED 92 lines ...

			case 0:
				hpc_ptr->u.isa_ctlr.io_start = readw (io_mem + addr);
				hpc_ptr->u.isa_ctlr.io_end = readw (io_mem + addr + 2);
				retval = check_region (hpc_ptr->u.isa_ctlr.io_start, (hpc_ptr->u.isa_ctlr.io_end - hpc_ptr->u.isa_ctlr.io_start + 1));
				if (retval)
Error --->
					return -ENODEV;
				request_region (hpc_ptr->u.isa_ctlr.io_start, (hpc_ptr->u.isa_ctlr.io_end - hpc_ptr->u.isa_ctlr.io_start + 1), "ibmphp");
				hpc_ptr->irq = readb (io_mem + addr + 4);
				addr += 5;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:958:ebda_rsrc_controller: ERROR:LEAK:845:958:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:845:alloc_ebda_hpc]
		addr += (bus_num * 9);	/* offset of ctlr_type */
		temp = readb (io_mem + addr);

		addr += 1;
		/* init hpc structure */
Start --->
		hpc_ptr = alloc_ebda_hpc (slot_num, bus_num);

	... DELETED 107 lines ...

				hpc_ptr->irq = readb (io_mem + addr + 5);
				addr += 6;
				break;
			default:
				iounmap (io_mem);
Error --->
				return -ENODEV;
		}

		//reorganize chassis' linked list
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:975:ebda_rsrc_controller: ERROR:LEAK:845:975:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:845:alloc_ebda_hpc]
		addr += (bus_num * 9);	/* offset of ctlr_type */
		temp = readb (io_mem + addr);

		addr += 1;
		/* init hpc structure */
Start --->
		hpc_ptr = alloc_ebda_hpc (slot_num, bus_num);

	... DELETED 124 lines ...

		for (index = 0; index < hpc_ptr->slot_count; index++) {

			hp_slot_ptr = (struct hotplug_slot *) kmalloc (sizeof (struct hotplug_slot), GFP_KERNEL);
			if (!hp_slot_ptr) {
				iounmap (io_mem);
Error --->
				return -ENOMEM;
			}
			memset (hp_slot_ptr, 0, sizeof (struct hotplug_slot));

---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:983:ebda_rsrc_controller: ERROR:LEAK:845:983:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:845:alloc_ebda_hpc]
		addr += (bus_num * 9);	/* offset of ctlr_type */
		temp = readb (io_mem + addr);

		addr += 1;
		/* init hpc structure */
Start --->
		hpc_ptr = alloc_ebda_hpc (slot_num, bus_num);

	... DELETED 132 lines ...


			hp_slot_ptr->info = (struct hotplug_slot_info *) kmalloc (sizeof (struct hotplug_slot_info), GFP_KERNEL);
			if (!hp_slot_ptr->info) {
				iounmap (io_mem);
				kfree (hp_slot_ptr);
Error --->
				return -ENOMEM;
			}
			memset (hp_slot_ptr->info, 0, sizeof (struct hotplug_slot_info));

---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:992:ebda_rsrc_controller: ERROR:LEAK:845:992:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_ebda.c:845:alloc_ebda_hpc]
		addr += (bus_num * 9);	/* offset of ctlr_type */
		temp = readb (io_mem + addr);

		addr += 1;
		/* init hpc structure */
Start --->
		hpc_ptr = alloc_ebda_hpc (slot_num, bus_num);

	... DELETED 141 lines ...

			hp_slot_ptr->name = (char *) kmalloc (30, GFP_KERNEL);
			if (!hp_slot_ptr->name) {
				iounmap (io_mem);
				kfree (hp_slot_ptr->info);
				kfree (hp_slot_ptr);
Error --->
				return -ENOMEM;
			}

			hp_slot_ptr->private = alloc_ibm_slot ();
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_pci.c:954:configure_bridge: ERROR:LEAK:804:954:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/hotplug/ibmphp_pci.c:804:scan_behind_bridge]
			}
		}		/* end of mem */
	}			/* end of for  */

	/* Now need to see how much space the devices behind the bridge needed */
Start --->
	amount_needed = scan_behind_bridge (func, sec_number);

	... DELETED 144 lines ...

			goto error;
		}
		if (rc) {
			if (rc == -ENOMEM) {
				ibmphp_remove_bus (bus, func->busno);
Error --->
				return rc;
			}
			retval = rc;
			goto error;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/ieee1394/eth1394.c:371:ether1394_add_host: ERROR:LEAK:362:371:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/ieee1394/eth1394.c:362:kmalloc]

	priv = (struct eth1394_priv *)dev->priv;

	priv->host = host;

Start --->
	hi = (struct host_info *)kmalloc (sizeof (struct host_info),
					  GFP_KERNEL);

	if (hi == NULL)
		goto out;

	if (register_netdev (dev)) {
		ETH1394_PRINT (KERN_ERR, dev->name, "Error registering network driver\n");
		kfree (dev);
Error --->
		return;
	}

	ETH1394_PRINT (KERN_ERR, dev->name, "IEEE-1394 IPv4 over 1394 Ethernet (%s)\n",
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/isdn/i4l/isdn_x25iface.c:225:isdn_x25iface_connect_ind: ERROR:LEAK:216:225:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/isdn/i4l/isdn_x25iface.c:216:dev_alloc_skb]

/* a connection set up is indicated by lower layer 
 */
int isdn_x25iface_connect_ind(struct concap_proto *cprot)
{
Start --->
	struct sk_buff * skb = dev_alloc_skb(1);
	enum wan_states *state_p 
	  = &( ( (ix25_pdata_t*) (cprot->proto_data) ) -> state);
	IX25DEBUG( "isdn_x25iface_connect_ind %s \n"
		   , MY_DEVNAME(cprot->net_dev) );
	if( *state_p == WAN_UNCONFIGURED ){ 
		printk(KERN_WARNING 
		       "isdn_x25iface_connect_ind while unconfigured %s\n"
		       , MY_DEVNAME(cprot->net_dev) );
Error --->
		return -1;
	}
	*state_p = WAN_CONNECTED;
	if( skb ){
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/isdn/pcbit/drv.c:1090:pcbit_set_msn: ERROR:LEAK:1079:1090:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/isdn/pcbit/drv.c:1079:kmalloc]
		if (cp)
			len = cp - sp;
		else
			len = strlen(sp);

Start --->
		ptr = kmalloc(sizeof(struct msn_entry), GFP_ATOMIC);

		if (!ptr) {
			printk(KERN_WARNING "kmalloc failed\n");
			return;
		}
		ptr->next = NULL;
		
		ptr->msn = kmalloc(len, GFP_ATOMIC);
		if (!ptr->msn) {
			printk(KERN_WARNING "kmalloc failed\n");
Error --->
			return;
		}

		memcpy(ptr->msn, sp, len - 1);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/md/dm-ioctl.c:285:dm_hash_rename: ERROR:LEAK:271:285:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/md/dm-ioctl.c:271:kstrdup]
	struct hash_cell *hc;

	/*
	 * duplicate new.
	 */
Start --->
	new_name = kstrdup(new);
	if (!new_name)
		return -ENOMEM;

	down_write(&_hash_lock);

	/*
	 * Is new free ?
	 */
	hc = __get_name_cell(new);
	if (hc) {
		DMWARN("asked to rename to an already existing name %s -> %s",
		       old, new);
		up_write(&_hash_lock);
Error --->
		return -EBUSY;
	}

	/*
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/md/dm-ioctl.c:296:dm_hash_rename: ERROR:LEAK:271:296:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/md/dm-ioctl.c:271:kstrdup]
	struct hash_cell *hc;

	/*
	 * duplicate new.
	 */
Start --->
	new_name = kstrdup(new);

	... DELETED 19 lines ...

	hc = __get_name_cell(old);
	if (!hc) {
		DMWARN("asked to rename a non existent device %s -> %s",
		       old, new);
		up_write(&_hash_lock);
Error --->
		return -ENXIO;
	}

	/*
---------------------------------------------------------
[BUG] Maybe.
/u1/acc/linux/2.5.48/drivers/md/dm-target.c:126:dm_register_target: ERROR:LEAK:114:126:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/md/dm-target.c:114:alloc_target]
}

int dm_register_target(struct target_type *t)
{
	int rv = 0;
Start --->
	struct tt_internal *ti = alloc_target(t);

	if (!ti)
		return -ENOMEM;

	write_lock(&_lock);
	if (__find_target_type(t->name))
		rv = -EEXIST;
	else
		list_add(&ti->list, &_targets);

	write_unlock(&_lock);
Error --->
	return rv;
}

int dm_unregister_target(struct target_type *t)
---------------------------------------------------------
[BUG] [GEM] Comment says "this is tricky..."
/u1/acc/linux/2.5.48/drivers/media/dvb/av7110/saa7146_v4l.c:220:saa7146_v4l_command: ERROR:LEAK:209:220:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/media/dvb/av7110/saa7146_v4l.c:209:kmalloc]
			} else {
			  
			  
			  /* this is tricky, but helps us saving kmalloc/kfree-calls 
			     and boring if/else-constructs ... */
Start --->
			  x = (int*)kmalloc(sizeof(int)*vw->clipcount*4,GFP_KERNEL);
			  if( NULL == x ) {
			    hprintk(KERN_ERR "saa7146_v4l.o: SAA7146_V4L_SWIN: out of kernel-memory.\n");
			    return -ENOMEM;
			  }
			  y = x+(1*vw->clipcount);
			  w = x+(2*vw->clipcount);
			  h = x+(3*vw->clipcount);
			  
			  /* transform clipping-windows */
			  if (0 != saa7146_v4lclip2plain(vw->clips, vw->clipcount,x,y,w,h))
Error --->
			    break;
			  clip_windows(saa, SAA7146_CLIPPING_RECT, vw->width, vw->height,
				       NULL, vw->clipcount, x, y, w, h);
			  kfree(x);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/media/video/bt819.c:183:bt819_attach: ERROR:LEAK:173:183:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/media/video/bt819.c:173:kmalloc]
{
	int i;
	struct bt819 *decoder;
	struct i2c_client *client;

Start --->
	client = kmalloc(sizeof(*client), GFP_KERNEL);
	if(client == NULL)
		return -ENOMEM;
	client_template.adapter = adap;
	client_template.addr = addr;
	memcpy(client, &client_template, sizeof(*client));
	
	decoder = kmalloc(sizeof(struct bt819), GFP_KERNEL);
	if (decoder == NULL) {
		MOD_DEC_USE_COUNT;
Error --->
		return -ENOMEM;
	}

	memset(decoder, 0, sizeof(struct bt819));
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/media/video/bttv-risc.c:381:bttv_risc_overlay: ERROR:LEAK:372:381:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/media/video/bttv-risc.c:372:kmalloc]
	struct SKIPLIST *skips;
	u32 *rp,ri,ra;
	u32 addr;

	/* skip list for window clipping */
Start --->
	if (NULL == (skips = kmalloc(sizeof(*skips) * ov->nclips,GFP_KERNEL)))
		return -ENOMEM;
	
	/* estimate risc mem: worst case is (clip+1) * lines instructions
	   + sync + jump (all 2 dwords) */
	instructions  = (ov->nclips + 1) *
		((skip_even || skip_odd) ? ov->w.height>>1 :  ov->w.height);
	instructions += 2;
	if ((rc = bttv_riscmem_alloc(btv->dev,risc,instructions*8)) < 0)
Error --->
		return rc;

	/* sync instruction */
	rp = risc->cpu;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/media/video/videodev.c:318:videodev_proc_create_dev: ERROR:LEAK:312:318:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/media/video/videodev.c:312:kmalloc]
	struct proc_dir_entry *p;

	if (video_dev_proc_entry == NULL)
		return;

Start --->
	d = kmalloc (sizeof (struct videodev_proc_data), GFP_KERNEL);
	if (!d)
		return;

	p = create_proc_entry(name, S_IFREG|S_IRUGO|S_IWUSR, video_dev_proc_entry);
	if (!p)
Error --->
		return;
	p->data = vfd;
	p->read_proc = videodev_proc_read;

---------------------------------------------------------
[BUG] next-to-last if statement missing an else branch?
/u1/acc/linux/2.5.48/drivers/message/fusion/mptctl.c:1762:mptctl_replace_fw: ERROR:LEAK:1724:1762:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/message/fusion/mptctl.c:1724:mpt_alloc_fw_memory]
		return 0;

	/* Allocate memory for the new FW image
	 */
	newFwSize = karg.newImageSize;
Start --->
	fwmem = mpt_alloc_fw_memory(ioc, newFwSize, &num_frags, &alloc_sz); 

	... DELETED 32 lines ...

	 */
	ioc->facts.FWImageSize = newFwSize;
	if (ioc->alt_ioc)
		ioc->alt_ioc->facts.FWImageSize = newFwSize;

Error --->
	return 0;
}

/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/message/i2o/i2o_core.c:2035:i2o_systab_send: ERROR:LEAK:1921:2035:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/message/i2o/i2o_core.c:1921:kmalloc]
static int i2o_systab_send(struct i2o_controller *iop)
{
	u32 msg[12];
	dma_addr_t sys_tbl_phys;
	int ret;
Start --->
	u32 *privbuf = kmalloc(16, GFP_KERNEL);

	... DELETED 108 lines ...

		dprintk(KERN_INFO "%s: SysTab set.\n", iop->name);
		kfree(privbuf);
	}
	i2o_status_get(iop); // Entered READY state

Error --->
	return ret;	

 }

---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/mtd/chips/cfi_cmdset_0001.c:206:cfi_intelext_setup: ERROR:LEAK:186:206:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/mtd/chips/cfi_cmdset_0001.c:186:kmalloc]
	struct mtd_info *mtd;
	unsigned long offset = 0;
	int i,j;
	unsigned long devsize = (1<<cfi->cfiq->DevSize) * cfi->interleave;

Start --->
	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);

	... DELETED 14 lines ...

	mtd->eraseregions = kmalloc(sizeof(struct mtd_erase_region_info) 
			* mtd->numeraseregions, GFP_KERNEL);
	if (!mtd->eraseregions) { 
		printk(KERN_ERR "Failed to allocate memory for MTD erase region info\n");
		kfree(cfi->cmdset_priv);
Error --->
		return NULL;
	}
	
	for (i=0; i<cfi->cfiq->NumEraseRegions; i++) {
---------------------------------------------------------
[BUG] [GEM] Almost right.
/u1/acc/linux/2.5.48/drivers/mtd/chips/cfi_cmdset_0001.c:230:cfi_intelext_setup: ERROR:LEAK:186:230:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/mtd/chips/cfi_cmdset_0001.c:186:kmalloc]
	struct mtd_info *mtd;
	unsigned long offset = 0;
	int i,j;
	unsigned long devsize = (1<<cfi->cfiq->DevSize) * cfi->interleave;

Start --->
	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);

	... DELETED 38 lines ...

		if (offset != devsize) {
			/* Argh */
			printk(KERN_WARNING "Sum of regions (%lx) != total size of set of interleaved chips (%lx)\n", offset, devsize);
			kfree(mtd->eraseregions);
			kfree(cfi->cmdset_priv);
Error --->
			return NULL;
		}

		for (i=0; i<mtd->numeraseregions;i++){
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/mtd/chips/cfi_cmdset_0002.c:177:cfi_amdstd_setup: ERROR:LEAK:150:177:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/mtd/chips/cfi_cmdset_0002.c:150:kmalloc]
{
	struct cfi_private *cfi = map->fldrv_priv;
	struct mtd_info *mtd;
	unsigned long devsize = (1<<cfi->cfiq->DevSize) * cfi->interleave;

Start --->
	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);

	... DELETED 21 lines ...

		mtd->numeraseregions = cfi->cfiq->NumEraseRegions * cfi->numchips;
		mtd->eraseregions = kmalloc(sizeof(struct mtd_erase_region_info) * mtd->numeraseregions, GFP_KERNEL);
		if (!mtd->eraseregions) { 
			printk(KERN_WARNING "Failed to allocate memory for MTD erase region info\n");
			kfree(cfi->cmdset_priv);
Error --->
			return NULL;
		}
			
		for (i=0; i<cfi->cfiq->NumEraseRegions; i++) {
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/mtd/chips/cfi_cmdset_0002.c:200:cfi_amdstd_setup: ERROR:LEAK:150:200:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/mtd/chips/cfi_cmdset_0002.c:150:kmalloc]
{
	struct cfi_private *cfi = map->fldrv_priv;
	struct mtd_info *mtd;
	unsigned long devsize = (1<<cfi->cfiq->DevSize) * cfi->interleave;

Start --->
	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);

	... DELETED 44 lines ...

		if (offset != devsize) {
			/* Argh */
			printk(KERN_WARNING "Sum of regions (%lx) != total size of set of interleaved chips (%lx)\n", offset, devsize);
			kfree(mtd->eraseregions);
			kfree(cfi->cmdset_priv);
Error --->
			return NULL;
		}
#if 0
		// debug
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/mtd/chips/sharp.c:120:sharp_probe: ERROR:LEAK:114:120:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/mtd/chips/sharp.c:114:kmalloc]
{
	struct mtd_info *mtd = NULL;
	struct sharp_info *sharp = NULL;
	int width;

Start --->
	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);
	if(!mtd)
		return NULL;

	sharp = kmalloc(sizeof(*sharp), GFP_KERNEL);
	if(!sharp)
Error --->
		return NULL;

	memset(mtd, 0, sizeof(*mtd));

---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/mtd/devices/docprobe.c:249:DoC_Probe: ERROR:LEAK:200:249:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/mtd/devices/docprobe.c:200:kmalloc]
	if (!docptr)
		return;
	
	if ((ChipID = doccheck(docptr, physadr))) {
		docfound = 1;
Start --->
		mtd = kmalloc(sizeof(struct DiskOnChip) + sizeof(struct mtd_info), GFP_KERNEL);

	... DELETED 43 lines ...

			return;
		}
		printk(KERN_NOTICE "Cannot find driver for DiskOnChip %s at 0x%lX\n", name, physadr);
	}
	iounmap((void *)docptr);
Error --->
}


/****************************************************************************
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/net/e100/e100_main.c:3808:e100_ethtool_gstrings: ERROR:LEAK:3793:3808:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/net/e100/e100_main.c:3793:kmalloc]

	switch (info.string_set) {
	case ETH_SS_TEST:
		if (info.len > E100_MAX_TEST_RES)
			info.len = E100_MAX_TEST_RES;
Start --->
		strings = kmalloc(info.len * ETH_GSTRING_LEN, GFP_ATOMIC);

	... DELETED 9 lines ...

	default:
		return -EOPNOTSUPP;
	}

	if (copy_to_user(ifr->ifr_data, &info, sizeof (info)))
Error --->
		return -EFAULT;

	if (copy_to_user(usr_strings, strings, info.len * ETH_GSTRING_LEN))
		return -EFAULT;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/net/ewrk3.c:1976:ewrk3_ioctl: ERROR:LEAK:1850:1976:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/net/ewrk3.c:1850:kmalloc]

	/* Other than ethtool, all we handle are private IOCTLs */
	if (cmd != EWRK3IOCTL)
		return -EOPNOTSUPP;

Start --->
	tmp = kmalloc(sizeof(union ewrk3_addr), GFP_KERNEL);

	... DELETED 120 lines ...


		break;
	case EWRK3_GET_STATS: { /* Get the driver statistics */
		struct ewrk3_stats *tmp_stats =
        		kmalloc(sizeof(lp->pktStats), GFP_KERNEL);
Error --->
		if (!tmp_stats) return -ENOMEM;

		spin_lock_irqsave(&lp->hw_lock, flags);
		memcpy(tmp_stats, &lp->pktStats, sizeof(lp->pktStats));
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/net/fc/iph5526.c:3015:tx_ip_packet: ERROR:LEAK:3008:3015:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/net/fc/iph5526.c:3008:look_up_cache]
u_short ox_id = OX_ID_FIRST_SEQUENCE;
u_int mtu;
struct fc_node_info *q;

	ENTER("tx_ip_packet");
Start --->
	q = look_up_cache(fi, skb->data - 2*FC_ALEN);
	if (q != NULL) {
		d_id = q->d_id;
		DPRINTK("Look-Up Cache Succeeded for d_id = %x", d_id);
		mtu = q->mtu;
		if (q->login == LOGIN_COMPLETED){
			fi->g.type_of_frame = FC_IP;
Error --->
			return tx_exchange(fi, skb->data, len, r_ctl, type, d_id, mtu, int_required, ox_id, virt_to_bus(skb));
		}
		
		if (q->d_id == BROADCAST) {
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/net/fc/iph5526.c:3043:tx_ip_packet: ERROR:LEAK:3008:3043:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/net/fc/iph5526.c:3008:look_up_cache]
u_short ox_id = OX_ID_FIRST_SEQUENCE;
u_int mtu;
struct fc_node_info *q;

	ENTER("tx_ip_packet");
Start --->
	q = look_up_cache(fi, skb->data - 2*FC_ALEN);

	... DELETED 29 lines ...

			tx_logi(fi, ELS_PLOGI, d_id); 
		}
	}
	DPRINTK2("Look-Up Cache Failed");
	LEAVE("tx_ip_packet");
Error --->
	return 0;
}

static int tx_arp_packet(char *data, unsigned long len, struct fc_info *fi)
---------------------------------------------------------
[BUG] Probably.
/u1/acc/linux/2.5.48/drivers/net/fc/iph5526.c:3086:tx_arp_packet: ERROR:LEAK:3089:3086:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/net/fc/iph5526.c:3089:look_up_cache]
			q = q->next;
		}
		return return_value;
	}
	else
Error --->
	if (opcode == ARPOP_REPLY) {
	struct fc_node_info *q; u_int mtu;
		DPRINTK("We are sending out an ARP reply");
Start --->
		q = look_up_cache(fi, data - 2*FC_ALEN);
		if (q != NULL) {
			d_id = q->d_id;
			DPRINTK("Look-Up Cache Succeeded for d_id = %x", d_id);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/net/fc/iph5526.c:3099:tx_arp_packet: ERROR:LEAK:3089:3099:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/net/fc/iph5526.c:3089:look_up_cache]
	}
	else
	if (opcode == ARPOP_REPLY) {
	struct fc_node_info *q; u_int mtu;
		DPRINTK("We are sending out an ARP reply");
Start --->
		q = look_up_cache(fi, data - 2*FC_ALEN);
		if (q != NULL) {
			d_id = q->d_id;
			DPRINTK("Look-Up Cache Succeeded for d_id = %x", d_id);
			mtu = q->mtu;
			if (q->login == LOGIN_COMPLETED){
				tx_exchange(fi, data, len, r_ctl, type, d_id, mtu, int_required, ox_id, TYPE_LLC_SNAP);
				/* Some devices support HW_TYPE 0x01 */
				memcpy(fi->g.arp_buffer, data - 2*FC_ALEN, len + 2*FC_ALEN);
				fi->g.arp_buffer[9 + 2*FC_ALEN] = 0x01;
Error --->
				return tx_exchange(fi, (char *)(fi->g.arp_buffer + 2*FC_ALEN), len, r_ctl, type, d_id, my_mtu, int_required, ox_id, TYPE_LLC_SNAP);
			}
			else {
				DPRINTK1("Node not logged in... Txing PLOGI to %x", d_id);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/net/fc/iph5526.c:3667:node_logged_in_prev: ERROR:LEAK:3660:3667:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/net/fc/iph5526.c:3660:look_up_cache]
	memcpy(node_name, buff_addr + 12, NODE_NAME_LEN);
	/* point to port_name in the ADISC payload */
	data += 10 * 4;
	/* point to last 6 bytes of port_name */
	data += 2;
Start --->
	temp = look_up_cache(fi, data);
	if (temp != NULL) {
		if ((temp->d_id == s_id) && (memcmp(node_name, temp->node_name, NODE_NAME_LEN) == 0)) {
			temp->login = LOGIN_COMPLETED;
#if DEBUG_5526_2
			display_cache(fi);
#endif
Error --->
			return TRUE;
		}
	}
	return FALSE;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/net/pcmcia/aironet4500_cs.c:285:awc_attach: ERROR:LEAK:275:285:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/net/pcmcia/aironet4500_cs.c:275:kmalloc]
	link->conf.ConfigIndex = 1;
	link->conf.Present = PRESENT_OPTION;

	/* Create the network device object. */

Start --->
	dev = kmalloc(sizeof(struct net_device ), GFP_KERNEL);
//	dev =  init_etherdev(0, sizeof(struct awc_private) );
	if (!dev ) {
		printk(KERN_CRIT "out of mem on dev alloc \n");
		kfree(link->dev);
		kfree(link);
		return NULL;
	};
	memset(dev,0,sizeof(struct net_device));
	dev->priv = kmalloc(sizeof(struct awc_private), GFP_KERNEL);
Error --->
	if (!dev->priv ) {printk(KERN_CRIT "out of mem on dev priv alloc \n"); return NULL;};
	memset(dev->priv,0,sizeof(struct awc_private));
	
//	link->dev->minor = dev->minor;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/net/tokenring/madgemc.c:356:madgemc_probe: ERROR:LEAK:194:356:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/net/tokenring/madgemc.c:194:kmalloc]
		 * Fetch MCA config registers
		 */
		for(i=0;i<4;i++)
			posreg[i] = mca_read_stored_pos(slot, i+2);
		
Start --->
		card = kmalloc(sizeof(struct madgemc_card), GFP_KERNEL);

	... DELETED 156 lines ...


		/* XXX is ISA_MAX_ADDRESS correct here? */
		if (tmsdev_init(dev, ISA_MAX_ADDRESS, NULL)) {
			printk("%s: unable to get memory for dev->priv.\n", 
			       dev->name);
Error --->
			return -1;
		}
		tp = (struct net_local *)dev->priv;

---------------------------------------------------------
[BUG] Looks possible but hard to tell for sure.
/u1/acc/linux/2.5.48/drivers/net/wan/pc300_tty.c:815:cpc_tty_receive: ERROR:LEAK:827:815:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/net/wan/pc300_tty.c:827:kmalloc]
			if (dsr_rx & DSR_BOF) {
				/* update EDA */ 
				cpc_writel(card->hw.scabase + DRX_REG(EDAL, ch), 
						RX_BD_ADDR(ch, pc300chan->rx_last_bd)); 
			}
Error --->
			return; 
		}
		
		if (rx_len > CPC_TTY_MAX_MTU) { 
			/* Free RX descriptors */ 
			CPC_TTY_DBG("%s: frame size is invalid.\n",cpc_tty->name);
			stats->rx_errors++; 
			stats->rx_frame_errors++; 
			cpc_tty_rx_disc_frame(pc300chan);
			continue;
		} 
		
Start --->
		new = (st_cpc_rx_buf *) kmalloc(rx_len + sizeof(st_cpc_rx_buf), GFP_ATOMIC);
		if (new == 0) {
			cpc_tty_rx_disc_frame(pc300chan);
			continue;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/interface.c:239:pnp_show_possible_resources: ERROR:LEAK:225:239:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/interface.c:225:pnp_alloc]
	struct pnp_resources * res = dev->res;
	int dep = 0;
	pnp_info_buffer_t *buffer;
	if (off)
		return 0;
Start --->
	buffer = (pnp_info_buffer_t *) pnp_alloc(sizeof(pnp_info_buffer_t));
	if (!buffer)
		return -ENOMEM;
	buffer->len = PAGE_SIZE;
	buffer->buffer = buf;
	buffer->curr = buffer->buffer;
	while (res){
		if (dep == 0)
			pnp_print_resources(buffer, "", res, dep);
		else
			pnp_print_resources(buffer, "   ", res, dep);
		res = res->dep;
		dep++;
	}
Error --->
	return (buffer->curr - buf);
}

static DEVICE_ATTR(possible,S_IRUGO,pnp_show_possible_resources,NULL);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/isapnp/core.c:427:isapnp_parse_id: ERROR:LEAK:423:427:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/isapnp/core.c:423:isapnp_alloc]
 *  Parse EISA id.
 */

static void isapnp_parse_id(struct pnp_dev * dev, unsigned short vendor, unsigned short device)
{
Start --->
	struct pnp_id * id = isapnp_alloc(sizeof(struct pnp_id));
	if (!id)
		return;
	if (!dev)
Error --->
		return;
	sprintf(id->id, "%c%c%c%x%x%x%x",
			'A' + ((vendor >> 2) & 0x3f) - 1,
			'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1265:pnpbios_get_resources: ERROR:LEAK:1261:1265:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1261:pnpbios_kmalloc]
	struct pnp_dev_node_info node_info;
	u8 nodenum = dev->number;
	struct pnp_bios_node * node;
	if (pnp_bios_dev_node_info(&node_info) != 0)
		return -ENODEV;
Start --->
	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
	if (!node)
		return -1;
	if (pnp_bios_get_dev_node(&nodenum, (char )0, node))
Error --->
		return -ENODEV;
	node_current_resource_data_to_dev(node,dev);
	kfree(node);
	return 0;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1279:pnpbios_set_resources: ERROR:LEAK:1276:1279:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1276:pnpbios_kmalloc]
static int pnpbios_set_resources(struct pnp_dev *dev, struct pnp_cfg *config, char flags)
{
	struct pnp_dev_node_info node_info;
	u8 nodenum = dev->number;
	struct pnp_bios_node * node;
Start --->
	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);

	if (pnp_bios_dev_node_info(&node_info) != 0)
Error --->
		return -ENODEV;
	if (!node)
		return -1;
	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1328:pnpbios_disable_resources: ERROR:LEAK:1293:1328:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1293:kmalloc]
	return 0;
}

static int pnpbios_disable_resources(struct pnp_dev *dev)
{
Start --->
	struct pnp_cfg * config = kmalloc(sizeof(struct pnp_cfg), GFP_KERNEL);

	... DELETED 29 lines ...

	struct pnp_bios_node * node;
	if (!config)
		return -1;
	memset(config, 0, sizeof(struct pnp_cfg));
	if (!dev || !dev->active)
Error --->
		return -EINVAL;
	for (i=0; i <= 8; i++)
		config->port[i] = &port;
	for (i=0; i <= 4; i++)
---------------------------------------------------------
[BUG] Same as above.
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1340:pnpbios_disable_resources: ERROR:LEAK:1293:1340:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1293:kmalloc]
	return 0;
}

static int pnpbios_disable_resources(struct pnp_dev *dev)
{
Start --->
	struct pnp_cfg * config = kmalloc(sizeof(struct pnp_cfg), GFP_KERNEL);

	... DELETED 41 lines ...

	for (i=0; i <= 2; i++)
		config->dma[i] = &dma;
	dev->active = 0;

	if (pnp_bios_dev_node_info(&node_info) != 0)
Error --->
		return -ENODEV;
	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
	if (!node)
		return -1;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1343:pnpbios_disable_resources: ERROR:LEAK:1293:1343:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1293:kmalloc]
	return 0;
}

static int pnpbios_disable_resources(struct pnp_dev *dev)
{
Start --->
	struct pnp_cfg * config = kmalloc(sizeof(struct pnp_cfg), GFP_KERNEL);

	... DELETED 44 lines ...


	if (pnp_bios_dev_node_info(&node_info) != 0)
		return -ENODEV;
	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
	if (!node)
Error --->
		return -1;
	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
		goto failed;
	if(node_set_resources(node, config)<0)
---------------------------------------------------------
[BUG] If second malloc in loop fails.
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1445:build_devlist: ERROR:LEAK:1411:1445:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1411:pnpbios_kmalloc]
		 * BIOSes to crash.
		 */
		if (pnp_bios_get_dev_node(&nodenum, (char )0 , node))
			break;
		nodes_got++;
Start --->
		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);

	... DELETED 28 lines ...

	}
	kfree(node);

	printk(KERN_INFO "PnPBIOS: %i node%s reported by PnP BIOS; %i recorded by driver\n",
		nodes_got, nodes_got != 1 ? "s" : "", devs);
Error --->
}

/*
 *
---------------------------------------------------------
[BUG] Not sure.
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/proc.c:170:proc_read_node: ERROR:LEAK:167:170:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/pnpbios/proc.c:167:pnpbios_kmalloc]
	struct pnp_bios_node *node;
	int boot = (long)data >> 8;
	u8 nodenum = (long)data;
	int len;

Start --->
	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
	if (!node) return -ENOMEM;
	if (pnp_bios_get_dev_node(&nodenum, boot, node))
Error --->
		return -EIO;
	len = node->size - sizeof(struct pnp_bios_node);
	memcpy(buf, node->data, len);
	kfree(node);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/proc.c:187:proc_write_node: ERROR:LEAK:184:187:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/pnpbios/proc.c:184:pnpbios_kmalloc]
{
	struct pnp_bios_node *node;
	int boot = (long)data >> 8;
	u8 nodenum = (long)data;

Start --->
	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
	if (!node) return -ENOMEM;
	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
Error --->
		return -EIO;
	if (count != node->size - sizeof(struct pnp_bios_node))
		return -EINVAL;
	memcpy(node->data, buf, count);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/proc.c:189:proc_write_node: ERROR:LEAK:184:189:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/pnpbios/proc.c:184:pnpbios_kmalloc]
{
	struct pnp_bios_node *node;
	int boot = (long)data >> 8;
	u8 nodenum = (long)data;

Start --->
	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
	if (!node) return -ENOMEM;
	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
		return -EIO;
	if (count != node->size - sizeof(struct pnp_bios_node))
Error --->
		return -EINVAL;
	memcpy(node->data, buf, count);
	if (pnp_bios_set_dev_node(node->handle, boot, node) != 0)
	    return -EINVAL;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/proc.c:92:proc_read_escd: ERROR:LEAK:88:92:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/pnpbios/proc.c:88:pnpbios_kmalloc]
	if (escd.escd_size > MAX_SANE_ESCD_SIZE) {
		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size reported by BIOS escd_info call is too great\n");
		return -EFBIG;
	}

Start --->
	tmpbuf = pnpbios_kmalloc(escd.escd_size, GFP_KERNEL);
	if (!tmpbuf) return -ENOMEM;

	if (pnp_bios_read_escd(tmpbuf, escd.nv_storage_base))
Error --->
		return -EIO;

	escd_size = (unsigned char)(tmpbuf[0]) + (unsigned char)(tmpbuf[1])*256;

---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/proc.c:99:proc_read_escd: ERROR:LEAK:88:99:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/pnpbios/proc.c:88:pnpbios_kmalloc]
	if (escd.escd_size > MAX_SANE_ESCD_SIZE) {
		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size reported by BIOS escd_info call is too great\n");
		return -EFBIG;
	}

Start --->
	tmpbuf = pnpbios_kmalloc(escd.escd_size, GFP_KERNEL);
	if (!tmpbuf) return -ENOMEM;

	if (pnp_bios_read_escd(tmpbuf, escd.nv_storage_base))
		return -EIO;

	escd_size = (unsigned char)(tmpbuf[0]) + (unsigned char)(tmpbuf[1])*256;

	/* sanity check */
	if (escd_size > MAX_SANE_ESCD_SIZE) {
		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size reported by BIOS read_escd call is too great\n");
Error --->
		return -EFBIG;
	}

	escd_left_to_read = escd_size - pos;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/quirks.c:44:quirk_awe32_resources: ERROR:LEAK:41:44:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/quirks.c:41:pnp_alloc]
	 * into the PnP discovery sequence, and cannot be used. Link in the
	 * two extra ports (at offset 0x400 and 0x800 from the one given) by
	 * hand.
	 */
	for ( ; res ; res = res->dep ) {
Start --->
		port2 = pnp_alloc(sizeof(struct pnp_port));
		port3 = pnp_alloc(sizeof(struct pnp_port));
		if (!port2 || !port3)
Error --->
			return;
		port = res->port;
		memcpy(port2, port, sizeof(struct pnp_port));
		memcpy(port3, port, sizeof(struct pnp_port));
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/resource.c:823:pnp_raw_set_dev: ERROR:LEAK:820:823:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/resource.c:820:pnp_generate_config]
int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, int mode)
{
	struct pnp_cfg *config;
	if (!dev)
		return -EINVAL;
Start --->
        config = pnp_generate_config(dev,depnum);
	if (dev->driver){
		printk(KERN_INFO "pnp: Unable to set resources becuase the PnP device '%s' is busy\n", dev->dev.bus_id);
Error --->
		return -EINVAL;
	}
	if (!dev->protocol->get || !dev->protocol->set)
		return -EINVAL;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/resource.c:826:pnp_raw_set_dev: ERROR:LEAK:820:826:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/pnp/resource.c:820:pnp_generate_config]
int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, int mode)
{
	struct pnp_cfg *config;
	if (!dev)
		return -EINVAL;
Start --->
        config = pnp_generate_config(dev,depnum);
	if (dev->driver){
		printk(KERN_INFO "pnp: Unable to set resources becuase the PnP device '%s' is busy\n", dev->dev.bus_id);
		return -EINVAL;
	}
	if (!dev->protocol->get || !dev->protocol->set)
Error --->
		return -EINVAL;
	if (!config)
		return -EINVAL;
	if (pnp_generate_request(config)==0)
---------------------------------------------------------
[BUG] Maybe.
/u1/acc/linux/2.5.48/drivers/scsi/scsi_scan.c:1730:scsi_report_lun_scan: ERROR:LEAK:1706:1730:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/scsi/scsi_scan.c:1706:scsi_allocate_request]
		/*
		 * We are out of memory, don't try scanning any further.
		 */
		return 0;
	}
Start --->
	sreq = scsi_allocate_request(sdevscan);

	... DELETED 18 lines ...

		printk(ALLOC_FAILURE_MSG, __FUNCTION__);
		scsi_release_commandblocks(sdevscan);
		/*
		 * We are out of memory, don't try scanning any further.
		 */
Error --->
		return 0;
	}

	scsi_cmd[0] = REPORT_LUNS;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/scsi/sr_ioctl.c:188:sr_do_ioctl: ERROR:LEAK:85:188:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/scsi/sr_ioctl.c:85:scsi_allocate_request]
        struct request *req;
	int result, err = 0, retries = 0;
	char *bounce_buffer;

	SDev = cd->device;
Start --->
	SRpnt = scsi_allocate_request(SDev);

	... DELETED 97 lines ...

	/* Wake up a process waiting for device */
	scsi_release_request(SRpnt);
	SRpnt = NULL;
      out:
	cgc->stat = err;
Error --->
	return err;
}

/* ---------------------------------------------------------------------- */
---------------------------------------------------------
[BUG] Leaking tmp_ba
/u1/acc/linux/2.5.48/drivers/scsi/st.c:3686:st_attach: ERROR:LEAK:3704:3686:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/scsi/st.c:3704:kmalloc]
		printk(KERN_ERR "st: out of memory. Device not attached.\n");
		return 1;
	}

	write_lock(&st_dev_arr_lock);
Error --->
	if (st_nr_dev >= st_dev_max) {

	... DELETED 12 lines ...

			scsi_slave_detach(SDp);
			return 1;
		}

		tmp_da = kmalloc(tmp_dev_max * sizeof(Scsi_Tape *), GFP_ATOMIC);
Start --->
		tmp_ba = kmalloc(tmp_dev_max * sizeof(ST_buffer *), GFP_ATOMIC);
		if (tmp_da == NULL || tmp_ba == NULL) {
			if (tmp_da != NULL)
				kfree(tmp_da);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/usb/class/bluetty.c:1240:usb_bluetooth_probe: ERROR:LEAK:1172:1240:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/usb/class/bluetty.c:1172:usb_alloc_urb]
	bluetooth->bulk_out_endpointAddress = endpoint->bEndpointAddress;
	bluetooth->bulk_out_buffer_size = endpoint->wMaxPacketSize * 2;

	/* create our write urb pool */ 
	for (i = 0; i < NUM_BULK_URBS; ++i) {
Start --->
		struct urb  *urb = usb_alloc_urb(0, GFP_KERNEL);

	... DELETED 62 lines ...

	bluetooth_table[minor] = NULL;

	/* free up any memory that we allocated */
	kfree (bluetooth);
	MOD_DEC_USE_COUNT;
Error --->
	return -EIO;
}


---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/usb/class/cdc-acm.c:612:acm_probe: ERROR:LEAK:602:612:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/usb/class/cdc-acm.c:602:kmalloc]
		acm->minor = minor;
		acm->dev = dev;

		INIT_WORK(&acm->work, acm_softint, acm);

Start --->
		if (!(buf = kmalloc(ctrlsize + readsize + acm->writesize, GFP_KERNEL))) {
			err("out of memory");
			kfree(acm);
			return -ENOMEM;
		}

		acm->ctrlurb = usb_alloc_urb(0, GFP_KERNEL);
		if (!acm->ctrlurb) {
			err("out of memory");
			kfree(acm);
Error --->
			return -ENOMEM;
		}
		acm->readurb = usb_alloc_urb(0, GFP_KERNEL);
		if (!acm->readurb) {
---------------------------------------------------------
[BUG] Also, hid_set_field reads uninitialized data.
/u1/acc/linux/2.5.48/drivers/usb/input/pid.c:139:hid_pid_erase: ERROR:LEAK:135:139:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/usb/input/pid.c:135:kmalloc]
		printk("Couldn't find report\n");
		return ret;
	}

	/* Find field */
Start --->
	field = (struct hid_field *) kmalloc(sizeof(struct hid_field), GFP_KERNEL);
	ret = hid_set_field(field, ret, pid->effects[id].device_id);
	if(!ret) {
		printk("Couldn't set field\n");
Error --->
		return ret;
	}

	hid_submit_report(hid, report, USB_DIR_OUT);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/usb/input/pid.c:149:hid_pid_erase: ERROR:LEAK:135:149:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/usb/input/pid.c:135:kmalloc]
		printk("Couldn't find report\n");
		return ret;
	}

	/* Find field */
Start --->
	field = (struct hid_field *) kmalloc(sizeof(struct hid_field), GFP_KERNEL);
	ret = hid_set_field(field, ret, pid->effects[id].device_id);
	if(!ret) {
		printk("Couldn't set field\n");
		return ret;
	}

	hid_submit_report(hid, report, USB_DIR_OUT);

	spin_lock_irqsave(&pid->lock, flags);
	hid_pid_ctrl_playback(hid, pid->effects + id, 0);
	pid->effects[id].flags = 0;
	spin_unlock_irqrestore(&pid->lock, flags);

Error --->
	return ret;
}

/* Erase all effects this process owns */
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/usb/misc/atmsar.c:298:atmsar_open: ERROR:LEAK:292:298:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/usb/misc/atmsar.c:292:kmalloc]
struct atmsar_vcc_data *atmsar_open (struct atmsar_vcc_data **list, struct atm_vcc *vcc, uint type,
				     ushort vpi, ushort vci, unchar pti, unchar gfc, uint flags)
{
	struct atmsar_vcc_data *new;

Start --->
	new = kmalloc (sizeof (struct atmsar_vcc_data), GFP_KERNEL);

	if (!new)
		return NULL;

	if (!vcc)
Error --->
		return NULL;

	memset (new, 0, sizeof (struct atmsar_vcc_data));
	new->vcc = vcc;
---------------------------------------------------------
[BUG] Maybe.
/u1/acc/linux/2.5.48/drivers/video/aty/atyfb_base.c:2451:atyfb_init: ERROR:LEAK:2030:2451:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/video/aty/atyfb_base.c:2030:kmalloc]
				if (pdev->device == aty_chips[i].pci_id)
					break;
			if (i < 0)
				continue;

Start --->
			info =

	... DELETED 415 lines ...

			/* This is insufficient! kernel_map has added two large chunks!! */
			return -ENXIO;
		}
	}
#endif				/* CONFIG_ATARI */
Error --->
	return 0;
}

#ifndef MODULE
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/video/radeonfb.c:787:radeonfb_pci_register: ERROR:LEAK:687:787:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/video/radeonfb.c:687:kmalloc]
	int i, j;
	char *bios_seg = NULL;

	RTRACE("radeonfb_pci_register BEGIN\n");

Start --->
	rinfo = kmalloc (sizeof (struct radeonfb_info), GFP_KERNEL);

	... DELETED 94 lines ...

		case PCI_DEVICE_ID_RADEON_LZ:
			strcpy(rinfo->name, "Radeon M6 LZ ");
			rinfo->hasCRTC2 = 1;
			break;
		default:
Error --->
			return -ENODEV;
	}

	/* framebuffer size */
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/cifs/transport.c:47:AllocMidQEntry: ERROR:LEAK:46:47:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/cifs/transport.c:46:kmalloc]
/* BB add spinlock to protect midq for each session BB */
	if (ses == NULL) {
		cERROR(1, ("\nNull session passed in to AllocMidQEntry "));
		return NULL;
	}
Start --->
	temp = kmalloc(sizeof (struct mid_q_entry), GFP_KERNEL);
Error --->
	temp = (struct mid_q_entry *) kmem_cache_alloc(cifs_mid_cachep,
						       SLAB_KERNEL);
	if (temp == NULL)
		return temp;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:120:vxfs_read_fshead: ERROR:LEAK:114:120:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:114:vxfs_blkiget]
{
	struct vxfs_sb_info		*infp = VXFS_SBI(sbp);
	struct vxfs_fsh			*pfp, *sfp;
	struct vxfs_inode_info		*vip, *tip;

Start --->
	if (!(vip = vxfs_blkiget(sbp, infp->vsi_iext, infp->vsi_fshino))) {
		printk(KERN_ERR "vxfs: unabled to read fsh inode\n");
		return -EINVAL;
	} else if (!VXFS_ISFSH(vip)) {
		printk(KERN_ERR "vxfs: fsh list inode is of wrong type (%x)\n",
				vip->vii_mode & VXFS_TYPE_MASK); 
Error --->
		return -EINVAL;
	}


---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:145:vxfs_read_fshead: ERROR:LEAK:134:145:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:134:vxfs_getfsh]
	if (!(infp->vsi_fship = vxfs_get_fake_inode(sbp, vip))) {
		printk(KERN_ERR "vxfs: unabled to get fsh inode\n");
		return -EINVAL;
	}

Start --->
	if (!(sfp = vxfs_getfsh(infp->vsi_fship, 0))) {
		printk(KERN_ERR "vxfs: unabled to get structural fsh\n");
		return -EINVAL;
	} 

#ifdef DIAGNOSTIC
	vxfs_dumpfsh(sfp);
#endif

	if (!(pfp = vxfs_getfsh(infp->vsi_fship, 1))) {
		printk(KERN_ERR "vxfs: unabled to get primary fsh\n");
Error --->
		return -EINVAL;
	}

#ifdef DIAGNOSTIC
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:155:vxfs_read_fshead: ERROR:LEAK:143:155:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:143:vxfs_getfsh]

#ifdef DIAGNOSTIC
	vxfs_dumpfsh(sfp);
#endif

Start --->
	if (!(pfp = vxfs_getfsh(infp->vsi_fship, 1))) {
		printk(KERN_ERR "vxfs: unabled to get primary fsh\n");
		return -EINVAL;
	}

#ifdef DIAGNOSTIC
	vxfs_dumpfsh(pfp);
#endif

	tip = vxfs_blkiget(sbp, infp->vsi_iext, sfp->fsh_ilistino[0]);
	if (!tip || ((infp->vsi_stilist = vxfs_get_fake_inode(sbp, tip)) == NULL)) {
		printk(KERN_ERR "vxfs: unabled to get structual list inode\n");
Error --->
		return -EINVAL;
	} else if (!VXFS_ISILT(VXFS_INO(infp->vsi_stilist))) {
		printk(KERN_ERR "vxfs: structual list inode is of wrong type (%x)\n",
				VXFS_INO(infp->vsi_stilist)->vii_mode & VXFS_TYPE_MASK); 
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:159:vxfs_read_fshead: ERROR:LEAK:143:159:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:143:vxfs_getfsh]

#ifdef DIAGNOSTIC
	vxfs_dumpfsh(sfp);
#endif

Start --->
	if (!(pfp = vxfs_getfsh(infp->vsi_fship, 1))) {

	... DELETED 10 lines ...

		printk(KERN_ERR "vxfs: unabled to get structual list inode\n");
		return -EINVAL;
	} else if (!VXFS_ISILT(VXFS_INO(infp->vsi_stilist))) {
		printk(KERN_ERR "vxfs: structual list inode is of wrong type (%x)\n",
				VXFS_INO(infp->vsi_stilist)->vii_mode & VXFS_TYPE_MASK); 
Error --->
		return -EINVAL;
	}

	tip = vxfs_stiget(sbp, pfp->fsh_ilistino[0]);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:165:vxfs_read_fshead: ERROR:LEAK:143:165:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:143:vxfs_getfsh]

#ifdef DIAGNOSTIC
	vxfs_dumpfsh(sfp);
#endif

Start --->
	if (!(pfp = vxfs_getfsh(infp->vsi_fship, 1))) {

	... DELETED 16 lines ...

	}

	tip = vxfs_stiget(sbp, pfp->fsh_ilistino[0]);
	if (!tip || ((infp->vsi_ilist = vxfs_get_fake_inode(sbp, tip)) == NULL)) {
		printk(KERN_ERR "vxfs: unabled to get inode list inode\n");
Error --->
		return -EINVAL;
	} else if (!VXFS_ISILT(VXFS_INO(infp->vsi_ilist))) {
		printk(KERN_ERR "vxfs: inode list inode is of wrong type (%x)\n",
				VXFS_INO(infp->vsi_ilist)->vii_mode & VXFS_TYPE_MASK);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:169:vxfs_read_fshead: ERROR:LEAK:143:169:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:143:vxfs_getfsh]

#ifdef DIAGNOSTIC
	vxfs_dumpfsh(sfp);
#endif

Start --->
	if (!(pfp = vxfs_getfsh(infp->vsi_fship, 1))) {

	... DELETED 20 lines ...

		printk(KERN_ERR "vxfs: unabled to get inode list inode\n");
		return -EINVAL;
	} else if (!VXFS_ISILT(VXFS_INO(infp->vsi_ilist))) {
		printk(KERN_ERR "vxfs: inode list inode is of wrong type (%x)\n",
				VXFS_INO(infp->vsi_ilist)->vii_mode & VXFS_TYPE_MASK);
Error --->
		return -EINVAL;
	}

	return 0;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:172:vxfs_read_fshead: ERROR:LEAK:143:172:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/freevxfs/vxfs_fshead.c:143:vxfs_getfsh]

#ifdef DIAGNOSTIC
	vxfs_dumpfsh(sfp);
#endif

Start --->
	if (!(pfp = vxfs_getfsh(infp->vsi_fship, 1))) {

	... DELETED 23 lines ...

		printk(KERN_ERR "vxfs: inode list inode is of wrong type (%x)\n",
				VXFS_INO(infp->vsi_ilist)->vii_mode & VXFS_TYPE_MASK);
		return -EINVAL;
	}

Error --->
	return 0;
}
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/isofs/rock.c:151:find_rock_ridge_relocation: ERROR:LEAK:150:151:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/isofs/rock.c:150:kmalloc]
      default:
	break;
      }
    }
  }
Start --->
  MAYBE_CONTINUE(repeat, inode);
Error --->
  return retval;
 out:
  if(buffer) kfree(buffer);
  return retval;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/isofs/rock.c:225:get_rock_ridge_filename: ERROR:LEAK:224:225:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/isofs/rock.c:224:kmalloc]
      default:
	break;
      }
    }
  }
Start --->
  MAYBE_CONTINUE(repeat,inode);
Error --->
  return retnamlen; /* If 0, this file did not have a NM field */
 out:
  if(buffer) kfree(buffer);
  return 0;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/isofs/rock.c:425:parse_rock_ridge_inode_internal: ERROR:LEAK:424:425:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/isofs/rock.c:424:kmalloc]
      default:
	break;
      }
    }
  }
Start --->
  MAYBE_CONTINUE(repeat,inode);
Error --->
  return 0;
 out:
  if(buffer) kfree(buffer);
  return 0;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/isofs/rock.c:579:rock_ridge_symlink_readpage: ERROR:LEAK:569:579:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/isofs/rock.c:569:kmalloc]
			CHECK_CE;
		default:
			break;
		}
	}
Start --->
	MAYBE_CONTINUE(repeat, inode);

	if (rpnt == link)
		goto fail;
	brelse(bh);
	*rpnt = '\0';
	unlock_kernel();
	SetPageUptodate(page);
	kunmap(page);
	unlock_page(page);
Error --->
	return 0;

	/* error exit from macro */
      out:
---------------------------------------------------------
[BUG] similar.
/u1/acc/linux/2.5.48/fs/jffs/intrep.c:935:jffs_scan_flash: ERROR:LEAK:1033:935:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/jffs/intrep.c:1033:jffs_alloc_node]
						       "offset = %u, erase_size = %d\n",
						       offset , fmc->sector_size);

						flash_safe_release(fmc->mtd);
						kfree (read_buf);
Error --->
						return -1; /* bad, bad, bad! */

	... DELETED 92 lines ...

		}/* switch */

		/* We have found the beginning of an inode.  Create a
		   node for it unless there already is one available.  */
		if (!node) {
Start --->
			if (!(node = jffs_alloc_node())) {
				/* Free read buffer */
				kfree (read_buf);

---------------------------------------------------------
[BUG] Looks bad, hard to tell for sure.
/u1/acc/linux/2.5.48/fs/jffs/intrep.c:941:jffs_scan_flash: ERROR:LEAK:1033:941:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/jffs/intrep.c:1033:jffs_alloc_node]

					}
					flash_safe_release(fmc->mtd);
					kfree (read_buf);

Error --->
					return -EAGAIN; /* erased offending sector. Try mount one more time please. */

	... DELETED 86 lines ...

		}/* switch */

		/* We have found the beginning of an inode.  Create a
		   node for it unless there already is one available.  */
		if (!node) {
Start --->
			if (!(node = jffs_alloc_node())) {
				/* Free read buffer */
				kfree (read_buf);

---------------------------------------------------------
[BUG] Looks bad.
/u1/acc/linux/2.5.48/fs/jffs2/erase.c:326:jffs2_mark_erased_blocks: ERROR:LEAK:278:326:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/jffs2/erase.c:278:jffs2_alloc_raw_node_ref]
		jeb = list_entry(c->erase_complete_list.next, struct jffs2_eraseblock, list);
		list_del(&jeb->list);
		spin_unlock_bh(&c->erase_completion_lock);

		if (!jffs2_cleanmarker_oob(c)) {
Start --->
			marker_ref = jffs2_alloc_raw_node_ref();

	... DELETED 42 lines ...


						list_add_tail(&jeb->list, &c->bad_list);
						c->nr_erasing_blocks--;
						spin_unlock_bh(&c->erase_completion_lock);
						wake_up(&c->erase_wait);
Error --->
						return;
					}
				}
				ofs += readlen;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/jffs2/readinode.c:124:jffs2_add_full_dnode_to_fraglist: ERROR:LEAK:83:124:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/jffs2/readinode.c:83:jffs2_alloc_node_frag]
	struct jffs2_node_frag *this, **prev, *old;
	struct jffs2_node_frag *newfrag, *newfrag2;
	uint32_t lastend = 0;


Start --->
	newfrag = jffs2_alloc_node_frag();

	... DELETED 35 lines ...

		/* We did */
		if (lastend < fn->ofs) {
			/* ... and we need to put a hole in before the new node */
			struct jffs2_node_frag *holefrag = jffs2_alloc_node_frag();
			if (!holefrag)
Error --->
				return -ENOMEM;
			holefrag->ofs = lastend;
			holefrag->size = fn->ofs - lastend;
			holefrag->next = NULL;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/quota_v2.c:309:find_free_dqentry: ERROR:LEAK:294:309:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/quota_v2.c:294:getdqbuf]
	struct v2_disk_dqblk *ddquot;
	struct v2_disk_dqblk fakedquot;
	dqbuf_t buf;

	*err = 0;
Start --->
	if (!(buf = getdqbuf())) {

	... DELETED 9 lines ...

	}
	else {
		blk = get_free_dqblk(filp, info);
		if ((int)blk < 0) {
			*err = blk;
Error --->
			return 0;
		}
		memset(buf, 0, V2_DQBLKSIZE);
		info->u.v2_i.dqi_free_entry = blk;	/* This is enough as block is already zeroed and entry list is empty... */
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/ufs/util.c:51:_ubh_bread_: ERROR:LEAK:36:51:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/ufs/util.c:36:kmalloc]
	if (size & ~uspi->s_fmask)
		return NULL;
	count = size >> uspi->s_fshift;
	if (count > UFS_MAXFRAG)
		return NULL;
Start --->
	ubh = (struct ufs_buffer_head *)

	... DELETED 9 lines ...

		ubh->bh[i] = NULL;
	return ubh;
failed:
	for (j = 0; j < i; j++)
		brelse (ubh->bh[j]);
Error --->
	return NULL;
}

struct ufs_buffer_head * ubh_bread_uspi (struct ufs_sb_private_info * uspi,
---------------------------------------------------------
[BUG] Only possible if the argument len == 0.
/u1/acc/linux/2.5.48/fs/xfs/pagebuf/page_buf.c:966:pagebuf_get_no_daddr: ERROR:LEAK:966:966:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/xfs/pagebuf/page_buf.c:966:kmalloc]
			"pb_get_no_daddr NOT block 0x%p mask 0x%p len %d\n",
				rmem, ((size_t)rmem & (size_t)~SECTOR_MASK),
				len);
			*/
		}

Error --->
		if ((rmem = kmalloc(tlen, GFP_KERNEL)) == 0) {
			pagebuf_free(pb);
			return NULL;
		}
---------------------------------------------------------
[BUG] Not sure.  Code path is complicated.
/u1/acc/linux/2.5.48/fs/xfs/xfs_da_btree.c:2221:xfs_da_do_buf: ERROR:LEAK:2179:2221:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/xfs/xfs_da_btree.c:2179:xfs_da_buf_make]
	 * Build a dabuf structure.
	 */
	if (bplist) {
		rbp = xfs_da_buf_make(nbplist, bplist, ra);
	} else if (bp)
Start --->
		rbp = xfs_da_buf_make(1, &bp, ra);

	... DELETED 36 lines ...

	if (mapp != &map) {
		kmem_free(mapp, sizeof(*mapp) * nfsb);
	}
	if (bpp)
		*bpp = rbp;
Error --->
	return 0;
exit1:
	if (bplist) {
		for (i = 0; i < nbplist; i++)
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/xfs/xfs_dir_leaf.c:651:xfs_dir_leaf_to_shortform: ERROR:LEAK:645:651:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/xfs/xfs_dir_leaf.c:645:kmem_alloc]
	char *tmpbuffer;
	int retval, i;
	xfs_dabuf_t *bp;

	dp = iargs->dp;
Start --->
	tmpbuffer = kmem_alloc(XFS_LBSIZE(dp->i_mount), KM_SLEEP);
	ASSERT(tmpbuffer != NULL);

	retval = xfs_da_read_buf(iargs->trans, iargs->dp, 0, -1, &bp,
					       XFS_DATA_FORK);
	if (retval)
Error --->
		return(retval);
	ASSERT(bp != NULL);
	memcpy(tmpbuffer, bp->data, XFS_LBSIZE(dp->i_mount));
	leaf = (xfs_dir_leafblock_t *)tmpbuffer;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/xfs/xfs_log_recover.c:1304:xlog_recover_add_to_trans: ERROR:LEAK:1294:1304:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/xfs/xfs_log_recover.c:1294:kmem_zalloc]
	xlog_recover_item_t	 *item;
	xfs_caddr_t		 ptr;

	if (!len)
		return 0;
Start --->
	ptr = kmem_zalloc(len, 0);
	memcpy(ptr, dp, len);

	in_f = (xfs_inode_log_format_t *)ptr;
	item = trans->r_itemq;
	if (item == 0) {
		ASSERT(*(uint *)dp == XFS_TRANS_HEADER_MAGIC);
		if (len == sizeof(xfs_trans_header_t))
			xlog_recover_add_item(&trans->r_itemq);
		memcpy(&trans->r_theader, dp, len); /* d, s, l */
Error --->
		return 0;
	}
	if (item->ri_prev->ri_total != 0 &&
	     item->ri_prev->ri_total == item->ri_prev->ri_cnt) {
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/init/do_mounts.c:707:rd_load_image: ERROR:LEAK:649:707:Memory leak [Allocated from: /u1/acc/linux/2.5.48/init/do_mounts.c:649:kmalloc]
	}
		
	/*
	 * OK, time to copy in the data
	 */
Start --->
	buf = kmalloc(BLOCK_SIZE, GFP_KERNEL);

	... DELETED 52 lines ...

noclose_input:
	close(out_fd);
out:
	sys_unlink("/dev/ram");
#endif
Error --->
	return res;
}

static int __init rd_load_disk(int n)
---------------------------------------------------------
[BUG] [GEM] The case where __dev_get_by_index() returns 0, followed by goto out.
/u1/acc/linux/2.5.48/net/ipv4/route.c:2229:inet_rtm_getroute: ERROR:LEAK:2166:2229:Memory leak [Allocated from: /u1/acc/linux/2.5.48/net/ipv4/route.c:2166:alloc_skb]
	u32 src = 0;
	int iif = 0;
	int err = -ENOBUFS;
	struct sk_buff *skb;

Start --->
	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);

	... DELETED 57 lines ...

	}

	err = netlink_unicast(rtnl, skb, NETLINK_CB(in_skb).pid, MSG_DONTWAIT);
	if (err > 0)
		err = 0;
Error --->
out:	return err;
}

int ip_rt_dump(struct sk_buff *skb,  struct netlink_callback *cb)
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/net/ipv6/route.c:1583:inet6_rtm_getroute: ERROR:LEAK:1556:1583:Memory leak [Allocated from: /u1/acc/linux/2.5.48/net/ipv6/route.c:1556:alloc_skb]
	int err;
	struct sk_buff *skb;
	struct flowi fl;
	struct rt6_info *rt;

Start --->
	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);

	... DELETED 21 lines ...


	if (iif) {
		struct net_device *dev;
		dev = __dev_get_by_index(iif);
		if (!dev)
Error --->
			return -ENODEV;
	}

	fl.oif = 0;
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/net/irda/irttp.c:1098:irttp_connect_request: ERROR:LEAK:1057:1098:Memory leak [Allocated from: /u1/acc/linux/2.5.48/net/irda/irttp.c:1057:dev_alloc_skb]
	if (self->connected)
		return -EISCONN;

	/* Any userdata supplied? */
	if (userdata == NULL) {
Start --->
		skb = dev_alloc_skb(64);

	... DELETED 35 lines ...

	self->remote_credit = n;

	/* SAR enabled? */
	if (max_sdu_size > 0) {
		ASSERT(skb_headroom(skb) >= (TTP_MAX_HEADER + TTP_SAR_HEADER),
Error --->
		       return -1;);

		/* Insert SAR parameters */
		frame = skb_push(skb, TTP_HEADER+TTP_SAR_HEADER);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/net/irda/irttp.c:1337:irttp_connect_response: ERROR:LEAK:1302:1337:Memory leak [Allocated from: /u1/acc/linux/2.5.48/net/irda/irttp.c:1302:dev_alloc_skb]
	IRDA_DEBUG(4, "%s(), Source TSAP selector=%02x\n", __FUNCTION__,
		   self->stsap_sel);

	/* Any userdata supplied? */
	if (userdata == NULL) {
Start --->
		skb = dev_alloc_skb(64);

	... DELETED 29 lines ...

	self->connected = TRUE;

	/* SAR enabled? */
	if (max_sdu_size > 0) {
		ASSERT(skb_headroom(skb) >= (TTP_MAX_HEADER+TTP_SAR_HEADER),
Error --->
		       return -1;);

		/* Insert TTP header with SAR parameters */
		frame = skb_push(skb, TTP_HEADER+TTP_SAR_HEADER);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/sound/oss/cs4232.c:385:cs4232_pnp_probe: ERROR:LEAK:375:385:Memory leak [Allocated from: /u1/acc/linux/2.5.48/sound/oss/cs4232.c:375:kmalloc]

static int cs4232_pnp_probe(struct pnp_dev *dev, const struct pnp_id *card_id, const struct pnp_id *dev_id)
{
	struct address_info *isapnpcfg;

Start --->
	isapnpcfg=(struct address_info*)kmalloc(sizeof(*isapnpcfg),GFP_KERNEL);
	if (!isapnpcfg)
		return -ENOMEM;

	isapnpcfg->irq		= dev->irq_resource[0].start;
	isapnpcfg->dma		= dev->dma_resource[0].start;
	isapnpcfg->dma2		= dev->dma_resource[1].start;
	isapnpcfg->io_base	= dev->resource[0].start;
	if (probe_cs4232(isapnpcfg,TRUE) == 0) {
		printk(KERN_ERR "cs4232: ISA PnP card found, but not detected?\n");
Error --->
		return -ENODEV;
	}
	attach_cs4232(isapnpcfg);
	dev->driver_data = isapnpcfg;


--cNdxnHkX5QqsyA0e--
