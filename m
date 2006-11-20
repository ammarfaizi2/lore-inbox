Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966190AbWKTREs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966190AbWKTREs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966216AbWKTREs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:04:48 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:43929 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966190AbWKTREq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:04:46 -0500
Message-ID: <4561DF7B.7090201@oracle.com>
Date: Mon, 20 Nov 2006 09:01:47 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: lkml <linux-kernel@vger.kernel.org>, rolandd@cisco.com,
       openib-general@openib.org
Subject: Re: infiniband section mismatches
References: <20061119184437.2608912c.randy.dunlap@oracle.com> <adau00uiebt.fsf@cisco.com>
In-Reply-To: <adau00uiebt.fsf@cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> Thanks for reporting this.  I've queued up a couple of patches to fix
> this for 2.6.20 (see below).
> 
>  - R.

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

> diff --git a/drivers/infiniband/hw/mthca/mthca_av.c b/drivers/infiniband/hw/mthca/mthca_av.c
> index 6959945..57cdc1b 100644
> --- a/drivers/infiniband/hw/mthca/mthca_av.c
> +++ b/drivers/infiniband/hw/mthca/mthca_av.c
> @@ -33,7 +33,6 @@
>   * $Id: mthca_av.c 1349 2004-12-16 21:09:43Z roland $
>   */
>  
> -#include <linux/init.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  
> @@ -323,7 +322,7 @@ int mthca_ah_query(struct ib_ah *ibah, s
>  	return 0;
>  }
>  
> -int __devinit mthca_init_av_table(struct mthca_dev *dev)
> +int mthca_init_av_table(struct mthca_dev *dev)
>  {
>  	int err;
>  
> diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
> index 149b369..283d50b 100644
> --- a/drivers/infiniband/hw/mthca/mthca_cq.c
> +++ b/drivers/infiniband/hw/mthca/mthca_cq.c
> @@ -36,7 +36,6 @@
>   * $Id: mthca_cq.c 1369 2004-12-20 16:17:07Z roland $
>   */
>  
> -#include <linux/init.h>
>  #include <linux/hardirq.h>
>  
>  #include <asm/io.h>
> @@ -970,7 +969,7 @@ void mthca_free_cq(struct mthca_dev *dev
>  	mthca_free_mailbox(dev, mailbox);
>  }
>  
> -int __devinit mthca_init_cq_table(struct mthca_dev *dev)
> +int mthca_init_cq_table(struct mthca_dev *dev)
>  {
>  	int err;
>  
> diff --git a/drivers/infiniband/hw/mthca/mthca_eq.c b/drivers/infiniband/hw/mthca/mthca_eq.c
> index e284e06..8ec9fa1 100644
> --- a/drivers/infiniband/hw/mthca/mthca_eq.c
> +++ b/drivers/infiniband/hw/mthca/mthca_eq.c
> @@ -33,7 +33,6 @@
>   * $Id: mthca_eq.c 1382 2004-12-24 02:21:02Z roland $
>   */
>  
> -#include <linux/init.h>
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
>  #include <linux/pci.h>
> @@ -479,10 +478,10 @@ static irqreturn_t mthca_arbel_msi_x_int
>  	return IRQ_HANDLED;
>  }
>  
> -static int __devinit mthca_create_eq(struct mthca_dev *dev,
> -				     int nent,
> -				     u8 intr,
> -				     struct mthca_eq *eq)
> +static int mthca_create_eq(struct mthca_dev *dev,
> +			   int nent,
> +			   u8 intr,
> +			   struct mthca_eq *eq)
>  {
>  	int npages;
>  	u64 *dma_list = NULL;
> @@ -664,9 +663,9 @@ static void mthca_free_irqs(struct mthca
>  				 dev->eq_table.eq + i);
>  }
>  
> -static int __devinit mthca_map_reg(struct mthca_dev *dev,
> -				   unsigned long offset, unsigned long size,
> -				   void __iomem **map)
> +static int mthca_map_reg(struct mthca_dev *dev,
> +			 unsigned long offset, unsigned long size,
> +			 void __iomem **map)
>  {
>  	unsigned long base = pci_resource_start(dev->pdev, 0);
>  
> @@ -691,7 +690,7 @@ static void mthca_unmap_reg(struct mthca
>  	iounmap(map);
>  }
>  
> -static int __devinit mthca_map_eq_regs(struct mthca_dev *dev)
> +static int mthca_map_eq_regs(struct mthca_dev *dev)
>  {
>  	if (mthca_is_memfree(dev)) {
>  		/*
> @@ -781,7 +780,7 @@ static void mthca_unmap_eq_regs(struct m
>  	}
>  }
>  
> -int __devinit mthca_map_eq_icm(struct mthca_dev *dev, u64 icm_virt)
> +int mthca_map_eq_icm(struct mthca_dev *dev, u64 icm_virt)
>  {
>  	int ret;
>  	u8 status;
> @@ -825,7 +824,7 @@ void mthca_unmap_eq_icm(struct mthca_dev
>  	__free_page(dev->eq_table.icm_page);
>  }
>  
> -int __devinit mthca_init_eq_table(struct mthca_dev *dev)
> +int mthca_init_eq_table(struct mthca_dev *dev)
>  {
>  	int err;
>  	u8 status;
> diff --git a/drivers/infiniband/hw/mthca/mthca_mad.c b/drivers/infiniband/hw/mthca/mthca_mad.c
> index 45e106f..acfa41d 100644
> --- a/drivers/infiniband/hw/mthca/mthca_mad.c
> +++ b/drivers/infiniband/hw/mthca/mthca_mad.c
> @@ -317,7 +317,7 @@ err:
>  	return ret;
>  }
>  
> -void __devexit mthca_free_agents(struct mthca_dev *dev)
> +void mthca_free_agents(struct mthca_dev *dev)
>  {
>  	struct ib_mad_agent *agent;
>  	int p, q;
> diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
> index 47ea021..0491ec7 100644
> --- a/drivers/infiniband/hw/mthca/mthca_main.c
> +++ b/drivers/infiniband/hw/mthca/mthca_main.c
> @@ -98,7 +98,7 @@ static struct mthca_profile default_prof
>  	.uarc_size	   = 1 << 18,	/* Arbel only */
>  };
>  
> -static int __devinit mthca_tune_pci(struct mthca_dev *mdev)
> +static int mthca_tune_pci(struct mthca_dev *mdev)
>  {
>  	int cap;
>  	u16 val;
> @@ -143,7 +143,7 @@ static int __devinit mthca_tune_pci(stru
>  	return 0;
>  }
>  
> -static int __devinit mthca_dev_lim(struct mthca_dev *mdev, struct mthca_dev_lim *dev_lim)
> +static int mthca_dev_lim(struct mthca_dev *mdev, struct mthca_dev_lim *dev_lim)
>  {
>  	int err;
>  	u8 status;
> @@ -255,7 +255,7 @@ static int __devinit mthca_dev_lim(struc
>  	return 0;
>  }
>  
> -static int __devinit mthca_init_tavor(struct mthca_dev *mdev)
> +static int mthca_init_tavor(struct mthca_dev *mdev)
>  {
>  	u8 status;
>  	int err;
> @@ -333,7 +333,7 @@ err_disable:
>  	return err;
>  }
>  
> -static int __devinit mthca_load_fw(struct mthca_dev *mdev)
> +static int mthca_load_fw(struct mthca_dev *mdev)
>  {
>  	u8 status;
>  	int err;
> @@ -379,10 +379,10 @@ err_free:
>  	return err;
>  }
>  
> -static int __devinit mthca_init_icm(struct mthca_dev *mdev,
> -				    struct mthca_dev_lim *dev_lim,
> -				    struct mthca_init_hca_param *init_hca,
> -				    u64 icm_size)
> +static int mthca_init_icm(struct mthca_dev *mdev,
> +			  struct mthca_dev_lim *dev_lim,
> +			  struct mthca_init_hca_param *init_hca,
> +			  u64 icm_size)
>  {
>  	u64 aux_pages;
>  	u8 status;
> @@ -575,7 +575,7 @@ static void mthca_free_icms(struct mthca
>  	mthca_free_icm(mdev, mdev->fw.arbel.aux_icm);
>  }
>  
> -static int __devinit mthca_init_arbel(struct mthca_dev *mdev)
> +static int mthca_init_arbel(struct mthca_dev *mdev)
>  {
>  	struct mthca_dev_lim        dev_lim;
>  	struct mthca_profile        profile;
> @@ -683,7 +683,7 @@ static void mthca_close_hca(struct mthca
>  		mthca_SYS_DIS(mdev, &status);
>  }
>  
> -static int __devinit mthca_init_hca(struct mthca_dev *mdev)
> +static int mthca_init_hca(struct mthca_dev *mdev)
>  {
>  	u8 status;
>  	int err;
> @@ -720,7 +720,7 @@ err_close:
>  	return err;
>  }
>  
> -static int __devinit mthca_setup_hca(struct mthca_dev *dev)
> +static int mthca_setup_hca(struct mthca_dev *dev)
>  {
>  	int err;
>  	u8 status;
> @@ -875,8 +875,7 @@ err_uar_table_free:
>  	return err;
>  }
>  
> -static int __devinit mthca_request_regions(struct pci_dev *pdev,
> -					   int ddr_hidden)
> +static int mthca_request_regions(struct pci_dev *pdev, int ddr_hidden)
>  {
>  	int err;
>  
> @@ -928,7 +927,7 @@ static void mthca_release_regions(struct
>  			   MTHCA_HCR_SIZE);
>  }
>  
> -static int __devinit mthca_enable_msi_x(struct mthca_dev *mdev)
> +static int mthca_enable_msi_x(struct mthca_dev *mdev)
>  {
>  	struct msix_entry entries[3];
>  	int err;
> @@ -1213,7 +1212,7 @@ int __mthca_restart_one(struct pci_dev *
>  }
>  
>  static int __devinit mthca_init_one(struct pci_dev *pdev,
> -			     const struct pci_device_id *id)
> +				    const struct pci_device_id *id)
>  {
>  	static int mthca_version_printed = 0;
>  	int ret;
> diff --git a/drivers/infiniband/hw/mthca/mthca_mcg.c b/drivers/infiniband/hw/mthca/mthca_mcg.c
> index 47ca8a9..a8ad072 100644
> --- a/drivers/infiniband/hw/mthca/mthca_mcg.c
> +++ b/drivers/infiniband/hw/mthca/mthca_mcg.c
> @@ -32,7 +32,6 @@
>   * $Id: mthca_mcg.c 1349 2004-12-16 21:09:43Z roland $
>   */
>  
> -#include <linux/init.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  
> @@ -371,7 +370,7 @@ int mthca_multicast_detach(struct ib_qp
>  	return err;
>  }
>  
> -int __devinit mthca_init_mcg_table(struct mthca_dev *dev)
> +int mthca_init_mcg_table(struct mthca_dev *dev)
>  {
>  	int err;
>  	int table_size = dev->limits.num_mgms + dev->limits.num_amgms;
> diff --git a/drivers/infiniband/hw/mthca/mthca_mr.c b/drivers/infiniband/hw/mthca/mthca_mr.c
> index a486dec..f71ffa8 100644
> --- a/drivers/infiniband/hw/mthca/mthca_mr.c
> +++ b/drivers/infiniband/hw/mthca/mthca_mr.c
> @@ -34,7 +34,6 @@
>   */
>  
>  #include <linux/slab.h>
> -#include <linux/init.h>
>  #include <linux/errno.h>
>  
>  #include "mthca_dev.h"
> @@ -135,7 +134,7 @@ static void mthca_buddy_free(struct mthc
>  	spin_unlock(&buddy->lock);
>  }
>  
> -static int __devinit mthca_buddy_init(struct mthca_buddy *buddy, int max_order)
> +static int mthca_buddy_init(struct mthca_buddy *buddy, int max_order)
>  {
>  	int i, s;
>  
> @@ -759,7 +758,7 @@ void mthca_arbel_fmr_unmap(struct mthca_
>  	*(u8 *) fmr->mem.arbel.mpt = MTHCA_MPT_STATUS_SW;
>  }
>  
> -int __devinit mthca_init_mr_table(struct mthca_dev *dev)
> +int mthca_init_mr_table(struct mthca_dev *dev)
>  {
>  	unsigned long addr;
>  	int err, i;
> diff --git a/drivers/infiniband/hw/mthca/mthca_pd.c b/drivers/infiniband/hw/mthca/mthca_pd.c
> index 59df516..c1e9507 100644
> --- a/drivers/infiniband/hw/mthca/mthca_pd.c
> +++ b/drivers/infiniband/hw/mthca/mthca_pd.c
> @@ -34,7 +34,6 @@
>   * $Id: mthca_pd.c 1349 2004-12-16 21:09:43Z roland $
>   */
>  
> -#include <linux/init.h>
>  #include <linux/errno.h>
>  
>  #include "mthca_dev.h"
> @@ -69,7 +68,7 @@ void mthca_pd_free(struct mthca_dev *dev
>  	mthca_free(&dev->pd_table.alloc, pd->pd_num);
>  }
>  
> -int __devinit mthca_init_pd_table(struct mthca_dev *dev)
> +int mthca_init_pd_table(struct mthca_dev *dev)
>  {
>  	return mthca_alloc_init(&dev->pd_table.alloc,
>  				dev->limits.num_pds,
> diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
> index 6a7822e..33e3ba7 100644
> --- a/drivers/infiniband/hw/mthca/mthca_qp.c
> +++ b/drivers/infiniband/hw/mthca/mthca_qp.c
> @@ -35,7 +35,6 @@
>   * $Id: mthca_qp.c 1355 2004-12-17 15:23:43Z roland $
>   */
>  
> -#include <linux/init.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  
> @@ -2241,7 +2240,7 @@ void mthca_free_err_wqe(struct mthca_dev
>  		*new_wqe = 0;
>  }
>  
> -int __devinit mthca_init_qp_table(struct mthca_dev *dev)
> +int mthca_init_qp_table(struct mthca_dev *dev)
>  {
>  	int err;
>  	u8 status;
> diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
> index f5d7677..58fcf5a 100644
> --- a/drivers/infiniband/hw/mthca/mthca_srq.c
> +++ b/drivers/infiniband/hw/mthca/mthca_srq.c
> @@ -715,7 +715,7 @@ int mthca_max_srq_sge(struct mthca_dev *
>  		     sizeof (struct mthca_data_seg));
>  }
>  
> -int __devinit mthca_init_srq_table(struct mthca_dev *dev)
> +int mthca_init_srq_table(struct mthca_dev *dev)
>  {
>  	int err;
>  
> diff --git a/drivers/infiniband/hw/amso1100/c2_rnic.c b/drivers/infiniband/hw/amso1100/c2_rnic.c
> index 623dc95..1687c51 100644
> --- a/drivers/infiniband/hw/amso1100/c2_rnic.c
> +++ b/drivers/infiniband/hw/amso1100/c2_rnic.c
> @@ -441,7 +441,7 @@ static int c2_rnic_close(struct c2_dev *
>   * involves initalizing the various limits and resouce pools that
>   * comprise the RNIC instance.
>   */
> -int c2_rnic_init(struct c2_dev *c2dev)
> +int __devinit c2_rnic_init(struct c2_dev *c2dev)
>  {
>  	int err;
>  	u32 qsize, msgsize;
> @@ -611,7 +611,7 @@ int c2_rnic_init(struct c2_dev *c2dev)
>  /*
>   * Called by c2_remove to cleanup the RNIC resources.
>   */
> -void c2_rnic_term(struct c2_dev *c2dev)
> +void __devexit c2_rnic_term(struct c2_dev *c2dev)
>  {
>  
>  	/* Close the open adapter instance */


-- 
~Randy
