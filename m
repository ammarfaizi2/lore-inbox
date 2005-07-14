Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVGNQxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVGNQxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVGNQxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:53:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:9191 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261563AbVGNQxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:53:42 -0400
Subject: Serial core: 8250_pci could not register serial port for  UART
	chip EXAR XR17D152
From: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, rmk@arm.linux.org.uk
Content-Type: text/plain
Date: Thu, 14 Jul 2005 11:47:29 -0500
Message-Id: <1121359649.15007.18.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  I have been coming across a problem with my serial port EXAR chip XR
17D152, when I try to use the 8250_pci driver.  I am using
kernel-2.6.12.1 on RHEL4.0-U1 on pSeries box with 4-cpu.  8250_pci
during the boot time, after detecting the exar chip (I checked with the
pci_dev structure and the pci_device_id structure for the info), is
unable to get thru the port registration (static int
__devinit_pciserial_init_one(struct pci_dev *dev, const struct
pci_device_id *ent) procedure in 8250_pci.c).  I debugged the problem
and traced upto the routine "static int uart_match_port(struct uart_port
*port1, struct uart_port *port2" in 8250.c where UPIO_MEM is not
satisfying the condition port1->membase==port2->membase and hence
returns 0.

  If I use the printk for dumping the port-> membase value the system
hags during the boot time with a blank screen (on the serial terminal).
I am yet to try with kernel-2.6.12.2.  Please let me know how to proceed
in this case.  Thanks,
V.Ananda Krishnan

