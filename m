Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWIZJ17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWIZJ17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 05:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWIZJ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 05:27:59 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:10979 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750906AbWIZJ17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 05:27:59 -0400
Date: Tue, 26 Sep 2006 11:27:57 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] at91_serial: Introduction
Message-ID: <20060926112757.03dd8cbc@cad-250-152.norway.atmel.com>
In-Reply-To: <1159261584.24659.16.camel@fuzzie.sanpeople.com>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
	<20060923211417.GB4363@flint.arm.linux.org.uk>
	<1159261584.24659.16.camel@fuzzie.sanpeople.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Sep 2006 11:06:24 +0200
Andrew Victor <andrew@sanpeople.com> wrote:

> For patch 1, I'm not to keen on the:
> 
>   +#ifdef CONFIG_AVR32
>   +       port->flags |= UPF_IOREMAP;
>   +       port->membase = ioremap(pdev->resource[0].start,
>   +                               pdev->resource[0].end
>   +                               - pdev->resource[0].start + 1);
>   +#else
> 
> part.  It might be better to pass a flag (in the platform_data
> structure) whether we are providing a virtual or a physical address.
> (If you want early init on the serial console, then I recommend just
> using a static mapping for the DBGU peripheral).

I sent a new patch in the same thread with this instead:

+#ifdef CONFIG_AVR32
+	port->flags |= UPF_IOREMAP;
+	port->membase = NULL;
+#else

This means that the console will be initialized a bit late, but I can
live with that for now. Maybe we can agree on a platform_data format so
that we can remove the #ifdef altogether?

> Patch 2 & 3 look correct, but they would need to be tested.

Yeah, I'm struggling a bit with SPI right now, but I'll se if I can get
my AT91 board up and running after that.

I'll resend the first patch when the AVR32 patches are in, and the
last two after I've tested them on AT91.

Haavard
