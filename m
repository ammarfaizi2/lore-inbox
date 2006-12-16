Return-Path: <linux-kernel-owner+w=401wt.eu-S1030830AbWLPKxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030830AbWLPKxX (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 05:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030835AbWLPKxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 05:53:23 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:39245 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030830AbWLPKxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 05:53:22 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4583D008.40806@s5r6.in-berlin.de>
Date: Sat, 16 Dec 2006 11:52:56 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Make entries in the "Device drivers" menu individually
 selectable
References: <Pine.LNX.4.64.0612140325340.13847@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612140325340.13847@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote on 2006-12-14:
>   i've posted on this before so here's a slightly-updated patch that
> uses the kbuild "menuconfig" feature to make numerous entries under
> the Device drivers menu selectable on the spot.

Works for me, but I don't see a lot of benefit from it. Actually I see
two disadvantages of the patch:

 - Without the patch, the choice of y/m/n for a subsystem and the help
text is put aside into the submenu. I find this current layout simpler
and quieter.

 - There are two out-of-tree FireWire drivers for special purposes (one
bus sniffer, one remote debugging aid) which might perhaps be candidates
for integration into mainline. These drivers do not use the ieee1394
base driver. (They just don't need to.) With your patch, disabling the
subsystem menu would not only disable the subsystem core driver (which
is correct) but would also hide the choice for such extra drivers which
do not need the core driver. Or vice versa, enabling the submenu would
enable the core driver, even though not all subsystem choices need the
core driver.

The latter point could be worked around by creating an extra hidden
option for the core driver which is SELECTed by the subsystem drivers
which need it. But this would put the user out of control and would
clash with the fact that there are further configuration options for the
core driver itself.

(Sorry if these things were already discussed when you posted the patch
before, I missed that.)

> if folks think this is a good idea, what's the best way to get it in?
> 
>   i could officially submit the patch as is or, if that's too
> wide-sweeping since it hits a lot of subsystems, leave it up to the
> individual subsystem maintainers to decide for themselves and submit
> their own patch.

This kind of patch can certainly be integrated as one big chunk. However
the points I made above are more valid for some subsystems than others.

>   (the patch below modifies those entries for which a "menuconfig"
> entry was immediately obvious and shouldn't affect any of the
> underlying logic.  that's why some entries were deliberately left out
> of the patch, at least for now.)
> 
> 
>  drivers/ata/Kconfig         |    8 ++------
>  drivers/connector/Kconfig   |    8 ++++----
>  drivers/dma/Kconfig         |   10 +++++-----
>  drivers/edac/Kconfig        |    8 ++++----
>  drivers/hwmon/Kconfig       |    8 ++++----
>  drivers/i2c/Kconfig         |    9 ++++-----
>  drivers/ide/Kconfig         |    6 +-----
>  drivers/ieee1394/Kconfig    |    7 ++++---
>  drivers/infiniband/Kconfig  |   10 +++++-----
>  drivers/isdn/Kconfig        |    9 ++++-----
>  drivers/leds/Kconfig        |    9 +++------
>  drivers/md/Kconfig          |    8 ++++----
>  drivers/message/i2o/Kconfig |   12 +++++-------
>  drivers/mmc/Kconfig         |    8 ++++----
>  drivers/mtd/Kconfig         |    8 ++++----
>  drivers/parport/Kconfig     |    8 ++++----
>  drivers/pnp/Kconfig         |    8 ++++----
>  drivers/spi/Kconfig         |    8 ++++----
>  drivers/telephony/Kconfig   |    9 ++++-----
>  drivers/w1/Kconfig          |    8 ++++----
>  20 files changed, 77 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 984ab28..a3bdf04 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -2,10 +2,8 @@
>  # SATA/PATA driver configuration
>  #
> 
> -menu "Serial ATA (prod) and Parallel ATA (experimental) drivers"
> -
> -config ATA
> -	tristate "ATA device support"
> +menuconfig ATA
> +	tristate "Serial ATA (prod) and Parallel ATA (experimental) drivers"
>  	depends on BLOCK
>  	depends on !(M32R || M68K) || BROKEN
>  	depends on !SUN4 || BROKEN
> @@ -519,5 +517,3 @@ config PATA_IXP4XX_CF
>  	  If unsure, say N.
> 
>  endif
> -endmenu
> -
[...]


-- 
Stefan Richter
-=====-=-==- ==-- =----
http://arcgraph.de/sr/
