Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316456AbSFJDy4>; Sun, 9 Jun 2002 23:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316488AbSFJDyz>; Sun, 9 Jun 2002 23:54:55 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:20884 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S316456AbSFJDyo>;
	Sun, 9 Jun 2002 23:54:44 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206100354.UAA17024@csl.Stanford.EDU>
Subject: [CHECKER] 36 missing return code checks in 2.4.17
To: linux-kernel@vger.kernel.org
Date: Sun, 9 Jun 2002 20:54:44 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Enclosed are 36 error reports for functions whose return value in 2.4.17
was ignored, even though many other callsites checked it.  There are
*many* more such errors, so if these are interesting, let me know and
I'll send some more.

Dawson

# BUGs	|	File Name
3	|	/drivers/printer.c
2	|	/drivers/aironet4500_card.c
2	|	/net/pcnet_cs.c
2	|	/usb/keyspan_pda.c
1	|	/drivers/ambassador.c
1	|	/drivers/pc_keyb.c
1	|	/2.4.17/exec_domain.c
1	|	/net/xprt.c
1	|	/drivers/i82365.c
1	|	/drivers/pty.c
1	|	/drivers/natsemi.c
1	|	/drivers/i810_audio.c
1	|	/isdn/init.c
1	|	/net/scc.c
1	|	/drivers/tty_io.c
1	|	/drivers/cardbus.c
1	|	/net/vlan.c
1	|	/net/axnet_cs.c
1	|	/2.4.17/socket.c
1	|	/net/orinoco_plx.c
1	|	/net/ltpc.c
1	|	/drivers/winbond-840.c
1	|	/fs/dir.c
1	|	/net/tulip_core.c
1	|	/drivers/scsi_debug.c
1	|	/message/i2o_scsi.c
1	|	/fs/inode.c
1	|	/char/pcigame.c
1	|	/2.4.17/shmem.c
1	|	/usb/ftdi_sio.c
1	|	/drivers/eata_pio.c

############################################################
# 2.4.17 specific errors

#
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/hamradio/scc.c:1791:scc_net_ioctl: ERROR:CHECK_ERR: ignored call '__check_region' [COUNTER=__check_region] [fit=1] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=229] [counter=1] [z = 3.17671735928427] [fn-z = -4.35889894354067]
				hwcfg.clock = SCC_DEFAULT_CLOCK;

#ifndef SCC_DONT_CHECK
			disable_irq(hwcfg.irq);


Error --->
			check_region(scc->ctrl, 1);
			Outb(hwcfg.ctrl_a, 0);
			OutReg(hwcfg.ctrl_a, R9, FHWRES);
			udelay(100);
---------------------------------------------------------
[BUG] usb_control_msg calls kmalloc, which can fail.
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/serial/keyspan_pda.c:355:keyspan_pda_break_ctl: ERROR:CHECK_ERR: ignored call 'usb_control_msg' [COUNTER=usb_control_msg] [fit=2] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=165] [counter=3] [z = 1.91157927859293] [fn-z = -4.35889894354067]
	else
		value = 0; /* clear break */
	usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
			4, /* set break */
			USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,

Error --->
			value, 0, NULL, 0, 2*HZ);
	/* there is something funky about this.. the TCSBRK that 'cu' performs
	   ought to translate into a break_ctl(-1),break_ctl(0) pair HZ/4
	   seconds apart, but it feels like the break sent isn't as long as it
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/serial/keyspan_pda.c:218:keyspan_pda_request_unthrottle: ERROR:CHECK_ERR: ignored call 'usb_control_msg' [COUNTER=usb_control_msg] [fit=2] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=165] [counter=3] [z = 1.91157927859293] [fn-z = -4.35889894354067]
			     | USB_DIR_OUT,
			     16, /* value: threshold */
			     0, /* index */
			     NULL,
			     0,

