Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136544AbREDWUe>; Fri, 4 May 2001 18:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136543AbREDWUO>; Fri, 4 May 2001 18:20:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19466 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136537AbREDWT5>;
	Fri, 4 May 2001 18:19:57 -0400
Date: Sat, 5 May 2001 00:19:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: proski@gnu.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-ac4 - oops on unload "cdrom" module
Message-ID: <20010505001917.P16507@suse.de>
In-Reply-To: <200105042110.XAA20705@green.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200105042110.XAA20705@green.mif.pg.gda.pl>; from ankry@green.mif.pg.gda.pl on Fri, May 04, 2001 at 11:10:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04 2001, Andrzej Krzysztofowicz wrote:
> > This oops happens when I run "rmmod cdrom" on a 2.4.4-ac4 kernel with
> > CONFIG_SYSCTL enabled. It doesn't happen if CONFIG_SYSCTL is disabled.
> > 
> > sr_mod isn't loaded at this point. Reference to sd_mod looks weird. After
> > this oops the "cdrom" module remains in memory in the "deleted" state.
> 
> > Unable to handle kernel NULL pointer dereference at virtual address 00000008
> [...]
> > >>EIP; c0118051 <unregister_sysctl_table+5/2c>   <=====
> 
> The following patch fixes unloading of cdrom module when no cdrom driver
> loaded (2.4.5-pre, 2.4.4-ac):
> 
> --- drivers/cdrom/cdrom.c.old	Fri May  4 22:44:31 2001
> +++ drivers/cdrom/cdrom.c	Fri May  4 22:54:36 2001
> @@ -2698,7 +2698,8 @@
>  
>  static void cdrom_sysctl_unregister(void)
>  {
> -	unregister_sysctl_table(cdrom_sysctl_header);
> +	if (cdrom_sysctl_header)
> +		unregister_sysctl_table(cdrom_sysctl_header);
>  }
>  
>  #endif /* CONFIG_SYSCTL */

Thanks applied.

-- 
Jens Axboe

