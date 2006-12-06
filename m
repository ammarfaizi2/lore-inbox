Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937576AbWLFTxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937576AbWLFTxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937578AbWLFTxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:53:18 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:45666 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937576AbWLFTxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:53:16 -0500
Date: Wed, 6 Dec 2006 11:54:00 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Restructure Device Driver menu entries
Message-Id: <20061206115400.7184e116.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612060514210.7300@localhost.localdomain>
References: <Pine.LNX.4.64.0612060514210.7300@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 09:33:46 -0500 (EST) Robert P. J. Day wrote:

> 
>   This is a *proposed* restructuring of the DD menu so that one can
> see and select/de-select entire submenus without having to enter each
> submenu.    It's also immediately obvious visually which submenus are
> currently active.
> 
>   Based on Randy Dunlap's earlier suggestion, it uses the kbuild
> "menuconfig" feature.  I changed only those sub-entries that matched
> an obvious pattern (that is, selectable in their entirety).  If there
> was *anything* slightly different about that sub-entry, I left it
> alone.  (That doesn't mean that those sub-entries can't be similarly
> tweaked with a minimum of effort, I was just keeping it simple for
> now.)
> 
>   Finally, if this structure is used, there's still a good deal of
> cleanup that can be done on each Kconfig file.  For example, if most
> of the mtd Kconfig file is now surrounded by
> 
>   if MTD
>   ...
>   endif
> 
> then each internal entry no longer has to include any variation of
> 
>   depends on MTD
> 
> but, for the time being, I left the individual config entries alone
> and just changed the top-level structure of each Kconfig file that was
> appropriate, just to get some feedback.
> 
>   Thoughts on this approach?

Looks like InfiniBand support wasn't converted to use the
menuconfig keyword?  Now its menu shows up at an odd location
in xconfig.  (Please test changes with menuconfig, xconfig, &
gconfig.)

Otherwise looks good to me.


> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index 9edface..25454e8 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -1,13 +1,13 @@
> -menu "InfiniBand support"
> -
>  config INFINIBAND
> -	depends on PCI || BROKEN
>  	tristate "InfiniBand support"
> +	depends on PCI || BROKEN
>  	---help---
>  	  Core support for InfiniBand (IB).  Make sure to also select
>  	  any protocols you wish to use as well as drivers for your
>  	  InfiniBand hardware.
> 
> +if INFINIBAND
> +
>  config INFINIBAND_USER_MAD
>  	tristate "InfiniBand userspace MAD support"
>  	depends on INFINIBAND
> @@ -45,4 +45,4 @@ source "drivers/infiniband/ulp/srp/Kconf
> 
>  source "drivers/infiniband/ulp/iser/Kconfig"
> 
> -endmenu
> +endif

---
~Randy