Error --->
			     2*HZ);
	MOD_DEC_USE_COUNT;
}

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/serial/ftdi_sio.c:342:ftdi_sio_open: ERROR:CHECK_ERR: ignored call 'usb_control_msg' [COUNTER=usb_control_msg] [fit=2] [fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=165] [counter=3] [z = 1.91157927859293] [fn-z = -4.35889894354067]
		/* No error checking for this (will get errors later anyway) */
		/* See ftdi_sio.h for description of what is reset */
		usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
				FTDI_SIO_RESET_REQUEST, FTDI_SIO_RESET_REQUEST_TYPE, 
				FTDI_SIO_RESET_SIO, 

Error --->
				0, buf, 0, WDR_TIMEOUT);

		/* Setup termios defaults. According to tty_io.c the 
		   settings are driver specific */
---------------------------------------------------------
[BUG]  seems like it.
/u2/engler/mc/oses/linux/2.4.17/fs/efs/dir.c:78:efs_readdir: ERROR:CHECK_ERR: ignored call 'filldir' [COUNTER=filldir] [fit=4] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=96] [counter=1] [z = 1.79361016917228] [fn-z = -4.35889894354067]
			if (namelen > 0) {
				/* found the next entry */
				filp->f_pos = (block << EFS_DIRBSIZE_BITS) | slot;

				/* copy filename and data in dirslot */

Error --->
				filldir(dirent, nameptr, namelen, filp->f_pos, inodenum, DT_UNKNOWN);

				/* sanity check */
				if (nameptr - (char *) dirblock + namelen > EFS_DIRBSIZE) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/isdn/sc/init.c:382:sc_init: ERROR:CHECK_ERR: ignored call 'request_irq' [COUNTER=request_irq] [fit=5] [fit_fn=1] [fn_ex=2] [fn_counter=1] [ex=310] [counter=10] [z = 1.53896752812773] [fn-z = -2.25170500701057]

		/*
		 * Lock down the hardware resources
		 */
		adapter[cinst]->interrupt = irq[b];

Error --->
		REQUEST_IRQ(adapter[cinst]->interrupt, interrupt_handler, SA_INTERRUPT, 
			interface->id, NULL);
		adapter[cinst]->iobase = io[b];
		for(i = 0 ; i < MAX_IO_REGS - 1 ; i++) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/eata_pio.c:962:eata_pio_detect: ERROR:CHECK_ERR: ignored call 'request_irq' [COUNTER=request_irq] [fit=5] [fit_fn=2] [fn_ex=1] [fn_counter=1] [ex=310] [counter=10] [z = 1.53896752812773] [fn-z = -2.91998558035372]

    find_pio_ISA(&gc, tpnt);
    
    for (i = 0; i <= MAXIRQ; i++)
	if (reg_IRQ[i])

Error --->
	    request_irq(i, do_eata_pio_int_handler, SA_INTERRUPT, "EATA-PIO", NULL);
    
    HBA_ptr = first_HBA;
  
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/pcmcia/i82365.c:1613:init_i82365: ERROR:CHECK_ERR: ignored call 'request_irq' [COUNTER=request_irq] [fit=5] [fit_fn=3] [fn_ex=1] [fn_counter=1] [ex=310] [counter=10] [z = 1.53896752812773] [fn-z = -2.91998558035372]
    }

    /* Set up interrupt handler(s) */
#ifdef CONFIG_ISA
    if (grab_irq != 0)

Error --->
	request_irq(cs_irq, pcic_interrupt, 0, "i82365", pcic_interrupt);
#endif
    
    if (register_ss_entry(sockets, &pcic_operations) != 0)
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/pcmcia/axnet_cs.c:661:axnet_open: ERROR:CHECK_ERR: ignored call 'request_irq' [COUNTER=request_irq] [fit=5] [fit_fn=4] [fn_ex=0] [fn_counter=1] [ex=310] [counter=10] [z = 1.53896752812773] [fn-z = -4.35889894354067]
	return -ENODEV;

    link->open++;
    MOD_INC_USE_COUNT;


