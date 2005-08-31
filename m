Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVHaJeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVHaJeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 05:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVHaJeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 05:34:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37647 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750726AbVHaJeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 05:34:06 -0400
Date: Wed, 31 Aug 2005 10:33:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
       ralf@linux-mips.org, starvik@axis.com
Subject: [FINAL WARNING] Removal of deprecated serial functions - please update your drivers NOW
Message-ID: <20050831103352.A26480@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	amax@us.ibm.com, ralf@linux-mips.org, starvik@axis.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per the feature-removal.txt file, I will be removing the following
functions shortly:

	* register_serial
	* unregister_serial
	* uart_register_port
	* uart_unregister_port

However, there are still some drivers which use these functions:

drivers/char/mwave/mwavedd.c:   return register_serial(&serial);
drivers/char/mwave/mwavedd.c:           unregister_serial(pDrvData->sLine);
drivers/misc/ibmasm/uart.c:     sp->serial_line = register_serial(&serial);
drivers/misc/ibmasm/uart.c:     unregister_serial(sp->serial_line);
drivers/net/ioc3-eth.c: register_serial(&req);
drivers/net/ioc3-eth.c: register_serial(&req);
drivers/serial/serial_txx9.c:   line = uart_register_port(&serial_txx9_reg, &port);
drivers/serial/serial_txx9.c:           uart_unregister_port(&serial_txx9_reg, line);

These drivers really really really need fixing in the next few days
if they aren't going to break.  I hereby ask that the maintainers of
the above drivers show some willingness to update their drivers.

Unfortunately, it appears that some of these drivers do not contain
email addresses for their maintainers, neither are they listed in
the MAINTAINERS file.  (mwavedd and serial_txx9).

Please note that this is the last warning folk will have before the
functions are removed.


In addition, the following drivers declare functions of the same name.
The maintainers of these need to look to see why, and eliminate them
where possible.

drivers/serial/crisv10.c:register_serial(struct serial_struct *req)
drivers/serial/crisv10.c:void unregister_serial(int line)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
