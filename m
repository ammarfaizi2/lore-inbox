Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265876AbUAKMyO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 07:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUAKMyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 07:54:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37388 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265876AbUAKMyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 07:54:07 -0500
Date: Sun, 11 Jan 2004 12:54:04 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: martin f krafft <madduck@madduck.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6: can't get 3c575/PCMCIA working - other PCMCIA card work
Message-ID: <20040111125404.E1931@flint.arm.linux.org.uk>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040106111939.GA2046@piper.madduck.net> <20040111120053.C1931@flint.arm.linux.org.uk> <20040111123208.GA4766@piper.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040111123208.GA4766@piper.madduck.net>; from madduck@madduck.net on Sun, Jan 11, 2004 at 01:32:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 01:32:08PM +0100, martin f krafft wrote:
> The card is a 3CCFE575BT-D. Under 2.4 with Hinds' pcmcia-cs modules,
> the driver was called 3c575_cs. Under 2.6 with the kernel drivers,
> only 3c574_cs exists. I assumed that 3c574_cs would also support the
> 3c575_cs, but I guess I am wrong.

The situation in vanilla 2.4 and 2.6 kernels is as follows: xxx_cs
drivers only drive PCMCIA cards.  They do not drive Cardbus cards -
Cardbus cards look exactly like normal PCI cards, and are therefore
the drivers are handled by the PCI subsystem.  PCMCIA helps out only
to detect the card insertion/removal events.

Hope this helps to make things a little clearer.

> A 3CCFE574BT works just fine with 574_cs (although upon removal,
> ifconfig will hang in the 'D' state forever. I guess that's
> a separate issue though. I will research this and post another time.

Indeed.

> > Could you insert the card, and then provide the output of lspci -vx ?
> 
> ftp://ftp.madduck.net/scratch/3c575-lspci.gz [1.5Kb]

... which seems to be exactly the same as my 3ccfe575bt card I have here.
I note though that the product description seems to be wrong (the PCI IDs
are identical.)  The card is most definitely "3CCFE575BT" and not "3c575".

Yours:

02:00.0 Ethernet controller: 3Com Corporation 3c575 [Megahertz] 10/100 LAN Card Bus (rev 01)
        Subsystem: 3Com Corporation 3C575 Megahertz 10/100 LAN Cardbus PC Card

Mine:

04:00.0 Ethernet controller: 3Com Corporation 3CCFE575BT Cyclone CardBus (rev 01)
        Subsystem: 3Com Corporation 3C575 Megahertz 10/100 LAN Cardbus PC Card

Socket 1:
  product info: "3Com Corporation", "3CCFE575BT", "LAN Cardbus Card", "001"
  manfid: 0x0101, 0x5157
  function: 6 (network)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
