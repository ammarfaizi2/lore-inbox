Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278567AbRJSSGk>; Fri, 19 Oct 2001 14:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278569AbRJSSGU>; Fri, 19 Oct 2001 14:06:20 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:25355 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S278567AbRJSSGP>;
	Fri, 19 Oct 2001 14:06:15 -0400
Date: Fri, 19 Oct 2001 12:06:44 -0600
From: Val Henson <val@nmt.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Yellowfin bug fix for Symbios cards
Message-ID: <20011019120644.D21008@boardwalk>
In-Reply-To: <20011018210416.D17208@boardwalk> <3BCF9FDD.D6586538@mandrakesoft.com> <20011018215429.A18593@boardwalk> <3BCFAB6F.15D345B7@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BCFAB6F.15D345B7@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Oct 19, 2001 at 12:26:23AM -0400
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 12:26:23AM -0400, Jeff Garzik wrote:
> Val Henson wrote:
> > Hm, good point.  I should figure out why read_eeprom isn't working and
> > fix that instead.  Maybe the driver should be changed to attempt to
> > read the MAC from the eeprom and then read from the registers if that
> > fails, instead of relying on flags.
> 
> Yeah.  There is at least one other driver (pcnet32?) that does something
> like this...
> 
> probe:
> 	dev->dev_addr[] = read_eeprom();
> 	if (!is_valid_ether_addr(dev->dev_addr))
> 		{ read from card registers }

Well, I asked our hardware engineers, and the reason read the MAC
address from the EEPROM is that we don't have an EEPROM on our
boards.  Instead, the bootloader reads some stuff out of NVRAM and
writes it into the MAC address registers of the ethernet chip.

I think the above scheme is a good way to read the MAC, but I'd want
to test it on an actual Yellowfin gigabit card before submitting it.
Anyone out here willing to test?

-VAL
