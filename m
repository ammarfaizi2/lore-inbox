Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVHEHWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVHEHWC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 03:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVHEHWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 03:22:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17329 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262896AbVHEHWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 03:22:00 -0400
Date: Fri, 5 Aug 2005 00:17:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: <jamey@crl.dec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] platform-device driver for MQ11xx graphics chip
Message-Id: <20050805001737.7bec8de7.akpm@osdl.org>
In-Reply-To: <20050802192041.C09C5B4262@lspace.crl.dec.com>
References: <20050802192041.C09C5B4262@lspace.crl.dec.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<jamey@crl.dec.com> wrote:
>
> 
> This patch adds platform_device driver for MQ11xx system-on-chip
> graphics chip.  This chip is used in several non-PCI ARM and MIPS
> platforms such as the iPAQ H5550.  Two subsequent patches add
> support for the framebuffer and USB gadget subdevices.  This patch
> adds the toplevel driver to drivers/platform because it does not
> provide any specific functionality (e.g., framebuffer) and it not tied
> to a named physical bus.  In these platforms, the MQ11xx is tied
> directly to the host bus.
> 
> ...
> +
> +static void
> +mq_free (struct mediaq11xx_base *zis, u32 addr, unsigned size)
> +{
> +	int i, j;
> +	u32 eaddr;
> +	struct mq_data *mqdata = to_mq_data (zis);
> +
> +	size = (size + MEMBLOCK_ALIGN - 1) & ~(MEMBLOCK_ALIGN - 1);
> +	eaddr = addr + size;
> +
> +	spin_lock (&mqdata->mem_lock);

It's unusual for a memory allocate/free function to not be IRQ-safe.  Will
there never be a requirement that mq_free() or mq_alloc() be called from
interrupts or softirq's?

> +	spin_unlock (&mqdata->mem_lock);

You've religiously used the wrong coding style throughout these patches:
neither core kernel nor arch/arm places a space before the opening paren. 
A little thing, but easy to get right.

There are eight-spaces where tabs should be in various places too..

