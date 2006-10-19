Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946478AbWJSUvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946478AbWJSUvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423290AbWJSUvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:51:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51094 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423253AbWJSUvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:51:48 -0400
Date: Thu, 19 Oct 2006 13:39:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Mirko Lindner <mlindner@syskonnect.de>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 4/6] net: use bitrev8
Message-Id: <20061019133951.1d463173.akpm@osdl.org>
In-Reply-To: <20061018164647.GD21820@localhost>
References: <20061018164647.GD21820@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 01:46:47 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Use bitrev8 for bmac, mace, macmace, macsonic, and skfp drivers.
> 
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Mirko Lindner <mlindner@syskonnect.de>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
>  drivers/net/Kconfig        |    1 
>  drivers/net/bmac.c         |   20 ++--------
>  drivers/net/mace.c         |   16 +-------
>  drivers/net/macmace.c      |   18 +--------
>  drivers/net/macsonic.c     |    6 ---
>  drivers/net/skfp/can.c     |   83 ---------------------------------------------
>  drivers/net/skfp/drvfbi.c  |   21 ++++-------
>  drivers/net/skfp/fplustm.c |    4 +-
>  drivers/net/skfp/smt.c     |    7 +--

A bunch of drivers.

> ===================================================================
> --- work-fault-inject.orig/drivers/net/Kconfig
> +++ work-fault-inject/drivers/net/Kconfig
> @@ -2500,6 +2500,7 @@ config DEFXX
>  config SKFP
>  	tristate "SysKonnect FDDI PCI support"
>  	depends on FDDI && PCI
> +	select BITREVERSE
>  	---help---
>  	  Say Y here if you have a SysKonnect FDDI PCI adapter.
>  	  The following adapters are supported by this driver:

But only one of them selects the library.

The patchset adds a large number of `select' statements.  afaict everything
_seems_ to work OK with that (as long as all the needed selects are there).

But select is problematic and I do wonder whether it'd be simpler to just
link the thing into vmlinux.

Oh well, we'll see how it goes.

