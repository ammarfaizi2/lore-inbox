Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbUCOCU0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 21:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUCOCU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 21:20:26 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:27062 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262198AbUCOCUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 21:20:21 -0500
Message-ID: <4055122D.8030809@us.ibm.com>
Date: Sun, 14 Mar 2004 18:17:17 -0800
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org,
       davem@redhat.com, netdev <netdev@oss.sgi.com>
Subject: Re: [patch/RFC] networking menus
References: <20040314163327.53102f46.rddunlap@osdl.org>
In-Reply-To: <20040314163327.53102f46.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> This is just a first pass/RFC.  It moves "Networking support" out of
> the "Device Drivers" menu, which seems helpful to me.  However,
> ISTM that it should really just be the "Networking options" here
> and not include Amateur Radio, IrDA, and Bluetooth support.
> I.e., I think that those latter 3 should fall under Device Drivers.
> Does that make sense to anyone else?

Just a comment that those 3 subsystems are not just
device drivers, they have non-trivial amount of code
in the protocol stack under ../net/. So would moving
them to device drivers be misleading in any way?

I can see pulling out Networking support from under
device drivers, though.

> Does this need to be discussed on netdev (also)?

Yes. :)

thanks,
Nivedita

> 
> // Linux 2.6.4
> // Rearrange networking menus so that Networking support/options
> // isn't buried inside Device Drivers.
 >
> diffstat:=
>  drivers/Kconfig       |    4 +++-
>  init/Kconfig          |    0
>  net/Kconfig           |    6 ++----
>  net/ax25/Kconfig      |    7 ++-----
>  net/bluetooth/Kconfig |    4 +---
>  net/irda/Kconfig      |    6 ++----
>  6 files changed, 10 insertions(+), 17 deletions(-)
> 
> 
> diff -Naurp ./drivers/Kconfig~net_config ./drivers/Kconfig
> --- ./drivers/Kconfig~net_config	2004-03-10 18:55:44.000000000 -0800
> +++ ./drivers/Kconfig	2004-03-12 15:20:39.000000000 -0800
> @@ -1,5 +1,7 @@
>  # drivers/Kconfig
>  
> +source "net/Kconfig"
> +
>  menu "Device Drivers"
>  
>  source "drivers/base/Kconfig"
> @@ -28,7 +30,7 @@ source "drivers/message/i2o/Kconfig"
>  
>  source "drivers/macintosh/Kconfig"
>  
> -source "net/Kconfig"
> +source "drivers/net/Kconfig"
>  
>  source "drivers/isdn/Kconfig"
>  
> diff -Naurp ./net/bluetooth/Kconfig~net_config ./net/bluetooth/Kconfig
> --- ./net/bluetooth/Kconfig~net_config	2004-03-10 18:55:43.000000000 -0800
> +++ ./net/bluetooth/Kconfig	2004-03-12 15:41:42.000000000 -0800
> @@ -2,10 +2,8 @@
>  # Bluetooth subsystem configuration
>  #
>  
> -menu "Bluetooth support"
> +menuconfig BT
>  	depends on NET
> -
> -config BT
>  	tristate "Bluetooth subsystem support"
>  	help
>  	  Bluetooth is low-cost, low-power, short-range wireless technology.
> diff -Naurp ./net/irda/Kconfig~net_config ./net/irda/Kconfig
> --- ./net/irda/Kconfig~net_config	2004-03-10 18:55:27.000000000 -0800
> +++ ./net/irda/Kconfig	2004-03-12 15:39:39.000000000 -0800
> @@ -2,11 +2,9 @@
>  # IrDA protocol configuration
>  #
>  
> -menu "IrDA (infrared) support"
> +menuconfig IRDA
>  	depends on NET
> -
> -config IRDA
> -	tristate "IrDA subsystem support"
> +	tristate "IrDA (infrared) subsystem support"
>  	---help---
>  	  Say Y here if you want to build support for the IrDA (TM) protocols.
>  	  The Infrared Data Associations (tm) specifies standards for wireless
> diff -Naurp ./net/ax25/Kconfig~net_config ./net/ax25/Kconfig
> --- ./net/ax25/Kconfig~net_config	2004-03-10 18:55:44.000000000 -0800
> +++ ./net/ax25/Kconfig	2004-03-12 15:40:01.000000000 -0800
> @@ -6,9 +6,8 @@
>  #		Joerg Reuter DL1BKE <jreuter@yaina.de>
>  # 19980129	Moved to net/ax25/Config.in, sourcing device drivers.
>  
> -menu "Amateur Radio support"
> -
> -config HAMRADIO
> +menuconfig HAMRADIO
> +	depends on NET
>  	bool "Amateur Radio support"
>  	help
>  	  If you want to connect your Linux box to an amateur radio, answer Y
> @@ -109,5 +108,3 @@ source "drivers/net/hamradio/Kconfig"
>  
>  endmenu
>  
> -endmenu
> -
> diff -Naurp ./net/Kconfig~net_config ./net/Kconfig
> --- ./net/Kconfig~net_config	2004-03-10 18:55:21.000000000 -0800
> +++ ./net/Kconfig	2004-03-12 15:24:30.000000000 -0800
> @@ -2,9 +2,9 @@
>  # Network configuration
>  #
>  
> -menu "Networking support"
> +###menu "Networking support"
>  
> -config NET
> +menuconfig NET
>  	bool "Networking support"
>  	---help---
>  	  Unless you really know what you are doing, you should say Y here.
> @@ -650,8 +650,6 @@ endmenu
>  
>  endmenu
>  
> -source "drivers/net/Kconfig"
> -
>  source "net/ax25/Kconfig"
>  
>  source "net/irda/Kconfig"
> diff -Naurp ./init/Kconfig~net_config ./init/Kconfig
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



