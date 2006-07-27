Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWG0J0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWG0J0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 05:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWG0J0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 05:26:31 -0400
Received: from web37913.mail.mud.yahoo.com ([209.191.124.108]:43864 "HELO
	web37913.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750701AbWG0J0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 05:26:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DbMIwBw5hTNC2XnvktjCFyz/jMrEGRG64EWcv4liInChtL7venptxoDX1Dim6mErQ2dkV8knbwFMwE87skHD3eKQ255DmmOAuGsJs9ItvzufRBoNBdZojf3RHN8JD/m/LrhaivSFkjLW0U1eUsY0iZSV1cdLFrsJrlzpAjpOK9s=  ;
Message-ID: <20060727092630.44005.qmail@web37913.mail.mud.yahoo.com>
Date: Thu, 27 Jul 2006 02:26:29 -0700 (PDT)
From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH 1/2] OMAP: Add keypad driver #3
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: akpm@osdl.org, juha.yrjola@solidboot.com, tony@atomide.com,
       ext-timo.teras@nokia.com, r-woodruff2@ti.com,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       dbrownell@users.sourceforge.net, kjh@hilman.org
In-Reply-To: <20060727085336.GA31563@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> > +
> > +	/* read the keypad status */
> > +	if (cpu_is_omap24xx()) {
> > +		int i;
> > +		for (i = 0; i < omap_kp->rows; i++)
> > +			disable_irq(OMAP_GPIO_IRQ(row_gpios[i]));
> > +	} else
> > +		/* disable keyboard interrupt and schedule for handling */
> > +		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> > +
> > +	if (!cpu_is_omap24xx()) {
> 
> This seems obfuscated.  It would be trivial to combine these two if()
> clauses.

Oops. I will update this in the next patch.

> 
> And a general note about the omap24xx vs !omap24xx differences in
> this
> file - would it make more sense for code readability to have two
> completely separate drivers?

Yeah, I had same thought when I did the integration of omap24xx H4 gpio
based keypad driver from TI OMAP tree to omap-git.  But, if Tony, Juha
and Richard agrees, then I can roll-out new omap2-gpio-keypad driver
patch along with changes into existing omap-keypad.c(will become
omap1-keypad.c then). It will be also easy for me to maintain omap2
keypad driver, as I don't have access to OMAP1 based boards.

> > +
> > +			if (machine_is_omap_osk() || machine_is_omap_h2()
> > +			   	 || machine_is_omap_h3())
> > +				udelay(9);
> > +			else
> > +				udelay(4);
> 
> Wouldn't it be better to pass this via the platform device driver? 
> It
> seems likely that other delays may be required with differing
> hardware.

Yes, we can. I will make that change.

> > +
> > +	if (machine_is_omap_h2() || machine_is_omap_h3() ||
> > +	    machine_is_omap_perseus2()) {
> > +		omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_GPIO_DEBOUNCING);
> > +	}
> 
> Maybe this should be a flag or something?  Why does h2, h3 and
> perseus2
> require this and not others?

Yes we can put the flag there through platform data, but OMAP1
(h2/h3/perseus) owners should comment on that. Kevin/Tony?

Thanx for the detailed review.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
