Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVFBWgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVFBWgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVFBWgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:36:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:29122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261442AbVFBWe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:34:56 -0400
Date: Thu, 2 Jun 2005 15:35:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] cpm_uart: Route SCC2 pins for the STx GP3 board
Message-Id: <20050602153540.53486bde.akpm@osdl.org>
In-Reply-To: <20050601105145.B15351@cox.net>
References: <20050601105145.B15351@cox.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter <mporter@kernel.crashing.org> wrote:
>
> +++ uncommitted/drivers/serial/cpm_uart/cpm_uart_cpm2.c  (mode:100644)
> @@ -134,12 +134,21 @@
>  
>  void scc2_lineif(struct uart_cpm_port *pinfo)
>  {
> +	/*
> +	 * STx GP3 uses the SCC2 secondary option pin assignment
> +	 * which this driver doesn't account for in the static
> +	 * pin assignments. This kind of board specific info
> +	 * really has to get out of the driver so boards can
> +	 * be supported in a sane fashion.
> +	 */
> +#ifndef CONFIG_STX_GP3
>  	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
>  	io->iop_pparb |= 0x008b0000;

Silly question: why is this driver using a volatile pointer to
memory-mapped I/O rather than readl and writel?

