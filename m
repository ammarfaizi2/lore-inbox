Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVCaQKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVCaQKm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVCaQKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:10:41 -0500
Received: from colo.lackof.org ([198.49.126.79]:1457 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261528AbVCaQKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:10:20 -0500
Date: Thu, 31 Mar 2005 09:12:06 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jim Gifford <maillist@jg555.com>
Cc: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: 64bit build of tulip driver
Message-ID: <20050331161206.GB19219@colo.lackof.org>
References: <424AE9E0.8040601@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424AE9E0.8040601@jg555.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 10:03:12AM -0800, Jim Gifford wrote:
> Under 32bit the tulip driver works fine, but under 64 bit it gives me a 
> lot if problems.

Sorry - I'm not seeing issues on either ia64 or parisc 64-bit systems.
But I'm only using HP 100BT cards (4-port, occasionally variants of
single port cards, and built-in on parisc workstations/servers).

2.6.12-rc1 bits seem to work fine on a500 (aka rp2470).


> I updated the tulip to what is in the current repository, and the issue
> still exists. Any suggestions.
> 
> First off it continually sends data out the network interface and never 
> negotiates is speed and duplex.
> Second in the log files all I see is an uninformative message 
> 0000:00:07.0: tulip_stop_rxtx() failed
> 
> Here is all the bootup information differences I can find on the driver

Are there any config option differences? 
e.g. MWI or MMIO options enabled on 64-bit but not 32-bit?

> 64 bit
> Dec 31 16:01:29 lfs tulip0: ***WARNING***: No MII transceiver found!
> Dec 31 16:01:29 lfs tulip1: ***WARNING***: No MII transceiver found!

You'll have to add printk's until you can sort out why the MII transceiver
isn't responding. Odds are 64-bit code runs faster than 32-bit on
the same machine (more registers or something).

> 32 bit
> Dec 31 16:01:16 lfs tulip0:  MII transceiver #1 config 1000 status 7809 
> advertising 01e1
> Dec 31 16:01:16 lfs tulip1:  MII transceiver #1 config 1000 status 7809 
> advertising 01e1.
> 
> Complete boot log - yes I know the date and time are off.
> Under a 64 bit compile
> Dec 31 16:01:29 lfs Linux Tulip driver version 1.1.13 (May 11, 2002)

Interesting My source tree says:
#define DRV_RELDATE     "December 15, 2004"
(same version # though)

> Dec 31 16:01:29 lfs PCI: Enabling device 0000:00:07.0 (0045 -> 0047)
> Dec 31 16:01:29 lfs tulip0: Old format EEPROM on 'Cobalt Microserver' 
> board.  Using substitute media control info.
> Dec 31 16:01:29 lfs tulip0:  EEPROM default media type Autosense.
> Dec 31 16:01:29 lfs tulip0:  Index #0 - Media MII (#11) described by a 
> 21142 MII PHY (3) block.
> Dec 31 16:01:29 lfs tulip0: ***WARNING***: No MII transceiver found!
> Dec 31 16:01:29 lfs eth0: Digital DS21143 Tulip rev 65 at 
> ffffffffb0001400, 00:10:E0:00:32:DE, IRQ 19.

HP is using exactly this chip. Difference seems to be with the phy/MII.

> Dec 31 16:01:29 lfs PCI: Enabling device 0000:00:0c.0 (0005 -> 0007)
> Dec 31 16:01:29 lfs tulip1: Old format EEPROM on 'Cobalt Microserver' 
> board.  Using substitute media control info.
> Dec 31 16:01:29 lfs tulip1:  EEPROM default media type Autosense.
> Dec 31 16:01:29 lfs tulip1:  Index #0 - Media MII (#11) described by a 
> 21142 MII PHY (3) block.
> Dec 31 16:01:29 lfs tulip1: ***WARNING***: No MII transceiver found!
> Dec 31 16:01:29 lfs eth1: Digital DS21143 Tulip rev 65 at 
> ffffffffb0001480, 00:10:E0:00:32:DF, IRQ 20.
> Dec 31 16:01:29 lfs bootlog:  Bringing up the eth0 interface...[  OK  ]
> Dec 31 16:01:30 lfs bootlog:  Adding IPv4 address 172.16.0.99 to the 
> eth0 interface...[  OK  ]
> Dec 31 16:01:31 lfs bootlog:  Setting up default gateway...[  OK  ]
> Dec 31 16:01:32 lfs 0000:00:07.0: tulip_stop_rxtx() failed
> Dec 31 16:01:38 lfs 0000:00:07.0: tulip_stop_rxtx() failed
> Dec 31 16:01:44 lfs 0000:00:07.0: tulip_stop_rxtx() failed
> Dec 31 16:01:50 lfs 0000:00:07.0: tulip_stop_rxtx() failed
> Dec 31 16:01:56 lfs 0000:00:07.0: tulip_stop_rxtx() failed
> Dec 31 16:02:02 lfs 0000:00:07.0: tulip_stop_rxtx() failed
> Dec 31 16:02:08 lfs 0000:00:07.0: tulip_stop_rxtx() failed

ISTR to remember submitting a patch so additional data
gets printed in tulip_stop_rxtx. Here is a reference to the patch
but I don't think it is relevant to the this problem:
	http://lkml.org/lkml/2004/12/15/119

grant

> Under 32 bit
> Dec 31 16:01:16 lfs Linux Tulip driver version 1.1.13 (May 11, 2002)
> Dec 31 16:01:16 lfs PCI: Enabling device 0000:00:07.0 (0045 -> 0047)
> Dec 31 16:01:16 lfs tulip0: Old format EEPROM on 'Cobalt Microserver' 
> board.  Using substitute media control info.
> Dec 31 16:01:16 lfs tulip0:  EEPROM default media type Autosense.
> Dec 31 16:01:16 lfs tulip0:  Index #0 - Media MII (#11) described by a 
> 21142 MII PHY (3) block.
> Dec 31 16:01:16 lfs tulip0:  MII transceiver #1 config 1000 status 7809 
> advertising 01e1.
> Dec 31 16:01:16 lfs eth0: Digital DS21143 Tulip rev 65 at b0001400, 
> 00:10:E0:00:32:DE, IRQ 19.
> Dec 31 16:01:16 lfs tulip1: Old format EEPROM on 'Cobalt Microserver' 
> board.  Using substitute media control info.
> Dec 31 16:01:16 lfs tulip1:  EEPROM default media type Autosense.
> Dec 31 16:01:16 lfs tulip1:  Index #0 - Media MII (#11) described by a 
> 21142 MII PHY (3) block.
> Dec 31 16:01:16 lfs tulip1:  MII transceiver #1 config 1000 status 7809 
> advertising 01e1.
> Dec 31 16:01:16 lfs eth1: Digital DS21143 Tulip rev 65 at b0001480, 
> 00:10:E0:00:32:DF, IRQ 20.
> Dec 31 16:01:17 lfs bootlog:  Bringing up the eth0 interface...[  OK  ]
> Dec 31 16:01:17 lfs bootlog:  Adding IPv4 address 172.16.0.99 to the 
> eth0 interface...[  OK  ]
> Dec 31 16:01:18 lfs bootlog:  Setting up default gateway...[  OK  ]
> Dec 31 16:01:20 lfs eth0: Setting full-duplex based on MII#1 link 
> partner capability of 45e1.
> 
> -- 
> ----
> Jim Gifford
> maillist@jg555.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