Error --->
    request_irq(dev->irq, ei_irq_wrapper, SA_SHIRQ, dev_info, dev);

    info->link_status = 0x00;
    info->watchdog.function = &ei_watchdog;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/aironet4500_card.c:422:awc4500_pnp_probe: ERROR:CHECK_ERR: ignored call 'request_irq' [COUNTER=request_irq] [fit=5] [fit_fn=5] [fn_ex=0] [fn_counter=1] [ex=310] [counter=10] [z = 1.53896752812773] [fn-z = -4.35889894354067]
		dev->tx_timeout = &awc_tx_timeout;
		dev->watchdog_timeo = AWC_TX_TIMEOUT;
		
		netif_start_queue (dev);
		

Error --->
		request_irq(dev->irq,awc_interrupt , SA_SHIRQ | SA_INTERRUPT ,"Aironet 4X00",dev);

		awc_private_init( dev);

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/aironet4500_card.c:593:awc4500_isa_probe: ERROR:CHECK_ERR: ignored call 'request_irq' [COUNTER=request_irq] [fit=5] [fit_fn=6] [fn_ex=0] [fn_counter=1] [ex=310] [counter=10] [z = 1.53896752812773] [fn-z = -4.35889894354067]
	    	dev->base_addr = isa_ioaddr;
	    	dev->irq = isa_irq_line;
		dev->tx_timeout = &awc_tx_timeout;
		dev->watchdog_timeo = AWC_TX_TIMEOUT;
		

Error --->
		request_irq(dev->irq,awc_interrupt ,SA_INTERRUPT ,"Aironet 4X00",dev);

		awc_private_init( dev);
		if ( awc_init(dev) ){
---------------------------------------------------------
[BUG] casts, but doesn't it always have to check? (cause of kmalloc if nothing else)
/u2/engler/mc/oses/linux/2.4.17/drivers/net/appletalk/ltpc.c:1203:ltpc_probe: ERROR:CHECK_ERR: ignored call 'request_irq' [COUNTER=request_irq] [fit=5] [fit_fn=7] [fn_ex=0] [fn_counter=1] [ex=310] [counter=10] [z = 1.53896752812773] [fn-z = -4.35889894354067]
		printk("setting up timer and irq\n");
	}

	if (irq) {
		/* grab it and don't let go :-) */

Error --->
		(void) request_irq( irq, &ltpc_interrupt, 0, "ltpc", dev);
		(void) inb_p(io+7);  /* enable interrupts from board */
		(void) inb_p(io+7);  /* and reset irq line */
	} else {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/char/pc_keyb.c:916:pckbd_init_hw: ERROR:CHECK_ERR: ignored call 'request_irq' [COUNTER=request_irq] [fit=5] [fit_fn=8] [fn_ex=0] [fn_counter=1] [ex=310] [counter=10] [z = 1.53896752812773] [fn-z = -4.35889894354067]
#endif

	kbd_rate = pckbd_rate;

	/* Ok, finally allocate the IRQ, and off we go.. */

Error --->
	kbd_request_irq(keyboard_interrupt);
}

