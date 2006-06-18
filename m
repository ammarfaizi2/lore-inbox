Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWFRP2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWFRP2y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWFRP2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:28:54 -0400
Received: from mx5.mail.ru ([194.67.23.25]:18468 "EHLO mx5.mail.ru")
	by vger.kernel.org with ESMTP id S1751184AbWFRP2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:28:54 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 2.6.17: CONFIG_PARPORT_SERIAL should require CONFIG_SERIAL_8250_PCI?
Date: Sun, 18 Jun 2006 19:28:50 +0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200606181423.17884.arvidjaar@mail.ru> <20060618120542.GA4833@flint.arm.linux.org.uk>
In-Reply-To: <20060618120542.GA4833@flint.arm.linux.org.uk>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606181928.51560.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 18 June 2006 16:05, Russell King wrote:
> On Sun, Jun 18, 2006 at 02:23:07PM +0400, Andrey Borzenkov wrote:
> > Just rebuilt 2.6.17 from older config and disabling 8250 PCI (I do not
> > have any on notebook) and got:
>
> Thanks for reporting this.  The patch below should fix this - please
> test so it can be submitted for the stable branch, thanks.
>

I confirm that with this patch doing oldconfig and deselecting SERIAL_8250_PCI 
also deselects PARPORT_SERIAL.

regards

- -andrey

> # Base git commit: 427abfa28afedffadfca9dd8b067eb6d36bac53f
> #	(Linux v2.6.17)
> #
> # Author:    Russell King (Sun Jun 18 13:00:48 BST 2006)
> # Committer: Russell King (Sun Jun 18 13:00:48 BST 2006)
> #
> #	[SERIAL] PARPORT_SERIAL should depend on SERIAL_8250_PCI
> #
> #	Since parport_serial uses symbols from 8250_pci, there should
> #	be a dependency between the configuration symbols for these
> #	two modules.  Problem reported by Andrey Borzenkov
> #
> #	Signed-off-by: Russell King
> #
> #	 drivers/parport/Kconfig |    2 +-
> #	 1 files changed, 1 insertions(+), 1 deletions(-)
> #
> diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
> --- a/drivers/parport/Kconfig
> +++ b/drivers/parport/Kconfig
> @@ -48,7 +48,7 @@ config PARPORT_PC
>
>  config PARPORT_SERIAL
>  	tristate "Multi-IO cards (parallel and serial)"
> -	depends on SERIAL_8250 && PARPORT_PC && PCI
> +	depends on SERIAL_8250_PCI && PARPORT_PC && PCI
>  	help
>  	  This adds support for multi-IO PCI cards that have parallel and
>  	  serial ports.  You should say Y or M here.  If you say M, the module
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFElXEzR6LMutpd94wRAh5PAKC7rNyFMqogQPGgYYixgK14M6hwcgCgs8h8
IqQIn2z447RBjQGLXM00iog=
=Tisv
-----END PGP SIGNATURE-----
