Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbSKSXiw>; Tue, 19 Nov 2002 18:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267172AbSKSXiw>; Tue, 19 Nov 2002 18:38:52 -0500
Received: from Xenon.Stanford.EDU ([171.64.66.201]:51605 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S267076AbSKSXif>; Tue, 19 Nov 2002 18:38:35 -0500
Date: Tue, 19 Nov 2002 15:45:31 -0800
From: Andy Chou <acc@CS.Stanford.EDU>
To: mc@cs.stanford.edu
Cc: linux-kernel@vger.kernel.org
Subject: [CHECKER] 74 potential buffer overruns in 2.5.33
Message-ID: <20021119234531.GA2723@Xenon.stanford.edu>
Reply-To: acc@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 74 out-of-bounds array accesses in Linux 2.5.33 found by the
MC checker.  This checker only considers statically allocated arrays
with indices that can be calculated at compile time.

The code fragment in each description below is incomplete; you'll need
to look at the source in some cases to determine if the report is
really a bug.

We'd appreciate any feedback -- even if it's not a bug.

-Andy Chou


# BUGs	|	File Name
4	|	/isdn/isdn_common.c
4	|	/message/i2o_block.c
4	|	/net/sch_gred.c
3	|	/drivers/cciss_scsi.c
3	|	/video/sis_main.c
3	|	/media/bt856.c
3	|	/wan/lmc_main.c
2	|	/sound/awe_wave.c
2	|	/video/init301.c
2	|	/net/xircom_tulip_cb.c
2	|	/media/msp3400.c
2	|	/usb/audio.c
2	|	/fs/extent.c
2	|	/drivers/mtdcore.c
2	|	/drivers/cpqfcTSworker.c
2	|	/drivers/3c505.c
2	|	/drivers/eexpress.c
2	|	/drivers/arlan-proc.c
1	|	/mtd/jedec.c
1	|	/drivers/aty128fb.c
1	|	/net/sdla.c
1	|	/drivers/eata_pio.c
1	|	/input/sunkbd.c
1	|	/drivers/parport_cs.c
1	|	/net/ray_cs.c
1	|	/mtd/vmax301.c
1	|	/pci/voice.c
1	|	/fs/jfs_txnmgr.c
1	|	/scsi/aha152x_stub.c
1	|	/drivers/qlogicfc.c
1	|	/drivers/fbmem.c
1	|	/usb/ohci-hub.c
1	|	/net/airo.c
1	|	/drivers/fealnx.c
1	|	/drivers/advansys.c
1	|	/sound/sequencer.c
1	|	/net/aironet4500_cs.c
1	|	/pci/ymfpci_main.c
1	|	/input/spaceorb.c
1	|	/net/3c359.c
1	|	/input/gunze.c
1	|	/drivers/ll_rw_blk.c
1	|	/sound/ymfpci.c
1	|	/drivers/3c515.c
1	|	/fs/fix_node.c
1	|	/net/ibmtr.c

---------------------------------------------------------
[BUG] Typo?
/home/acc/linux/2.5.33/drivers/net/arlan-proc.c:667:arlan_sysctl_info161719: 
ERROR:BUFFER:667:667:Array bounds error: priva->card->_21[1019] indexed 
with [1019]
	memcpy_fromio(priva->conf, priva->card, sizeof(struct 
arlan_shmem));
	SARLUCN(_16, 0xC0);
	SARLUCN(_17, 0x6A);
	SARLUCN(_18, 14);
	SARLUCN(_19, 0x86);

Error --->
	SARLUCN(_21, 0x3fd);

final:
	*lenp = pos;
---------------------------------------------------------
[BUG] [GEM] Bizarre.
/home/acc/linux/2.5.33/sound/oss/sequencer.c:1643:compute_finetune: 
ERROR:BUFFER:1643:1643:Array bounds error: semitone_tuning[24] indexed 
with [99]
	semitones = bend / 100;
	if (semitones > 99)
		semitones = 99;
	cents = bend % 100;


Error --->
	amount = (int) (semitone_tuning[semitones] * multiplier * 
cent_tuning[cents]) / 10000;

	if (negative)
		return (base_freq * 10000) / amount;	/* Bend down */
---------------------------------------------------------
[BUG] Same as other sisbios_mode
/home/acc/linux/2.5.33/drivers/video/sis/sis_main.c:398:sisfb_validate_mode: 
ERROR:BUFFER:398:398:Array bounds error: sisbios_mode[73] indexed with 
[-1]
		}
		break;
	}

	if(ivideo.chip < SIS_315H) {

Error --->
             if(sisbios_mode[sisfb_mode_idx].xres > 1920)
	         sisfb_mode_idx = -1;
	}
	/* TW: TODO: Validate modes available on either 300 or 310/325 
series only */
---------------------------------------------------------
[BUG] if dev_alloc_skb fails
/home/acc/linux/2.5.33/drivers/net/3c515.c:872:corkscrew_open: 
ERROR:BUFFER:872:872:Array bounds error: vp->rx_ring[16] indexed with [-1]
				break;	/* Bad news!  */
			skb->dev = dev;	/* Mark as being used by this 
device. */
			skb_reserve(skb, 2);	/* Align IP on 16 byte 
boundaries */
			vp->rx_ring[i].addr = isa_virt_to_bus(skb->tail);
		}

Error --->
		vp->rx_ring[i - 1].next = 
