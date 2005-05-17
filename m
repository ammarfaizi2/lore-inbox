Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVEQAg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVEQAg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 20:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVEQAg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 20:36:28 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:38101 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261332AbVEQAgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 20:36:23 -0400
Date: Mon, 16 May 2005 20:35:25 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/pnp/: possible cleanups
Message-ID: <20050517003525.GB11189@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	perex@suse.cz, linux-kernel@vger.kernel.org
References: <20050517000853.GN5112@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517000853.GN5112@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 02:08:53AM +0200, Adrian Bunk wrote:

Hi Adrian,

I'll apply this patch if you comment out or use "#if 0" on the exported
symbols.  Also do not remove isapnp_read_byte or pnp_auto_config_dev because
they are part of the device driver API.  I would like you to only target the
protocol API.  I'll have the time to seriously work on features like modular
isapnp in about a week.

Thanks,
Adam


> 
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - #if 0 the following unused global function:
>   - core.c: pnp_remove_device
> - remove the following unneeded EXPORT_SYMBOL's:
>   - card.c: pnp_add_card
>   - card.c: pnp_remove_card
>   - card.c: pnp_add_card_device
>   - card.c: pnp_remove_card_device
>   - card.c: pnp_add_card_id
>   - core.c: pnp_register_protocol
>   - core.c: pnp_unregister_protocol
>   - core.c: pnp_add_device
>   - core.c: pnp_remove_device
>   - pnpacpi/core.c: pnpacpi_protocol
>   - driver.c: pnp_add_id
>   - isapnp/core.c: isapnp_read_byte
>   - manager.c: pnp_auto_config_dev
>   - resource.c: pnp_register_dependent_option
>   - resource.c: pnp_register_independent_option
>   - resource.c: pnp_register_irq_resource
>   - resource.c: pnp_register_dma_resource
>   - resource.c: pnp_register_port_resource
>   - resource.c: pnp_register_mem_resource
> 
> Note that this patch #if 0's exactly one functions and removes no
> functions. Most it does is the removal of EXPORT_SYMBOL's, so if any
> modular code will use any of them, re-adding will be trivial.
> 
> Modular ISAPnP might be interesting in some cases, but this is more
> legacy code. If someone would work on it to sort all the issues out
> (starting with the point that most users of __ISAPNP__ will have to be
> fixed) re-adding the required EXPORT_SYMBOL's won't be hard for him.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
