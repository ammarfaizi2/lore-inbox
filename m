Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVCSRVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVCSRVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 12:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVCSRVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 12:21:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64267 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262641AbVCSRVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 12:21:06 -0500
Date: Sat, 19 Mar 2005 17:21:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: takata@linux-m32r.org, akpm@osdl.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Bitrotting serial drivers
Message-ID: <20050319172101.C23907@flint.arm.linux.org.uk>
Mail-Followup-To: takata@linux-m32r.org, akpm@osdl.org,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

m32r_sio
--------

Maintainer: Hirokazu Takata

Please clean up the m32r_sio driver, removing whatever bits of code
aren't absolutely necessary.

Specifically, I'd like to see the following addressed:

- the usage of SERIAL_IO_HUB6
  (this driver doesn't support hub6 cards)
- SERIAL_IO_* should be UPIO_*
- __register_m32r_sio, register_m32r_sio, unregister_m32r_sio,
  m32r_sio_get_irq_map
  (this driver doesn't support PCMCIA cards, all of which are based on
   8250-compatible devices.)
- early_serial_setup
  (should we really have the function name duplicated across different
   hardware drivers?)

au1x00_uart
-----------

Maintainer: unknown (akpm - any ideas?)

This is a complete clone of 8250.c, which includes all the 8250-specific
structure names.

Specifically, I'd like to see the following addressed:

- Please clean this up to use au1x00-specific names.
- this driver is lagging behind with fixes that the other drivers are
  getting.  Is au1x00_uart actually maintained?
- the usage of UPIO_HUB6
  (this driver doesn't support hub6 cards)
- __register_serial, register_serial, unregister_serial
  (this driver doesn't support PCMCIA cards, all of which are based on
   8250-compatible devices.)
- early_serial_setup
  (should we really have the function name duplicated across different
   hardware drivers?)

The main reason is I wish to kill off uart_register_port and
uart_unregister_port, but these drivers are using it.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
