Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWBRPJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWBRPJh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 10:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWBRPJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 10:09:37 -0500
Received: from verein.lst.de ([213.95.11.210]:39651 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750938AbWBRPJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 10:09:36 -0500
Date: Sat, 18 Feb 2006 16:09:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Subject: Re: [openib-general] [PATCH 08/22] Generic ehca headers
Message-ID: <20060218150920.GA23817@lst.de>
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005723.13620.10389.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218005723.13620.10389.stgit@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:57:23PM -0800, Roland Dreier wrote:
> From: Roland Dreier <rolandd@cisco.com>
> 
> The defines of TRUE and FALSE look rather useless.  Why are they needed?
> 
> What is struct ehca_cache for?  It doesn't seem to be used anywhere.
> 
> ehca_kv_to_g() looks completely horrible.  The whole idea of using
> vmalloc()ed kernel memory to do DMA seems unacceptable to me.

When you want to do scatter-gather dma on kernel-virtual contingous
areas allocate the pages individually and map them into kva using
vmap().  Then dma can be performed using dma_map_page, or in case
you have lots of pages dma_map_sg after creating an S/G list.

