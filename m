Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWBRMTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWBRMTO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBRMTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:19:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20145 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751155AbWBRMTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:19:14 -0500
Date: Sat, 18 Feb 2006 12:19:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Subject: Re: [PATCH 02/22] Firmware interface code for IB device.
Message-ID: <20060218121913.GD911@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@ozlabs.org, openib-general@openib.org,
	SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
	MEDER@de.ibm.com
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005707.13620.20538.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218005707.13620.20538.stgit@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:57:07PM -0800, Roland Dreier wrote:
> From: Roland Dreier <rolandd@cisco.com>
> 
> This is a very large file with way too much code for a .h file.
> The functions look too big to be inlined also.  Is there any way
> for this code to move to a .c file?
> ---
> 
>  drivers/infiniband/hw/ehca/hcp_if.h | 2022 +++++++++++++++++++++++++++++++++++

> +#include "ehca_tools.h"
> +#include "hipz_structs.h"
> +#include "ehca_classes.h"
> +
> +#ifndef EHCA_USE_HCALL
> +#include "hcz_queue.h"
> +#include "hcz_mrmw.h"
> +#include "hcz_emmio.h"
> +#include "sim_prom.h"
> +#endif
> +#include "hipz_fns.h"
> +#include "hcp_sense.h"
> +#include "ehca_irq.h"
> +
> +#ifndef CONFIG_PPC64
> +#ifndef Z_SERIES
> +#warning "included with wrong target, this is a p file"
> +#endif
> +#endif
> +
> +#ifdef EHCA_USE_HCALL
> +
> +#ifndef EHCA_USERDRIVER
> +#include "hcp_phyp.h"
> +#else
> +#include "testbench/hcallbridge.h"
> +#endif
> +#endif

the ifdefs should all go away and the build system should make sure it's
only built for the right platforms.

