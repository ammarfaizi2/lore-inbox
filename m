Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267021AbTA3Auh>; Wed, 29 Jan 2003 19:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbTA3Auh>; Wed, 29 Jan 2003 19:50:37 -0500
Received: from fmr01.intel.com ([192.55.52.18]:59367 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267021AbTA3Aug>;
	Wed, 29 Jan 2003 19:50:36 -0500
Date: Thu, 30 Jan 2003 08:56:55 +0800 (CST)
From: Stanley Wang <stanley.wang@linux.co.intel.com>
X-X-Sender: stanley@manticore.sh.intel.com
To: Scott Murray <scottm@somanetworks.com>
cc: Stanley Wang <stanley.wang@linux.co.intel.com>,
       Rusty Lynch <rusty@linux.co.intel.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [Pcihpd-discuss] Questions about CPCI Hot Swap driver.
In-Reply-To: <Pine.LNX.4.44.0301291321270.17194-100000@rancor.yyz.somanetworks.com>
Message-ID: <Pine.LNX.4.44.0301300852340.15010-100000@manticore.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003, Scott Murray wrote:

[snip]
> > > 2. I wonder why we could not receive the #ENUM interrupt when we unpluged
> > > the board after disabling the corresponding slot("echo 0 > power")? It 
> > > seems that the cpci_led_on has some mysterious side effect, but I could 
> > > not find any hints in the spec.
> > > Could you help me?
> 
> With most hardware and the current driver, you will still receive an ENUM#
> signal if you flip a card's toggle open after echoing 0 into its power 
> file.  Since the write to the slot's power file triggers unconfiguration 
> of the driver for the attached device and removal of the kernel's PCI 
> representation, pulling the card out then triggers the improper removal 
> detection logic.  I should probably only honor the write of 0 to the 
> power file for devices that are in extracting state via a toggle flip, 
> I'll experiment a bit to see if that model works.
> 
> However, if the peripheral card in question is a ZT5541, all bets are off,
> since in my experiments here it seems to completely shut down when its
> hotswap LED is toggled.  I'm pretty sure this makes it non-compliant with
> PICMG 2.1, but have not decided yet if disabling the attention file is 
> worthwhile.  We could probably live without the attention file to toggle
> the LED, and theoretically disable_slot should not need to call cpci_led_on
> since clearing EXT is supposed to turn on the LED, but I've not seen 
> enough peripheral hardware yet to have a feel for how safe it would be to
> rely on things working correctly on all boards.
The only peripheral board I use is zt5541. And I found the all pci_config_read
return 0xffff after I illuminated the LED.
Thanks for your explanation, it helps me a lot.

Best Regards,
-Stan 
-- 
Opinions expressed are those of the author and do not represent Intel
Corporation


