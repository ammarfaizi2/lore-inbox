Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVGMRJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVGMRJX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVGMRGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:06:53 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:13188 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261293AbVGMREr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:04:47 -0400
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1121116677.28557.104.camel@tdi>
References: <42CA96FC.9000708@arcom.com>
	 <20050706195740.A28758@flint.arm.linux.org.uk> <42CD2C16.1070308@arcom.com>
	 <1121108408.28557.71.camel@tdi>
	 <20050711204646.D1540@flint.arm.linux.org.uk>
	 <1121112057.28557.91.camel@tdi>
	 <20050711211706.E1540@flint.arm.linux.org.uk>
	 <1121116677.28557.104.camel@tdi>
Content-Type: text/plain
Organization: LOSL
Date: Wed, 13 Jul 2005 11:04:56 -0600
Message-Id: <1121274296.4334.58.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 15:17 -0600, Alex Williamson wrote:

>    No, I think this is a problem with the broken A2 UARTs getting
> confused in serial8250_set_sleep().  If I remove either UART_CAP_SLEEP
> or UART_CAP_EFR from the capabilities list for this UART, it behaves
> normally.  Also, just commenting out the UART_CAP_EFR chunks of
> set_sleep make it behave.  I'll ping Exar for more data.  Thanks,

Hi Russell,

   I don't know enough about the extended UART programming model, but I
notice that when UART_CAP_EFR and UART_CAP_SLEEP are set on a UART, we
set the UART_IERX_SLEEP bit in the UART_IER immediately after it's found
and configured.  It's from this point until we hit userspace and clear
that bit that output from the UART is garbled.  Are UARTs supposed to
output data with sleep mode enabled?  Are there known working configs
where a UART w/ EFR and SLEEP are able to be used as a serial console?
This system with the A2 rev ST16C2550 part that's not working is the
only one I have with a console UART w/ these capabilities.  Just trying
to make sure that there's not a latent bug that we enable a bad sleep
mode when the UART is being used for the console.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

