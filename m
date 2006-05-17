Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWEQXI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWEQXI3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 19:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWEQXI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 19:08:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:31437 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751142AbWEQXI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 19:08:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Brice Goglin <brice@myri.com>
Subject: Re: [PATCH 3/4] myri10ge - Driver core
Date: Thu, 18 May 2006 01:08:32 +0200
User-Agent: KMail/1.9.1
Cc: netdev@vger.kernel.org, gallatin@myri.com, linux-kernel@vger.kernel.org
References: <20060517220218.GA13411@myri.com> <20060517220608.GD13411@myri.com>
In-Reply-To: <20060517220608.GD13411@myri.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605180108.32949.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thursday 18 May 2006 00:06 schrieb Brice Goglin:

> +static char *myri10ge_fw_name = NULL;
> +static char *myri10ge_fw_unaligned = "myri10ge_ethp_z8e.dat";
> +static char *myri10ge_fw_aligned = "myri10ge_eth_z8e.dat";
> +static int myri10ge_ecrc_enable = 1;
> +static int myri10ge_max_intr_slots = 1024;
> +static int myri10ge_small_bytes = -1;	/* -1 == auto */
> +static int myri10ge_msi = 1;	/* enable msi by default */
> +static int myri10ge_intr_coal_delay = 25;
> +static int myri10ge_flow_control = 1;
> +static int myri10ge_deassert_wait = 1;
> +static int myri10ge_force_firmware = 0;
> +static int myri10ge_skb_cross_4k = 0;
> +static int myri10ge_initial_mtu = MYRI10GE_MAX_ETHER_MTU - ETH_HLEN;
> +static int myri10ge_napi_weight = 64;
> +static int myri10ge_watchdog_timeout = 1;
> +static int myri10ge_max_irq_loops = 1048576;
> +
> +module_param(myri10ge_fw_name, charp, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(myri10ge_fw_name, "Firmware image name\n");
> +module_param(myri10ge_max_intr_slots, int, S_IRUGO);
> +MODULE_PARM_DESC(myri10ge_max_intr_slots, "Interrupt queue slots\n");
> +module_param(myri10ge_small_bytes, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(myri10ge_small_bytes, "Threshold of small packets\n");
> +module_param(myri10ge_msi, int, S_IRUGO);
> +MODULE_PARM_DESC(myri10ge_msi, "Enable Message Signalled Interrupts\n");
> +module_param(myri10ge_intr_coal_delay, int, S_IRUGO);
> +MODULE_PARM_DESC(myri10ge_intr_coal_delay, "Interrupt coalescing
> delay\n"); +module_param(myri10ge_ecrc_enable, int, S_IRUGO);
> +MODULE_PARM_DESC(myri10ge_ecrc_enable, "Enable Extended CRC on PCI-E\n");
> +module_param(myri10ge_flow_control, int, S_IRUGO);
> +MODULE_PARM_DESC(myri10ge_flow_control, "Pause parameter\n");
> +module_param(myri10ge_deassert_wait, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(myri10ge_deassert_wait,
> +		 "Wait when deasserting legacy interrupts\n");
> +module_param(myri10ge_force_firmware, int, S_IRUGO);
> +MODULE_PARM_DESC(myri10ge_force_firmware,
> +		 "Force firmware to assume aligned completions\n");
> +module_param(myri10ge_skb_cross_4k, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(myri10ge_skb_cross_4k,
> +		 "Can a small skb cross a 4KB boundary?\n");
> +module_param(myri10ge_initial_mtu, int, S_IRUGO);
> +MODULE_PARM_DESC(myri10ge_initial_mtu, "Initial MTU\n");
> +module_param(myri10ge_napi_weight, int, S_IRUGO);
> +MODULE_PARM_DESC(myri10ge_napi_weight, "Set NAPI weight\n");
> +module_param(myri10ge_watchdog_timeout, int, S_IRUGO);
> +MODULE_PARM_DESC(myri10ge_watchdog_timeout, "Set watchdog timeout\n");
> +module_param(myri10ge_max_irq_loops, int, S_IRUGO);
> +MODULE_PARM_DESC(myri10ge_max_irq_loops,
> +		 "Set stuck legacy IRQ detection threshold\n");

How about writing the module_param() and MODULE_PARM_DESC() calls
directly after each declaration? That would make it clearer
that they are all parameters.

> +	response->result = 0xffffffff;

0xffffffff appears throughout your code as a return value. maybe
use a named constant for it?

> +	for (sleep_total = 0;
> +	     sleep_total < (15 * 1000) && response->result == 0xffffffff;
> +	     sleep_total += 10) {
> +		udelay(10);
> +	}

udelay does not sleep. If you want to sleep, use msleep instead.

> +
> +	myri10ge_pio_copy((void __iomem *)submit, &buf, sizeof(buf));
> +	for (i = 0; *confirm != 0xffffffff && i < 20; i++)
> +		udelay(1000);
> +	if (*confirm != 0xffffffff) {
> +		dev_err(&mgp->pdev->dev, "dummy rdma %s failed\n",
> +			(enable ? "enable" : "disable"));
> +	}
> +}

Can you use msleep here instead of udelay?

> +static int myri10ge_load_firmware(struct myri10ge_priv *mgp)
> +{
> +	volatile u32 *confirm;
> +	volatile char __iomem *submit;

The __iomem variable need not be volatile.

> +	myri10ge_pio_copy((void __iomem *)submit, &buf, sizeof(buf));
> +	mb();
> +	udelay(1000);
> +	mb();

can't you use msleep(1) instead? 

> +static inline void
> +myri10ge_submit_8rx(struct mcp_kreq_ether_recv __iomem * dst,
> +		    struct mcp_kreq_ether_recv *src)
> +{
> +	u32 low;
> +
> +	low = src->addr_low;
> +	src->addr_low = DMA_32BIT_MASK;
> +	myri10ge_pio_copy(dst, src, 8 * sizeof(*src));
> +	mb();
> +	src->addr_low = low;
> +	*(u32 __force *) & dst->addr_low = src->addr_low;
> +	mb();
> +}

The __force dereference seems fishy.

> +	if (unlikely(((end >> 12) != (data >> 12)) && (data & 4095UL))) {
> +		printk
> +		    ("myri10ge_alloc_small: small skb crossed 4KB boundary\n");

Printk level is missing.


> +static int myri10ge_open(struct net_device *dev)

This function is too long to read easily.

> +	/* allocate the host shadow rings */
> +
> +	bytes = 8 + (MYRI10GE_MCP_ETHER_MAX_SEND_DESC_TSO + 4)
> +	    * sizeof(*mgp->tx.req_list);
> +	mgp->tx.req_bytes = kmalloc(bytes, GFP_KERNEL);
> +	if (mgp->tx.req_bytes == NULL)
> +		goto abort_with_nothing;
> +	memset(mgp->tx.req_bytes, 0, bytes);
> +
> +	/* ensure req_list entries are aligned to 8 bytes */
> +	mgp->tx.req_list = (struct mcp_kreq_ether_send *)
> +	    ALIGN((unsigned long)mgp->tx.req_bytes, 8);
> +
> +	bytes = rx_ring_entries * sizeof(*mgp->rx_small.shadow);
> +	mgp->rx_small.shadow = kmalloc(bytes, GFP_KERNEL);
> +	if (mgp->rx_small.shadow == NULL)
> +		goto abort_with_tx_req_bytes;
> +	memset(mgp->rx_small.shadow, 0, bytes);
> +
> +	bytes = rx_ring_entries * sizeof(*mgp->rx_big.shadow);
> +	mgp->rx_big.shadow = kmalloc(bytes, GFP_KERNEL);
> +	if (mgp->rx_big.shadow == NULL)
> +		goto abort_with_rx_small_shadow;
> +	memset(mgp->rx_big.shadow, 0, bytes);
> +
> +	/* allocate the host info rings */
> +
> +	bytes = tx_ring_entries * sizeof(*mgp->tx.info);
> +	mgp->tx.info = kmalloc(bytes, GFP_KERNEL);
> +	if (mgp->tx.info == NULL)
> +		goto abort_with_rx_big_shadow;
> +	memset(mgp->tx.info, 0, bytes);
> +
> +	bytes = rx_ring_entries * sizeof(*mgp->rx_small.info);
> +	mgp->rx_small.info = kmalloc(bytes, GFP_KERNEL);
> +	if (mgp->rx_small.info == NULL)
> +		goto abort_with_tx_info;
> +	memset(mgp->rx_small.info, 0, bytes);
> +
> +	bytes = rx_ring_entries * sizeof(*mgp->rx_big.info);
> +	mgp->rx_big.info = kmalloc(bytes, GFP_KERNEL);
> +	if (mgp->rx_big.info == NULL)
> +		goto abort_with_rx_small_info;
> +	memset(mgp->rx_big.info, 0, bytes);
> +

Can you do all these allocations at once? Maybe you can even
move them into the size passed to alloc_etherdev.

If you need separate allocations, using kzalloc simplifies
your code.

> +	/* re-write the last 32-bits with the valid flags */
> +	src->flags = last_flags;
> +	src_ints = (u32 *) src;
> +	src_ints += 3;
> +	dst_ints = (u32 __iomem *) dst;
> +	dst_ints += 3;
> +	*(u32 __force *) dst_ints = *src_ints;
> +	tx->req += cnt;
> +	mb();
> +}

All these casts indicate that you do something wrong here.
In particular, dereferencing an __iomem pointer should
not be done in a device driver.

> +		/* Break the SKB or Fragment up into pieces which
> +		 * do not cross mgp->tx.boundary */
> +		low = MYRI10GE_LOWPART_TO_U32(bus);
> +		high_swapped = htonl(MYRI10GE_HIGHPART_TO_U32(bus));
> +		while (len) {
> +			u8 flags_next;
> +			int cum_len_next;
> +
> +			if (unlikely(count == max_segments))
> +				goto abort_linearize;
> +
> +			boundary = (low + tx->boundary) & ~(tx->boundary - 1);
> +			seglen = boundary - low;
> +			if (seglen > len)
> +				seglen = len;
> +			flags_next = flags & ~MYRI10GE_MCP_ETHER_FLAGS_FIRST;
> +			cum_len_next = cum_len + seglen;
> +#ifdef NETIF_F_TSO
> +			if (mss) {	/* TSO */
> +				(req - rdma_count)->rdma_count = rdma_count + 1;
> +
> +				if (likely(cum_len >= 0)) {	/* payload */
> +					int next_is_first, chop;
> +
> +					chop = (cum_len_next > mss);
> +					cum_len_next = cum_len_next % mss;
> +					next_is_first = (cum_len_next == 0);
> +					flags |= chop *
> +					    MYRI10GE_MCP_ETHER_FLAGS_TSO_CHOP;
> +					flags_next |= next_is_first *
> +					    MYRI10GE_MCP_ETHER_FLAGS_FIRST;
> +					rdma_count |= -(chop | next_is_first);
> +					rdma_count += chop & !next_is_first;
> +				} else if (likely(cum_len_next >= 0)) {	/* header ends */
> +					int small;
> +
> +					rdma_count = -1;
> +					cum_len_next = 0;
> +					seglen = -cum_len;
> +					small =
> +					    (mss <=
> +					     MYRI10GE_MCP_ETHER_SEND_SMALL_SIZE);
> +					flags_next =
> +					    MYRI10GE_MCP_ETHER_FLAGS_TSO_PLD |
> +					    MYRI10GE_MCP_ETHER_FLAGS_FIRST |
> +					    (small *
> +					     MYRI10GE_MCP_ETHER_FLAGS_SMALL);
> +				}
> +			}

100 characters per line are too much, as are six levels of intentation,
or the number of lines in this function.
You should try to split into into smaller ones.

>
> +	if ((new_mtu < 68) || (ETH_HLEN + new_mtu > MYRI10GE_MAX_ETHER_MTU)) {
> +		printk(KERN_ERR "myri10ge: %s: new mtu (%d) is not valid\n",
> +		       dev->name, new_mtu);
> +		return -EINVAL;
> +	}
> +	printk("%s: changing mtu from %d to %d\n",
> +	       dev->name, dev->mtu, new_mtu);

You shouldn't use printk as a basic feedback mechanism to user space.
The return code already contains the information.
Also the printk misses a message level.

> +	pci_set_power_state(pdev, 0);	/* zeros conf space as a side effect */
> +	udelay(5000);		/* give card time to respond */
> +	pci_read_config_word(mgp->pdev, PCI_VENDOR_ID, &vendor);

5000 is a long time for udelay. If you can't convert this to msleep,
use at least mdelay.

> +		printk(KERN_ERR "myri10ge: %s: device timeout, resetting\n",
> +		       mgp->dev->name);
> +		printk("myri10ge: %s: %d %d %d %d %d\n", mgp->dev->name,
> +		       mgp->tx.req, mgp->tx.done, mgp->tx.pkt_start,
> +		       mgp->tx.pkt_done,
> +		       (int)ntohl(mgp->fw_stats->send_done_count));
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		schedule_timeout(HZ * 2);
> +		set_current_state(TASK_RUNNING);
> +		printk("myri10ge: %s: %d %d %d %d %d\n", mgp->dev->name,
> +		       mgp->tx.req, mgp->tx.done, mgp->tx.pkt_start,
> +		       mgp->tx.pkt_done,
> +		       (int)ntohl(mgp->fw_stats->send_done_count));

missing printk levels here.

instead of schedule_timeout, you probably want to use msleep().

> +	if (status != 0) {
> +		printk(KERN_ERR "myri10ge: %s: failed to load firmware\n",
> +		       mgp->dev->name);

dev_err?

> +	for (i = 0; i < ETH_ALEN; i++) {
> +		netdev->dev_addr[i] = mgp->mac_addr[i];
> +	}

Don't need the curly braces here.

> +
> +	printk("myri10ge: %s: %s IRQ %d, tx bndry %d, fw %s, WC %s\n",
> +	       netdev->name, (mgp->msi_enabled ? "MSI" : "xPIC"),
> +	       pdev->irq, mgp->tx.boundary, mgp->fw_name,
> +	       (mgp->mtrr >= 0 ? "Enabled" : "Disabled"));
> +

missing printk level (KERN_DEBUG?). Could probably use dev_printk.

> +      abort_with_irq:
> +	free_irq(pdev->irq, mgp);
> +	if (mgp->msi_enabled)
> +		pci_disable_msi(pdev);
> +
> +      abort_with_firmware:
> +	myri10ge_dummy_rdma(mgp, 0);
> +
> +      abort_with_rx_done:
> +	bytes = myri10ge_max_intr_slots * sizeof(*mgp->rx_done.entry);
> +	pci_free_consistent(pdev, bytes, mgp->rx_done.entry, mgp->rx_done.bus);
> +
> +      abort_with_ioremap:
> +	iounmap((void __iomem *)mgp->sram);
> +
> +      abort_with_wc:
> +#ifdef CONFIG_MTRR
> +	if (mgp->mtrr >= 0)
> +		mtrr_del(mgp->mtrr, mgp->iomem_base, mgp->board_span);
> +#endif
> +	pci_free_consistent(pdev, sizeof(*mgp->fw_stats),
> +			    mgp->fw_stats, mgp->fw_stats_bus);
> +
> +      abort_with_cmd:
> +	pci_free_consistent(pdev, sizeof(*mgp->cmd), mgp->cmd, mgp->cmd_bus);
> +
> +      abort_with_netdev:
> +
> +	free_netdev(netdev);
> +	return status;
> +}

Goto labels are conventionally indented all the way
to the left. Yes, lindent/indent gets this wrong.

> +	iounmap((void __iomem *)mgp->sram);

unnecessary cast.

> +
> +#define MYRI10GE_PCI_VENDOR_MYRICOM 	0x14c1
> +#define MYRI10GE_PCI_DEVICE_Z8E 	0x0008

Shouldn't the vendor ID go to pci_ids.h?

> +
> +static __init int myri10ge_init_module(void)
> +{
> +	printk("%s: Version %s\n", myri10ge_driver.name, MYRI10GE_VERSION_STR);
> +	return pci_register_driver(&myri10ge_driver);
> +}
> +
> +static __exit void myri10ge_cleanup_module(void)
> +{
> +	pci_unregister_driver(&myri10ge_driver);
> +}
> +
> +module_init(myri10ge_init_module);

This line should go right under the function it refers to.

	Arnd <><
