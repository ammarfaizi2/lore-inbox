Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWJZCYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWJZCYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422825AbWJZCYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:24:12 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:14764 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422800AbWJZCYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:24:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=eLikH2IVx0YI2pISgw5TVuRfG9Qq33e6XQDB5OzafmOckKhVYQpU3pO65tRefV4vBFGuaoX9wuY2i0oOMJPzaEcwlyBJQjmLO21Mh6YmGk6xBPtVpN8fiQRk4OZzhK3cHIwJxta6MrQ98stWpOhOl08tlvgKd2jTHA7SlmFdtGg=  ;
From: David Brownell <david-b@pacbell.net>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 1/2] !CONFIG_NET_ETHERNET unsets CONFIG_PHYLIB, but  CONFIG_USB_USBNET also needs CONFIG_PHYLIB
Date: Wed, 25 Oct 2006 19:24:03 -0700
User-Agent: KMail/1.7.1
Cc: toralf.foerster@gmx.de, netdev@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, link@miggy.org, greg@kroah.com,
       akpm@osdl.org, zippel@linux-m68k.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061025222709.A13681C5E0B@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20061025165957.4c390137.randy.dunlap@oracle.com>
In-Reply-To: <20061025165957.4c390137.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610251924.04321.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 October 2006 4:59 pm, Randy Dunlap wrote:
> On Wed, 25 Oct 2006 15:27:09 -0700 David Brownell wrote:
> 
> > The other parts are right, this isn't.
> > 
> > Instead, "usbnet.c" should #ifdef the relevant ethtool hooks
> > according to CONFIG_MII ... since it's completely legit to
> > use usbnet with peripherals that don't need MII.
> 
> Ugh.  OK.  How's this?  (2 patches)

Looks about right, but ...


> However, the MII config symbol should not be in the 10/100 Ethernet
> menu, so that other drivers can use (enable) it or so that users
> can enable it without needing to enable 10/100 Ethernet.

... MII should still depend on ETHERNET, right?
Just not limited to 10/100 Ethernet.

> --- linux-2619-rc3-pv.orig/drivers/net/Kconfig
> +++ linux-2619-rc3-pv/drivers/net/Kconfig
> @@ -145,6 +145,13 @@ config NET_SB1000
>  
>  source "drivers/net/arcnet/Kconfig"
>  
> +config MII
> +	tristate "Generic Media Independent Interface device support"
> +	help
> +	  Most ethernet controllers have MII transceiver either as an external
> +	  or internal device.  It is safe to say Y or M here even if your
> +	  ethernet card lacks MII.
> +
>  source "drivers/net/phy/Kconfig"
>  
>  #
> @@ -180,14 +187,6 @@ config NET_ETHERNET
>  	  kernel: saying N will just cause the configurator to skip all
>  	  the questions about Ethernet network cards. If unsure, say N.
>  
> -config MII
> -	tristate "Generic Media Independent Interface device support"
> -	depends on NET_ETHERNET
> -	help
> -	  Most ethernet controllers have MII transceiver either as an external
> -	  or internal device.  It is safe to say Y or M here even if your
> -	  ethernet card lack MII.
> -
>  source "drivers/net/arm/Kconfig"
>  
>  config MACE
> 
