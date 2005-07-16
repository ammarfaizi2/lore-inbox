Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVGPIkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVGPIkU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 04:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVGPIjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 04:39:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4109 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261260AbVGPIjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 04:39:03 -0400
Date: Sat, 16 Jul 2005 09:38:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: Serial core: 8250_pci could not register serial port for  UART chip EXAR XR17D152
Message-ID: <20050716093858.A19067@flint.arm.linux.org.uk>
Mail-Followup-To: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>,
	linux-kernel@vger.kernel.org, gregkh@suse.de
References: <1121359649.15007.18.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1121359649.15007.18.camel@siliver.austin.ibm.com>; from mansarov@us.ibm.com on Thu, Jul 14, 2005 at 11:47:29AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 11:47:29AM -0500, V. ANANDA KRISHNAN wrote:
>   I have been coming across a problem with my serial port EXAR chip XR
> 17D152, when I try to use the 8250_pci driver.  I am using
> kernel-2.6.12.1 on RHEL4.0-U1 on pSeries box with 4-cpu.  8250_pci
> during the boot time, after detecting the exar chip (I checked with the
> pci_dev structure and the pci_device_id structure for the info), is
> unable to get thru the port registration (static int
> __devinit_pciserial_init_one(struct pci_dev *dev, const struct
> pci_device_id *ent) procedure in 8250_pci.c).  I debugged the problem
> and traced upto the routine "static int uart_match_port(struct uart_port
> *port1, struct uart_port *port2" in 8250.c where UPIO_MEM is not
> satisfying the condition port1->membase==port2->membase and hence
> returns 0.

That's the intended result.  uart_match_port() only returns true when
the types of the two ports match, and the base address of the two ports
also match.

Please try mainline 2.6 kernels.  Also, please include the kernel entire
messages when reporting bugs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
