Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbSKTImq>; Wed, 20 Nov 2002 03:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbSKTImq>; Wed, 20 Nov 2002 03:42:46 -0500
Received: from Xenon.Stanford.EDU ([171.64.66.201]:11497 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S265909AbSKTImg>; Wed, 20 Nov 2002 03:42:36 -0500
Date: Wed, 20 Nov 2002 00:49:34 -0800
From: Andy Chou <acc@CS.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Cc: mc@cs.stanford.edu
Subject: [CHECKER] 16 more potential buffer overruns in 2.5.48
Message-ID: <20021120084934.GA24014@Xenon.stanford.edu>
Reply-To: acc@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 16 more potential buffer overruns from 2.5.48, which are
different from those I already sent out for 2.5.33.  Again, these were
found statically, and confirmation that any of these are bugs would be
appreciated.

-Andy Chou


# BUGs	|	File Name
4	|	/fs/cifs/smbdes.c
4	|       /drivers/pnp/pnpbios/core.c
2	|	/drivers/isdn/hardware/eicon/os_4bri.c
2	|	/sound/pci/cs4281.c
1	|	/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
1	|	/drivers/isdn/eicon/eicon_mod.c
1	|	/drivers/net/3c515.c
1	|	/net/ipv4/arp.c

---------------------------------------------------------
[BUG] Hw imposed bound?
/u1/acc/linux/2.5.48/drivers/net/3c515.c:553:corkscrew_scan: 
ERROR:BUFFER:553:553:Array bounds error: options[8] indexed with [8]
		printk(KERN_INFO "3c515 Resource configuration register 
%#4.4x, DCR %4.4x.\n",
		     inl(ioaddr + 0x2002), inw(ioaddr + 0x2000));
		irq = inw(ioaddr + 0x2002) & 15;
		corkscrew_found_device(dev, ioaddr, irq, CORKSCREW_ID, dev
				       && dev->mem_start ? dev->

Error --->
				       mem_start : options[cards_found]);
		dev = 0;
		cards_found++;
	}
---------------------------------------------------------
[BUG] Typo, condition should be  i < number_of(saved_regs)
/u1/acc/linux/2.5.48/sound/pci/cs4281.c:2157:cs4281_resume: 
ERROR:BUFFER:2157:2157:Array bounds error: saved_regs[20] indexed with 
[20]

	snd_cs4281_chip_init(chip, 0);

	/* restore the status registers */
	for (i = 0; number_of(saved_regs); i++)

Error --->
		if (saved_regs[i])
			snd_cs4281_pokeBA0(chip, saved_regs[i], 
chip->suspend_regs[i]);

	if (chip->ac97)
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1330:pnpbios_disable_resources: 
ERROR:BUFFER:1330:1330:Array bounds error: config->port[8] indexed with 
[8]
		return -1;
	memset(config, 0, sizeof(struct pnp_cfg));
	if (!dev || !dev->active)
		return -EINVAL;
	for (i=0; i <= 8; i++)

Error --->
		config->port[i] = &port;
	for (i=0; i <= 4; i++)
		config->mem[i] = &mem;
	for (i=0; i <= 2; i++)
---------------------------------------------------------
[BUG] ind could be as large as 515
/u1/acc/linux/2.5.48/fs/cifs/smbdes.c:410:SamOEMhash: 
ERROR:BUFFER:410:410:Array bounds error: s_box[256] indexed with [256]

		index_i++;
		index_j += s_box[index_i];

		tc = s_box[index_i];

Error --->
		s_box[index_i] = s_box[index_j];
		s_box[index_j] = tc;

		t = s_box[index_i] + s_box[index_j];
---------------------------------------------------------
[BUG] Similar to another.
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1332:pnpbios_disable_resources: 
ERROR:BUFFER:1332:1332:Array bounds error: config->mem[4] indexed with [4]
	if (!dev || !dev->active)
		return -EINVAL;
	for (i=0; i <= 8; i++)
		config->port[i] = &port;
	for (i=0; i <= 4; i++)

Error --->
		config->mem[i] = &mem;
	for (i=0; i <= 2; i++)
		config->irq[i] = &irq;
	for (i=0; i <= 2; i++)
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/arch/i386/kernel/cpu/cpufreq/powernow-k6.c:202:powernow_k6_setpolicy: 
ERROR:BUFFER:202:202:Array bounds error: clock_ratio[8] indexed with [8]
		break;
	default:
		return;
	}


Error --->
	if (clock_ratio[i] > max_multiplier)
		BUG();

	powernow_k6_set_state(j);
---------------------------------------------------------
[BUG] Not sure.
/u1/acc/linux/2.5.48/net/ipv4/arp.c:1313:arp_format_neigh_entry: 
ERROR:BUFFER:1313:1313:Array bounds error: hbuffer[30] indexed with [-1]
	for (k = 0, j = 0; k < HBUFFERLEN - 3 && j < dev->addr_len; j++) {
		hbuffer[k++] = hexbuf[(n->ha[j] >> 4) & 15];
		hbuffer[k++] = hexbuf[n->ha[j] & 15];
		hbuffer[k++] = ':';
	}

Error --->
	hbuffer[--k] = 0;
#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
	}
