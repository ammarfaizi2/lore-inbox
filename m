Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270180AbRHGKuj>; Tue, 7 Aug 2001 06:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270182AbRHGKu3>; Tue, 7 Aug 2001 06:50:29 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:46005 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S270180AbRHGKuP>; Tue, 7 Aug 2001 06:50:15 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200108071049.MAA07138@sunrise.pg.gda.pl>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
To: rhw@MemAlpha.CX (Riley Williams)
Date: Tue, 7 Aug 2001 12:49:21 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0108070757460.11974-100000@infradead.org> from "Riley Williams" at Aug 07, 2001 08:04:58 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Riley Williams wrote:"
>  >>>>  Q> alias eth0 ne
>  >>>>  Q> options eth0 io=0x340
>  >>>>  Q> alias eth1 ne
>  >>>>  Q> options eth1 io=0x320
>  >>>>  Q> alias eth2 ne
>  >>>>  Q> options eth2 io=0x2c0
>  >>>>  Q> alias eth3 ne2k-pci
>  >>>>  Q> alias eth4 ne2k-pci
>  >>>>  Q> alias eth5 tulip
> 
>  >> However, if the cards are controlled by different drivers, you can
>  >> influence the order they are detected in by your choice of entries in
>  >> modules.conf - in the example above, the ISA cards are always eth0,
> 
>  >> eth1 and eth2, the NE2k-pci cards are always eth3 and eth4, and the
>  >> tulip card is always eth5, simply because that's what the said file
>  >> says.
> 
>  > Not always. You are wrong here, I'm afraid:
> 
>  > Lets assume that eth0-eth3 are not initialized at boot time and
>  > your init scripts attempt to initialize eth4 ...
> 
> Then I get an entry for eth4 in the `ifconfig` output, with NO entries
> for `eth0` through `eth3`, exactly as expected.

Did you ever try ? I think no. I've got the problem a few times while
(re)configuring multi-ethernet machines.

ne2k-pci is the first module loaded then and it finds two interfaces.
As there is no interfaces registered at the moment, they are named eth0 and
eth1 (sic!)

The interface names from modules.conf mean nothing here, they are ignored.

I see tho ways to get the proper intyerface names:
1. Force loading all modules in the appropriate sequence (ne before
   ne2k-pci) either manually or via pre-install command
2. Renaming interfaces after they are initialized (yes, interface names can
   be changed, but it is ugly)

> Note that the `ifconfig` command refers to the interfaces by name, and
> it's the settings in modules.conf that decide what type of interface
> that name refers to. That mapping can't be changed by any interface
> configuration or initialisation command, and the names used are those
> as given.

ifconfig does not assign interface names. The kernel driver (module) does.
And the driver has no option passed (even I thing it is impossiblke to pass
any) to define new interface naming scheme.

>  > To avoid such problems one probably should add a lot of
>  > pre-install parameters in modules.conf.
> 
> What problems?

Described above.

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
