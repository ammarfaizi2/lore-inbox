Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVC3PCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVC3PCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVC3PCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:02:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57613 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262010AbVC3PB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:01:57 -0500
Date: Wed, 30 Mar 2005 16:01:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ patch 3/5] drivers/serial/jsm: new serial device driver
Message-ID: <20050330160144.B13781@flint.arm.linux.org.uk>
Mail-Followup-To: Wen Xiong <wendyx@us.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20050308235807.GA11807@kroah.com> <422F1A8A.4000106@us.ltcfwd.linux.ibm.com> <20050309163518.GC25079@kroah.com> <422F2FDD.4050908@us.ltcfwd.linux.ibm.com> <20050309185800.GA27268@kroah.com> <4231BB5D.8020400@us.ltcfwd.linux.ibm.com> <1110556428.9917.31.camel@laptopd505.fenrus.org> <4231C9B2.5020202@us.ltcfwd.linux.ibm.com> <1110559614.9917.43.camel@laptopd505.fenrus.org> <42321CEA.2000405@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42321CEA.2000405@us.ltcfwd.linux.ibm.com>; from wendyx@us.ibm.com on Fri, Mar 11, 2005 at 05:34:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 05:34:18PM -0500, Wen Xiong wrote:
> diff -Nuar linux-2.6.11.org/drivers/serial/jsm/jsm_neo.c linux-2.6.11.new/drivers/serial/jsm/jsm_neo.c
> --- linux-2.6.11.org/drivers/serial/jsm/jsm_neo.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.11.new/drivers/serial/jsm/jsm_neo.c	2005-03-11 16:26:47.442988256 -0600
> +/*
> + * neo_param()
> + * Send any/all changes to the line to the UART.
> + */
> +static void neo_param(struct jsm_channel *ch)
> +{
> +	u8 lcr = 0;
> +	u8 uart_lcr = 0;
> +	u8 ier = 0;
> +	u32 baud = 9600;
> +	int quot = 0;
> +	struct jsm_board *bd;
> +
> +	bd = ch->ch_bd;
> +	if (!bd)
> +		return;
> +
> +	/*
> +	 * If baud rate is zero, flush queues, and set mval to drop DTR.
> +	 */

The modem signal side of this is already handled for you.

> +			const u64 bauds[4][16] = {
> +				{ 
> +					0,	50,	75,	110,
> +					134,	150,	200,	300,
> +					600,	1200,	1800,	2400,
> +					4800,	9600,	19200,	38400 },
> +				{ 
> +					0,	57600,	115200, 230400,
> +					460800, 150,	200,	921600,
> +					600,	1200,	1800,	2400,
> +					4800,	9600,	19200,	38400 },
> +				{ 
> +					0,	57600,	76800, 115200,
> +					131657, 153600, 230400, 460800,
> +					921600, 1200,	1800,	2400,
> +					4800,	9600,	19200,	38400 },
> +				{ 
> +					0,	57600,	115200, 230400,
> +					460800, 150,	200,	921600,
> +					600,	1200,	1800,	2400,
> +					4800,	9600,	19200,	38400 }
> +			};
> +
> +			baud = C_BAUD(ch->uart_port.info->tty) & 0xff;
> +
> +			if (ch->ch_c_cflag & CBAUDEX)
> +				iindex = 1;

This is buggy.  You're making invalid assumptions about the
given baud rate flags in the termios.  Use the helper functions
provided please.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