#endif
---------------------------------------------------------
[BUG] Typo, condition should be  i < number_of(saved_regs)
/u1/acc/linux/2.5.48/sound/pci/cs4281.c:2114:cs4281_suspend: 
ERROR:BUFFER:2114:2114:Array bounds error: chip->suspend_regs[20] indexed 
with [21]
	snd_cs4281_pokeBA0(chip, BA0_HICR, BA0_HICR_CHGM);

	/* remember the status registers */
	for (i = 0; number_of(saved_regs); i++)
		if (saved_regs[i])

Error --->
			chip->suspend_regs[i] = snd_cs4281_peekBA0(chip, 
saved_regs[i]);

	/* Turn off the serial ports. */
	snd_cs4281_pokeBA0(chip, BA0_SERMC, 0);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/fs/cifs/smbdes.c:413:SamOEMhash: 
ERROR:BUFFER:413:413:Array bounds error: s_box[256] indexed with [256]

		tc = s_box[index_i];
		s_box[index_i] = s_box[index_j];
		s_box[index_j] = tc;


Error --->
		t = s_box[index_i] + s_box[index_j];
		data[ind] = data[ind] ^ s_box[t];
	}
}
---------------------------------------------------------
[BUG] Same.
/u1/acc/linux/2.5.48/fs/cifs/smbdes.c:407:SamOEMhash: 
ERROR:BUFFER:407:407:Array bounds error: s_box[256] indexed with [256]
	for (ind = 0; ind < (val ? 516 : 16); ind++) {
		unsigned char tc;
		unsigned char t;

		index_i++;

Error --->
		index_j += s_box[index_i];

		tc = s_box[index_i];
		s_box[index_i] = s_box[index_j];
---------------------------------------------------------
[BUG] Copy and paste
/u1/acc/linux/2.5.48/fs/cifs/smbdes.c:409:SamOEMhash: 
ERROR:BUFFER:409:409:Array bounds error: s_box[256] indexed with [256]
		unsigned char t;

		index_i++;
		index_j += s_box[index_i];


Error --->
		tc = s_box[index_i];
		s_box[index_i] = s_box[index_j];
		s_box[index_j] = tc;

---------------------------------------------------------
[BUG] same.
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1334:pnpbios_disable_resources: 
ERROR:BUFFER:1334:1334:Array bounds error: config->irq[2] indexed with [2]
	for (i=0; i <= 8; i++)
		config->port[i] = &port;
	for (i=0; i <= 4; i++)
		config->mem[i] = &mem;
	for (i=0; i <= 2; i++)

Error --->
		config->irq[i] = &irq;
	for (i=0; i <= 2; i++)
		config->dma[i] = &dma;
	dev->active = 0;
---------------------------------------------------------
[BUG] bar assigned to 4 at end of previous loop.
/u1/acc/linux/2.5.48/drivers/isdn/hardware/eicon/os_4bri.c:268:diva_4bri_init_card: 
ERROR:BUFFER:268:268:Array bounds error: a->slave_adapters[3] indexed with 
[4]
	 */
	quadro_list =
	    (PADAPTER_LIST_ENTRY) diva_os_malloc(0, sizeof(*quadro_list));
	if (!(a->slave_list = quadro_list)) {
		for (i = 0; i < (tasks - 1); i++) {

Error --->
			diva_os_free(0, a->slave_adapters[bar]);
			a->slave_adapters[bar] = 0;
		}
		diva_4bri_cleanup_adapter(a);
---------------------------------------------------------
[BUG] same.
/u1/acc/linux/2.5.48/drivers/isdn/hardware/eicon/os_4bri.c:269:diva_4bri_init_card: 
ERROR:BUFFER:269:269:Array bounds error: a->slave_adapters[3] indexed with 
[4]
	quadro_list =
	    (PADAPTER_LIST_ENTRY) diva_os_malloc(0, sizeof(*quadro_list));
	if (!(a->slave_list = quadro_list)) {
		for (i = 0; i < (tasks - 1); i++) {
			diva_os_free(0, a->slave_adapters[bar]);

Error --->
			a->slave_adapters[bar] = 0;
		}
		diva_4bri_cleanup_adapter(a);
		return (-1);
---------------------------------------------------------
[BUG] Bad bounds test?
/u1/acc/linux/2.5.48/drivers/isdn/eicon/eicon_mod.c:439:eicon_command: 
ERROR:BUFFER:439:439:Array bounds error: idi_d[32] indexed with [-4]
								if (!(card 
= eicon_findnpcicard(dstart.card_id - i)))
									
return -EINVAL;
	
								
card->flags |= EICON_FLAGS_LOADED;
								
card->flags |= EICON_FLAGS_RUNNING;

Error --->
								card->d = 
&idi_d[idi_length - (i+1)];
								
eicon_pci_init_conf(card);
								if 
(card->d->channels > 1) {
									
cmd.command = ISDN_STAT_ADDCH;
---------------------------------------------------------
[BUG] Same
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1336:pnpbios_disable_resources: 
ERROR:BUFFER:1336:1336:Array bounds error: config->dma[2] indexed with [2]
	for (i=0; i <= 4; i++)
		config->mem[i] = &mem;
	for (i=0; i <= 2; i++)
		config->irq[i] = &irq;
	for (i=0; i <= 2; i++)

Error --->
		config->dma[i] = &dma;
	dev->active = 0;

	if (pnp_bios_dev_node_info(&node_info) != 0)