#if defined CONFIG_PSMOUSE
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/wireless/orinoco_plx.c:241:orinoco_plx_init_one: ERROR:CHECK_ERR: ignored call 'request_irq' [COUNTER=request_irq] [fit=5] [fit_fn=9] [fn_ex=0] [fn_counter=1] [ex=310] [counter=10] [z = 1.53896752812773] [fn-z = -4.35889894354067]

	hermes_struct_init(&(priv->hw), dev->base_addr);	/* XXX */
	dev->name[0] = '\0';	/* name defaults to ethX */
	register_netdev(dev);
	request_irq(pdev->irq, orinoco_plx_interrupt, SA_SHIRQ, dev->name,

Error --->
		    dev);
	if (dldwd_proc_dev_init(priv) != 0) {
		printk(KERN_ERR "%s: Failed to create /proc node\n", dev->name);
		return -EIO;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/pcmcia/pcnet_cs.c:1028:pcnet_open: ERROR:CHECK_ERR: ignored call 'request_irq' [COUNTER=request_irq] [fit=5] [fit_fn=10] [fn_ex=0] [fn_counter=1] [ex=310] [counter=10] [z = 1.53896752812773] [fn-z = -4.35889894354067]

    link->open++;
    MOD_INC_USE_COUNT;

    set_misc_reg(dev);

Error --->
    request_irq(dev->irq, ei_irq_wrapper, SA_SHIRQ, dev_info, dev);

    info->phy_id = info->eth_phy;
    info->link_status = 0x00;
---------------------------------------------------------
[BUG] 133 checks can't be wrong.
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/printer.c:432:usblp_write: ERROR:CHECK_ERR: ignored call 'usb_submit_urb' [COUNTER=usb_submit_urb] [fit=6] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=133] [counter=3] [z = 1.4950900031928] [fn-z = -4.35889894354067]

		if (copy_from_user(usblp->writeurb.transfer_buffer, buffer + writecount,
				usblp->writeurb.transfer_buffer_length)) return -EFAULT;

		usblp->writeurb.dev = usblp->dev;

Error --->
		usb_submit_urb(&usblp->writeurb);
		up (&usblp->sem);
	}

---------------------------------------------------------
[BUG] can they?
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/printer.c:482:usblp_read: ERROR:CHECK_ERR: ignored call 'usb_submit_urb' [COUNTER=usb_submit_urb] [fit=6] [fit_fn=2] [fn_ex=0] [fn_counter=2] [ex=133] [counter=3] [z = 1.4950900031928] [fn-z = -6.16441400296897]
	if (usblp->readurb.status) {
		err("usblp%d: error %d reading from printer",
			usblp->minor, usblp->readurb.status);
		usblp->readurb.dev = usblp->dev;
 		usblp->readcount = 0;

Error --->
		usb_submit_urb(&usblp->readurb);
		count = -EIO;
		goto done;
	}
---------------------------------------------------------
[BUG] probable bug.
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/printer.c:498:usblp_read: ERROR:CHECK_ERR: ignored call 'usb_submit_urb' [COUNTER=usb_submit_urb] [fit=6] [fit_fn=2] [fn_ex=0] [fn_counter=2] [ex=133] [counter=3] [z = 1.4950900031928] [fn-z = -6.16441400296897]
	}

	if ((usblp->readcount += count) == usblp->readurb.actual_length) {
		usblp->readcount = 0;
		usblp->readurb.dev = usblp->dev;

Error --->
		usb_submit_urb(&usblp->readurb);
	}

done:
---------------------------------------------------------
[BUG] calls kmalloc which can fail.
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/scsi_debug.c:622:scsi_debug_detect: ERROR:CHECK_ERR: ignored call 'scsi_register' [COUNTER=scsi_register] [fit=9] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=52] [counter=1] [z = 1.03991826124437] [fn-z = -4.35889894354067]
{
	int i;

	for (i = 0; i < NR_HOSTS_PRESENT; i++) {
		tpnt->proc_name = "scsi_debug";	/* Huh? In the loop??? */

Error --->
		scsi_register(tpnt, 0);
	}
	return NR_HOSTS_PRESENT;
}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/message/i2o/i2o_scsi.c:365:i2o_scsi_init: ERROR:CHECK_ERR: ignored call 'i2o_query_scalar' [COUNTER=i2o_query_scalar] [fit=10] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=44] [counter=1] [z = 0.854981960070962] [fn-z = -4.35889894354067]
			dprintk(("Found disk %d %d.\n", target, lun));
			h->task[target][lun]=unit->lct_data.tid;
			h->tagclock[target][lun]=jiffies;

			/* Get the max fragments/request */

