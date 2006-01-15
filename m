Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWAOCBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWAOCBs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 21:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWAOCBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 21:01:48 -0500
Received: from ozlabs.org ([203.10.76.45]:53455 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751621AbWAOCBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 21:01:47 -0500
Date: Sun, 15 Jan 2006 12:59:10 +1100
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, rolandd@cisco.com
Subject: Re: [patch 2.6.15-mm4] sem2mutex: infiniband, #2
Message-ID: <20060115015910.GK26421@krispykreme>
References: <20060114150949.GA24284@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114150949.GA24284@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

Just a small thing, it looks like the script is doing a double include
of linux/mutex.h a few times:

> Index: linux/drivers/infiniband/hw/mthca/mthca_dev.h
> ===================================================================
> --- linux.orig/drivers/infiniband/hw/mthca/mthca_dev.h
> +++ linux/drivers/infiniband/hw/mthca/mthca_dev.h
> @@ -44,7 +44,9 @@
>  #include <linux/pci.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/timer.h>
> -#include <asm/semaphore.h>
> +#include <linux/mutex.h>
> +#include <linux/mutex.h>
> +
>  
>  #include "mthca_provider.h"
>  #include "mthca_doorbell.h"

...

> Index: linux/drivers/infiniband/hw/mthca/mthca_memfree.h
> ===================================================================
> --- linux.orig/drivers/infiniband/hw/mthca/mthca_memfree.h
> +++ linux/drivers/infiniband/hw/mthca/mthca_memfree.h
> @@ -40,7 +40,9 @@
>  #include <linux/list.h>
>  #include <linux/pci.h>
>  
> -#include <asm/semaphore.h>
> +#include <linux/mutex.h>
> +#include <linux/mutex.h>
> +
>  
>  #define MTHCA_ICM_CHUNK_LEN \
>  	((256 - sizeof (struct list_head) - 2 * sizeof (int)) /		\

Anton
