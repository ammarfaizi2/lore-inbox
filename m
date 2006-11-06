Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753192AbWKFPAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbWKFPAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 10:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbWKFPAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 10:00:13 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:11725 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1753192AbWKFPAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 10:00:11 -0500
Date: Mon, 6 Nov 2006 15:58:39 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, raisch@de.ibm.com
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control block in 64k page mode
Message-ID: <20061106145839.GA9387@osiris.boeblingen.de.ibm.com>
References: <200611052140.38445.hnguyen@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611052140.38445.hnguyen@de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_PPC_64K_PAGES
> +void *ehca_alloc_fw_ctrlblock(void);
> +void ehca_free_fw_ctrlblock(void *ptr);
> +#else
> +#define ehca_alloc_fw_ctrlblock() get_zeroed_page(GFP_KERNEL)
> +#define ehca_free_fw_ctrlblock(ptr) free_page((unsigned long)(ptr))
> +#endif

Maybe you want to make sure that ehca_alloc_fw_ctrlblock() always returns a
void pointer, so you can avoid all the casts in your code?

static inline void *ehca_alloc_fw_ctrlblock(void)
{
	return (void *)get_zeroed_page(GFP_KERNEL);
}