Error --->
			i2o_query_scalar(c, d->lct_data.tid, 0xF103, 3, &limit, 2);
			
			/* sanity */
			if ( limit == 0 )
---------------------------------------------------------
[BUG] is there some reason they don't have to check here?
/u2/engler/mc/oses/linux/2.4.17/drivers/char/tty_io.c:2125:tty_unregister_driver: ERROR:CHECK_ERR: ignored call 'devfs_register_chrdev' [COUNTER=devfs_register_chrdev] [fit=14] [fit_fn=1] [fn_ex=1] [fn_counter=1] [ex=33] [counter=1] [z = 0.550822632755244] [fn-z = -2.91998558035372]
	if (othername == NULL) {
		retval = devfs_unregister_chrdev(driver->major, driver->name);
		if (retval)
			return retval;
	} else

Error --->
		devfs_register_chrdev(driver->major, othername, &tty_fops);

	if (driver->prev)
		driver->prev->next = driver->next;
---------------------------------------------------------
[BUG] sysclt can fail if kmalloc fails.
/u2/engler/mc/oses/linux/2.4.17/kernel/exec_domain.c:280:abi_register_sysctl: ERROR:CHECK_ERR: ignored call 'register_sysctl_table' [COUNTER=register_sysctl_table] [fit=16] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=31] [counter=1] [z = 0.486664263392289] [fn-z = -4.35889894354067]
};

static int __init
abi_register_sysctl(void)
{

Error --->
	register_sysctl_table(abi_root_table, 1);
	return 0;
}

---------------------------------------------------------
[BUG] can get EBUSY from register_filesystem can't it?  or it can't because
	they know the type cannot be in there already?  43 other places do use
	the result.
/u2/engler/mc/oses/linux/2.4.17/net/socket.c:1714:sock_init: ERROR:CHECK_ERR: ignored call 'register_filesystem' [COUNTER=register_filesystem] [fit=23] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=43] [counter=2] [z = 0.170996392014195] [fn-z = -4.35889894354067]

	/*
	 *	Initialize the protocols module. 
	 */


Error --->
	register_filesystem(&sock_fs_type);
	sock_mnt = kern_mount(&sock_fs_type);
	/* The real protocol initialization is performed when
	 *  do_initcalls is run.  
---------------------------------------------------------
[BUG] can run out of memory.
/u2/engler/mc/oses/linux/2.4.17/net/8021q/vlan.c:444:register_802_1Q_vlan_device: ERROR:CHECK_ERR: ignored call 'register_netdevice' [COUNTER=register_netdevice] [fit=24] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=21] [counter=1] [z = 0.0978231976089055] [fn-z = -4.35889894354067]
	grp->vlan_devices[VLAN_ID] = new_dev;
	vlan_proc_add_dev(new_dev); /* create it's proc entry */

	/* TODO: Please check this: RTNL   --Ben */
	rtnl_lock();

