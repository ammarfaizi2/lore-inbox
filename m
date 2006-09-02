Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWIBKjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWIBKjN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 06:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWIBKjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 06:39:13 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:18356 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751029AbWIBKjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 06:39:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=stMKl+9JBY4D9DH9T/v8IhXBp/4W0e2wntCw+8Z+rSKYPHjfMbbbyKYbw9kGJcf4HPVA8sk0HwyY5RDWs4EUO6qHSm20iiOWDZSZFJczGDf5S5FvYFosGpkA+IgFlXB+TI0cOmlYWqy2r9QI/uiQTeo/NfT9kDgBntiZtnuQDss=  ;
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] driver for mcs7830 (aka DeLOCK) USB ethernet adapter
Date: Sat, 2 Sep 2006 03:38:54 -0700
User-Agent: KMail/1.7.1
Cc: Arnd Bergmann <arnd@arndb.de>, David Hollis <dhollis@davehollis.com>,
       support@moschip.com, dbrownell@users.sourceforge.net,
       linux-kernel@vger.kernel.org, Michael Helmling <supermihi@web.de>
References: <200608071500.55903.arnd.bergmann@de.ibm.com> <200608071811.09978.arnd.bergmann@de.ibm.com> <200608202207.39709.arnd@arndb.de>
In-Reply-To: <200608202207.39709.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609020338.54932.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 1:07 pm, Arnd Bergmann wrote:
> This driver adds support for the DeLOCK USB ethernet adapter
> and potentially others based on the MosChip MCS7830 chip.
> 
> It is based on the usbnet and asix drivers as well as the
> original device driver provided by MosChip, which in turn
> was based on the usbnet driver.
> 
> It has been tested successfully on an OHCI, but interestingly
> there seems to be a problem with the mcs7830 when connected to
> the ICH6/EHCI in my thinkpad: it keeps receiving lots of
> broken packets in the RX interrupt.

That is, the "status" polling which you disabled??  If so, please
update this comment ...

> The problem goes away when 
> I'm using an active USB hub, so I assume it's not related to
> the device driver, but rather to the hardware.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks basically OK to me, although I'd rather see the two patches
you posted on 27-August be merged into it before an upstream merge.
(To use normal MII constants, and handle max size frames.)


> ---
> 
> This version incorporates a few cleanups from myself an changes
> based on comments from David Hollis. 

He has more experience than I do with respect to these sorts of
real Ethernet adapters and usbnet.  :)

Speaking of which ... isnt this driver missing a hook to make
the MII stuff visible through ethtool?

- Dave

> In particular, it now has 
> 
> - an rx_fixup function that removes an out-of-band data byte
>   from each received packet.
> - got rid of the status function, which did not do the right thing
>   and is not needed in this driver.
> - has a working set_multicast function, although that one always
>   needs to set allmulticast mode in order to get the chip to
>   receive any frames.
> - doesn't use a private mutex in its mii functions, that functionality
>   is added in a separate patch to usbnet.
> 
> Please merge the driver in 2.6.19!
> 
>  drivers/usb/net/Kconfig   |    8
>  drivers/usb/net/Makefile  |    1
>  drivers/usb/net/mcs7830.c |  474 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 483 insertions(+)
> 
