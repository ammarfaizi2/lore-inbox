Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbUJYX55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbUJYX55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 19:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbUJYXzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 19:55:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:37589 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261943AbUJYWWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 18:22:50 -0400
Subject: Re: ia64 failure with [PATCH] 8250: Let arch provide the list of
	leagacy ports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1098742146.2144.200.camel@mulgrave>
References: <1098742146.2144.200.camel@mulgrave>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 08:20:04 +1000
Message-Id: <1098742804.6719.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 18:08 -0400, James Bottomley wrote:
> ia64 seems to rely on empty ports being registered.  Without this, ia64
> crashes on boot with
> 
> Removing wrong port: 0000000000000000 != a000000100781bd8

I send this patch to Linus already, though he may have missed it, I'll
resend.

Ben.

> James
> 
> ===== drivers/serial/8250.c 1.76 vs edited =====
> --- 1.76/drivers/serial/8250.c	2004-10-22 18:31:26 -05:00
> +++ edited/drivers/serial/8250.c	2004-10-25 16:59:22 -05:00
> @@ -2001,13 +2001,6 @@
>  	for (i = 0; i < UART_NR; i++) {
>  		struct uart_8250_port *up = &serial8250_ports[i];
>  
> -		/* Don't register "empty" ports, setting "ops" on them
> -		 * makes the console driver "setup" routine to succeed,
> -		 * which is wrong. --BenH.
> -		 */
> -		if (!up->port.iobase)
> -			continue;
> -
>  		up->port.line = i;
>  		up->port.ops = &serial8250_pops;
>  		up->port.dev = dev;
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

