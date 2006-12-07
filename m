Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163330AbWLGUtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163330AbWLGUtl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 15:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163331AbWLGUtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 15:49:40 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:47237 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163330AbWLGUtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 15:49:40 -0500
Date: Thu, 7 Dec 2006 12:49:17 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild : Restructure Device Drivers menu for entry
 selectability
Message-Id: <20061207124917.7fa95b95.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612070354200.14891@localhost.localdomain>
References: <Pine.LNX.4.64.0612070354200.14891@localhost.localdomain>
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

On Thu, 7 Dec 2006 04:01:47 -0500 (EST) Robert P. J. Day wrote:

> 
>   Rewrite a number of the Kconfig files under the drivers/ directory
> so that those driver submenus can be selected or de-selected
> directly from the Drivers menu using the kbuild "menuconfig" feature
> without having to enter the submenu itself.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>   NOTE:  Only those drivers submenus for which the Kconfig change was
> *immediately* obvious are included here.  Some of the other Kconfig
> files have "issues" with dependencies so that they'll need some extra
> cleanup before they can be tweaked like this as well.  So this first
> pass of a patch is just the beginning.

InfiniBand is presented in the wrong location in xconfig
with this patch.  After changing this to be
"menuconfig INFINIBAND"
it works as expected and looks good.

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

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
