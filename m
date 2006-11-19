Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933715AbWKSX2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933715AbWKSX2J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 18:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933750AbWKSX2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 18:28:09 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:24052 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S933715AbWKSX2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 18:28:06 -0500
Date: Sun, 19 Nov 2006 15:24:32 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: jeff@garzik.org, shemminger@osdl.org, romieu@fr.zoreil.com,
       csnook@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] atl1: Build files for Attansic L1 driver
Message-Id: <20061119152432.a85d4166.randy.dunlap@oracle.com>
In-Reply-To: <20061119202915.GB29736@osprey.hogchain.net>
References: <20061119202915.GB29736@osprey.hogchain.net>
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

On Sun, 19 Nov 2006 14:29:15 -0600 Jay Cliburn wrote:

> From: Jay Cliburn <jacliburn@bellsouth.net>
> 
> This patch contains the build files for the Attansic L1 gigabit ethernet
> adapter driver.
> 
> Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>
> ---
> 
>  Kconfig       |   12 ++++++++++++
>  Makefile      |    1 +
>  atl1/Makefile |   30 ++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 6e863aa..f503d10 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -2329,6 +2329,18 @@ config QLA3XXX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called qla3xxx.
>  
> +config ATL1
> +	tristate "Attansic(R) L1 Gigabit Ethernet support (EXPERIMENTAL)"
> +	depends on NET_PCI && PCI && EXPERIMENTAL
> +	select CRC32
> +	select MII
> +	---help---
> +	  This driver supports Attansic L1 gigabit ethernet adapter.
> +
> +	  To compile this driver as a module, choose M here.  The module
> +	  will be called atl1.
> +
> +
>  endmenu

One problem here is that MII depends on NET_ETHERNET, which is
10/100 ethernet, which may not be enabled if someone has only
gigabit ethernet.  :)

I have a partial patch which moves MII and PHYLIB outside of
NET_ETHERNET.  That also makes them usable by USB or other
non-drivers/net/ drivers, e.g., again without the need
to enable NET_ETHERNET if someone only has USB ethernet.  :(

I'll try to post it for review later today.

---
~Randy
