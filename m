Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbUKQVdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbUKQVdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbUKQVbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:31:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27600 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262553AbUKQV2b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:28:31 -0500
Date: Wed, 17 Nov 2004 15:19:52 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops on boot when initializing CDROM
Message-ID: <20041117171952.GA22554@logos.cnet>
References: <Pine.LNX.4.58.0411162336510.24144@artax.karlin.mff.cuni.cz> <419BA1C0.3040601@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419BA1C0.3040601@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 11:08:48AM -0800, Randy.Dunlap wrote:
> Mikulas Patocka wrote:
> >When booting kernel 2.4.27 on notebook with cd-rw dvd-ro drive, I get oops
> >on cdrom_sysctl_register+2a trying to dereference address 20.
> >Call stack: register_cdrom+235
> >
> >gcc-3.2.3
> 
> Thanks for the .config file.
> 
> with: CONFIG_SYSCTL=y, CONFIG_PROC_FS=n
> 
> Am I confused here, or is the 2.4 (and 2.6) source code confused?

It seems the source is confused, ouch. 

Applied, thanks Randy.

> diffstat:=
>  drivers/cdrom/cdrom.c |    2 --
>  1 files changed, 2 deletions(-)
> 
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
> -- 

> diff -Naurp ./drivers/cdrom/cdrom.c~cdrom_sysctl ./drivers/cdrom/cdrom.c
> --- ./drivers/cdrom/cdrom.c~cdrom_sysctl	2003-11-28 10:26:20.000000000 -0800
> +++ ./drivers/cdrom/cdrom.c	2004-11-17 10:45:45.666804288 -0800
> @@ -2598,9 +2598,7 @@ ctl_table cdrom_cdrom_table[] = {
>  
>  /* Make sure that /proc/sys/dev is there */
>  ctl_table cdrom_root_table[] = {
> -#ifdef CONFIG_PROC_FS
>  	{CTL_DEV, "dev", NULL, 0, 0555, cdrom_cdrom_table},
> -#endif /* CONFIG_PROC_FS */
>  	{0}
>  	};
>  static struct ctl_table_header *cdrom_sysctl_header;

