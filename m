Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVEaW1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVEaW1Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 18:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVEaW0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 18:26:15 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:61421 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261173AbVEaWZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 18:25:50 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jim Ramsay <jim.ramsay@gmail.com>
Subject: Re: Bug in 8520.c - port.type not set for serial console
Date: Tue, 31 May 2005 16:25:46 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <4789af9e05053015385667923@mail.gmail.com>
In-Reply-To: <4789af9e05053015385667923@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505311625.46084.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 May 2005 4:38 pm, Jim Ramsay wrote:
> I am attempting to get the 8520.c driver's serial console working with
> a 16550A UART implementation, and have run into what I consider to be
> a bug:  In short, the proper 'port.type' for this serial port is not
> set until the module init (serial8250_init) is called, so the FCR is
> set incorrectly during serial8250_console_init for any port type which
> is different than UNKNOWN.
> 
> The exact problem is that the FCR is being set to '0x0' for a port
> type of 'UNKNOWN', when for my specific 16550A, it should be set to
> '0xC1' - and this makes my screen fill with empty characters instead
> of the printk output I need.

Shouldn't a 16550A UART work correctly with FCR==0x0, i.e., with FIFOs
disabled?  Is your UART broken?

Serial console output is always polled, one character at a time, so
you shouldn't need FIFOs until later.
