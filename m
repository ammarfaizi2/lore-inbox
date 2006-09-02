Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWIBRvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWIBRvy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 13:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWIBRvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 13:51:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:9173 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751250AbWIBRvx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 13:51:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [PATCH] driver for mcs7830 (aka DeLOCK) USB ethernet adapter
Date: Sat, 2 Sep 2006 19:51:38 +0200
User-Agent: KMail/1.9.1
Cc: linux-usb-devel@lists.sourceforge.net,
       David Hollis <dhollis@davehollis.com>, support@moschip.com,
       dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       Michael Helmling <supermihi@web.de>
References: <200608071500.55903.arnd.bergmann@de.ibm.com> <200608202207.39709.arnd@arndb.de> <200609020338.54932.david-b@pacbell.net>
In-Reply-To: <200609020338.54932.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609021951.40470.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 September 2006 12:38, David Brownell wrote:
> > 
> > It has been tested successfully on an OHCI, but interestingly
> > there seems to be a problem with the mcs7830 when connected to
> > the ICH6/EHCI in my thinkpad: it keeps receiving lots of
> > broken packets in the RX interrupt.
> 
> That is, the "status" polling which you disabled??  If so, please
> update this comment ...

No, the receive errors are independent from the status interrupt.
I have now got confirmation by another user that they also
happen on a different thinkpad when not using a USB hub, but
with a hub everything seems fine.

> > The problem goes away when 
> > I'm using an active USB hub, so I assume it's not related to
> > the device driver, but rather to the hardware.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Looks basically OK to me, although I'd rather see the two patches
> you posted on 27-August be merged into it before an upstream merge.
> (To use normal MII constants, and handle max size frames.)

Ok, I can resend.

> > This version incorporates a few cleanups from myself an changes
> > based on comments from David Hollis. 
> 
> He has more experience than I do with respect to these sorts of
> real Ethernet adapters and usbnet.  :)
> 
> Speaking of which ... isnt this driver missing a hook to make
> the MII stuff visible through ethtool?

hmm, I wasn't aware that ethtool does this. I did check that mii-tool
works though.

Going through the ethtool operations, I think that it should be
possible to implement a few of them, including ETHTOOL_GREGS,
ETHTOOL_GEEPROM, ETHTOOL_SEEPROM, ETHTOOL_NWAY_RST and ETHTOOL_GPERMADDR.
Do you think these should be done?

	Arnd <><

-- 
VGER BF report: U 0.49989