Error --->
	register_netdevice(new_dev);
	rtnl_unlock();
	    
	/* NOTE:  We have a reference to the real device,
---------------------------------------------------------
[BUG] shoujldn't it be doing a sanity check?
/u2/engler/mc/oses/linux/2.4.17/fs/proc/inode.c:202:proc_read_super: ERROR:CHECK_ERR: ignored call 'parse_options' [COUNTER=parse_options] [fit=25] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=21] [counter=1] [z = 0.0978231976089055] [fn-z = -4.35889894354067]
	for_each_task(p) if (p->pid) root_inode->i_nlink++;
	read_unlock(&tasklist_lock);
	s->s_root = d_alloc_root(root_inode);
	if (!s->s_root)
		goto out_no_root;

Error --->
	parse_options(data, &root_inode->i_uid, &root_inode->i_gid);
	return s;

out_no_root:
---------------------------------------------------------
[BUG] lots of places check...
/u2/engler/mc/oses/linux/2.4.17/net/sunrpc/xprt.c:641:csum_partial_copy_to_page_cache: ERROR:CHECK_ERR: ignored call 'skb_copy_bits' [COUNTER=skb_copy_bits] [fit=31] [fit_fn=1] [fn_ex=1] [fn_counter=1] [ex=18] [counter=1] [z = -0.0526315789473686] [fn-z = -2.91998558035372]
				csum2 = skb_copy_and_csum_bits(skb, offset,
							       cur_ptr,
							       to_move, 0);
				csum = csum_block_add(csum, csum2, offset);
			} else

Error --->
				skb_copy_bits(skb, offset, cur_ptr, to_move);
			offset += to_move;
			copied -= to_move;
			cur_ptr += to_move;
---------------------------------------------------------
[BUG] calls kmalloc.
/u2/engler/mc/oses/linux/2.4.17/drivers/char/pty.c:432:pty_init: ERROR:CHECK_ERR: ignored call 'devfs_mk_dir' [COUNTER=devfs_mk_dir] [fit=32] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=36] [counter=2] [z = -0.0744322927564789] [fn-z = -4.35889894354067]
	 */
	pty_driver.ioctl = pty_bsd_ioctl;

	/* Unix98 devices */
#ifdef CONFIG_UNIX98_PTYS

Error --->
	devfs_mk_dir (NULL, "pts", NULL);
	printk("pty: %d Unix98 ptys configured\n", UNIX98_NR_MAJORS*NR_PTYS);
	for ( i = 0 ; i < UNIX98_NR_MAJORS ; i++ ) {
		int j;
---------------------------------------------------------
[BUG] calls kmalloc.
/u2/engler/mc/oses/linux/2.4.17/mm/shmem.c:1402:init_shmem_fs: ERROR:CHECK_ERR: ignored call 'devfs_mk_dir' [COUNTER=devfs_mk_dir] [fit=32] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=36] [counter=2] [z = -0.0744322927564789] [fn-z = -4.35889894354067]
#ifdef CONFIG_TMPFS
	if ((error = register_filesystem(&shmem_fs_type))) {
		printk (KERN_ERR "Could not register shm fs\n");
		return error;
	}

Error --->
	devfs_mk_dir (NULL, "shm", NULL);
#endif
	res = kern_mount(&tmpfs_fs_type);
	if (IS_ERR (res)) {
---------------------------------------------------------
[BUG] can fail according to implementation...
/u2/engler/mc/oses/linux/2.4.17/drivers/sound/i810_audio.c:2860:i810_pm_resume: ERROR:CHECK_ERR: ignored call 'pci_enable_device' [COUNTER=pci_enable_device] [fit=38] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=142] [counter=8] [z = -0.187317162316337] [fn-z = -4.35889894354067]

