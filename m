Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWI1B3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWI1B3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWI1B3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:29:05 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:25694 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964986AbWI1B3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:29:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=hViRbQxDBLfEVXPBEWYwoFvn0af7gNTsfu83w1up4kQiTO8x+4t7f1PVTiKm5dNg4jtm1nXPrxenVoNzwHJY3d57oIGMS0a9qw4zfZ27OYQZYqG6Ow8NYA0SlDkEdyeZCfc+X23yaBXe2/lKZ+Afz0kh83mds8AC6LCRRR+KDxw=  ;
From: David Brownell <david-b@pacbell.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] driver for mcs7830 (aka DeLOCK) USB ethernet adapter
Date: Wed, 27 Sep 2006 18:28:57 -0700
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net,
       David Hollis <dhollis@davehollis.com>, support@moschip.com,
       dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       Michael Helmling <supermihi@web.de>
References: <200609170102.50856.arnd@arndb.de>
In-Reply-To: <200609170102.50856.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271828.58205.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 September 2006 4:02 pm, Arnd Bergmann wrote:
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
> broken packets in the RX interrupt. The problem goes away when
> I'm using an active USB hub, so I assume it's not related to
> the device driver, but rather to the hardware.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

... yes, I'd assume it's a hardware issue too.  Try different
cables; if you have a fast 'scope, you might see what kind of
eye diagram you get.  The hub might improve the signal quality.


Do you know how the remote wakeup mechanism works for this chip?
It'd be interesting to see "usbnet" be taught how to autosuspend
chips which will wake up the USB host when they get the right
kind of packet ... for example, passing the multicast/broadcast
filter, or addressed directly to that adapter.

Such an autosuspend mechanism would let the host controller stop
polling a mostly-idle network link, getting rid of one source of
periodic DMA transfers and thus allowing deeper sleep states for
many x86 family CPUs.  And also, I'd expect, giving fewer
opportunities for those broken RX packets.  :)

- Dave

