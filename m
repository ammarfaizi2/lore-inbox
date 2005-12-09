Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVLIPZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVLIPZh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVLIPZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:25:37 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:25690 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932356AbVLIPZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:25:34 -0500
Date: Fri, 9 Dec 2005 16:25:31 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051209152530.GE15372@harddisk-recovery.com>
References: <20051209140559.GA23868@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209140559.GA23868@suse.de>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 03:05:59PM +0100, Olaf Hering wrote:
> a POWER4 system in 'full-system-partition' mode has the console device
> on ttyS0. But the user interface to the Linux system console may still
> be on the hardware management console (HMC). If this is the case, there
> is no way to send a break to trigger a sysrq.
> Other setups do already use 'ctrl o' to trigger sysrq. This includes iSeries
> virtual console on tty1, and pSeries LPAR console on hvc0 or hvsi0.

So it's a POWER4 problem.

> 'ctrl o' is currently mapped to 'flush output', see 'stty -a'

Eww... If you can't use a serial break, why can't you use an
established control character like ctrl-] (telnet) or [enter]~ (ssh) ?

If you really want to use ctrl-o, could you make a way that pressing
ctrl-o twice sends a single ctrl-o to the process attached to the
console?

> Signed-off-by: Olaf Hering <olh@suse.de>
> 
>  drivers/serial/8250.c |    7 +++++++
>  1 files changed, 7 insertions(+)
> 
> Index: linux-2.6.15-rc5-olh/drivers/serial/8250.c
> ===================================================================
> --- linux-2.6.15-rc5-olh.orig/drivers/serial/8250.c
> +++ linux-2.6.15-rc5-olh/drivers/serial/8250.c
> @@ -1154,6 +1154,13 @@ receive_chars(struct uart_8250_port *up,
>  			 */
>  		}
>  		ch = serial_inp(up, UART_RX);
> +
> +#if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_SERIAL_CORE_CONSOLE)

If it is a POWER4-only problem, why isn't there a dependency on
CONFIG_POWER4 over here? I don't like to have the ctrl-o sysrq stuff
enabled on my regular PC if it only matters to some rare (in absolute
numbers) system.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
