Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265737AbTFNUui (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbTFNUui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:50:38 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:13036 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265714AbTFNUuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:50:23 -0400
Date: Sat, 14 Jun 2003 23:03:34 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Add PCI PS/2 controller support [5/13]
Message-ID: <20030614230334.A26210@ucw.cz>
References: <20030614223513.A25948@ucw.cz> <20030614223934.C25997@ucw.cz> <20030614224022.D25997@ucw.cz> <200306142251.51235.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200306142251.51235.oliver@neukum.org>; from oliver@neukum.org on Sat, Jun 14, 2003 at 10:51:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 10:51:51PM +0200, Oliver Neukum wrote:

> > +static int pcips2_write(struct serio *io, unsigned char val)
> > +{
> > +	struct pcips2_data *ps2if = io->driver;
> > +	unsigned int stat;
> > +
> > +	do {
> > +		stat = inb(ps2if->base + PS2_STATUS);
> > +		cpu_relax();
> > +	} while (!(stat & PS2_STAT_TXEMPTY));
> 
> What will happen if somebody unplugs the base station while this
> is running?

I suppose it will wait until you put the base station back. Russell, is
there any notification that the base is getting removed or do all the
loops need checking? I'd consider it not hotpluggable for now.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
