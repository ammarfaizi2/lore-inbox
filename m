Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265938AbUGIVvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265938AbUGIVvj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUGIVv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:51:28 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:10742 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S265920AbUGIVvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:51:06 -0400
Date: Fri, 9 Jul 2004 18:24:56 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Message-ID: <20040709182456.A20309@mail.kroptech.com>
References: <40EEF10F.1030404@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40EEF10F.1030404@am.sony.com>; from tim.bird@am.sony.com on Fri, Jul 09, 2004 at 12:25:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 12:25:03PM -0700, Tim Bird wrote:
> Finally, this code adds a new FASTBOOT menu to the kernel
> config system, where we (CE Linux Forum developers) would like
> to add this and other config options which can be used to
> reduce kernel bootup time.

<snip>

> +menuconfig FASTBOOT
> +	bool "Fast boot options"
> +	help
> +	  Say Y here to enable faster booting of the Linux kernel.  If you
> +	  say Y here, you may be asked to provide hardcoded values for some
> +	  parameters that the kernel usually determines automatically.

If FASTBOOT is intended to be merely a container for individual related
options, this help text seems misleading. FASTBOOT=y alone will have no
effect on the kernel. It's just a gateway to other more specific
options. Something like this may be better:

	Say Y here to select among various options that can decrease
	kernel boot time. These options commonly involve providing
	hardcoded values for some parameters that the kernel usually
	determines automatically.

	This option is useful primarily on embedded systems.

	If unsure, say N.

> +config PRESET_LPJ
> +	int "Preset loops_per_jiffy" if USE_PRESET_LPJ
> +	help
> +	  This is the number of loops used by delay() to achieve a single
> +	  jiffy of delay inside the kernel.  It is roughly BogoMips * 5000.
> +	  To determine the correct value for your kernel, first turn off
> +	  the fast booting option, compile and boot the kernel on your
> +	  target hardware, then see what value is printed during the
> +	  kernel boot.  Use that value here.

Perhaps mention the new lpj= parameter is an alternative:

	loops_per_jiffy can also be set via the "lpj=" kernel command
	line parameter.

--Adam

