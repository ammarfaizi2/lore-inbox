Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWAVHhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWAVHhR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 02:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWAVHhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 02:37:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15594 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751226AbWAVHhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 02:37:16 -0500
Date: Sat, 21 Jan 2006 23:36:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org
Subject: Re: [PATCH] serial: serial_txx9 driver update
Message-Id: <20060121233649.51211403.akpm@osdl.org>
In-Reply-To: <20060118.021901.71085469.anemo@mba.ocn.ne.jp>
References: <20060118.021901.71085469.anemo@mba.ocn.ne.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
>  serial_txx9_verify_port(struct uart_port *port, struct serial_struct *ser)
>   {
>  -	if (ser->irq < 0 ||
>  -	    ser->baud_base < 9600 || ser->type != PORT_TXX9)
>  +	unsigned long new_port = (unsigned long)ser->port +
>  +		((unsigned long)ser->port_high << ((sizeof(long) - sizeof(int)) * 8));

Are you sure about this part?  Shifting something left by sizeof(something)
seems very strange.  It'll give different results on 64-bit machines for
the same hardware.  Are you sure it wasn't supposed to be an addition?

If this was indeed intended then can you please explain why?

If it was supposed to be an addition, wouldn't this be more clearly
expressed by defining a suitable structure and using sizeof(that structure)
to work out the address range?