static int i810_pm_resume(struct pci_dev *dev)
{
	int num_ac97,i=0;
	struct i810_card *card=pci_get_drvdata(dev);

Error --->
	pci_enable_device(dev);
	pci_restore_state (dev,card->pm_save_state);

	/* observation of a toshiba portege 3440ct suggests that the 
---------------------------------------------------------
[BUG] indeed.
/u2/engler/mc/oses/linux/2.4.17/drivers/atm/ambassador.c:2428:setup_pci_dev: ERROR:CHECK_ERR: ignored call 'pci_enable_device' [COUNTER=pci_enable_device] [fit=38] [fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=142] [counter=8] [z = -0.187317162316337] [fn-z = -4.35889894354067]
    
    void setup_pci_dev (void) {
      unsigned char lat;
      
      /* XXX check return value */

Error --->
      pci_enable_device (pci_dev);

      // enable bus master accesses
      pci_set_master (pci_dev);
---------------------------------------------------------
[BUG] yup.
/u2/engler/mc/oses/linux/2.4.17/drivers/pcmcia/cardbus.c:298:cb_alloc: ERROR:CHECK_ERR: ignored call 'pci_enable_device' [COUNTER=pci_enable_device] [fit=38] [fit_fn=4] [fn_ex=0] [fn_counter=1] [ex=142] [counter=8] [z = -0.187317162316337] [fn-z = -4.35889894354067]
		if (irq_pin) {
			dev->irq = irq;
			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
		}


Error --->
		pci_enable_device(dev); /* XXX check return */
		pci_insert_device(dev, bus);
	}

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/winbond-840.c:1671:w840_resume: ERROR:CHECK_ERR: ignored call 'pci_enable_device' [COUNTER=pci_enable_device] [fit=38] [fit_fn=5] [fn_ex=0] [fn_counter=1] [ex=142] [counter=8] [z = -0.187317162316337] [fn-z = -4.35889894354067]

	rtnl_lock();
	if (netif_device_present(dev))
		goto out; /* device not suspended */
	if (netif_running(dev)) {

Error --->
		pci_enable_device(pdev);
	/*	pci_power_on(pdev); */

		spin_lock_irq(&np->lock);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/char/joystick/pcigame.c:150:pcigame_probe: ERROR:CHECK_ERR: ignored call 'pci_enable_device' [COUNTER=pci_enable_device] [fit=38] [fit_fn=6] [fn_ex=0] [fn_counter=1] [ex=142] [counter=8] [z = -0.187317162316337] [fn-z = -4.35889894354067]

	for (i = 0; i < 6; i++)
		if (~pci_resource_flags(dev, i) & IORESOURCE_IO)
			break;


Error --->
	pci_enable_device(dev);

	pcigame->base = ioremap(pci_resource_start(pcigame->dev, i),
				pci_resource_len(pcigame->dev, i));
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/tulip/tulip_core.c:1849:tulip_resume: ERROR:CHECK_ERR: ignored call 'pci_enable_device' [COUNTER=pci_enable_device] [fit=38] [fit_fn=7] [fn_ex=0] [fn_counter=1] [ex=142] [counter=8] [z = -0.187317162316337] [fn-z = -4.35889894354067]
{
	struct net_device *dev = pci_get_drvdata(pdev);

	if (dev && netif_running (dev) && !netif_device_present (dev)) {
#if 1

Error --->
		pci_enable_device (pdev);
#endif
		/* pci_power_on(pdev); */
		tulip_up (dev);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/natsemi.c:2496:natsemi_resume: ERROR:CHECK_ERR: ignored call 'pci_enable_device' [COUNTER=pci_enable_device] [fit=38] [fit_fn=8] [fn_ex=0] [fn_counter=1] [ex=142] [counter=8] [z = -0.187317162316337] [fn-z = -4.35889894354067]

	rtnl_lock();
	if (netif_device_present(dev))
		goto out;
	if (netif_running(dev)) {

Error --->
		pci_enable_device(pdev);
	/*	pci_power_on(pdev); */
		
		natsemi_reset(dev);
---------------------------------------------------------
[BUG] can call kmalloc
/u2/engler/mc/oses/linux/2.4.17/drivers/net/pcmcia/pcnet_cs.c:314:pcnet_attach: ERROR:CHECK_ERR: ignored call 'ethdev_init' [COUNTER=ethdev_init] [fit=50] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=13] [counter=1] [z = -0.367883603690978] [fn-z = -4.35889894354067]
	for (i = 0; i < 4; i++)
	    link->irq.IRQInfo2 |= 1 << irq_list[i];
    link->conf.Attributes = CONF_ENABLE_IRQ;
    link->conf.IntType = INT_MEMORY_AND_IO;


Error --->
    ethdev_init(dev);
    dev->init = &pcnet_init;
    dev->open = &pcnet_open;
    dev->stop = &pcnet_close;

