Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWAKO7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWAKO7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWAKO7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:59:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45838 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751645AbWAKO7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:59:09 -0500
Date: Wed, 11 Jan 2006 14:59:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
Subject: Re: [patch 4/5] Add MMC password protection (lock/unlock) support V3
Message-ID: <20060111145901.GC20523@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
	"Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>,
	linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
	Tony Lindgren <tony@atomide.com>,
	"Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
	"Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
References: <43C2E0BD.5040601@indt.org.br> <43C35850.2020104@drzeus.cx> <43C508E1.4080007@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C508E1.4080007@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 09:32:17AM -0400, Anderson Briglia wrote:
> Pierre Ossman wrote:
> > Anderson Briglia wrote:
> > 
> > 
> >>@@ -238,6 +295,11 @@ int mmc_register_card(struct mmc_card *c
> >>			if (ret)
> >>				device_del(&card->dev);
> >>		}
> >>+#ifdef CONFIG_MMC_PASSWORDS
> >>+		ret = device_create_file(&card->dev, &mmc_dev_attr_lockable);
> >>+		if (ret)
> >>+			device_del(&card->dev);
> >>+#endif
> >>	}
> >>	return ret;
> >>}
> >> 
> >>
> > 
> > 
> > It might be wise to also check the command classes here. I don't believe
> > SDIO supports locking.
> 
> In this case, the lockable attribute will show "unlockable", which is
> the expected behavior. The lockable attribute will always be present,
> the card being lockable or not.

"unlockable" seems to be confusing.

"Unlockable" may mean something which is locked but can be unlocked
(unlock-able).  Or it may mean something which can't be locked
(un-lockable).

Maybe returning "unsupported", "locked", "unlocked" etc would be
clearer?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
