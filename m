Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278293AbRJSDyX>; Thu, 18 Oct 2001 23:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278294AbRJSDyN>; Thu, 18 Oct 2001 23:54:13 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:4103 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S278293AbRJSDyC>;
	Thu, 18 Oct 2001 23:54:02 -0400
Date: Thu, 18 Oct 2001 21:54:30 -0600
From: Val Henson <val@nmt.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Yellowfin bug fix for Symbios cards
Message-ID: <20011018215429.A18593@boardwalk>
In-Reply-To: <20011018210416.D17208@boardwalk> <3BCF9FDD.D6586538@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BCF9FDD.D6586538@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Oct 18, 2001 at 11:37:01PM -0400
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 11:37:01PM -0400, Jeff Garzik wrote:
> Val Henson wrote:
> > Long version: Reading the MAC address from the EEPROM didn't work on
> > the Symbios card, so I turned on the IsGigabit flag to read it
> > correctly.  This also forces full-duplex on, which is wrong.  So I
> > added a flag controlling only the MAC address reading behavior and
> > turned off the IsGigabit flag for Symbios cards.
> 
> Thanks, applied.
> 
> Any idea where the MAC address comes from on the Symbios card?

I believe our bootloader (Smon) initializes the MAC address.

> Standard net driver policy is to read the MAC address from the original
> source at probe time, typically EEPROM but sometimes in a boot PROM,
> firmware console memory, or cardbus CIS.  It is generally preferred to
> -not- read the MAC address from the card registers unless you absolutely
> have to, since card's copy of the MAC address is easily changeable or
> corrupted by rebooting from Windows into Linux or similar things (MacOS
> into Linux).

Hm, good point.  I should figure out why read_eeprom isn't working and
fix that instead.  Maybe the driver should be changed to attempt to
read the MAC from the eeprom and then read from the registers if that
fails, instead of relying on flags.

By the way, the only other OS that runs on our hardware is VxWorks,
and possibly a few of the more obscure RTOS's...

-VAL
