Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVBSJEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVBSJEz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 04:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVBSJAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 04:00:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48584 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261666AbVBSIoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 03:44:01 -0500
Message-ID: <4216FC3E.9090000@pobox.com>
Date: Sat, 19 Feb 2005 03:43:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: mikep@linuxtr.net, linux-tr@linuxtr.net, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/tokenring/: make some code static
References: <20050219083800.GP4337@stusta.de>
In-Reply-To: <20050219083800.GP4337@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch makes some needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/net/tokenring/3c359.c           |    2 +-
>  drivers/net/tokenring/3c359_microcode.h |    2 +-
>  drivers/net/tokenring/ibmtr.c           |   24 ++++++++++++------------
>  drivers/net/tokenring/madgemc.c         |    2 +-
>  drivers/net/tokenring/smctr.c           |    2 +-
>  drivers/net/tokenring/smctr_firmware.h  |    2 +-
>  6 files changed, 17 insertions(+), 17 deletions(-)
> 
> --- linux-2.6.11-rc3-mm2-full/drivers/net/tokenring/3c359_microcode.h.old	2005-02-16 18:49:26.000000000 +0100
> +++ linux-2.6.11-rc3-mm2-full/drivers/net/tokenring/3c359_microcode.h	2005-02-16 18:49:32.000000000 +0100
> @@ -22,7 +22,7 @@
>  
>  static int mc_size = 24880 ; 
>  
> -u8 microcode[] = { 
> +static u8 microcode[] = { 
>   0xfe,0x3a,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
>  ,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
>  ,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00

firmware should definitely be 'static const'


> --- linux-2.6.11-rc3-mm2-full/drivers/net/tokenring/3c359.c.old	2005-02-16 18:48:55.000000000 +0100
> +++ linux-2.6.11-rc3-mm2-full/drivers/net/tokenring/3c359.c	2005-02-16 18:49:45.000000000 +0100
> @@ -276,7 +276,7 @@
>  	return ; 
>  }
>   
> -int __devinit xl_probe(struct pci_dev *pdev, const struct pci_device_id *ent) 
> +static int __devinit xl_probe(struct pci_dev *pdev, const struct pci_device_id *ent) 
>  {
>  	struct net_device *dev ; 
>  	struct xl_private *xl_priv ; 
> --- linux-2.6.11-rc3-mm2-full/drivers/net/tokenring/ibmtr.c.old	2005-02-16 18:50:03.000000000 +0100
> +++ linux-2.6.11-rc3-mm2-full/drivers/net/tokenring/ibmtr.c	2005-02-16 18:52:43.000000000 +0100
> @@ -151,7 +151,7 @@
>  
>  /* this allows displaying full adapter information */
>  
> -char *channel_def[] __devinitdata = { "ISA", "MCA", "ISA P&P" };
> +static char *channel_def[] __devinitdata = { "ISA", "MCA", "ISA P&P" };
>  
>  static char pcchannelid[] __devinitdata = {
>  	0x05, 0x00, 0x04, 0x09,
> @@ -171,7 +171,7 @@
>  	0x03, 0x08, 0x02, 0x00
>  };
>  
> -char __devinit *adapter_def(char type)
> +static char __devinit *adapter_def(char type)
>  {
>  	switch (type) {
>  	case 0xF: return "PC Adapter | PC Adapter II | Adapter/A";
> @@ -184,7 +184,7 @@
>  
>  #define TRC_INIT 0x01		/*  Trace initialization & PROBEs */
>  #define TRC_INITV 0x02		/*  verbose init trace points     */
> -unsigned char ibmtr_debug_trace = 0;
> +static unsigned char ibmtr_debug_trace = 0;
>  
>  static int 	ibmtr_probe(struct net_device *dev);
>  static int	ibmtr_probe1(struct net_device *dev, int ioaddr);
> @@ -192,7 +192,7 @@
>  static int 	trdev_init(struct net_device *dev);
>  static int 	tok_open(struct net_device *dev);
>  static int 	tok_init_card(struct net_device *dev);
> -void 		tok_open_adapter(unsigned long dev_addr);
> +static void 	tok_open_adapter(unsigned long dev_addr);
>  static void 	open_sap(unsigned char type, struct net_device *dev);
>  static void 	tok_set_multicast_list(struct net_device *dev);
>  static int 	tok_send_packet(struct sk_buff *skb, struct net_device *dev);
> @@ -201,11 +201,11 @@
>  static void 	initial_tok_int(struct net_device *dev);
>  static void 	tr_tx(struct net_device *dev);
>  static void 	tr_rx(struct net_device *dev);
> -void 		ibmtr_reset_timer(struct timer_list*tmr,struct net_device *dev);
> +static void	ibmtr_reset_timer(struct timer_list*tmr,struct net_device *dev);
>  static void	tok_rerun(unsigned long dev_addr);
> -void 		ibmtr_readlog(struct net_device *dev);
> +static void	ibmtr_readlog(struct net_device *dev);
>  static struct 	net_device_stats *tok_get_stats(struct net_device *dev);
> -int 		ibmtr_change_mtu(struct net_device *dev, int mtu);
> +static int	ibmtr_change_mtu(struct net_device *dev, int mtu);
>  static void	find_turbo_adapters(int *iolist);
>  
>  static int ibmtr_portlist[IBMTR_MAX_ADAPTERS+1] __devinitdata = {
> @@ -933,7 +933,7 @@
>  #define DLC_MAX_SAP_OFST        32
>  #define DLC_MAX_STA_OFST        33
>  
> -void tok_open_adapter(unsigned long dev_addr)
> +static void tok_open_adapter(unsigned long dev_addr)
>  {
>  	struct net_device *dev = (struct net_device *) dev_addr;
>  	struct tok_info *ti;
> @@ -1104,7 +1104,7 @@
>  	return ti->sram_virt + index;
>  }
>  
> -void dir_open_adapter (struct net_device *dev)
> +static void dir_open_adapter (struct net_device *dev)
>  {
>          struct tok_info *ti = (struct tok_info *) dev->priv;
>          unsigned char ret_code;
> @@ -1845,7 +1845,7 @@
>  
>  /*****************************************************************************/
>  
> -void ibmtr_reset_timer(struct timer_list *tmr, struct net_device *dev)
> +static void ibmtr_reset_timer(struct timer_list *tmr, struct net_device *dev)
>  {
>  	tmr->expires = jiffies + TR_RETRY_INTERVAL;
>  	tmr->data = (unsigned long) dev;
> @@ -1877,7 +1877,7 @@
>  
>  /*****************************************************************************/
>  
> -void ibmtr_readlog(struct net_device *dev)
> +static void ibmtr_readlog(struct net_device *dev)
>  {
>  	struct tok_info *ti;
>  
> @@ -1910,7 +1910,7 @@
>  
>  /*****************************************************************************/
>  
> -int ibmtr_change_mtu(struct net_device *dev, int mtu)
> +static int ibmtr_change_mtu(struct net_device *dev, int mtu)
>  {
>  	struct tok_info *ti = (struct tok_info *) dev->priv;
>  
> --- linux-2.6.11-rc3-mm2-full/drivers/net/tokenring/madgemc.c.old	2005-02-16 18:52:55.000000000 +0100
> +++ linux-2.6.11-rc3-mm2-full/drivers/net/tokenring/madgemc.c	2005-02-16 18:53:04.000000000 +0100
> @@ -625,7 +625,7 @@
>  /*
>   * Disable the board, and put back into power-up state.
>   */
> -void madgemc_chipset_close(struct net_device *dev)
> +static void madgemc_chipset_close(struct net_device *dev)
>  {
>  	/* disable interrupts */
>  	madgemc_setint(dev, 0);
> --- linux-2.6.11-rc3-mm2-full/drivers/net/tokenring/smctr_firmware.h.old	2005-02-16 18:53:18.000000000 +0100
> +++ linux-2.6.11-rc3-mm2-full/drivers/net/tokenring/smctr_firmware.h	2005-02-16 18:53:31.000000000 +0100
> @@ -21,7 +21,7 @@
>  
>  #if defined(CONFIG_SMCTR) || defined(CONFIG_SMCTR_MODULE)
>  
> -unsigned char smctr_code[] = {
> +static unsigned char smctr_code[] = {
>  	0x0BC, 0x01D, 0x012, 0x03B, 0x063, 0x0B4, 0x0E9, 0x000,
>  	0x000, 0x01F, 0x000, 0x001, 0x001, 0x000, 0x002, 0x005,
>  	0x001, 0x000, 0x006, 0x003, 0x001, 0x000, 0x004, 0x009,

ditto


> --- linux-2.6.11-rc3-mm2-full/drivers/net/tokenring/smctr.c.old	2005-02-16 18:54:13.000000000 +0100
> +++ linux-2.6.11-rc3-mm2-full/drivers/net/tokenring/smctr.c	2005-02-16 18:54:20.000000000 +0100
> @@ -77,7 +77,7 @@
>  
>  /* SMC Name of the Adapter. */
>  static char smctr_name[] = "SMC TokenCard";
> -char *smctr_model = "Unknown";
> +static char *smctr_model = "Unknown";
>  
>  /* Use 0 for production, 1 for verification, 2 for debug, and
>   * 3 for very verbose debug.
> 
> 

