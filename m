Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265758AbUGDTkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265758AbUGDTkx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 15:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265761AbUGDTkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 15:40:53 -0400
Received: from jupiter.loonybin.net ([208.248.0.98]:17169 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S265758AbUGDTku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 15:40:50 -0400
Date: Sun, 4 Jul 2004 14:40:09 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too in 2.6.x tx timeout
Message-ID: <20040704194009.GA2029@bliss>
References: <20040626222304.GA31195@bliss> <87hdsoghdv.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hdsoghdv.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 08:07:40PM +0900, OGAWA Hirofumi wrote:
> Zinx Verituse <zinx@epicsol.org> writes:
> 
> > This problem appears similar to the thread earlier this year with
> > the subject '2.6.3 - 8139too timeout debug info', but I don't think
> > it is, since the 2.6.2 driver and patches given in that thread
> > don't appear to work.
> > 
> > I have enabled debug in the stock Linux 2.6.7 8139too.c and posted it at:
> > http://zinx.xmms.org/misc/tmp/8139too.debug
> > The debug shows init, DHCP request (succeeded), then a ping -f that lasts
> > until shortly after it timed out.
> 
> Already solved?

Nope, but I've done some more looking.

> 
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Transmit timeout, status 0d 0000 c07f media 08.
> eth0: Tx queue start entry 25  dirty entry 21.
> eth0:  Tx descriptor 0 is 10080062.
> eth0:  Tx descriptor 1 is 00080062. (queue head)
> eth0:  Tx descriptor 2 is 00080062.
> eth0:  Tx descriptor 3 is 00080062.
> eth0: link up, 10Mbps, half-duplex, lpa 0x0000
> rtl8139_hw_start: init buffer addresses
> 
> Tx status registers seems still not complete to transmit the packets.
> So this problem may not be the lost interrupt problem.
> 
> The attached file is the ported 2.4.24's 8139too.c. Can you try this
> driver? This driver solve the problem?

No :(

My only idea right now is perhaps the yenta stuff in 2.6.7 doesn't
initialize the card the same way as the stuff in 2.4.24; but I'm not
very familiar with all the hardware/software involved :)

> 
> Also, please send the .config.

Up with some other files:
http://zinx.xmms.org/misc/tmp/8139too/
linux-2.6.7-mobius-dotconfig (.config being used for the kernel)
8139too.debug (original 2.6.7 driver debug info)
8139too.debug-2.4.24-driver-in-2.6.7 (ping -f with the forward-ported 2.4.24 driver)
8139too.debug2-2.4.24-driver-in-2.6.7 (individual ping -c 1's with the forward ported 2.4.24 driver)
8139too.2.6.7.diag (rtl8139-diag output for 2.6.7; 2.6.7 driver)
8139too.2.4.24-in-2.6.7.diag (rtl8139-diag for 2.6.7; 2.4.24 driver)
8139too.2.4.24.diag (rtl8139-diag output for 2.4.24 [knoppix 2004-02-16])

On the ping -c1: several pings made it, then it didn't reply for one,
but also reported no timeout in the messages.  Another ping caused it
to not reply _and_ to timeout/reset.

> 
> Thanks.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 

Thank you very much for helping :)

By the way, I downloaded the specs for the 8139C and noticed immediately
it claims writing to the ISR has no effect and that reading it clears it.
The drivers appear to indicate this documentation is entirely wrong --
Is there any real documentation for this chipset?

-- 
Zinx Verituse                                    http://zinx.xmms.org/
