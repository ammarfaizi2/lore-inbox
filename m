Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267618AbTAQRsE>; Fri, 17 Jan 2003 12:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267622AbTAQRsE>; Fri, 17 Jan 2003 12:48:04 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:36360 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id <S267618AbTAQRsC>; Fri, 17 Jan 2003 12:48:02 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200301171756.MAA01256@clem.clem-digital.net>
Subject: Re: 2.5.59 fails compile 3c509.c
In-Reply-To: <wrp3cnryhmv.fsf@hina.wild-wind.fr.eu.org> from Marc Zyngier at "Jan 17, 2003  3:29:12 pm"
To: mzyngier@freesurf.fr
Date: Fri, 17 Jan 2003 12:56:58 -0500 (EST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc Zyngier
  > 
  > Could you please try the following patch ?
  > 
  > Thanks,
  > 
  >         M.
  > 
  > ===== drivers/net/3c509.c 1.30 vs edited =====
  > --- 1.30/drivers/net/3c509.c	Wed Jan 15 11:07:35 2003
  > +++ edited/drivers/net/3c509.c	Fri Jan 17 15:26:30 2003
  > @@ -319,16 +319,6 @@
  >  	dev->watchdog_timeo = TX_TIMEOUT;
  >  	dev->do_ioctl = netdev_ioctl;
  >  
  > -#ifdef CONFIG_PM
  > -	/* register power management */
  > -	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
  > -	if (lp->pmdev) {
  > -		struct pm_dev *p;
  > -		p = lp->pmdev;
  > -		p->data = (struct net_device *)dev;
  > -	}
  > -#endif
  > -
  >  	return 0;
  >  }
  >  
  > @@ -598,6 +588,16 @@
  >  #endif
  >  	lp->mca_slot = mca_slot;
  >  
  > +#ifdef CONFIG_PM
  > +	/* register power management */
  > +	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
  > +	if (lp->pmdev) {
  > +		struct pm_dev *p;
  > +		p = lp->pmdev;
  > +		p->data = (struct net_device *)dev;
  > +	}
  > +#endif
  > +
  >  	return el3_common_init (dev);
  >  }
  >  
  > @@ -1080,12 +1080,14 @@
  >  	free_irq(dev->irq, dev);
  >  	/* Switching back to window 0 disables the IRQ. */
  >  	EL3WINDOW(0);
  > +#ifdef CONFIG_EISA
  >  	if (!lp->edev) {
  >  	    /* But we explicitly zero the IRQ line select anyway. Don't do
  >  	     * it on EISA cards, it prevents the module from getting an
  >  	     * IRQ after unload+reload... */
  >  	    outw(0x0f00, ioaddr + WN0_IRQ);
  >  	}
  > +#endif
  >  
  >  	return 0;
  >  }
  > 
  > -- 
  > Places change, faces change. Life is so very strange.
  > 


Patch fixes the compile problem.
-- 
Pete Clements 
clem@clem.clem-digital.net
