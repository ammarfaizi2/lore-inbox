Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWFSSsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWFSSsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWFSSrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:47:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16142 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964836AbWFSSrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:47:19 -0400
Date: Mon, 19 Jun 2006 19:47:06 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
Message-ID: <20060619184706.GH3479@flint.arm.linux.org.uk>
Mail-Followup-To: Chris Rankin <rankincj@yahoo.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20060619180658.58945.qmail@web52908.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619180658.58945.qmail@web52908.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 07:06:58PM +0100, Chris Rankin wrote:
> I have just booted Linux 2.6.17 on an old 350 MHz PII, and have
> discovered this message in the boot log:
> 
> setup_irq: irq handler mismatch
>  <c0131a86> setup_irq+0x10d/0x11a  <c01f3889> serial8250_interrupt+0x0/0x107
>  <c0131b00> request_irq+0x6d/0x89  <c01f34ba> serial8250_startup+0x2d6/0x42b
>  <c01f01e1> uart_startup+0x64/0x121  <c01f0401> uart_open+0x163/0x3a2
>  <c01e214f> tty_open+0x175/0x2bc  <c0152fb1> chrdev_open+0x160/0x17c
>  <c0152e51> chrdev_open+0x0/0x17c  <c014b093> __dentry_open+0xe0/0x1cf
>  <c014b1e6> nameidata_to_filp+0x19/0x28  <c014b220> do_filp_open+0x2b/0x31
>  <c014b30c> do_sys_open+0x3c/0xa9  <c014b3a6> sys_open+0x16/0x18
>  <c0102adb> syscall_call+0x7/0xb 

This seems to be an invalid situation - you appear to have an _ISA_
NE2000 card using IRQ3, trying to share the same interrupt as a
serial port.

ISA interrupts aren't sharable without additional hardware support
or specific software support in the Linux kernel interrupt
architecture.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
