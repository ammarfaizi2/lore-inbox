Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWIUQGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWIUQGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 12:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWIUQGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 12:06:47 -0400
Received: from xenotime.net ([66.160.160.81]:27568 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750788AbWIUQGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 12:06:46 -0400
Date: Thu, 21 Sep 2006 09:07:49 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: Aubrey <aubreylee@gmail.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 2/4] Blackfin: Serial driver for Blackfin arch on 2.6.18
Message-Id: <20060921090749.ce8a3a01.rdunlap@xenotime.net>
In-Reply-To: <489ecd0c0609210257tb8daf0fl7603ff96e6e21c2e@mail.gmail.com>
References: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
	<1158830784.11109.93.camel@localhost.localdomain>
	<6d6a94c50609210223o5adf9bb5w7bfb70fb59094c85@mail.gmail.com>
	<489ecd0c0609210257tb8daf0fl7603ff96e6e21c2e@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 17:57:03 +0800 Luke Yang wrote:

> Great thanks. Here is the new patch:
> 
>  drivers/serial/Kconfig      |   44 ++
>  drivers/serial/Makefile     |    1
>  drivers/serial/bfin_5xx.c   |  906 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/serial_core.h |    3
>  4 files changed, 954 insertions(+)
> 

> +#ifdef CONFIG_SERIAL_BFIN_DMA
> +static void bfin_serial_dma_tx_chars(struct bfin_serial_port *uart)
> +{
> +	struct circ_buf *xmit = &uart->port.info->xmit;
> +	unsigned short ier;
> +	int flags = 0;
> +
> +	if (!uart->tx_done)
> +		return;
> +
> +	uart->tx_done = 0;
> +
> +	if (uart->port.x_char) {
> +		UART_PUT_CHAR(uart, uart->port.x_char);
> +		uart->port.icount.tx++;
> +		uart->port.x_char = 0;
> +		uart->tx_done = 1;
> +		return;
> +	}
> +	/*
> +	 * Check the modem control lines before
> +	 * transmitting anything.
> +	 */
> +	bfin_serial_mctrl_check(uart);
> +
> +	if (uart_circ_empty(xmit) || uart_tx_stopped(&uart->port)) {
> +		bfin_serial_stop_tx(&uart->port);
> +		uart->tx_done = 1;
> +		return;
> +	}
> +
> +	local_irq_save(flags);
> +	uart->tx_count = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	if (uart->tx_count > (UART_XMIT_SIZE - xmit->tail))
> +	uart->tx_count = UART_XMIT_SIZE - xmit->tail;

The line above still needs to be indented one more tab stop.
Otherwise looks OK to me.

---
~Randy
