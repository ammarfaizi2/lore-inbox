Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWF2Rbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWF2Rbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWF2Rbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:31:31 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:13406 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751086AbWF2Rb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:31:29 -0400
Message-ID: <44A40E68.9080906@tls.msk.ru>
Date: Thu, 29 Jun 2006 21:31:20 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris@amavis.tls.msk.ru, Wedgwood@vger.kernel.org
Subject: Re: [PATCH 07/13] SERIAL: PARPORT_SERIAL should depend on SERIAL_8250_PCI
References: <20060620114527.934114000@sous-sol.org> <20060620114733.957367000@sous-sol.org>
In-Reply-To: <20060620114733.957367000@sous-sol.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote at Tue, 20 Jun 2006 00:00:07 -0700:

> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> From:	Russell King <rmk+lkml@arm.linux.org.uk>
> 
> Since parport_serial uses symbols from 8250_pci, there should
> be a dependency between the configuration symbols for these
> two modules.  Problem reported by Andrey Borzenkov
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
>  drivers/parport/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> --- linux-2.6.16.21.orig/drivers/parport/Kconfig
> +++ linux-2.6.16.21/drivers/parport/Kconfig
> @@ -48,7 +48,7 @@ config PARPORT_PC
>  
>  config PARPORT_SERIAL
>  	tristate "Multi-IO cards (parallel and serial)"
> -	depends on SERIAL_8250 && PARPORT_PC && PCI
> +	depends on SERIAL_8250_PCI && PARPORT_PC && PCI
>  	help
>  	  This adds support for multi-IO PCI cards that have parallel and
>  	  serial ports.  You should say Y or M here.  If you say M, the module

Hmm.  I just found out that this patch makes our serial+parallel PCI cards unusable..
because.. well.. because it effectively turns parport_serial OFF, without a way to
select it either as a module or built-in.  Because on 2.6.16, there's NO such
config symbol - SERIAL_8250_PCI.  Ie, the original Kconfig was right, but this
change just broke (disabled) parport_serial module completely.

In contrast, in 2.6.17 (as Andrey Borzenkov correctly pointed out), this change IS
needed (see eg. http://lkml.org/lkml/2006/6/18/117).

I've no idea how this patch slipped into 2.6.16 -stable queue in the first place... ;)

Thanks.

/mjt
