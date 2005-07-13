Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVGMSIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVGMSIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVGMSFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:05:14 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:7854 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261318AbVGMSDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:03:32 -0400
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1121274296.4334.58.camel@tdi>
References: <42CA96FC.9000708@arcom.com>
	 <20050706195740.A28758@flint.arm.linux.org.uk> <42CD2C16.1070308@arcom.com>
	 <1121108408.28557.71.camel@tdi>
	 <20050711204646.D1540@flint.arm.linux.org.uk>
	 <1121112057.28557.91.camel@tdi>
	 <20050711211706.E1540@flint.arm.linux.org.uk>
	 <1121116677.28557.104.camel@tdi>  <1121274296.4334.58.camel@tdi>
Content-Type: text/plain
Organization: LOSL
Date: Wed, 13 Jul 2005 12:03:49 -0600
Message-Id: <1121277829.4334.76.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 11:04 -0600, Alex Williamson wrote:
> Just trying to make sure that there's not a latent bug that we enable
> a bad sleep mode when the UART is being used for the console.

   Yes, this is the problem.  When a UART is specified as the console
using "console=uart,...", the console index is not initialized.  This
causes the uart_console() check to mis-identify the port and we enable
sleep mode when we don't intend to do so.  Not sure how to fix it yet,
but I assume we need to go back through after the serial ports are
enumerated, and un-suspend the console port.  David, would you mind
trying this on the XR16L255x part? (ie. don't use console=ttyS, use
console=uart,...)  Thanks,

	Alex
-- 
Alex Williamson                             HP Linux & Open Source Lab

