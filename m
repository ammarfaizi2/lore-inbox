Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWGaRrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWGaRrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWGaRrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:47:36 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:6667 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030289AbWGaRrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:47:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 31 Jul 2006 17:46:34.0122 (UTC) FILETIME=[438A96A0:01C6B4C9]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] x86_64 built-in command line
Date: Mon, 31 Jul 2006 13:46:27 -0400
Message-ID: <Pine.LNX.4.61.0607311342410.24292@chaos.analogic.com>
In-Reply-To: <20060731171442.GI6908@waste.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64 built-in command line
Thread-Index: Aca0yUOUD0aanLwPSOaCC/WSx1b8rw==
References: <20060731171442.GI6908@waste.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Matt Mackall" <mpm@selenic.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, <ak@suse.de>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2006, Matt Mackall wrote:

> Allow setting a command line at build time on x86_64. Compiled but not
> tested.
>
> Signed-off-by: Matt Mackall <mpm@selenic.com>
>
> Index: linux/arch/x86_64/Kconfig
> ===================================================================
> --- linux.orig/arch/x86_64/Kconfig	2006-07-26 18:08:29.000000000 -0500
> +++ linux/arch/x86_64/Kconfig	2006-07-27 17:19:50.000000000 -0500
> @@ -558,6 +558,20 @@ config K8_NB
> 	def_bool y
> 	depends on AGP_AMD64 || IOMMU || (PCI && NUMA)
>
> +config CMDLINE_BOOL
> +	bool "Default bootloader kernel arguments" if EMBEDDED
> +
> +config CMDLINE
> +	string "Initial kernel command string" if EMBEDDED
> +	depends on CMDLINE_BOOL
> +	default "root=/dev/hda1 ro"
> +	help
> +	  On some systems, there is no way for the boot loader to pass
> +	  arguments to the kernel. For these platforms, you can supply
> +	  some command-line options at build time by entering them
> +	  here. In most cases you will need to specify the root device
> +	  here.
> +
> endmenu
>
> #
> Index: linux/arch/x86_64/kernel/setup.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/setup.c	2006-07-26 18:08:29.000000000 -0500
> +++ linux/arch/x86_64/kernel/setup.c	2006-07-27 17:26:51.000000000 -0500
> @@ -289,6 +289,10 @@ static __init void parse_cmdline_early (
> 	int len = 0;
> 	int userdef = 0;
>
> +#ifdef CONFIG_CMDLINE_BOOL
> +	strlcpy(saved_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +#endif
> +
> 	for (;;) {
> 		if (c != ' ')
> 			goto next_char;
>
> --
> Mathematics is the supreme nostalgia of our time.
> -

But this just makes it nice for __your__ embedded system. I suggest you
use:
> +	default "root=/dev/root ro"

The boot setup code makes a symlink to whatever your specific
setup requires.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
