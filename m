Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbULYN3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbULYN3T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 08:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbULYN3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 08:29:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:50071 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261427AbULYN3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 08:29:15 -0500
Subject: Re: A general question on SMP-safe driver code.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Nelson <james4765@verizon.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41CC9F2A.9080905@verizon.net>
References: <41CC9F2A.9080905@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103977401.22646.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 25 Dec 2004 12:23:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-24 at 22:58, Jim Nelson wrote:
> Looking at a few older drivers, I'm trying to figure out the best ways to handle 
> some locking.  Using drivers/char/esp.c as an example (since it's the one I'm 
> trying to grok right now), here is one example:

> ;
> 	serial_out(info, UART_ESI_CMD1, ESI_GET_TX_AVAIL);
> 	spin_unlock_irq(&info->esp_lock);
> 
> 	while ((serial_in(info, UART_ESI_STAT1) != 0x03) ||
> 		(serial_in(info, UART_ESI_STAT2) != 0xff)) {

You need to guard these as well in the locks. It might actually look a
lot cleaner to have functions esp_send_command(info, a, b) and the like
which do the locking internally ?

