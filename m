Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVCHV4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVCHV4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 16:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVCHV4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 16:56:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26560 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262115AbVCHVzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 16:55:52 -0500
Date: Tue, 8 Mar 2005 22:55:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Re: Fix suspend/resume problems with b44
Message-ID: <20050308215537.GD24188@elf.ucw.cz>
References: <20050308094655.GA16775@elf.ucw.cz> <20050308101739.371968be.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308101739.371968be.davem@davemloft.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > @@ -1934,6 +1936,9 @@
> >  	if (!netif_running(dev))
> >  		return 0;
> >  
> > +	if (request_irq(dev->irq, b44_interrupt, SA_SHIRQ, dev->name, dev))
> > +		printk(KERN_ERR PFX "%s: request_irq failed\n", dev->name);
> > +
> 
> This is a hard error and means that bringup of the chip
> will totally fail.  It definitely deserves something harder
> than a printk(), but unfortunately ->resume() has no way
> to cleanly fail.

Any idea what to do there? I'd say that request_irq is very unlikely
to fail given that it worked okay before suspend...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
