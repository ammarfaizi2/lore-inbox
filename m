Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVCOBEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVCOBEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 20:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVCOBEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 20:04:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62470 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262169AbVCOBEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 20:04:00 -0500
Date: Tue, 15 Mar 2005 02:03:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, pfg@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc4 fix for sn_serial.c
Message-ID: <20050315010358.GF3207@stusta.de>
References: <200503141132.39284.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503141132.39284.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 11:32:39AM -0800, Jesse Barnes wrote:
> The sal_console and sal_console_uart structures have a circular relationship 
> since they both initialize member fields to pointers of one another.  The 
> current code forward declares sal_console_uart as extern so that sal_console 
> can take its address, but gcc4 complains about this since the real definition 
> of sal_console_uart is marked 'static'.  This patch just removes the static 
> qualifier from sal_console_uart to avoid the inconsistency.  Does it look ok 
> to you, Pat?
>...
> ===== drivers/serial/sn_console.c 1.12 vs edited =====
> --- 1.12/drivers/serial/sn_console.c	2005-03-07 20:41:31 -08:00
> +++ edited/drivers/serial/sn_console.c	2005-03-14 10:57:19 -08:00
> @@ -801,7 +801,7 @@
>  
>  #define SAL_CONSOLE	&sal_console
>  
> -static struct uart_driver sal_console_uart = {
> +struct uart_driver sal_console_uart = {
>  	.owner = THIS_MODULE,
>  	.driver_name = "sn_console",
>  	.dev_name = DEVICE_NAME,

Why can't you solve this without making sal_console_uart global?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