isa_virt_to_bus(&vp->rx_ring[0]);	/* Wrap the ring. */
		outl(isa_virt_to_bus(&vp->rx_ring[0]), ioaddr + 
UpListPtr);
	}
	if (vp->full_bus_master_tx) {	/* Boomerang bus master Tx. */
---------------------------------------------------------
[BUG] happens when num_luns = CISS_MAX_PHYS_LUN;
/home/acc/linux/2.5.33/drivers/block/cciss_scsi.c:614:cciss_find_non_disk_devices: 
ERROR:BUFFER:614:614:Array bounds error: ld_buff->LUN[16] indexed with 
[16]
	}

	for(i=0; i<num_luns; i++) {
		/* Execute an inquiry to figure the device type */
		memset(inq_buff, 0, sizeof(InquiryData_struct));

Error --->
		memcpy(scsi3addr, ld_buff->LUN[i], 8); /* ugly... */
		return_code = sendcmd(CISS_INQUIRY, cntl_num, inq_buff,
                	sizeof(InquiryData_struct), 2, 0 ,0, scsi3addr );
	  	if (return_code == IO_OK) {
---------------------------------------------------------
[BUG] Should probably assert.
/home/acc/linux/2.5.33/drivers/isdn/i4l/isdn_common.c:2078:register_isdn: 
ERROR:BUFFER:2078:2078:Array bounds error: dev->drv[32] indexed with [32]
	save_flags(flags);
	cli();
	for (j = 0; j < drvidx; j++)
		if (!strcmp(i->id, dev->drvid[j]))
			sprintf(i->id, "line%d", drvidx);

Error --->
	dev->drv[drvidx] = d;
	strcpy(dev->drvid[drvidx], i->id);
	isdn_info_update();
	dev->drivers++;
---------------------------------------------------------
[BUG] Might be ok, but probably should assert.
/home/acc/linux/2.5.33/drivers/video/aty128fb.c:1091:aty128_var_to_pll: 
ERROR:BUFFER:1091:1091:Array bounds error: post_dividers[7] indexed with 
[7]

    /* calculate feedback divider */
    n = c.ref_divider * output_freq;
    d = c.dotclock;


Error --->
    pll->post_divider = post_dividers[i];
    pll->feedback_divider = round_div(n, d);
    pll->vclk = vclk;

---------------------------------------------------------
[BUG] Clear cut.
/home/acc/linux/2.5.33/drivers/message/i2o/i2o_block.c:786:i2ob_evt: 
ERROR:BUFFER:786:786:Array bounds error: evt_local->data[16] indexed with 
[16]
			 */
			case I2O_EVT_IND_BSA_SCSI_SMART:
			{
				char buf[16];
				printk(KERN_INFO "I2O Block: %s received a 
SCSI SMART Event\n",i2ob_dev[unit].i2odev->dev_name);

Error --->
				evt_local->data[16]='\0';
				sprintf(buf,"%s",&evt_local->data[0]);
				printk(KERN_INFO "      Disk 
Serial#:%s\n",buf);
				printk(KERN_INFO "      ASC 0x%02x 
\n",evt_local->ASC);
---------------------------------------------------------
[BUG]
/home/acc/linux/2.5.33/drivers/media/video/bt856.c:144:bt856_attach: 
ERROR:BUFFER:144:144:Array bounds error: encoder->reg[128] indexed with 
[222]
	i2c_smbus_write_byte_data(client, 0xdc, 0x18);
	encoder->reg[0xdc] = 0x18;
	i2c_smbus_write_byte_data(client, 0xda, 0);
	encoder->reg[0xda] = 0;
	i2c_smbus_write_byte_data(client, 0xde, 0);

Error --->
	encoder->reg[0xde] = 0;

	bt856_setbit(encoder, 0xdc, 3, 1);
	//bt856_setbit(encoder, 0xdc, 6, 0);
---------------------------------------------------------
[BUG] 
/home/acc/linux/2.5.33/sound/pci/emu10k1/voice.c:42:voice_alloc: 
ERROR:BUFFER:42:42:Array bounds error: emu->voices[64] indexed with [64]
	int idx;

	*rvoice = NULL;
	for (idx = 0; idx < 64; idx += pair ? 2 : 1) {
		voice = &emu->voices[idx];

Error --->
		voice2 = pair ? &emu->voices[idx+1] : NULL;
		if (voice->use || (voice2 && voice2->use))
			continue;
		voice->use = 1;
---------------------------------------------------------
[BUG] [GEM] Could cause major corruption
/home/acc/linux/2.5.33/drivers/net/tulip/xircom_tulip_cb.c:903:xircom_init_ring: 
ERROR:BUFFER:903:903:Array bounds error: tp->tx_ring[16] indexed with [16]
	/* The Tx buffer descriptor is filled in as needed, but we
	   do need to clear the ownership bit. */
	for (i = 0; i < TX_RING_SIZE; i++) {
		tp->tx_skbuff[i] = 0;
		tp->tx_ring[i].status = 0;

Error --->
		tp->tx_ring[i].buffer2 = virt_to_bus(&tp->tx_ring[i+1]);
#ifdef CARDBUS
		if (tp->chip_id == X3201_3)
			tp->tx_aligned_skbuff[i] = 
dev_alloc_skb(PKT_BUF_SZ);
---------------------------------------------------------
[BUG] Seems bad, copied from user space.
/home/acc/linux/2.5.33/drivers/isdn/i4l/isdn_common.c:1528:isdn_ctrl_ioctl: 
ERROR:BUFFER:1528:1528:Array bounds error: iocpar.bname[20] indexed with 
[31]
						switch (bname[j]) {
						case '\0':
							loop = 0;
							/* Fall through */
						case ',':

Error --->
							bname[j] = '\0';
							
strcpy(dev->drv[drvidx]->msn2eaz[i], bname);
							j = ISDN_MSNLEN;
							break;
---------------------------------------------------------
[BUG] [GEM] Forgot to subtract offset?
/home/acc/linux/2.5.33/drivers/net/tokenring/3c359.c:754:xl_open_hw: 
ERROR:BUFFER:754:754:Array bounds error: xl_priv->xl_laa[6] indexed with 
[10]
	 */

	if (xl_priv->xl_laa[0]) {  /* If using a LAA address */
		for (i=10;i<16;i++) { 
			writel( (MEM_BYTE_WRITE | 0xD0000 | xl_priv->srb) 
+ i, xl_mmio + MMIO_MAC_ACCESS_CMD) ; 

Error --->
			writeb(xl_priv->xl_laa[i],xl_mmio + MMIO_MACDATA) 
; 
		}
		memcpy(dev->dev_addr,xl_priv->xl_laa,dev->addr_len) ; 
	} else { /* Regular hardware address */ 
---------------------------------------------------------
[BUG] [GEM] uses enum not quite correctly
/home/acc/linux/2.5.33/net/sched/sch_gred.c:484:gred_init: 
ERROR:BUFFER:484:484:Array bounds error: tb2[2] indexed with [2]

	if (tb[TCA_GRED_PARMS-1] == 0 && tb[TCA_GRED_STAB-1] == 0 &&
	    tb[TCA_GRED_DPS-1] != 0) {
		rtattr_parse(tb2, TCA_GRED_DPS, 
RTA_DATA(opt),RTA_PAYLOAD(opt));


Error --->
		sopt = RTA_DATA(tb2[TCA_GRED_DPS-1]);
		table->DPs=sopt->DPs;   
		table->def=sopt->def_DP; 
		table->grio=sopt->grio; 
---------------------------------------------------------
[BUG] Not really sure.  Maybe just missing an assert?
/home/acc/linux/2.5.33/fs/reiserfs/fix_node.c:2400:fix_nodes: 
ERROR:BUFFER:2400:2400:Array bounds error: p_s_tb->insert_size[5] indexed 
with [5]
		       become the root node.  */
	  
		    RFALSE( n_h == MAX_HEIGHT - 1,
			    "PAP-8355: attempt to create too high of a 
tree");


Error --->
		    p_s_tb->insert_size[n_h + 1] = (DC_SIZE + KEY_SIZE) * 
(p_s_tb->blknum[n_h] - 1) + DC_SIZE;
		}
		else
		    if ( n_h < MAX_HEIGHT - 1 )
---------------------------------------------------------
[BUG] Maybe?  Seems to warrant an assert or comment at least.
/home/acc/linux/2.5.33/fs/hfs/extent.c:501:shrink_fork: 
ERROR:BUFFER:501:501:Array bounds error: ext->length[3] indexed with [-1]
			ext->block[i] = ext->length[i] = 0;
			--i;
		}
		if (count) {
			ext->end -= count;

Error --->
			ext->length[i] -= count;
			error = hfs_clear_vbm_bits(mdb, ext->block[i] +
						       ext->length[i], 
count);
			if (error) {
---------------------------------------------------------
[BUG] Bad upper bound
/home/acc/linux/2.5.33/drivers/parport/parport_cs.c:338:parport_config: 
ERROR:BUFFER:338:338:Array bounds error: mode[3] indexed with [3]
	   link->io.BasePort1);
    if (link->io.NumPorts2)
	printk(" & %#x", link->io.BasePort2);
    printk(", irq %u [SPP", link->irq.AssignedIRQ);
    for (i = 0; i < 5; i++)

Error --->
	if (p->modes & mode[i].flag) printk(",%s", mode[i].name);
    printk("]\n");
    
    link->state &= ~DEV_CONFIG_PENDING;
---------------------------------------------------------
[BUG] happens when num_luns = CISS_MAX_PHYS_LUN;
/home/acc/linux/2.5.33/drivers/block/cciss_scsi.c:1197:cciss_update_non_disk_devices: 
ERROR:BUFFER:1197:1197:Array bounds error: ld_buff->LUN[16] indexed with 
[16]
	{
		int devtype;

		/* for each physical lun, do an inquiry */
		memset(inq_buff, 0, sizeof(InquiryData_struct));

Error --->
		memcpy(&scsi3addr[0], &ld_buff->LUN[i][0], 8);

		if (cciss_scsi_do_inquiry(hba[cntl_num], 
			scsi3addr, inq_buff) != 0)
---------------------------------------------------------
[BUG] [GEM] Off-by-one?
[BUG] Basically same as above
/home/acc/linux/2.5.33/drivers/mtd/mtdcore.c:236:mtd_pm_callback: 
ERROR:BUFFER:236:236:Array bounds error: mtd_table[16] indexed with [16]
		}
	} else i = MAX_MTD_DEVICES-1;

	if (rqst == PM_RESUME || ret) {
		for ( ; i >= 0; i--) {

Error --->
			if (mtd_table[i] && mtd_table[i]->resume)
				mtd_table[i]->resume(mtd_table[i]);
		}
	}
---------------------------------------------------------
[BUG] Same as another.
/home/acc/linux/2.5.33/drivers/media/video/msp3400.c:935:msp3400c_thread: 
ERROR:BUFFER:935:935:Array bounds error: carrier_detect_main[4] indexed 
with [-1]
			}
			break;
		case 0: /* 4.5 */
		default:
		no_second:

Error --->
			msp->second = carrier_detect_main[max1].cdo;
			msp3400c_setmode(client, MSP_MODE_FM_TERRA);
			msp->nicam_on = 0;
			msp3400c_setcarrier(client, msp->second, 
msp->main);
---------------------------------------------------------
[BUG] Clear cut.
/home/acc/linux/2.5.33/drivers/scsi/advansys.c:5100:advansys_detect: 
ERROR:BUFFER:5100:5100:Array bounds error: ep->adapter_info[6] indexed 
with [6]
                ep->adapter_info[1] = asc_dvc_varp->cfg->adapter_info[1];
                ep->adapter_info[2] = asc_dvc_varp->cfg->adapter_info[2];
                ep->adapter_info[3] = asc_dvc_varp->cfg->adapter_info[3];
                ep->adapter_info[4] = asc_dvc_varp->cfg->adapter_info[4];
                ep->adapter_info[5] = asc_dvc_varp->cfg->adapter_info[5];

Error --->
                ep->adapter_info[6] = asc_dvc_varp->cfg->adapter_info[6];

               /*
                * Modify board configuration.
---------------------------------------------------------
[BUG]
/home/acc/linux/2.5.33/drivers/net/wireless/airo.c:1035:readStatusRid: 
ERROR:BUFFER:1035:1035:Array bounds error: statr->_reserved[7] indexed 
with [9]
	u16 *s;

	statr->len = le16_to_cpu(statr->len);
	for(s = &statr->mode; s <= &statr->SSIDlen; s++) *s = 
le16_to_cpu(*s);


Error --->
	for(s = &statr->beaconPeriod; s <= &statr->_reserved[9]; s++)
		*s = le16_to_cpu(*s);

	return rc;
---------------------------------------------------------
[BUG] Similar to others in the same file.
/home/acc/linux/2.5.33/net/sched/sch_gred.c:481:gred_init: 
ERROR:BUFFER:481:481:Array bounds error: tb[2] indexed with [2]
	if (opt == NULL ||
		rtattr_parse(tb, TCA_GRED_STAB, RTA_DATA(opt), 
RTA_PAYLOAD(opt)) )
			return -EINVAL;

	if (tb[TCA_GRED_PARMS-1] == 0 && tb[TCA_GRED_STAB-1] == 0 &&

Error --->
	    tb[TCA_GRED_DPS-1] != 0) {
		rtattr_parse(tb2, TCA_GRED_DPS, 
RTA_DATA(opt),RTA_PAYLOAD(opt));

		sopt = RTA_DATA(tb2[TCA_GRED_DPS-1]);
---------------------------------------------------------
[BUG] What were they thinking?
/home/acc/linux/2.5.33/drivers/video/sis/sis_main.c:356:sisfb_validate_mode: 
ERROR:BUFFER:356:356:Array bounds error: sisbios_mode[73] indexed with 
[-1]
		}
		if(sisbios_mode[sisfb_mode_idx].xres > xres)
		        sisfb_mode_idx = -1;
                if(sisbios_mode[sisfb_mode_idx].yres > yres)
		        sisfb_mode_idx = -1;

Error --->
		if (sisbios_mode[sisfb_mode_idx].xres == 720)
			sisfb_mode_idx = -1;
		break;
	case DISPTYPE_TV:
---------------------------------------------------------
[BUG]
/home/acc/linux/2.5.33/drivers/scsi/cpqfcTSworker.c:2473:SendLogins: 
ERROR:BUFFER:2473:2473:Array bounds error: fcChip->LILPmap[128] indexed 
with [128]
      i = fcChip->LILPmap[0] >= (32*4) ? 32*4 : fcChip->LILPmap[0];
      NumberOfPorts = i;
//      printk(" LILP alpa count %d ", i);
      while( i > 0)
      {

Error --->
	PortIds[j] = fcChip->LILPmap[1+ j];
	j++; i--;
      }
    }
---------------------------------------------------------
[BUG]
/home/acc/linux/2.5.33/drivers/video/sis/init301.c:8274:SetOEMYFilter: 
ERROR:BUFFER:8274:8274:Array bounds error: SiS300_Filter1[10] indexed with 
[18]
      for(i=0x48; i<=0x4A; i++, j++) {
     	SiS_SetReg1(Part2Port,i,SiS300_Filter2[temp][index][j]);
      }
  } else {
      for(i=0x35, j=0; i<=0x38; i++, j++) {

Error --->
       	SiS_SetReg1(Part2Port,i,SiS300_Filter1[temp][index][j]);
      }
  }
}
---------------------------------------------------------
[BUG] [GEM] Off-by-one?
[BUG] Basically same as above
/home/acc/linux/2.5.33/drivers/mtd/mtdcore.c:237:mtd_pm_callback: 
ERROR:BUFFER:237:237:Array bounds error: mtd_table[16] indexed with [16]
	} else i = MAX_MTD_DEVICES-1;

	if (rqst == PM_RESUME || ret) {
		for ( ; i >= 0; i--) {
			if (mtd_table[i] && mtd_table[i]->resume)

Error --->
				mtd_table[i]->resume(mtd_table[i]);
		}
	}
	up(&mtd_table_mutex);
---------------------------------------------------------
[BUG] caused by assignment lwm = XTPAGEMAXSLOT;
/home/acc/linux/2.5.33/fs/jfs/jfs_txnmgr.c:1716:xtLog: 
ERROR:BUFFER:1716:1716:Array bounds error: p->xad[18] indexed with [256]
			 * Lazy commit may allow xtree to be modified 
before
			 * txUpdateMap runs.  Copy xad into linelock to
			 * preserve correct data.
			 */
			xadlock->xdlist = &xtlck->pxdlock;

Error --->
			memcpy(xadlock->xdlist, &p->xad[lwm],
			       sizeof(xad_t) * xadlock->count);

			for (i = 0; i < xadlock->count; i++)
---------------------------------------------------------
[BUG] Complex path.
/home/acc/linux/2.5.33/drivers/media/video/msp3400.c:873:msp3400c_thread: 
ERROR:BUFFER:873:873:Array bounds error: carrier_detect_main[4] indexed 
with [-1]
				val2 = val, max2 = this;
			dprintk("msp3400: carrier2 val: %5d / %s\n", 
val,cd[this].name);
		}

		/* programm the msp3400 according to the results */

Error --->
		msp->main   = carrier_detect_main[max1].cdo;
		switch (max1) {
		case 1: /* 5.5 */
			if (max2 == 0) {
---------------------------------------------------------
[BUG] Hmmm.
/home/acc/linux/2.5.33/drivers/media/video/bt856.c:142:bt856_attach: 
ERROR:BUFFER:142:142:Array bounds error: encoder->reg[128] indexed with 
[218]
	DEBUG(printk(KERN_INFO "%s-bt856: attach\n", encoder->bus->name));

	i2c_smbus_write_byte_data(client, 0xdc, 0x18);
	encoder->reg[0xdc] = 0x18;
	i2c_smbus_write_byte_data(client, 0xda, 0);

Error --->
	encoder->reg[0xda] = 0;
	i2c_smbus_write_byte_data(client, 0xde, 0);
	encoder->reg[0xde] = 0;

---------------------------------------------------------
[BUG] Straightforward.
/home/acc/linux/2.5.33/drivers/mtd/maps/vmax301.c:226:init_vmax301: 
ERROR:BUFFER:226:226:Array bounds error: vmax_mtd[2] indexed with [2]
			vmax_mtd[i]->module = THIS_MODULE;
			add_mtd_device(vmax_mtd[i]);
		}
	}


Error --->
	if (!vmax_mtd[1] && !vmax_mtd[2]) {
		iounmap((void *)iomapadr);
		return -ENXIO;
	}
---------------------------------------------------------
[BUG] Off-by-one
/home/acc/linux/2.5.33/sound/oss/awe_wave.c:977:calc_rate_offset: 
ERROR:BUFFER:977:977:Array bounds error: cent_tuning[100] indexed with 
[100]
			break;
		base += 100;
	}
	freq = freq * 10000 / semitone_tuning[i];
	for (i = 0; i < 100; i++) {

Error --->
		if (freq < cent_tuning[i+1])
			break;
		base++;
	}
---------------------------------------------------------
[BUG] Stupid
/home/acc/linux/2.5.33/drivers/video/sis/sis_main.c:354:sisfb_validate_mode: 
ERROR:BUFFER:354:354:Array bounds error: sisbios_mode[73] indexed with 
[-1]
		default:
		        xres =    0; yres =    0;  break;
		}
		if(sisbios_mode[sisfb_mode_idx].xres > xres)
		        sisfb_mode_idx = -1;

Error --->
                if(sisbios_mode[sisfb_mode_idx].yres > yres)
		        sisfb_mode_idx = -1;
		if (sisbios_mode[sisfb_mode_idx].xres == 720)
			sisfb_mode_idx = -1;
---------------------------------------------------------
[BUG]
/home/acc/linux/2.5.33/drivers/video/sis/init301.c:8267:SetOEMYFilter: 
ERROR:BUFFER:8267:8267:Array bounds error: SiS300_Filter2[10] indexed with 
[18]
	  if(temp1 & EnablePALN) temp = 18;
       }
  }
  if(SiS_VBType & VB_SIS301BLV302BLV) {
      for(i=0x35, j=0; i<=0x38; i++, j++) {

Error --->
       	SiS_SetReg1(Part2Port,i,SiS300_Filter2[temp][index][j]);
      }
      for(i=0x48; i<=0x4A; i++, j++) {
     	SiS_SetReg1(Part2Port,i,SiS300_Filter2[temp][index][j]);
---------------------------------------------------------
[BUG]
/home/acc/linux/2.5.33/sound/oss/ymfpci.c:548:voice_alloc: 
ERROR:BUFFER:548:548:Array bounds error: codec->voices[64] indexed with 
[64]
	ymfpci_voice_t *voice, *voice2;
	int idx;

	for (idx = 0; idx < YDSXG_PLAYBACK_VOICES; idx += pair ? 2 : 1) {
		voice = &codec->voices[idx];

Error --->
		voice2 = pair ? &codec->voices[idx+1] : NULL;
		if (voice->use || (voice2 && voice2->use))
			continue;
		voice->use = 1;
---------------------------------------------------------
[BUG] Not sure.
/home/acc/linux/2.5.33/drivers/net/arlan-proc.c:754:arlan_sysctl_info18: 
ERROR:BUFFER:754:754:Array bounds error: priva->card->_18[14] indexed with 
[14]
	{
		printk(KERN_WARNING " Could not find the device private in 
arlan procsys, bad\n ");
		return -1;
	}
	memcpy_fromio(priva->conf, priva->card, sizeof(struct 
arlan_shmem));

Error --->
	SARLBNpln(u_char, _18, 0x800);

final:
	*lenp = pos;
---------------------------------------------------------
[BUG] Possibly bad.
/home/acc/linux/2.5.33/drivers/net/tulip/xircom_tulip_cb.c:877:xircom_init_ring: 
ERROR:BUFFER:877:877:Array bounds error: tp->rx_ring[32] indexed with [32]
	tp->dirty_rx = tp->dirty_tx = 0;

	for (i = 0; i < RX_RING_SIZE; i++) {
		tp->rx_ring[i].status = 0;
		tp->rx_ring[i].length = PKT_BUF_SZ;

Error --->
		tp->rx_ring[i].buffer2 = virt_to_bus(&tp->rx_ring[i+1]);
		tp->rx_skbuff[i] = NULL;
	}
	/* Mark the last entry as wrapping the ring. */
---------------------------------------------------------
[BUG] Meant &flp->dlci[0]?
/home/acc/linux/2.5.33/drivers/net/wan/sdla.c:954:sdla_close: 
ERROR:BUFFER:954:954:Array bounds error: flp->dlci[8] indexed with [8]
	if (flp->config.station == FRAD_STATION_NODE)
	{
		for(i=0;i<CONFIG_DLCI_MAX;i++)
			if (flp->dlci[i] > 0) 
				sdla_cmd(dev, SDLA_DEACTIVATE_DLCI, 0, 0, 
dlcis, len, NULL, NULL);

Error --->
		sdla_cmd(dev, SDLA_DELETE_DLCI, 0, 0, &flp->dlci[i], 
sizeof(flp->dlci[i]), NULL, NULL);
	}

	memset(&intr, 0, sizeof(intr));
---------------------------------------------------------
[BUG] Seems fishy.
/home/acc/linux/2.5.33/drivers/net/wan/lmc/lmc_main.c:2179:lmc_softreset: 
ERROR:BUFFER:2179:2179:Array bounds error: sc->lmc_rxring[32] indexed with 
[32]
         * to the end of the packj,et but since there's nothing there tail 
== data
         */
        sc->lmc_rxring[i].buffer1 = virt_to_bus (skb->data);

        /* This is fair since the structure is static and we have the next 
address */

Error --->
        sc->lmc_rxring[i].buffer2 = virt_to_bus (&sc->lmc_rxring[i + 1]);

    }

---------------------------------------------------------
[BUG] [GEM] Incorrect sizeof calculation?
/home/acc/linux/2.5.33/drivers/net/eexpress.c:1474:eexp_hw_init586: 
ERROR:BUFFER:1474:1474:Array bounds error: start_code[69] indexed with 
[69]
	for (i = 0; i < (sizeof(start_code)); i+=32) {
		int j;
		outw(i, ioaddr + SM_PTR);
		for (j = 0; j < 16; j+=2)
			outw(start_code[(i+j)/2],

Error --->
			     ioaddr+0x4000+j);
		for (j = 0; j < 16; j+=2)
			outw(start_code[(i+j+16)/2],
			     ioaddr+0x8000+j);
---------------------------------------------------------
[BUG]
/home/acc/linux/2.5.33/drivers/scsi/pcmcia/aha152x_stub.c:289:aha152x_config_cs: 
ERROR:BUFFER:289:289:Array bounds error: ints[8] indexed with [8]
    ints[4] = reconnect;
    ints[5] = parity;
    ints[6] = synchronous;
    ints[7] = reset_delay;
    if (ext_trans) {

Error --->
	ints[8] = ext_trans; ints[0] = 8;
    }
    aha152x_setup("PCMCIA setup", ints);
    
---------------------------------------------------------
[BUG] Might be ok use of overlap, but unlikely.
/home/acc/linux/2.5.33/drivers/net/pcmcia/ray_cs.c:1175:translate_frame: 
ERROR:BUFFER:1175:1175:Array bounds error: (struct 
snaphdr_t*)(u_char*)&ptx->var->org[3] indexed with [3]
        /* Copy LLC header to card buffer */
        memcpy_toio((UCHAR *)&ptx->var, eth2_llc, sizeof(eth2_llc));
        memcpy_toio( ((UCHAR *)&ptx->var) + sizeof(eth2_llc), (UCHAR 
*)&proto, 2);
        if ((proto == 0xf380) || (proto == 0x3781)) {
            /* This is the selective translation table, only 2 entries */

Error --->
            writeb(0xf8, (UCHAR *) &((struct snaphdr_t 
*)ptx->var)->org[3]);
        }
        /* Copy body of ethernet packet without ethernet header */
        memcpy_toio((UCHAR *)&ptx->var + sizeof(struct snaphdr_t), \
---------------------------------------------------------
[BUG] Not sure.
/home/acc/linux/2.5.33/drivers/net/wan/lmc/lmc_main.c:2200:lmc_softreset: 
ERROR:BUFFER:2200:2200:Array bounds error: sc->lmc_txring[32] indexed with 
[32]
            dev_kfree_skb(sc->lmc_txq[i]);	/* free it */
            sc->stats.tx_dropped++;      /* We just dropped a packet */
        }
        sc->lmc_txq[i] = 0;
        sc->lmc_txring[i].status = 0x00000000;

Error --->
        sc->lmc_txring[i].buffer2 = virt_to_bus (&sc->lmc_txring[i + 1]);
    }
    sc->lmc_txring[i - 1].buffer2 = virt_to_bus (&sc->lmc_txring[0]);
    LMC_CSR_WRITE (sc, csr_txlist, virt_to_bus (sc->lmc_txring));
---------------------------------------------------------
[BUG] Incorrect sizeof calculation?
/home/acc/linux/2.5.33/drivers/net/eexpress.c:1477:eexp_hw_init586: 
ERROR:BUFFER:1477:1477:Array bounds error: start_code[69] indexed with 
[72]
		for (j = 0; j < 16; j+=2)
			outw(start_code[(i+j)/2],
			     ioaddr+0x4000+j);
		for (j = 0; j < 16; j+=2)
			outw(start_code[(i+j+16)/2],

Error --->
			     ioaddr+0x8000+j);
	}

	/* Do we want promiscuous mode or multicast? */
---------------------------------------------------------
[BUG] [HARD] Consider ptr = 0 at the end?
/home/acc/linux/2.5.33/drivers/usb/class/audio.c:589:dmabuf_copyin_user: 
ERROR:BUFFER:589:589:Array bounds error: db->sgbuf[32] indexed with [32]
		if (pgrem > size)
			pgrem = size;
		rem = db->dmasize - ptr;
		if (pgrem > rem)
			pgrem = rem;

Error --->
		if (copy_from_user((db->sgbuf[ptr >> PAGE_SHIFT]) + (ptr & 
(PAGE_SIZE-1)), buffer, pgrem))
			return -EFAULT;
		size -= pgrem;
		(char *)buffer += pgrem;
---------------------------------------------------------
[BUG] 
/home/acc/linux/2.5.33/drivers/usb/host/ohci-hub.c:145:ohci_hub_descriptor: 
ERROR:BUFFER:145:145:Array bounds error: desc->DeviceRemovable[3] indexed 
with [3]
	/* two bitmaps:  ports removable, and usb 1.0 legacy 
PortPwrCtrlMask */
	rh = roothub_b (ohci);
	desc->bitmap [0] = rh & RH_B_DR;
	if (ports > 7) {
		desc->bitmap [1] = (rh & RH_B_DR) >> 8;

Error --->
		desc->bitmap [2] = desc->bitmap [3] = 0xff;
	} else
		desc->bitmap [1] = 0xff;
}
---------------------------------------------------------
[BUG] Bad upper bound.  More in same function.
/home/acc/linux/2.5.33/drivers/input/joystick/spaceorb.c:116:spaceorb_process_packet: 
ERROR:BUFFER:116:116:Array bounds error: spaceorb_buttons[6] indexed with 
[6]
			break;

		case 'K':				/* Button data */
			if (spaceorb->idx != 5) return;
			for (i = 0; i < 7; i++)

Error --->
				input_report_key(dev, spaceorb_buttons[i], 
(data[2] >> i) & 1);

			break;

---------------------------------------------------------
[BUG] copied and pasted from elsewhere.
/home/acc/linux/2.5.33/sound/pci/ymfpci/ymfpci_main.c:233:voice_alloc: 
ERROR:BUFFER:233:233:Array bounds error: chip->voices[64] indexed with 
[64]
	int idx;
	
	*rvoice = NULL;
	for (idx = 0; idx < YDSXG_PLAYBACK_VOICES; idx += pair ? 2 : 1) {
		voice = &chip->voices[idx];

Error --->
		voice2 = pair ? &chip->voices[idx+1] : NULL;
		if (voice->use || (voice2 && voice2->use))
			continue;
		voice->use = 1;
---------------------------------------------------------
[BUG] Seems bad.
/home/acc/linux/2.5.33/drivers/block/ll_rw_blk.c:556:blk_dump_rq_flags: 
ERROR:BUFFER:556:556:Array bounds error: rq_flags[12] indexed with [12]

	printk("%s: dev %02x:%02x: ", msg, major(rq->rq_dev), 
minor(rq->rq_dev));
	bit = 0;
	do {
		if (rq->flags & (1 << bit))

Error --->
			printk("%s ", rq_flags[bit]);
		bit++;
	} while (bit < __REQ_NR_BITS);

---------------------------------------------------------
[BUG] when dev_alloc_skb fails
/home/acc/linux/2.5.33/drivers/net/wan/lmc/lmc_main.c:2186:lmc_softreset: 
ERROR:BUFFER:2186:2186:Array bounds error: sc->lmc_rxring[32] indexed with 
[-1]
    }

    /*
     * Sets end of ring
     */

Error --->
    sc->lmc_rxring[i - 1].length |= 0x02000000; /* Set end of buffers flag 
*/
    sc->lmc_rxring[i - 1].buffer2 = virt_to_bus (&sc->lmc_rxring[0]); /* 
Point back to the start */
    LMC_CSR_WRITE (sc, csr_rxlist, virt_to_bus (sc->lmc_rxring)); /* write 
base address */

---------------------------------------------------------
[BUG]
/home/acc/linux/2.5.33/drivers/video/fbmem.c:750:register_framebuffer: 
ERROR:BUFFER:750:750:Array bounds error: fb_ever_opened[32] indexed with 
[32]
	for (i = 0 ; i < FB_MAX; i++)
		if (!registered_fb[i])
			break;
	fb_info->node = mk_kdev(FB_MAJOR, i);
	registered_fb[i] = fb_info;

Error --->
	if (!fb_ever_opened[i]) {
		struct module *owner = fb_info->fbops->owner;
		/*
		 *  We assume initial frame buffer devices can be opened 
this
---------------------------------------------------------
[BUG] Bad bound for phy_idx?
/home/acc/linux/2.5.33/drivers/net/fealnx.c:587:fealnx_init_one: 
ERROR:BUFFER:587:587:Array bounds error: np->phys[2] indexed with [2]

		for (phy = 1; phy < 32 && phy_idx < 4; phy++) {
			int mii_status = mdio_read(dev, phy, 1);

			if (mii_status != 0xffff && mii_status != 0x0000) 
{

Error --->
				np->phys[phy_idx++] = phy;
				printk(KERN_INFO
				       "%s: MII PHY found at address %d, 
status "
				       "0x%4.4x.\n", dev->name, phy, 
mii_status);
---------------------------------------------------------
[BUG] Seems possibly bad.
/home/acc/linux/2.5.33/drivers/isdn/i4l/isdn_common.c:1523:isdn_ctrl_ioctl: 
ERROR:BUFFER:1523:1523:Array bounds error: iocpar.bname[20] indexed with 
[20]

					while (1) {
						if ((ret = 
verify_area(VERIFY_READ, p, 1)))
							return ret;
						get_user(bname[j], p++);

Error --->
						switch (bname[j]) {
						case '\0':
							loop = 0;
							/* Fall through */
---------------------------------------------------------
[BUG] Off-by-one
/home/acc/linux/2.5.33/sound/oss/awe_wave.c:941:freq_to_note: 
ERROR:BUFFER:941:941:Array bounds error: cent_tuning[100] indexed with 
[100]
	}

	tune = 0;
	freq = freq * 10000 / semitone_tuning[i];
	for (i = 0; i < 100; i++) {

Error --->
		if (freq < cent_tuning[i+1])
			break;
		tune++;
	}
---------------------------------------------------------
[BUG] Possible
/home/acc/linux/2.5.33/drivers/mtd/chips/jedec.c:334:handle_jedecs: 
ERROR:BUFFER:334:334:Array bounds error: priv->chips[16] indexed with [-1]
	  (JEDEC->size << priv->chips[I].addrshift) - Bank)
	 priv->bank_fill[Bank/my_bank_size] =  base + (JEDEC->size << 
priv->chips[I].addrshift) - Bank;
      I++;
   }


Error --->
   priv->size += priv->chips[I-1].size*Count;
	 
   return priv->chips[I-1].size;
}
---------------------------------------------------------
[BUG] Similar to others in the same file.
/home/acc/linux/2.5.33/net/sched/sch_gred.c:339:gred_change: 
ERROR:BUFFER:339:339:Array bounds error: tb[2] indexed with [2]
	if (opt == NULL ||
		rtattr_parse(tb, TCA_GRED_STAB, RTA_DATA(opt), 
RTA_PAYLOAD(opt)) )
			return -EINVAL;

	if (tb[TCA_GRED_PARMS-1] == 0 && tb[TCA_GRED_STAB-1] == 0 &&

Error --->
	    tb[TCA_GRED_DPS-1] != 0) {
		rtattr_parse(tb2, TCA_GRED_DPS, RTA_DATA(opt),
		    RTA_PAYLOAD(opt));

---------------------------------------------------------
[BUG] Bad bound check
/home/acc/linux/2.5.33/drivers/net/pcmcia/aironet4500_cs.c:511:awc_pcmcia_config: 
ERROR:BUFFER:511:511:Array bounds error: awc_ports[4] indexed with [4]
		last_fn = RequestIO;
		while ((last_ret = CardServices(RequestIO, link->handle, 
&link->io)) ){
		
			if (ii > 4) 
				goto cs_failed;

Error --->
			link->io.BasePort1 = awc_ports[ii];
			ii++;
		};

---------------------------------------------------------
[BUG] Bounds test of j does not exit loop.
/home/acc/linux/2.5.33/drivers/scsi/qlogicfc.c:928:isp2x00_make_portdb: 
ERROR:BUFFER:928:928:Array bounds error: hostdata->port_db[256] indexed 
with [256]
			}
			if (j == QLOGICFC_MAX_ID + 1)
				printk("qlogicfc%d : Too many scsi 
devices, no more room in port map.\n", hostdata->host_id);
			if (!hostdata->port_db[j].wwn) {
				hostdata->port_db[j].loop_id = 
temp[i].loop_id;

Error --->
				hostdata->port_db[j].wwn = temp[i].wwn;
			}
		} else
			hostdata->port_db[i].loop_id = temp[i].loop_id;
---------------------------------------------------------
[BUG]
/home/acc/linux/2.5.33/drivers/input/touchscreen/gunze.c:69:gunze_process_packet: 
ERROR:BUFFER:69:69:Array bounds error: gunze->data[10] indexed with [10]
{
	struct input_dev *dev = &gunze->dev;

	if (gunze->idx != GUNZE_MAX_LENGTH || gunze->data[5] != ',' ||
		(gunze->data[0] != 'T' && gunze->data[0] != 'R')) {

Error --->
		gunze->data[10] = 0;
		printk(KERN_WARNING "gunze.c: bad packet: >%s<\n", 
gunze->data);
		return;
	}
---------------------------------------------------------
[BUG] Similar to other one.
/home/acc/linux/2.5.33/drivers/usb/class/audio.c:614:dmabuf_copyout_user: 
ERROR:BUFFER:614:614:Array bounds error: db->sgbuf[32] indexed with [32]
		if (pgrem > size)
			pgrem = size;
		rem = db->dmasize - ptr;
		if (pgrem > rem)
			pgrem = rem;

Error --->
		if (copy_to_user(buffer, (db->sgbuf[ptr >> PAGE_SHIFT]) + 
(ptr & (PAGE_SIZE-1)), pgrem))
			return -EFAULT;
		size -= pgrem;
		(char *)buffer += pgrem;
---------------------------------------------------------
[BUG] Maybe?  Seems to warrant an assert or comment at least.
/home/acc/linux/2.5.33/fs/hfs/extent.c:503:shrink_fork: 
ERROR:BUFFER:503:503:Array bounds error: ext->block[3] indexed with [-1]
		}
		if (count) {
			ext->end -= count;
			ext->length[i] -= count;
			error = hfs_clear_vbm_bits(mdb, ext->block[i] +

Error --->
						       ext->length[i], 
count);
			if (error) {
				hfs_warn("hfs_truncate: error %d freeing "
				       "blocks.\n", error);
---------------------------------------------------------
[BUG] Seems clear cut.
/home/acc/linux/2.5.33/drivers/media/video/bt856.c:140:bt856_attach: 
ERROR:BUFFER:140:140:Array bounds error: encoder->reg[128] indexed with 
[220]
	encoder->enable = 1;

	DEBUG(printk(KERN_INFO "%s-bt856: attach\n", encoder->bus->name));

	i2c_smbus_write_byte_data(client, 0xdc, 0x18);

Error --->
	encoder->reg[0xdc] = 0x18;
	i2c_smbus_write_byte_data(client, 0xda, 0);
	encoder->reg[0xda] = 0;
	i2c_smbus_write_byte_data(client, 0xde, 0);
---------------------------------------------------------
[BUG] [GEM] Ouch
/home/acc/linux/2.5.33/drivers/input/keyboard/sunkbd.c:271:sunkbd_connect: 
ERROR:BUFFER:271:271:Array bounds error: sunkbd->keycode[128] indexed with 
[128]

	sprintf(sunkbd->name, "Sun Type %d keyboard", sunkbd->type);

	memcpy(sunkbd->keycode, sunkbd_keycode, sizeof(sunkbd->keycode));
	for (i = 0; i < 255; i++)

Error --->
		set_bit(sunkbd->keycode[i], sunkbd->dev.keybit);
	clear_bit(0, sunkbd->dev.keybit);

	sprintf(sunkbd->name, "%s/input", serio->phys);
---------------------------------------------------------
[BUG] INVALID_PCB_MSG does not return an error, i may be large upon loop 
exit.
/home/acc/linux/2.5.33/drivers/net/3c505.c:537:receive_pcb: 
ERROR:BUFFER:537:537:Array bounds error: pcb->data.raw[62] indexed with 
[63]
	if (j >= 20000) {
		TIMEOUT_MSG(__LINE__);
		return FALSE;
	}
	/* woops, the last "data" byte was really the length! */

Error --->
	total_length = pcb->data.raw[--i];

	/* safety check total length vs data length */
	if (total_length != (pcb->length + 2)) {
---------------------------------------------------------
[BUG] Forgot to test end condition?
/home/acc/linux/2.5.33/drivers/message/i2o/i2o_block.c:1554:i2ob_new_device: 
ERROR:BUFFER:1554:1554:Array bounds error: i2ob_dev[256] indexed with 
[256]
		printk(KERN_INFO 
			"i2o_block: Unable to claim device. Installation 
aborted\n");
		return;
	}


Error --->
	dev = &i2ob_dev[unit];
	dev->i2odev = d; 
	dev->controller = c;
	dev->tid = d->lct_data.tid;
---------------------------------------------------------
[BUG] Same as other.
/home/acc/linux/2.5.33/net/sched/sch_gred.c:343:gred_change: 
ERROR:BUFFER:343:343:Array bounds error: tb2[2] indexed with [2]
	if (tb[TCA_GRED_PARMS-1] == 0 && tb[TCA_GRED_STAB-1] == 0 &&
	    tb[TCA_GRED_DPS-1] != 0) {
		rtattr_parse(tb2, TCA_GRED_DPS, RTA_DATA(opt),
		    RTA_PAYLOAD(opt));


Error --->
		sopt = RTA_DATA(tb2[TCA_GRED_DPS-1]);
		table->DPs=sopt->DPs;   
		table->def=sopt->def_DP; 
		table->grio=sopt->grio; 
---------------------------------------------------------
[BUG] can cardpresent == NOTOK leak to this point?
/home/acc/linux/2.5.33/drivers/net/tokenring/ibmtr.c:695:ibmtr_probe1: 
ERROR:BUFFER:695:695:Array bounds error: channel_def[3] indexed with [-1]

	if (!version_printed++) {
		printk(version);
	}
#endif /* !PCMCIA */

Error --->
	DPRINTK("%s %s found\n",
		channel_def[cardpresent - 1], 
adapter_def(ti->adapter_type));
	DPRINTK("using irq %d, PIOaddr %hx, %dK shared RAM.\n",
			irq, PIOaddr, ti->mapped_ram_size / 2);
---------------------------------------------------------
[BUG] [GEM] Test performed after corruption has already occurred.
/home/acc/linux/2.5.33/drivers/net/3c505.c:527:receive_pcb: 
ERROR:BUFFER:527:527:Array bounds error: pcb->data.raw[62] indexed with 
[62]
	cli();
	i = 0;
	do {
		j = 0;
		while (((stat = get_status(dev->base_addr)) & ACRF) == 0 
&& j++ < 20000);

Error --->
		pcb->data.raw[i++] = inb_command(dev->base_addr);
		if (i > MAX_PCB_DATA)
			INVALID_PCB_MSG(i);
	} while ((stat & ASF_PCB_MASK) != ASF_PCB_END && j < 20000);
---------------------------------------------------------
[BUG] Missing shift?
/home/acc/linux/2.5.33/drivers/message/i2o/i2o_block.c:1644:i2ob_del_device: 
ERROR:BUFFER:1644:1644:Array bounds error: i2ob_media_change_flag[16] 
indexed with [16]

	/* 
	 * Do we need this?
	 * The media didn't really change...the device is just gone
	 */

Error --->
	i2ob_media_change_flag[unit] = 1;

	i2ob_dev_count--;	
}
---------------------------------------------------------
[BUG] happens when num_luns = CISS_MAX_PHYS_LUN;
/home/acc/linux/2.5.33/drivers/block/cciss_scsi.c:636:cciss_find_non_disk_devices: 
ERROR:BUFFER:636:636:Array bounds error: ld_buff->LUN[16] indexed with 
[1023]
			    case 0x08: /* medium changer */
					  /* this is the only kind of dev 
*/
					  /* we want to expose here. */
				if (cciss_scsi_add_entry(cntl_num, -1,
					(unsigned char *) ld_buff->LUN[i],

Error --->
					devtype) != 0) 
						i=num_luns; // leave loop
				break;
			    default: 
---------------------------------------------------------
[BUG]
/home/acc/linux/2.5.33/drivers/message/i2o/i2o_block.c:1354:i2ob_init_iop: 
ERROR:BUFFER:1354:1354:Array bounds error: 
i2ob_queues[unit]->request_queue[128] indexed with [128]
	}

	for(i = 0; i< MAX_I2OB_DEPTH; i++)
	{
		i2ob_queues[unit]->request_queue[i].next = 

Error --->
			&i2ob_queues[unit]->request_queue[i+1];
		i2ob_queues[unit]->request_queue[i].num = i;
	}
	i2ob_queues[unit]->lock = SPIN_LOCK_UNLOCKED;
---------------------------------------------------------
[BUG]
/home/acc/linux/2.5.33/drivers/scsi/eata_pio.c:964:eata_pio_detect: 
ERROR:BUFFER:964:964:Array bounds error: reg_IRQ[16] indexed with [16]
    find_pio_EISA(&gc, tpnt);

    find_pio_ISA(&gc, tpnt);
    
    for (i = 0; i <= MAXIRQ; i++)

Error --->
	if (reg_IRQ[i])
	    request_irq(i, do_eata_pio_int_handler, SA_INTERRUPT, 
"EATA-PIO", NULL);
    
    HBA_ptr = first_HBA;
---------------------------------------------------------
[BUG]
/home/acc/linux/2.5.33/drivers/scsi/cpqfcTSworker.c:1643:ProcessELS_Request: 
ERROR:BUFFER:1643:1643:Array bounds error: fchs->pl[30] indexed with [30]
      // 0 = Port Address; 24-bit address of affected device
      // 1 = Area Address; MS 16 bits valid
      // 2 = Domain Address; MS 8 bits valid
    for( i=0; i<Ports; i++)
    { 

Error --->
      BigEndianSwap( (UCHAR*)&fchs->pl[i+1],(UCHAR*)&Buff, 4);
      switch( Buff & 0xFF000000)
      {

---------------------------------------------------------
[BUG] Seems possibly bad.
/home/acc/linux/2.5.33/drivers/isdn/i4l/isdn_common.c:2079:register_isdn: 
ERROR:BUFFER:2079:2079:Array bounds error: dev->drvid[32] indexed with 
[32]
	cli();
	for (j = 0; j < drvidx; j++)
		if (!strcmp(i->id, dev->drvid[j]))
			sprintf(i->id, "line%d", drvidx);
	dev->drv[drvidx] = d;

Error --->
	strcpy(dev->drvid[drvidx], i->id);
	isdn_info_update();
	dev->drivers++;
	set_global_features();


