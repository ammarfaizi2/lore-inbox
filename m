Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030690AbWHILZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030690AbWHILZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030691AbWHILZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:25:13 -0400
Received: from mx3.aixit.com ([82.149.224.22]:16060 "EHLO mx3.aixit.com")
	by vger.kernel.org with ESMTP id S1030690AbWHILZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:25:09 -0400
X-Qmail-Scanner-Mail-From: lk@stresslinux.org via mx3
X-Qmail-Scanner: 1.25 (Clear:RC:1(82.149.224.60):. Processed in 0.210011 secs)
Message-ID: <44D9C611.6030606@stresslinux.org>
Date: Wed, 09 Aug 2006 13:25:05 +0200
From: Stresslinux Kernel <lk@stresslinux.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.8
References: <20060807051118.GA29831@kroah.com> <20060807051329.GB29831@kroah.com>
In-Reply-To: <20060807051329.GB29831@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

can you pleas update the LATEST-IS file on kernel.org to the current version?

thanks

Carsten

Greg KH schrieb:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3c5842..6a1bb87 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2572,6 +2572,14 @@ M:	dbrownell@users.sourceforge.net
>  L:	spi-devel-general@lists.sourceforge.net
>  S:	Maintained
>  
> +STABLE BRANCH:
> +P:	Greg Kroah-Hartman
> +M:	greg@kroah.com
> +P:	Chris Wright
> +M:	chrisw@sous-sol.org
> +L:	stable@kernel.org
> +S:	Maintained
> +
>  TPM DEVICE DRIVER
>  P:	Kylene Hall
>  M:	kjhall@us.ibm.com
> diff --git a/Makefile b/Makefile
> index 1f89bc5..4c9fe27 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,7 @@
>  VERSION = 2
>  PATCHLEVEL = 6
>  SUBLEVEL = 17
> -EXTRAVERSION = .7
> +EXTRAVERSION = .8
>  NAME=Crazed Snow-Weasel
>  
>  # *DOCUMENTATION*
> diff --git a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
> index 6b1ea0c..e545b09 100644
> --- a/arch/i386/pci/mmconfig.c
> +++ b/arch/i386/pci/mmconfig.c
> @@ -15,7 +15,9 @@ #include <linux/acpi.h>
>  #include <asm/e820.h>
>  #include "pci.h"
>  
> -#define MMCONFIG_APER_SIZE (256*1024*1024)
> +/* aperture is up to 256MB but BIOS may reserve less */
> +#define MMCONFIG_APER_MIN	(2 * 1024*1024)
> +#define MMCONFIG_APER_MAX	(256 * 1024*1024)
>  
>  /* Assume systems with more busses have correct MCFG */
>  #define MAX_CHECK_BUS 16
> @@ -197,9 +199,10 @@ void __init pci_mmcfg_init(void)
>  		return;
>  
>  	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
> -			pci_mmcfg_config[0].base_address + MMCONFIG_APER_SIZE,
> +			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
>  			E820_RESERVED)) {
> -		printk(KERN_ERR "PCI: BIOS Bug: MCFG area is not E820-reserved\n");
> +		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
> +				pci_mmcfg_config[0].base_address);
>  		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
>  		return;
>  	}
> diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
> index a2060e4..3c55c76 100644
> --- a/arch/x86_64/pci/mmconfig.c
> +++ b/arch/x86_64/pci/mmconfig.c
> @@ -13,7 +13,10 @@ #include <asm/e820.h>
>  
>  #include "pci.h"
>  
> -#define MMCONFIG_APER_SIZE (256*1024*1024)
> +/* aperture is up to 256MB but BIOS may reserve less */
> +#define MMCONFIG_APER_MIN	(2 * 1024*1024)
> +#define MMCONFIG_APER_MAX	(256 * 1024*1024)
> +
>  /* Verify the first 16 busses. We assume that systems with more busses
>     get MCFG right. */
>  #define MAX_CHECK_BUS 16
> @@ -175,9 +178,10 @@ void __init pci_mmcfg_init(void)
>  		return;
>  
>  	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
> -			pci_mmcfg_config[0].base_address + MMCONFIG_APER_SIZE,
> +			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
>  			E820_RESERVED)) {
> -		printk(KERN_ERR "PCI: BIOS Bug: MCFG area is not E820-reserved\n");
> +		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
> +				pci_mmcfg_config[0].base_address);
>  		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
>  		return;
>  	}
> @@ -190,7 +194,8 @@ void __init pci_mmcfg_init(void)
>  	}
>  	for (i = 0; i < pci_mmcfg_config_num; ++i) {
>  		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
> -		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);
> +		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address,
> +							 MMCONFIG_APER_MAX);
>  		if (!pci_mmcfg_virt[i].virt) {
>  			printk("PCI: Cannot map mmconfig aperture for segment %d\n",
>  			       pci_mmcfg_config[i].pci_segment_group_number);
> diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
> index a88b94a..832163c 100644
> --- a/drivers/char/tty_io.c
> +++ b/drivers/char/tty_io.c
> @@ -2776,7 +2776,7 @@ static void flush_to_ldisc(void *private
>  	struct tty_struct *tty = (struct tty_struct *) private_;
>  	unsigned long 	flags;
>  	struct tty_ldisc *disc;
> -	struct tty_buffer *tbuf;
> +	struct tty_buffer *tbuf, *head;
>  	int count;
>  	char *char_buf;
>  	unsigned char *flag_buf;
> @@ -2793,7 +2793,9 @@ static void flush_to_ldisc(void *private
>  		goto out;
>  	}
>  	spin_lock_irqsave(&tty->buf.lock, flags);
> -	while((tbuf = tty->buf.head) != NULL) {
> +	head = tty->buf.head;
> +	tty->buf.head = NULL;
> +	while((tbuf = head) != NULL) {
>  		while ((count = tbuf->commit - tbuf->read) != 0) {
>  			char_buf = tbuf->char_buf_ptr + tbuf->read;
>  			flag_buf = tbuf->flag_buf_ptr + tbuf->read;
> @@ -2802,10 +2804,12 @@ static void flush_to_ldisc(void *private
>  			disc->receive_buf(tty, char_buf, flag_buf, count);
>  			spin_lock_irqsave(&tty->buf.lock, flags);
>  		}
> -		if (tbuf->active)
> +		if (tbuf->active) {
> +			tty->buf.head = head;
>  			break;
> -		tty->buf.head = tbuf->next;
> -		if (tty->buf.head == NULL)
> +		}
> +		head = tbuf->next;
> +		if (head == NULL)
>  			tty->buf.tail = NULL;
>  		tty_buffer_free(tty, tbuf);
>  	}
> diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
> index 766cc96..9b4f4ee 100644
> --- a/drivers/i2c/busses/scx200_acb.c
> +++ b/drivers/i2c/busses/scx200_acb.c
> @@ -181,21 +181,21 @@ static void scx200_acb_machine(struct sc
>  		break;
>  
>  	case state_read:
> -		/* Set ACK if receiving the last byte */
> -		if (iface->len == 1)
> +		/* Set ACK if _next_ byte will be the last one */
> +		if (iface->len == 2)
>  			outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
>  		else
>  			outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
>  
> -		*iface->ptr++ = inb(ACBSDA);
> -		--iface->len;
> -
> -		if (iface->len == 0) {
> +		if (iface->len == 1) {
>  			iface->result = 0;
>  			iface->state = state_idle;
>  			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
>  		}
>  
> +		*iface->ptr++ = inb(ACBSDA);
> +		--iface->len;
> +
>  		break;
>  
>  	case state_write:
> @@ -304,8 +304,12 @@ static s32 scx200_acb_smbus_xfer(struct 
>  		buffer = (u8 *)&cur_word;
>  		break;
>  
> -	case I2C_SMBUS_BLOCK_DATA:
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		if (rw == I2C_SMBUS_READ)
> +			data->block[0] = I2C_SMBUS_BLOCK_MAX; /* For now */
>  		len = data->block[0];
> +		if (len == 0 || len > I2C_SMBUS_BLOCK_MAX)
> +			return -EINVAL;
>  		buffer = &data->block[1];
>  		break;
>  
> @@ -369,7 +373,7 @@ static u32 scx200_acb_func(struct i2c_ad
>  {
>  	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
>  	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> -	       I2C_FUNC_SMBUS_BLOCK_DATA;
> +	       I2C_FUNC_SMBUS_I2C_BLOCK;
>  }
>  
>  /* For now, we only handle combined mode (smbus) */
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 45e2cdf..2e79137 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -756,9 +756,9 @@ int i2c_probe(struct i2c_adapter *adapte
>  					"parameter for adapter %d, "
>  					"addr 0x%02x\n", adap_id,
>  					address_data->ignore[j + 1]);
> +				ignore = 1;
> +				break;
>  			}
> -			ignore = 1;
> -			break;
>  		}
>  		if (ignore)
>  			continue;
> diff --git a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
> index 5413dc4..e084dbf 100644
> --- a/drivers/ieee1394/sbp2.c
> +++ b/drivers/ieee1394/sbp2.c
> @@ -2541,6 +2541,9 @@ static int sbp2scsi_slave_configure(stru
>  		sdev->skip_ms_page_8 = 1;
>  	if (scsi_id->workarounds & SBP2_WORKAROUND_FIX_CAPACITY)
>  		sdev->fix_capacity = 1;
> +	if (scsi_id->ne->guid_vendor_id == 0x0010b9 && /* Maxtor's OUI */
> +	    (sdev->type == TYPE_DISK || sdev->type == TYPE_RBC))
> +		sdev->allow_restart = 1;
>  	return 0;
>  }
>  
> diff --git a/drivers/media/dvb/ttpci/budget-av.c b/drivers/media/dvb/ttpci/budget-av.c
> index aaaae40..3f4aa08 100644
> --- a/drivers/media/dvb/ttpci/budget-av.c
> +++ b/drivers/media/dvb/ttpci/budget-av.c
> @@ -58,6 +58,7 @@ struct budget_av {
>  	struct tasklet_struct ciintf_irq_tasklet;
>  	int slot_status;
>  	struct dvb_ca_en50221 ca;
> +	u8 reinitialise_demod:1;
>  };
>  
>  /* GPIO Connections:
> @@ -214,8 +215,9 @@ static int ciintf_slot_reset(struct dvb_
>  	while (--timeout > 0 && ciintf_read_attribute_mem(ca, slot, 0) != 0x1d)
>  		msleep(100);
>  
> -	/* reinitialise the frontend */
> -	dvb_frontend_reinitialise(budget_av->budget.dvb_frontend);
> +	/* reinitialise the frontend if necessary */
> +	if (budget_av->reinitialise_demod)
> +		dvb_frontend_reinitialise(budget_av->budget.dvb_frontend);
>  
>  	if (timeout <= 0)
>  	{
> @@ -1064,12 +1066,10 @@ static void frontend_init(struct budget_
>  		fe = tda10021_attach(&philips_cu1216_config,
>  				     &budget_av->budget.i2c_adap,
>  				     read_pwm(budget_av));
> -		if (fe) {
> -			fe->ops.tuner_ops.set_params = philips_cu1216_tuner_set_params;
> -		}
>  		break;
>  
>  	case SUBID_DVBC_KNC1_PLUS:
> +		budget_av->reinitialise_demod = 1;
>  		fe = tda10021_attach(&philips_cu1216_config,
>  				     &budget_av->budget.i2c_adap,
>  				     read_pwm(budget_av));
> diff --git a/drivers/net/e1000/e1000_hw.c b/drivers/net/e1000/e1000_hw.c
> index 523c2c9..c5e7023 100644
> --- a/drivers/net/e1000/e1000_hw.c
> +++ b/drivers/net/e1000/e1000_hw.c
> @@ -353,6 +353,7 @@ e1000_set_mac_type(struct e1000_hw *hw)
>      case E1000_DEV_ID_82572EI_COPPER:
>      case E1000_DEV_ID_82572EI_FIBER:
>      case E1000_DEV_ID_82572EI_SERDES:
> +    case E1000_DEV_ID_82572EI:
>          hw->mac_type = e1000_82572;
>          break;
>      case E1000_DEV_ID_82573E:
> diff --git a/drivers/net/e1000/e1000_hw.h b/drivers/net/e1000/e1000_hw.h
> index 150e45e..c01e5d2 100644
> --- a/drivers/net/e1000/e1000_hw.h
> +++ b/drivers/net/e1000/e1000_hw.h
> @@ -462,6 +462,7 @@ #define E1000_DEV_ID_82571EB_SERDES     
>  #define E1000_DEV_ID_82572EI_COPPER      0x107D
>  #define E1000_DEV_ID_82572EI_FIBER       0x107E
>  #define E1000_DEV_ID_82572EI_SERDES      0x107F
> +#define E1000_DEV_ID_82572EI             0x10B9
>  #define E1000_DEV_ID_82573E              0x108B
>  #define E1000_DEV_ID_82573E_IAMT         0x108C
>  #define E1000_DEV_ID_82573L              0x109A
> diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
> index fba1e4d..a3cd0b3 100644
> --- a/drivers/net/sky2.c
> +++ b/drivers/net/sky2.c
> @@ -2187,9 +2187,6 @@ static int sky2_poll(struct net_device *
>  	int work_done = 0;
>  	u32 status = sky2_read32(hw, B0_Y2_SP_EISR);
>  
> -	if (!~status)
> -		goto out;
> -
>  	if (status & Y2_IS_HW_ERR)
>  		sky2_hw_intr(hw);
>  
> @@ -2226,7 +2223,7 @@ static int sky2_poll(struct net_device *
>  
>  	if (sky2_more_work(hw))
>  		return 1;
> -out:
> +
>  	netif_rx_complete(dev0);
>  
>  	sky2_read32(hw, B0_Y2_SP_LISR);
> diff --git a/drivers/usb/host/uhci-q.c b/drivers/usb/host/uhci-q.c
> index a06d84c..27909bc 100644
> --- a/drivers/usb/host/uhci-q.c
> +++ b/drivers/usb/host/uhci-q.c
> @@ -896,12 +896,14 @@ static int uhci_result_common(struct uhc
>  			/*
>  			 * This URB stopped short of its end.  We have to
>  			 * fix up the toggles of the following URBs on the
> -			 * queue and restart the queue.
> +			 * queue and restart the queue.  But only if this
> +			 * TD isn't the last one in the URB.
>  			 *
>  			 * Do this only the first time we encounter the
>  			 * short URB.
>  			 */
> -			if (!urbp->short_transfer) {
> +			if (!urbp->short_transfer &&
> +					&td->list != urbp->td_list.prev) {
>  				urbp->short_transfer = 1;
>  				urbp->qh->initial_toggle =
>  						uhci_toggle(td_token(td)) ^ 1;
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 23f1f3a..7f6d659 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -473,13 +473,18 @@ out:
>     pass does the actual I/O. */
>  void invalidate_bdev(struct block_device *bdev, int destroy_dirty_buffers)
>  {
> +	struct address_space *mapping = bdev->bd_inode->i_mapping;
> +
> +	if (mapping->nrpages == 0)
> +		return;
> +
>  	invalidate_bh_lrus();
>  	/*
>  	 * FIXME: what about destroy_dirty_buffers?
>  	 * We really want to use invalidate_inode_pages2() for
>  	 * that, but not until that's cleaned up.
>  	 */
> -	invalidate_inode_pages(bdev->bd_inode->i_mapping);
> +	invalidate_inode_pages(mapping);
>  }
>  
>  /*
> diff --git a/fs/ext3/inode.c b/fs/ext3/inode.c
> index 2edd7ee..21b8bf4 100644
> --- a/fs/ext3/inode.c
> +++ b/fs/ext3/inode.c
> @@ -1159,7 +1159,7 @@ retry:
>  		ret = PTR_ERR(handle);
>  		goto out;
>  	}
> -	if (test_opt(inode->i_sb, NOBH))
> +	if (test_opt(inode->i_sb, NOBH) && ext3_should_writeback_data(inode))
>  		ret = nobh_prepare_write(page, from, to, ext3_get_block);
>  	else
>  		ret = block_prepare_write(page, from, to, ext3_get_block);
> @@ -1245,7 +1245,7 @@ static int ext3_writeback_commit_write(s
>  	if (new_i_size > EXT3_I(inode)->i_disksize)
>  		EXT3_I(inode)->i_disksize = new_i_size;
>  
> -	if (test_opt(inode->i_sb, NOBH))
> +	if (test_opt(inode->i_sb, NOBH) && ext3_should_writeback_data(inode))
>  		ret = nobh_commit_write(file, page, from, to);
>  	else
>  		ret = generic_commit_write(file, page, from, to);
> @@ -1495,7 +1495,7 @@ static int ext3_writeback_writepage(stru
>  		goto out_fail;
>  	}
>  
> -	if (test_opt(inode->i_sb, NOBH))
> +	if (test_opt(inode->i_sb, NOBH) && ext3_should_writeback_data(inode))
>  		ret = nobh_writepage(page, ext3_get_block, wbc);
>  	else
>  		ret = block_write_full_page(page, ext3_get_block, wbc);
> @@ -2402,14 +2402,15 @@ static unsigned long ext3_get_inode_bloc
>  	struct buffer_head *bh;
>  	struct ext3_group_desc * gdp;
>  
> -
> -	if ((ino != EXT3_ROOT_INO && ino != EXT3_JOURNAL_INO &&
> -		ino != EXT3_RESIZE_INO && ino < EXT3_FIRST_INO(sb)) ||
> -		ino > le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count)) {
> -		ext3_error(sb, "ext3_get_inode_block",
> -			    "bad inode number: %lu", ino);
> +	if (!ext3_valid_inum(sb, ino)) {
> +		/*
> +		 * This error is already checked for in namei.c unless we are
> +		 * looking at an NFS filehandle, in which case no error
> +		 * report is needed
> +		 */
>  		return 0;
>  	}
> +
>  	block_group = (ino - 1) / EXT3_INODES_PER_GROUP(sb);
>  	if (block_group >= EXT3_SB(sb)->s_groups_count) {
>  		ext3_error(sb,"ext3_get_inode_block","group >= groups count");
> diff --git a/fs/ext3/namei.c b/fs/ext3/namei.c
> index b8f5cd1..7be89fe 100644
> --- a/fs/ext3/namei.c
> +++ b/fs/ext3/namei.c
> @@ -1000,7 +1000,12 @@ static struct dentry *ext3_lookup(struct
>  	if (bh) {
>  		unsigned long ino = le32_to_cpu(de->inode);
>  		brelse (bh);
> -		inode = iget(dir->i_sb, ino);
> +		if (!ext3_valid_inum(dir->i_sb, ino)) {
> +			ext3_error(dir->i_sb, "ext3_lookup",
> +				   "bad inode number: %lu", ino);
> +			inode = NULL;
> +		} else
> +			inode = iget(dir->i_sb, ino);
>  
>  		if (!inode)
>  			return ERR_PTR(-EACCES);
> @@ -1028,7 +1033,13 @@ struct dentry *ext3_get_parent(struct de
>  		return ERR_PTR(-ENOENT);
>  	ino = le32_to_cpu(de->inode);
>  	brelse(bh);
> -	inode = iget(child->d_inode->i_sb, ino);
> +
> +	if (!ext3_valid_inum(child->d_inode->i_sb, ino)) {
> +		ext3_error(child->d_inode->i_sb, "ext3_get_parent",
> +			   "bad inode number: %lu", ino);
> +		inode = NULL;
> +	} else
> +		inode = iget(child->d_inode->i_sb, ino);
>  
>  	if (!inode)
>  		return ERR_PTR(-EACCES);
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index f801693..a3b825f 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -596,6 +596,27 @@ static int proc_permission(struct inode 
>  	return proc_check_root(inode);
>  }
>  
> +static int proc_setattr(struct dentry *dentry, struct iattr *attr)
> +{
> +	int error;
> +	struct inode *inode = dentry->d_inode;
> +
> +	if (attr->ia_valid & ATTR_MODE)
> +		return -EPERM;
> +
> +	error = inode_change_ok(inode, attr);
> +	if (!error) {
> +		error = security_inode_setattr(dentry, attr);
> +		if (!error)
> +			error = inode_setattr(inode, attr);
> +	}
> +	return error;
> +}
> +
> +static struct inode_operations proc_def_inode_operations = {
> +	.setattr	= proc_setattr,
> +};
> +
>  static int proc_task_permission(struct inode *inode, int mask, struct nameidata *nd)
>  {
>  	struct dentry *root;
> @@ -987,6 +1008,7 @@ static struct file_operations proc_oom_a
>  
>  static struct inode_operations proc_mem_inode_operations = {
>  	.permission	= proc_permission,
> +	.setattr	= proc_setattr,
>  };
>  
>  #ifdef CONFIG_AUDITSYSCALL
> @@ -1184,7 +1206,8 @@ out:
>  
>  static struct inode_operations proc_pid_link_inode_operations = {
>  	.readlink	= proc_pid_readlink,
> -	.follow_link	= proc_pid_follow_link
> +	.follow_link	= proc_pid_follow_link,
> +	.setattr	= proc_setattr,
>  };
>  
>  #define NUMBUF 10
> @@ -1356,6 +1379,7 @@ static struct inode *proc_pid_make_inode
>  	ei->task = NULL;
>  	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
>  	inode->i_ino = fake_ino(task->pid, ino);
> +	inode->i_op = &proc_def_inode_operations;
>  
>  	if (!pid_alive(task))
>  		goto out_unlock;
> @@ -1579,11 +1603,13 @@ static struct file_operations proc_task_
>  static struct inode_operations proc_fd_inode_operations = {
>  	.lookup		= proc_lookupfd,
>  	.permission	= proc_permission,
> +	.setattr	= proc_setattr,
>  };
>  
>  static struct inode_operations proc_task_inode_operations = {
>  	.lookup		= proc_task_lookup,
>  	.permission	= proc_task_permission,
> +	.setattr	= proc_setattr,
>  };
>  
>  #ifdef CONFIG_SECURITY
> @@ -1873,10 +1899,12 @@ static struct file_operations proc_tid_b
>  
>  static struct inode_operations proc_tgid_base_inode_operations = {
>  	.lookup		= proc_tgid_base_lookup,
> +	.setattr	= proc_setattr,
>  };
>  
>  static struct inode_operations proc_tid_base_inode_operations = {
>  	.lookup		= proc_tid_base_lookup,
> +	.setattr	= proc_setattr,
>  };
>  
>  #ifdef CONFIG_SECURITY
> @@ -1918,10 +1946,12 @@ static struct dentry *proc_tid_attr_look
>  
>  static struct inode_operations proc_tgid_attr_inode_operations = {
>  	.lookup		= proc_tgid_attr_lookup,
> +	.setattr	= proc_setattr,
>  };
>  
>  static struct inode_operations proc_tid_attr_inode_operations = {
>  	.lookup		= proc_tid_attr_lookup,
> +	.setattr	= proc_setattr,
>  };
>  #endif
>  
> @@ -1946,6 +1976,7 @@ static void *proc_self_follow_link(struc
>  static struct inode_operations proc_self_inode_operations = {
>  	.readlink	= proc_self_readlink,
>  	.follow_link	= proc_self_follow_link,
> +	.setattr	= proc_setattr,
>  };
>  
>  /**
> diff --git a/include/asm-s390/futex.h b/include/asm-s390/futex.h
> index 1802775..ffedf14 100644
> --- a/include/asm-s390/futex.h
> +++ b/include/asm-s390/futex.h
> @@ -98,9 +98,10 @@ futex_atomic_cmpxchg_inatomic(int __user
>  
>  	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
>  		return -EFAULT;
> -	asm volatile("   cs   %1,%4,0(%5)\n"
> +	asm volatile("   sacf 256\n"
> +		     "   cs   %1,%4,0(%5)\n"
>  		     "0: lr   %0,%1\n"
> -		     "1:\n"
> +		     "1: sacf 0\n"
>  #ifndef __s390x__
>  		     ".section __ex_table,\"a\"\n"
>  		     "   .align 4\n"
> diff --git a/include/asm-sparc64/sfp-machine.h b/include/asm-sparc64/sfp-machine.h
> index 5015bb8..89d4243 100644
> --- a/include/asm-sparc64/sfp-machine.h
> +++ b/include/asm-sparc64/sfp-machine.h
> @@ -34,7 +34,7 @@ #define _FP_MUL_MEAT_S(R,X,Y)					\
>  #define _FP_MUL_MEAT_D(R,X,Y)					\
>    _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
>  #define _FP_MUL_MEAT_Q(R,X,Y)					\
> -  _FP_MUL_MEAT_2_wide_3mul(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
> +  _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
>  
>  #define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_imm(S,R,X,Y,_FP_DIV_HELP_imm)
>  #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_1_udiv_norm(D,R,X,Y)
> diff --git a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
> index 3ade6a4..c60ca4c 100644
> --- a/include/linux/ext3_fs.h
> +++ b/include/linux/ext3_fs.h
> @@ -495,6 +495,15 @@ static inline struct ext3_inode_info *EX
>  {
>  	return container_of(inode, struct ext3_inode_info, vfs_inode);
>  }
> +
> +static inline int ext3_valid_inum(struct super_block *sb, unsigned long ino)
> +{
> +	return ino == EXT3_ROOT_INO ||
> +		ino == EXT3_JOURNAL_INO ||
> +		ino == EXT3_RESIZE_INO ||
> +		(ino >= EXT3_FIRST_INO(sb) &&
> +		 ino <= le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count));
> +}
>  #else
>  /* Assume that user mode programs are passing in an ext3fs superblock, not
>   * a kernel struct super_block.  This will allow us to call the feature-test
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index f8f2347..2c31bb0 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -967,15 +967,16 @@ #ifndef NET_SKB_PAD
>  #define NET_SKB_PAD	16
>  #endif
>  
> -extern int ___pskb_trim(struct sk_buff *skb, unsigned int len, int realloc);
> +extern int ___pskb_trim(struct sk_buff *skb, unsigned int len);
>  
>  static inline void __skb_trim(struct sk_buff *skb, unsigned int len)
>  {
> -	if (!skb->data_len) {
> -		skb->len  = len;
> -		skb->tail = skb->data + len;
> -	} else
> -		___pskb_trim(skb, len, 0);
> +	if (unlikely(skb->data_len)) {
> +		WARN_ON(1);
> +		return;
> +	}
> +	skb->len  = len;
> +	skb->tail = skb->data + len;
>  }
>  
>  /**
> @@ -985,6 +986,7 @@ static inline void __skb_trim(struct sk_
>   *
>   *	Cut the length of a buffer down by removing data from the tail. If
>   *	the buffer is already under the length specified it is not modified.
> + *	The skb must be linear.
>   */
>  static inline void skb_trim(struct sk_buff *skb, unsigned int len)
>  {
> @@ -995,12 +997,10 @@ static inline void skb_trim(struct sk_bu
>  
>  static inline int __pskb_trim(struct sk_buff *skb, unsigned int len)
>  {
> -	if (!skb->data_len) {
> -		skb->len  = len;
> -		skb->tail = skb->data+len;
> -		return 0;
> -	}
> -	return ___pskb_trim(skb, len, 1);
> +	if (skb->data_len)
> +		return ___pskb_trim(skb, len);
> +	__skb_trim(skb, len);
> +	return 0;
>  }
>  
>  static inline int pskb_trim(struct sk_buff *skb, unsigned int len)
> diff --git a/kernel/sched.c b/kernel/sched.c
> index c13f1bd..61d1169 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -4044,17 +4044,22 @@ asmlinkage long sys_sched_yield(void)
>  	return 0;
>  }
>  
> -static inline void __cond_resched(void)
> +static inline int __resched_legal(int expected_preempt_count)
> +{
> +	if (unlikely(preempt_count() != expected_preempt_count))
> +		return 0;
> +	if (unlikely(system_state != SYSTEM_RUNNING))
> +		return 0;
> +	return 1;
> +}
> +
> +static void __cond_resched(void)
>  {
>  	/*
>  	 * The BKS might be reacquired before we have dropped
>  	 * PREEMPT_ACTIVE, which could trigger a second
>  	 * cond_resched() call.
>  	 */
> -	if (unlikely(preempt_count()))
> -		return;
> -	if (unlikely(system_state != SYSTEM_RUNNING))
> -		return;
>  	do {
>  		add_preempt_count(PREEMPT_ACTIVE);
>  		schedule();
> @@ -4064,13 +4069,12 @@ static inline void __cond_resched(void)
>  
>  int __sched cond_resched(void)
>  {
> -	if (need_resched()) {
> +	if (need_resched() && __resched_legal(0)) {
>  		__cond_resched();
>  		return 1;
>  	}
>  	return 0;
>  }
> -
>  EXPORT_SYMBOL(cond_resched);
>  
>  /*
> @@ -4091,7 +4095,7 @@ int cond_resched_lock(spinlock_t *lock)
>  		ret = 1;
>  		spin_lock(lock);
>  	}
> -	if (need_resched()) {
> +	if (need_resched() && __resched_legal(1)) {
>  		_raw_spin_unlock(lock);
>  		preempt_enable_no_resched();
>  		__cond_resched();
> @@ -4100,14 +4104,13 @@ int cond_resched_lock(spinlock_t *lock)
>  	}
>  	return ret;
>  }
> -
>  EXPORT_SYMBOL(cond_resched_lock);
>  
>  int __sched cond_resched_softirq(void)
>  {
>  	BUG_ON(!in_softirq());
>  
> -	if (need_resched()) {
> +	if (need_resched() && __resched_legal(0)) {
>  		__local_bh_enable();
>  		__cond_resched();
>  		local_bh_disable();
> @@ -4115,10 +4118,8 @@ int __sched cond_resched_softirq(void)
>  	}
>  	return 0;
>  }
> -
>  EXPORT_SYMBOL(cond_resched_softirq);
>  
> -
>  /**
>   * yield - yield the current processor to other threads.
>   *
> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
> index 3948949..729abc4 100644
> --- a/net/8021q/vlan.c
> +++ b/net/8021q/vlan.c
> @@ -67,10 +67,6 @@ static struct packet_type vlan_packet_ty
>  	.func = vlan_skb_recv, /* VLAN receive method */
>  };
>  
> -/* Bits of netdev state that are propagated from real device to virtual */
> -#define VLAN_LINK_STATE_MASK \
> -	((1<<__LINK_STATE_PRESENT)|(1<<__LINK_STATE_NOCARRIER)|(1<<__LINK_STATE_DORMANT))
> -
>  /* End of global variables definitions. */
>  
>  /*
> @@ -470,7 +466,9 @@ #endif
>  	new_dev->flags = real_dev->flags;
>  	new_dev->flags &= ~IFF_UP;
>  
> -	new_dev->state = real_dev->state & ~(1<<__LINK_STATE_START);
> +	new_dev->state = (real_dev->state & ((1<<__LINK_STATE_NOCARRIER) |
> +					     (1<<__LINK_STATE_DORMANT))) |
> +			 (1<<__LINK_STATE_PRESENT);
>  
>  	/* need 4 bytes for extra VLAN header info,
>  	 * hope the underlying device can handle it.
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0280535..dd0ae1b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -251,11 +251,11 @@ nodata:
>  }
>  
>  
> -static void skb_drop_fraglist(struct sk_buff *skb)
> +static void skb_drop_list(struct sk_buff **listp)
>  {
> -	struct sk_buff *list = skb_shinfo(skb)->frag_list;
> +	struct sk_buff *list = *listp;
>  
> -	skb_shinfo(skb)->frag_list = NULL;
> +	*listp = NULL;
>  
>  	do {
>  		struct sk_buff *this = list;
> @@ -264,6 +264,11 @@ static void skb_drop_fraglist(struct sk_
>  	} while (list);
>  }
>  
> +static inline void skb_drop_fraglist(struct sk_buff *skb)
> +{
> +	skb_drop_list(&skb_shinfo(skb)->frag_list);
> +}
> +
>  static void skb_clone_fraglist(struct sk_buff *skb)
>  {
>  	struct sk_buff *list;
> @@ -802,49 +807,86 @@ struct sk_buff *skb_pad(struct sk_buff *
>  	return nskb;
>  }	
>   
> -/* Trims skb to length len. It can change skb pointers, if "realloc" is 1.
> - * If realloc==0 and trimming is impossible without change of data,
> - * it is BUG().
> +/* Trims skb to length len. It can change skb pointers.
>   */
>  
> -int ___pskb_trim(struct sk_buff *skb, unsigned int len, int realloc)
> +int ___pskb_trim(struct sk_buff *skb, unsigned int len)
>  {
> +	struct sk_buff **fragp;
> +	struct sk_buff *frag;
>  	int offset = skb_headlen(skb);
>  	int nfrags = skb_shinfo(skb)->nr_frags;
>  	int i;
> +	int err;
>  
> -	for (i = 0; i < nfrags; i++) {
> +	if (skb_cloned(skb) &&
> +	    unlikely((err = pskb_expand_head(skb, 0, 0, GFP_ATOMIC))))
> +		return err;
> +
> +	i = 0;
> +	if (offset >= len)
> +		goto drop_pages;
> +
> +	for (; i < nfrags; i++) {
>  		int end = offset + skb_shinfo(skb)->frags[i].size;
> -		if (end > len) {
> -			if (skb_cloned(skb)) {
> -				BUG_ON(!realloc);
> -				if (pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
> -					return -ENOMEM;
> -			}
> -			if (len <= offset) {
> -				put_page(skb_shinfo(skb)->frags[i].page);
> -				skb_shinfo(skb)->nr_frags--;
> -			} else {
> -				skb_shinfo(skb)->frags[i].size = len - offset;
> -			}
> +
> +		if (end < len) {
> +			offset = end;
> +			continue;
>  		}
> -		offset = end;
> +
> +		skb_shinfo(skb)->frags[i++].size = len - offset;
> +
> +drop_pages:
> +		skb_shinfo(skb)->nr_frags = i;
> +
> +		for (; i < nfrags; i++)
> +			put_page(skb_shinfo(skb)->frags[i].page);
> +
> +		if (skb_shinfo(skb)->frag_list)
> +			skb_drop_fraglist(skb);
> +		goto done;
> +	}
> +
> +	for (fragp = &skb_shinfo(skb)->frag_list; (frag = *fragp);
> +	     fragp = &frag->next) {
> +		int end = offset + frag->len;
> +
> +		if (skb_shared(frag)) {
> +			struct sk_buff *nfrag;
> +
> +			nfrag = skb_clone(frag, GFP_ATOMIC);
> +			if (unlikely(!nfrag))
> +				return -ENOMEM;
> +
> +			nfrag->next = frag->next;
> +			kfree_skb(frag);
> +			frag = nfrag;
> +			*fragp = frag;
> +		}
> +
> +		if (end < len) {
> +			offset = end;
> +			continue;
> +		}
> +
> +		if (end > len &&
> +		    unlikely((err = pskb_trim(frag, len - offset))))
> +			return err;
> +
> +		if (frag->next)
> +			skb_drop_list(&frag->next);
> +		break;
>  	}
>  
> -	if (offset < len) {
> +done:
> +	if (len > skb_headlen(skb)) {
>  		skb->data_len -= skb->len - len;
>  		skb->len       = len;
>  	} else {
> -		if (len <= skb_headlen(skb)) {
> -			skb->len      = len;
> -			skb->data_len = 0;
> -			skb->tail     = skb->data + len;
> -			if (skb_shinfo(skb)->frag_list && !skb_cloned(skb))
> -				skb_drop_fraglist(skb);
> -		} else {
> -			skb->data_len -= skb->len - len;
> -			skb->len       = len;
> -		}
> +		skb->len       = len;
> +		skb->data_len  = 0;
> +		skb->tail      = skb->data + len;
>  	}
>  
>  	return 0;
> diff --git a/net/ipv4/netfilter/ip_conntrack_helper_h323.c b/net/ipv4/netfilter/ip_conntrack_helper_h323.c
> index 518f581..853a3d5 100644
> --- a/net/ipv4/netfilter/ip_conntrack_helper_h323.c
> +++ b/net/ipv4/netfilter/ip_conntrack_helper_h323.c
> @@ -1092,7 +1092,7 @@ static struct ip_conntrack_expect *find_
>  	tuple.dst.protonum = IPPROTO_TCP;
>  
>  	exp = __ip_conntrack_expect_find(&tuple);
> -	if (exp->master == ct)
> +	if (exp && exp->master == ct)
>  		return exp;
>  	return NULL;
>  }
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 7026b08..00cb388 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -71,7 +71,12 @@ struct cache_head *sunrpc_cache_lookup(s
>  	new = detail->alloc();
>  	if (!new)
>  		return NULL;
> +	/* must fully initialise 'new', else
> +	 * we might get lose if we need to
> +	 * cache_put it soon.
> +	 */
>  	cache_init(new);
> +	detail->init(new, key);
>  
>  	write_lock(&detail->hash_lock);
>  
> @@ -85,7 +90,6 @@ struct cache_head *sunrpc_cache_lookup(s
>  			return tmp;
>  		}
>  	}
> -	detail->init(new, key);
>  	new->next = *head;
>  	*head = new;
>  	detail->entries++;
> diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
> index ac990bf..785a2ac 100644
> --- a/sound/core/oss/pcm_oss.c
> +++ b/sound/core/oss/pcm_oss.c
> @@ -1745,6 +1745,8 @@ static int snd_pcm_oss_open_file(struct 
>  	for (idx = 0; idx < 2; idx++) {
>  		if (setup[idx].disable)
>  			continue;
> +		if (! pcm->streams[idx].substream_count)
> +			continue; /* no matching substream */
>  		if (idx == SNDRV_PCM_STREAM_PLAYBACK) {
>  			if (! (f_mode & FMODE_WRITE))
>  				continue;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
