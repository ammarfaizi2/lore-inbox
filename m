Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUHPUYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUHPUYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267941AbUHPUYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:24:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41881 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267939AbUHPUYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:24:36 -0400
Date: Mon, 16 Aug 2004 22:11:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>, benh@kernel.crashing.org,
       david-b@pacbell.net
Subject: Re: [patch] enums to clear suspend-state confusion
Message-ID: <20040816201059.GF467@openzaurus.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz> <s5hzn4v9ntz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzn4v9ntz.wl@alsa2.suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This patch should clear up some confusion between driver model and
> > drivers people, and also prepares way to add runtime power managment
> > later. Please apply,

> > --- linux-mm/include/linux/pci.h	2004-07-28 22:43:31.000000000 +0200
> > +++ linux-delme/include/linux/pci.h	2004-08-12 13:41:12.000000000 +0200
> > @@ -637,7 +637,7 @@
> >  	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
> >  	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
> >  	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
> > -	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
> > +	int  (*suspend) (struct pci_dev *dev, suspend_state_t reason);	/* Device suspended */
> 
> Does this mean that each driver needs rewrite of suspend callback?


Yes, all drivers will eventually have to be touched. Thats unavoidable.
Fortunately most drivers ignore state, and those that don't are saved
by suspend_state_t being u32 for now... so we
are not breaking them just now.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

